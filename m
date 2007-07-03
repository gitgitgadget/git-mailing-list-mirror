From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-fetch will leave a ref pointing to a tag
Date: Tue, 3 Jul 2007 13:01:49 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707031257590.4071@racer.site>
References: <Pine.LNX.4.64.0707022207420.4071@racer.site>
 <20070703032315.7279.qmail@science.horizon.com> <20070703041859.GB4007@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux@horizon.com, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 03 14:02:06 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5h54-0006jc-2h
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 14:02:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757158AbXGCMB4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 08:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757144AbXGCMB4
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 08:01:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:37687 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755120AbXGCMB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 08:01:56 -0400
Received: (qmail invoked by alias); 03 Jul 2007 12:01:54 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp056) with SMTP; 03 Jul 2007 14:01:54 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/EBppmuV/Esk8/N0gTX8cTyNsV1ksEbSc1UH45eK
	PFva8AGwIkYyEs
X-X-Sender: gene099@racer.site
In-Reply-To: <20070703041859.GB4007@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51479>

Hi,

On Tue, 3 Jul 2007, Jeff King wrote:

> On Mon, Jul 02, 2007 at 11:23:15PM -0400, linux@horizon.com wrote:
> 
> > And until git-merge-ff is available, what's the recommended way to
> > "advance master to tag <foo>, but only if that wouldn't lose anything?"
> 
> You can ask "do I have anything that foo doesn't?":
> 
>   test "`git-rev-list foo.. | wc -l`" -gt 0

If it is only the test, you can do that by

	test $(git merge-base foo bar) = $(git rev-parse foo)

(which tests if foo is a stricth ancestor of bar). Although in your 
(linux@horizon.com's) place I would really look at "git log foo.." myself, 
as peff almost suggested.

For if you (linux@horizon.com) _have_ changes, you want to know which 
changes they are, right?

Of course, it seems to me that what you (linux@horizon.com; do you really 
have no proper name?) _really_ wanted to do is "git rebase v2.6.22-rc7".

Ciao,
Dscho
