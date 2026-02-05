Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F340D35581F
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 11:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770290461; cv=pass; b=W0e+4PFuUv7APFBn2BPnXZUs5n6WfLxLCOzIlsrM1vSIOd/1dLOL8SV4Vw0wC3YmxIs6xp+oFwpG5fDHMBRTFTUWYtlOj1NQn3l7yczg8nY/AlHhPLHZOeaTNrbaOF2Tj1loazg6W//8SSjnfOO0rNl52iFGyH1ssXjJChuTzoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770290461; c=relaxed/simple;
	bh=gTF6kRCU9K17TdI10QMiS2xDr+dkw9/2R18jYMbwOqo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lTKc3Wx13oDBkZE/ddtL0aW79KywiaOMuZTHlaJLnDNa3q6bGoDMqhvzHsLFYhTriTluiLYaPJDCaw1GLoDwATQlMm/D0iBh9J/j2Yp2jCSKXzh9fXcM/ZILd9Vqp5VuGOX7aRZdCmE29YtVYFf6JIASzSmwxYUYZLUqAgpKUJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVu98nS+; arc=pass smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVu98nS+"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5ecddf73062so485521137.1
        for <git@vger.kernel.org>; Thu, 05 Feb 2026 03:21:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770290460; cv=none;
        d=google.com; s=arc-20240605;
        b=ly9uOpu1WtbtjRrcCNuIbTJusO3O5L9Q95d1hbDjXNtyR8X0mVCSeOboBQKMzAkSuh
         x2l/JxigjzH16MZStc6xY4REqUbCmsGY9XJnRlX8iIgVK6/luFBcUQ4DyZpod9rQ5aCz
         1+biz4LRqklb0tfp+Juju0LpXjE/UOtHmPzAtLCq5lZlXA2wW36FoUxdbmYLRf02cVNC
         dlvkBK6yXXKou6o+LYOuy/DiNf87dAVm88+o3VyGO8QsG4ss2rnCY3DmNcMm3oEUAuJE
         IVg2U53Ob8yLQNdbmf2NEhKRSCVPPOalkT7PUpmSHscschYGlUbdfhHtF52i8qXvrKPR
         r0vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=+WPQlq+9IbSOubp5oCjBhz4mumhQLZAsTWWucFLTp+4=;
        fh=5qca7/jlTeJ+EQxzugJG47P9PlCzUHj/yIqbONCC4Hw=;
        b=X2AkjLRX5S8MMj2M/hqgJb9BxSWdAF9Y0ReTmHug5a942vLzd7+qXYb9Z/jPQKmFMh
         yQTNjsbY/AGbGUr/g/4Qf4y8r9EEV3nuQDWrH5wWArmBPr4Sw9bo+WeVAp+GR/alZmRO
         F98Uxt3cyN/7Jrr66Om6LQkEHVPzfeExtwp4byieoA0FZDi481tRxEr0B6utcDhFcGu5
         GM8n04D4FrP2MNKsiTyylMaiwA0lTX6ezdacRhhC2XHEDsn9w/wXQbwINEQ4TvdVZ76I
         DdtSHCJ4RAvx/w3PUnKtQU+3cJin10z3ogW7lQCnw0grkRGXu/OD0b627ergreMxNYbV
         VaAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770290460; x=1770895260; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+WPQlq+9IbSOubp5oCjBhz4mumhQLZAsTWWucFLTp+4=;
        b=SVu98nS+BIXsy4eS3v5K5of8CE2u7S50/MunVROvEgupO7Tg6TJnTFOM6Fy8zUYJ9h
         QRwsbhIMSj4oRilr/EN1IvgRihZrDpWNo3pcOiyak/HHjV1lpoWxRdetf0nboK1RCS00
         tAM1HUCxSFmv5nuxz3SNNpZoS4wwb82MjaNVTmkeKxjN6rrzAV/Pqpys1DLkEUImbRdA
         kUyHu3F3SqvlP6y9vdLtZr+0f04xq5vQ8iuPDVlI1teql/sQQGsuyZnQsgVWsFuqmN9H
         OZLN99MYhNUQ2mxJYAoiBeOT5Y8VgbSHe0SMWRj9rlClEYdmrmRBy77yH4evS9mHH+eN
         1daw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770290460; x=1770895260;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+WPQlq+9IbSOubp5oCjBhz4mumhQLZAsTWWucFLTp+4=;
        b=sUbzzKpzxQmjiFb3L1PD7xbKTZUTGVaOLJCcPzufW0yBDETQigDyTI0Af3QffcSPx1
         rARau6Q5sQjb1inT3JlngP+7z09kuon4Kx+1dtz35AGqMgyRuaGE/WNm4Apa4IP6ROsl
         RlvXpBj9i4cI4QbwgnHscmn8bmdurwxpwnE69Qy88h2LXW5M48io6raelc8Dng1jNk1d
         C/XoKX9TW+tjYmK87dlXnCOyyYhvZIQgvVxc45H/Qjp3yQVXC4LJgygcmX+gcaMYC+Ka
         KXFHIuceXPUwAXq7/jHTpQxW7c2GmQJNzYkAieNkAG3Ka0RJCZF9jDDYgPyNmTHzFO5W
         Jm8w==
X-Gm-Message-State: AOJu0YyOtTus21YdIPAcqlhF4ZoyUixqm3oVGvdk+y9zneGFAOSu0JAj
	8l2CzOP4UM/Khu7dFLLjRfqr03Wu5YDz9p4b5hFYfmKlTxIO+JezCUq8yAGPDTr9sK1tuA1uR0M
	lBPshJlXaJ2DPuVG1N0WgUejh0xfUmG0=
X-Gm-Gg: AZuq6aK5nP5/BbbFZekeIxW0myI/Wcu8K8nqhsmAsOGPY6yT5bCmtPbTuxk5NArBb2y
	rA7RAIQWltKPm3tGw8YPsTp41mQE0GIPWJPNAbglEgBPkOmXxOZzoCiw2lMtNr6PjusieNlC0Ac
	z3ePYlqR3o1ydQwIR563WSXYiLzaXMCkzKUH93NjdPNXfl70297cHd/npt2N3KOTVsoJXITcgXO
	mBWOKuoeb9VWEfVZrag3xFWTTnVjENBFLLjJuu9XuNqyR8diR8Md4j8Cv18rRiZffUJTu9rReWt
	2B2Gt/GgRYmREi8C8pLkF5ShckMGeg==
X-Received: by 2002:a05:6102:3f42:b0:5ee:a6f8:f93b with SMTP id
 ada2fe7eead31-5f94cfedc5dmr1014446137.2.1770290459814; Thu, 05 Feb 2026
 03:20:59 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Feb 2026 06:20:57 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Feb 2026 06:20:57 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aYOCm3vzfDmnZhhu@denethor>
References: <20260128234519.2721179-1-jltobler@gmail.com> <20260203001002.2500198-1-jltobler@gmail.com>
 <20260203001002.2500198-4-jltobler@gmail.com> <CAOLa=ZRb1eVSD42Obr_m+3KUy0Bh=0XmOZt8ofrbzy4Mp8xfwQ@mail.gmail.com>
 <aYOCm3vzfDmnZhhu@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 5 Feb 2026 06:20:57 -0500
X-Gm-Features: AZwV_QjSSHKCAVdB14Gez_wKAXamSEg_1WVJCDqT32RLnq2C_jhYJ6cpZC_s1jM
Message-ID: <CAOLa=ZSdU5jRqQhaehvqnVebcXT8TiMqCdSSqFYEh5XVJtrNdA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] odb: prepare `struct odb_transaction` to become generic
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, gitster@pobox.com
Content-Type: multipart/mixed; boundary="00000000000001c034064a11de36"

--00000000000001c034064a11de36
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

> On 26/02/04 02:31AM, Karthik Nayak wrote:
>> Justin Tobler <jltobler@gmail.com> writes:
>>
>> [snip]
>>
>> > +
>> > +/*
>> > + * A transaction may be started for an object database prior to writing new
>> > + * objects via odb_transaction_begin(). These objects are not committed until
>> > + * odb_transaction_commit() is invoked. Only a single transaction may be pending
>> > + * at a time.
>> > + *
>> > + * Each ODB source is expected to implement its own transaction handling.
>> > + */
>> >  struct odb_transaction;
>>
>> Nit: Wouldn't it be nicer to just the below `struct odb_transaction`
>> here and drop this line?
>
> I assume you mean drop the typedef in favor of defining it directly in
> the struct and thus removing the need for the forward declation. I kind
> of like having a typedef for the function callback, but I don't feel too
> strongly either way. I've ammended locally, but will hold off from
> sending another version unless there is other feedback.
>

All good.

>> > +typedef void (*odb_transaction_commit_fn)(struct odb_transaction *transaction);
>> > +struct odb_transaction {
>> > +	/* The ODB source the transaction is opened against. */
>> > +	struct odb_source *source;
>> > +
>> > +	/* The ODB source specific callback invoked to commit a transaction. */
>> > +	odb_transaction_commit_fn commit;
>> > +};
>> >
>> >  /*
>> >   * The object database encapsulates access to objects in a repository. It
>> > --
>> > 2.52.0.373.g68cb7f9e92
>>
>> Just a question in general, is the idea to eventually also add support
>> for {prepare, rollback} within odb transactions?
>
> I'm not quite sure yet about "prepare", but certainly an "abort" or
> "rollback" will be introduced in a followup series. This will be useful
> as we expand ODB transaction usage to other operations that require the
> ability to remove temporary objects such as remerge-diffs.
>

Alright.

--00000000000001c034064a11de36
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: ef4830e13e1c6eed_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tRWZSY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNWF5Qy85OUJsNUFxMVJLUk9iNVF3Vk9HTGNyMDhqZwpHVVlUaWZSMjdn
K1J6N0xBR3dSTWNod2hNV2JtYVN6dkVzdGYyb3VsSDVKRkQ3cStnakVKNXJtWUNVcnkwRVpyClgy
Z0kxV3FhL0cvSC8rZkNwbEhEY0c2TFBkU0xmN0NleDJ0TktPNG9OdW84UE5uc3VXOHEyQmdYajNV
UmdJdDYKVGcvMlp5eVYvek92VzJRVjlNR25LVkxxRFZDMWhSaHdhbXY2NVVjUGRrVTkxMzk4dkV6
RzU0VlcrN3N5WGhEawovbEh3djR4eXNNYTJOK3NCeFVBNnY3RHFrbkpET1hlamlsRHNBTTlXSC82
QStMNythZGI1YXJZL2ZYU2xFcGdwCkVUQnpWRXhORXJGT2JXM1RRNGw0MUl3T2ozSjhoVDVWOXEy
K3F4Ni9zU2xtVHZ0U1JxQmUrK2p2SEl3N2gvczcKL2xLNzVHOFJ4WFhYb0o0RHJ2RXoxZnZ6RkFD
VkxjN3huTmlYekx5ZzJ0MGQ0Ui9qQ28yTkRqdVRjTkR6NDljTwp2K1FmZmJMQ0h1ME4xd1RaNlMz
UnNFRFQyR2FIZzRkZkFKUlBnd0QycEtteTlwbWRmRkN2c3hNd1BLTWl0U2o0CndOYzlSREY0UzZ6
eWNwQW15S01CT2UxaWM4VDcxcm1Lb0FaejhuTT0KPVBYdFkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000001c034064a11de36--
