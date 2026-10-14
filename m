Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF9C37BE7F
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 11:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791976397; cv=pass; b=RB/Ef1b1hOKBigQNOwHqEDylq67Z4C2R6B5HnEIRknxenubPmh3WQE1n7+Gsq+Mb3nwNFXATBfVycW41T848ZjqHrhUW7mZWkAJESUN+RG/y07BKB1QVOlEgn0BnKpgwIJrRLXb+J9ehQCgyEUiTRrSWbZKoX9sOdErOsHrZGAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791976397; c=relaxed/simple;
	bh=cfw3+94mQpoMP+0VoIislLphzB4BW6+nlf5oFZdUSr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E0LkHSUY7GesF8mbV5XVglMTtaBSa7Wzq+yXxl5LjER5cEAqtW+zt5RpglAJkcoNKnznTmH4sx9z5mozdIxdeEkqEdsz5DsGvV4qvFj6jR9BG2JArdVhRYkMZw6Ro4iJoaPcE+ZvVJurpvRlsN2A4IQ44Dt1mU7ZVRLMGevW9sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctVUtwOH; arc=pass smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctVUtwOH"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-8244537ab76so1794111a34.2
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 04:13:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791976395; cv=none;
        d=google.com; s=arc-20260327;
        b=En76JkyMkpSgWQAYReKqXvplGyj/LjGIdch6n4zZ+eHziMWPGhDLJyksw2av14jBwb
         UR9spC+CPwvptO1Mx+MLyq7cgPVEiLrOEEXsYFDtP3mLAEdK8KRX1rOH3BSfxrbSAIn+
         5oy3Q6+s0++9x0jFg/qTr3yOc5gLujgTCkKRVHtMqHMMxMvhJONulgHEg9qI0zgvKe+2
         MC+fFnlJLw3OcWQN0MP5Gm3sQ7fyNjBAfBB9AW21Fey3zqVB+4y4hWYJRYeG3XLK/YIV
         2EPtgusB/ZEU4tgD37FgkLANx+IFDB4WQSIkW8EuW1neVrPh0LWF7vZsFysbd1k9iov4
         p0Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=87Wo2KlkpLwxbCtZDQ7uva5Tt7SXFRn7Nkk0J74H9h4=;
        fh=xct+iGG4b1LwuXoxK5VB4+y71YE7hTgcJFCPJmdmGL8=;
        b=LNJ9lWGlHuJRGYGzgqbWFXgjZk1jCZCt37fRxlGaggynuUFrtkwca1WHoX+xh/7HLO
         lourBHDvFGfR+JMwI6ZsClz4kuhqcTRPF1mvRpYgMG8X/nE5XhYae7BNGpapHRY7Su9a
         5Ws1fX3OVgKpLgwaqfZIBwytOlVZgCKqpM5HOJ2bM8rWbGjYyBMQZkJNawLoCnaCRRFv
         54xqcSCT0oNhU21G7SdyP6Y5z5x5/3PLEFQ9NiuI+lkKDFIXcu06nZUqqd78zP32wCHe
         1D5ORvXwZFHgSL9YSTczNEHK3Zpv4BpYwCXnRmyeO6BA2UYiJe5C8s3ADPPzz+IuwvHQ
         yanQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791976395; x=1792581195; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=87Wo2KlkpLwxbCtZDQ7uva5Tt7SXFRn7Nkk0J74H9h4=;
        b=ctVUtwOHvprOnhWQpPE0reo7VtxpFflfcOLkISO++N/8GIIZTGlDe3OvWWA5l3QzpZ
         7ZDosJQCo6BNXSLCdomTZogNJO8aWSEsiNDsrQ1Pj8Dteimk2PbFdEb7tvipTQreGwhX
         DN0hCHPd9mMIOSrm8m2go0iG9Ts/32NNvOiKIgm3tbksCtmG59lxm2gbCTgvBEY4Qo6Z
         cTb5OiM/VQ0PpeW3Nax7hJL/un9FlJCkUhkZQfKJL1Bcrg6V0M6HgUHtIs7P0ijVCbJu
         nfkOkbOFvPV/efMQajcQmW0RaxBmleN37M/8uMyREgZhMS7seQwGNN8hkuF0IARzS51Q
         f+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791976395; x=1792581195;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=87Wo2KlkpLwxbCtZDQ7uva5Tt7SXFRn7Nkk0J74H9h4=;
        b=0o3jZY45xvI4B+L7cdKQ14+616uGEMBCCT9gJm4kqqa92hdqipd1gjzCMubU0sF6yA
         OfuRyWgtVtpJgxU6rVbN3tUhlt02PoGA7bgOLFckXidCwXmWxQhDF8uk3rLrmfCIyCkQ
         1kr8oek82msJi/IIyCPK3hFJ7sYQ4Tc4U/g2sx44YQyj66UJsNsQ3YktEW+/IEJYVFN6
         +KPDbIXkyfaUkN/IHPPQE9dkHM4rlK/+ZprjBVS1GaZ1hipuXY93/nhTlyiap9TqYANx
         6ke9LzwUI9KnvBV2skVTJEHV7ZYhK85VwSSIR/4+hB2xG8vR379sRGOqofRm2Ksi9TNJ
         +pIQ==
X-Gm-Message-State: AFq9FYJxWcdu8pLpyQybM4wW2+NXChp8Bl6uq6YmeOJbV9Ett1VF/iiN
	p3AFNoOxjiUWGXHaIQnw0vDKDzSLZU1BGF5qw48pxGNVzV12jqSouTiskkHN1SeDjF4F6TI+09/
	eSPKmfyMB0ii7LfuqkylnDOFwuE2onTQ=
X-Gm-Gg: AYBFou2PfYoqxF3ijsr7ARsXFdkJiNEg2eEAeTlKWUQM9UTNEO9Papr1vcFS9xqbwcr
	S/8PKRvuQFFw8XrtJQpT4xSxzuinlcBfnEnnZX/blqo6Dq99ibsu53qHp2hS2xQ2g0CcK15QBqT
	b6rCoIo5QtAeQ4fkLg7Q5kXitgqpDfy8sQI3FktNVDmOcEa5LXmsFRqaz/M1hWesoTqMDr1L0b+
	H+jxG7YBUfif5tsmUOo9Jtb5usVkoFQ1m3B31arDy5s6SKANFPJCeSbhlO+A8FU0HL28Q723Ynw
	avH/WISM8sdYkVnDYw7flS+DBhcCkfXRUhmpXpGMr/Me1E+C57XJpkD7wrs5eRxwPIiaSK+bt50
	nxkuezj7J09wM1HlIfr6XEikxEapjTdtzI5TG8Yrm0Ut15/JnHVvu7Ansq+kk+XjnYTDIta8DQ0
	yV/uSNZoGyTAxg6kFbcwSSp1b4j0WlmCmxiMMmDgyZyY8josDIAHq7mdA=
X-Received: by 2002:a05:6808:4495:b0:4d6:9293:9bc3 with SMTP id
 5614622812f47-50c592a3a14mr12287365b6e.61.1791976394747; Wed, 14 Oct 2026
 04:13:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014081209.61966-1-okhuomonajayi54@gmail.com>
 <CAPSxiM8xEA5zAUb_Wd0M0=PGD44XeS7=NX0vsdMcyid8-EOV+g@mail.gmail.com>
 <CAFpMFfBVSaGSoFfw9pfOcDWMKnLwnpMSyT51Nu7f-ZXE2NyxZA@mail.gmail.com> <CAPSxiM8NTdJo8TeSYNis20F0JNkTDwXn0hu_ukMkz0uQrsJW+w@mail.gmail.com>
In-Reply-To: <CAPSxiM8NTdJo8TeSYNis20F0JNkTDwXn0hu_ukMkz0uQrsJW+w@mail.gmail.com>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Wed, 14 Oct 2026 12:12:52 +0100
X-Gm-Features: AclHuK-syWVifbndzr7CyLKZqBp48Y91kyURMsxy6X4LlmaG93CdTK8InJQ8CLw
Message-ID: <CAFpMFfB57cWn5WWjeRwKEDsAOSfs18HD99mZanKED0_YL6yVyw@mail.gmail.com>
Subject: Re: [Outreachy PATCH] diffcore-break: remove USE_THE_REPOSITORY_VARIABLE
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	siddharthasthana31@gmail.com, kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 12:11=E2=80=AFPM Usman Akinyemi
<usmanakinyemi202@gmail.com> wrote:
> > Thanks for the review.
> > I meant that since the USE_THE_REPOSITORY_VARIABLE has been removed, an=
y
> > future use of  the_repository without adding the
> > USE_THE_REPOSITORY_VARIABLE macro would fail to compile.
> > I see that my statement above is not clear, I would modify the
> > wordings and send in a v2.
> You do not need to add that. That is literally like explaining if and
> else statements
> in the commit message. It is not needed.
>
> Thanks.

Yeah, i would take it out of the commit message in my v2
Thanks
