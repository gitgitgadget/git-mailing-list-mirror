From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] symlinks: remove PATH_MAX limitation
Date: Fri, 11 Jul 2014 15:19:49 -0700
Message-ID: <xmqqd2db35dm.fsf@gitster.dls.corp.google.com>
References: <53B72DAA.5050007@gmail.com>
	<xmqqsimdc988.fsf@gitster.dls.corp.google.com>
	<53C036DB.7000505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,  msysGit <msysgit@googlegroups.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBCG77UMM3EJRBD6GQGPAKGQEXWT227I@googlegroups.com Sat Jul 12 00:20:04 2014
Return-path: <msysgit+bncBCG77UMM3EJRBD6GQGPAKGQEXWT227I@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qc0-f184.google.com ([209.85.216.184])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBD6GQGPAKGQEXWT227I@googlegroups.com>)
	id 1X5jAe-0007Hl-Sr
	for gcvm-msysgit@m.gmane.org; Sat, 12 Jul 2014 00:20:01 +0200
Received: by mail-qc0-f184.google.com with SMTP id i8sf403350qcq.21
        for <gcvm-msysgit@m.gmane.org>; Fri, 11 Jul 2014 15:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=0hDQ40YJdnOpkZQiFrkNl6Cfo4bFDcDHF29Rf1JIvWE=;
        b=kIE/rjCMTlXBEgqXJUnvO4qy+V9hJInqP6R+gxHn31WfIaEh4o5M+5vKUi/V90TThc
         k1azwykQ1nrA20adOKFC63vJAZ1INFMqNAzndyQquTdZp+paG5vWSObyWiXUkbxGgG3v
         DvU+A1Q+Dxz3lGfqtLPS3wtoE1kbGdjkBv1mE3ogTX2wQmXoazJhCuZhB3ujJFynbgCo
         PDW0+mMD+/E5fOUVI+ZgybTDpcabhn+Uu67RQTYv0FH7On7bOn9KK5J2iw7HomO60uhd
         5SAOidg8+g4kccuS4K6tzCDjydLBkekxgjXxD/NbpYs0eY3rZLChgtUb4ktXmuRuzFTb
         jdNA==
X-Received: by 10.182.28.71 with SMTP id z7mr17074obg.16.1405117199939;
        Fri, 11 Jul 2014 15:19:59 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.182.97.227 with SMTP id ed3ls564863obb.29.gmail; Fri, 11 Jul
 2014 15:19:58 -0700 (PDT)
X-Received: by 10.66.144.228 with SMTP id sp4mr853930pab.5.1405117198854;
        Fri, 11 Jul 2014 15:19:58 -0700 (PDT)
Received: from smtp.pobox.com (smtp.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id xn6si176463vdc.2.2014.07.11.15.19.58
        for <msysgit@googlegroups.com>;
        Fri, 11 Jul 2014 15:19:58 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4D27A28543;
	Fri, 11 Jul 2014 18:19:43 -0400 (EDT)
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 440F428542;
	Fri, 11 Jul 2014 18:19:43 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 30F5F28540;
	Fri, 11 Jul 2014 18:19:36 -0400 (EDT)
In-Reply-To: <53C036DB.7000505@gmail.com> (Karsten Blees's message of "Fri, 11
	Jul 2014 21:11:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 711035D4-0949-11E4-B47A-9903E9FBB39C-77302942!pb-smtp0.pobox.com
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted
 sender) smtp.mail=junio@pobox.com;       dkim=pass header.i=@pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253335>

Karsten Blees <karsten.blees@gmail.com> writes:

> Am 07.07.2014 20:30, schrieb Junio C Hamano:
>> Karsten Blees <karsten.blees@gmail.com> writes:
>> 
>> The above cache_def_free(cache) does not free the cache itself, but
>> only its associated data, so the name cache_def_free() is somewhat
>> misleading.
>> 
>
> You already merged this to master ("kb/path-max-must-go" lol), should
> I send a fixup! s/cache_def_free/cache_def_clear/ or is it OK as is?

I do not think a fix-up would hurt other topics in flight, so
please do so.

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
