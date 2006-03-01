From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-svn and huge data and modifying the git-svn-HEAD branch
 directly
Date: Wed, 1 Mar 2006 22:07:17 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0603012202250.9893@wbgn013.biozentrum.uni-wuerzburg.de>
References: <62502.84.163.87.135.1141063190.squirrel@mail.geht-ab-wie-schnitzel.de>
 <20060227184641.GA21684@hand.yhbt.net> <20060227185557.GA32142@delft.aura.cs.cmu.edu>
 <20060227192422.GB9518@hand.yhbt.net> <46a038f90602271625y6c7e9072u372b8dd3662e272c@mail.gmail.com>
 <Pine.LNX.4.64.0602271634410.22647@g5.osdl.org> <20060301065138.GC21684@hand.yhbt.net>
 <44056BF1.6000109@op5.se> <Pine.LNX.4.64.0603010745320.22647@g5.osdl.org>
 <4405C6BE.2000706@op5.se> <Pine.LNX.4.64.0603010821590.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, Eric Wong <normalperson@yhbt.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 01 22:08:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEYXe-0008UN-PJ
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 22:07:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbWCAVHX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 16:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751907AbWCAVHX
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 16:07:23 -0500
Received: from mail.gmx.de ([213.165.64.20]:53900 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751215AbWCAVHX (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Mar 2006 16:07:23 -0500
Received: (qmail invoked by alias); 01 Mar 2006 21:07:22 -0000
Received: from lxweb002.wuerzburg.citynet.de (EHLO localhost) [81.209.129.202]
  by mail.gmx.net (mp034) with SMTP; 01 Mar 2006 22:07:22 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603010821590.22647@g5.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17012>

Hi,

On Wed, 1 Mar 2006, Linus Torvalds wrote:

> On Wed, 1 Mar 2006, Andreas Ericsson wrote:
> > 
> > Personally I'm all for namespace separation. I'm assuming the script 
> > has the tracker-branch hardcoded anyway, so I don't really understand 
> > why it would be necessary to keep other refs in a separate directory 
> > and, if it *is* necessary, why that subdirectory can't be 
> > .git/refs/heads/svn.
> > 
> > Eric mentioned earlier that the tracking-branch can't be committed to 
> > (ever), so the user convenience for searching other directories should 
> > be nearly non-existant.
> 
> The thing about it being .git/refs/heads/svn/xyzzy is that then you can 
> do
> 
> 	git checkout svn/xyzzy
> 
> _not_ a branch and you must _not_ commit to it.
> 
> It's much more like a tag: it's a pointer to the last point of an 
> svn-import.
> 
> So I think it should either _be_ a tag (although Dscho worries about some 
> broken porcelain being confused by tags changing) or it should be in a 
> namespace all it's own. Not under .git/refs/heads/ at any point, because 
> it is _not_ a head of development.

I almost missed that you reference me in the email (often, I just delete 
the email if the Subject is of no interest to me).

I did not worry about broken porcelain. I saw broken porcelain. But that 
is more a broken concept than broken porcelain: in a distributed 
environment, there is no way to have a reliable tag. Think about it: 
whenever you have two different versions of a tag, you cannot know which 
one is the correct one.

But my worries do not matter at all for local tags.

Conceptually, however, the last point of a svnimport should *never* be a 
tag, but *always* a head.

Ciao,
Dscho
