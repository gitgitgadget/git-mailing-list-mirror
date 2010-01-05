From: Jeff King <peff@peff.net>
Subject: Re: How to exclude files from "git diff"
Date: Tue, 5 Jan 2010 01:45:09 -0500
Message-ID: <20100105064509.GC19025@coredump.intra.peff.net>
References: <6dc9ffc80912180909q2e9cbe30r7c802a2152c5954@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "H.J. Lu" <hjl.tools@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 05 07:45:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NS3AP-0004KD-O6
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 07:45:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754077Ab0AEGpO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 01:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752382Ab0AEGpO
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 01:45:14 -0500
Received: from peff.net ([208.65.91.99]:42126 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750763Ab0AEGpN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 01:45:13 -0500
Received: (qmail 28320 invoked by uid 107); 5 Jan 2010 06:49:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 05 Jan 2010 01:49:57 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Jan 2010 01:45:09 -0500
Content-Disposition: inline
In-Reply-To: <6dc9ffc80912180909q2e9cbe30r7c802a2152c5954@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136170>

On Fri, Dec 18, 2009 at 09:09:15AM -0800, H.J. Lu wrote:

> I have some bookkeeping files in my git repository.  How do I
> exclude them from "git diff"? Does "git diff" support
> 
> # git diff --exclude="foo.*.bar*"

No, I don't believe there is a way to do that. You would have to do
something like:

  git diff $(git ls-files | grep -v whatever)

The usual concept of "exclusion" for git is not to track files at all
via the .gitignore mechanism.  Are these files that have content you
really _want_ in the repository, but you just don't want to see them
when doing some diffs? Or are they files that could not be in the
repository at all?

-Peff
