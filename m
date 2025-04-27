Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E976C148
	for <git@vger.kernel.org>; Sun, 27 Apr 2025 15:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745766256; cv=none; b=QoddVT/Wi+LKUKsYOtWPNbphiIN6Sr/sjWSjTIVpCLiW4Nfd5HyyW6GW86nxjRtXhSDx1QVoaMZ7VoGmMAgWSybAP4J6+yJtzlm9CBJZX0K0xJuA4SNGiVWJtpdUgsU/Jy140aXMtX2rTgNKVkjDIEoNZZUg/g2iwMLwliWBfjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745766256; c=relaxed/simple;
	bh=UxiLmAMXvVgmK8lz5EYTkINhciUkI4XOrcI3QH8nHOs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=WDLsgQ74kmCu1EC/7MI8XadEWRWu8HQEO12W9+LgR110ok5PRsri2MVNkC60UNVMONLeJVJVHgwb30nPhvsXIOj2Lmn/M3BQJCLrfuztuTJ9WvOAxT5AvgqgkTKcFx/ROi7xtWM442jDRvdtpEODrjqQJoZ4lU6LquPosSUoAbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4OGb7SM; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4OGb7SM"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cfe574976so26266855e9.1
        for <git@vger.kernel.org>; Sun, 27 Apr 2025 08:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745766252; x=1746371052; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=THOiq4nWZ4JZnpk0yB1a0Af4r3xWrfdKZ4/F7oxt4A0=;
        b=Q4OGb7SMOFAIh/hbYZYA8wf1qf4sWfMxboLyCpKpCOrqdPpz7Vb+6ahSwxgFmR2B6a
         jq47aULpJgEwxZnm9klkjjt4bPsKbRc3+uU43RQ3gLX6r9HxZTaMKsHVDb6+Ibq5zNKq
         taWpMzn6F03OBeQ26517BlL7GBCwGTY66cQuwr8cyV+ixcU0l2FqATwHWr6H1kg52MLS
         nmAG1VzdxcjN9kVmN78xmpjybVQcsd8Vf9i28v68hHZFzmVWKoBGwa0qwZIHje9FdTQZ
         Gt/LhPc6xz1zZc+UeC3CzNdMjUT953lrjK0yAHgZZwaAQf/KEbyEpk6La+SchDwhSjRi
         PZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745766252; x=1746371052;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=THOiq4nWZ4JZnpk0yB1a0Af4r3xWrfdKZ4/F7oxt4A0=;
        b=TgmHMpPtej7qZxpRZ6yLhbvugNB1kRnINUhICwpCSceW/oK+XWMfJ7x1djnXwoBka/
         Xl6rZ/ybknMIJwYh0MiHt7VF3neVM47cG31bT/xDlQFszmKZO9AuAbQE9vrbXR4+Dn4E
         sLLxzTS6dvD86xkmaXNYOHxhZnwk9kxLj4pxCVRR5h3V9sh7JHqKCT5RMYtZg1ESp6N4
         J1/dBmp8OblNOg/v28IhGl2waYimx4oBPVLvAtfMmqsyRAjor5BbP0uZaWuTO7x+u0V5
         /70+zB9AyE6yCC3sqwP1vs08LU/9zrGF9MXVmh5pmVGsp1fEURh8Mg3kHgWCsc3l+5Mj
         jeDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSnHIN8rvSm1EnQAkzTFGa96Ixr4Ee20n89wIcxeAXoLfaS9kyv1SSoJi7EmUh9p3ujP8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yysc65Ni3xrk0XXf29idAQS/d9nmizp9X6w+pwtQHDd8V1R9qtt
	PNJIh7c6pyiH3H0FYepWPHPy9NXyZNt04qBPP8FwBfFSMkUX0pqsQefBag==
X-Gm-Gg: ASbGnct6MsCxD1LJPWZqstVVzFQVV2te2oTKZWALFBBYrlhfGw+08D/JrXLvcXhPND5
	CrbkXgSxpP+k3Ttsm+u1lyPD2hnTjDmrud8bkPx/4N0pf7bm96XDTfpoqUhMSvw7CC+hmdj/FLx
	pp6KB6ioS+0xVCkq6SQrBACYzcPINtqIhcs4j4JHjIlKwNPbjA1pdxna1pLc+WKSAMOXmoUQJUi
	Jrtt83DEWUizTTss5OhZbj6PhXz2xaO7B4ewmnqUlDSJ39Zrx5O7g7NN3GCVSSO+epUP+73coMG
	rfyYmKt4n7186jB43JzyYFKCPxyHD9i9wVlccwAs7z+udFamMs4loRD0QneVerOCY50+y1hb/cN
	vl+hB+qN8OFlmbipn
X-Google-Smtp-Source: AGHT+IFeUmaSj6E2jS6oD39id8721flzpVFWE0rU2tk5uvuOAA6UUjuBp9q/yI5/BXUhslPiwlFIJA==
X-Received: by 2002:a05:600c:190b:b0:43b:c95f:fd9 with SMTP id 5b1f17b1804b1-440a65ba213mr74724805e9.5.1745766252226;
        Sun, 27 Apr 2025 08:04:12 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073e5d52bsm8786670f8f.90.2025.04.27.08.04.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Apr 2025 08:04:11 -0700 (PDT)
Message-ID: <23078e29-8f1f-4eb3-be71-7ef419252bab@gmail.com>
Date: Sun, 27 Apr 2025 16:04:10 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] xdiff: disable cleanup_records heuristic with --minimal
To: Niels Glodny <n.glodny@campus.lmu.de>, git@vger.kernel.org
Cc: johannes.schindelin@gmx.de, peff@peff.net, phillip.wood@dunelm.org.uk
References: <20250425155951.1227700-1-n.glodny@campus.lmu.de>
Content-Language: en-US
In-Reply-To: <20250425155951.1227700-1-n.glodny@campus.lmu.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Niels

On 25/04/2025 16:59, Niels Glodny wrote:
> The cleanup_records function marks some lines as changed
> before running the actual diff algorithm. For most lines,
> this is a good performance optimization, but it also marks
> lines that are surrounded by many changed lines as changed
> as well. This can cause redundant changes and longer-than-
> necessary diffs.

Nicely explained. We normally wrap commit messages at 72 characters

> Whether this results in better-looking diffs is subjective.
> However, the --minimal flag explicitly requests the shortest
> possible diff.

Looking at the diff for 2ff58dec493 (refs: introduce function to batch 
refname availability checks, 2025-03-12) I'd say it is definitely less 
readable with this change but some of the changes in 320f2061b63 (t0602: 
use subshell to ensure working directory unchanged, 2025-02-28) are more 
readable. Anyway as you say if we promise to find the minimal diff then 
that is what we should do.
> The performance impact of this change is negligible, and it
> results in shorter diffs in about 1.3% of diffs in Git's
> history.

Have you got any numbers for the performance change?

I think the premise of this patch is sound, I've left a couple of 
comments below as I think we can simplify the code changes.

> diff --git a/t/t4071-diff-minimal.sh b/t/t4071-diff-minimal.sh
> new file mode 100755
> index 0000000000..3ad759dab4
> --- /dev/null
> +++ b/t/t4071-diff-minimal.sh
> @@ -0,0 +1,16 @@
> +#!/bin/sh
> +
> +test_description='minimal diff algorithm'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'minimal diff should not mark changes between changed lines' '
> +	printf "x\nx\nx\nx\n" >pre &&
> +	printf "x\nx\nx\nA\nB\nC\nD\nx\nE\nF\nG\n" >post &&
> +	test_must_fail git diff --no-index \
> +		--minimal pre post >diff &&
> +	! grep "+x" diff &&
> +	! grep "-x" diff
> +'

Thanks for taking the trouble to add a new test. We have a few test 
helper functions which we could use here.

	test_write_lines x x x x >pre &&
	test_write_lines x x x A B C D x E F G >post &&
	test_expect_code 1 git diff --no-index --minimal pre post >diff &&
	test_grep ! ^[-+]x diff

test_expect_code ensures that the non-zero exit code is from the files 
not matching rather than another error like an invalid option or missing 
file. test_grep will display the file if there are matches which helps 
when debugging test failures.

 > [...]> -static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t 
*xdf1, xdfile_t *xdf2) {
> +static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1,
> +			       xdfile_t *xdf2, int need_min) {
>   	long i, nm, nreff, mlim;
>   	xrecord_t **recs;
>   	xdlclass_t *rcrec;
> @@ -379,7 +383,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
xdlclassifier_t carries a copy of the flag that were interested in so I 
think at the start of xdl_cleanup_records we can add

	int need_min = !!(cf->flags & XDF_NEED_MINIMAL);

and then we don't need to change the signature.

>   	for (i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart]; i <= xdf1->dend; i++, recs++) {
>   		rcrec = cf->rcrecs[(*recs)->ha];
>   		nm = rcrec ? rcrec->len2 : 0;
> -		dis1[i] = (nm == 0) ? 0: (nm >= mlim) ? 2: 1;
> +		dis1[i] = (nm == 0) ? 0: (nm >= mlim && !need_min) ? 2: 1;

If we want a minimal diff then we force dis1[i] to be 1 so that this 
line will never be marked as changed before searching for the longest 
common sequence. Well spotted.

Best Wishes

Phillip

>   	}
>   
>   	if ((mlim = xdl_bogosqrt(xdf2->nrec)) > XDL_MAX_EQLIMIT)
> @@ -387,7 +391,7 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
>   	for (i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart]; i <= xdf2->dend; i++, recs++) {
>   		rcrec = cf->rcrecs[(*recs)->ha];
>   		nm = rcrec ? rcrec->len1 : 0;
> -		dis2[i] = (nm == 0) ? 0: (nm >= mlim) ? 2: 1;
> +		dis2[i] = (nm == 0) ? 0: (nm >= mlim && !need_min) ? 2: 1;
>   	}
>   
>   	for (nreff = 0, i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart];
> @@ -449,10 +453,10 @@ static int xdl_trim_ends(xdfile_t *xdf1, xdfile_t *xdf2) {
>   }
>   
>   
> -static int xdl_optimize_ctxs(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2) {
> -
> +static int xdl_optimize_ctxs(xdlclassifier_t *cf, xdfile_t *xdf1,
> +	xdfile_t *xdf2, int need_min) {
>   	if (xdl_trim_ends(xdf1, xdf2) < 0 ||
> -	    xdl_cleanup_records(cf, xdf1, xdf2) < 0) {
> +	    xdl_cleanup_records(cf, xdf1, xdf2, need_min) < 0) {
>   
>   		return -1;
>   	}
> 
> base-commit: f65182a99e545d2f2bc22e6c1c2da192133b16a3

