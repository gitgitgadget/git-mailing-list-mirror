From: dhruva <dhruvakm@gmail.com>
Subject: Re: [PATCH] Makefile: introduce NO_PTHREADS
Date: Mon, 1 Dec 2008 14:18:00 +0530
Message-ID: <e3f230850812010048x4b8038fegaa97b247f7851a3e@mail.gmail.com>
References: <200811121029.34841.thomas@koch.ro>
	 <vzAozXmaOLEpyz-7DHx4nMusAdaTsFp7iZ8xfFsgAIraex6_wfvyuw@cipher.nrlssc.navy.mil>
	 <alpine.LFD.2.00.0811141109580.3468@nehalem.linux-foundation.org>
	 <7vtza95h01.fsf@gitster.siamese.dyndns.org>
	 <alpine.LFD.2.00.0811150915240.3468@nehalem.linux-foundation.org>
	 <e2b179460811170203v41e54ecclc3d6526bcc0fe928@mail.gmail.com>
	 <492148AD.1090604@viscovery.net>
	 <e2b179460811170245t1845cc66h7cb2a18c43a79359@mail.gmail.com>
	 <4921548E.6070802@viscovery.net> <4933A058.3050101@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Mike Ralphson" <mike.ralphson@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Linus Torvalds" <torvalds@linux-foundation.org>
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Dec 01 09:49:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L74TE-0001iC-RI
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 09:49:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbYLAIsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 03:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbYLAIsE
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 03:48:04 -0500
Received: from rv-out-0506.google.com ([209.85.198.237]:40199 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748AbYLAIsB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 03:48:01 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2365221rvb.1
        for <git@vger.kernel.org>; Mon, 01 Dec 2008 00:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=pYA5/6u+yM9/vgSwfOOMuYOXfku+4V3fIKHMmnjGFrM=;
        b=TbZq5EFBZ14uxOnxLefgyTSS9T1IFm8mGIjJxRxskBPvw5mfRBS+VHJPSMyJLyBNbZ
         wISLo6sXXCqKCMNvSjV3mPSRfzkChRx6aWuL3A+y+MO4j/cKc8yqL/Ei78GOHD7UPj44
         u1QJH458RErfyvnJgjdJBELHZ441Iedq67V7g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=E2Ucv8gv6w5Rq5gkRSbkgQw59XOlUrr4kXfb/Cw/JgtEjH7He6Oig3n/EvG1GteUnR
         cwutOwAvq4kOrBczcJqu+dRzV6Nsw3zRa4UZFUgOfMG4Uj262bbTtpYTWA6ge7ksj3rj
         RZBivHcYsNi4t27+vaHWVHrL1DuhmHvsx1KqM=
Received: by 10.142.238.4 with SMTP id l4mr4353936wfh.98.1228121280346;
        Mon, 01 Dec 2008 00:48:00 -0800 (PST)
Received: by 10.142.110.21 with HTTP; Mon, 1 Dec 2008 00:48:00 -0800 (PST)
In-Reply-To: <4933A058.3050101@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102004>

Hello,
 I am able to compile and use git by defining THREADED_DELTA_SEARCH
and copying setjmp.h from mingw (www.mingw.org) to msys include folder
with small changes to it. If it does add value, we should try to
enable this by default.

-dhruva

On Mon, Dec 1, 2008 at 1:59 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Johannes Sixt schrieb:
>> Mike Ralphson schrieb:
>>> 2008/11/17 Johannes Sixt <j.sixt@viscovery.net>:
>>>> Mike Ralphson schrieb:
>>>>> 2008/11/15 Linus Torvalds <torvalds@linux-foundation.org>:
>>>>>> On Sat, 15 Nov 2008, Junio C Hamano wrote:
>>>>>>> This introduces make variable NO_PTHREADS for platforms that lack the
>>>>>>> support for pthreads library or people who do not want to use it for
>>>>>>> whatever reason.  When defined, it makes the multi-threaded index
>>>>>>> preloading into a no-op, and also disables threaded delta searching by
>>>>>>> pack-objects.
>>>>>> Ack. Makes sense.
>>>>> I'd be minded to make this the default on AIX to keep the prerequisite
>>>>> list as small as possible, then people can opt-in for the performance
>>>>> benefits if required.
>>>> Is pthreads not a standard shipment on AIX? I would set NO_PTHREADS only
>>>> if we know in advance that there are many installations without pthreads.
>>>> (And I don't know what the situation is.)
>>> I should have dug a bit further, it seems to be present on my 5.3
>>> machines but I still need to determine whether it got installed by
>>> default. Either way it must need some other link flags...
>>
>> I tried compiling with THREADED_DELTA_SEARCH=Yes, and it fails with
>>
>>     CC builtin-pack-objects.o
>> In file included from /usr/include/sys/pri.h:29,
>>                  from /usr/include/sys/sched.h:38,
>>                  from /usr/include/sched.h:52,
>>                  from /usr/include/pthread.h:43,
>>                  from builtin-pack-objects.c:22:
>> /usr/include/sys/proc.h:203: parse error before "crid_t"
>> /usr/include/sys/proc.h:212: parse error before "p_class"
>> /usr/include/sys/proc.h:355: parse error before '}' token
>>
>> :-( Maybe NO_PTHREADS is indeed the safer choice? I'm not going to dig
>> into this today, though. (I'm on AIX 4.3.something.)
>>
>>>> BTW, this needs to be squashed in, because we don't have pthreads on Windows:
>>>>
>>>> diff --git a/Makefile b/Makefile
>>>> index ffc9531..3a30b8c 100644
>>>> --- a/Makefile
>>>> +++ b/Makefile
>>>> @@ -769,6 +769,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
>>>>        NO_STRCASESTR = YesPlease
>>>>        NO_STRLCPY = YesPlease
>>>>        NO_MEMMEM = YesPlease
>>>> +       NO_PTHREADS = YesPlease
>>>>        NEEDS_LIBICONV = YesPlease
>>>>        OLD_ICONV = YesPlease
>>>>        NO_C99_FORMAT = YesPlease
>>>>
>>> Ta. Ok to add your S-o-B on a squashed patch?
>>
>> Sure. Use this address please:
>>
>> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
>
> Mike,
>
> you said you would resend the patch, but I think you forgot about it.
> Would you do that now, please?
>
> -- Hannes
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Contents reflect my personal views only!
