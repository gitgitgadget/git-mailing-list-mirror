Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0104C14262C
	for <git@vger.kernel.org>; Mon,  6 May 2024 11:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714995649; cv=none; b=aLz5PG4Aa0LZZmiG8NrXG8XSSiINLEsA4Y+uTL5xX99u+v8flZ5+SD0c3MgK8UF2x8f5zLXh//F7QYemEDxf5e9d+xydii3EpwLdCj7zLRYmYmvXdv5jBYK+jpUE3Uybehec9KsuGA+1SU4D8gNBnRrOqLuvJIV6+qMheX0i268=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714995649; c=relaxed/simple;
	bh=R1UX4rrbB2Fs16VP2P/ji4uab0Rf871xGdUizXDqBMU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hKzNEZL8IVoghzFll5urUJCX5LOiiUhA7r8++LuwdhHtVk6EqRF1/C3eZebg/OGhOAmPib18EUIM0AzEnV0Bg7GJu9/7jouQhwK2+Arobn8oGxaRCwes7VRMDkPhKBY+85hvgYVlpYX8Zz3qbsQMciad2TlO4BdS6sWA1y136z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnB9S8RO; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnB9S8RO"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-23f59d71d10so751640fac.2
        for <git@vger.kernel.org>; Mon, 06 May 2024 04:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714995647; x=1715600447; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Hal1LsSeqSBirDYd+rOPkevgnl/b1OWaJOnvZEwTSQ=;
        b=bnB9S8ROlYgEI/e2jAk4yzdDTAfViJfyvHFrdB2UuWX3cFstlfY5ajcBYtlqd3AK+Y
         vEDhgtanzFjv8L+AZwdv1V/t+fGjCDA8gh20t1FKmxwHhthIeMe6NL0XWB/9kXDrSwW1
         iPmU/pUlvANKK3K2rmvccsuoIf/lQ7DpS5Vhwk1P8kd1XC+M2OiQiGZ4h2bzfZ3HqFq3
         2V1JxqPdyPOjRUDUKgC2e6G26CWPo4uqtr8idFztC9O67ZobuZDnHAhFUXMOiULf+/4p
         EUHqrJLaDpUyldix6Ri85MbU8uNevIQSKwWajp1GHDF3hSz8h3YI+MM5G534C/uJthG3
         0uuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714995647; x=1715600447;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Hal1LsSeqSBirDYd+rOPkevgnl/b1OWaJOnvZEwTSQ=;
        b=FlSCD9VNdnMMDYpPQ3AGiINgv0GXuO+7bHJOMBdVMzTYD4glEFhI8Wik1V2QEKPirf
         PTLrTATVc197J7/ykCaDISl+KZ7xMEjFqGmsMVO1AhpLxTQRcZHszqsGKG+AcOCH+xuk
         hD7gCEUEGnWQVVojpJKur4aw6b/Oi8+LLhSsAQFZH4v6dnHhcmuDzpFkqWMRw/3XkQgW
         v4ltJCHFVxkuj6fDiO/1YthQtn4GrWsyEGiX5ZeevdzGjuMa8CFBFilBbUxOQxcSvnHT
         yOQnyn3CIxYa1Qdk4pegvu5ZM+WaKHJOJ/r/cm/Fasmj1f2Da/EsGRykshZF2Wsh+vta
         +B0Q==
X-Forwarded-Encrypted: i=1; AJvYcCV31qBtezShmoVNimrkK/9DnrQk4ys8C2To64b8VUoko74XCqM7zA2FYV7+vnKdgNeAbLjFtwKpVHpq/pQmE7HY8KP2
X-Gm-Message-State: AOJu0YwwDzXXO2i0uAk8u9LwiZnbMHarddUiVkmVw21DAcODUU6VrqiL
	5P8V254UYTsY+3/Ygp9huqHcvy9jtqLASOd0zxL2E2ncvKbKBAXaZMOf2NawqlIybU1pc9ihtQM
	Qfz4FTwsOIJ6pCUMQg68QH9uKaaY=
X-Google-Smtp-Source: AGHT+IFu22d+W0fGNIq1wIJ1YWkwtn2S/4HC13uAI6OranHTfHPa2/9d72PRvGZhkucG4gL3FdvR+A/HZ5zTWRCUP/M=
X-Received: by 2002:a05:6870:2212:b0:23c:6723:8651 with SMTP id
 i18-20020a056870221200b0023c67238651mr14056770oaf.11.1714995646840; Mon, 06
 May 2024 04:40:46 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 May 2024 04:40:46 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <pull.1716.v3.git.git.1714791848557.gitgitgadget@gmail.com>
References: <pull.1716.v2.git.git.1714711829698.gitgitgadget@gmail.com> <pull.1716.v3.git.git.1714791848557.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 6 May 2024 04:40:46 -0700
Message-ID: <CAOLa=ZSre3f+0SR-_migfkPONqhinobKjU=NnGOJ_sTNM_L5ug@mail.gmail.com>
Subject: Re: [PATCH v3] refs: return conflict error when checking packed refs
To: Ivan Tse via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Ivan Tse <ivan.tse1@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000526d540617c78a42"

--000000000000526d540617c78a42
Content-Type: text/plain; charset="UTF-8"

Hello Ivan,

"Ivan Tse via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Ivan Tse <ivan.tse1@gmail.com>

[snip]

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index a098d14ea00..97473f377d1 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -794,8 +794,10 @@ static int lock_raw_ref(struct files_ref_store *refs,
>  		 */
>  		if (refs_verify_refname_available(
>  				    refs->packed_ref_store, refname,
> -				    extras, NULL, err))
> +				    extras, NULL, err)) {
> +			ret = TRANSACTION_NAME_CONFLICT;
>  			goto error_return;
> +		}
>  	}
>
>  	ret = 0;
>

Shouldn't we also do this change in `lock_ref_oid_basic` where we gather
the same lock again for creating the reflog entry?

> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index 33d34d5ae9e..530369266fd 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -1091,6 +1091,22 @@ test_expect_success 'branchname D/F conflict resolved by --prune' '
>  	test_cmp expect actual
>  '
>
> +test_expect_success 'branchname D/F conflict rejected with targeted error message' '
> +	git clone . df-conflict-error &&
> +	git branch dir_conflict &&
> +	(
> +		cd df-conflict-error &&
> +		git update-ref refs/remotes/origin/dir_conflict/file HEAD &&
> +		test_must_fail git fetch 2>err &&
> +		test_grep "error: some local refs could not be updated; try running" err &&
> +		test_grep " ${SQ}git remote prune origin${SQ} to remove any old, conflicting branches" err &&
> +		git pack-refs --all &&
> +		test_must_fail git fetch 2>err-packed &&
> +		test_grep "error: some local refs could not be updated; try running" err-packed &&
> +		test_grep " ${SQ}git remote prune origin${SQ} to remove any old, conflicting branches" err-packed
> +	)
> +'
> +
>  test_expect_success 'fetching a one-level ref works' '
>  	test_commit extra &&
>  	git reset --hard HEAD^ &&
>
> base-commit: d4cc1ec35f3bcce816b69986ca41943f6ce21377
> --
> gitgitgadget

--000000000000526d540617c78a42
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 815ecda99ca2ee06_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZNHdid1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mKzFNQy80OWRaVUwvR3QzcGpkemdydkk2Z1BoRlJhOApzY2I4VlczbEZn
aldDb0JOSmRkVHpXK3pTWDI0d0tPQmEwUUNzUm1oUWtvME5SR2w3SGZVcHhOWERGT2tDOFVPCi8z
VHM4c0w2WnBTQzN5UWRsdS9aWE1pMXk3d1JxK0RURnUyZ0xVcVpXalIxVGo5a2dWakdkWVdMTno2
K1JCaUoKdXNCNVluNzVOb05TYlMybmpvaWo2VGo0engwQnZPWks5ekZRZFJtWTVkcS84aW9LWk9S
aFZiWUQ2RzV5VmIvYQp6Y0JoRlVpK0IySW9VSHc1NSsrMzgzV3lGcDhRRXdhM3dUcUFEMjhDREJJ
N1Q2YXV4Rlhqa1pKUVJNdlFrRUltCkEwUVdzQmRLb1VkNWlYQk5YTTg3bFVaOWNNbVhudTdJNlVG
TTVGL1RCUDJZNGNjUDVvSHZOVS9HTVZqdGkweHcKS3p6anYwaW84QTdJd29ZaTBDSjltWlE1R0JB
VmtvVy9iZEJVWlpCSE5TZVVOZDhDOFA3MGN1SnVNSTUvYWRXdgpSLy9IZEhiaFZ0UVY3N2E3N3lI
QVZNRXBzV0ZydGU0QXdvdjFyejdxRFlMYXAxdVdNMWVqeXJUTkFCSE5QQnQ3CmlaSjhKdUJ4OC8y
SUJLRzQ0dGNibFM5VmgyaGVWZUZkVU54RlY1Yz0KPU5YY2YKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000526d540617c78a42--
