Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4DC26ED25
	for <git@vger.kernel.org>; Sun,  5 Jul 2026 13:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783258947; cv=none; b=fJKTp5YsWLp/0ngvMfjvK56Eruk1XGZmZj5HGR6nf07vVnVEFP/l6p9v64a6Duy7q6NhDUBgaFA7VP9EdkwZCZVG3PlH0T+uZzW/zOo+qS5qetdOltmI7uMVdvA1zukht+SkuR6j+iPF9HorMwstZtLTRhh8Ymv87NW//WdSL7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783258947; c=relaxed/simple;
	bh=m3LJRQJnyrCgcFD3Rpo30tTf+8UYYd1EIKZJ+IrlHDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=e2jXRZtSq0Uc6VzaszNlv/xwkVuohVY7B2W+IT+3i/l7SBcusln4IrbStAFBfxgRL21p99XKf8WP3+HhlfWM5c0hMe+ZMSOO5ikqr94jfLZgdsPjnMS5YtBu81tURhiwes10orCdpu7RZqA1ifgb92jKPhYX3Nu6AFktuD88guk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+fL2SbY; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+fL2SbY"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-474560436c3so2086593f8f.0
        for <git@vger.kernel.org>; Sun, 05 Jul 2026 06:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783258944; x=1783863744; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vAIwAOqxbZZnYvLjxkVNHAT4mBMe3qzn/JVfA70PCdQ=;
        b=h+fL2SbYdAtp4q6j1cTFA7USfl3gMZe91qg8yHldh3SOl8VWvQDdGyg3iY1Adk49eY
         t2HYejyEgaB8b2zeLwU+FE83CpKbzEwanKkwQGLdPtCdUMuOQS8aSfn87/JSxJ2bz94N
         ofKYskWhtuF8FD2ophBPEMDWNoVucWZYlmfr9LXEjntsnpogKxtpcEnHQ+5l7Jy5HCiu
         zyGyBSUe0RkBUQZa5QNVa09Qc17hRdRrIRbHAkYgC7tcHIymJMEg8OyHKLJYh7CCzwCf
         V1orW/zsIk8ftuHSFc91BagFKkm8BySvfbTms9QJzAKtSuMKcW2I4uQovp1+FIsxDoeu
         SZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783258944; x=1783863744;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vAIwAOqxbZZnYvLjxkVNHAT4mBMe3qzn/JVfA70PCdQ=;
        b=Cdy0FXJRQGWD8ImRO+osvalFXETb1/+PuJjnfxd0S/umCaT0IMky/Q1+9hE4o61NDT
         3ZcdYf6+wIjKnvTJ1QAPWXmXEMQFJGNIbQXmPjJAEWIrpmfNSgvQVvo5Y2JS1Dkd04hh
         mmZd6TjaovrZmpDCdvWgYZJvqPgG+RdrIlZ+f7mVeZW/tb26IVup7Dv/t+JGf5PEl/VT
         tBcgYR4Bn6W7THb+vbrvZEewkTebnJAsptdzNuB8HtJffPR7XRS9cCXbqtsQnHaDHPNC
         vTUtHXEC1e0PxKURSnIusm6FH1e/JCVHmAZ86fS/OmewUCX3jL+25QKR4NWjsRFsiCws
         UGfA==
X-Forwarded-Encrypted: i=1; AHgh+RrKnCvtUcVi7tC5DUO//Cq/HqnOVj3sz1gNkOjd7pq7Fcwn5UmpeJ6W6Gsk5f41y8fQ7O4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWXjWNS9BvAqycn2jQA15T9/NV7xJCSJTYR/0pTJ6a74FNqab1
	poW17UBY4+JxHW/tbB3Mu8j0UMkcOr94Ch/gB0HyZrzhujXWGiBsmsZtfxa5pw==
X-Gm-Gg: AfdE7cnHi7obStL1zOHqYjoNDrH4Px8N7rCMjyHIDF2hXfIY/mbWaZK9c89jSptrZbk
	DWaIq5ZLBaM7YGL5PekE1eR1WmZqRFWa6HhXfWiSIrRkyx7JSRzam4vSMYZiPDl5QLmNLp2HDlN
	r1u+fsyfdcwo2/XCvpV4zwmqIbSVzq4ku0YsC+L7Jaamy72o2iCwMqdEpa5pmxu6ZAFpliWV7dk
	9Fkayy3o52AQaS0KL6bDHvdzPmbm6vsOC32SHiMMiC1zZBWEqWG254UeHLABUjv/jwa7ba7IouR
	+MCzVdMHBH2RZPiG/buzjW7oOEDpU6v0QWlO8HgCSrLHQkNKrg+XIC4FQ9yOmsfTww/cOQYvNZd
	QtVauHEAg7qWekDjdSEw5yEJT3Y91sQQ2vvMsLpb+y0f8EMb5LUAy6in8pHzjZoFQKvPGbDevfa
	z4Ua/AXmwcdS8GaQxgawMymTAGSy9zo3JY+FhS9FPJw6LwviraApdwOowQBrdip/u+s9qMHGOr8
	gNnNA==
X-Received: by 2002:a05:6000:2893:b0:475:f0d1:eb60 with SMTP id ffacd0b85a97d-47aad73a47amr8147510f8f.59.1783258943998;
        Sun, 05 Jul 2026 06:42:23 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a55be4sm14744218f8f.31.2026.07.05.06.42.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2026 06:42:23 -0700 (PDT)
Message-ID: <4fa47057-0a14-4749-96f0-0efd3d50386d@gmail.com>
Date: Sun, 5 Jul 2026 14:42:18 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] diff: give --compact-summary a short synonym --sstat
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqldbqdpri.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqldbqdpri.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 05/07/2026 05:28, Junio C Hamano wrote:
> These days I find myself using '--compact-summary' very often, which
> I consider is a strict superset of '--stat' (or '--stat --summary').
> Promote its use by giving it a short synonym '--sstat' (stands for
> summary+stat).

Thanks for the example below, it was useful to see the difference 
between "--compact-summary" and "--stat --summary". I'm afraid I don't 
think adding a slightly cryptic shortened alias is a good idea. It is 
already possible to tab-complete after typing "--comp" so I don't think 
this is saving the user much typing and it clutters the UI with an 
obscure option name that could plausibly be an alias for "--shortstat".

Thanks

Phillip

> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>   * The `format-patch` output still uses --stat --summary, which
>     looks like so:
> 
>   Documentation/diff-options.adoc                      |  1 +
>   diff.c                                               |  3 +++
>   t/t4000-diff-format.sh                               |  2 +-
>   t/t4013-diff-various.sh                              |  2 ++
>   .../diff.diff-tree_--pretty_--root_--sstat_initial   | 12 ++++++++++++
>   t/t4013/diff.diff-tree_-R_--sstat_initial_mode       |  4 ++++
>   6 files changed, 23 insertions(+), 1 deletion(-)
>   create mode 100644 t/t4013/diff.diff-tree_--pretty_--root_--sstat_initial
>   create mode 100644 t/t4013/diff.diff-tree_-R_--sstat_initial_mode
> 
>     but if we change it to use --compact-summary (aka --sstat), it
>     would instead look like this:
> 
>   Documentation/diff-options.adoc                              |  1 +
>   diff.c                                                       |  3 +++
>   t/t4000-diff-format.sh                                       |  2 +-
>   t/t4013-diff-various.sh                                      |  2 ++
>   t/t4013/diff.diff-tree_--pretty_--root_--sstat_initial (new) | 12 ++++++++++++
>   t/t4013/diff.diff-tree_-R_--sstat_initial_mode (new)         |  4 ++++
>   6 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/diff-options.adoc b/Documentation/diff-options.adoc
> index c8242e2462..b2b755fd3d 100644
> --- a/Documentation/diff-options.adoc
> +++ b/Documentation/diff-options.adoc
> @@ -221,6 +221,7 @@ These parameters can also be set individually with `--stat-width=<width>`,
>   `--stat-name-width=<name-width>` and `--stat-count=<count>`.
>   
>   `--compact-summary`::
> +`--sstat`::
>   	Output a condensed summary of extended header information such
>   	as file creations or deletions ("new" or "gone", optionally `+l`
>   	if it's a symlink) and mode changes (`+x` or `-x` for adding
> diff --git a/diff.c b/diff.c
> index 2a9d0d8687..284d391c47 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -6112,6 +6112,9 @@ struct option *add_diff_options(const struct option *opts,
>   		OPT_CALLBACK_F(0, "compact-summary", options, NULL,
>   			       N_("generate compact summary in diffstat"),
>   			       PARSE_OPT_NOARG, diff_opt_compact_summary),
> +		OPT_CALLBACK_F(0, "sstat", options, NULL,
> +			       N_("generate compact summary in diffstat"),
> +			       PARSE_OPT_NOARG|PARSE_OPT_HIDDEN, diff_opt_compact_summary),
>   		OPT_CALLBACK_F(0, "binary", options, NULL,
>   			       N_("output a binary diff that can be applied"),
>   			       PARSE_OPT_NONEG | PARSE_OPT_NOARG, diff_opt_binary),
> diff --git a/t/t4000-diff-format.sh b/t/t4000-diff-format.sh
> index 32b14e3a71..cc5c62fdbc 100755
> --- a/t/t4000-diff-format.sh
> +++ b/t/t4000-diff-format.sh
> @@ -101,7 +101,7 @@ date >path2/path3
>   
>   for format in stat raw numstat shortstat summary \
>   	dirstat cumulative dirstat-by-file \
> -	patch-with-raw patch-with-stat compact-summary
> +	patch-with-raw patch-with-stat compact-summary sstat
>   do
>   	test_expect_success "--no-patch in 'git diff-files --no-patch --$format' is a no-op" '
>   		git diff-files --no-patch "--$format" >actual &&
> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
> index d35695f5b0..a42dca8a0b 100755
> --- a/t/t4013-diff-various.sh
> +++ b/t/t4013-diff-various.sh
> @@ -474,6 +474,8 @@ diff-tree --pretty --notes note
>   diff-tree --format=%N note
>   diff-tree --stat --compact-summary initial mode
>   diff-tree -R --stat --compact-summary initial mode
> +diff-tree --pretty --root --sstat initial
> +diff-tree -R --sstat initial mode
>   EOF
>   
>   test_expect_success !WITH_BREAKING_CHANGES 'whatchanged needs --i-still-use-this' '
> diff --git a/t/t4013/diff.diff-tree_--pretty_--root_--sstat_initial b/t/t4013/diff.diff-tree_--pretty_--root_--sstat_initial
> new file mode 100644
> index 0000000000..b5c9d7693a
> --- /dev/null
> +++ b/t/t4013/diff.diff-tree_--pretty_--root_--sstat_initial
> @@ -0,0 +1,12 @@
> +$ git diff-tree --pretty --root --sstat initial
> +commit 444ac553ac7612cc88969031b02b3767fb8a353a
> +Author: A U Thor <author@example.com>
> +Date:   Mon Jun 26 00:00:00 2006 +0000
> +
> +    Initial
> +
> + dir/sub (new) | 2 ++
> + file0 (new)   | 3 +++
> + file2 (new)   | 3 +++
> + 3 files changed, 8 insertions(+)
> +$
> diff --git a/t/t4013/diff.diff-tree_-R_--sstat_initial_mode b/t/t4013/diff.diff-tree_-R_--sstat_initial_mode
> new file mode 100644
> index 0000000000..51b1aa7d71
> --- /dev/null
> +++ b/t/t4013/diff.diff-tree_-R_--sstat_initial_mode
> @@ -0,0 +1,4 @@
> +$ git diff-tree -R --sstat initial mode
> + file0 (mode -x) | 0
> + 1 file changed, 0 insertions(+), 0 deletions(-)
> +$

