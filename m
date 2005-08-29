From: Martijn Kuipers <martijn.kuipers@gmail.com>
Subject: Re: [PATCH] Spell __attribute__ correctly in cache.h.
Date: Mon, 29 Aug 2005 09:17:22 +0100
Message-ID: <4312C492.2010307@gmail.com>
References: <19723.1125249085@lotus.CS.Berkeley.EDU> <Pine.LNX.4.58.0508281045060.3317@g5.osdl.org> <43120BC5.8060608@kaijanaho.info> <Pine.LNX.4.58.0508281245150.3317@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Antti-Juhani Kaijanaho <antti-juhani@kaijanaho.info>,
	Jason Riedy <ejr@EECS.Berkeley.EDU>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 29 10:18:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9epr-0005Yh-9U
	for gcvg-git@gmane.org; Mon, 29 Aug 2005 10:17:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbVH2IRc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Aug 2005 04:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbVH2IRc
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Aug 2005 04:17:32 -0400
Received: from smtp1.netcabo.pt ([212.113.174.28]:59450 "EHLO
	exch01smtp11.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S1750766AbVH2IRc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2005 04:17:32 -0400
Received: from [192.168.8.10] ([85.138.8.13] RDNS failed) by exch01smtp11.hdi.tvcabo with Microsoft SMTPSVC(6.0.3790.211);
	 Mon, 29 Aug 2005 09:17:25 +0100
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508281245150.3317@g5.osdl.org>
X-OriginalArrivalTime: 29 Aug 2005 08:17:25.0664 (UTC) FILETIME=[16AD6A00:01C5AC72]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7895>

Hi,

I still had 2.95 on my machine (Debian). Results are:

martijn@hobbes:~$ gcc-2.95 --version
2.95.4

martijn@hobbes:~$ gcc-2.95 --std=c99 -pedantic -Wall -W -ofoo foo.c
cc1: unknown C standard `c99'
foo.c:5: field `b' has incomplete type
foo.c: In function `main':
foo.c:20: warning: unknown conversion type character `z' in format
foo.c:20: warning: unknown conversion type character `z' in format
foo.c:20: warning: unknown conversion type character `z' in format
foo.c:20: warning: too many arguments for format

Kind regards,
Martijn

Linus Torvalds wrote:

>On Sun, 28 Aug 2005, Antti-Juhani Kaijanaho wrote:
>  
>
>>This is not true under C99.  If an array[] is the last member of a
>>struct (which is what we are, AFAIK, talking about), then sizeof that
>>struct is defined and gives the size of that struct as if the array's
>>size were zero (but the struct cannot be used in an automatic context).
>>    
>>
>
>Ahh, thanks. Mea culpa, I thought it was illegal in general. In that case,
>the only reason not to use [] is that older gcc's don't like it, but even
>that version cut-off may be old enough to not matter.
>
>Anybody know? gcc-2.95 is still considered production at least for the
>kernel. I don't have it available to test whether it understands []
>though.
>
>		Linus
>-
>To unsubscribe from this list: send the line "unsubscribe git" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>  
>
