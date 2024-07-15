Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EB03B796
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 16:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721059669; cv=none; b=MeprUWVG/SK3yuqXiB0xd7skxHwZRwOgcIPghJhPMIP7ptt/QCrv2KypaQbQci4QpQRib8E51MCtGjYdU90bCumjwBTd8eUGksngAHckyqB96Tdw4vRP8FcXNiny5UID2ik06M4njC44vwabSR/TzRkpbvrFpIqWR0j/Eun8fmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721059669; c=relaxed/simple;
	bh=cFUWZHYuiSEbiOu3xKqIyu0+V6gUtzPs/5JPjfV/+dA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HzgHWnPeuJvhk0XgC1gGue24/eh6LsZDTuHr2Oc3zILCmQsNgEcBaBnJZXHLTfKTRxU44mQZrj23F24NyHRr27QQsw9+Xn2wcX65jJmP4x+A8b+SZScs62Lwo+J/ayy6dV2hwcY+Amy1PbJoMxhMZO0Oo268RyHqMoBkUTJ2bUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HhjbcmIi; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhjbcmIi"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2eede876fcbso24447111fa.2
        for <git@vger.kernel.org>; Mon, 15 Jul 2024 09:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721059666; x=1721664466; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=p8s8GfIBTpb4nfhVbkrM1KmNCh6OA8NC3KtQt3+UNA0=;
        b=HhjbcmIiMVD7QezKIqhc9zpS6eLK9IL8WiRC66EtaxOJiYxXFaOfr5OtEIHudH+trp
         dsPK6Iw2HBbaWOw0xt0nfPll6HFOmEfgIbs3Wbu5C/iZTLPn/FjFpU/OjA/B/hVwaKld
         yCrArAg/ep6EhQrcPFH5vfLUTN3d5LODgtgvNVKrN5YxjTa11EVSD/iOuK8gMSmylVah
         K1D1E119lwwkLgxdEjNpfIx+pjBg2pbrZF5EaNVFFlgXa9aTDm/SycNQt6xSuxQu3N9s
         EWDU0+0sLDsAJNhg3pMOHrsSB1lFd/AhtdWri7pkYtu6boQs0vmSpoSnEIBuqOhN7AgE
         /EAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721059666; x=1721664466;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p8s8GfIBTpb4nfhVbkrM1KmNCh6OA8NC3KtQt3+UNA0=;
        b=Dm62vN9lGeJfcY+h5pYEb3mfPmoX4CAN+c9Byjs+ODo1+NcI2Cvr7W0rhksqFo4tgz
         Vxvbwq9NK6UIne7WRVuwgbBDDnGNCFxpcyLqNZpLSoIKU5x1oJGEKais90av9Y6Yn4hu
         KDpnw5F9ejUuszyirxOWMdpZNf28d7NicgG114pQYLZBcQXKmgX0U36x5Irc5wpvwiOk
         vcJ3Sct2ysO76bCo4FMvyGMf+YpQUkjx0nvza6ncdZJtxIeEc7dAEdb4JTEZAQrCCcD+
         3F2p85QqF1dKQ+fMXCQPicfdCCLMfV4LNAUW1lZelOtb+UH1GHWtKFd/pCCv1X4NZQGx
         gZHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWp9BplZ5Pp4M9S5NjQe6a8dKl53G96U8lINtORj5WxR2Z9AUjXKz7Rnj99iBY0lixD7vZllLN+8kBWkAHjQyhCzYy6
X-Gm-Message-State: AOJu0YzSnPNzJCTONykik+w/Bzycnt+CNPsb50o52T+NlPOcdRzYObiB
	y/BzaVY+6lOb74TWy7MWt1HrS/UpXmtK96/thmmupOAo0JCX8e75V6RXiTIu2U0okT0JKV1ekN4
	KTmkqCOx6WtUwCReIMAEY/eo0mtIucMM5
X-Google-Smtp-Source: AGHT+IEBb7RDJCMO3ezX++0UJZgkXHIM6u1+5RVqg7TWVHPJTxglHPkiUfFXG13eRuDsJEssDL2XgQMRh3dWFTCFuHA=
X-Received: by 2002:a2e:9054:0:b0:2ee:8aed:ddcd with SMTP id
 38308e7fff4ca-2eef2d6d76dmr2744071fa.2.1721059665464; Mon, 15 Jul 2024
 09:07:45 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Jul 2024 12:07:43 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqq7cdm90h7.fsf@gitster.g>
References: <20240711083043.1732288-1-karthik.188@gmail.com>
 <20240713134518.773053-1-karthik.188@gmail.com> <20240713134518.773053-9-karthik.188@gmail.com>
 <xmqqa5ilcngi.fsf@gitster.g> <CAOLa=ZTkYs_Wz2YM82Nm0yPJX8-hYV3WC-aMEqYNRoS+2ZpG3A@mail.gmail.com>
 <cccf899d-12c4-4046-a958-33374bb870c6@ramsayjones.plus.com>
 <CAOLa=ZQfhD21Anzd3wWwWcxji7tJydaiD7mrhReH5zLQdXBWng@mail.gmail.com> <xmqq7cdm90h7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 15 Jul 2024 12:07:43 -0400
Message-ID: <CAOLa=ZTjHKX3EMbVu1_bjdDez=3aODZQYY4npKrCY-7ZRXN1hQ@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] ci/style-check: add `RemoveBracesLLVM` to '.clang-format'
To: Junio C Hamano <gitster@pobox.com>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, chriscool@tuxfamily.org, 
	git@vger.kernel.org, jltobler@gmail.com, phillip.wood123@gmail.com
Content-Type: multipart/mixed; boundary="000000000000ff6934061d4b6d23"

--000000000000ff6934061d4b6d23
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Providing a path does work indeed. But we were discussing the option to
>> provide an additional path apart from the default '.clang-format'.
>
> But that is not a requirement.  The requirement is to allow us to
> use what we have in .clang-format plus one other rule.
>
> And if that requirement is met by copying the entire contents in
> .clang-format to a temporary file, adding the other one to the same
> temporary file, and then using the temporary file instead of
> .clang-format, that is fine, isn't it?

Ah right. Let me summarise:
- Method 1: Inject the extra config to '.clang-format' in the CI's job.
This is the current method.
- Method 2: Create '.clang-format-ci' to use in the CI
  - Method 2.a: The new file contains '.clang-format' + CI specific
  rules.
  - Method 2.b: The new file simply contains the new rules and we inject
  the rest in the CI's job.

I'd say methods '1' and '2.b' are similar, since they modify the tree on
the CI. So no real benefit of one over the other, no?

The issue with method '2.a' is that we have two sources of truth and we
need to ensure both files are updates always.

Since the former methods don't have any cons of maintenance apart from
seeming a bit hacky, I'd prefer that. But happy to go the other way too!

--000000000000ff6934061d4b6d23
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b778e54097b16c78_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hVlNVNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md293REFDUExKYVZJNDhTdmxJT0toNWlUei8vMjZKYwpWNUFMSkxVTWto
NlJ2TjExU2RXQkswc2pxRkxXVVBCR2tyMk90dlhjRVFQd1JiVy9USkUxNWROOUQ1Z0poTGF5ClpG
Rng1Z1pTWTRuYWRkbTZ4c0FvdnpWSlJjcVl1Um9VSzdDN1BkYUNyUWZySjNRWWVVQ3JJbHdDV25n
ZW1IZkoKKytET3RNN2xzVnZpU3VoWm9GMWtPOEovM1lQdVh1WklBWWdkWVlYOGQxQ3lBdTlvMFJr
R3NXazd1M1Q5bVc3NQpEdUczcFJyMUVXTHhWa3prK1UxL2xza05sM1VBMlpON1FFb0FYV0FZLytr
dXRVend6NkgyMnRvWU5nVGJORDVLCmpXbGY3aE90K0E0Y08zK1Zzb3FuU3YwZzIwY2plYkQwS3Ax
ZFI4ays1SE9YOXQ2WHhxci9LS2xweXV5Vzc0enkKYnNVSFpFdkJBRTVvWUxEeXd1eWpwNDUxYkhM
TGdocis1L2phODJCVE8wK0x4SlVCcjBmMXNkOWVrby90cFEvSwpBVTRPc2daWUdYazB5SEZtRlM2
QzlwYVVPcFNPMkdOVXFFR2pycm5EWXFLKzZacHl5VVVra1loVSs5SnB4aFI0CnlKRjR2WHdPV3Yy
aDF3a0g1ZDkwOGl1YUZIR0JJeDJWdHNQWWlDZz0KPXpVVU0KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ff6934061d4b6d23--
