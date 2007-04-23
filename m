From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: GIT vs Other: Need argument
Date: Mon, 23 Apr 2007 19:55:42 -0400
Message-ID: <655BF52F-9CD9-4C79-A6D0-5A3BDE9BE58F@silverinsanity.com>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com> <20070417104520.GB4946@moonlight.home> <8b65902a0704170841q64fe0828mdefe78963394a616@mail.gmail.com> <200704171818.28256.andyparkins@gmail.com> <20070417173007.GV2229@spearce.org> <462521C7.2050103@softax.com.pl> <Pine.LNX.4.64.0704181130150.12094@racer.site> <alpine.LFD.0.98.0704180851060.2828@woody.linux-foundation.org> <Pine.LNX.4.64.0704191118050.8822@racer.site> <alpine.LFD.0.98.0704190940330.9964@woody.linux-foundation.org> <4627ABBB.8060709@softax.com.pl> <alpine.LFD.0.98.0704191341370.9964@woody.linux-foundation.org> <877is29b1l.wl%cworth@cworth.org> <7vps5ud91x.fsf@assigned-by-dhcp.cox.net> <87vefm7l6g.wl%cworth@cworth.org> <alpine.LFD.0.98.0704231609440.9964@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Carl Worth <cworth@cworth.org>, Junio C Hamano <junkio@cox.net>,
	Marcin Kasperski <Marcin.Kasperski@softax.com.pl>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Apr 24 01:56:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg8OE-0004Pn-Di
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 01:56:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030682AbXDWXzs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 19:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030767AbXDWXzs
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 19:55:48 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:56869 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030342AbXDWXzr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 19:55:47 -0400
Received: from [192.168.1.6] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id D0BDB1FFC003;
	Mon, 23 Apr 2007 23:55:46 +0000 (UTC)
In-Reply-To: <alpine.LFD.0.98.0704231609440.9964@woody.linux-foundation.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45383>


On Apr 23, 2007, at 7:24 PM, Linus Torvalds wrote:

> So I don't really see the problem with just saying:
>
>  - the remote *has* a default branch. That's the one you get by  
> default
>    with "git clone".
>
>  - if you want to track another branch, you should just tell git  
> that you
>    want to track it, and switch to that instead:
>
> 	git branch --track mybranch origin/otherbranch
> 	git checkout mybranch
>
>    and be happy with it.
>
> Yes, it's two extra commands, but they aren't *that* hard to explain,
> after all. You really can basically explain each stage both very  
> simply
> and naturally with just

It's even better than that.  Just use "git checkout --track -b  
mybranch origin/otherbranch".  Slightly cumbersome, but is only one  
command.  And easily explained: "Checkout a tracking branch named  
mybranch for origin/otherbranch".

And the --track can be removed by using branch.autosetupmerge for  
people who always want it.

Actually the man page appears to be minorly incorrect.  It has "[-b  
[ --track | --no-track ]", which doesn't work.  Git gives me "git  
checkout: updating paths is incompatible with switching branches/ 
forcing".  I think it's interpreting --track as the new branch name.   
I'll send a patch reversing the order of the arguments in the man page.

~~ Brian
