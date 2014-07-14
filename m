From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] dir: remove PATH_MAX limitation
Date: Sun, 13 Jul 2014 21:29:51 -0700
Message-ID: <xmqqzjgczhog.fsf@gitster.dls.corp.google.com>
References: <53B72DAA.5050007@gmail.com> <53B72DD5.6020603@gmail.com>
	<xmqqa98i7aqt.fsf@gitster.dls.corp.google.com>
	<53C036CD.902@gmail.com>
	<xmqq4myn34xo.fsf@gitster.dls.corp.google.com>
	<53C076B8.9030209@gmail.com>
	<CACsJy8BOdQwht_b2D48cZP-NFosT2FxGg+hkEthsGBvW7EE=FQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Karsten Blees <karsten.blees@gmail.com>,  Git List <git@vger.kernel.org>,  msysGit <msysgit@googlegroups.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: msysgit+bncBCG77UMM3EJRBSFZRWPAKGQEOYXCRPI@googlegroups.com Mon Jul 14 06:30:02 2014
Return-path: <msysgit+bncBCG77UMM3EJRBSFZRWPAKGQEOYXCRPI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qc0-f184.google.com ([209.85.216.184])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBSFZRWPAKGQEOYXCRPI@googlegroups.com>)
	id 1X6Xtq-0006Cr-5p
	for gcvm-msysgit@m.gmane.org; Mon, 14 Jul 2014 06:30:02 +0200
Received: by mail-qc0-f184.google.com with SMTP id i8sf1002547qcq.1
        for <gcvm-msysgit@m.gmane.org>; Sun, 13 Jul 2014 21:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=UKiLeRMhp2HjmZ16pn2XK9QhabCB98Zz8J5OYsxhg9Y=;
        b=Ek8AApvWxm7GTAL9pj2DLSWQwROtB9ZZtvnGf8My+nyxr97FQ2az0e0lsxXGqdPFYV
         tYWwCYbg6pou2zaB22jFI+00qX6MgKW4LtAn2eR8a5/TKlXfEm3gYH8EcPFQhYzCH9Gh
         5jDyB7EVfO9H80MCQF5o0SGYI4blbeOaDMuWKKkfc9dIoTgkjh888QzIG0s7KQDU9lNy
         joI2n+7yIWB6fHIKfrgtMXDJoG7FtZs9DlpaUYSv9jqvyR9RI/q/qn9II9H3777+GLdP
         GZk6UEJyKBHEAClbyhTKq3MMdonPKjg1qG/+jfMgh7AQqZzPlRnrZl4/oFJ2uQ1efkhm
         BZqw==
X-Received: by 10.50.222.44 with SMTP id qj12mr426375igc.13.1405312201037;
        Sun, 13 Jul 2014 21:30:01 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.51.15.163 with SMTP id fp3ls212806igd.23.canary; Sun, 13 Jul
 2014 21:30:00 -0700 (PDT)
X-Received: by 10.42.100.138 with SMTP id a10mr8175326ico.32.1405312200151;
        Sun, 13 Jul 2014 21:30:00 -0700 (PDT)
Received: from smtp.pobox.com (smtp.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id fh2si407112vdb.3.2014.07.13.21.30.00
        for <msysgit@googlegroups.com>;
        Sun, 13 Jul 2014 21:30:00 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7DD4A220F2;
	Mon, 14 Jul 2014 00:29:42 -0400 (EDT)
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 72367220F1;
	Mon, 14 Jul 2014 00:29:42 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B05CB220EE;
	Mon, 14 Jul 2014 00:29:35 -0400 (EDT)
In-Reply-To: <CACsJy8BOdQwht_b2D48cZP-NFosT2FxGg+hkEthsGBvW7EE=FQ@mail.gmail.com>
	(Duy Nguyen's message of "Sat, 12 Jul 2014 09:56:17 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 75D5ECA4-0B0F-11E4-9D81-9903E9FBB39C-77302942!pb-smtp0.pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253466>

Duy Nguyen <pclouds@gmail.com> writes:

>> [01/20] dir.c: coding style fix
>> [02/20] dir.h: move struct exclude declaration to top level
>> [03/20] prep_exclude: remove the artificial PATH_MAX limit
>>
>> ...perhaps with s/if (!dir->basebuf.alloc)/if (!dir->basebuf.buf)/
>>
>> @Duy any reason for not signing off that series?
>
> That series still need a lot more work, but for those first three, if
> you want to fast track, you have my sign-offs.

If it is not too much trouble, can you send only the relevant
patches (these three) with sign-off again?  I'd prefer to give
patches a new chance to be eyeballed by people, and they will tend
to have a better chance by being a smaller and an isolated topic.

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
