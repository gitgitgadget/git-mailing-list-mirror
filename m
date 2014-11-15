From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] t1410: fix breakage on case-insensitive filesystems
Date: Sat, 15 Nov 2014 09:27:58 +0100
Message-ID: <54670E8E.5040901@kdbg.org>
References: <CAO2U3QiFvwMiwVCdVju_vJKK_HVndpQf4VyrEaHeeVVN6rgYgA@mail.gmail.com>	<20141109014354.GA23883@peff.net> <20141109015918.GA24736@peff.net>	<5463C106.5090803@kdbg.org> <20141112215923.GB6801@peff.net>	<546470D0.3080809@kdbg.org> <20141113090832.GA8329@peff.net>	<546653D6.7040505@kdbg.org> <87zjbtlcj0.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Michael Blume <blume.mike@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>,
 git@vger.kernel.org, msysGit <msysgit@googlegroups.com>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: msysgit+bncBCJYV6HBKQIJJHM4UMCRUBEPEYCZK@googlegroups.com Sat Nov 15 09:28:06 2014
Return-path: <msysgit+bncBCJYV6HBKQIJJHM4UMCRUBEPEYCZK@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f63.google.com ([209.85.215.63])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCJYV6HBKQIJJHM4UMCRUBEPEYCZK@googlegroups.com>)
	id 1XpYiE-0006QA-4V
	for gcvm-msysgit@m.gmane.org; Sat, 15 Nov 2014 09:28:06 +0100
Received: by mail-la0-f63.google.com with SMTP id q1sf1551704lam.18
        for <gcvm-msysgit@m.gmane.org>; Sat, 15 Nov 2014 00:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=5qSK7qHm20kFbb7qYRRPvOb+P4ZXEbwQ6sZzzPhvH8w=;
        b=cG2v06FsYzHUODqNmtfr72B9EngYYbRpq8AoTaPQejaagSdESRahQ30NoHJtwlCDnJ
         NLJOJm+bkyDys9b+lbI5HUZe8SVhqVnJpZbqbZEtGYLGFIKeoq+nJx8lXHFsp9RZt6dy
         9oZBHKy/vFa6628iPCG0Bc/CcFAObYyYJ0+LXPjggZqDbbD3N9YrXJAxu8VDV3O3b3yM
         azyAfQcyFcJhKW+7s05DkQvLZIzy/fTusmuy35IlqzGXaMgLrx1jBrDiw7m/V8ydSrKa
         B/GQntNFnsnevYks0uuMueorNOGHsBfKUDdR2zUfsO1Qw6MtBEP51T0uKiWWU2gEyqm2
         bMXw==
X-Received: by 10.152.2.135 with SMTP id 7mr2238lau.19.1416040085943;
        Sat, 15 Nov 2014 00:28:05 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.27.41 with SMTP id q9ls825815lag.67.gmail; Sat, 15 Nov
 2014 00:28:04 -0800 (PST)
X-Received: by 10.112.62.226 with SMTP id b2mr194620lbs.11.1416040084124;
        Sat, 15 Nov 2014 00:28:04 -0800 (PST)
Received: from bsmtp.bon.at (bsmtp3.bon.at. [213.33.87.17])
        by gmr-mx.google.com with ESMTPS id jw5si276392wid.2.2014.11.15.00.28.04
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Nov 2014 00:28:04 -0800 (PST)
Received-SPF: none (google.com: j6t@kdbg.org does not designate permitted sender hosts) client-ip=213.33.87.17;
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3jfqS23mB5z5tlB;
	Sat, 15 Nov 2014 09:28:02 +0100 (CET)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 5A98419F730;
	Sat, 15 Nov 2014 09:27:59 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <87zjbtlcj0.fsf@igel.home>
X-Original-Sender: j6t@kdbg.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=none
 (google.com: j6t@kdbg.org does not designate permitted sender hosts) smtp.mail=j6t@kdbg.org
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>

Am 14.11.2014 um 22:04 schrieb Andreas Schwab:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>> diff --git a/compat/mingw.c b/compat/mingw.c
>> index 2ee3fe3..fc64b73 100644
>> --- a/compat/mingw.c
>> +++ b/compat/mingw.c
>> @@ -312,7 +312,7 @@ int mingw_open (const char *filename, int oflags, ...)
>>  		return -1;
>>  	fd = _wopen(wfilename, oflags, mode);
>>  
>> -	if (fd < 0 && (oflags & O_CREAT) && errno == EACCES) {
>> +	if (fd < 0 && (oflags & (O_WRONLY|O_RDWR)) && errno == EACCES) {
> 
> O_WRONLY and O_RDWR aren't flags, but two values of a 2-bit field
> (O_ACCMODE).

Hrm... I wondered why O_RDONLY can be zero. If I find O_ACCMODE on
Windows, I'll use it, otherwise, the patch as is will have to do - we
don't have to be particularly portable in this corner of the code.

-- Hannes

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
