Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794395286;
	b=IVGwNn70yaImV94Iy0VzUufu+bf6vuulNAocRfO4BeCDx+oK2i8EICVrey0AQXWiFxhd
	 JKNlfPURK2A+kKJ+NVjlC1GMnWOjKRFIV1t9PtsXmNGeuPWBkEP3+0p3olZ/mvR6UFvcQ
	 2LdaGhUI1kJhbfcwcwh6PPg6TBp5xc46AP2sEt1nX6OUioWrrHa0RQNhxfz1uhrcy9Mew
	 lntd/7MW6FHDImkRBogLrIbRKxdl37uYQpe7+yAaQvxMTlgLGJfvZTkz24kOztQ0MsJ6d
	 bAMvGcedqqDAyNcZkcOThCNAi7TgcvgG3oV+d8RFe7QZtFzyx6Uk0TzxhZofzYMXbMg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794395286;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=h2Mm4YRhyPIUwGghY+UqRdOZpSr7cgC0XIZgLlC15yU=;
	b=k0zDeAcPM8HFc70/k5bGCR3VSiIOkajIv98Wz/iN3Ig9anbA7XvjEX/gzKbTMnnTbQ7b
	 BSlgCuZl6jKyrRhNkaAwlLn6M/myHHSRasoWDDHFlKI4XivKDUZsI3qJgOkx/aPfxNr3f
	 d6UoehBK4o8tf4Z/mORb7zJnb3JgDJLGIPxyakrSPiNcS8IZ1qkVu0SvBGD9h+vNv4GcB
	 /bE7UYckVbvqRGDgFrdBfj5l+fsRPC5Taljf13G1NVaDOvcrRUkKbpePkfvg+M4Nn2fcP
	 PsCb58kC1WBRYH+yMlWYlE/U1fvEABUq/pHQjpN/dkJe6BCkC0O1zPVaCRLY05FPd2A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gAkt1jUD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.48
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4CD606A8A9
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 11:08:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE4CD606A8A9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gAkt1jUD
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-99075306daaso1486425241.3
        for <git@vger.kernel.org>; Wed, 11 Nov 2026 03:08:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794395285; cv=none;
        d=google.com; s=arc-20260327;
        b=gZsnKHu0pRMNWvbgzvPNtGvyB7FTPmjHpzdtL3riu6XKYHeafbMFh9FFZf9wW/hU7R
         7SKwje+FVeqduggBxSKkGWY2VykQW6SAIg0NJPKXnEsfLXZmGqKgL372jkvCe/U02JhG
         iqM42dJ0zAdhHrHY5HJ50yq97RNIhMbfU8rZArEOB2/yz22uy5wS9X5fFu/c1aZulfST
         kiAwbUqexuVDArduMZ2oWdLu7N/uMruLNX33jeTqyZy1dhAGXNrHMgpNxrj3vV0JrRyY
         UOlbc65uWIMS4nANZvPqtDV5E5mvhA4nlTnvpnl+w5+u3VuLcAEL7bebn7LJtgXBG+hF
         1NZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=h2Mm4YRhyPIUwGghY+UqRdOZpSr7cgC0XIZgLlC15yU=;
        fh=i/0/6E7Ukg/WJkIGstX9Kw/YwJp+B5ZPqosqQ46OftE=;
        b=oVPeTjvbS0eCqmXJXQy4jIQwVA2EA7/uqVYQbawwfEYt7ApC1h5xUVPVGYR0iny/Qo
         kp/GbadEe0Fe3LiGXHr3kZOctYh5T5MNMqTTw/l6KM7V46E1ncPAbfL54Z2I6wzc2Hw8
         pjuYZ4QxETbKVIGMGDMH1KU3W2vNnmCETYw5pIIFEjxzaVpUr7DTxDeb4cqyukhsXGuF
         F5Jhwy6iSa3UDk48heIuNp/0lcq/7Lw1s34QI9tJBvsVfnzYK7G1ykN3jV4gLuv2vk/r
         JF2ZT34Ub7xb5760Ys86EkFFo0fImOM6gQBiPmKdly7Dt8dwt1L90q+ySAt8dOW/NqMp
         wIFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794395285; x=1795000085; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h2Mm4YRhyPIUwGghY+UqRdOZpSr7cgC0XIZgLlC15yU=;
        b=gAkt1jUDVF+JaFQnMPn1/JzzddrhtcXnu0IuDnIM3lXgia6ejxHI94DCsnSNNCO3vh
         pvP/L9ei3CDUMMTgXhnEXgdKsL5uxDjBvaIhdkQG6TwmPfNKJvD1qbc8wp5rNmhREu/N
         6uGCregKKfyazT88XOAp41LTL0vtTBh0i5anmYNxLFZal4A2G5r/tzFLflAKvEw/CdfX
         NivJf5/dZxh/YXV5nzlNeXVoeQOJB+cvUHWhrNM0BZjuXDCCrlTCtthzMdOs3mj4FN8H
         1+Z8OrEMkujmRWaLX7gUpWRImD6fuCgu4DVwe9IQx4/kHGNFUGZAzjXFyPeXvAgByIOm
         AVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794395285; x=1795000085;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h2Mm4YRhyPIUwGghY+UqRdOZpSr7cgC0XIZgLlC15yU=;
        b=HTf0kd/n6A1plKenwLVDfRd3u3e37x134S+QarPctkfHY4pusLfMS4u8ou88CZzll2
         f77dkm6DAc+wG6OHP/7klGUoRqXcsyjalXa9Guq3F6Rgr2mFNHY+HUUp31XGMlZhexfk
         DtIKKxE8VZaQjAEbR1Ea1fFZgBx0g+zjyjpGVC9OWp8v9fZlCZJmnquW6zfSf9ywvhOY
         fkrGLX6FU44usGGvmK8ujrAusHT0UWsGnVxJSxeBGw6HsroPI55hijTc7AEfePvahQs2
         mA9ixBSswuFCRo2XsYzwB2zjHMQ7Bik2W/s86/fB/T2k9RvS5+iRCYodXUCD8CsLt0zd
         YwIg==
X-Forwarded-Encrypted: i=1; AL+hErE31le1y7+dbLMdKmKQLkGK9cgARszGkaNFVAWKb8dVW1XLPqF21Y724pxdjo3sYYaNbek=@vger.kernel.org
X-Gm-Message-State: APuU4Z/dK6jsceqjeeR1qpzDisFnAvBsZBVaWSgVfM7fuxPEDDYgEg9H
	pnMPVTzChFyPzYKW9q+vaBLn2Q/Qc0D1TghdMVtXnwyPlLRxGEb8xsljl4ytqlSFtWu7XlQJXsz
	JmTEht7y6FgyDD2r9neVgNlx3K803YDsBXQ==
X-Gm-Gg: AYBFou1ISyaR9U/0s6hz8EDGikrS09egBS0POvE7m6tQg9/MvE9lrAkhP+74DHF0usw
	OkclYj1/UZyE5Vs9I5dIW/Iw7kxNDslu6ep+N7c9k1vDnawUf+jpAA6p4z23Pss0YlzYgKDjKkx
	u/0qa+G8jMo980dVZSKpoSMq9jtqoR30QzGcEUEV0l2J2BG7ytUk/zApuawjpafv8j7lBt5CNh4
	q0UoLnymOdiwG163toZeBzDVzDGSLYXy5Lk82CXo17HPgcucL/m2pMfM2J+a6Wfn1tZFeHjF8Z9
	vh4SZjufM97G2lErnlCbyCcfH8IY4bzKy8ZiYeQN+e/SsamomKpcwWF2fJNnUBSJZe0AXrlx8Mg
	HZhDtqlM+hUlw0619c6hEVMm7jsxtw5QktZmBSA/b0cK7Plo1xbcrH8lioAJmAEH6n7J2PC9Iqc
	0YIyxOmHutTRF61DnwjsDyAtOx8XBu
X-Received: by 2002:a05:6102:374f:b0:7d2:cbb5:71fe with SMTP id
 ada2fe7eead31-7d506107ed9mr715745137.29.1794395284783; Wed, 11 Nov 2026
 03:08:04 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Nov 2026 06:08:03 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <pull.2305.v4.git.1794385537870.gitgitgadget@gmail.com>
References: <pull.2305.git.1794251100.gitgitgadget@gmail.com> <pull.2305.v4.git.1794385537870.gitgitgadget@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Wed, 11 Nov 2026 06:08:03 -0500
X-Gm-Features: AclHuK86dkj0D4qgRhzprsMH4wY8rnNDEvQrCOjLeW80tdbHj0ZVoWkOEeWmXk8
Message-ID: <CAOLa=ZT7xKFf5_Q5hBfstyeXfTA=TDfzS-Z7mig18rZLgLKefw@mail.gmail.com>
Subject: Re: [PATCH v4] archive: remove USE_THE_REPOSITORY_VARIABLE from
 archival modules
To: Srujith A Poojary via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Srujith A Poojary <poojarysrujith@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000896d21065ffe354b"

--000000000000896d21065ffe354b
Content-Type: text/plain; charset="UTF-8"

"Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Srujith A Poojary <poojarysrujith@gmail.com>
>
> Refactor archive-tar.c and builtin/archive.c to clean up archiver
> initialization order and header dependencies.
>

Please read the 'describe-changes' section of the
Documentation/SubmittingPatches. This message here doesn't explain
anything.

[snip]

>  archive-tar.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/archive-tar.c b/archive-tar.c
> index a1c66024d4..1b376d048a 100644
> --- a/archive-tar.c
> +++ b/archive-tar.c
> @@ -531,11 +531,15 @@ void init_tar_archiver(void)
>  	int i;
>  	register_archiver(&tar_archiver);
>
> +	/* Set built-in defaults first so user config can override them */
>  	tar_filter_config("tar.tgz.command", internal_gzip_command, NULL);
>  	tar_filter_config("tar.tgz.remote", "true", NULL);
>  	tar_filter_config("tar.tar.gz.command", internal_gzip_command, NULL);
>  	tar_filter_config("tar.tar.gz.remote", "true", NULL);
> +
> +	/* Load repository config so user settings override the defaults above */
>  	repo_config(the_repository, git_tar_config, NULL);
> +
>  	for (i = 0; i < nr_tar_filters; i++) {
>  		/* omit any filters that never had a command configured */
>  		if (tar_filters[i]->filter_command)
>
> base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
> --
> gitgitgadget

So the code only adds two comments? Which isn't what the message
suggested at all.

Taking a step back and reading your previous commits and messages seems
like we're talking to an AI model. I'll refrain from reviewing further.

Thanks,
Karthik

--000000000000896d21065ffe354b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 17e86be12a72735d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yMFRKRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMzRtREFDQzFTaHhHaEkzK3J4Ylg0UFJDa053RUcwYgpRZFlKZ3c4Rkh0
K0VvbUxZWG9xMzhvcmFSUEtlWmFhQ2RzLzkyLzlMendKOXB2QWlmbDFFVnNJSVAzb3ZZUmtMCnpI
Nk1NTHFzNGIyVFJqYXlKT3MyQ0NRRVdUN1ljM29MVmI4OUlTWGZLTGxGTTFXSTVGSlRVRHk2eDNB
YWdCUWoKbkFxbzFYWEp6cTBHVmdhRmRnMGtNd2N4SnA2U0xKcE8xaTBteEYwbGVWUjJGY1Q4dkxq
NzB4R3RpblNCWFRYQgpVT0FCMGY4SHJTdXh0U0FlZUVsdlg2TXJBZk1Sdzlab1pZeXhYMDFIaTBx
V1d3bHhsWDlRWWp6S3JKM0JlM0k1Cis0eTlyQU0yVk9WYy9WU2RRVUhIbnIwNTQ0ZEVBWUg2c2dn
Wjg0N0loZDVkRjZIejh4VmZmcWxQQUp2aElqVHUKYk5rczdqTm5FSE9uK0NXVVhuR2kzSDF6MXdt
UTlFTnZlUzdxSEJWZEIwUnpXUTFaVi9uS3R1MUVuYlhMK0tKZApxSk1qdTlLVldDayt3dlhZTU5X
c1UyVkMvM0wvd0Yrc3d4U1BiMlRGcEZram5FazN1dVh1N3ZJdTdwbC9IYTdpCkdyTFNFeXk3NG5j
czlyQmRjVW1OVk1GVFpEQ3JqNHFndE5YUzRTdz0KPUNhNzQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000896d21065ffe354b--
