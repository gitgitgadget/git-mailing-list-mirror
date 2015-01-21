From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/lib-httpd: switch SANITY check for NOT_ROOT
Date: Wed, 21 Jan 2015 14:33:02 -0800
Message-ID: <xmqq61bzwyqp.fsf@gitster.dls.corp.google.com>
References: <20150114211712.GE1155@peff.net>
	<064010B3-BC58-42F2-B5C0-DAADAA59B87D@gmail.com>
	<xmqqwq4n6b4c.fsf@gitster.dls.corp.google.com>
	<20150115222719.GA19021@peff.net>
	<xmqqa91j6537.fsf@gitster.dls.corp.google.com>
	<20150115235752.GB25120@peff.net>
	<xmqqh9vr4mlz.fsf@gitster.dls.corp.google.com>
	<20150116013256.GA25894@peff.net>
	<BEFF558C-774D-4891-96A0-BE962F8070E7@gmail.com>
	<20150116033445.GA29572@peff.net> <20150116091648.GA2450@peff.net>
	<xmqqfvba37bq.fsf@gitster.dls.corp.google.com>
	<xmqqzj9i1rci.fsf@gitster.dls.corp.google.com> <54BAF1C2.60103@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Jeff King <peff@peff.net>,  "Kyle J. McKay" <mackyle@gmail.com>,  msysgit@googlegroups.com,  Git Mailing List <git@vger.kernel.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: msysgit+bncBCG77UMM3EJRBIGSQCTAKGQEOWHXR3Q@googlegroups.com Wed Jan 21 23:33:06 2015
Return-path: <msysgit+bncBCG77UMM3EJRBIGSQCTAKGQEOWHXR3Q@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qa0-f56.google.com ([209.85.216.56])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBIGSQCTAKGQEOWHXR3Q@googlegroups.com>)
	id 1YE3ph-0005Ry-UF
	for gcvm-msysgit@m.gmane.org; Wed, 21 Jan 2015 23:33:06 +0100
Received: by mail-qa0-f56.google.com with SMTP id n8sf7022523qaq.1
        for <gcvm-msysgit@m.gmane.org>; Wed, 21 Jan 2015 14:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=7hwPCikcvGngvHZC2F1lXuM76NNblVmuclDHDB1bE28=;
        b=PZsEUkFRGph0WiuOGktPO3yN4WrgO5MtRutV4xzHL1fs4f5MQe7/CmHlLWSKlm78lZ
         2h91ciUgJSsYRakstxU4xC0maBKLYOTJXGGwB9tSs/mBSo4HD3Qb5ma1d3Fs8B5QWn+7
         c9N3nCR+NH4xTHWWQ0dh/DIaCnmPbxx1JqB0VHjN2BtV+aNdBfg/ZAV5jT1eUvNpX1Z9
         rmqXyUtm4f6GqNKLW4trs3bR0UQ1YWbUq3+dLwqDfFiJ15UEpKVOSEpSBF0FUhYUuynv
         rU++/XfXUrgmRuWHiIFwVwydVw2v+Up+lWyZvEY6PjzbBea+FsCQYNnQM957uczlH0AY
         UBjg==
X-Received: by 10.182.181.69 with SMTP id du5mr83864obc.23.1421879585295;
        Wed, 21 Jan 2015 14:33:05 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.182.28.8 with SMTP id x8ls168780obg.27.gmail; Wed, 21 Jan 2015
 14:33:04 -0800 (PST)
X-Received: by 10.182.108.193 with SMTP id hm1mr8565990obb.43.1421879584513;
        Wed, 21 Jan 2015 14:33:04 -0800 (PST)
Received: from sasl.smtp.pobox.com (pb-smtp1.int.icgroup.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id fg3si80728qcb.1.2015.01.21.14.33.04
        for <msysgit@googlegroups.com>;
        Wed, 21 Jan 2015 14:33:04 -0800 (PST)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 12411304EB;
	Wed, 21 Jan 2015 17:33:04 -0500 (EST)
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0678C304EA;
	Wed, 21 Jan 2015 17:33:04 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7E265304E8;
	Wed, 21 Jan 2015 17:33:03 -0500 (EST)
In-Reply-To: <54BAF1C2.60103@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershausen?=
 =?utf-8?Q?=22's?= message of
	"Sun, 18 Jan 2015 00:35:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7666D76A-A1BD-11E4-9BD6-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262774>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Hm, being one day offline and there are lots of ideas and
> new patches, I like that.
> I run these test under msys and cygwin on latest pu (a3dc223ff234481356c)=
:
> ...
> (msys passes or skips all)
>
> Without digging further, these fail on my cygwin:
> ...
> I'm not sure what is the best way forward, it seems as if CYGIN is "half =
POSIX" now.

Are you reporting differences between the state before these patches
and after, or just the fact that with these patches the named tests
break (which may or may not be broken before the patches)?

--=20
--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github =
accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den

---=20
You received this message because you are subscribed to the Google Groups "=
Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
