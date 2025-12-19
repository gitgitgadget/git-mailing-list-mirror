Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D65B2C0F62
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 10:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766140429; cv=none; b=BU+Vfep9IY20MDo9LkMvJ8YY7pBTpweAQRJJYAfxnTRfFZOZXfU2WnQFdL4erET2XexV+WMjzYtDVZEdlnf+nVECfZwVGRjzMw3UMl1tquhVjYBzJlAo08pLTqOOah6kryXOJksJQeim0dv6cia/JHFupBVrFyh5P+mpn7A93Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766140429; c=relaxed/simple;
	bh=A/pobn2qOVPXNL5ddqOreSsSpiuLYMGmVYwYiuGOFdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NSZJgLD6eE07PgBEzhzc3oCQTx9YJgqVGlMRF8wELXYoP24q/NJ7cABIVkQJpOQ/E3OBryGWm8GJgzAYhHr+RisACVE2BGU27qogQYln1qbzUefooPcFjrUrDtwbnXxyCri8hXugwb7QPYTREPF7H9kNNH3BbM0UpruNBytUzmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CbfUYjHI; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbfUYjHI"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-477a219dbcaso14244525e9.3
        for <git@vger.kernel.org>; Fri, 19 Dec 2025 02:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766140426; x=1766745226; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pRwQxG+IgsLlofH02DHyRA88hqsIjZSe9B+pukQvYg0=;
        b=CbfUYjHIzi3UaPhJEsFQK9cRKFUDQimDr/mymXAD81hpLGZJ6beCj1TxUbmxwLy1m1
         aEHZJVzISFqqdqrJYGlQlXibDrmlzHm65/bUMQLsXlO8GSi9Iw7AuHBJ8uyWlrOdGBSh
         876F3HUkViif1pAv82IshpWBUyyVg+eFKcelEdAhlaQsqUhnOyyXEIs3/FCwTsPknXwF
         BCLXBF5A+IbTk+LLQKBF3JTZ6OjrgSAxHx28jTYqc4l4O+wjWcDVASt+3Knf6XYu0Yod
         Z5RYYpdA9x1btyJO3PBGsmOL8M2a/oYz5ygFMrqzB4jDK0tdpZmjv6VnSguCQd/wWmYy
         WFDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766140426; x=1766745226;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pRwQxG+IgsLlofH02DHyRA88hqsIjZSe9B+pukQvYg0=;
        b=Mfo+ZAQ72ADUAQ+YKhCntSQ3MrlcmQJBnKG/1vX8sEiySa6m1ZiMicLffoVFr51RxY
         TAq2o5ut0kMTJjMVR4YWzTpvXuD8NK8jvr1IayRf4/gYGCNr5cVv5xv2DS2iiKTuphZJ
         sC0GTc1X33AZGYLURD8xNKD+Ux7OjpmUh+hyX4hWpR3yDGeGekBPS1H7VxLQkCS/mRcT
         3k2Udio0acvuY4OIR4bOL+LdOwSZa2ZxQ9YaKB8fxB246QOpKnaEHRZSZqtufUhemWt3
         9PUfRtKfCOhDJBXaHW4tXrx5YeIyP20UnZUQ53u52qBEYvFNq8AoTggFlMRJ7Y3SDTE4
         +2Ow==
X-Forwarded-Encrypted: i=1; AJvYcCWkXb5NyowMjYCVumE+xMwjt44J6W6r6rqmHLeY/1/EwLc7vgHBn04MrRCi9xJRBhOKNX4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4LcwZdCrPcDJ5c2Y2K7pAuP5isulg46OKFNBKGs0v8wuQurEf
	D6GS3eFc32G3LVdMCluMslCfZmi4C/N6hmAcbImT0C9v4ocg4fi7WVex/L0E8KaK
X-Gm-Gg: AY/fxX5ThOCphX65oIzRyt/LpkS0o+ChPaoJTvK7+35CyfJ5dLN+ogix4qeBtQjOBA+
	kaAuenA88YuqHQnPmqjByTLDTdADXF0z7eIRO8CbmRXIfLWoBXMd3z4I1Y3/fqmfyHSr5NsVxdT
	NXpapfN7byn5bB1oBmpStFHvAHWluxu3aed1jsKMtpqa/toHTH8QcX92MFkITBtY/0lNkBtzmaI
	nxWl36uNI3TWTDQxMN+BWfkvSaNCKpUQHY35XmwBv2HA8P3Vfy2rYSnS7LxDqL8rPu4DGUVt9WU
	HIHTZ7UauDXD8Rx6pakcT2VVGuJYolLZsbC7CqlQBtsdU6iBzFFfmsJ7k8Ttg0rzGVbZo+1PB5V
	cicb/r9/hTg7BX2In/ptRd/mmnRadEx36e5uvAyk+XWi/Fb9b/05wrigCrRmviovDhOCwAjEqbP
	WnKH7s8slXst324qosEAcTsiJ1don84CxovAwkmLsMRwhwnKuPiyxXb7f8f7MnSi9wPlcRM5nGW
	da6
X-Google-Smtp-Source: AGHT+IF8VQV0DjEFFis6XBf/fUrE/K4XgUDQjezFZt95Av6VygGtne4JG3NUsMavxvbpirombmYMoQ==
X-Received: by 2002:a05:600c:3b94:b0:471:13fa:1b84 with SMTP id 5b1f17b1804b1-47d19566b00mr22252135e9.12.1766140425641;
        Fri, 19 Dec 2025 02:33:45 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be27b0d5asm90446895e9.13.2025.12.19.02.33.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 02:33:45 -0800 (PST)
Message-ID: <035238d7-f98a-4072-a363-9a57650abb95@gmail.com>
Date: Fri, 19 Dec 2025 10:33:40 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] diff: add --no-indicators option
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
 Collin Funk <collin.funk1@gmail.com>
References: <pull.2133.git.git.1766132264231.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.2133.git.git.1766132264231.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 19/12/2025 08:17, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> Add --no-indicators to replace '+', '-', and ' ' indicators in the
> left margin with spaces. Colors are preserved, allowing diffs to be
> distinguished by color alone.
> 
> This is useful when copy-pasting diff output, as the indicators no
> longer need to be manually removed.

But you're still left with a space at the beginning of each line. I'd 
have thought it would be better for --no-indicators to just strip the 
leading '+', ' ', '-' though that still leaves us with

     \ No newline at end of file

should that whole line be stripped as well?

If you just want to replace the indicators with a space then you can 
always set up an alias that does

     diff --output-indicator-old=' '  --output-indicator-new=' ' \
          --output-indicator-context=' '

The --output-indicator-* options error out if you pass an empty string 
so you cannot use them to remove the indicators all together.

Thanks

Phillip

> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>      diff: add '--no-indicators' option
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2133%2FHaraldNordgren%2Fno-indicators-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2133/HaraldNordgren/no-indicators-v1
> Pull-Request: https://github.com/git/git/pull/2133
> 
>   diff.c                 | 17 +++++++++++++++++
>   t/t4000-diff-format.sh | 32 ++++++++++++++++++++++++++++++++
>   2 files changed, 49 insertions(+)
> 
> diff --git a/diff.c b/diff.c
> index 436da250eb..668ba349fe 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -5290,6 +5290,20 @@ static int diff_opt_char(const struct option *opt,
>   	return 0;
>   }
>   
> +static int diff_opt_no_indicators(const struct option *opt,
> +				  const char *arg, int unset)
> +{
> +	struct diff_options *options = opt->value;
> +
> +	BUG_ON_OPT_NEG(unset);
> +	BUG_ON_OPT_ARG(arg);
> +
> +	options->output_indicators[OUTPUT_INDICATOR_NEW] = ' ';
> +	options->output_indicators[OUTPUT_INDICATOR_OLD] = ' ';
> +	options->output_indicators[OUTPUT_INDICATOR_CONTEXT] = ' ';
> +	return 0;
> +}
> +
>   static int diff_opt_color_moved(const struct option *opt,
>   				const char *arg, int unset)
>   {
> @@ -5828,6 +5842,9 @@ struct option *add_diff_options(const struct option *opts,
>   		OPT_INTEGER_F(0, "inter-hunk-context", &options->interhunkcontext,
>   			      N_("show context between diff hunks up to the specified number of lines"),
>   			      PARSE_OPT_NONEG),
> +		OPT_CALLBACK_F(0, "no-indicators", options, NULL,
> +			       N_("do not show '+', '-' and ' ' indicators in the left margin"),
> +			       PARSE_OPT_NONEG | PARSE_OPT_NOARG, diff_opt_no_indicators),
>   		OPT_CALLBACK_F(0, "output-indicator-new",
>   			       &options->output_indicators[OUTPUT_INDICATOR_NEW],
>   			       N_("<char>"),
> diff --git a/t/t4000-diff-format.sh b/t/t4000-diff-format.sh
> index 32b14e3a71..1863553056 100755
> --- a/t/t4000-diff-format.sh
> +++ b/t/t4000-diff-format.sh
> @@ -95,6 +95,38 @@ test_expect_success 'git diff-files --patch --no-patch does not show the patch'
>   	test_must_be_empty err
>   '
>   
> +cat >expected_no_indicators <<\EOF
> +diff --git a/path0 b/path0
> +old mode 100644
> +new mode 100755
> +--- a/path0
> ++++ b/path0
> +@@ -1,3 +1,3 @@
> + Line 1
> + Line 2
> + line 3
> + Line 3
> +diff --git a/path1 b/path1
> +deleted file mode 100755
> +--- a/path1
> ++++ /dev/null
> +@@ -1,3 +0,0 @@
> + Line 1
> + Line 2
> + line 3
> +EOF
> +
> +test_expect_success 'git diff-files --no-indicators replaces +/- with spaces' '
> +	git diff-files -p --no-indicators >actual &&
> +	compare_diff_patch expected_no_indicators actual
> +'
> +
> +test_expect_success 'git diff-files --no-indicators --color preserves colors' '
> +	git diff-files -p --no-indicators --color --ws-error-highlight=none >actual.raw &&
> +	test_decode_color <actual.raw >actual &&
> +	grep -F "<RED> line 3<RESET>" actual &&
> +	grep -F "<GREEN> Line 3<RESET>" actual
> +'
>   
>   # Smudge path2/path3 so that dirstat has something to show
>   date >path2/path3
> 
> base-commit: c4a0c8845e2426375ad257b6c221a3a7d92ecfda

