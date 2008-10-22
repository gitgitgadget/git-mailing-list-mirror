From: Jeff King <peff@peff.net>
Subject: Re: git performance
Date: Wed, 22 Oct 2008 16:36:25 -0400
Message-ID: <20081022203624.GA4585@coredump.intra.peff.net>
References: <000801c93483$2fdad340$8f9079c0$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Edward Ned Harvey <git@nedharvey.com>
X-From: git-owner@vger.kernel.org Wed Oct 22 22:37:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KskSa-00024S-Iz
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 22:37:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753323AbYJVUg1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 16:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753143AbYJVUg1
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 16:36:27 -0400
Received: from peff.net ([208.65.91.99]:3807 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752144AbYJVUg1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 16:36:27 -0400
Received: (qmail 4291 invoked by uid 111); 22 Oct 2008 20:36:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 22 Oct 2008 16:36:26 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Oct 2008 16:36:25 -0400
Content-Disposition: inline
In-Reply-To: <000801c93483$2fdad340$8f9079c0$@com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98906>

On Wed, Oct 22, 2008 at 04:17:16PM -0400, Edward Ned Harvey wrote:

> So - I didn't see anything out there saying "git is fast because it
> uses inotify" or anything like that.  Perhaps git would not help me at
> all?  Because git still needs to stat all the files in the tree?

Yes, it does stat all the files. How many files are you talking about,
and what platform?  From a warm cache on Linux, the 23,000 files kernel
repo takes about a tenth of a second to stat all files for me (and this
on a several year-old machine). And of course many operations don't
require stat'ing at all (like looking at logs, or diffs that don't
involve the working tree).

-Peff
