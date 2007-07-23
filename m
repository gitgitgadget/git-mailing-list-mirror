From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What is a reasonable mixed workflow for git/git-cvsserver?
Date: Mon, 23 Jul 2007 11:16:52 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707231106590.14781@racer.site>
References: <E8B0B250-A428-4CDC-A4D2-FFCF45953076@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Jul 23 12:17:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICuyX-0004qL-Mk
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 12:17:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759907AbXGWKRI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 06:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759799AbXGWKRI
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 06:17:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:50077 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759392AbXGWKRG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 06:17:06 -0400
Received: (qmail invoked by alias); 23 Jul 2007 10:17:04 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp026) with SMTP; 23 Jul 2007 12:17:04 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Kn0o9fz4K93MCU+fJSHPpV9MKpBlTWOXucHffCm
	S9SFC0uvoB7kSv
X-X-Sender: gene099@racer.site
In-Reply-To: <E8B0B250-A428-4CDC-A4D2-FFCF45953076@zib.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53421>

Hi,

On Mon, 23 Jul 2007, Steffen Prohaska wrote:

> What's a reasonable workflow when some people use git and other people 
> use git-cvsserver simultaneously?

This is what we did here:

We cvsimported the whole stuff (but we did not have your problems, since 
there was only one branch).  Then we initialised a shared repository with 
that branch, turned on git-cvsserver (and found a few bugs, but that was 
long ago, and AFAIR all our issues were fixed) and went to work.

There were a few committing via cvs, and a few others committing via git.  
One person only tracked via cvs, not contributing code, just reviewing 
and testing.

We did not have the need to impose certain restrictions, such as git-shell 
(to prevent invoking other programs), or hooks refusing a push that 
touches parts the person pushing has no business changing.

But we had the option to go there, if needed.  So far, all went fine.  And 
I'm convinced that it is partly because of the trust model.  After all, I 
still have my local repository.  And that I can trust at all times.

So if a poisonous person (instead of thrashing the mailing list with long 
mails) would have decided to corrupt the repo, we would have realised that 
pretty quickly, repaired the damage without much effort, and kicked out 
that person.

Needless to say that all our devs converted to Git.  And I'm happy to say 
that they're all happy with it.

Ciao,
Dscho
