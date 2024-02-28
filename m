Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6DB12EBF0
	for <git@vger.kernel.org>; Wed, 28 Feb 2024 11:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119960; cv=none; b=MyJdvCrCQUB/kTjBZueZJ3iV/l1H62OC85h1lmIXcCrCBVgU50uEcYzfKcIkIKoaXSHeD+0tqeRlk7/sQtmdf376UrQe2CE95aR6svSzTRPsC/JIyeNYr86dAi+kpMnY3hjyIYHwZLbKgsQ70uE2mbH4qMBPOd7j9bsPxzYnPI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119960; c=relaxed/simple;
	bh=pZMjF0EMWbtKsJhZNXS/ukFxB4TUN3C52Q5ePl5EuI0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qOafYa84wcWoCvJydH+IKwEk2j44iwkrktnixwG9q2tJgYelh4VNpAnnclGun+slDWGozL4GSB7eQ4ZAkEhJ/6fbvwiZVsSt4MesP05DfNmDlhC+HFburX1uJL5/dwZyj6gLaUjAF0oeGSgsZtotfPOth9zvQ3XGIyx2J925Aug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZEJXYejG; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEJXYejG"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-21f0c82e97fso3577333fac.2
        for <git@vger.kernel.org>; Wed, 28 Feb 2024 03:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709119956; x=1709724756; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=L6QadjBe8Qy6U0AUScNSkQwphGV3CYiqYXYMWis4COs=;
        b=ZEJXYejGU5a/yeaKu9gofP0nGlpN0zQksuw2y62T6PdA6q8x1G6//nKsl7UYaNw8xY
         Ep05K/Ndh/L3AtwmHWIP3R0f3S2SI3TJPHP74X6URIZZEclaznDDH1GEap2zBcVmxm7x
         RIKWwVRmBYWOcx7XXaFXZzL8dQd2MGix1//VgxHSfgQEJkj5NEde1AFOgA7q6KHd8GaS
         lP0ODzEzrnRUpJ/reEmQv4WN/FinrtoS4YU9DsKk4fCjDmKd2KhHeGkWcJfR0VkxANr3
         vR5n6IZF2K+lsRNW0eOvPWMlQJorFh6wdwAMgabaskYyJhdf8fj4gUcnnZWwVX+mr8mq
         +N6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709119956; x=1709724756;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L6QadjBe8Qy6U0AUScNSkQwphGV3CYiqYXYMWis4COs=;
        b=rjnDQmvfWVGLd46q5nlKET1uFxuEVNlJOn2FQltgoIeZzIqRURebpPP4YJlTKA3RAo
         o/kggo7PDEVRnQmF24z0o6A2IDqbI0bL3EiVfQMm2TDVAVQjVlrkoNZbDN5rD+zTCT45
         n01VwjFr4ro8gFScYoZpz1dbyJbr3iUV8PEssu0Iw7YE78Knk8W/bjkEKZB5zNevyYlR
         N0VELpm/oOYeyP5+8DMENKSqK2hefPDP7fi9nnjJqxbo1gxGs1A0nVXlF08ghdkWWzfW
         OM9wA91zrBBc94hhOJB0m7VhdYzsf0P6Qhe/FHvsusCu5wg61hA9i2ohA3GuogI9G4B6
         hPIw==
X-Forwarded-Encrypted: i=1; AJvYcCXuMtXL7M2OwFgO2RJEI+/ZndPzIrqShTUZvJbdYupR4pDaIFANHGDF23nwvyCnQ5c+AWikhwo2DVjwF4OwTuUS2fqP
X-Gm-Message-State: AOJu0YwR8RK1+/q3T1FOZ3LS1S2Qw/jwLTqbFjOp8qvN3xrx3c96+SG4
	wj80NHt/bULq1/QEAxeM7icniNhaOb+yosWR2JdOE8BB6JvljwDgv5mfF5SDf0YwFFEnZYr8pzv
	Qtwu46iyQTQrT/BPOG5GjNS3YYZt1XHK0GVE=
X-Google-Smtp-Source: AGHT+IHYJg/waoujPfKLCwzoPRWgEAPoixw3X/jgx9rXQRB7/FHZ4i/g3FClC+eS9K3cGS4zPGvhxvUQ6BTnAuiEgkc=
X-Received: by 2002:a05:6870:524f:b0:21e:6d57:81f7 with SMTP id
 o15-20020a056870524f00b0021e6d5781f7mr15248736oai.17.1709119956023; Wed, 28
 Feb 2024 03:32:36 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Feb 2024 03:32:35 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <95be968e10bd02c64448786e690bbefe5c082577.1709041721.git.ps@pks.im>
References: <cover.1709041721.git.ps@pks.im> <95be968e10bd02c64448786e690bbefe5c082577.1709041721.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 28 Feb 2024 03:32:35 -0800
Message-ID: <CAOLa=ZSycN0iYbBP-rXKW5=tNJLaSd0q8+Vm=CzNfsP2nR0sJg@mail.gmail.com>
Subject: Re: [PATCH 1/2] refs/reftable: don't fail empty transactions in repo
 without HEAD
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Mike Hommey <mh@glandium.org>
Content-Type: multipart/mixed; boundary="000000000000db95e506126f7f09"

--000000000000db95e506126f7f09
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Under normal circumstances, it shouldn't ever happen that a repository
> has no HEAD reference. In fact, git-update-ref(1) would fail any request
> to delete the HEAD reference, and a newly initialized repository always
> pre-creates it, too.
>
> But in the next commit, we are going to change git-clone(1) to partially
> initialize the refdb just up to the point where remote helpers can find
> the repository. With that change, we are going to run into a situation
> where repositories have no refs at all.
>
> Now there is a very particular edge case in this situation: when
> preparing an empty ref transacton, we end up returning whatever value
> `read_ref_without_reload()` returned to the caller. Under normal
> conditions this would be fine: "HEAD" should usually exist, and thus the
> function would return `0`. But if "HEAD" doesn't exist, the function
> returns a positive value which we end up returning to the caller.
>
> Fix this bug by resetting the return code to `0` and add a test.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs/reftable-backend.c    |  1 +
>  t/t0610-reftable-basics.sh | 13 +++++++++++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index a14f2ad7f4..45568818f0 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -821,6 +821,7 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
>  				      &head_referent, &head_type);
>  	if (ret < 0)
>  		goto done;
> +	ret = 0;
>

So this is not really a problem in this function, it's more of that
`refs.c:ref_transaction_prepare` checks if `ret` is non-zero.

Nit: would be nice to have a comment about why overriding this value is
ok.

>  	for (i = 0; i < transaction->nr; i++) {
>  		struct ref_update *u = transaction->updates[i];
> diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
> index 6a131e40b8..c5f4d23433 100755
> --- a/t/t0610-reftable-basics.sh
> +++ b/t/t0610-reftable-basics.sh
> @@ -328,6 +328,19 @@ test_expect_success 'ref transaction: writes are synced' '
>  	EOF
>  '
>
> +test_expect_success 'ref transaction: empty transaction in empty repo' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	test_commit -C repo --no-tag A &&
> +	COMMIT=$(git -C repo rev-parse HEAD) &&

why do we do this?

--000000000000db95e506126f7f09
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 20fca8a2a1227b28_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1YZkdkRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMlpqQy85aGd5eGxnY2RFQzBselBHTGo5ZVdzaEYxZgpiUjN4dCtmQnJl
QWRVQUNJYVd5QjZsTjVsL2Y0aCtLbVFqWDd2TWh4TU8wR3FHTWJDditwczloS0JKZ1czcmMwClRB
V3YwZVZWMWtvSHphK1l1NTFJaFNwcS9UQ2puRHdNQXZFQWJtNXEzUWMyN0dHTEJTcGdhVmtUMTlR
Q2R6YmcKNVo1Y2c4RlV4c0tiOTRva2ZtMVRQVXJJTGJ2bVk0TWppcXRHK1E0a0Nldk9aeTlKb2ZZ
ZHJaVXNWK1FTQXlSRwpZcW9idHI0NFRDQUpja0xtQlNOaTZYRGZNZzBROXQxZDhPTkp5UWNWaHgy
ODZKV3JuOUgzS3NleWdkdXVGZVVPCnZtTHk1SDBVY09UM2dEbCt5R2RMb2N4V0VCY2Rvb2hFVi9z
dDZSYjlkYThRQmdSOFYxd2xnUHN2UEMvN0Q0ZzUKenRvZXg2OTErSVczZmlEK0RpRE5LRUx6cndy
ZHRucnljTklFZEpuSGp1UlAvWmNYaXdVNXhNb29NTEFndUROegp1VklsYTRBQVQ4VndjN09pdUJi
OVFjZEFLR01ZTm9VeHNhSzFZeDJSS0hTR2E4Z0lTS0E1ZWcxSWpaV1VCbFNnCnk0VS9GTkdvZVhn
cHpNQ1Vzb1I1Zm96VnpKelFQNzNzVjNxQWZZWT0KPVE5S3MKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000db95e506126f7f09--
