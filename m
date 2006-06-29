From: fork0@t-online.de (Alex Riesen)
Subject: Re: Improved three-way blob merging code
Date: Fri, 30 Jun 2006 01:07:22 +0200
Message-ID: <20060629230722.GA7216@steel.home>
References: <Pine.LNX.4.64.0606282157210.12404@g5.osdl.org> <81b0412b0606290043s15e19b9fl853627e815f009ff@mail.gmail.com> <Pine.LNX.4.64.0606291028010.12404@g5.osdl.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>,
	Davide Libenzi <davidel@xmailserver.org>
X-From: git-owner@vger.kernel.org Fri Jun 30 01:08:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw5cd-0007Qd-MN
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 01:08:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933088AbWF2XIT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 19:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933087AbWF2XIT
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 19:08:19 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:61889 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id S933089AbWF2XIS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 19:08:18 -0400
Received: from fwd28.aul.t-online.de 
	by mailout01.sul.t-online.com with smtp 
	id 1Fw5bZ-0004ss-00; Fri, 30 Jun 2006 01:07:25 +0200
Received: from tigra.home (rSULAGZdgejm3+yS6XyZ0MYOr1i188J1Rx1vnqLM+ZOc53mU3h1qYo@[84.160.88.232]) by fwd28.sul.t-online.de
	with esmtp id 1Fw5bX-2DlVA00; Fri, 30 Jun 2006 01:07:23 +0200
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 3A1E0277B5;
	Fri, 30 Jun 2006 01:07:23 +0200 (CEST)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1Fw5bW-00034y-SQ; Fri, 30 Jun 2006 01:07:22 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606291028010.12404@g5.osdl.org>
User-Agent: Mutt/1.5.6i
X-ID: rSULAGZdgejm3+yS6XyZ0MYOr1i188J1Rx1vnqLM+ZOc53mU3h1qYo
X-TOI-MSGID: 107b6925-861f-4c27-8dcd-f70e96886c4f
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22926>

Linus Torvalds, Thu, Jun 29, 2006 19:45:20 +0200:
> IOW, what I'd like git-merge-tree to do is to be able to at a minimum say:
> 
>  - will a merge succeed cleanly, and if not, show me where the problem 
>    spots are.
>  - what will the result of the merge look like.
> 
> because that's actually what a downstream developer wants to do. He'd just 
> do
> 
> 	git fetch linus
> 	git show-changes linus..my-branch
> 
> which would basically be the preparatory thing for sending me an email 
> saying "please merge 'my-branch', and you'll see this".

it's a "git show-merge linus..my-branch" :)

> Now, obviously, I think that there's a _lot_ of overlap between doing this 
> and actually doing the merge itself, so hopefully the things I do will at 
> least have some things in common and perhaps help you do the proper 
> recursive merger.

I certanly hope so: only the last pass of the recursive merge seem to
really need the index. It's use in all the previuos recursions looks
more like abuse.
