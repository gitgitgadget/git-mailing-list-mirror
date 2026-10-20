Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792523164;
	b=S31jg/rhYW4uBl8/7sbYXnMjXvxVWt/RJkL6IO2cnN/WD3+Iifo0/dxyzs60iwJHjRJM
	 5r64qEhtKStjUjligeMVz7ACToNhdR3aUAle6rWeeq7c3JJlZgQWbYcUkUn9A8tqFe9ZJ
	 MH6/xCyzceuWSN1Ax/YIKSorfhBbbWhizc+l9O2ew3OI0s7GaLGDKm4VLgyc+whl0JaKw
	 +Zoely1vZdlKLmAR01Doj0FDSqQC15sHqAV59of2lNFLBk9s+e/AWI7vyHiqCw1SloCuj
	 x/6GKDY70kEsJbNBrgdNHQ3TcdvihMz5PEJTUDy3zB+HqyMv3YX47wf/ZtohgWsQ/Xg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792523164;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:
	 In-Reply-To:References:MIME-Version:Date:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=UNbGRK4PZ+9u8uTQXHDyp9+3qQZZ4mha/4QOx4Z/MdA=;
	b=OfaarEEgrYfAnoVqaF4d+RKpaS/o85axaDQTyC3/qf72bcxPWzGIaBLu4iCkT5TCuf0w
	 klS+XXreC3zGqVzSkUI2pv2GGkhxuhVh6OMY2LosN8DKJtEsF85Jjp9GPL+q6DsAkeJja
	 k6MoJBV7VvJqphkTfgcZKkDV26NEBK42QexYQkhx0i5D0opxIEFLhOBM+x9RCjNHc2nm7
	 WgrLCeVCaZmCc36pYAgJfNFK7+pWRcqm3f2ULYZy9/Djy1D7EGtfPcfo0CnKNYuexBK6w
	 tIoHxmaHjpU+/uarH5FvOjTlxoWp4hiYEcWjupgs30w+tT0SFt6a7ZuzNyREMebUj7g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qp+WmQHi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.42
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98B5606A319
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 19:06:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E98B5606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qp+WmQHi
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-9908346255fso453281241.1
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 12:06:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792523163; cv=none;
        d=google.com; s=arc-20260327;
        b=CHrXadoVG3BXfm1JrO4k4GIuKKUkv/QusRbCMy8Ru845WSzJ3JHI4r7GEH/dTy3kxD
         qgqgDzG+Z/jnJhQZ1ZlTZ8n5zB33x/u8RBRJulI7wekv2dJzP503rbS9LvqEaQnZakH+
         UEkVIO3+EqSz8AwrxN0PCf5V7WvqiUg3eI1Kgmw1Z3+kF7RNBkzOUopdEe5VSTqqUsn7
         kaGMtcAVDWbWcgbqwfUk9dhIfN5qM/JrgHlcDtpRL+5evyML2ur26EG8c8IrBQ4EbP3a
         zlVrWFrOujhj7AtbDcO9hPO6+ii7vBc9AJQr5+0fRBwo57eZgKvzfqGOhbfymnP1FbMH
         uN/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=UNbGRK4PZ+9u8uTQXHDyp9+3qQZZ4mha/4QOx4Z/MdA=;
        fh=4hRD6dug9K2dA8/Qy44rHfFMnlFofhUgf7dxeZXl9E8=;
        b=dn4YPo7F2E5R41zplUQ8qNx1ISU0ryf3SNTe0t/rlTjGMkmjNVK7+LXpKnVt5h2G7F
         TQn6/WJp6Azq+gCSMocB6fzGjdhyGWcz7Wepgpq+b+8ljGUuHsqybVvCZReP7tRgJboU
         kQSW2qljCbmwCTfLPnQa5NqZAAf3aOK8ew5y92860r+R6TjiL/xjLxSUzLqHfTAxoguh
         UMgzvUphUgUYy+baPiWu2NmmMBm8uawfx2oguuENimf/4IHRaDiWhXL9rWkwl/enx6p3
         BHWqgt5SXMm08+j0GxV9ij5L4pxfEkBInjh5m3Ylrq05le/2Tdqeke7xgfoU0P3AG1Sx
         Uq3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792523163; x=1793127963; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UNbGRK4PZ+9u8uTQXHDyp9+3qQZZ4mha/4QOx4Z/MdA=;
        b=qp+WmQHisu99apGEQI2l9dV24Jr+FI3qU4QSqZsNXJRd6jEEDxqCpKlu47ULya3UCE
         +3uZ2RMV6vI6lJc4fbia3P/RWeIoSD8MxOznIp82J5VthPyMnUk8db3e0mQMFXCAx4sV
         NMOJ8VL6Wmg+Q879APUoLc6hriAsY/ufFcmEdYVaZwJtVo6daHv9DmCCTePRCDbGgtNw
         g7CdNkFC0wl+HGFfaq3AxRS3UMCAKPZMu8S3Jsr4mZ/XHaVyRzcOvVE2izXxyr+Q7qt0
         sCSivZWz2nvIapEYrTiLXlOIRaDY21zE32+o/uLNOo35qNuHXElH1hxj+M2XcLdOCHlM
         QwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792523163; x=1793127963;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UNbGRK4PZ+9u8uTQXHDyp9+3qQZZ4mha/4QOx4Z/MdA=;
        b=pEfmW35Z1Hcw5hgTXBVE3EOd8HLh/CTp0p0kxj867RUYKfRFuBvbXDNcY5+YZpLTj5
         Nt6blCQ8Z4eF7LvkIkdTJA2LBPcIW4Ess7GAtf+gVv5miuiFLFaZ9BiOdxJ7LEOiBLxt
         znsdQeaL9Ry/832Ci6QhPyWnwcd6UocNRgAnDdPgxQ6cnX6wHDZI5itQRaE5l7b6Cnex
         zqKAJH6F7gn65/Gad3k8MK0Gbo3hduAeUvk2TokgCYxG7K5kweZAi0CnOB5J7sCkyQUl
         TJpQFeAjHJdwzFt1DK6QuXaxQTZ72QOdOEh12bCbwVadYikn475Q1HaP7EurmZRkuK/3
         mqRQ==
X-Gm-Message-State: AFq9FYKYkcKkugjgTv4w01m0PH+lBFTUJLxDBiR0OzUvnsXvqE1FgLrL
	aE5r3OvsGLl64XlcEUkQpnbKMO9DorLQ1i4SbISXGRjXbzM/h/BF2iQhN0kuCOLNoHTUlLxz1x0
	K/9fsWRWWXx3mBkPdpt/eXGTG3lrjnnZ/PQ==
X-Gm-Gg: AYBFou28i5mkW1ZtZAnzA7J/tbjbgOoJgzPRrH2v5mdQVR1YmwbrC9cDA2ANdf+PYXF
	vryTBRjifG+eR0AfifeBb1QCVfMeKDuxyPbqJq2qRGoLtaUvbNkFCYuSFuYy42HTnDoL6We2uV2
	0FAqEb1/U/eSfwb1XzHxsu0bcOLOsczueP4+3AmtHKzmeZVoq6uCWHapiok+Q9h1WKe3UUFXHdg
	VqLAWCcOJGVV78T4xjRPpCxlBWCftLr44RzIpiWZX7KeXzwnWMbQECLe1sbqqAuNW6009Tssy5C
	1uwPq3cKyOjvFwNs0CSYwIejJ22myMpNT84dE26x9nWVfq9Sd97UnIoIgk+lKOqYh7jw/s4uREj
	vZj6ycOs2CwxC7EuKutebTy/uR2m0kv2skKXH5I++GYLlRw==
X-Received: by 2002:a05:6102:30c2:10b0:7cb:c08b:f50e with SMTP id
 ada2fe7eead31-7cc7bb88538mr553074137.10.1792523162812; Tue, 20 Oct 2026
 12:06:02 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Oct 2026 15:06:00 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Oct 2026 15:06:00 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <atcrO3y0o-2G8Dpu@pks.im>
References: <20261019-b4-pks-odb-extension-v1-0-143a5963b77f@pks.im>
 <20261019-b4-pks-odb-extension-v1-2-143a5963b77f@pks.im> <CAOLa=ZQj0sZu7WRzmvgZx23ZeO1KBtOm6yWOLCzeVP_86zkTPQ@mail.gmail.com>
 <atcrO3y0o-2G8Dpu@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Tue, 20 Oct 2026 15:06:00 -0400
X-Gm-Features: AclHuK_oxHdW4Oj67wqvOQk5ww4lXotd1ST-UP40UOePzmPqoagIw6fgICJ88Rs
Message-ID: <CAOLa=ZQ9YH43igSivrCTy9ruDsRnTDPu0xipp3XdpNXU2zmtCA@mail.gmail.com>
Subject: Re: [PATCH 2/7] setup: introduce object storage extension
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000005f2542065e4a5242"

--0000000000005f2542065e4a5242
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Oct 19, 2026 at 02:29:20PM -0700, Karthik Nayak wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> > diff --git a/odb/source-files.c b/odb/source-files.c
>> > index 455f409db0..4a7cbbfd9b 100644
>> > --- a/odb/source-files.c
>> > +++ b/odb/source-files.c
>> > @@ -1245,6 +1246,12 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
>> >  		object_dir = xstrdup_or_null(getenv(DB_ENVIRONMENT));
>> >  		alternates = xstrdup_or_null(getenv(ALTERNATE_DB_ENVIRONMENT));
>> >  	}
>> > +	if (!object_dir && payload) {
>> > +		if (is_absolute_path(payload))
>> > +			object_dir = xstrdup(payload);
>> > +		else
>> > +			object_dir = xstrfmt("%s/%s", odb->repo->commondir, payload);
>> > +	}
>>
>> On the reference side, we use `strbuf_realpath()` to convert the
>> relative paths to absolute paths, should we be doing that here too?
>
> Overall I'd love for the "files" source to only ever use absolute paths,
> but historically that wasn't the case. We sometimes expose those paths
> to users, and changing the "files" source thus breaks a bunch of tests.
>
> So I'm retaining that behaviour for now, also with the extension. It may
> be something to explore going forward though.
>
>> > diff --git a/odb/source.c b/odb/source.c
>> > index b25ef14df8..10abe33a26 100644
>> > --- a/odb/source.c
>> > +++ b/odb/source.c
>> > @@ -1,4 +1,5 @@
>> >  #include "git-compat-util.h"
>> > +#include "gettext.h"
>> >  #include "object-file.h"
>> >  #include "odb/source-files.h"
>> >  #include "odb/source.h"
>>
>> Do we need this import? This commit seems to compile without it.
>
> Yeah, we add some translatable strings to `odb_source_new()`. The header
> is also implicitly included, but as Junio pointed out we should include
> headers explicitly regardless when we require their declarations.
>
>> > diff --git a/t/t0001-init.sh b/t/t0001-init.sh
>> > index f1d227f271..c7c464d3a2 100755
>> > --- a/t/t0001-init.sh
>> > +++ b/t/t0001-init.sh
>> > @@ -839,6 +839,36 @@ test_expect_success 'init with --ref-storage-format=garbage' '
>> >  	test_cmp expect err
>> >  '
>> >
>> > +test_expect_success DEFAULT_REPO_FORMAT 'extensions.objectStorage is not allowed with repo version 0' '
>> > +	test_when_finished "rm -rf objstorage" &&
>> > +	git init objstorage &&
>> > +	git -C objstorage config set extensions.objectStorage files &&
>> > +	test_must_fail git -C objstorage rev-parse 2>err &&
>> > +	test_grep "repo version is 0, but v1-only extension found" err
>> > +'
>> > +
>> > +test_expect_success DEFAULT_REPO_FORMAT 'extensions.objectStorage with files backend' '
>> > +	test_when_finished "rm -rf objstorage" &&
>> > +	git init objstorage &&
>> > +	git -C objstorage config set core.repositoryformatversion 1 &&
>>
>> If we're doing this, do we still need DEFAULT_REPO_FORMAT?
>
> We could indeed get away with not having the prerequisite right now. But
> once we have a second backend we'd need this, because in that case we'd
> potentially initialize the repository with a different backend here. And
> then just switching over to the "files" backend would probably not
> result in anything good.
>
> So this is more of a protective measure for the future.
>

Yeah but this also means that this doesn't run with refs reftable, no?
It should be okay, I'll leave it to you.

>> > +	git -C objstorage config set extensions.objectStorage garbage &&
>> > +	test_must_fail git -C objstorage rev-parse 2>err &&
>> > +	test_grep "invalid value for ${SQ}extensions.objectstorage${SQ}: ${SQ}garbage${SQ}" err &&
>> > +
>> > +	git config --file objstorage/.git/config extensions.objectStorage garbage://payload &&
>> > +	test_must_fail git -C objstorage rev-parse 2>err &&
>> > +	test_grep "invalid value for ${SQ}extensions.objectstorage${SQ}: ${SQ}garbage://payload${SQ}" err
>> > +'
>> > +
>>
>> We should add  tests for the files ODB with {valid, invalid} payload. We
>> should probably also test absolute and relative paths in the valid flow.
>
> I add tests for both absolute and relative paths in a later commit. Here
> I'm basically just verifying whether the object storage extension even
> kicks in at all, without yet verifying its semantics properly.
>
> Patrick

Yeah, I think I saw those after this email.

--0000000000005f2542065e4a5242
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: fda000965869b9b6_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yWHU1TVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOHRPQy93S3B0ZWhVWnRBM1JMVDVBT2dJNVFZZmNsVAowSVowcmdUQUZD
bzlwQnVVaDRkSml3MlNHRzE3K0ljeEFtYXlJR2hVcW1VRjBuTWZaMHdTR1B1N2Zna3N2bGc4CkMx
RUNIdnFxZ28vUzVhOWY0bCtTQlUyeWNvRXFxdzZIaU5TZk83ZzdoczhrSnc3cjVuTzFxaEVIQm5T
eUMxSE4KZEJtYkcvNGN4aE1nOWpNcFZueVZBK0NoOVBqQ2pDMkRmc0E2ZEF3emFkd3FsOTJ2d2hp
djEyNDJWWUNYdHRFUApnMDhOTlVSRmhxNE9rVTNDdVA3UlVnVUZlTGFNYWRYQ2dRWDJJa2U1cENq
aGdiaTFsWVBHNjBNalZDTUpUdng2CnhzNERraHk3VWt4cVJibWtqZFpqT1AyTUZ5cHc2MUpYNUdi
QzEzRU1lbTlCNlB1RGFCTTgzclU2VERUbVV5ODkKT3kvM3VHMG4xZmlJbjI3L0ZUVmlyeGE2b0hZ
c1hpWEpxdGhObFZSWmRLV05nTDA1S3dLZmtWdmZIZkJSZzBlZwpXQSt5R3dIQ1JMWVBIKzhXWnpt
MEU2UWRlRFpuM3RTSE1mK1pzd3lxUWpZRmQvdW1QYXg4cEFGa1lWMTBFendjCkl6Q0hkMTB1SURW
RExvT0F1bjRKSzlnNi90eGQvNEJKZ0Jma0RHWT0KPW5WK2QKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000005f2542065e4a5242--
