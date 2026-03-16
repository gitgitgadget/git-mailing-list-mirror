Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D522D27FD51
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 11:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773659660; cv=pass; b=kbPd+D3YBD02Jh8QVHdo5xCHbANhhd41O70ANmQPCwrmVemytU4kZiwdPkJZiEvCDdhVm++56oZsXtrPWG7r6jfVPO8IwtzKxpghSOiQY20460ap+cds/7Eznj5URGEEkbf5ovUUf6eNaQ6Oq7pq2US3SoD/BJ8KsMDweVYaVvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773659660; c=relaxed/simple;
	bh=ti6ZqORmhPgGDcDSoV30fu6e+f+5S/eB+fP7dw3e/0E=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=X3qgUUO5OTrfpvwGuxcIzhaQxqRWXps6H9YrwMRDeo3SmqqVjHhR4GqJQSaUYOCbZ3l9Qz/x13/rq+4Ls2QFVVoyocVoSiV+58jEsgHysC1NJ/yU3hfk6XrlOUl8OUhtOTyIKE5F65t1cTsAHwFkDgJ+Y0so5IdWTDrZEMQINeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZGixRkZ; arc=pass smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZGixRkZ"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5674d8be45eso1652847e0c.1
        for <git@vger.kernel.org>; Mon, 16 Mar 2026 04:14:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773659658; cv=none;
        d=google.com; s=arc-20240605;
        b=GpmGoc+od1v4IAZhlTcp2IWdWv7CVp0wt3k1n8qWLu0dyIHqmSsaMA+J1h6nYSB8np
         tYblHL7qfAT44qQ+/pjBCC31TLpy9E31PTitJ6oE9uYVUNSC6Qh8SgQPA9A1tRV2fbON
         7IRMe0SEQ/PminhYgDGieQCz0n2bvLgQ+5TtIDEtpN5ul1oM1cyNT09xsx9xlP7m9hVG
         Qn8KUAmPCzhhEAZRbmgb/OCjiAMCzkOAvVon4IhxIzh9V1U3j5gWHHIeuiuUPEP7nvoG
         JluWfeR5U0HN3maY7Z7i1sFF/Pvp5Fm5XYlcuQ1xzDR4D9TFcWWS9FFs/ZR9buy4CNlk
         FwCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=winrZbqZa0dn+7MulwjNow8NCUOqKZf0ZkrR94ZYBlA=;
        fh=5U2R/i8AZaq9ppTaxy+fscObKy0B+M6rkU6HEQGeBAI=;
        b=Fhj15ZhQDGB3nkmA8AOVazM2KUvu+/qHgLtNqB1ARREi0F/lq2k5Qrw9PiOajTzt1n
         H7r5UP23VRdskKYtUSWKtLEyHtY0npqcOxknWzC1mLkRJhoBSF0liN49JGCu1CZjvYtq
         xYlwcTsZZ6VaUVRXM093KJRmlsXb3yUpWyWiWODJ53mUV6p250eRHs4OnSXPGQQtVTe6
         tf9YziDD4/HJKQjizbAAks2+v255Kjp6ByfMAnKmu9q94GK5WTUTIrIBHwQSDt6blkKR
         cHs8q57joszBoklxLHmSZHFpvn4NBwMEvjaBi82VkIfjNYqDdWeULP/ejYYwoiSbWfLe
         IlOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773659658; x=1774264458; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=winrZbqZa0dn+7MulwjNow8NCUOqKZf0ZkrR94ZYBlA=;
        b=NZGixRkZV5vPrc0/utk4UHZk9Qd54FbLQavCsde23aNHZNVzoOU8kC4fJ404VF/8KE
         iVb/Wjdc4m53spmoAb+D3SRljM4ApSuc3ceVI1B71NBxSrFSmRCkDhKJkodhzC+CGSpg
         P9YwLFXQzmE/Vd+J5AU81TpOcg7IDLXgJmf0PQ0Q4uCD1QBhhu2jnEIs3J0WvVefFk3s
         l3qtO3zz0I3A5J9yO25wlyEUIQf6ldsLwkpMIXK9qapnA+C4UHu8Kt/2OgJIL+yA8joo
         DCwRjsSh9GPvmNAFf8AyU0p/dvGxGkX6yZGXa93ph5bFFiemwK0pdqKqF6XwVaQ7NEfo
         UUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773659658; x=1774264458;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=winrZbqZa0dn+7MulwjNow8NCUOqKZf0ZkrR94ZYBlA=;
        b=SSOePm2uYdYsgKrSIKGKCDNYkfbGnwIzNVdTNl14sllX7II4M16SvOy20cgMEEAt+A
         tejydPD4uGfJNMEq4uegGtATNEUACno3LUAqXCas7RZwb7O/fhLjsbrbFfCWtrCF6k/H
         UEG6VUUKG/F+dOQtfvE2X99QUjAX+/oS+L10ZPOK09EZDfCYCwwKkejRdSHjp2vg9tNb
         DcG7J9i4Xo8Zgzdh5iUGgQzzYXp1dJUrH9DkhGOpeArL5gzlFkyV0DPkd0P0zfY0ov+S
         w1u0/7BeFRax53HUdaSWuty7TXEWLbZ32S31iQZWf/ZUJaC2m/LqaqiNFN9fRTNLelKo
         5lQg==
X-Forwarded-Encrypted: i=1; AJvYcCXT7kKGSt5iUTHr8KGigYPQqKnUOdIulHzVHY5S3sct9XFhzPayF7UblzzUYRevqHBUtmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe1SNO2WY5pSoIaq1ZS13SKaqoLOB2Yt1o9v3+XGXGp7WSey4C
	DiiXJpdmxjEbqewr0EVvbB3rLCLajzgA0hu9OMOlhdFTnMQ9gryIBGL0wpcj1X3ovIfTllJCcad
	45jyHto5qDVjvBXDQDwW0bR9Z0EI2bj3aXGrA
X-Gm-Gg: ATEYQzz8p809BGFcUMsI3jDPFjvhP/8r+O0O/Meyq8EON8523ETf+Wwg6Ge8UXb4jGn
	otaTv+6N6UhUVj6P4tN1WrbaQWJLnGMb9PNnfoxdvh9lUJDkIOirGN5Oj6gJ/0yjjyaOdwKmgiu
	sYjDWV379ytgpYai0tNJQb81ybNS0rroPakLEmKUzYAO6WoFIS0F3o5NIk8b+OmuGmfZXF9wt9a
	HP/CGHXJAYHKqnirw3dat5jXGbytOUmACBG4QyRwrTR220c7Wkwbrwzaiq4B0sjUETVS+7YnQyr
	zuXnwoEAqsZLKNozRHyC53iLBzsy6ETYOSNkzD0AA+kydRWZx8+Z
X-Received: by 2002:a05:6122:2a4e:b0:563:72d8:ea6 with SMTP id
 71dfb90a1353d-56b6291dc05mr4370053e0c.10.1773659657528; Mon, 16 Mar 2026
 04:14:17 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 16 Mar 2026 04:14:15 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 16 Mar 2026 04:14:15 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260315231538.68586-1-jerrywang183@yahoo.com>
References: <20260315231538.68586-1-jerrywang183.ref@yahoo.com> <20260315231538.68586-1-jerrywang183@yahoo.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 16 Mar 2026 04:14:15 -0700
X-Gm-Features: AaiRm514kAWCqi8uytZ29hARa6gq3SyTxo6n0vyHpI_AYlNUqDB-NsFnjgAhjWw
Message-ID: <CAOLa=ZTpfHUySnMgCFMnvo2JcRSv8zqFP-cLFSs+Ab5Cy2zsvg@mail.gmail.com>
Subject: Re: [GSoC PATCH] apply: report the location of corrupt patches
To: Jialong Wang <jerrywang183@yahoo.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000d717b7064d22511d"

--000000000000d717b7064d22511d
Content-Type: text/plain; charset="UTF-8"

Jialong Wang <jerrywang183@yahoo.com> writes:

> When parsing a corrupt patch, git apply reports only the line number.
> That does not tell the user which input the line number refers to.
>
> Include the patch input path in the error message so the reported
> location is easier to use.
>

Definitely a welcome change.

> Add tests for both file input and standard input.
>
> Signed-off-by: Jialong Wang <jerrywang183@yahoo.com>
> ---
>  apply.c               |  3 ++-
>  t/t4100-apply-stat.sh | 16 +++++++++++++++-
>  2 files changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/apply.c b/apply.c
> index b6dd1066a0..904d1c3e55 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -1875,7 +1875,8 @@ static int parse_single_patch(struct apply_state *state,
>  		len = parse_fragment(state, line, size, patch, fragment);
>  		if (len <= 0) {
>  			free(fragment);
> -			return error(_("corrupt patch at line %d"), state->linenr);
> +			return error(_("corrupt patch at %s:%d"),
> +				     state->patch_input_file, state->linenr);

Okay so `prase_single_patch()` is called by `parse_chunk()` which is
called by `apply_patch()`, which unconditionally sets
`state->patch_input_file`. So this looks good.

>  		}
>  		fragment->patch = line;
>  		fragment->size = len;
> diff --git a/t/t4100-apply-stat.sh b/t/t4100-apply-stat.sh
> index a5664f3eb3..f99e439688 100755
> --- a/t/t4100-apply-stat.sh
> +++ b/t/t4100-apply-stat.sh
> @@ -48,7 +48,21 @@ test_expect_success 'applying a hunk header which overflows fails' '
>  	+b
>  	EOF
>  	test_must_fail git apply patch 2>err &&
> -	echo "error: corrupt patch at line 4" >expect &&
> +	echo "error: corrupt patch at patch:4" >expect &&
> +	test_cmp expect err
> +'
> +
> +test_expect_success 'applying a hunk header which overflows from stdin fails' '
> +	cat >patch <<-\EOF &&
> +	diff -u a/file b/file
> +	--- a/file
> +	+++ b/file
> +	@@ -98765432109876543210 +98765432109876543210 @@
> +	-a
> +	+b
> +	EOF
> +	test_must_fail git apply <patch 2>err &&
> +	echo "error: corrupt patch at <stdin>:4" >expect &&
>  	test_cmp expect err
>  '
>  test_done
> --
> 2.51.0

Nit: It would also be nice to see that this does work with multiple
patch inputs, where one of them is corrupted.

--000000000000d717b7064d22511d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1ae2ae4b2f873829_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tMzVnWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK0NOQy85NVJacEJoeTZKZENUb3pKV3dVYUp4WldiSgovV1V2M0VLd3la
NmNjUVpOK2lTNUZ6YVdnbUwyaHRwbG5FbmZhZk8wTTBlSEh0SXYxYTlJeVFCVEdHTWk3eTdjClVH
cC9GQ29lQmI0RkRVclZNYllrL1J5S2h2R04vb24zb1htczYyUUhrVldrZ0d0anJJa0FtTTNnRy9L
MkdrdkIKYXdTejZhZDVSTmRqc2l5Tmg5ME1DNStTQ2dYQVc1L2tBOWp0RzZhNmd5TjR3enNsQjQ3
K0VkaWNlS3JxbnhXLwptU2F5UEs1S2xvSFg4Vmxaak9QVUpEcnNEQVdDOERlVEVEdHFyNktUajdk
M2Q0Mkl1Q2Jid3ltUkdDT3FyRUUwCklUWnVwcVZCMGxwM0lLbTZpaGNFV2JaWUdkbjQ2UVErVzkw
bXBpSTQvbCsrZ1ZmN3RUbnowOEFxUDhKcFcrOUYKRWFlcTNJcVpnbXZXS3pvREpNWmpvc1BTaS9G
L1AwZCtlc3krd2UrT2ZnYm84V1Q0cHl4OURsZVA0MVJMVk95dApHbVJaeWh4NkE0YTM1SlVvSDlt
UmZ2N01JbHRXc29iUU5yTWRRTDNyYnF4MzJLL2pVYmZXcnc0TFMra2tLOVdTCmR3RjA4dHlyNFRn
UzNoNzhoRWhjQ1lKdVlteHhkd0VpaVdXWDhtcz0KPTZoYWQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000d717b7064d22511d--
