From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] Disable t0110's high-bit test on Windows
Date: Fri, 18 Jul 2014 11:26:24 -0700
Message-ID: <xmqqd2d2mskv.fsf@gitster.dls.corp.google.com>
References: <20140716092959.GA378@ucw.cz>
	<1405611425-10009-1-git-send-email-kasal@ucw.cz>
	<1405611425-10009-3-git-send-email-kasal@ucw.cz>
	<53C813D2.8070701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stepan Kasal <kasal@ucw.cz>,  Johannes Sixt <j6t@kdbg.org>,  GIT Mailing-list <git@vger.kernel.org>,  msysGit <msysgit@googlegroups.com>,  Johannes Schindelin <johannes.schindelin@gmx.de>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBCG77UMM3EJRBW6NUWPAKGQEPQ2L2RI@googlegroups.com Fri Jul 18 20:26:40 2014
Return-path: <msysgit+bncBCG77UMM3EJRBW6NUWPAKGQEPQ2L2RI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qc0-f191.google.com ([209.85.216.191])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBW6NUWPAKGQEPQ2L2RI@googlegroups.com>)
	id 1X8Crd-0006IR-1z
	for gcvm-msysgit@m.gmane.org; Fri, 18 Jul 2014 20:26:37 +0200
Received: by mail-qc0-f191.google.com with SMTP id c9sf1165954qcz.8
        for <gcvm-msysgit@m.gmane.org>; Fri, 18 Jul 2014 11:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=WmnQppIlgh9Wt8+QFffs6afJEfhPqlhHuF0CX0wl2C0=;
        b=M55H7DFCq6dq8IQB4mEAt09BoSQYPMWtcUJ6ibFYw+fI1VMIDrl9iq9zofXpMws/oY
         mXn/p1Qb91zARN/PcPNovDlgj/9wNvupvkRAO4Sj0+IAaQ7FXxcqO2MOfU28yqpC7geJ
         HoXR5jOg5+1ESqqCrFfigkUfYd4+hYGvzTcjJ99weqsC77G7JOrOAB2a7ppEepiQzZWX
         qkYV5jLqb2JQW9jIlJlhqkh1k8NjSH9VqU+0eGcruhniH6e2VJouYbhyO6ilNwuen9aP
         8hxcqR3VgUBSaWaxqg6mGLCEKXWvpZUQc0FlPhoBEm5OfW/BvDlX/GdQhohJ7D6Tus3h
         lt+Q==
X-Received: by 10.140.49.144 with SMTP id q16mr85990qga.1.1405707996298;
        Fri, 18 Jul 2014 11:26:36 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.29.133 with SMTP id b5ls692648qgb.43.gmail; Fri, 18 Jul
 2014 11:26:35 -0700 (PDT)
X-Received: by 10.236.124.131 with SMTP id x3mr2790731yhh.14.1405707995772;
        Fri, 18 Jul 2014 11:26:35 -0700 (PDT)
Received: from smtp.pobox.com (smtp.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id w2si726987qcl.3.2014.07.18.11.26.33
        for <msysgit@googlegroups.com>;
        Fri, 18 Jul 2014 11:26:33 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 93F542882C;
	Fri, 18 Jul 2014 14:26:32 -0400 (EDT)
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 880742882B;
	Fri, 18 Jul 2014 14:26:32 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E092C28825;
	Fri, 18 Jul 2014 14:26:26 -0400 (EDT)
In-Reply-To: <53C813D2.8070701@gmail.com> (Karsten Blees's message of "Thu, 17
	Jul 2014 20:20:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 07B22682-0EA9-11E4-AC38-9903E9FBB39C-77302942!pb-smtp0.pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253835>

Karsten Blees <karsten.blees@gmail.com> writes:

> Am 17.07.2014 17:37, schrieb Stepan Kasal:
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>> 
>> The bash Git for Windows uses (i.e. the MSys bash) cannot pass
>> command-line arguments with high bits set verbatim to non-MSys programs,
>> but instead converts those characters with high bits set to their hex
>> representation.
>> 
>
> The description is not entirely correct...the Unicode-enabled MSYS.dll
> expects the command line to be UTF-8. Only *invalid* UTF-8 is converted
> to hex code for convenience. So its not the high bits that cause trouble,
> but specifying 0x80 without proper UTF-8 lead byte.
>
> I believe the last line of the test may actually work:
>
> test "$(test-urlmatch-normalization -p "$(cat "$tu-11")")" = "x://q/%C2%80%DF%BF%E0%A0%80%EF%BF%BD%F0%90%80%80%F0%AF%BF%BD"
>
> -- 

Can somebody send a tested replacement then?

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
For more options, visit https://groups.google.com/d/optout.
