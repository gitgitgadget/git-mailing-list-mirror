From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach 'git apply' to look at $GIT_DIR/config
Date: Sun, 18 Feb 2007 01:53:52 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702180151060.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vlkiwsepm.fsf@assigned-by-dhcp.cox.net> <7v8xewsd2j.fsf@assigned-by-dhcp.cox.net>
 <20070217232603.GB30839@coredump.intra.peff.net>
 <Pine.LNX.4.63.0702180105000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v64a0qpa8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 18 01:54:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIaJf-0008PW-2c
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 01:54:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965508AbXBRAxy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 19:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965510AbXBRAxy
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 19:53:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:39405 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965508AbXBRAxx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 19:53:53 -0500
Received: (qmail invoked by alias); 18 Feb 2007 00:53:52 -0000
X-Provags-ID: V01U2FsdGVkX1/E8bNm/1fESUN7gRK4CTOBxPveMZHRskmheyj3fA
	PRUg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v64a0qpa8.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40042>

Hi,

On Sat, 17 Feb 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > ... However, I suspect you have to 'cd' back to prefix, or else the 
> > patch gets applied in the repo root, right? (Disclaimer: I did not 
> > read the patch.)
> 
> Actually, not cd-ing up was a bug, since git diff is always relative to 
> root.  The behaviour to apply the same file was inconsistent between 
> with --index and without as far as I can tell.

For the same reason that I like git-merge-file, and git-diff2, namely to 
have a _sane_ tool with a lot of options, which works the same everywhere 
I have git, I also like git-apply.

And I use git-apply to apply patches way more often than "patch" these 
days. And I _think_ that it is a feature that it does not cd-up before 
trying to apply the stuff. In git.git, I cannot think of a reasonable use 
case for applying something not relative-to-root, but I had that use case 
in some other (git-tracked) project.

So my vote is to leave the cwd where it is in git-apply.

Ciao,
Dscho
