Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5D61A9FB8
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 16:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754928500; cv=none; b=UsXzpCANt1t/kusrb4lZBosXVvFS3mIsOXOo/Zsq/t5dkbVgpd0Ktc64iuseAJaJhTH3e87o9THMn8Is9BOB4SabRyge0wSgcuE1Mhny02kyokxzxsLrKtpyLLjUBYCMOnqrCEUbO+KyzvxGf+zemS0pV4NR9tYVzw2+FUJVHEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754928500; c=relaxed/simple;
	bh=EXVcTJ0aEesZ2UhNCh7q3uxXteyFaRr7NXDLfeTXq7I=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=TQDPlj5LwPKMOxc5SI4bD9ryRihBDIdwChyEgG1gwVN5NvzhpgTUypVYrW4BujA6RZw+jJDCDeWgHGwl4KjNg9z9ptiYndyXTTYXvZV9oKzsW2u4QgyJU8Qpo4+igZ3Vfvh0lIuFZr1FYtjLoA03NTpZEInODY5rrr3Myc5973E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGlqzVLM; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGlqzVLM"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-76b8d289f73so4229681b3a.1
        for <git@vger.kernel.org>; Mon, 11 Aug 2025 09:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754928497; x=1755533297; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9bVtsiIjiVW8+JnP376FaHOdfWD4ILRAfxWhIK7mx1g=;
        b=JGlqzVLMCSK48EBipFNbumOE1eGqBv7d7SHed6rxLjQ6wgm1CGoRjfBDHkps1nKEBA
         J937TGjIMf/gNDHDsIau/KkSsMc4NGFrLAX4dQM/9d5TWYDWCu3TmfKJ4HHy/1e9ldnA
         mY53aAQ8+0oK4cVF96x2Kx5N2ddQ89wU4A1Dp8YOcYYuP8/VUhgQuCJ2g6d7jb9w1qOU
         5AA2TYY94KbaERxVX/MOoIyp2kHKE6WTkmSLFgRN0zdM2/suzyAtdVjZoQ9ZCq7qBvXv
         47Tn/AmBju3lEoQO35jf0lx94GgluEHMHxGWcAlfQoci76+n1Mj0a6vZACuMgLI8djDk
         ScKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754928497; x=1755533297;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9bVtsiIjiVW8+JnP376FaHOdfWD4ILRAfxWhIK7mx1g=;
        b=Pep8cXVGYvOQSq75GPn2vLSh0/IByYt5bC/gO+RQMl2ubPBIRgFOTCjcE4vH1X1bMX
         wrD9bS8VQBRqGg9AvEGCi8NgwcZdglFkXbebN3PMIeedg18qo72q8OXDury7Yera2OiT
         jMh6GSxftXxujQno9rSoFbcTzFWj9yTMSqJszHn9LLXpdpHOEc9VmIxoCsZzaujrxXQH
         ds2PkZrpMGZi67HsFVlb9bfa7Fc1xM+x08ls9UPZVaoHEO7GHC3Xadd1qmWSepcgSGh0
         qKjpBtQXrai8NFRuud/Ko3EhNdDeM6KPsolhjzmXGRCB3zFv8+THP2YlxdIxzMR4tcRP
         gSNw==
X-Gm-Message-State: AOJu0YwczTOvCGf6uC3huho9fPe7DNBZjW7CcRMFkcA5TSkg6A86l5TT
	XeYAyDdEqMmxKs1U3TovyrYU2gLyoqytK66qg2EvoxlQd6u36N5GJyxj1yjy7KvaalM=
X-Gm-Gg: ASbGncsChM/wJqkoi1s3r8rXeO2UnQSPk1Gtms+sWfDFBsSCQtCfmW9AgI4MMJ4+Dfa
	hSSRKIaRThJUuAnrK9vt9lT/4Oopp4uEGfDH9ZWmIztuvM67yW35fwI68uLZsPg3jskECFbvb41
	NrOBBzzTHvGpa+W/hbJpP3CUpRHnZI+NwpX2B9Uc+SAprV9p6MJ7DQeuuwxFtMSIpS7WivVfcsF
	ekCas6vEByVpJI5iW5NlAgZIJi1Gq5kTec9X3NvIX0FkTkUM2ldIMS5M8Brq7X9tdt4Lo19CpCo
	N/iPWAKWXB3zzREQa0OsSRp8vrAlqZTrnZ3WHOuHJkvcXm/NsKYxSNodbNVRGY4n/1G4BF63lRl
	N9tZ5tQQCl1zC59Xc+htgFCYf2LyBKDcitOjGbQ3Tr3JmeAKDjyY4zazC6w==
X-Google-Smtp-Source: AGHT+IEvHWiiamHI2YL0nu7FrQXRGI9b+9uAHKwhYofoX/00SxGADpsMGve4Alurh5CQo9DD0pjeYA==
X-Received: by 2002:a05:6a00:1493:b0:76b:fe5e:3994 with SMTP id d2e1a72fcca58-76e0df22a4dmr203276b3a.20.1754928496899;
        Mon, 11 Aug 2025 09:08:16 -0700 (PDT)
Received: from smtpclient.apple (awork062197.netvigator.com. [203.198.28.197])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c5d73eb9dsm6932218b3a.3.2025.08.11.09.08.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Aug 2025 09:08:16 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v5] bloom: enable bloom filter with wildcard pathspec in
 revision traversal
From: Lidong Yan <yldhome2d2@gmail.com>
In-Reply-To: <xmqqy0rp3l8s.fsf@gitster.g>
Date: Tue, 12 Aug 2025 00:08:03 +0800
Cc: git@vger.kernel.org,
 stolee@gmail.com,
 ttaylorr@github.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <B5A8897E-3D20-487D-9774-444463F81DA4@gmail.com>
References: <20250809042236.72695-1-yldhome2d2@gmail.com>
 <20250811060137.75135-1-yldhome2d2@gmail.com> <xmqqy0rp3l8s.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.700.81)

Junio C Hamano <gitster@pobox.com> writes:
>=20
> Lidong Yan <yldhome2d2@gmail.com> writes:
>=20
>> Signed-off-by: Lidong Yan <yldhome2d2@gmail.com>
>> [jc: avoid allocating zero length path in
>> convert_pathspec_to_bloom_keyvec()]
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>=20
> Instead just do
>=20
>        Helped-by: Junio C Hamano <gitster@pobox.com>
>        Signed-off-by: Lidong Yan <yldhome2d2@gmail.com>
>=20
> here.  [who: comment] followed by a sign-off from that person is
> done by the person who is signing off the tweak, not by the original
> author.

I see =E2=80=94 when someone makes additions to another person=E2=80=99s
commit, they=E2=80=99ll also modify the log message in the process.

Thanks,
Lidong

