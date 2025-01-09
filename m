Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403E121771F
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 12:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736426361; cv=none; b=mVX3Gdu3K80XDXd/AJJn7fJ2LQVSF8412G1/vUyPCbMya3OBvn3Gbhld9NvQ/7nq5XzP+p3fN9qYbqrPYFsF/hKA1vQgkTBLcptoXmEgviCfkQcbvYSLhnjg+DQ3qicN342hbmomgMWReTl3wfj075m3YKH4Ht6qdH2BLBRsd0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736426361; c=relaxed/simple;
	bh=uyakOxGjIwJcfUltDm+Xds8zUTuV4y4QrL8lQyxwP14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZquxOwdKHBFnh4Yrts8klMOaaNmafX+RplF83K21MRAUwo5X1zExDnfYQYgIZhO5ygBJ+V0d5yN4j6C86KibWPeDJ2xoMZrG50aY4HbHA3CfcxHmaiAT8dfOfTVToCdGiK4DqOk5iJWMBwfaQf57zmL+Lj/TZvWXHjDSoUHKrJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6ZFH1aG; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6ZFH1aG"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2166360285dso13082825ad.1
        for <git@vger.kernel.org>; Thu, 09 Jan 2025 04:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736426358; x=1737031158; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x1cYiX1U+3GDdFBUTAe6fpnCrxvnZXLUTgXPoJQ4uuQ=;
        b=P6ZFH1aGdDXN7fyROEQpPn5rnKZzxBulZpRN8H+sKMqHWohm9LmU7k+bLSy6ljHypP
         9cWLMLZd2YHK7jAJgHM/rO4GVWXVxtfpidM8JG6VkY6bvGYaWxFerOgyASDch/U8zDX7
         pVNXwUE/DpQCv8Rsa9PPSqjFxmIHIK2/312rrJjIrmU33TWQoUSMnmcOghQzkb1v7opF
         Y3HYAiEtcARzbmOtlzYa11qzWae612iT8mpc+wpW6Km1BepfyS5qK6TYWS2E943zyWWv
         jmTB6xetgno6VqLKZ94hvqJhLjQdZgMUUiyCNwjJQy/v241wqivqAOXLjEOX3EnCTb//
         mjDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736426358; x=1737031158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1cYiX1U+3GDdFBUTAe6fpnCrxvnZXLUTgXPoJQ4uuQ=;
        b=J68sdaAIkhEL0z/EJkfdYZu3Sx4DXAcCHUDL5E/P/OCMPp2zF8DBAYzGbjWAZjMJAZ
         GLetCN05imzXDLXOwSrROtj1yJsBcRd5CzXKa3SdPeU1tQa1gIA1pcs+WDQR9gfl2QqZ
         c88+h8JMxSdzVeNmVb/VrLUHMx6CgKhATvdz5GHvyQodXw5GwHrHPpJEPhl+FYziuvQx
         a6rzAeBm16GuqI37tF62P6uj52BTmkUFzWu+HHSDe4qZtr6m+IfqwdELKO5MU3R8Co2D
         tG75ZPsm3yGVrrH92P/V9omCvPmfU2Ws/+IkGAbTpclxhZg54fjX3T4iBVehhDUel64H
         4EsQ==
X-Gm-Message-State: AOJu0YzMywug7e9/goaAS1s2PDYxnj8qRrgJ8zCLIZnEsVEEA6kUhFwk
	4EfX1f+wxVnA0oOfJtZn7fWEihMtbgpqexBG7mXMIZ+20aAjRWKl
X-Gm-Gg: ASbGncvKtVoiQAxuQPCNxbzmWhvHfau+YI0MrloNJMQQ1Lg4zhcDoCgdMC6MjLXXCe6
	wc/JjkTkTEEZPbLsLF3YgTrcyxNCjkIrc7PTfPJ2V+2G/OtgGe2jY0YkT07TLVsVGkFYAKgrUjy
	7nXptORSQcqQ8IDcJYXzXg0uyR3aowVEcErS0qfUhYOaWQYqiOYyi2tlZF7jv6lATUyZ43fxtQD
	2nFTYU7uTNR20LPdT4ZprYMS8O6LHw3klU=
X-Google-Smtp-Source: AGHT+IEFYGX1v3tpb8RrOEQpBE9CgGahZ/TkvtZFQvHt/0AWxwPj+hVpi2h7Xi42/UujqfxjX8pZww==
X-Received: by 2002:a17:902:d4c9:b0:216:7cef:99b3 with SMTP id d9443c01a7336-21a83fd0afcmr90394165ad.52.1736426358433;
        Thu, 09 Jan 2025 04:39:18 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9177b45esm11725705ad.2.2025.01.09.04.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 04:39:17 -0800 (PST)
Date: Thu, 9 Jan 2025 20:40:23 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2] builtin/blame: fix out-of-bounds read with excessive
 `--abbrev`
Message-ID: <Z3_Dt5SpG6qE5_9V@ArchLinux>
References: <20250109-b4-pks-blame-truncate-hash-length-v1-1-9ad4bb09e059@pks.im>
 <20250109-b4-pks-blame-truncate-hash-length-v2-1-589c81a6ddb0@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109-b4-pks-blame-truncate-hash-length-v2-1-589c81a6ddb0@pks.im>

On Thu, Jan 09, 2025 at 12:48:22PM +0100, Patrick Steinhardt wrote:
> In 6411a0a896 (builtin/blame: fix type of `length` variable when
> emitting object ID, 2024-12-06) we have fixed the type of the `length`
> variable. In order to avoid a cast from `size_t` to `int` in the call to
> printf(3p) with the "%.*s" formatter we have converted the code to
> instead use fwrite(3p), which accepts the length as a `size_t`.
> 
> It was reported though that this makes us read over the end of the OID
> array when the provided `--abbrev=` length exceeds the length of the
> object ID. This is because fwrite(3p) of course doesn't stop when it
> sees a NUL byte, whereas printf(3p) does.
> 
> Fix the bug by reverting back to printf(3p) and culling the provided
> length to `GIT_MAX_HEXSZ` to keep it from overflowing when cast to an
> `int`.
> 
> Reported-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> This fixes the issue reported in [1]. Thanks!
> 
> Changes in v2:
> 
>   - Take into account that we may strip ^, * and ? indicators by moving
>     around the check.
>   - Fix the testcase so that it actually fails without the fix.
>   - Link to v1: https://lore.kernel.org/r/20250109-b4-pks-blame-truncate-hash-length-v1-1-9ad4bb09e059@pks.im
> 
> Patrick
> 
> [1]: <4d812802-afbc-4635-7a19-73896fcda625@gmx.de>
> ---
>  builtin/blame.c  | 5 ++++-
>  t/t8002-blame.sh | 4 ++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/blame.c b/builtin/blame.c
> index 867032e4c16878ffd56df8a73162b89ca4bd2694..f92e487bed22eec576a4716f2e654cb61efb9903 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -505,7 +505,10 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
>  			length--;
>  			putchar('?');
>  		}
> -		fwrite(hex, 1, length, stdout);
> +
> +		if (length > GIT_MAX_HEXSZ)
> +			length = GIT_MAX_HEXSZ;

Here, we explicitly set the length if it exceeds the max hex of the
repo. Although `printf` will automatically hide the length, we should
explicitly do this. Make sense.

> +		printf("%.*s", (int)length, hex);
>  		if (opt & OUTPUT_ANNOTATE_COMPAT) {
>  			const char *name;
>  			if (opt & OUTPUT_SHOW_EMAIL)
> diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
> index 0147de304b4d104cc7f05ea1f8d68f1a07ceb80d..7cf6e0253a5bbd4d6e438e627dc18b47eac4df66 100755
> --- a/t/t8002-blame.sh
> +++ b/t/t8002-blame.sh
> @@ -126,6 +126,10 @@ test_expect_success '--no-abbrev works like --abbrev with full length' '
>  	check_abbrev $hexsz --no-abbrev
>  '
>  
> +test_expect_success 'blame --abbrev gets truncated' '
> +	check_abbrev $hexsz --abbrev=9000 HEAD
> +'
> +

By the way, I feel this usage is a little strange as the user side. When
I received the report mail from Johannes today morning, I feel a little
funny that we allow the value of the `--abrrev` option exceeds the
`GIT_MAX_HEXSZ` in the first place.

>  test_expect_success '--exclude-promisor-objects does not BUG-crash' '
>  	test_must_fail git blame --exclude-promisor-objects one
>  '
> 
> ---
> base-commit: 14650065b76b28d3cfa9453356ac5669b19e706e
> change-id: 20250109-b4-pks-blame-truncate-hash-length-c875cac66d71
> 

Thanks,
Jialuo
