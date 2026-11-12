Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493525;
	b=SXxwIdvGmN1V3U8nSPW6IOTvbxgTQdiXCW+7PAeSDo5hDQQex4YeEiUZuWdJWPSde//4
	 OZFKVtZS00g3PnPVHuN5+2d0ORdnurkT+UIcI4QwfYAvdwhr3SxO1hdhKM21ENiAxnUmE
	 g3je+ENZXa492NhYdD/UHZ9aD3xfgcgWKMMV8FHJNcGAWQCuf/4yG/OGYNEPuWhXtKU9b
	 A/e01o1l0D8dfp13vCZGb5Ga2WTJY1SQcc/eEjj++5Ozmym1ceN65yTOVToHpDZtjYdaF
	 p3QBZCpVOB+JdcP56yLfiH6fHLkHa2VueFTwdCSOfJqSfp0iONm965f3CkZg1PbxW7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493525;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=4/IMXe+DppUU5OTGAyszFlR6uQgwFdXf4HCo6LeZKzE=;
	b=gNaSHPbJZoJvP2PVq+5CqRWCNX0PktvKonNNzOxuyWB89MAbBcbphz0/8e+O3TvCsxF7
	 Hi/Ihc90NgbH9h2BU0sSW34WylFWPWLi3iqsjVtpYh7uD1+gq3Ji8btU2YFO2dqD3afLV
	 Gg5UnJp+W5Hzs4WM2yQIGSH1wGHaUyd4RXbTxxA1bdTdkexC/oi8wxKfC+3iAyQ/T7lF8
	 n8cSKt9K25+ZyML6huiKMnFV0bEgVAymzizdOgINPYX/ySAGxqbXt0FhTVdmhcRQAhW4X
	 ib1iLg6HCxs97YHtGvHHiX9DS1C6PLprycAnzDdB++q/YBT3uYwFVxXQoe5kqM7DeYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LSIWJUoV;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09352606A882
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 14:25:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09352606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LSIWJUoV
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so45953745e9.2
        for <git@vger.kernel.org>; Thu, 12 Nov 2026 06:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794493523; x=1795098323; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4/IMXe+DppUU5OTGAyszFlR6uQgwFdXf4HCo6LeZKzE=;
        b=LSIWJUoV9NhJ5ospOZ6Vi2YAHSrZnD1O3Ot8gFo3kmTWUAVw2vJmB9gKAHRT1Yv4Q8
         lK3elMpuqdvGhniywBVAIX97yzB8iL0PHVDA/V4+CjerI+gVTNduCHoEXvQQeq0aZfYa
         cO/bo2X5W3s8+jTC8wxCY6Jv60j6LjdIpqeD6H16WHOO6g3Sy9zlrubPP0BjaAfapvnY
         VfubgjC6KM49CDnY5xoVW9W57//tD3R0ElZeIL11+nrXi8biHGfYLAtqkqr0XP/Zy+8C
         8NnHcMaAN/Ioq4nUdob8CpC7CxsnyfWHi7uAZCGwMo0Mo7X4X7IdSHFQ+AVPOTN99Hg0
         j18w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794493523; x=1795098323;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4/IMXe+DppUU5OTGAyszFlR6uQgwFdXf4HCo6LeZKzE=;
        b=QHHANj9TAMk9NEHv4g/CXi/ZdD4Rk3Ar1YXa2TdG7GZ8FtCGjgCr2teaYqQmxfITKU
         NH92lEZMGZ7eYEAzkgz19pzAifFeyI74Si/61qGoadD4nsYupwPdENBRqrXuTWLRME/p
         w8dsb3T3myW0ELM9xAZDQ4mL7rE7pG56WlZywgppyGu6sunmTWfKcM5kZNPWS0i6N2He
         dgqPems9yThWmID2TdmPfgfi08RfqHYekNyjAT2peojp0zKYhPD7rKzm+gShkeDiaSGa
         Wq0sRG9/DFooxac1pIGelgHOOxqC2POf4sbB4Q4nx+GjQesIdt5/SDb8CynbJq1TArVx
         AdPw==
X-Forwarded-Encrypted: i=1; AL+hErGYVRP+nI1GUa/WuPmR2UcL3dZ3/+T1B9Be3VlCsL3ZY6aCS2xz5mtycf4A2S45wbY1iQw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/1ReuHAYXYHZT4GQkJ2QH4O1TZ5If19DzUfdL0iyG9QEOaxf3c
	+2UMVx3KuCWwnzFkKnKUTUKDeyZTurckHnA4e7DQvs0Bf9i1UvvUpbDO
X-Gm-Gg: AYBFou1D5vWxJo/yfMt05ocJcwwDe9v5GgHyuYnHfpkt4Hv+KryGC4qorYPC6hoyn5R
	+KGYO4AfG0umEvt9AOImykvuRXO6Hq+tr82bpmQlN8hW7P2jn7qewOxlKS2FObwK5t3VTVQAZwZ
	aI3QA6ARwjXO2FafqjXTceu6nLL6UPieHgUOE1854RZ8bJKj2oSP/BE+LBncdtNqyDsQK8UfgZs
	swDjBgkZdfkwNj+gslEbn6Nky0Ey16YGedM5GretpS4aCzeyAzpEShE2m17ed+qyqSrHZx/4+Sg
	oAd6IKEMX4ilVAmh3FB0gBmrd47scVJMQ/WMgzCn+q3MOTfcHNifVVVBEqlSoPIGtQszE9GMF5v
	YlcivvGkN5ZxdgOw/wxlfOAQMOcGF1VkiDyRdq2Gl6Roriwfo1EAebMK9urJvV1cs+Y8m90lV7r
	NqTuIIeJwXbdJ73G6p08cXMR2SsQoZ7JLSpHNDZWZoyg0AK7MBhneYTG/53W12nFdHecrElZOwt
	6Zc07A1AZ66UfJGX2V3M+YYz4MyFiDZvQrh/WNdQTZlmoIH7Eil7SSDV0dH1DmsFe9v5PZs3YIp
	Sbd7eV3wtnd+Nbn/jb+OlfY6358KZGqRQANhA457g6EhZgpk3d1FrtPJzNoNzoy3YbWeHIF2/ks
	DVV2tk/ZU
X-Received: by 2002:a05:600c:a0c:b0:4b8:4af2:88b3 with SMTP id 5b1f17b1804b1-4ba0938b7f3mr118292495e9.22.1794493523130;
        Thu, 12 Nov 2026 06:25:23 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498369a3fd2sm17736851f8f.52.2026.11.12.06.25.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 06:25:22 -0800 (PST)
Message-ID: <f04be044-96a7-40e5-9fb9-81bde0e3dc04@gmail.com>
Date: Thu, 12 Nov 2026 14:25:18 +0000
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 00/15] Fix segfaults on settings given without a value
To: Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>, Jeff King <peff@peff.net>,
 Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
 Patrick Steinhardt <ps@pks.im>, Colin Hinton <colinlewishinton@gmail.com>,
 Matt Hunter <m@lfurio.us>, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Usman Akinyemi <usmanakinyemi202@gmail.com>,
 Miklos Vajna <vmiklos@collabora.com>, Junio C Hamano <gitster@pobox.com>,
 Thomas Bachem <mail@thomasbachem.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
 <pull.2297.v3.git.1794437355.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.2297.v3.git.1794437355.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Thomas

On 11/11/2026 22:49, Thomas Bachem via GitGitGadget wrote:
> Changes since v2:
> 
>   * Where an invalid value is ignored, a missing one now is too, with a
>     warning: remote.*.tagOpt (patch 6) and color.blame.repeatedLines (patch
>     7). v2 rejected them (Phillip).
> 
>   * The test in patch 1 rebases onto HEAD~3 and checks the result with
>     test_commit_message (Phillip).

That sounds good, and the range-diff below looks as I'd expect. Thanks 
for working on this, as far as I'm concerned it is ready for next.

Phillip
> Range-diff vs v2:
> 
>    1:  47224a9893 !  1:  1262222ccd rebase -i: handle NULL value for rebase.missingCommitsCheck
>       @@ t/t3404-rebase-interactive.sh: test_expect_success 'rebase -i respects rebase.mi
>        +	rebase_setup_and_clean missing-commit &&
>        +	(
>        +		set_fake_editor &&
>       -+		FAKE_LINES="1 2 3 4" \
>       -+			git -c rebase.missingCommitsCheck rebase -i --root 2>actual
>       ++		FAKE_LINES=1 \
>       ++			git -c rebase.missingCommitsCheck rebase -i HEAD~3 2>actual
>        +	) &&
>       -+	test D = $(git cat-file commit HEAD | sed -ne \$p) &&
>       ++	test_commit_message HEAD -m C &&
>        +	test_grep "missing value for option rebase.missingCommitsCheck" actual &&
>        +	test_grep ! "commits may have been dropped" actual
>        +'
>    2:  9170c4162f =  2:  ec9d7fd183 odb: handle NULL values for core.alternateRefs* config
>    3:  d3fd6290e0 =  3:  c071e79d11 add-patch: handle NULL value for color slots
>    4:  a822cbb844 =  4:  8773aaef0b bundle-uri: handle NULL value for fetch.bundleCreationToken
>    5:  6c2a671a92 =  5:  123f03f024 grep: handle NULL value for grep.patternType
>    6:  d4b49d1363 !  6:  339590cd4b remote: handle NULL value for remote.<name>.tagOpt
>       @@ Commit message
>            "git remote" and "git status" segfault: handle_config() passes the
>            NULL value to strcmp().
>        
>       -    Reject a missing value with config_error_nonbool(), as handle_config()
>       -    already does for remote.<name>.url and remote.<name>.pushurl.
>       +    The setting takes "--no-tags" or "--tags", and any other value is
>       +    ignored. Ignore a missing value too, but warn about it.
>        
>       +    Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>            Assisted-by: Claude Fable 5.1
>       +    Assisted-by: Claude Opus 5.5
>            Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
>        
>         ## remote.c ##
>       @@ remote.c: static int handle_config(const char *key, const char *value,
>         		else
>         			error(_("more than one uploadpack given, using the first"));
>         	} else if (!strcmp(subkey, "tagopt")) {
>       -+		if (!value)
>       -+			return config_error_nonbool(key);
>       ++		if (!value) {
>       ++			warning(_("missing value for '%s'"), key);
>       ++			return 0;
>       ++		}
>         		if (!strcmp(value, "--no-tags"))
>         			remote->fetch_tags = -1;
>         		else if (!strcmp(value, "--tags"))
>       @@ t/t5505-remote.sh: test_expect_success 'remote information for the origin' '
>         	)
>         '
>         
>       -+test_expect_success 'tagOpt needs a value' '
>       -+	test_must_fail git -C test -c remote.origin.tagOpt remote 2>err &&
>       ++test_expect_success 'tagOpt without a value only warns' '
>       ++	git -C test -c remote.origin.tagOpt remote >actual 2>err &&
>       ++	echo origin >expect &&
>       ++	test_cmp expect actual &&
>        +	test_grep "missing value for .remote.origin.tagopt." err
>        +'
>        +
>    7:  25843b43bf !  7:  ad50c4b35b blame: handle NULL values for color.blame.* config
>       @@ Commit message
>            value makes "git blame" segfault: git_blame_config() passes the NULL
>            value to strlen() or to parse_color_fields().
>        
>       -    Reject a missing value with config_error_nonbool(), as
>       +    An invalid color.blame.repeatedLines gets a warning and is ignored.
>       +    Treat a missing value the same way.
>       +
>       +    An invalid color.blame.highlightRecent makes "git blame" die, so
>       +    reject a missing value there with config_error_nonbool(), as
>            git_blame_config() already does for blame.date and blame.coloring.
>        
>       +    Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>            Assisted-by: Claude Fable 5.1
>       +    Assisted-by: Claude Opus 5.5
>            Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
>        
>         ## builtin/blame.c ##
>       @@ builtin/blame.c: static int git_blame_config(const char *var, const char *value,
>         		return 0;
>         	}
>         	if (!strcmp(var, "color.blame.repeatedlines")) {
>       -+		if (!value)
>       -+			return config_error_nonbool(var);
>       ++		if (!value) {
>       ++			warning(_("missing value for '%s'"),
>       ++				"color.blame.repeatedLines");
>       ++			return 0;
>       ++		}
>         		if (color_parse_mem(value, strlen(value), repeated_meta_color))
>         			warning(_("invalid value for '%s': '%s'"),
>         				"color.blame.repeatedLines", value);
>       @@ t/t8012-blame-colors.sh: test_expect_success 'blame color by age: new code is di
>         	test_grep qfunc colored
>         '
>         
>       -+test_expect_success 'color.blame.repeatedLines and highlightRecent need a value' '
>       -+	test_must_fail git -c color.blame.repeatedLines blame hello.c 2>err &&
>       -+	test_grep "missing value for .color.blame.repeatedlines." err &&
>       ++test_expect_success 'color.blame.repeatedLines without a value only warns' '
>       ++	git blame --color-lines hello.c >expect &&
>       ++	git -c color.blame.repeatedLines blame --color-lines hello.c >actual 2>err &&
>       ++	test_cmp expect actual &&
>       ++	test_grep "missing value for .color.blame.repeatedLines." err
>       ++'
>       ++
>       ++test_expect_success 'color.blame.highlightRecent needs a value' '
>        +	test_must_fail git -c color.blame.highlightRecent blame hello.c 2>err &&
>        +	test_grep "missing value for .color.blame.highlightrecent." err
>        +'
>    8:  d8681a8560 =  8:  90209dc754 merge: handle NULL value for branch.<name>.mergeOptions
>    9:  51f8eba073 =  9:  f30ecf07b4 remote: handle NULL value for remotes.<group>
>   10:  a5b6436943 = 10:  bb6eecd20c setup: handle NULL value for safe.bareRepository
>   11:  1533ef9cc6 = 11:  510dc56c9b pseudo-merge: handle NULL value for bitmapPseudoMerge.<name>.pattern
>   12:  6219e9fd7f = 12:  751fae34b2 scalar: handle NULL value for scalar.repo
>   13:  080106d5ea = 13:  4d5d2ce04e config: handle NULL value for remote URLs in hasconfig includes
>   14:  fb9e63541b = 14:  474aebd572 bundle-uri: handle NULL values in bundle lists
>   15:  12f841e5ff = 15:  f6f3295ff5 config: handle NULL values when listing colors and expiry dates
> 

