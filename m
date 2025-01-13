Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED4B1C549F
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 20:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736798865; cv=none; b=RT5XgM2wQEqA7/OfXerhkvSfOJ32yJUItUb2vhprT9pX6d8fIgL+d7KK7QlRXbJlGF5T5GeHJN9XlFJv7gVHunkfeBYEx04w1UgKnWN11Gmqkbw2ANG5u4eSHzG4qQD0fvz9vlCRXGteuapj2SWLbhFYIPGYR1qqKroXxEpoioM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736798865; c=relaxed/simple;
	bh=scNnmvI6RR6bwuvKQGYJUdzKxkcoMX/JammbTvTW7QE=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=ssg0iGbbQLhtsxqcAWDhkyL7SEsgcqCVGLvQBvgicSazfkUP+N/3d3Ip8COXcEfCtFbITZwCF6lgA6LQU93iGqODeipKG/F4otsOsZ1CB0wEq/gfBT90rDgF+gQol48Igf8Udz2fH5gxyxYMXavKhaxv0JYqp6/nu8on/t67BYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 50DK75Dd2877041
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 20:07:06 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>,
        "'Usman Akinyemi'" <usmanakinyemi202@gmail.com>
Cc: <git@vger.kernel.org>, <christian.couder@gmail.com>, <ps@pks.im>,
        <johncai86@gmail.com>, <Johannes.Schindelin@gmx.de>, <me@ttaylorr.com>,
        <phillip.wood@dunelm.org.uk>,
        "'Christian Couder'" <chriscool@tuxfamily.org>
References: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>	<20250106103713.1452035-4-usmanakinyemi202@gmail.com>	<xmqqfrlvzzcd.fsf@gitster.g>	<CAPSxiM_0h7OyQO-Of8YhcOt4KbtuoKXe111ZCvsLf5y+OgCHaw@mail.gmail.com>	<xmqq1pxdnuxo.fsf@gitster.g>	<CAPSxiM93qVjoDGBRaGAv1-o3oiKkEE0mtH9ERTN9dVxvZpCczw@mail.gmail.com>	<xmqq5xmokn0z.fsf@gitster.g>	<CAPSxiM8KYpmoSYaWciF_KrtHhUTPj543q9mgio+qdeB-FHeDUQ@mail.gmail.com>	<xmqqldvi5v5v.fsf@gitster.g>	<CAPSxiM8kWoAXEvAVtp0C9NUQaas3KN=TMBA-p9o6+8KDQbmBUA@mail.gmail.com>	<xmqqmsfubtt8.fsf@gitster.g>	<CAPSxiM93asot47GgfK3ExNWd9M-4fjbWzRWQ=koCFdA8rNwD7g@mail.gmail.com> <xmqqfrlm8pim.fsf@gitster.g>
In-Reply-To: <xmqqfrlm8pim.fsf@gitster.g>
Subject: RE: [PATCH 3/4] connect: advertise OS version
Date: Mon, 13 Jan 2025 15:07:00 -0500
Organization: Nexbridge Inc.
Message-ID: <033a01db65f6$b88d4db0$29a7e910$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQL1iKQeqDpt8guF+jE2EcHccRlcdgJILRDnAcvCYH8CsUaxuQJTXpHeAtMPW6oCstvxTQHFooTNAlc05cUB+jC+DQKjTcH/AgsCJXIBZe3p7rAKjLUA
Content-Language: en-ca
X-Antivirus: Norton (VPS 250113-4, 1/13/2025), Outbound message
X-Antivirus-Status: Clean

On January 13, 2025 2:47 PM, Junio C Hamano wrote:
>Usman Akinyemi <usmanakinyemi202@gmail.com> writes:
>
>> On Mon, Jan 13, 2025 at 9:16=E2=80=AFPM Junio C Hamano =
<gitster@pobox.com> wrote:
>>>
>>> Usman Akinyemi <usmanakinyemi202@gmail.com> writes:
>>>
>>> > Actually, in this patch series, there is a config option called
>>> > `osVersion.command` The specified command will be run and the
>>> > output will be used as the value for `os-version` capability.
>>>
>>> That is essentially a "you can throw at us any arbitrary string".
>>> So my recommendation would not change.  .format would not give us
>>> much _additional_ value in such a case.
>> Hi Junio,
>>
>> Thanks for this.  So, from what I understand, the feature and config
>> option introduced by this patch series is enough, no need to =
introduce
>> another .format config. Right ?
>
>Yup.
>
>At least until we and our userbase gain more experience with the =
feature.

My thought on this is somehow relating uname -? (something) with the =
format
code. Options to uname are not always standard and there are extensions, =
so
there might be some use in having a binding for non-standard stuff. For =
example,
on NonStop, uname -r returns the major OS level, and uname -v returns =
the
minor level. My thought on this is .format R=3Duname -r, .format =
V=3Duname -v, or
something like that. But as you said, it will take time for us to get =
experience
with this.

--Randall

