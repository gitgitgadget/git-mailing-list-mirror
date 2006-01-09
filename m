From: lamikr <lamikr@cc.jyu.fi>
Subject: Re: undoing changes with git-checkout -f
Date: Tue, 10 Jan 2006 00:52:39 +0200
Message-ID: <43C2E937.4060508@cc.jyu.fi>
References: <43C2D2C4.2010904@cc.jyu.fi> <7vmzi5hy69.fsf@assigned-by-dhcp.cox.net>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 09 23:47:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ew5nP-0000gH-J2
	for gcvg-git@gmane.org; Mon, 09 Jan 2006 23:47:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751598AbWAIWrU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jan 2006 17:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751602AbWAIWrU
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jan 2006 17:47:20 -0500
Received: from posti6.jyu.fi ([130.234.4.43]:28387 "EHLO posti6.jyu.fi")
	by vger.kernel.org with ESMTP id S1751598AbWAIWrT (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Jan 2006 17:47:19 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by posti6.jyu.fi (8.13.4/8.13.4) with ESMTP id k09MlBNt013760;
	Tue, 10 Jan 2006 00:47:11 +0200
Received: from aragorn.kortex.jyu.fi (aragorn.kortex.jyu.fi [130.234.182.44])
	by posti6.jyu.fi (8.13.4/8.13.4) with ESMTP id k09Ml1qG013740;
	Tue, 10 Jan 2006 00:47:02 +0200
Received: from [127.0.0.1] (aragorn.kortex.jyu.fi [127.0.0.1])
	by aragorn.kortex.jyu.fi (Postfix) with ESMTP id 2A6CD468169;
	Tue, 10 Jan 2006 00:52:40 +0200 (EET)
User-Agent: Mozilla Thunderbird 1.0.6-7.2.20060mdk (X11/20050322)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzi5hy69.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: amavisd-new at cc.jyu.fi
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14380>

Junio C Hamano wrote:

>lamikr <lamikr@cc.jyu.fi> writes:
>
>  
>
>>1) I clone git repo by using command
>>
>>    git-clone rsync://source.mvista.com/git/linux-omap-2.6.git
>>linux-omap-2.6
>>    
>>
>
>Please do not use rsync:// transport if possible (mvista might
>only pubilsh via rsync:// and not git://, so it may not be your fault).
>  
>
Ok, I will send a message to maintainer. I was just pasting the address
from their instructions. (They were using cogito on top of git, but I
want to learn to use pure git commands first)

>Nothing.  After the second step, git does not know anything
>about 1.txt; if it is a part of something you wanted to
>eventually commit, or it is some notes you took while perusing
>the source and is precious even when you switch branches (even
>though you would not commit it as part of the project) , so it
>does not touch it.  After running "make", "checkout -f" does not
>do "make clean" for you to remove *.o files either, for exactly
>the same reason.
>
>"git status" would tell you the file is "untracked".
>
>If you did something like this:
>
>	$ edit 1.txt
>        $ git add 1.txt
>        $ git reset --hard
>
>"git reset --hard" would remove it, while "git checkout -f"
>would leave the file behind.
>  
>
Ok, so this describes the power difference between "checkout -f"
and "git-reset --hard" pretty well.

>BTW, please do not set Reply-To: (or Mail-Followup-To: for that
>matter) to the list.  When I (or somebody else) want to reply
>to you, especially in private, your Reply-To: header forces me
>to manually rewrite the To: header MUA prepares for me.
>
>I know why you do it --- you are on the list and otherwise you
>would get duplicate messages, one from me directly and another
>from the list.  I've seen other people do it, but IMNSHO it is a
>bad practice.  Filter them on your end, and do not put extra
>burden to others, please.  The only case mucking with the
>addressee headers may be acceptable is to remove yourself from
>CC: list when a list you are on is on the CC: list.
>  
>
Yes, I am a victim of graphical email reader aka "thunderbird".
But I will now remember to do this for vger mailing lists.

A little off topic, but I just wish that http mail archive apps like the
one used in
http://marc.theaimsgroup.com/?l=linux-kernel
could also offer possibility to filter duplicates away.

Mika
