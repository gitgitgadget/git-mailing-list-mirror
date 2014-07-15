From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH 1/2] MinGW: fix compile error due to missing ELOOP
Date: Wed, 16 Jul 2014 01:57:38 +0200
Message-ID: <53C5BFF2.30001@gmail.com>
References: <20140712075035.GA12400@ucw.cz> <1405431797-20899-1-git-send-email-kasal@ucw.cz> <xmqq38e2wkkh.fsf@gitster.dls.corp.google.com> <53C5B0A1.4060502@gmail.com> <53C5B0E7.4050706@gmail.com> <20140715234257.GM12427@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Stepan Kasal <kasal@ucw.cz>, 
 Johannes Sixt <j6t@kdbg.org>,
 GIT Mailing-list <git@vger.kernel.org>, 
 msysGit <msysgit@googlegroups.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: msysgit+bncBCH3XYXLXQDBB4X7S2PAKGQESL7TUQA@googlegroups.com Wed Jul 16 01:57:39 2014
Return-path: <msysgit+bncBCH3XYXLXQDBB4X7S2PAKGQESL7TUQA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f186.google.com ([209.85.217.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBB4X7S2PAKGQESL7TUQA@googlegroups.com>)
	id 1X7CbL-0002qt-Ax
	for gcvm-msysgit@m.gmane.org; Wed, 16 Jul 2014 01:57:39 +0200
Received: by mail-lb0-f186.google.com with SMTP id v6sf11999lbi.23
        for <gcvm-msysgit@m.gmane.org>; Tue, 15 Jul 2014 16:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=4/aQpvNbb60kW36NmOV7sNfOVxrh3e0opx6SJ6v1SYE=;
        b=egaXsyRkF7Nbj6lUPMU5+N/mq/zkU6eHp+ld8DmjKpL4lyB74DdbxHnikR5LGIT+ZH
         EyTUiQmkUX+UUlNgpFP9WciZs3/VyWWNWIQMmr0lmfIVoVyTaqvYrn95FtqypVMsV887
         sJFegt+a241hC8855L/6NjqxjOhenlwnpd0eZIGO1MZE6qbyf8pDeFxjQhzlti/DYkj3
         YpHtRPFeCpfQBb+tpN0isub2UA2w64+yRaMxb5rblP6vN0h8Ks54jlr4205+3icC7J66
         nV6nYQyxxoKDpaX7asPxX7PKTGaa8FGn6y4xDNjGidq0G3bHGUDKVTnJQ8w2/PZLX1Ew
         l5Rg==
X-Received: by 10.180.84.66 with SMTP id w2mr39466wiy.19.1405468659136;
        Tue, 15 Jul 2014 16:57:39 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.182.197 with SMTP id eg5ls660755wic.1.canary; Tue, 15 Jul
 2014 16:57:38 -0700 (PDT)
X-Received: by 10.180.87.7 with SMTP id t7mr775628wiz.5.1405468658054;
        Tue, 15 Jul 2014 16:57:38 -0700 (PDT)
Received: from mail-wi0-x236.google.com (mail-wi0-x236.google.com [2a00:1450:400c:c05::236])
        by gmr-mx.google.com with ESMTPS id o6si267874wij.1.2014.07.15.16.57.38
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 15 Jul 2014 16:57:38 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::236 as permitted sender) client-ip=2a00:1450:400c:c05::236;
Received: by mail-wi0-f182.google.com with SMTP id d1so413031wiv.3
        for <msysgit@googlegroups.com>; Tue, 15 Jul 2014 16:57:38 -0700 (PDT)
X-Received: by 10.180.74.82 with SMTP id r18mr9015764wiv.62.1405468657962;
        Tue, 15 Jul 2014 16:57:37 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id fu7sm2001624wib.2.2014.07.15.16.57.36
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 15 Jul 2014 16:57:37 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <20140715234257.GM12427@google.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::236
 as permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253651>

Am 16.07.2014 01:42, schrieb Jonathan Nieder:
> Karsten Blees wrote:
> 
>> MinGW and MSVC before 2010 don't define ELOOP, use EMLINK (aka "Too many
>> links") instead.
> [...]
>> +#ifndef ELOOP
>> +#define ELOOP EMLINK
>> +#endif
> 
> This could use
> 
> 	#define ELOOP WSAELOOP
> 
> as an alternative.  But it shouldn't matter since git doesn't look for
> EMLINK anywhere (EMLINK = 31, WSAELOOP = wsabaseerr+62 = 10062).
> 
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> 

It matters when we report the error to the user (i.e. via die_errno):

strerror(EMLINK) -> "Too many links"
strerror(10062)  -> "Unknown error"

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
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
