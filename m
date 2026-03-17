Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BB5371CE7
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 09:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773740460; cv=pass; b=X5yIsrywqNAlc9ku2dQ1eErZVnbKkGO9Yr+n+s1PFwoPx95CVyEynjKW6/F0xmbfdq6HS3wOc3KCq7Z3N1rxYU6l0FhpsBoZS4Dpe8hJORaflSJxX47ik858BY+t/YSx87HLIsiLRzVyVoel8mjZTb1oGF3fiN5/E3V/NGhXFZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773740460; c=relaxed/simple;
	bh=kjSavBGVEYuk+ImplmjHT7/NxGgSGFugZmVQUAeMRyw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XJeLaDRYTf1RM/CQC8WNK1cIMpuYn8FRAZYzAyE6/e1Dsfdj1jE0WIJm9XP+xWkwA4RIHkBR3Y5QVqqEmM2CzzMiKobgoo6bkhkWntPo3/EG67JOX65sT+U2wfkxhREaOmxIQNLxhXKgDZUYeAMKvWZeDrIq9uy7+jrZPFrrYy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxNuwHha; arc=pass smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxNuwHha"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5673804da95so2093428e0c.0
        for <git@vger.kernel.org>; Tue, 17 Mar 2026 02:40:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773740458; cv=none;
        d=google.com; s=arc-20240605;
        b=IKQA0ySwyMZHwj5tGvqgSQ7eziuIL66b5ikmLBdHiqEyXr1N2yUdCJRIsG5NdGD9a8
         ABUOKuq5emrnXHZJTlpK2UDa+na9QWpHVK4Q9wi9VRLQXXbTkUeyI7iy/eRLFThNFoTY
         CGevnmf8p9989O3zU+KxrQWCGmgkTBWmhtJj75GNiEGCj9dqSO5xxg/fBC3nu6ZFSE1Y
         RVRDpSRAp1zVpcg79xUbxDVlYDGKDvkFbg/+GKzkkYDV9lcIpQ4jYPXbm3xqjrrauQWT
         NZtHkT04hrg5ipIYbrAfaosM3ltSTT/rPCJxLbyoFVMl3QNyACv5WP7dXPv4ZqEdmjtw
         NaWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=4Kej9RgCVdDxcZLwFbOOHl3c4WDW9UWP+udtcL5rsuw=;
        fh=ZNFe3D6Y7rkpz5eiB6JJZ5AKH0QzP57BKsaWjc5jAjg=;
        b=bVfR09tofqNw7exZ8lgA15OWZ9srC7zaMIQPYYU++hM8/5wIpr0XAf3K8RlPohF/dh
         ygrmdw/e607OtQ+QHeCBN96Hs//wVX6F/BkxW1QPWyQDe5hqMvem1y1B3Z+KL8muHiem
         hl5E5wTfzsjw8aQi527JhQ89xCuK9PeNJKPHDukkrDUCNiTyEXSyw/RTkAszMbfjEnK6
         H8UW3YnQoENGgrYHYpRQrw2K2TF9ZX7jeeYMSGOYVLs0S1mI2GqvKlDAEhHR4H8PFxcv
         5e0ZGl3i0qiREw1JcmayC+6+ak51hOnK9RonyK5q0xAG8jM+1wFW/EQrHje2xprM0xyf
         1l1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773740458; x=1774345258; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Kej9RgCVdDxcZLwFbOOHl3c4WDW9UWP+udtcL5rsuw=;
        b=IxNuwHhaQgXwNbrXm6dWm1dK0iI+vJYWsh9XM8My+xQCPrAVtDZ5H2NJ+WyrpaK74G
         PDVQ7+8g1b8Nz0D2CX6BGupv7Uap0J63yA2oKHuzvy5kiMEzC3kB6b0eMht6FhEzbs5X
         F5Q1+DsBd6kIlnMAKiwtXyYpy6ePHIHC8ERFfgVSgdFSnVU+h4u0Mc2ooWGrs1jC+6I7
         +pRetfn3bfus0isvvQnjKfoQPw6P2l+JyVtL2w3OEI6EqIhWYocu5UYz4+ZwKqu2x+9H
         AqUCeHV6+k97GLXLHI2d8ZXU+P0zHYXJhwTLPCr/Be6YmtEm+PAoUHcagxtsyXBqgjkh
         7KUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773740458; x=1774345258;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Kej9RgCVdDxcZLwFbOOHl3c4WDW9UWP+udtcL5rsuw=;
        b=KaQHcqdmmlCwsfwFPT1RVs60rnj8256kFiUPhqBI+VLtaVXyRlInId7OfNPfZe9ZeH
         P/oq9Pic8LpRA5LTGimThsSkVoAahqQebn+2u/xULjdIrXvJOfHcJLfE2/z5hnTJ3d86
         OYKtQKJllYFkEoNkYLsqGKzHREnwR/seL0jT9+SJ/fIIZs+QXjlmUSm3k/m2WV3gVntO
         CPgdF/EIfhHcgL43znxS+ly4d0CrwJDNq3Lq2EUvXn112+teUmw1ww2r5NjPAbNIMKPO
         9jJKdvrskfe/kGrNnJ1BYXXLjgnr8qZ+4hfgZ9XH8loru3qZJkJeW3GoS+3FCQ7AOtsU
         Iu2w==
X-Forwarded-Encrypted: i=1; AJvYcCUdt1JAuTUXqbjyesrm+LwVOn1EKt7PmswQPig7Jg3TmALvzAPhDzVPfZMNFBj37icXA+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPbkei2V7LcxqVEVAquzKIgC4am4Vlv1zQ+089+iYbmYdswO7M
	YosCYCY91eaxTmb44bzOhv1xLSpbTmK/YxeMXvJFPGMmhAyfT0C1eHReYYwfHQyYJPprYp7LZTD
	GAVirjt83+b6pHKawcJmfo1Sx+11OgiE=
X-Gm-Gg: ATEYQzz0uJpXUW+YyCsG5hPdnEvKJXjB68GcZThZmW+wE2tP+Wr0nQ9Vn8T/5x0Q+gD
	hRNpqOaEOzScqEJ9xGvob7ZDJsZ4CZFefEskAlp9KpirwfTLN6DN6wkp46nkgI3v/PEXsp5klbO
	yx0EI6pBWUL64eWeKFJbVU+rP6wjhSxXEzitaDzHgnv4mgK6ptxkxvqb7cPmX81Qm330GIApFKu
	x5ynnDv5q8UHM0hb3uzcun7XeCfyBKk97Oz46QsW7Sfd/4/MKO5EFOnnMyyAUYMCDJGeUbXPoU0
	EciA3Bif6Iv9tPJ7mei0CSRyrkiOS2fjeo2Bps7/Iw==
X-Received: by 2002:a05:6102:508b:b0:5ff:ea33:2c7 with SMTP id
 ada2fe7eead31-6020e58554fmr5025702137.24.1773740458553; Tue, 17 Mar 2026
 02:40:58 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Mar 2026 02:40:57 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Mar 2026 02:40:57 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260317002235.6121-1-jerrywang183@yahoo.com>
References: <20260317002235.6121-1-jerrywang183.ref@yahoo.com> <20260317002235.6121-1-jerrywang183@yahoo.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 17 Mar 2026 02:40:57 -0700
X-Gm-Features: AaiRm50UxzRHmc0UiU64A1lor1spfVUQd8QReyPGKeAl0mighzvbz40xiF0a0LE
Message-ID: <CAOLa=ZR8SZRN_xD29gshW3sujncuvhVSVh_9w=XpCHTcCf13Gg@mail.gmail.com>
Subject: Re: [GSoC PATCH] apply: report input location in binary and garbage
 patch errors
To: Jialong Wang <jerrywang183@yahoo.com>, git@vger.kernel.org
Cc: gitster@pobox.com
Content-Type: multipart/mixed; boundary="000000000000f4ccb6064d3521ba"

--000000000000f4ccb6064d3521ba
Content-Type: text/plain; charset="UTF-8"

Jialong Wang <jerrywang183@yahoo.com> writes:

> Several binary parsing paths in apply.c still report only line
> numbers. When more than one patch input is fed to a single
> invocation, that does not tell the user which input the line belongs
> to.
>
> Report the patch input location for corrupt and unrecognized binary
> patches, as well as the "patch with only garbage" case, and update
> the related tests.
>
> Signed-off-by: Jialong Wang <jerrywang183@yahoo.com>
> ---
>  apply.c                 | 10 ++++++----
>  t/t4100-apply-stat.sh   | 12 ++++++++++++
>  t/t4103-apply-binary.sh | 20 +++++++++++++++++++-
>  3 files changed, 37 insertions(+), 5 deletions(-)
>
> diff --git a/apply.c b/apply.c
> index 700809f3e6..84b4a569c5 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -2110,8 +2110,8 @@ static struct fragment *parse_binary_hunk(struct apply_state *state,
>   corrupt:
>  	free(data);
>  	*status_p = -1;
> -	error(_("corrupt binary patch at line %d: %.*s"),
> -	      state->linenr-1, llen-1, buffer);
> +	error(_("corrupt binary patch at %s:%d: %.*s"),
> +	      state->patch_input_file, state->linenr-1, llen-1, buffer);
>  	return NULL;
>  }
>
> @@ -2147,7 +2147,8 @@ static int parse_binary(struct apply_state *state,
>  	forward = parse_binary_hunk(state, &buffer, &size, &status, &used);
>  	if (!forward && !status)
>  		/* there has to be one hunk (forward hunk) */
> -		return error(_("unrecognized binary patch at line %d"), state->linenr-1);
> +		return error(_("unrecognized binary patch at %s:%d"),
> +			     state->patch_input_file, state->linenr-1);
>  	if (status)
>  		/* otherwise we already gave an error message */
>  		return status;
> @@ -2309,7 +2310,8 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
>  		 */
>  		if ((state->apply || state->check) &&
>  		    (!patch->is_binary && !metadata_changes(patch))) {
> -			error(_("patch with only garbage at line %d"), state->linenr);
> +			error(_("patch with only garbage at %s:%d"),
> +			      state->patch_input_file, state->linenr);
>  			return -128;
>  		}
>  	}
> diff --git a/t/t4100-apply-stat.sh b/t/t4100-apply-stat.sh
> index b3d93d8ed6..8393076469 100755
> --- a/t/t4100-apply-stat.sh
> +++ b/t/t4100-apply-stat.sh
> @@ -125,4 +125,16 @@ test_expect_success 'applying a patch with an invalid mode reports the input' '
>  	EOF
>  	test_cmp expect err
>  '
> +
> +test_expect_success 'applying a patch with only garbage reports the input' '
> +	cat >garbage.patch <<-\EOF &&
> +	diff --git a/f b/f
> +	--- a/f
> +	+++ b/f
> +	this is garbage
> +	EOF
> +	test_must_fail git apply garbage.patch 2>err &&
> +	echo "error: patch with only garbage at garbage.patch:4" >expect &&
> +	test_cmp expect err
> +'
>  test_done
> diff --git a/t/t4103-apply-binary.sh b/t/t4103-apply-binary.sh
> index 8e302a5a57..f2d41e06bc 100755
> --- a/t/t4103-apply-binary.sh
> +++ b/t/t4103-apply-binary.sh
> @@ -179,6 +179,24 @@ test_expect_success PERL_TEST_HELPERS 'reject truncated binary diff' '
>  	" <patch >patch.trunc &&
>
>  	do_reset &&
> -	test_must_fail git apply patch.trunc
> +	test_must_fail git apply patch.trunc 2>err &&
> +	line=$(awk "END { print NR + 1 }" patch.trunc) &&
> +	grep "error: corrupt binary patch at patch.trunc:$line: " err
> +'
> +
> +test_expect_success 'reject unrecognized binary diff' '
> +	cat >patch.bad <<-\EOF &&
> +	diff --git a/f b/f
> +	new file mode 100644
> +	index 0000000..7898192
> +	GIT binary patch
> +	bogus
> +	EOF
> +	test_must_fail git apply patch.bad 2>err &&
> +	cat >expect <<-\EOF &&
> +	error: unrecognized binary patch at patch.bad:4
> +	error: No valid patches in input (allow with "--allow-empty")
> +	EOF
> +	test_cmp expect err
>  '
>  test_done
> --
> 2.51.0

This patch looks good to me!

Thanks for picking this up.

- Karthik

--000000000000f4ccb6064d3521ba
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b91088d51d65663d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tNUlhY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNlE1REFDQTdjNDE5YTh0UHFHMjFQbzZNUzZkK0lJcAowWDhwL29KSm5a
YXJuR1lva1NGak43L29pZk5YTTRiTEkwbzJvWmMwc3F0RHJVRS9iQVlIZkQybnZOUFJNa05ICk9L
azZxUDdIYXRQUjBjVGM5VHJETEVWV2tBa3VtYkxEeEtIYldlWFFWaGFJWjMxSmlZNnlqUzlYWVYz
NE4vcysKVmNJUDRPeldKMTBrRmRkYkVZWmJYNHIzdGhZSEh5STY0clhNdHk1ekFQVHJ4Wm1GSkFK
S1AyNWRUazFsTHg5NgozV0NvY3U5amZxTFhCR1VWcFd0YTN0T1dBS0dtaWdXZGZZblhEYnQ4NTNI
cWJuVmZUc1BrU1VseUlyRkJRcjRvClY2WUp3bHlQc3RMay9IcVdsbTJINmhWNU5IbU12c01GUXZz
MVhoUDRVaVQxSmJ1REZnWnZTQU9TejZ1V3RTUnkKekZvZktFcXJ2VzQyVUx5bVFEYWl4SjJoTGRZ
NFdnRGMrczlpRHBuTFQxdjZocnZmSEVTM1hvUGdHY0YrcllOeApvZ0MzTzdyZDRWR2JqQTRmS0NN
dkl0MFJYWC85TWtTLytsZGlmQjRKdmdRVVZFQmtyV0NXL1c2dTNjWDVLdCtVCjMxVmVPTkJQUDlw
K0VWRmRaOHVEZDQzVVR4a3hMbmtrTEZYR0VBMD0KPVh5aWUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f4ccb6064d3521ba--
