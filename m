Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A24F350298
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 03:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792120792; cv=pass; b=oTC5QTZd0jAA04Se8K5P7CS1xd9coo72ooBeRGcIRdOApFicQJgfCL+0hruMfqkg24LkL4YWSnrNoPz3MrTbPsLUP4RqaO+OLqXK+87TREQYuXLTlDu2HIO/VbrOKSgoDsnYwsxx+fihiV/A0nB2U0mpnoMh+YtN7RUyUNEg7tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792120792; c=relaxed/simple;
	bh=KV4guPWBodcgpG/mH5qncBeRMNzrkLt378fZ+fE79Jw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WI1Asa5GpqgD57rvpPcyxjCMSrsbvvhYlpsmQP2TGIfjvyoCS0GjD9HuhRdqdEVDMTKjaz15VcoQDDOLJ0LXiX08/1/bEFDCDUMMYOrUPlBikKSLaDVLNoI3yCuLPl1PpCV0v5oznNMPJHnaDz06EVSSdxoaIUV1x1TA+BDn9gE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3nSsrXH; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3nSsrXH"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1419d3416ceso4870120c88.0
        for <git@vger.kernel.org>; Thu, 15 Oct 2026 20:19:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792120791; cv=none;
        d=google.com; s=arc-20260327;
        b=gm49hhjOPWEanAxioK7C7BxZjywiF+ZjqHXOfRevy7HgiCOBAJzLsmR0mAjkrIO4Wz
         m+T7B4GrCQX1lgYqYek4jCUV8XSw+pTw3J5/122TyXC1pqOtbGHDhsrPrgRr/PD/BjHO
         HIi39A8jxySdHr4nTSSl0TFVS5aRcgDm83MHANpEQnk+s17Ax9NRWIO9SUiLEwpONOXG
         x1A+UPjwYMeai6lASkeF17hTKNMaZ5rxIccuMADF1TfPj64SG5zlMnlUsQS46YHRxDNH
         QMy6Nf1cLLIF0xE2+u/HwSyHkvPmDBjiAWh3PzJlYM9w/jvcQam5a6B+ewbxlF7Vw38F
         RXfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bCOSKoVfV7Z44XkrvZVVb5srbRvBJQXTmFJg83KEouw=;
        fh=P8ybVzpT9aE10NOVqSs39E3YeinjaU01S2GYVMjDXRw=;
        b=iSYIjKf9QsZ7gxQmqxgiraQLBOTO3ZPnW3GBtNoOZXyErFTeVw6vGD9SCOVXl8l3I4
         21HXEOnAsuVdk1yTl2/oUg75N/ReyWM0CbwZc4Rth7iYiLcgPGS3pw4/sKp0N+khGgH6
         JTHEc6Grt76j6sqLYkEDnUkaDTl8hSIhvUz5B6y6Ky2XGXopbZOzGoG1ejs0QON1F1ID
         yIJbsYKsuDWiguX+aCHKr4jlr9KQmbBah2EvF80dEXEVC9MVmBYBEP7ynv+PFZ9KGPxo
         oOUYRWzQSI7Yow8dQP1KinMTp0ClbTd5MD39LmzwzQ5Cds6rpfwvz5yQEwQYvJovDzau
         Sh+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792120790; x=1792725590; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bCOSKoVfV7Z44XkrvZVVb5srbRvBJQXTmFJg83KEouw=;
        b=W3nSsrXHGKtiWnI2kbbnCbYClImbNRl+amBju9xCpI3bwK+DBi2CsEOGEJdjnxUhW7
         9Pfr7+RZQLU9WkwihdOweJ4TBEncu0KQvzW6R/DpUQjm0UYO/fRAvTy4kG6Rq+ZdcwYU
         mEVX8vNot/5dLsLGOgbGUwEW3/MLZiDwB8KNxxnc0siVNh4W4UN2y3Rg2O5Uuj4kptQH
         b9et/aTS6xJAXgIMSQc99YmKmNPm2mwNcqGt7bWk2FoWnIxgnLovgXeCbuKVd6mLENC1
         8dUm/0c+875BgqyKfgz5SSU8CPjbuxP/SYrn5oKTYlHqkSY2XWiccY/nAsEygX3jkkkq
         VOWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792120791; x=1792725591;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bCOSKoVfV7Z44XkrvZVVb5srbRvBJQXTmFJg83KEouw=;
        b=yHa0p4S4BDR5VSb7PLXsAJYfa3Kg8XrpVKOP5X2L72od/bxilNjUEa5fJmWeeFtB6K
         gmLyLjCcdBkULjNZ5q7d+01yuyEZybUcvgHiNu457V9TRajW5Fuc2vFgfnYS6R9U+GNf
         X/Q7pUOnK1UkaliZL5nyXWql9VtpukHeCTvBQp6ERMGv70BOBopEfOJDqwQGZRGni58Q
         xjlVyMQrdCutj4ryglmwq23TL7BAsqVOiT3NET20kiTNJrS6iwvBL13aCziGSM5GI/ED
         VG9tc4CurrCRoVOyIVl/NjXAfWLs9xc5QHbYlugdP6sGsYbd9b/8Fc7VNB8XmV8WI21n
         CqHQ==
X-Forwarded-Encrypted: i=1; AKwUvBweJIn03AUwUoe7S9/1WMk/Ot5WjU4xqnGMceRIcco03ljDO5inKBVz5lWRi9St/vDcBnc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLtoy1YL8qcw31mHLhrE3PPT4DcpwC9cgOxcoFJa3QUCfWT4rKP
	uMo5unDmMSI9aFiit9KMyiIp9kSS1jLRKJkZOdo4my8QwvPk38cQzv1egGwexHOL1KGO4EoR9dM
	JxqReUpSj7mXtAHOfnOeglFeMPg1/qY0=
X-Gm-Gg: AYBFou2j817huZSfYjcvi24s/CtXYTrvCOiFC5zfpluY+9EYusnpqr/1SyDKjynT1Iv
	acu25xRyE3/gY6LE/rWlJMeHMdnB3VzKmObeIcap09CdXep9whysfj9rhJdqUPYQ/OQ1ZEevlyt
	7sP3/n/3uG0wQTTsvg35lMOt9mC2kq3IfuICf0eF8Nslh+OewZPezZzDqk6tVRCK8oi0Zmlpwrk
	s3b6PVOdAOspcOb70HrjahqxuLGbwrmPJlRlhxJ5ARkTGJVJ11jSrzAa6JMn1kVvOB8LYEFmKDg
	W0hbffpqhXkGZIcapHzAsG7IfZFPN2KrMXQtQQdAsuM0sZkNZWue+0DkYAEZqvj1+BwrHeSf/Wf
	OJnAnBlXoHU5PS5+ZOmXf0hyrErBHJ7qfoKpKu+4xo/jL/0riGcG+
X-Received: by 2002:a05:7023:908:b0:143:8860:afa1 with SMTP id
 a92af1059eb24-16a63386a1emr31786141c88.46.1792120790494; Thu, 15 Oct 2026
 20:19:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2258.git.1792067455341.gitgitgadget@gmail.com>
 <20261015133624.82112-1-haraldnordgren@gmail.com> <xmqqse26n5fa.fsf@gitster.g>
 <CAHwyqnWX-3NXtFkKZvKeGweNqYFOp+A5NLgf+aO2iuwg_c2t7Q@mail.gmail.com> <CAFuK-obau8UkmVVs0xkuwjddkqftMxwcGnGR640YqjswGrTj3Q@mail.gmail.com>
In-Reply-To: <CAFuK-obau8UkmVVs0xkuwjddkqftMxwcGnGR640YqjswGrTj3Q@mail.gmail.com>
From: Venkat Ragavan <mail2venkat21@gmail.com>
Date: Fri, 16 Oct 2026 08:49:38 +0530
X-Gm-Features: AclHuK8TiwUBzh_Xwh9kDuX1sG0T8P98YMlXnnJwulyioI1RpZcprttloH7_xt8
Message-ID: <CAFuK-oarU1rZOcDzYr=YA1SNvfAzyB6LaXXCjtZV6WWGswOnyw@mail.gmail.com>
Subject: Re: [PATCH] refs: fix loose-ref seeking across directory boundaries
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, gitgitgadget@gmail.com, git@vger.kernel.org, 
	karthik.188@gmail.com, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[Resending as plain text after the mailing list rejected the HTML version.]

> I realize now that I didn't read the code properly. I didn't expect to
> see a loop encapsulating a call to test_expect_success. That explains
> the if case as well.

Thanks for following up, and thanks Junio for explaining the setup. Since
the loop intentionally exercises loose, packed, and mixed ref layouts, I'll
leave the test unchanged.


On Fri, Oct 16, 2026 at 8:47=E2=80=AFAM Venkat Ragavan <mail2venkat21@gmail=
.com> wrote:
>
> > I realize now that I didn't read the code properly. I didn't expect to
> > see a loop encapsulating a call to test_expect_success. That explains
> > the if case as well.
>
> Thanks for following up, and thanks Junio for explaining the setup. Since
> the loop intentionally exercises loose, packed, and mixed ref layouts, I=
=E2=80=99ll
> leave the test unchanged.
>
> On Fri, Oct 16, 2026 at 2:47=E2=80=AFAM Harald Nordgren <haraldnordgren@g=
mail.com> wrote:
>>
>> > > The general idea looks sound.
>> > >
>> > >> +                    if test "$storage" =3D mixed
>> > >> +                    then
>> > >> +                            git pack-refs --all || return 1
>> > >> +                    fi &&
>> > >
>> > > I don't see any reason why a test would need an if block, we know wh=
at data we
>> > > expect, no?
>> >
>> > This is three tests implemented as a single test with a for-loop
>> > around it.  The variable instructs the single test_expect_success
>> > to behave slightly differently depending on its setting.
>>
>> I realize now that I didn't read the code properly. I didn't expect to
>> see a loop encapsulating a call to test_expect_success. That explains
>> the if case as well.
>>
>>
>> Harald
