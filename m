From: Jeff King <peff@peff.net>
Subject: Re: touching a file causes it to be listed using git diff-files
Date: Thu, 14 Jan 2010 00:26:58 -0500
Message-ID: <20100114052658.GA13973@coredump.intra.peff.net>
References: <p0624080ec7740ddc4caf@[63.138.152.134]>
 <20100114030204.GB1878@coredump.intra.peff.net>
 <p06240810c774498d4a2e@[63.138.152.134]>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Stephen Bannasch <stephen.bannasch@deanbrook.org>
X-From: git-owner@vger.kernel.org Thu Jan 14 06:27:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVIEe-00049h-Ji
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 06:27:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754824Ab0ANF1D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 00:27:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753318Ab0ANF1B
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 00:27:01 -0500
Received: from peff.net ([208.65.91.99]:36280 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752335Ab0ANF1B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 00:27:01 -0500
Received: (qmail 3987 invoked by uid 107); 14 Jan 2010 05:31:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 14 Jan 2010 00:31:50 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jan 2010 00:26:58 -0500
Content-Disposition: inline
In-Reply-To: <p06240810c774498d4a2e@[63.138.152.134]>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136929>

On Thu, Jan 14, 2010 at 12:01:46AM -0500, Stephen Bannasch wrote:

> Do you know if there is a plumbing command that will stat all of the
> files without listing the files that actually do need updating?
> 
> In the case where file1 has been only touched but file2 has been
> changed (and both are tracked) I'd like to stat both filesand then run
> diff-files as plumbing to see that only file2 has been changed in the
> working directory.

Judging from the scripts in git itself, I think the recommended practice
is to simply "git update-index --refresh -q >/dev/null".

> 'git diff' also stats the files but strangely 'git diff --quiet' doesn't ???

I can't reproduce that behavior here on the current "master". Old
versions of git used to not do the index refresh for "diff". What
version of git are you using?

-Peff
