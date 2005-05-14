From: David Greaves <david@dgreaves.com>
Subject: Re: [PATCH] Ignore file filter
Date: Sat, 14 May 2005 16:13:08 +0100
Message-ID: <42861584.6020601@dgreaves.com>
References: <4283CAF8.3050304@dgreaves.com> <20050513231229.GI32232@pasky.ji.cz> <4285B6A8.4080309@dgreaves.com> <7vy8ai2nb6.fsf@assigned-by-dhcp.cox.net> <20050514142421.GG3905@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 14 17:13:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWyKW-0003fd-Ku
	for gcvg-git@gmane.org; Sat, 14 May 2005 17:13:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262781AbVENPN2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 May 2005 11:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262783AbVENPN2
	(ORCPT <rfc822;git-outgoing>); Sat, 14 May 2005 11:13:28 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:27607 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S262781AbVENPNU (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 May 2005 11:13:20 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id DE33AE6DAD; Sat, 14 May 2005 16:11:46 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 24385-02; Sat, 14 May 2005 16:11:46 +0100 (BST)
Received: from oak.dgreaves.com (unknown [217.135.156.197])
	by mail.ukfsn.org (Postfix) with ESMTP
	id ECF8BE6D9E; Sat, 14 May 2005 16:11:45 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DWyKC-0008CT-8k; Sat, 14 May 2005 16:13:08 +0100
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050514142421.GG3905@pasky.ji.cz>
X-Enigmail-Version: 0.91.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis wrote:

>Dear diary, on Sat, May 14, 2005 at 11:01:49AM CEST, I got a letter
>where Junio C Hamano <junkio@cox.net> told me that...
>  
>
>>>>>>>"DG" == David Greaves <david@dgreaves.com> writes:
>>>>>>>              
>>>>>>>
>>>>>if [[ $file =~ $patt ]]; then
>>>>>          
>>>>>
>>>>I'm sorry but this is really nothing my bash-2.05.0(1)-release supports.
>>>>        
>>>>
>>DG> OK
>>DG> I don't know how to do that.
>>
>>Is that regexp or shell glob?  If regexp, expr is your friend,
>>like this:
>>
>>    if expr "$file" : "$patt" >/dev/null; then
>>    
>>
>
>Oh, this looks nice. I didn't know expr can do that. :-)
>
>Still, I'd prefer the old-fashioned globs as primary matching mechanism.
>  
>
OK
I was wondering about supporting _both_ globs and re's
right now my ignore file has a # to precede comment lines
maybe re: precedes regexp lines and unadorned lines are globs.

However the re's provided by regex(7) are too weedy to be worth
bothering with.
If however, there is a serious plan to go to perl, it may be worth
providing for this now in the ignore syntax.

Additionally this causes problems with sharing the same exclude file as
used by git.
However...
I really think git's exclude file capability and cogito's are different.
Cogito is aiming to provide full-blown SCM capabilities - git isn't

I am also concerned that a centralised ignore file is not flexible enough.
Certainly limiting if we support globs only.
It may be that you want different rules in different trees - someone on
lkml mentioned that excludes vary in different parts of the source.
Eg .s files may be generally ignored - but not in the asm parts of the tree.

Also... you haven't mentioned perl for a while - can you give us an update?
I personally think we're making life needlessly unpleasant by sticking
with shell.


David

-- 

