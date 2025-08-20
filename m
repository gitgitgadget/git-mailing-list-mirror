Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494752253AB
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 12:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755693881; cv=none; b=DHlziXz6gLGIUO3cKNYTeITFMTz5TZ8EYmutwqTEbeO6FCz39D3HNWXHwqDCkjMbCwD8OEo0lDZ8R4aZX3tRGltgGWDL3WrGnXbjryNyWIrTuz+KWe0Kiax4G3VjwgwNAHc9NbvLAH7sCSX4y1ogXLIA4NpI8/gP3vJVH8OpZ0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755693881; c=relaxed/simple;
	bh=nxCDJssxTXVh9rpCVcOJwW09OSKV0sbjARJC4hR59SI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=lwRGL+ouzaTp9oU1H0XFRBuMSZ2eMxSyR2sTxagfFBqrkxUrfBgGwrNuPbX5pHAmh33sE3pYNGfduU4RN4dSoMfg7/stm76iZzbnTqpFxTo7TQUBDgwwcX5cVPUKS21HWuJV+6L3JCpTyujkQnAxQSbzR1+121JPzBwk1ZwEnEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aczgAKrT; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aczgAKrT"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-890190c7912so1535177241.2
        for <git@vger.kernel.org>; Wed, 20 Aug 2025 05:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755693877; x=1756298677; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RydngE/jKGikxUVYrse3Z0eqX4cBeB33lviWsYB2Jr4=;
        b=aczgAKrTbl0c3BOAmpKL1rgO98Itg+Ze900ewonXlAXJ+AO7ujZ0dFEWORLQAgbaBS
         iT21ZGLg0KcDXEF+A0+DJNo0+RnQ/ypiitpXfamxFcSoJu/oamrKYhhwR07VjP/WG/wO
         qOEnp6d8+/FGzDtGnCS2jNlmaGnz296JlMqjmpxUxFedpfCZmljd+tIfqswzjfIEhwqR
         dnaTRsxXycv8UobVJuLTgIuc985gDnlvpB29dF2hbau3+KcoWYEHryKdAQYu2+mUVnFo
         ua0zVMuCbo6ZLAeioj3ukJ34HiXu8ppOZ2a0hAs2u7XfkiclBGWcUQ823eF12DYrY99R
         3wdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755693877; x=1756298677;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RydngE/jKGikxUVYrse3Z0eqX4cBeB33lviWsYB2Jr4=;
        b=vjvPG2kYew97qWUCp3j0pDjzbpq6G01wSP7fZ8HHSabQ79xBFc00nFOibZT9BPBzkx
         Nz24sP0OJ11Z4cl+xz/YqoNqPYUWfUPG56ApTtSu8INkxXVbajJxnzXnCSfJXZAwMwyV
         bUsOCjNVWtEog7coX1MGv8loZo5wrSIsqRhKREh+zKlhoJha1811SEPUx8bmjoz0evZl
         mQHfZhigNAd6ZksuQnylpaQf92FoqUOgsfO5hbXj8cnBOQD+5MqUcwx5Vy+Ptv47E7Lq
         sDulwkB8bItvHy98aTf6fRq1Ds1wRVhmRhAnsCfhMOSG6KmujCnzQIz++5eU17d15los
         +neA==
X-Forwarded-Encrypted: i=1; AJvYcCVKhGVUdqOAvcJzrZQvJxEvHAMxZNXr0K050L/Lv61cuCiHXH0zfiVtgr8AVsEli3wgMlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfPMyErF0MqRXcMDKKowRkxPWCbU4cjc7STnbNYrpDMgRJykxD
	/ahrDMyxwsNjY3IuD6SYipMr2znXhmGBE85LM2N9/+sWzoWO22pNZD6TB3zBSymXeUc2t0x/dzF
	EagHE3w8zVgGJCQbicYM6jQD8ImgkKWQVuA==
X-Gm-Gg: ASbGncvqvc48Ga+rnIJ1DnsImnAz3rBcPBxgCpb1tYAT4s8AYO+/oWz/oZMFATKkKsi
	e9xoOWRdtEuedlzcFq8RuggA+O4D7SMcRFhyCbhWv3wGjP5fFsrizv+WDLNQvADdDvSZ5/mZJzf
	cTt5rSp7R6tbuzF9B6YGfjOA5cuIysE4vqyqCvWHpfdtrU6FUXNSBGx3tPnpS4Znhd8ModlK/K6
	f7BRg==
X-Google-Smtp-Source: AGHT+IHI8z+VvYCOOnWmpcwNX3EFK975k8QqxV/g7FRVcK/CynElVsCwJTDmBjFNAVtFW3OP7npiWZSb4TkvOjO7an8=
X-Received: by 2002:a05:6102:4415:b0:4e2:aafe:1bde with SMTP id
 ada2fe7eead31-51a4f4398c1mr670752137.9.1755693877061; Wed, 20 Aug 2025
 05:44:37 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 20 Aug 2025 05:44:36 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 20 Aug 2025 05:44:36 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250819-b4-pks-packfiles-store-v1-5-1660842e125a@pks.im>
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im> <20250819-b4-pks-packfiles-store-v1-5-1660842e125a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 20 Aug 2025 05:44:36 -0700
X-Gm-Features: Ac12FXzLmmsZcxsBTlfkYBKC4xBiYiOg7Dg-69aU5i5FJpzd1LtI_0g_7FcAYvw
Message-ID: <CAOLa=ZRfWamERa_tKenhnxaGnH096p8hGYjauzfw1UzzjA_T_g@mail.gmail.com>
Subject: Re: [PATCH 05/16] odb: move MRU list of packfiles into `struct packfile_store`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000e09977063ccb5514"

--000000000000e09977063ccb5514
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The object database tracks the list of packfiles in most-recently-used
> order, which is mostly used to favor reading from packfiles that contain
> most of the objects that we're currently accessing. With the
> introduction of the `struct packfile_store` we have a better place to
> host this list though.
>
> Move the list accordingly.

[snip]

> diff --git a/packfile.h b/packfile.h
> index 2f84d7d7e6..3022f3a19e 100644
> --- a/packfile.h
> +++ b/packfile.h
> @@ -65,6 +65,9 @@ struct packfile_store {
>  	 */
>  	struct packed_git *packs;
>
> +	/* A most-recently-used ordered version of the packs list. */
> +	struct list_head mru;
> +
>  	/*
>  	 * A map of packfile names to packed_git structs for tracking which
>  	 * packs have been loaded already.
>
> --
> 2.51.0.261.g7ce5a0a67e.dirty

Question: for my understanding, so we maintain a list of `packed_git`
packfiles in `packfile_store.packs` and then the same list is
available in a MRU form in `packfile_store.mru`?

I assume this is to optimize searches to use the mru form? Is there a
reason to not pick the mru list?

Thanks

--000000000000e09977063ccb5514
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d5ab71c6d1544649_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pbHd6QVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNlM5Qy85WEJ4RXpvNzBKb1gxM2VqeEtUdElFOXhNRQpVcld6dTVpTEJX
dE1SeDVTbUtUTCtxWVFsZkxHMlkyM1lQSmZTazJmdWFHTitMUXZQRHViU1Z5Yjc1TDJOa1d1Ckt6
Z2NuNnkrMUZERGVDNFhaMVRoNU1zVjg5ZTd6T2N0elpTZFkwMmF1UWxUQy9CY0kyMzREUEgrQkRE
Ylh0NncKWUh6ZkFZSWVNRE45Umo1QkZoVkNqMlJpRDBNdDdWc3BkMWwvWUVhMTM0VndQb2s0WkRD
MzBIMHkyajFmaWV0ZgorQkhjS2F4UXMzWVJydGgwMnJKM0FBeG12NktWSlp4QmNBY0t4VUlYaUVs
aFVoRWZZanBkVlBVZkI4NERjRWNGCkxZdGNiV3kyL0NtWVcxVjZrY2NLUjRFbWlSYklCRUZ0Qys5
RkEwOWVYdGc0RnY0SGdjZEhwQkhtVHVydmVXKzMKK0FvZG96SnM2NmpoOUVqQmVGRGxyeENSL1do
SjRGMGl6L0JpRHUxbjZUVEFIYldwM01SMDVDc25aR2dvZHZtcApNcFRSdlNVTGoxSFhOZnhIVFR5
T3Zzc2NPOFlEUDVxTlF4eFZPRFZldUJrTWd6ZWxDb2tlVzl2SzhrTHpiVnlMCjFlYzdJdkRDVDE5
RGczZGl3YUhuL0NVbDVEcHBiM1krcXJieG02ND0KPVdIbXAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000e09977063ccb5514--
