Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793456723;
	b=HQdfY4BRSV+TiEeEb07mraZ4BoaVP+jITzP6sRCkZeEBezZpM6YH25nO2Ju5FulzdAqA
	 s9MVzrNnQWeZoY3ngGUC4e3Zu0tUn/t8HSDT09mJwQr6IvtVuHdHCmUK/fRDHKfo5c7No
	 ET2844W3DqBepp9IgHEVclQ1rmpZWSpKyhNH8ttqvChw2rbLkrm+E1yzYPaw8U30ppuLO
	 ST3842YnVl1qIyyh5tjT6r8yIY0BgRRtcjqhoNoU+d+H/myCv8wpov49QAS1WQEUIFMya
	 AmC6Fhwi4LvHaQjCub/Hdqgu50MTtbzqjNoLC5UgueqKiEIVVpV5jESoj20kHqhUsbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793456723;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8sWgtpDDsU5STAyixtP/tV4jyvckanoIgoSJYAQ3Z0M=;
	b=GyWdXhS1fcsYSNdBIkfvMXhuOjXNgc0xvOvmZz1KtdmoF/ZXaclAD4w5NZWyjrO/p67y
	 UeHsKrft/g7k3tyWX/k0Ppan/UPlzQPB1Q7nZ94jHDFpuOimtFL1sq+RZmuRIeOHQz4Uv
	 cpoP7kjVluWAjIlM4i9FIrlgeb62l/dyUbFV3CJ6d5Kg45+14z17IK8Ru1b0xybP2/bAF
	 y5Pu0XzlGAUfUakk2rjW6xKfm/uE3TTnubBObzPeBOrOuuqF/+fDVEOeVKOOvKTj09IIK
	 CtSy1ghqOp930U9vg1rKKi+nheStHpdY74iViH4N6aDgjqx+s74kmLnrCwjLVwVUrgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QoNn87ka;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0EB606A324
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 14:25:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D0EB606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QoNn87ka
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso11080535e9.2
        for <git@vger.kernel.org>; Sat, 31 Oct 2026 07:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793456722; x=1794061522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8sWgtpDDsU5STAyixtP/tV4jyvckanoIgoSJYAQ3Z0M=;
        b=QoNn87kaJ1wnUgpwwAfkoAmmlqpHyeErCpOnXh9m1jpIaaYr7OGw9tOphT+r2+oBgH
         USCPFaon6+J33drUzInSJQ8pYyP3n67cNhhB0LtI9pU7DcNuhxne1OZUKmfDX1V4qopA
         TdQcGSYg+iQeFon8iB/ODynasVTbP2/A2NGL11yIqx6iHZOo6Y9nkCCNvWZTPf71PH8n
         KJos9sLh/cAK6dGQPJwfY+BUPGcTfYqjZg/+603MsMQHOAby+q7GEmoaceXqUnVUEb4j
         E7wqs3dk/MYTq9oU2LDiyGa+DINimTxYXNoqerJZzOt5HzrnLZkI62dRMoJ+l+P1qNgO
         sXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793456722; x=1794061522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8sWgtpDDsU5STAyixtP/tV4jyvckanoIgoSJYAQ3Z0M=;
        b=syglu0VlDA3acFfWBUzu8okK586Bc+AetSqFoW4hfYPOHhmRMk4AEDGhkEzQN7/eTz
         kiXVi/P30fYlenwEmnfRgBLCM303GRDkeSEWcvSw1XmDUcEWlvpbg1O6xmtKo7B7ytQr
         YxfkoPIBouuVjVujOXUSkJHCxC9BCx+i9bcEQzEoOQfXTQkwKq/ttz8Wa0g0vHReMkGR
         +OArAePag+YWwIhxR+FKB3S8gVTmJY3zqA76yVlrgLh3YG5++L9JjgfvY8ZfivkSFxIC
         QZLyAsVXJj4gPTzub7oUFqc3Qa+6EZDtw/5RTn8H0r3zOQsy5tNnljSHYRAkF6eNcbX5
         dLHw==
X-Gm-Message-State: AFq9FYI2OwVUC7NTC6Xvz1/csDugNcAxQ7KvYAITdNk96UNfWalHLWZc
	QSyBsfafvyDEtORg485vJiNjQzCKcl7YdgxFCELZBapOzJN/LLrG5+Ce
X-Gm-Gg: AYBFou0mz8H6GwtFHd6K2ntxzGTAy8rGrxW/ZojR2cd0EImtkih4xlOA2gtKKZEyek9
	Bzu9xvtQsOkUOQJJmPcABaYwMlHx6UlosisFDngPIdyEMKwQUMotBLRjGQNix1Wh1Q/8KKqjqbc
	5XwV+MRHm1/TDjnXD8b5fuzIGiljCKOMTCiEJr4ckrGB2LRizumaM5zMIN9LR2Ghpc51Vrif5a2
	h6QFPdio1TcjMJNWeshz8dIdeKSjUEVGCCKCl1wvR9WvfYlEWKrKYEKwZeb4YydaOseCWkAbTpm
	OueAzzZReDf5u/nl6PShv7hQdjmsxLSYQwFm5VQRCMAK9IoDxrrakjO11pw0YO3xkCMD8oy4dnE
	JjcUDd8sJTa1H8kkq+xmldWQjOEa2/Db94OzWDXgGkbRHhYXYBGFoksbRgdMqVZmw7dEM9LthAz
	DiLcCiTgwBpk0o1vqy0Dd8w72xgG4GwBFf/up5gyWmBttGze3bct4j/3ArsMfI5ntJ352BTfzvf
	27o7cb2dUzHm27s/yR4VlBDCQ6FrtXoZE+n3tRhxRuDgKvZ0EJI4rPJ69lJALfuT0XjX00jbgFo
	qSVBqzIeHDq2SDEGgvcAiVMjxPA++4SOh6pveuubRVz8CTq4qFPv
X-Received: by 2002:a05:600c:3b2a:b0:4a4:3a2d:15da with SMTP id 5b1f17b1804b1-4ac1709a2c3mr114845195e9.15.1793456721599;
        Sat, 31 Oct 2026 07:25:21 -0700 (PDT)
Received: from GODS-GIFT.localdomain ([197.211.58.196])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b80306sm9721477f8f.33.2026.10.31.07.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 07:25:21 -0700 (PDT)
From: Cynthia Uche <herroyalpriestess@gmail.com>
To: christian.couder@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	kaartic.sivaraam@gmail.com,
	ps@pks.im,
	newren@gmail.com,
	peff@peff.net,
	sandals@crustytoothpaste.net,
	Johannes.Schindelin@gmx.de,
	jltobler@gmail.com,
	cynthianuchepro@gmail.com
Subject: Re: [PATCH v3 4/4] fast-import: use early_scan_options() for --allow-unsafe-features
Date: Sat, 31 Oct 2026 15:22:55 +0100
Message-ID: <20261031142255.4941-1-herroyalpriestess@gmail.com>
X-Mailer: git-send-email 2.56.GIT
In-Reply-To: <20261012074413.337183-5-christian.couder@gmail.com>
References: <20261012074413.337183-5-christian.couder@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Christian,

I read through the series and ran t0040 and t9300 on the
cc/early-scan-options topic, as in origin/seen (tip dabb68a20d).
All 118 tests in t0040 pass, including the new early-scan tests, and
all 261 tests in t9300 pass, including the new R: tests.

> +	 * The scan uses the same options as parse_options() below, so the
> +	 * two agree on which options take a value and on abbreviations. In
> +	 * case of doubt, the scan stops early, so unsafe features are then
> +	 * refused rather than wrongly allowed.
> +	 */
> +	early_scan_options(argc - 1, argv + 1, fast_import_options,
> +			   EARLY_SCAN_STOP_AT_NON_OPTION,
> +			   option_parse_early_allow_unsafe, &state);

The call passes EARLY_SCAN_STOP_AT_NON_OPTION, but the 3/4 header says
to pass it when parse_options() is called with
PARSE_OPT_STOP_AT_NON_OPTION or with subcommands. That is not the case
here: parse_argv() calls parse_options() with only PARSE_OPT_KEEP_ARGV0,
and the table has no subcommands. Stopping at the first non-option is
the safe direction, and it matches the old loop, which also broke at
the first argument not starting with a dash. But the comment only says
the scan stops early "in case of doubt", and does not mention this flag.

With an input file containing
"feature import-marks-if-exists=nonexistent.marks", I tried:

  ./git fast-import --depth 5 --allow-unsafe-features <input

which succeeds (exit=0), and

  ./git fast-import --depth 5 extra --allow-unsafe-features <input

which dies with "forbidden in input without --allow-unsafe-features"
(exit=128). The stray "extra" would make parse_options() fail with a
usage error, but that only happens after the stream's feature lines
have been processed.

To see what the flag changes, I replaced EARLY_SCAN_STOP_AT_NON_OPTION
with 0 locally and ran the second command again. It then failed with
the usage error (exit=129) instead, so the scan had gone past "extra",
seen --allow-unsafe-features, and the unsafe feature line was accepted
before parse_options() rejected the command line.

I would suggest adding a sentence to the comment saying that the scan
stops at the first non-option through EARLY_SCAN_STOP_AT_NON_OPTION,
even though parse_options() is not called with
PARSE_OPT_STOP_AT_NON_OPTION, so that readers know why the flag is
passed.

I did not find other issues in this patch :)

Thanks,
Cynthia
