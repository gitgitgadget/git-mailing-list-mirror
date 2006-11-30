X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git and bzr
Date: Thu, 30 Nov 2006 11:19:23 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611301111310.30004@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45357CC3.4040507@utoronto.ca> <20061026101038.GA13310@coredump.intra.peff.net>
 <877iyne4dm.fsf@alplog.fr> <Pine.LNX.4.64.0610260753090.3962@g5.osdl.org>
 <456B7C6A.80104@webdrake.net> <845b6e870611280410j58bdcd99nc05d0f67489293e4@mail.gmail.com>
 <ekhaeg$etk$1@sea.gmane.org> <Pine.LNX.4.63.0611281433270.30004@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0611280754050.30076@woody.osdl.org> <456C7592.6020700@ableton.com>
 <ekhtnt$rkk$1@sea.gmane.org> <456C9DFF.1040407@onlinehome.de>
 <456CA981.4010808@onlinehome.de> <Pine.LNX.4.64.0611281346490.4244@woody.osdl.org>
 <456CB197.2030201@onlinehome.de> <Pine.LNX.4.64.0611281413310.4244@woody.osdl.org>
 <Pine.LNX.4.63.0611291149440.30004@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0611290922410.3513@woody.osdl.org> <456DD76C.4010902@gmx.net>
 <Pine.LNX.4.64.0611291235590.3513@woody.osdl.org> <87bqmpvlxf.wl%cworth@cworth.org>
 <456E8147.9070304@gmx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 30 Nov 2006 10:19:37 +0000 (UTC)
Cc: Carl Worth <cworth@cworth.org>, git@vger.kernel.org,
	bazaar-ng@lists.canonical.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <456E8147.9070304@gmx.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32717>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gpj0s-0003KF-6o for gcvg-git@gmane.org; Thu, 30 Nov
 2006 11:19:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933843AbWK3KT1 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 05:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934363AbWK3KT1
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 05:19:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:33477 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S933843AbWK3KT0 (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 05:19:26 -0500
Received: (qmail invoked by alias); 30 Nov 2006 10:19:24 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp042) with SMTP; 30 Nov 2006 11:19:24 +0100
To: Raimund Bauer <ray007@gmx.net>
Sender: git-owner@vger.kernel.org

Hi,

On Thu, 30 Nov 2006, Raimund Bauer wrote:

> * Carl Worth wrote, On 30.11.2006 01:05:
> > Let's help people do exactly that by making the behavior of "git
> > commit -a" be the default for "git commit".
> >   
> Maybe we could do that _only_ if the index matches HEAD, and otherwise keep
> current behavior?
> So people who don't care about the index won't get tripped up, and when you do
> have a dirty index, you get told about it?

So many people spoke for it, it's time I crash the wedding.

From a usability viewpoint, it is a horrible convention. The user has to 
remember too much of the side effects to handle the commit operation. 
The function of the program would no longer be dependent on the command 
line arguments and your config, but _also_ on something as volatile as 
the index.

You would literally end up asking "did I change the index?" _everytime_ 
before you commit.

And remember, even a simple "git add" changes the index! (Why it does is 
brutally clear once you grasp the concept of the staging area.)

Worse, doing a "git commit --amend" should _not_ automatically add "-a" 
_even_ if the index matches the HEAD, since it is quite possible that you 
had a typo in the message you want to fix up. And quite possibly other 
options would not want that either.

But here's an idea: tell the user that she has to tell git-commit which 
files she wants committed. Yes! That's it. Just tell it the friggin' 
files. And if you are a lazy bum, and want to commit _all_ modified 
files, git has a nice shortcut for ya: "-a".

Ciao,
Dscho
