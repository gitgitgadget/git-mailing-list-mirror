Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04317272E56
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 10:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751364062; cv=none; b=JKwtZyf+zZmn/O98Fx/8C5cY0YGdyvQ7QBEqjzK+O/+x7iAAiDkSFdwEy4kKwqKpUIX4sZijOgtbNC6bMqw8al0MX1nNWtItGqlC42pe8gkXUV59xsqDpBvELOC/Nwc2UXpL7IBXWEDT1pRF+irMnoWOKldZwknmgXlWGsommhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751364062; c=relaxed/simple;
	bh=g80RwHrYkYY7e+SoM81dJZgx+gTE/QNkWbZSfZB3z+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UpGW302EuKOaD4aaTUK9iMrnw02/+vbjUKCo5hZb9MF0ysOWcoMQ+VzJ/nQ+GNqD5/cr/RZF9+Fskhn0cjXkqtrQ0L2TkULfLsmFAsqukMMAXi04krrwrl1zrinw0P2h6cUAFiGgURQezlOTIi5LGad33mtJYeiWFNlsEkmVTNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwjLHvK1; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwjLHvK1"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae0de0c03e9so802002866b.2
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 03:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751364059; x=1751968859; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OHi9FlGtRg/EDnf2MgHBTqXZr0Gl2vvMcmNgU6VzNOg=;
        b=fwjLHvK1Y0lZKQYdJjmEwSSJH04wMfIc9xgsv8hgApeexEIIsROF+IfqrLoYNH9hvM
         AvwnUQT05L0khfibSlPuUDuXeC6/REri6NBXmeNnHjm+jLgDXS9rJFQCRbmDAGnNREiE
         RCtQz8OlHH64aQDaGspLZge2VtFfT1R1J5FvT7PCyr7yH/eOfAKEX9BW5i0JxqAw+Kvf
         jJ1kXfKZFg+I3QWSaBzrkStqWDCvT+NlLvFDPuyNWP+ucHKVtVKKem7+a87tqVyvAuJc
         hrVOyBR2ggAgrvJggpKPfuhSXz+umiX3SI4rLYA1BxNEBagH6pknwbqnIKvIYpBpcZzd
         vzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751364059; x=1751968859;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OHi9FlGtRg/EDnf2MgHBTqXZr0Gl2vvMcmNgU6VzNOg=;
        b=OVA+Ezx5/ypi5KFtPCHOtfSqStuXOGNCZXHGDSEFg0C4t/YRvj00O4jMgi1Bvj2wxv
         pygRrY5e6GaH+pVlGVNezE6kH92AIxCp8h5fmBzwDgchTqiVdKiidSCd4Xvz2WP4/Mi8
         UXnld4kAoubnWswga8BTKETOW6A4CQkagjSURDgSiYVwUdR4f4s9Bf09H5BLeXxANZ3d
         e8t5EJHEgxMvi9GlKtFmxP0Dg0hSMoG8huy95UnQ17yM9QyRdo/6kdGRzsi5i/qNlP8b
         k+FIq30DT5OA/JBknqfP9Ago+Hk9D+bGH9r28fOnjTCBIn9L7Dqu+y5ZMNCETTZhfsj7
         M32g==
X-Forwarded-Encrypted: i=1; AJvYcCWdPI06yliBY5/NU5nxjY51Dp7ZtGfXrpC93b/ChFgz1hwUuVubgTooGN1XSCY0IHD4CJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZj4clxMq5Le0NUcn1QTEQKz+Z41m+KHzBSABK915dl1orH2xR
	jo3WkbDWo63fzcaO76bEy2gFDhbtx3kzFOxHGh7uMEzypq4aukvYsAiXRzM02g==
X-Gm-Gg: ASbGncss7w0rxFNhwE4zxZjyiE/FVZd1ASqm/fQqiMw+Mj/icXFZuP79gc/otxaK1zW
	yJrpCI0AujjGdUKT9ApvZhfRQvbiL16mbPlUbiv05YdD3P+0YQgBVXKWENKwku5RhYpxg0UxKmZ
	sGOy+f+YXs3Ke7qA1XRk158BGJdAaOJ+j1oJLi0/sXfn9sDqDawvL8zWQVZ81JfOIQa4MAso1mq
	2TQzsAg7mUcjcbw6NqafyQZr4voh3vu9YbA3GA6YwsJFr+s/dVHEdg56DXQ53YYWIMGRWotYHvq
	M6tpUpY4Uu5gTnjUgTFpgLvulUut0/GWyGUH9njd5b3fv+ruZ9VC9QBWjoxr/42tW63k753JE1n
	L0ny0k1Aa7NCQTL9UdUSe+k3aFqzRbF3tS6g0zQRZFsbxdk4=
X-Google-Smtp-Source: AGHT+IEcHwcx7H+sq9QVGlsGFvYJ1m4UhbGEzUXW4VyaxMnECodMxZBHF+KEuxNu8E7a4Nv/6bfu0w==
X-Received: by 2002:a17:906:eecb:b0:ae0:abec:dc13 with SMTP id a640c23a62f3a-ae3501a6ebfmr1510297866b.53.1751364058923;
        Tue, 01 Jul 2025 03:00:58 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:8515:f93a:c957:e0a3? ([2a0a:ef40:700:a501:8515:f93a:c957:e0a3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c01615sm851817066b.94.2025.07.01.03.00.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 03:00:58 -0700 (PDT)
Message-ID: <4fa954a7-ce48-41af-8106-21bb6f17d340@gmail.com>
Date: Tue, 1 Jul 2025 11:00:57 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] add-patch: respect diff.context configuration
To: Leon Michalak via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Eric Sunshine <sunshine@sunshineco.com>,
 Christian Couder <christian.couder@gmail.com>,
 Leon Michalak <leonmichalak6@gmail.com>
References: <pull.1915.v2.git.1746884789.gitgitgadget@gmail.com>
 <pull.1915.v3.git.1751128486.gitgitgadget@gmail.com>
 <1ec8a1384862765795f17e2d0fcb7b601ef2b25f.1751128487.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <1ec8a1384862765795f17e2d0fcb7b601ef2b25f.1751128487.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Leon

On 28/06/2025 17:34, Leon Michalak via GitGitGadget wrote:
> From: Leon Michalak <leonmichalak6@gmail.com>
> 
> Various builtins that use add-patch infrastructure do not respect
> the user's diff.context and diff.interHunkContext file configurations.
> This patch fixes this inconsistency.
> 
> This is because the plumbing commands used by "git add -p" to generate
> the diff do not read those config settings. Fix this by reading the
> config before generating the patch and passing it along to the diff
> command with the "-U" and "--inter-hunk-context" command-line options.

This looks good to me, thanks for working on it

Phillip

> Signed-off-by: Leon Michalak <leonmichalak6@gmail.com>
> ---
>   add-interactive.c          | 17 +++++++++++++++++
>   add-interactive.h          |  1 +
>   add-patch.c                |  6 ++++++
>   t/t3701-add-interactive.sh | 22 ++++++++++++++++++++++
>   4 files changed, 46 insertions(+)
> 
> diff --git a/add-interactive.c b/add-interactive.c
> index 97ff35b6f12a..e0aafb8dd02a 100644
> --- a/add-interactive.c
> +++ b/add-interactive.c
> @@ -39,8 +39,12 @@ static void init_color(struct repository *r, struct add_i_state *s,
>   void init_add_i_state(struct add_i_state *s, struct repository *r)
>   {
>   	const char *value;
> +	int context;
> +	int interhunkcontext;
>   
>   	s->r = r;
> +	s->context = -1;
> +	s->interhunkcontext = -1;
>   
>   	if (repo_config_get_value(r, "color.interactive", &value))
>   		s->use_color = -1;
> @@ -78,6 +82,19 @@ void init_add_i_state(struct add_i_state *s, struct repository *r)
>   	repo_config_get_string(r, "diff.algorithm",
>   			       &s->interactive_diff_algorithm);
>   
> +	if (!repo_config_get_int(r, "diff.context", &context)) {
> +		if (context < 0)
> +			die(_("%s cannot be negative"), "diff.context");
> +		else
> +			s->context = context;
> +	}
> +	if (!repo_config_get_int(r, "diff.interHunkContext", &interhunkcontext)) {
> +		if (interhunkcontext < 0)
> +			die(_("%s cannot be negative"), "diff.interHunkContext");
> +		else
> +			s->interhunkcontext = interhunkcontext;
> +	}
> +
>   	repo_config_get_bool(r, "interactive.singlekey", &s->use_single_key);
>   	if (s->use_single_key)
>   		setbuf(stdin, NULL);
> diff --git a/add-interactive.h b/add-interactive.h
> index 693f125e8e4b..c63f35b14be8 100644
> --- a/add-interactive.h
> +++ b/add-interactive.h
> @@ -18,6 +18,7 @@ struct add_i_state {
>   
>   	int use_single_key;
>   	char *interactive_diff_filter, *interactive_diff_algorithm;
> +	int context, interhunkcontext;
>   };
>   
>   void init_add_i_state(struct add_i_state *s, struct repository *r);
> diff --git a/add-patch.c b/add-patch.c
> index 95c67d8c80c4..b43ca1600738 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -415,6 +415,8 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
>   {
>   	struct strvec args = STRVEC_INIT;
>   	const char *diff_algorithm = s->s.interactive_diff_algorithm;
> +	int diff_context = s->s.context;
> +	int diff_interhunkcontext = s->s.interhunkcontext;
>   	struct strbuf *plain = &s->plain, *colored = NULL;
>   	struct child_process cp = CHILD_PROCESS_INIT;
>   	char *p, *pend, *colored_p = NULL, *colored_pend = NULL, marker = '\0';
> @@ -424,6 +426,10 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
>   	int res;
>   
>   	strvec_pushv(&args, s->mode->diff_cmd);
> +	if (diff_context != -1)
> +		strvec_pushf(&args, "--unified=%i", diff_context);
> +	if (diff_interhunkcontext != -1)
> +		strvec_pushf(&args, "--inter-hunk-context=%i", diff_interhunkcontext);
>   	if (diff_algorithm)
>   		strvec_pushf(&args, "--diff-algorithm=%s", diff_algorithm);
>   	if (s->revision) {
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index b088ee141ff4..18dc329ea1f6 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -1230,4 +1230,26 @@ test_expect_success 'hunk splitting works with diff.suppressBlankEmpty' '
>   	test_cmp expect actual
>   '
>   
> +test_expect_success 'add -p respects diff.context' '
> +	test_write_lines a b c d e f g h i j k l m >file &&
> +	git add file &&
> +	test_write_lines a b c d e f G h i j k l m >file &&
> +	echo y | git -c diff.context=5 add -p >actual &&
> +	test_grep "@@ -2,11 +2,11 @@" actual
> +'
> +
> +test_expect_success 'add -p respects diff.interHunkContext' '
> +	test_write_lines a b c d e f g h i j k l m n o p q r s >file &&
> +	git add file &&
> +	test_write_lines a b c d E f g i i j k l m N o p q r s >file &&
> +	echo y | git -c diff.interhunkcontext=2 add -p >actual &&
> +	test_grep "@@ -2,16 +2,16 @@" actual
> +'
> +
> +test_expect_success 'add -p rejects negative diff.context' '
> +	test_config diff.context -1 &&
> +	test_must_fail git add -p 2>output &&
> +	test_grep "diff.context cannot be negative" output
> +'
> +
>   test_done

