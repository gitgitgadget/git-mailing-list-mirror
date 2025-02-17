Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B4322371A
	for <git@vger.kernel.org>; Mon, 17 Feb 2025 14:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739803096; cv=none; b=flcQQzSv8Q8isrZuXCE5y0PuKphitc3Vji3sRc5WjWeDftw4eP2IGWHuNGNtvUvAQJShLLwTm82OXwZ8JrfEQtC5D9KsBfczXmcUCDsFXFn3PNu4PmdUF6XBwbbPMBFSVJmDbSYTBf8uznEtT8C9hQ84tZNxZU2aYS671iYWYBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739803096; c=relaxed/simple;
	bh=AfEVjfZH69cBiOyP5hSMMOrGyURMw7X7rOAzdmsRnTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cm1St/1gzo7QUnc6hTXbP07bMawdWXzm0d/6yanAHak769wob6yecQJnJ0Mo+mYq+1MZytwH8SKdfjMGfzq7PHGDvDGfk17mL3lFxQx7zDAhIcsHsEH57+Ww/PAWsH/uAiZm75DHH+0QcwUPstL3Np9AnUsAhM2akgCPtWE7ccM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXYSMzFE; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXYSMzFE"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso48433105e9.1
        for <git@vger.kernel.org>; Mon, 17 Feb 2025 06:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739803093; x=1740407893; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TfeM1O7EFyNYeD7KqVjZ8FtkfFQnwY6Wo/YISUp1eIk=;
        b=mXYSMzFE8Z1tAmu35Nk/CDz5JyZHVYiySejM2iLhiZX6Nv2KQW+93Df1XKVWKqrnzS
         JE3IIjk5SRbjpzpNQUf+w3kjzZtubh3wkRMMW81dGVc6ZvNkXQNF5V+6f2vGk/iPMGUp
         wj28VqkQx8B4Fa/8x2r8bLN66YcULeqdSsTab0k2rE2bK0jEhTDKC6tET2U8S6jHD3U3
         9Lto9G3LpSvvC7drA263ja99U9Wx7C83H9L0J5wa9WGKVunuL9Az/WZhKnmmmleLnlgp
         gpFc+V2XV8+8aXAxt2P3Tmg7tsOlmj6pq17ST3wvvC4wfMcfyPUO6zaDweOItBpFzbv5
         lRFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739803093; x=1740407893;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TfeM1O7EFyNYeD7KqVjZ8FtkfFQnwY6Wo/YISUp1eIk=;
        b=nWVSB/C8WHlKlv8Xm0n0xcMRaOQiHIrzUZUXmrfjcbHh99JLLnKx+mERgwEr0g6y27
         POHq5mNG6nvBmB0wJDVVvV3XYqiCcNM8xFTQJlLy8FmMT+DyyhxdWlDC+hKomjQ5r/P1
         iQtP09Mfr0PcO0ZriHPFda56E1PgBAz/NEuoH0ZKkIw2emi/IQkiPJYb1OMWn5IGA7Oz
         jgwv2Jp8IBtypaekHFrgP3yr07TUX3RTixX2Lxk41KUCriSBE4G3BluVwGWgVHJRY8TF
         yUicU1IH8xEFZhJ3GjQzH1DJq/5MIPXPQref852JROn2wLldJ8sMS1yeQchiJEHp6O4S
         BpwA==
X-Forwarded-Encrypted: i=1; AJvYcCUGVAz6V4Re7kyAADpETd3vxGPmZkRRbN1qWtYwiu/04vUmD2svADnT4HSMlmGI9rIdNHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNJaQOkJnfLRaeNt72zBT4tJtpM+3gdUvtj+1ZIjcaQK8Gb3N5
	zthqV2BE7rnFN4lrpdpKXsLCH9SSORetDgpKl0ac8L81MZP/PtIx
X-Gm-Gg: ASbGncvlO2jbhF91HrbAMpp71cu+bjEkiSzQ+Q6mascdwtaCjvH9D0wD3Iyvz6uGlYe
	wE5yu2w8Aj6NkqLm3jQXDiDxqT4SgFQUls4XUHOYWPgHS3McfCK7ywk+317enj8PYvtrWISXUR8
	glm8fnvi1n9ARPip0SXblm7B/2yXhQWzuI0/EHevO1stJeCd8ygjZhHKKnkZs50IQwVWCrSTHIe
	AzVPCl12CFkMSXp3lhs5zhJOCFqj62k3kcltsyU57RCpBrN782uXpSaElYmKuFZ0axa3Be4/Tz0
	hLkw+L21/000hRd/PBI1+as4iHnTGE+8Y9hV/q+ph2/KM3iujU/lSDEo553Zf9V+xHUQtA==
X-Google-Smtp-Source: AGHT+IGJw4JpZAMWy7hmlNAOlsS3pJG4qjf4s4K7V80eyFQgyMo2rXMFZv10zzHWsH3jmDkTCoKm4g==
X-Received: by 2002:a5d:525a:0:b0:38f:3245:21fc with SMTP id ffacd0b85a97d-38f33f56512mr7055530f8f.50.1739803092823;
        Mon, 17 Feb 2025 06:38:12 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f8217sm12614917f8f.90.2025.02.17.06.38.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 06:38:12 -0800 (PST)
Message-ID: <d6d4230e-7b80-4eec-b218-37717ae2e298@gmail.com>
Date: Mon, 17 Feb 2025 14:38:11 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/3] builtin: introduce diff-pairs command
To: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Cc: peff@peff.net, Patrick Steinhardt <ps@pks.im>,
 Junio C Hamano <gitster@pobox.com>
References: <20241213042312.2890841-1-jltobler@gmail.com>
 <20250212041825.2455031-1-jltobler@gmail.com>
 <20250212041825.2455031-3-jltobler@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20250212041825.2455031-3-jltobler@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Justin

On 12/02/2025 04:18, Justin Tobler wrote:
> Through git-diff(1), a single diff can be generated from a pair of blob
> revisions directly. Unfortunately, there is not a mechanism to compute
> batches of specific file pair diffs in a single process. Such a feature
> is particularly useful on the server-side where diffing between a large
> set of changes is not feasible all at once due to timeout concerns.
> 
> To facilitate this, introduce git-diff-pairs(1) which takes the
> null-terminated raw diff format as input on stdin and produces diffs in
> other formats. As the raw diff format already contains the necessary
> metadata, it becomes possible to progressively generate batches of diffs
> without having to recompute rename detection or retrieve object context.
> Something like the following:
> 
> 	git diff-tree -r -z -M $old $new |
> 	git diff-pairs -p
> 
> should generate the same output as `git diff-tree -p -M`. Furthermore,
> each line of raw diff formatted input can also be individually fed to a
> separate git-diff-pairs(1) process and still produce the same output.

I like the idea of this, I've left a few comments mainly around the UI.

 > +Here's an incomplete list of things that `diff-pairs` could do, but
 > +doesn't (mostly in the name of simplicity):
 > +
 > + - Only `-z` input is accepted, not normal `--raw` input.

I think only accepting NUL terminated input is fine, but if we want to 
accept other formats we should  have a plan for how to do that in a 
backwards compatible way as we cannot use `-z` to distinguish between 
input formats.

> +	const char * const usage[] = {
> +		N_("git diff-pairs [diff-options]"),

Normally the option summary printed by "git foo -h" is generated by the 
option parser. In this case we don't define any options and use 
setup_revisions() instead so we need to provide the option summary 
ourselves. Looking at diff-files.c we can add

	"\n"
	COMMON_DIFF_OPTIONS_HELP;

to do that.

> +	argc = setup_revisions(argc, argv, &revs, NULL);

I think we should check that there are no options left on the 
commandline after setup_revisions() returns

> +	/* Don't allow pathspecs at all. */
> +	if (revs.prune_data.nr)
> +		usage_with_options(usage, options);

It is not just pathspecs that we want to reject but all revision related 
options. Looking at diff-files.c we can do

	if (rev.pending.nr ||
	    rev.min_age != -1 || rev.max_age != -1 ||
	    rev.max_count != -1)
		usage_with_option(usage, options);

To catch some of that but it still accepts things like "--first-parent", 
"--merges" and "--ancestry-path". We may just have to live with that as 
I don't think it is worth expanding a huge amount of effort to prevent them.

> +	if (!revs.diffopt.output_format)
> +		revs.diffopt.output_format = DIFF_FORMAT_RAW;

This matches the other diff plumbing commands but I'm not sure it is the 
most helpful default for a command that is supposed to transform raw 
diffs into another format. Maybe we should default to DIFF_FORMAT_PATCH?


> +test_expect_success 'split input across multiple diff-pairs' '

This needs a PERL prerequisite I think. I'm a bit unsure what this test 
adds compared to the others.

Best Wishes

Phillip

> +	write_script split-raw-diff "$PERL_PATH" <<-\EOF &&
> +	$/ = "\0";
> +	while (<>) {
> +	  my $meta = $_;
> +	  my $path = <>;
> +	  # renames have an extra path
> +	  my $path2 = <> if $meta =~ /[RC]\d+/;
> +
> +	  open(my $fh, ">", sprintf "diff%03d", $.);
> +	  print $fh $meta, $path, $path2;
> +	}
> +	EOF
> +
> +	git diff-tree -p -M -C -C base new >expect &&
> +
> +	git diff-tree -r -z -M -C -C base new |
> +	./split-raw-diff &&
> +	for i in diff*; do
> +		git diff-pairs -p <$i || return 1
> +	done >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_done

