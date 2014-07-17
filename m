From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] MinGW: Skip test redirecting to fd 4
Date: Thu, 17 Jul 2014 13:38:15 -0700
Message-ID: <xmqqy4vroh54.fsf@gitster.dls.corp.google.com>
References: <20140716092959.GA378@ucw.cz>
	<1405611425-10009-1-git-send-email-kasal@ucw.cz>
	<1405611425-10009-2-git-send-email-kasal@ucw.cz>
	<xmqqbnsnq14j.fsf@gitster.dls.corp.google.com>
	<53C82F78.1020805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stepan Kasal <kasal@ucw.cz>,  Johannes Sixt <j6t@kdbg.org>,  GIT Mailing-list <git@vger.kernel.org>,  msysGit <msysgit@googlegroups.com>,  Johannes Schindelin <johannes.schindelin@gmx.de>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBCG77UMM3EJRBP7IUCPAKGQE34NWS3A@googlegroups.com Thu Jul 17 22:38:25 2014
Return-path: <msysgit+bncBCG77UMM3EJRBP7IUCPAKGQE34NWS3A@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qc0-f183.google.com ([209.85.216.183])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBP7IUCPAKGQE34NWS3A@googlegroups.com>)
	id 1X7sRc-00049Q-Nc
	for gcvm-msysgit@m.gmane.org; Thu, 17 Jul 2014 22:38:24 +0200
Received: by mail-qc0-f183.google.com with SMTP id m20sf822593qcx.0
        for <gcvm-msysgit@m.gmane.org>; Thu, 17 Jul 2014 13:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=UOOdhF2hiaajr7Ge5BflbEyTe6bZfmaEBwZqNralW6s=;
        b=WQkuda7wESNlZPPCp5NTJyeUguN8B+79Nv7DQvugKDzA4UWV/SP0Ep90tlW2i+flV1
         YTUKF+VsxQh6/el8InH3A2AnJz5XZr6RC5kz4hfjbEjs1GgC7eiFnGvzEhAKE0o4xFdt
         JGoLqjp20dkVyZbrB3GDmUXiy7vOCflsaEkTtq5Q+2oCpwzXY2JW9ZeS/yywZtO3wuoD
         PYcrfw6hlzTc+S7f3dMqvlcnXM3eGAXJO3m6f5qFISywBEQsqPltgVBYau8e8/E0RbR9
         cj5pvadalF89arYwai4lZE/9SBkvOdzq39XTGhTeJ2cvM0/EVHQJTt2vR4qHFDmDcuX5
         Kmew==
X-Received: by 10.140.51.18 with SMTP id t18mr33811qga.27.1405629503969;
        Thu, 17 Jul 2014 13:38:23 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.98.175 with SMTP id o44ls817452qge.55.gmail; Thu, 17 Jul
 2014 13:38:23 -0700 (PDT)
X-Received: by 10.236.209.97 with SMTP id r61mr17170853yho.33.1405629503375;
        Thu, 17 Jul 2014 13:38:23 -0700 (PDT)
Received: from smtp.pobox.com (smtp.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id he4si457787qcb.0.2014.07.17.13.38.23
        for <msysgit@googlegroups.com>;
        Thu, 17 Jul 2014 13:38:23 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2F9B92ACA3;
	Thu, 17 Jul 2014 16:38:23 -0400 (EDT)
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 24BCA2ACA2;
	Thu, 17 Jul 2014 16:38:23 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 258B12AC99;
	Thu, 17 Jul 2014 16:38:17 -0400 (EDT)
In-Reply-To: <53C82F78.1020805@gmail.com> (Karsten Blees's message of "Thu, 17
	Jul 2014 22:18:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 48267856-0DF2-11E4-9F17-9903E9FBB39C-77302942!pb-smtp0.pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253780>

Karsten Blees <karsten.blees@gmail.com> writes:

> Yes. 0, 1 and 2 work (vie GetStdHandle), but anything else is handled
> by the C-runtime. And as MSYS.dll (bash) and MSVCRT.dll (git) do it in
> different ways, it doesn't work.
>
>> -	echo copy 6 |
>> -	test-line-buffer "&4" 4<input >actual &&
>> +	test-line-buffer "&0" <input >actual &&
>
> test-line-buffer already reads commands ("copy 6") from stdin, so stdin cannot
> be reused for the data stream, unfortunately.

Sorry, that was my silly.

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
