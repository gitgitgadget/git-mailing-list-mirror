From: Martijn Kuipers <martijn.kuipers@gmail.com>
Subject: Re: [PATCH] Spell __attribute__ correctly in cache.h.
Date: Mon, 29 Aug 2005 09:55:22 +0100
Message-ID: <4312CD7A.4010401@gmail.com>
References: <19723.1125249085@lotus.CS.Berkeley.EDU> <Pine.LNX.4.58.0508281045060.3317@g5.osdl.org> <43120BC5.8060608@kaijanaho.info> <Pine.LNX.4.58.0508281245150.3317@g5.osdl.org> <4312C492.2010307@gmail.com> <4312C8D6.9010200@kaijanaho.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Jason Riedy <ejr@EECS.Berkeley.EDU>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 29 10:58:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9fQa-00059U-Dq
	for gcvg-git@gmane.org; Mon, 29 Aug 2005 10:55:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbVH2IzZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Aug 2005 04:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750889AbVH2IzZ
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Aug 2005 04:55:25 -0400
Received: from smtp3.netcabo.pt ([212.113.174.30]:13725 "EHLO
	exch01smtp12.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S1750855AbVH2IzY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2005 04:55:24 -0400
Received: from [192.168.8.10] ([85.138.8.13]) by exch01smtp12.hdi.tvcabo with Microsoft SMTPSVC(6.0.3790.211);
	 Mon, 29 Aug 2005 09:55:23 +0100
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
To: Antti-Juhani Kaijanaho <antti-juhani@kaijanaho.info>
In-Reply-To: <4312C8D6.9010200@kaijanaho.info>
X-OriginalArrivalTime: 29 Aug 2005 08:55:23.0358 (UTC) FILETIME=[6449EFE0:01C5AC77]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7897>

Sorry, I am not very familiar with all those command line options:
Anyway, redo was easy:
with: --std=c9x

gcc-2.95 --std=c9x -pedantic -Wall -W -ofoo foo.c
foo.c:5: field `b' has incomplete type
foo.c: In function `main':
foo.c:20: warning: unknown conversion type character `z' in format
foo.c:20: warning: unknown conversion type character `z' in format
foo.c:20: warning: unknown conversion type character `z' in format
foo.c:20: warning: too many arguments for format

I found one man-page online 
(http://gcc.gnu.org/onlinedocs/gcc-2.95.3/gcc_2.html#SEC3), which seemed 
to suggest -fstd=c9x (if I understood correclty). This gave the same 
results.

I hope this makes it a bit more useful :-)
If not, just let me know.

Kind regards,
Martijn


Antti-Juhani Kaijanaho wrote:

>Martijn Kuipers wrote:
>  
>
>>martijn@hobbes:~$ gcc-2.95 --std=c99 -pedantic -Wall -W -ofoo foo.c
>>cc1: unknown C standard `c99'
>>    
>>
>
>This makes this test a little less useful.  Try with --std=c9x (GCC 2.95
>is old enough not to know the standard by the "official" name).
>
>According to GCC 3.0 C99 status page [1], 3.0 supported flexible array
>members.  There is no similar page for 2.95.
>
>  
>
