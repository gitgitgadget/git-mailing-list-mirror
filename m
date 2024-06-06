Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE9F185081
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 10:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717668043; cv=none; b=LuAIctq+gTkGrm6SV47bMGmSYQmlCuOgOs9da0TbkAIjL3wa6dm6ht8JewYFKeBviwVvgKSDcQQ8reHirveAUv1MtF7pHDV7XwNqw7uKs1MsKAoWWUEu5KjUrZKcn5r6iYjmk9mTbU4hlr8zuIN5RZtWLIKL1vcWx4pTX+A4SbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717668043; c=relaxed/simple;
	bh=PFXX5bL21OSGg2Pnlad3jjV/+y05KmS7oecgaF3j4Mk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=lZYA1mqe9Z6NVt3G8dZNpZb1ftrqhE/aPp9Qwhdfdc2lcb12t6Fyd/fYtzzcitOb7p/CKxJrSMnElvR7jp1ADSMMrzD5nZaaM/qGC+mcbtrwjUpQSUkVrGFW+6oce8pSpdDzHjmUs1rxDKM/gVODUlN9Zlw3u+Q+ufUCu/jKmtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YlS35Elg; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlS35Elg"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3d1fe4f5bf5so362150b6e.2
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 03:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717668041; x=1718272841; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qv9c0RZCVygVhee6aLJoBKLPrRFoTWo2c6vSHOv8bP4=;
        b=YlS35Elg6DAP6muGaKNvxeSNLTwDVR4jUqIfQGA51T7crVPEcPqQRXTPpctWlaKZzD
         fDQWLfnq/RqyBXG89MrFXxCTRj2Q+mE7QDBLaGc9g9tCE0bjDvwb4v/qIzAH3S5F5eo6
         /A15x8iD3RTSEuCeIrfjcNYOybz+0sTDa7cuWr5ZOZVOcTzfvzeZKCka82vffpfI6LNh
         IobPsdhF1Ubbz3gWUdWnbVt1T5eBofPFyUTlj5GfzM1i7XTHa7r0e0wxVbbAg8MJxtu/
         lOnc38NtIzJ80tlVra4bAemBmndFFHCrv9rLb9vOvoHSvcxLsBGOyflQ55vnGcpMii8P
         UpNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717668041; x=1718272841;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qv9c0RZCVygVhee6aLJoBKLPrRFoTWo2c6vSHOv8bP4=;
        b=gl+rWTRjgQZl4ytCtb4HB1gtfsZXtABtrVmyrEeDKlcX+ZTrJM0WV+6jiqIyRtLGKf
         MlLMZlZdU4qM5RT3gxaL86q1gUgrRGuz2H1s0cdyOayMszEetV2h8F7Jv/6nh4SQF/Mk
         QAjGXkyp0rYqCk5ekzV6TQl5CtYSxgU7OQEyNJAdKr0NDXpTPfjG4ZFFoJ3wNdqfjlx7
         ozcBrEWX/Nzc8QRFetQBeGqPg+Pm/x2EKroEsaQJdBBvkPm51O+hRpDpd2wjhnlOT3NB
         Kl3PF7vw6mZCdfhQF2Cm+LmMLRfp+OczrOeNlm7vczOuGq0wczHwBzk8RzC/ul4rcgcn
         JZCg==
X-Forwarded-Encrypted: i=1; AJvYcCUXQfdQkoVKaCXdkOnLJF2lGKxjjQ36b9Z7TSPDri5/GDO3iKZ+gbnMhdCG48G6HOOTE0ht28+CkG5Jxq/NcPB+Ws8w
X-Gm-Message-State: AOJu0Yx4p63Y9t/yye+x1xFGv8YFd8Lb1YHPVmin7YVZqCIeAHUSatUM
	uXT4GRR4j8BoiqtNiHohmbbXuQWJ8JgDYnJgsQSEMw74a+bDVr520CFNVPNoY1F5Gxkr7q+VfSV
	UvLoJ0cHD/oVBRcwhPApHy+xC9aQ=
X-Google-Smtp-Source: AGHT+IGmjREHrVrimFuxFLd/T9Gx4k6Qb1+DXapfseCL1LjPLxFgJQnBKHrMTtbCAMcnp8RFg7KknWSFw88zXvp2B1o=
X-Received: by 2002:a54:4704:0:b0:3c9:76b0:753b with SMTP id
 5614622812f47-3d2042959f2mr5242090b6e.14.1717668041235; Thu, 06 Jun 2024
 03:00:41 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 6 Jun 2024 03:00:40 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ecabbb74e19ea773fd23719bd7fd4937b29679e5.1717402439.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im> <ecabbb74e19ea773fd23719bd7fd4937b29679e5.1717402439.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 6 Jun 2024 03:00:40 -0700
Message-ID: <CAOLa=ZQj1UrNO+nOxhp2kaO+F1hHDE14FMYi74Eg8sMAgXz8OQ@mail.gmail.com>
Subject: Re: [PATCH 02/29] parse-options: fix leaks for users of OPT_FILENAME
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000070bc98061a35c13a"

--00000000000070bc98061a35c13a
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

[snip]

> diff --git a/builtin/archive.c b/builtin/archive.c
> index 15ee1ec7bb..f29c0ef6ad 100644
> --- a/builtin/archive.c
> +++ b/builtin/archive.c
> @@ -92,6 +92,7 @@ int cmd_archive(int argc, const char **argv, const char *prefix)
>  			N_("path to the remote git-upload-archive command")),
>  		OPT_END()
>  	};
> +	int ret;
>
>  	argc = parse_options(argc, argv, prefix, local_opts, NULL,
>  			     PARSE_OPT_KEEP_ALL);
> @@ -106,6 +107,8 @@ int cmd_archive(int argc, const char **argv, const char *prefix)
>
>  	setvbuf(stderr, NULL, _IOLBF, BUFSIZ);
>
> -	UNLEAK(output);
> -	return write_archive(argc, argv, prefix, the_repository, output, 0);
> +	ret = write_archive(argc, argv, prefix, the_repository, output, 0);
> +
> +	free(output);
> +	return ret;

Since output is passed to `write_archive`, we capture the return and
free output. Makes sense.

[snip]

> diff --git a/builtin/log.c b/builtin/log.c
> index 78a247d8a9..4e4b645a21 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -2021,7 +2021,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  	const char *rfc = NULL;
>  	int creation_factor = -1;
>  	const char *signature = git_version_string;
> -	const char *signature_file_arg = NULL;
> +	char *signature_file_arg = NULL;
>  	struct keep_callback_data keep_callback_data = {
>  		.cfg = &cfg,
>  		.revs = &rev,
> @@ -2559,6 +2559,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  	strbuf_release(&rdiff1);
>  	strbuf_release(&rdiff2);
>  	strbuf_release(&rdiff_title);
> +	free(description_file);
> +	free(signature_file_arg);
>  	free(to_free);
>  	free(rev.message_id);
>  	if (rev.ref_message_ids)
>

I see `char *description_file = NULL` already and it is also used
`OPT_FILENAME`. So all good here.

The rest of the patch looks good too. This was commit was quite easy to
ready. Appreciate the neat breakdown.

--00000000000070bc98061a35c13a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c4af10911d1e9d73_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aaGlNWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mKzFYQy85QkFjdGN4UHo4Z1g0ZUl0OW9wUVdiaHlzOAptWmtwRnA0dFhz
Wk9RcS9RL1BTNU9xZ0N2MjY5SmlKK3FFQThWUWlhZXNBUUtJdWZMMFl1MWgrMmt4OTVFa3FJCmtn
T3hrR1U2ck1wOVA4NC9jQTIxTG5Vc1htVDd3T0N5aVRnWC9UYTBaanhTclY2RjQ5UmZ2M21MYUlU
VDg1YTIKaEdnQzlaRzZFaG4wUTY4a3Q0Um1VSVg2NzB6N05tUkxrRExkak1RZFNyRUtzeWRFZTNj
enh1TGVSekFvUmw1Vgozc2x2MU02TUdUMHRYZ0hpYXBtZnd1SW53dHNTMjRHWGpkUnNqUUtjNitW
VWpOblRaZEVNbTJ6R0VobVQ5NDRVCjhqNlVreHhqZ1BlaVRvOXlQZkxDNzRFUjlCdVJacW9Yb2M0
OGdRMTV2OE5FQzJkQUtzcFdSM1hRY3ZmbE83Tm8KT2M2WnNIcXpvQUhHKzR6eXRsYlhsMDUrUXJx
UThTYk9UMlRVckZSWGd3RUswODBQVHRFZkZyaW5FaHUwV2VETQpuL3lOU2xxby9ObGN3ckhMekJT
SWQ2ckRscU16dHpiWFE5eHlFZ08zRDVndDhCcTM2K3F4dUh5SDhFKzRwdXhVCmhwdDVXcElCUm9P
SWVURm1jNjJqdHNYZWsyai9kUU11bk1ZQm8yQT0KPUtnRCsKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000070bc98061a35c13a--
