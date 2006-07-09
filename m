From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: RFH: refactor read-tree
Date: Sun, 9 Jul 2006 16:55:04 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607091650030.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0607090015250.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0607082011060.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 09 16:55:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fzagq-0004od-J1
	for gcvg-git@gmane.org; Sun, 09 Jul 2006 16:55:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932480AbWGIOzI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Jul 2006 10:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbWGIOzI
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Jul 2006 10:55:08 -0400
Received: from mail.gmx.de ([213.165.64.21]:62368 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932480AbWGIOzG (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jul 2006 10:55:06 -0400
Received: (qmail invoked by alias); 09 Jul 2006 14:55:05 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp041) with SMTP; 09 Jul 2006 16:55:05 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607082011060.5623@g5.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23555>

Hi,

On Sat, 8 Jul 2006, Linus Torvalds wrote:

> On Sun, 9 Jul 2006, Johannes Schindelin wrote:
> > 
> > I also played a little with git-merge-tree, because it seems so much 
> > simpler and easier to refactor. But there is a problem: Either I call it 
> > the wrong way, or it does not yet work correctly: I tried
> > 
> > 	git-merge-tree $(git-merge-base branch1 branch2) branch1 branch2
> > 
> > with what is in 'next'. But it only showed the _new_ files, not the 
> > modified ones.
> 
> What git-merge-tree does is to show the _difference_ to "branch1".

I see my problem: branch1 is not the "upstream" branch, but my own. Tsk. 
Too easy.

Now, if only merge-tree knew about renames. *sigh*.

> And yes, I agree 100% that "git-read-tree" has become an unholy mess. I 
> looked at it, and I think it's unfixable. I considered re-writing it from 
> scratch, at least for some specific cases, but I couldn't bring myself to 
> do it.

Well, I think that at least the unpack_tree() thing should be relatively 
easy to extract. And the rest _should_ be relatively easy to clean up, 
provided we introduce a read_tree_options struct, which gets passed around 
a la "this" in Java/C++.

Ciao,
Dscho
