Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE370363096
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 16:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774197491; cv=none; b=Bhpt5E3aSKbutruw3W7crhCk1LaSj0aquVAffR+lPJTbPO4pw0BV7BfyXmtuGFol+IzA8RX+W86FMNS6FKqVzrCxcJVSL+p1RgIEp3Qm7ehT2GUOb8bl2Bl9IVrgoLCI55SAXkZHBGfa+Ewlh2gWA+TnFJy7VvYoT6R42jc4I1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774197491; c=relaxed/simple;
	bh=I2kx1nUlFwxem8dG2qJpkAGHDM6bjKkRAccqSBwBp1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SQHcfM8x/cMSlDRq18No4XRCWJaUqBHpXGF9F/o9hGc7EOT/C1R2SYOe4gIRML7E6G4NJPPwEo545CdGkAjJINdnvHBGAbQ9WQZbquYnAOBxzNtQXcywoWMk+aAb+DZf/w0QjiHlAXpuf0maySr46HSq1qmMfEQPkZE00kn+HT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WfbY1imn; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfbY1imn"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-486ff201041so15831665e9.1
        for <git@vger.kernel.org>; Sun, 22 Mar 2026 09:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774197488; x=1774802288; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=r4Dcl5jZvzqcL/J1bf52JVXNCqRFtuZ1CNUvsIfnt8A=;
        b=WfbY1imnLaVHbtr+AwWqUVbk/sGdFzgt6gb9UcjWWrfg71Xf0yRbpMQHaWtl02iKiQ
         TLuKvQ1Jw7tm9/eRb8kzkfWxgQ9CRtVE111g3sp6OIqjMeSfRPMYYW3SmLw4O/mjovP8
         z1BR5bgswwjFgaMHCFRbxM2pSBf/2PNYZUeLHuptrWZ8lnF8WlviBVOrmJu2ACTwglGQ
         IuE6VeYNtwxj9ljO3WQ73vG1GsMrQ0gGj5iuuEnXGzdDXdZhliuihqzF/mvYdYM0RjEm
         u55pRldwKLmZtvPAc7dKhKGqXDYr/zsZ0L8VB6f64ArL+pOboaG16eE9FmVjV+Dlr6SE
         MulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774197488; x=1774802288;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4Dcl5jZvzqcL/J1bf52JVXNCqRFtuZ1CNUvsIfnt8A=;
        b=evd3eNoO7oMwlmIMcRZvu1RfX1jq8WI1Mc4yHEQWK8jV28edcwSoOSTCjhtVAbgqB/
         1t+UvQdN3sFUKrOFpDKM3ITtu1GiK9fcMVKek+GaJHy/YTCggusTRc6wob5dJTtocnyT
         eeHst04gWlS2kLoIWSGkvnfYxCqo5QJkF60cRthMb0eBVUEyGT+VCBjAx9HmG0zq2Gpc
         EYbtwcpEA/I2xNyugkzpJcdFKZlS8bM0RK+lTeorEU3hrF7KfsPwixVzOgCEZWbzj+B9
         0t0UJ560I+UN8JFKSg9u3INCFVC55ulY4UPao5m7mRAaJwZCGLeo1P5kpAG+YxglZyXr
         hKBw==
X-Forwarded-Encrypted: i=1; AJvYcCUhSRT5NuHBdGinecodI5Ye3PyOjFF7ikAImuRToW4XwGUHBo14UdBHKqr5C+Rjeh605Nk=@vger.kernel.org
X-Gm-Message-State: AOJu0YylyRofdPI4ha7sgRMGPOs2KBBoc8+Rktn3gByVxqTvnT0z2oQI
	bxLjLGF2T1IMsaGdvtGepqc9Twr0xBDQRpZS9DfP0lZvn0qQBg/DTUMQ
X-Gm-Gg: ATEYQzz8qx+9yYHNgGYQKEYDBR/76+muUG/ZYqqkLDGi6TTtao/K+ETGyWX6bdJrXk8
	jHQRsgz47Co/fD6JzLhwjkE+VXKWRH61GitfsnOYY/mcEk1sDYcs8Bw6Mfjv80FECie6nKgcoon
	UGM5PNMc5+RQa4VBcxQE69krFV63LflZA8ayhOmCyrBZKuq2BqKEfjjxTn7GzEWHzCv82Otjp4F
	VxnrNn5zA/dAoaJ3tTrK9pO6f8R6X5Iom1T8SFZh/4XXnRlg+re+M/RxOakua0nqUwwzE26zl68
	/Eb0iRPsDTETrpBur6gUK4DmuHULlcnQF8htwctLKntwFuETYik74zNRokd2FGLY0YKLS50o5gf
	mqEXG/xtJlrke/v8aF5UXwDooVtEk33CCoeBYyqFS/rK0+4OEdQEcb4KQ2MRY/kDEjc+MF02qIV
	RUxUqC8yYxLuXTa96aRGqIuLBvp4Hkh70ca/zFCHMgp+3URCbdxXMKBtYTVW8D+TImfJ8VCw9tE
	036SA==
X-Received: by 2002:a05:600c:4ca3:b0:487:338:b4eb with SMTP id 5b1f17b1804b1-4870338b589mr42865645e9.28.1774197488030;
        Sun, 22 Mar 2026 09:38:08 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe6d9896sm235712535e9.2.2026.03.22.09.38.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Mar 2026 09:38:07 -0700 (PDT)
Message-ID: <45a949f3-8b90-4046-995f-da1df265abfe@gmail.com>
Date: Sun, 22 Mar 2026 16:38:03 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] backfill: handle unexpected arguments
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im, stolee@gmail.com
References: <xmqqfr5sacps.fsf@gitster.g>
 <20260322053207.60992-1-r.siddharth.shrimali@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20260322053207.60992-1-r.siddharth.shrimali@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/03/2026 05:32, Siddharth Shrimali wrote:
> git backfill takes no non-option arguments. However, if extra
> arguments are passed with git backfill, parse_options() leaves
> them in argc and the command ignores them silently, giving the
> user no indication that something is wrong.
> 
> Add a check after parse_options() to report an error if any unexpected
> arguments remain. To ensure the user understands why the command
> failed, print an error message specifying the unknown argument
> followed by the short usage string. This matches the behavior of
> other Git commands such as git bugreport.
> 
> Also, add a test in t5620 to ensure the unexpected arguments are
> rejected with the correct error message and that the full option
> descriptions are not printed.

Nicely explained

> diff --git a/t/t5620-backfill.sh b/t/t5620-backfill.sh
> index 58c81556e7..3f1eeb67e8 100755
> --- a/t/t5620-backfill.sh
> +++ b/t/t5620-backfill.sh
> @@ -176,6 +176,12 @@ test_expect_success 'backfill --sparse without cone mode (negative)' '
>   	test_line_count = 12 missing
>   '
>   
> +test_expect_success 'backfill rejects unexpected arguments' '
> +	test_must_fail git -C backfill1 backfill unexpected-arg >err 2>&1 &&
> +	grep "unknown argument .*unexpected-arg" err &&
> +	! grep "Minimum number of objects" err

Using test_grep would make test failures easier to debug as it prints a 
diagnostic message if it fails. Note that "! grep" should become 
"test_grep !" to ensure the diagnostic message is printed when the 
expression matches.

Thanks

Phillip


> +'
> +
>   . "$TEST_DIRECTORY"/lib-httpd.sh
>   start_httpd
>   

