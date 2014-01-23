From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Makefile: Fix compilation of Windows
 resource file
Date: Thu, 23 Jan 2014 10:02:46 -0800
Message-ID: <xmqqlhy6vant.fsf@gitster.dls.corp.google.com>
References: <52DD857C.6060005@ramsay1.demon.co.uk>
	<xmqqy529t5bb.fsf@gitster.dls.corp.google.com>
	<xmqqppnlt3u3.fsf@gitster.dls.corp.google.com>
	<52DEF9F2.1000905@ramsay1.demon.co.uk>
	<xmqqk3dssxpb.fsf@gitster.dls.corp.google.com>
	<52DF6B6C.4020708@viscovery.net>
	<xmqq38kgyozt.fsf@gitster.dls.corp.google.com>
	<52DFF4E8.8060605@viscovery.net>
	<xmqqppnjyl10.fsf@gitster.dls.corp.google.com>
	<xmqqeh3zydrz.fsf@gitster.dls.corp.google.com>
	<52E0C4BA.4080405@viscovery.net>
	<CABNJ2GJRsqsr5+ga3-oKVU_H-HtsH+R14fBaVwV8jJcExkxr4g@mail.gmail.com>
	<52E1244E.4010503@viscovery.net>
	<CABNJ2GKA5PhzTfrhSCOTWtWAKMdT8+Sn6_Q54z=Dc0UVWgdmZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j.sixt@viscovery.net>,  msysGit <msysgit@googlegroups.com>,  Ramsay Jones <ramsay@ramsay1.demon.co.uk>,  GIT Mailing-list <git@vger.kernel.org>,  Pat Thoyts <patthoyts@users.sourceforge.net>
To: Pat Thoyts <patthoyts@gmail.com>
X-From: msysgit+bncBCG77UMM3EJRBTNSQWLQKGQELWF52HQ@googlegroups.com Thu Jan 23 19:02:55 2014
Return-path: <msysgit+bncBCG77UMM3EJRBTNSQWLQKGQELWF52HQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qc0-f189.google.com ([209.85.216.189])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBTNSQWLQKGQELWF52HQ@googlegroups.com>)
	id 1W6OcA-0006jL-Qs
	for gcvm-msysgit@m.gmane.org; Thu, 23 Jan 2014 19:02:55 +0100
Received: by mail-qc0-f189.google.com with SMTP id i8sf437389qcq.26
        for <gcvm-msysgit@m.gmane.org>; Thu, 23 Jan 2014 10:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=L6aOJeOY4Ytux0r7AknbVtOVkYdmp4HBiPniR6UT014=;
        b=JkzD3S3NGaLktpMH/zRaKBewPHi60VqvUgFislDlbtlWLBg+2AdWTBZzSIuiOTli+N
         30+SgMeSeOt+wvHVF5M7EiHRPmSEF+UYsDDkvxg14X/Q16O2yydvciVF2AKKMmbOaas5
         duNLi9jCR132zNjSVPD0KTp0QUWLYsXKrJCoDl305tyIAfc6ui2UougEf5OPO9InLmk9
         UIPeAAshyWart3iQp5TjG+dryge44qUMuYQdx+jJi6AOk779y27WcfuX21gJu6CdnvG+
         EL93xI9GUY2E4lB+8NAsItBWB4N7l9Sm+ftKu5s6y9oBHRd6tO57VSrD0Q3DOw7V79ap
         Sc4Q==
X-Received: by 10.140.107.138 with SMTP id h10mr166258qgf.2.1390500173973;
        Thu, 23 Jan 2014 10:02:53 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.49.94.210 with SMTP id de18ls362628qeb.87.gmail; Thu, 23 Jan
 2014 10:02:53 -0800 (PST)
X-Received: by 10.236.36.39 with SMTP id v27mr3321940yha.5.1390500173361;
        Thu, 23 Jan 2014 10:02:53 -0800 (PST)
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id g1si2284991pbw.2.2014.01.23.10.02.51
        for <msysgit@googlegroups.com>;
        Thu, 23 Jan 2014 10:02:51 -0800 (PST)
Received-SPF: pass (google.com: best guess record for domain of jch@b-sasl-quonix.pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F3A5E6520F;
	Thu, 23 Jan 2014 13:02:50 -0500 (EST)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD5BB6520E;
	Thu, 23 Jan 2014 13:02:50 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C84A365208;
	Thu, 23 Jan 2014 13:02:49 -0500 (EST)
In-Reply-To: <CABNJ2GKA5PhzTfrhSCOTWtWAKMdT8+Sn6_Q54z=Dc0UVWgdmZQ@mail.gmail.com>
	(Pat Thoyts's message of "Thu, 23 Jan 2014 15:19:18 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 926DAD90-8458-11E3-B1C5-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: best guess record for domain of jch@b-sasl-quonix.pobox.com
 designates 208.72.237.35 as permitted sender) smtp.mail=jch@b-sasl-quonix.pobox.com;
       dkim=pass header.i=@pobox.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240922>

Pat Thoyts <patthoyts@gmail.com> writes:

>>> GIT_VERSION=1.9.rc0
>>> all:
>>>     echo $(join -DMAJOR= -DMINOR= -DPATCH=, \
>>>         $(wordlist 1,3,$(filter-out rc%,$(subst -, ,$(subst .,
>>> ,$(GIT_VERSION)))) 0 0))
>>>
>>> This removes any rc* parts and appends a couple of zeros so that all
>>> missing elements should appear as 0 in the final list.
>>
>> As Junio already pointed out, this records the wrong number in the 1.9
>> track before 1.9.1 is out because the third position is the commit count,
>> not the patch level.
>>
>> -- Hannes
>
> OK - I cehcked and you are right in that the GIT_VERSION value is the
> one showing up the properties dialog at least under Windows 7. As this
> is the most likely to be examined I agree that just taking the first
> two digits is the simplest fix here. So, fine by me then.
>
> Acked-by: Pat Thoyts <patthoyts@users.sourceforge.net>

Thanks.

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
For more options, visit https://groups.google.com/groups/opt_out.
