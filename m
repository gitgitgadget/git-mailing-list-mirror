Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8442747B
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 09:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758014217; cv=none; b=cg5yspl6N18Q8Rm9hu2BcYab9WR+HIeSHHV2Q79f7Oy9Uto4VhRuV6M6RHtiXbSc4QfV0LZ3cZcLw1WI6uiGrcHWhxPbxdN3CeV5A2oz/yRXwMAG0YR7gkba++KKtNePw1a4Gp7gwhTabI3nN94SQaOPt2U5TeuC9sVjJxklH5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758014217; c=relaxed/simple;
	bh=xXDKXFKSsk6E6YLsVor4ZYnCZvZ8P7CrCUzpAwtXIOo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WfgntAjCBoP6QOXwjRGMsEcKw+cIa7plgaG5N8BKORp5eSoaLmOAjPEFIZsYPigTFrwCIEYJM1WrgSZ7PVfY3OcyOfwgykYdsk08hPIL23WVj1uKS4r9EiRPdZIOu1j1CWOQFbtVudUL2nGX9uvy1zBIJeL5Ey7BW5BC7qV0gk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqcwdRHX; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqcwdRHX"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-545dccac2f9so3718344e0c.0
        for <git@vger.kernel.org>; Tue, 16 Sep 2025 02:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758014214; x=1758619014; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=sUch0bA/0jLl9tYIUalQbRg+wMEiSjsAuzBP555u8KY=;
        b=RqcwdRHXi2dAl995Ku5bZiE9Q3Uf9EWq2x8LvRjuRrJHlr7Xo2a10i3uAFbwzSQSK1
         gPUTIyfqw5xnUkA3pX7q5ltyhie4E6Tg2bT+Mr6w2xF+jVF9AffOc3JxGmsDRHXw0LFs
         /XrGrpSIqVEnW99fzssoyLVOE3LI85vbCCPNSkq6imU9RRGka0ONOdo9Mio/k7KYOPpE
         YFGE5SpSHLmSMlkSeejbmQLIbfgcJBZbz7ow0Q17CJGckKyDW+8sSRPK3akJe9H6PkTo
         vlrpSzmC3fRsC6tj8mnH2buzcyjcKYm17fbbeB3otV9zJBqhc/H509JGsDYJJfCPVutA
         vgqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758014214; x=1758619014;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sUch0bA/0jLl9tYIUalQbRg+wMEiSjsAuzBP555u8KY=;
        b=DEhO2arNCWk1R1J2RKpSvB3QMjxRZhEEhuVGTsmglK2OX8wCSsSCBMWBiEV/kEqib0
         thERkKKGbO/1x7u5N46aNohJsBzBx+Gestz6BFPULYJYKsJcTFIsaByTVHhqV1Kb8hYg
         5D7p4nWoO9A/SvzP9yLqsK2RrzvL17HU0ic5EYlu3QTwMGL5plk+jd/rZx0o1qTVpTaP
         lp40R6nSapspAryTay0b/eMse60iQLqNs/2sgxEeqlPt9bF3ZpGrUI57ZGYVpwM1mIIS
         tKoGJWEOQIPFOeh2zX2QsgvOwNwXFicqZGjVud9fHbJv3WmRbbekuFSEU1eUR8GleMOp
         hAkA==
X-Forwarded-Encrypted: i=1; AJvYcCUeu3JnlyBcn29Ira7AGSydWKmhiyuyq75S+ooVveUxkKadHZ9txR8p8m0tAmlP4KCD+mc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBqjwgfb218s6AguDOEhctK3hCdjPHOby0lg0wSUwtn6ATSYYB
	DLKAwiDJZk3f2LjVqwMJfaf8WnDp1smgzrel/VJwJIMF3DeUdEAhYDz9cegoTEAbb/SLHSrb01x
	QUXiJ2OoakzuicVQgMJQIjJDpjeJoJuM=
X-Gm-Gg: ASbGnctJVUWQu2m+LHgluHhwaTLumouJpvkUYDsHDiN8OxgqeKQPw6fbUQHCuK70LjD
	4PyNvYqOV98/dPZloYiSfHFkgzHl7+EMSX9OQ9CAdan9M76MgDOzTsnryeqtLzFEcoeYXmMY6XQ
	q0M42TcRVZeKmnFqp7Rd3rVBoc6qQ1LUisrCc4VvBuwhSHS+33L8ExXrCVlwVLvATy9VuFDGIlK
	Gila7RSQFJ8RkLfIfpW2wTD6n4Bjl1IV9Z9z1Ny+w==
X-Google-Smtp-Source: AGHT+IGbk/DmYwULfsHyS5pgmZ+fCif5Jx0w5Qw50Y1D1/HGLHa2MFOAaILRlGUx7pNvZsCQvbQDpmLllBmIgXVgycw=
X-Received: by 2002:a05:6122:251f:b0:545:d9d2:a832 with SMTP id
 71dfb90a1353d-54a16baaf41mr5253068e0c.7.1758014214482; Tue, 16 Sep 2025
 02:16:54 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 Sep 2025 05:16:53 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 Sep 2025 05:16:53 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250911-b4-pks-meson-docs-target-v1-3-a92c666ecef9@pks.im>
References: <20250911-b4-pks-meson-docs-target-v1-0-a92c666ecef9@pks.im> <20250911-b4-pks-meson-docs-target-v1-3-a92c666ecef9@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 16 Sep 2025 05:16:53 -0400
X-Gm-Features: AS18NWBi6z3-Vt74S3z9yH9oAeluyAdL7S0WlV2IRuqciw9sV_tKg-lF9O_tiM8
Message-ID: <CAOLa=ZSXXk9iwnU6a9BR-jfhs0XU8MXQqa8edpOajfORV2uY5w@mail.gmail.com>
Subject: Re: [PATCH 3/3] ci: don't compile whole project when testing docs
 with Meson
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000c3cce1063ee79402"

--000000000000c3cce1063ee79402
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Patrick Steinhardt <ps@pks.im> writes:

> Our "documentation" CI jobs, unsurprisingly, performs a couple of tests
> on our documentation. The job knows to not only test the documentation
> generated by our Makefile, but also by Meson.
>
> In the latter case with Meson we end up building the whole project,
> including all of the binaries. This is of course quite excessive and a
> waste of compute cycles, as we don't care about these binaries at all.
>
> Fix this by using the new "docs" target that we introduced in the
> preceding commit.
>
> Reported-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  ci/test-documentation.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/ci/test-documentation.sh b/ci/test-documentation.sh
> index 49f87f50fd..5e4fd8fbd7 100755
> --- a/ci/test-documentation.sh
> +++ b/ci/test-documentation.sh
> @@ -48,13 +48,13 @@ check_unignored_build_artifacts
>
>  # Build docs with Meson and AsciiDoc
>  meson setup build-asciidoc -Ddocs=3Dhtml,man -Ddocs_backend=3Dasciidoc
> -meson compile -C build-asciidoc
> +meson compile -C build-asciidoc docs
>  check_docs build-asciidoc AsciiDoc
>  rm -rf build-asciidoc
>
>  # Build docs with Meson and AsciiDoctor
>  meson setup build-asciidoctor -Ddocs=3Dhtml,man -Ddocs_backend=3Dasciido=
ctor
> -meson compile -C build-asciidoctor
> +meson compile -C build-asciidoctor docs
>  check_docs build-asciidoctor Asciidoctor
>  rm -rf build-asciidoctor
>
>

This makes sense. I really like how a lot of our CI config is forge
agnostic. I opened the patch expecting to review GitHub/GitLab changes.
Glad I didn't have to.

> --
> 2.51.0.450.g87641ccf93.dirty

--000000000000c3cce1063ee79402
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 99f90149e736b10a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qSkt3UVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMU04REFDQ2czYTZiQmk2RVoyNUw4R3pSRTEyV0FvbgphMFhkSXZUWHJJ
N1Fla0IzdlQ2R0JxemhkWitCV2dibDZCcmFkVlRTUG1mc1g0d3ZmajJ4bStHL3ZWelZmMUNuCnM1
N0hPY3BoR2xKZkltWWVwMWRWUllPdWVnU3FNZWtoWGJLUnZvamxScGpjYkJWeDJMQU4zSXdmZ0pq
NjNIMW8KTHN4c29CYXRxQmFxZlBZQnZ6N1lhazl2VHdYeTZ0Q1BZUmZPQnAzY210Rit4aVZhUk9J
M0ZuMXc4SVd4NFRqdgo0Qnd0QWtlZkJ4VlBGYkRNVWdtZTJvWDBoQzdtRDgxV2lDS1cvaWNJbUZL
KzJmZzFhY0FNaTZGV1BHcEp1cGhKCmVMbm5rOGdwZndHbmJ2Smt4MnJ4RVdLc25GSkt4OURybkw2
SjB0OG5qNjBBSHZ6SkdjRDE0SjZhVVMwaDhCSlUKamJYOVg0aHlMTlNJd1dsYlhwcTYzQWxpWGIr
eHJyUWF0bHlXb1ZzRlI4SzJ2SEpoclpiTGxXcGpuanpJd2I2ZgpodkloMnI2STFaa2NQVGltQmFO
Z0s4Mmw1a1I0UERjeXc5UnBRamF1dnBtSW8yeTVsUDdpcVgyYkRrSlRhZlVQCjlqYm1yeUkxa0ts
RzFtcURVdGtFOHpvYkMxbEtjVVBoS3VwUldHYz0KPTdtK0kKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c3cce1063ee79402--
