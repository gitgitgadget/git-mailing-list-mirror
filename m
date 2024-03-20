Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D7385C73
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 23:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710977038; cv=none; b=QRoeyhGjRbP1e+zKBqlVSJpaocBefvfIrt8wJUdfpOhDplSPejYWOcBdeWpyMDFCF5jFmrkBkA1MRPs84+gxHt9kJxwEOiV0/kHPbsW1fFaKTg9BYeE4uTozelHR80kVT4z9+zdVxSsReg01x0YiP9LX7KGE1OwgX5ikQbay/YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710977038; c=relaxed/simple;
	bh=QhXpCOWsHYtBhv5+kJ+UtPCIi+2iUwtU68Gwv2tRB8Y=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=byydfOWMQpAgvjF32Yiwr0zAxRwxz3WmyqPC20mxkpLUXFg+XJJ4stgK3ajLqT0eg5tIH4NXYTG2syPVu/B2R8IUsZftytLKB2qkyg/026YH60fn+dICGuXcoPr+we78ZEyhVUCJX+hGyRm00tuMkZ8HfAxpx2Vmjauzr40byLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJbDqB0p; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJbDqB0p"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6e2c45b81d8so444939a34.0
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 16:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710977036; x=1711581836; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QhXpCOWsHYtBhv5+kJ+UtPCIi+2iUwtU68Gwv2tRB8Y=;
        b=BJbDqB0pP0vM681gW1c8YpX4zkZNrn9YQzirGxbYROwfRyd0BmVE+Gk0y6pw2isZ6Y
         Ll7+jP8Q9+52Rz2ACzbtW+EE38jkB6sDfJMtEPVeLZmWKxaTpSPz4tGlzeFcTNSkRapB
         JXxR0zPUUMY92QHPu24i7XgbOmBbbBkYpCO1wV5vO9SEHvT1QUD5hLDxgM7ez5sVE5eG
         +TaLIgdYUWnvnoAwRujWcbRdDArdmMWYdTSBGxAVnG2OkGp2gDLcAutUFwQsqTMtf0Ys
         tdpWviyvZBIeOKRO1pmHhvvoRvyeqrXhthjBpnVf1mDjwCaEf7F/+vslrx5M6jXi5etC
         LPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710977036; x=1711581836;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QhXpCOWsHYtBhv5+kJ+UtPCIi+2iUwtU68Gwv2tRB8Y=;
        b=jBw6zexu8bou2SBExz8raxOppMDUM91X+lucOEFmfyYpUtUz2Cx+STKwpXKVUXTM+H
         MfqGFRTf/obreo4lJMxZQhjcCGSI/rDhwC8jpBo1IkThz2GsBMIczRL9mB4gAXZJpvEP
         O9dXj8FS/5xfL+fcW+PmBnVtaKRGqHFffbjMORbnhAJYdtIfsBGFkMppk7/mg6V+Z2CJ
         5XT5ZOedBVGyWvfkF15CLGOSI28zM3Br598K9cocQoTrxhl26kaEYOntwOLrPq/6pwiM
         vutfMNiyLqrbqw9eDZrhTFsltKMRyWfW+TCEEfEp079lqvnHmKjR7LdpVHCxbCHPLczK
         bawQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyymHK/uwHAXh+xjjP79efA7DPtoYPAesAjEUPtHT/LIMxwvUNagjbAjm5wfzIHfJDFTsFzE5Lj7vMvLln41KKjAhr
X-Gm-Message-State: AOJu0YyEJIbmbEKOgX2Uf7odagZyRYSnOBW7oMicxegnQJgJbIuM+g6X
	kBrejgJCtm1uaoXrsPIuGjOybPNT2nCfFparBoRPnOLQPG8O0qvCIcO1JcEG1pPQiRfXHD5Jg9I
	iHnsVYOz8WEhZAEp7BffKjdYRt18tVNJGtbhd0Q==
X-Google-Smtp-Source: AGHT+IFqT2RKZf4tGCD9GS/kG5zDppIeWggldGISdDoiugcRA0iBDpoL/93Q3MQaPi2IVnVBUnuh4Q3mSKCH/QapilE=
X-Received: by 2002:a05:6871:5a94:b0:21e:e24e:e77 with SMTP id
 oo20-20020a0568715a9400b0021ee24e0e77mr567961oac.23.1710977035840; Wed, 20
 Mar 2024 16:23:55 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 20 Mar 2024 16:23:54 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ff163a621d3b55924882cea1d1c51c074ce2cae9.1710706118.git.ps@pks.im>
References: <cover.1710706118.git.ps@pks.im> <ff163a621d3b55924882cea1d1c51c074ce2cae9.1710706118.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 20 Mar 2024 16:23:54 -0700
Message-ID: <CAOLa=ZQbkW1_X3oaipbTNMTy3z5jvbFoFp4W9wPSh8gHSAFYzg@mail.gmail.com>
Subject: Re: [PATCH 10/15] builtin/pack-refs: release allocated memory
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>
Content-Type: multipart/mixed; boundary="00000000000070c99f06141fe2fb"

--00000000000070c99f06141fe2fb
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Some of the command line options in `cmd_pack_refs()` require us to
> allocate memory. This memory is never released and thus leaking, but we
> paper over this leak by declaring the respective variables as `static`
> function-level variables, which is somewhat awkward.
>
> Refactor the code to release the allocated memory and drop the `static`
> declaration. While at it, remove the useless `flags` variable.
>

Tangent: I was looking at `files_pack_refs` and it seems like there are
a bunch of `die(...)` calls there. I wonder if it would be nicer to use
`error()` instead so we could do a better job at cleanup.

--00000000000070c99f06141fe2fb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 6b574c94492562c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1YN2NBa1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL0xUQy85cTNzZXB3VTd5cDlzb1NMN0pYQTdscXdkMgpLQWUyamNHalNj
ZzZMMkRTbmthUlhoeFAzejhqbHAzU1F1Z09jZUNpU0ZkMklOTjdNeE9DNWNvVXp3V2plUnVGCjJr
cHhpc2UrMUNqRjI0NmhYQTM2Q2VOMElncWF2TnVWWVpjaXJCcVpyK1NFbVhCWUpoUGVpcWNkOEJB
NGw4S0IKU1RMaForekdpLzBNTjRwUGZjNitTam15ZVpJaFFkdFRoME5pSWwzKzlSYzN5TjgwYUF4
M2xsL3RWZFpaQy91Sgp4TmpDZXFRNGhVNHQvNDlwd3h4WXZiRUJtSHkzb2ZqL1lobHlPN0lFQmJM
cHhoNFpWN2RWK1p5TU0wVHIxT0k1CjhhOUhCSWUzc3liUmRDZ29tZUxJM25rYUdmWmRRS24zWUVs
S3RkdzNRd2UxZ0tNT040TVNCNU96Ni9DODhQdm8KYkwxdnRCZFFMRE0xMW9hK3VqbGNrT0tndzdr
WS9kU0x2Z29NVk5FTWN1aFJNUWQ2YzY5YTNWQlVZay9nSWJvZwptUUVnUExoUjR3WFNJVU1XOVYx
QW10eGcrR3hOVDdyR25TbGFESEJSSm5VOFZvbE01QTRkTlZEQzFNWXZtR1NmCjlicUppWkJkcEdr
UDRkZTNBRGRCTjM0SFJ2anJnQjhjMVBVNHZlOD0KPU0wMjUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000070c99f06141fe2fb--
