Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2154CCDE5
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 11:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788262575; cv=pass; b=pMaEYYlZdpLBEmWZ1wmrNPj93QfEnvC79Cym/D+MMG+zxiJ9PBWlqJlhTzq2nlxAWI2SsOqta2OAkaT5izcrtRYMhT3soTS+RfZjNemcaiVtxPzxL6Qm0aMipKZ+JQ8uWFWaRxMwF+S6I9WLD9Mq7KnuT6k5r4YURHoQ4MiXBTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788262575; c=relaxed/simple;
	bh=aVd5BxcvZWlSGFRxkuCiEUDiNIKhlvgJbcF1Kkwt9+k=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=TB8q5UeLy/TgkZyDCowohJqUMZHTcvwDo3qjpQrX0cdlj5sFZRbjuuPuzaLg7EUwkpwDkL/tv8Ki/X6TqIXuJ9sgULuV4R09HeMK7zfZeyImOWjmbRkghHRQcyKpTT5zxfWLFSPChnmM5UU2ZwAHaUJgLI2AEzhOPAZzOjVE/oM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fM1UGOm/; arc=pass smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fM1UGOm/"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-7841b831381so998986137.2
        for <git@vger.kernel.org>; Tue, 01 Sep 2026 04:36:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788262572; cv=none;
        d=google.com; s=arc-20260327;
        b=p2LltWTMeFyY369o/UTcm7gW7PNKTuTL2Wh2GKuFP8HDXznkSKY/XK/bBS+DaP01yK
         p+IoEVDmaOlY9dPpUi6CLofLec+dun4l0oiVo87srqwGTpdyPouRxfd4GHLkXi7N5/3u
         y/ogLmd7PwSOYU62CSjEFQIIzTOmvy3w6rIuzyWfPm/c1BeaynGQODrgPh6f7xvAdhz7
         TlI4oMRYuKKetQZLXmnfN2dKKh57pb9DSzqfI2DvNPQVcaOWdw9yz4+AG6+MGPADpzCu
         RAcCVqRqhu95u8W6KwBcmXANiiy1hve6SC8D8jSbqgE6HDyw0arH+RFXrsBJckLdboFp
         Oh1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=jF0I6eVKO+73SNOagsbYGiDeJ6Yxd0WqE3bDls6qOJA=;
        fh=mW+4OOXUc72hDanBR9XuXoqANGq1IvafaJuDCeRMjng=;
        b=HZ670/KwnTDdpCJgN/rZKN9fBEOpCITvdIowlrZ35rFcVjB6RSSQCR7bVWXyMjaBss
         5lJD0TFrZfoiqeyt6G/YOjQus+coPDwmuRspKQbgYtJ3GO+K8ZI44/19utgh3Kg7XXjd
         54sAXXvnwfkvTn+Fw8mXBOYCUYtcito6bAkYxswwquF1kjrIRUwsNvtRL6E4Hf6FpkeY
         Lgcw61uMJDmsGL2B66ZkImh8UuEur1jjML7hVgpNRROlkQMA9IBx7OJ9loz7BpDsQmzr
         hysJfeyPc+G7PwyKgVXPgKF2gT4KNdYhXLDJucEeOVEoaZASxhb7BQePcrGcwZdaZJ79
         tVCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788262572; x=1788867372; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jF0I6eVKO+73SNOagsbYGiDeJ6Yxd0WqE3bDls6qOJA=;
        b=fM1UGOm/x+1l8y/rWBoTI43XYJ8AzfVYuckCp9rstBNn8DAZIVYuv3B45nO8mFGQ5O
         IVWwreizDEcbS+qyqC5a+i2Z0SWVy6jTzV9vKJnJCfsMbSrMbQ742n4dG0Vc6fiSOFHB
         H9Vp3k9Gc/U8yRi3MrUBgDA7Du3o8T9UD99TRTrkSnMOCQbFzIHYnm65k4t3XHsHLs7/
         jrgqYJKMI1m9Mq81tc0nyvDMxSV+higskF1BT+dCAe2UMxKfXgt+XmxBcTwF9clGb2g7
         WksbQT5IRVRl6zpxKeOi/mdcuI0YFS5L9/m4JCZUvB6yYKhPCCWmMiIlQD0Uj9KEK+tW
         sDYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788262572; x=1788867372;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jF0I6eVKO+73SNOagsbYGiDeJ6Yxd0WqE3bDls6qOJA=;
        b=QI+CiGH1V4ePXebyXdfhaCIWWyE/NGqltROT4TpyKs/voNxLkz0CvRQZAB3XrHsvWU
         +OImXNzy0iIsCOn66DwjZl6F3xMfbMcwdpQerrlQd1eOiLOERxwNG1AXjoH1fLSM1qPM
         A/tFjd5ZFVB0SX3CWcVZx2eTm4bJ18gTDSr4Q+vh3k2DrIoKnDEsuLt4D1OjKRmqp+hn
         VYHT53MYlN870f4Ygzm4/SxpuVyHoBfnssH1aQBxx2HcYaYLm6AVCiDwUrYA+9SUxbI3
         K3CMltpDmuPrwllgQKzH0fomd/v5mgjrBbWOvHYKN9uLtVBEDy2IKgOEyXHOLui3JqvX
         NfLQ==
X-Forwarded-Encrypted: i=1; AHgh+RrsHBLfnWSeeecBUy1tMGPSn9mOuKyrVKvgGOWBhsUGtx34/FJRr5ukdSFgaJTxkDkKzSM=@vger.kernel.org
X-Gm-Message-State: AFuF++mvNcOkNfCnJna4Gsy85UpXRh47Iju7tJ9Xf3tMYhbYKZKVo6XW
	e0K5V2zh0Q168O/ebnC1dsVs/oL7bDhlY8SuxrHt1FN5n5W4+K1lRAPxuGzW72V5LyMX9En1EOU
	UROadSc/8NySgKnueYM2zHmoAC0u/KKVkrqyq
X-Gm-Gg: AR+sD1074mbF6zN7L2WLVVjoGz5neUjpOhjyuIj/htmxZmt6ranGEJeFmCLsixSytrI
	DXA+iVqQYKgnWZjgYDzuxDef0BUmhaRiv5jmkKlyHnU0OxcF8c/sOZPUD7myGTrBKy1xHs1pU2t
	/nvwELyj1LcKmRklflmoFM32yaRshtEOoFRmGLd2AKNCUsuLSOAn4UxZQP3wPW1p1LPYCYLdVxH
	KBOUEZQ1RV6k/3SPjr7iQCoZRcONSfVCAkYNR708allGkltGvKQt31OtV1aYNoAjX3BtPZgkxy5
	Xw/BqbP1exYf13bEUUc0A+Z6EMEDsyBDY3CwTXUqnrVwMH6PZ5FyxWpqhX3iQBSV3iriT32m8ln
	jI5WBiPDrBmI9T4komvIEB2OuU1ScxmqaXI7pmD+nYB2Jzw==
X-Received: by 2002:a05:6102:4415:b0:784:b6e7:cee0 with SMTP id
 ada2fe7eead31-789fc1883c8mr2649646137.3.1788262572178; Tue, 01 Sep 2026
 04:36:12 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 1 Sep 2026 07:36:10 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 1 Sep 2026 07:36:10 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260830204835.1040408-3-gitster@pobox.com>
References: <20260828225206.310500-1-gitster@pobox.com> <20260830204835.1040408-1-gitster@pobox.com>
 <20260830204835.1040408-3-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 1 Sep 2026 07:36:10 -0400
X-Gm-Features: AcwNN1WoatuZnEOxVJ9jGQl_UHXgBXkZnmgDCVympWorFa6OzVTqcDqNOSb4G-I
Message-ID: <CAOLa=ZQQ6YO6GFxUnoqQpC0P45Dw3duu3j-hHuOkUw+SzHXzOg@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] checkout: validate new branch name in checkout_branch()
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000061768f065a6a5301"

--00000000000061768f065a6a5301
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> In checkout_main(), new branch name validation is performed before
> dispatching to checkout_branch() or checkout_paths().  Checking out
> paths does not create new branches, so this validation only belongs
> in checkout_branch().
>
> Move the validate_branchname() and validate_new_branchname() calls
> from checkout_main() into checkout_branch().  checkout_paths()
> checks and fails if '.new_branch' is set before doing anything,
> which indicates that this change is safe and makes good sense.
>

This is straightforward and makes sense.

> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/checkout.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 774e4fd5b3..14542626e9 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1734,6 +1734,17 @@ static int checkout_branch(struct checkout_opts *opts,
>  		free(full_ref);
>  	}
>
> +	if (opts->new_branch) {
> +		struct strbuf buf = STRBUF_INIT;
> +
> +		if (opts->new_branch_force)
> +			opts->branch_exists = validate_branchname(opts->new_branch, &buf);
> +		else
> +			opts->branch_exists =
> +				validate_new_branchname(opts->new_branch, &buf, 0);
> +		strbuf_release(&buf);
> +	}
> +
>  	if (!new_branch_info->commit && opts->new_branch) {
>  		struct object_id rev;
>  		int flag;
> @@ -2062,17 +2073,6 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
>  			die(_("you must specify path(s) to restore"));
>  	}
>
> -	if (opts->new_branch) {
> -		struct strbuf buf = STRBUF_INIT;
> -
> -		if (opts->new_branch_force)
> -			opts->branch_exists = validate_branchname(opts->new_branch, &buf);
> -		else
> -			opts->branch_exists =
> -				validate_new_branchname(opts->new_branch, &buf, 0);
> -		strbuf_release(&buf);
> -	}
> -
>  	if (opts->patch_mode || opts->pathspec.nr)
>  		ret = checkout_paths(opts, &new_branch_info);
>  	else
> --
> 2.55.0-884-g76cf8659c2

The changes looks good too.

--00000000000061768f065a6a5301
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 676b3b3940bcb59a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xV3VLZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMHA1Qy85dzhVVzBSQlB5Y3oxUk1kbWhPZHpaMk1DRApUVzExWWtvZktQ
WDBCejFQOU1GakphdlZHUzVPMk9KNjkybVdXS00vVm1uM2h6OHIwQjdWejI2azRYcXFPb0pECmlu
R091SENKTHQzSWtwSkE4d0ozUXBUa0VJamFzRVloZ0JqR0grTkdYMDVrbGVpK1RqOVhwa1AxVFk5
YUUwR3kKOUswbUdCZk1HSXY5WGNOL0dWZUM0QkV4eWRlUUo4b1AyRmpKbXpRYy9OYjIvSTNlTElx
cUxNQ3ZGcTAxbmxtKwp5TnpqcE9zUHlvQ0VSeEw1NVB3eXl4THFQaVFhNEJ6czN3cVUwSUJVVFVS
d3FnZHNRaVBDZ2M1K1p6c1NsS24wCmgyUHVTOVdXbXN1Tm9PRElsMFk1MFNUc2duWklDdkdEbDlX
V1hCaXU1MGRlTkFWL21GVUlJV0ZrOGZFVU03WHUKY3BQS3RzbGN1UkljTlJNaFdncStjWXE0eUQ1
bGVweTlEaytlMy96b2x0cENPYnFlQWo5cDRMM0pxRk5LQk1wZApCaDlrTUFLY3ZWd2dja3ZCQUNX
cmRDek95UXlOckxNNHBkU1FqTWRJdlFlaGQxWkg0TiswdnNsbVR3eG5pUjluCjZIRGFFMTJudE5i
eWkvbDByT1BudFNVdDZnbXozSERPUHM0cnhmcz0KPWZrRVYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000061768f065a6a5301--
