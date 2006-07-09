From: fork0@t-online.de (Alex Riesen)
Subject: Re: RFH: refactor read-tree
Date: Mon, 10 Jul 2006 00:17:53 +0200
Message-ID: <20060709221753.GB6966@steel.home>
References: <Pine.LNX.4.63.0607090015250.29667@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0607082011060.5623@g5.osdl.org> <20060709124324.GE5919@steel.home> <Pine.LNX.4.63.0607091630110.29667@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0607090827430.5623@g5.osdl.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 10 00:18:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzhbS-00042d-TA
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 00:18:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161189AbWGIWSM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Jul 2006 18:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161191AbWGIWSM
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Jul 2006 18:18:12 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:60324 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1161189AbWGIWSL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jul 2006 18:18:11 -0400
Received: from fwd33.aul.t-online.de 
	by mailout08.sul.t-online.com with smtp 
	id 1FzhbJ-0003IR-01; Mon, 10 Jul 2006 00:18:05 +0200
Received: from tigra.home (T5fF+0ZHgeWPFiYMGfaWkpUhHOJXulhhAI+OIMtG+5COO5NCLR21UK@[84.160.121.31]) by fwd33.sul.t-online.de
	with esmtp id 1Fzhb9-1zCjb60; Mon, 10 Jul 2006 00:17:55 +0200
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 77DCC277AF;
	Mon, 10 Jul 2006 00:17:54 +0200 (CEST)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1Fzhb7-0003sJ-Pt; Mon, 10 Jul 2006 00:17:53 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607090827430.5623@g5.osdl.org>
User-Agent: Mutt/1.5.6i
X-ID: T5fF+0ZHgeWPFiYMGfaWkpUhHOJXulhhAI+OIMtG+5COO5NCLR21UK
X-TOI-MSGID: 3f00fa25-399c-4249-a024-1e7d35e4c7b6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds, Sun, Jul 09, 2006 17:30:26 +0200:
> > > > The basic idea is that "branch1" should be your current branch, and it 
> > > > obviously is also expected to match (more or less) the current index. So 
> > > > you can do a merge by
> > > > 
> > > >  - reading in "branch1" into the index:
> > > > 
> > > > 	GIT_INDEX_FILE=.git/tmp-index git-read-tree -m branch1
> > > 
> > > what is "-m" here for?
> > 
> > It means that git-read-tree tries to merge the current index with branch1.
> 
> Well, the current index always "merges" by just taking the timestamps from 
> it. The actual _content_ doesn't matter for the single-tree case.

But the name suggests it's a temporary index, which would not have
anything in it and even the .git/tmp-index is not supposed to exist.
So I'd actually understand this as creating an index from the tree-ish
branch1, without merging anything. And continue wondering what that -m
is for...
