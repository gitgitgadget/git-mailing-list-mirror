Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B953716132A
	for <git@vger.kernel.org>; Mon,  1 Sep 2025 18:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756750655; cv=none; b=ds5CcUHwZJzhi/kRBdqY3POAyFhoZQIN6V3X+r/+ybohnYkEsP6IWzeRNk0AQw4qDH4e8m1jaRHNZWAJEnE1nUanwf/eMzkDDVdDXUL16NgFIJJhXRU+fYhJAm1EATl20LswAasHnzqcSivZtiy3YC6mXtSo5Tm6zAtuH+HwVqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756750655; c=relaxed/simple;
	bh=Jjmrm6k9Gym5LB5kQ0jbR1w6KMTndnLv3Dur/tLdpjk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hbpvGzWG2u/vK0LkEcKzuZQt4XKel1WMONucPniEUtv1j2TLQihL4N0b/A4NaiimDjkTZHEuJajKDiYJwu83iI0f4Clwm2uGBtplwuCtNwWbWcAF5Pt6DaYkGI1ACxwJHiHUEnX6F3yMgUM40mccnj19/Pw0pOJ9oabYWFQBTnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VgT8fvzu; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VgT8fvzu"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-8960a00e85bso828865241.1
        for <git@vger.kernel.org>; Mon, 01 Sep 2025 11:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756750652; x=1757355452; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JO2LN8MUR2x0D/p/+MH97zWQNVQKicfQHziUm8eP1lg=;
        b=VgT8fvzumNmdgWKSUgBJUorvC2A9MBJZVj6Bjh1/VoD3kce9Xq6gZLKu/+cIu9NSyK
         Dz5vPLjhYKiPNOZKp0+d0Szz0Ymr/iLplU1Hlyfcw4GqtR5LkvQAuVaGRfHBxvqo0hZE
         pEpTAzQgmZniaHexpb/Ie60zc9BI7e4+EV7RaZIAVSTYnlL97DD3NGtAjOGU+oaZ8yEB
         yeSeKLb5PtVJfAeAWtKsmEBVSV4aqJYait7fvtqSXj/BRMGl7kQ0hUWBdyd+Mh0GJjHy
         iSUhvCRn3g5MRFhBGvFBhxmexVNFXDytHaa4OBtZc3/Q/vKqPnHfwz29rxbfzqnJRWlc
         nj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756750652; x=1757355452;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JO2LN8MUR2x0D/p/+MH97zWQNVQKicfQHziUm8eP1lg=;
        b=uG6nJt13YfYIOLESMyFqtFkLKPB20Jro2f0uZr1S0d7sgCbihFCpZZQpn1i9rImUDx
         oU4sCBtCJ+qR4PrDwP7TE/1S93kUsiEoy8IQHWn2/q3mXDp9mJ2kSAqIiYrlaHDYz/Hp
         vXsF1weC1iX5EpqR0qfbwpbCbqtahx6KhJXfkq3RSPrKmwk7ruAfe5mDF9DuHVqQp0W9
         xToBAwQ0/ce+zKKtqlByfS4DOmuhrV5iP60T3wAXyHRatuCkcmt/lFEJx/yLieouyNzT
         uT5dbhfOw6RhscNtN5LFvEP0aZlSW8dZ4rtbDjyexpMmwmS5tTwTBIT8reyPriyQw8Jm
         JLTA==
X-Forwarded-Encrypted: i=1; AJvYcCWsJV96E8fKne61PlcKT1hCsLJ4ARxDIHeFm75Nkj0WviM2TqcsTc5BNAT2FsGhk1GQiM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxemFGSJrVJEOwu1c1A7i+YoiR0CNTTMrF+JS4Mc+nMCm8L+I2C
	OBNgPiio+C+a4rrbci+KTW65JdH0zfUZBFJqT2ZdjRZnRMp3oJhlWZ3Hh7TbDsg8uWjUXbv1+Tb
	qnqF7Zv1NpWgcVWPPP/2WQmt+v5ZRX88=
X-Gm-Gg: ASbGnct16tVHrglgi+5xZd9pmLXlM1EFIsjGM2PxGONnpjN7wcVr1FVXqLMfW+lIWRn
	6pH/5WwjEse+7+mYnBT9400tEFgBVRHdxISUuui5jtOgd/WG6j5ZKmZcfEgYqkmgUFPUYfjgNBr
	b26mWBDJI36fcqvpov7kZaxYQFrNtyAnZ+D+N8PDWxWq5W+dNxaEeHdhrzn4M1L82KuEASwEhSw
	6qcybTMdqDbosPPMz7qTdzrzoEF5hjlmZWwSiF85coBJLknD/Ny
X-Google-Smtp-Source: AGHT+IG8Xt4r2bH+ljEiQ/1Uqdo2CKK3CcigingkG4RzukZiW/CSzCzVlPzTAAxAtSQ5cqPkl+BFBno2W6qQhqGwkzM=
X-Received: by 2002:a67:e707:0:b0:52a:5fc6:e50 with SMTP id
 ada2fe7eead31-52b1bd35203mr2832148137.30.1756750652516; Mon, 01 Sep 2025
 11:17:32 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 1 Sep 2025 11:17:30 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 1 Sep 2025 11:17:30 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqy0r3whe7.fsf@gitster.g>
References: <YQXPR01MB3046197EF39296549EE6DD669A33A@YQXPR01MB3046.CANPRD01.PROD.OUTLOOK.COM>
 <20250820213323.GA1667633@coredump.intra.peff.net> <aKbHozlmDIqfgkg4@pks.im>
 <20250821072706.GA2390046@coredump.intra.peff.net> <aKbwabLZiWasYoBC@pks.im>
 <xmqqwm6w3bjp.fsf@gitster.g> <aKgKmLvaHAuueJeb@pks.im> <CAOLa=ZS43w74tWjD47h2mnGiyaQWrGEY-UpL8kdXJi_zD0ASmw@mail.gmail.com>
 <xmqq8qjbxn8n.fsf@gitster.g> <CAOLa=ZRizMKRsP2wo-RJUksXAv1Hgx3XDGCO_ZGOwKpf6kAbQQ@mail.gmail.com>
 <xmqqy0r3whe7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 1 Sep 2025 11:17:30 -0700
X-Gm-Features: Ac12FXyWRU1Q7Nn-WraSTaHE_6lP1hJU_JHj1LKGu6WU-lVNtS9QGYI3DJMiC-M
Message-ID: <CAOLa=ZQgMfeJf6aQGJZ7z-3SNtCjK+so70fb0YSPOa5qLzZ7uA@mail.gmail.com>
Subject: Re: "lock file exists" when fetching in bare clone of repository
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>, Joe Drew <joe.drew@indexexchange.com>, 
	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000009a4779063dc162cf"

--0000000000009a4779063dc162cf
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> This error type is bubbled up to `files_transaction_prepare()` which
>> tries to lock each reference update by calling `lock_ref_for_update()`.
>> So if the locking fails, we check if the rejection type can be ignored,
>> which is done by calling `ref_transaction_maybe_set_rejected()`.
>>
>> Only during batched updates would errors be ignore and only for
>> non-generic errors. So this change would specifically only apply for
>> batched updates. Currently that is used by:
>>
>>     1. git fetch
>>     2. git receive-pack
>>     3. git update-ref --batch-updates
>>
>> And for all three scenarios I think it makes sense to add this in.
>
> Thanks for an extra explanation.
>
> These pieces of information would be necessary in the proposed log
> message when it becomes a real patch.

Yup. I will send it in soon. Was a bit busy last week with the OSSE and
Git mini summit.

--0000000000009a4779063dc162cf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: afe415caa5fc1949_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pMTR6a1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md3k5REFDVmR6QnhJdEUxVFhwUnNZK2MxcE5aM05KNgo3QTBzSGY0NGZB
eWZkYUhtaVRHVDNGOGFLb3c2VktSUmpvWDUxbkRuRnp5L1g1V2RmOTIrMi9ZNGRaT09mSFpDClRp
MUNEUUxTanZWazZuUWlMY3laQnRTZU5TWGhhVzVkR0tsM0tNMkNHVGtlM2RheVozNUVsTnJDOVkr
aUsva2kKa0IxM3JBQWNveCtTUDdQVUw3QklONXhXTUlDTG9ZSmw5b1k1dk5hSmhTWGVwNmFCWlFK
V1FhcWxtSHpHY04vdQpTZFJBaE5MNGRaMnJaVTNOMEZ0eHRVSVV6UWFqOVBSaml3V051cFpTSFAv
eVNoWW5XcHdXVHp3UXl0MzIxUGx3CkpxQ29qb2ZqL2oxOW5sR1ltbG1xVXdsQ2hNRzFZa2dyczFE
UzVtaGp2WXJUNW1wa3hhQWxGVWx5ekd4enlXR1IKRFphU1V4ZTJUTU5qZG5NSUhJbmhxNVpoTENW
bDRXZlpGN2h5ajJ4Y3RSazdVMnpoSW5KL3F1NElFeWN4MjZTNgp3V1RqS0NyR2VCcStpa242Q1d3
MzJTQ0VhZS92cHF5cTVaY2RyRmpMcjlScWFCaWM5bHJMNzNJYjFDeXo0djRWCmpiakVGYUNGZ3N6
eEU1YkdrdmNBZFdtTzFNZCsvWjFYSndTSlJORT0KPTAwRFIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000009a4779063dc162cf--
