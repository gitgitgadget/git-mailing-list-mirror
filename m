Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794040977;
	b=h80+BY/915JSRQ/B9QUa+jqggEePCrf7TV53ATgPqv4O/Jh6Ms4rVHKpNaVPLopOPrz2
	 46NSh5YlLmqBzAZIrfeqTKpolBllKIVpf4+ICQIAXpwsjcKG1l96HI1NJDVg/YCTzY7NS
	 ETlSzTlvjb2HEan+fRqvP8q062xoCkfE5VTUD+GpLgzSFXSeRvdfXCrN5KeV7d8gMWaA7
	 MnYOU2zdRhgsGUfuRdIq3C9X7VniLHCBQC5z+ycWjoOeehw+Tt5EDjLEI09D7uIFbgNfU
	 Optg61jcv5fgBjUo+/D5cirnoOlzRZUDAwkeUsjUQ8ghrZ5gDx6ZqVC9SVkKbVCU/VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794040977;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=RDXTSRorkwwGKpfGvPjIEs9FY39cF/2a0R5Y5rHIouk=;
	b=HkcyDzre24uYbGsFS7UZDFHmqq5ZlxBCRcMBo8wR9r3sbhoT8XfCq0XPUVVN1i7Jq1x+
	 wRRogapdE0nSH/evlJM4nijMgotT4Hja148nIo0rFrarb1JtWC2xQ2RvRecwt5UjrmVxp
	 1uOL7++eMAKsk+C5Zqz1hngt6OatZ+c2ds178CK/200T+L5e7ZiTpWkw2iEVLd8Sfh2Ln
	 r4sOWZ4X0GJ6R4Y5MLPPg9yO4dNaNDB+kUjmpn6zVOE5wB9HdEn/o3irLTEWBMV/sGpcB
	 muKnZuj+yy3f+XUxa66ydHFsK254NPeO4jvI1dh7/z1NaSwY5UOJ5A7XyqxknXRaYFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=03XfVGHl;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B1E606A32C
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 08:42:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5B1E606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=03XfVGHl
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3b09a83d12aso935962a91.2
        for <git@vger.kernel.org>; Sat, 07 Nov 2026 00:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794040976; x=1794645776; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RDXTSRorkwwGKpfGvPjIEs9FY39cF/2a0R5Y5rHIouk=;
        b=03XfVGHlCNgv3gGURRmvzFD8jKOXLdKMzGg9WaYh51M2Zyo6DoJhBPUy7+HTci8pa0
         NyeKkYFNDTaohYTdpzB6TQ5JDYIVQtJRkPujUI1ZPIU6Iph65+hChCaCVqgqOBtCHJXC
         TwZ/5pPHsqRnwPKzsW4pFnf4PLqEIWLDaXFhJhVemjGV4NE8iwBxX9e/zPi66PPBT9mu
         13BPyUMc8RZNn+sqeDaPqFIAodY1rs0yX3CH5NkufL0i2CCvG9/O7Q+MPOjboto2OVA4
         XrBdG8tt/nHvghH241haeMWzY+i99AIShJFQFkQhQPcRzkAFmDOW2hit138CevF7FfCS
         PoYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794040976; x=1794645776;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RDXTSRorkwwGKpfGvPjIEs9FY39cF/2a0R5Y5rHIouk=;
        b=QAPVAD5Ttz3riqaRncIY19R2YCR4NIPY9MEfYi0JFoT0pW0QxJZ7+FADirrX7jujcW
         FxVmKZpvvKNZ81u3wuLjNknVxNybB3X5VOlwdPBpPJh/Jp+YfmIsBWlS5Ydtnk3RqyU2
         WVlDRKvJNRs7Sfyu2KBNB23gQiZLbKIbi25JlKNPWFWYyxbZxT62pUCmKo3XXD7x8EbX
         6lz+bk2/DqGHAFeQd6pMzqFmKP/NnxjVDU/W+sbtS4QssxytCTsuWAfSqBnaubkH+gRl
         A96IitCAgfC8m8VIKMJM7TnmNkgX3ep9aywI140JKLSxrfdgUfk05KSXACmrH8z9TAAn
         R1BA==
X-Gm-Message-State: APuU4Z8RBJ+iRtr50rsMYVqQPIz+ZweJngEZZMDecOPTSw+APIRDhWM+
	1ElO6LR0dykMEuwV+72kRWpEtgFtF7NLxfj1UZdo2DDL3xzIRmvjEWWfxevZAA==
X-Gm-Gg: AYBFou02MMvvLx1drcLkEulZVOQuJGlfExyiLksRym5Ex30gjdZlPq9RpM8Q3204j7J
	c5H8G5AWGxD6zwP2DBCbfV6UrcnogD+sO73hJW7uMbNDKorWX2L/d4mkyHptgfxXE5Ea8QG19dI
	vFLWciKOtq9p6ioBym1xFc9XQQDVs2EdbMrYe5FteVAwB62lQm479rixwx63UDFFjOxJUn871L3
	fqT2J8i6FjC02q7VWkyEgTXYAGiaGws9193W0R7orWoppz55VkKfOOGHg7fHNwVnwQ1Q3Z+Re/1
	khrcXA6vCPd0eBdQkAiGagPqeDNdKoJ8fTlErJANAhqQ5u1O/bsYqgkUCvOhkBNi723S60PcsAn
	+WhK05qqH/0Ch+dpDa5yDcF1mpqsGmaGt5qfAP5VYqGaspGKIYBxP7svkd3dvMCCWJHSaNO7dzX
	rYLo8WO89NcelbYPZqrXx/6+7EAerQGH7CnuQllzMEvHmnyuxbni7iLMcITb4QZIAcuHCu308tc
	fQbY0+GyUjGaA9Txk04CCUW6vBchWKRN5NEIgxRV/kHQ4YYj+3pcguLkKPFubBxqcG2o+02gMNh
	pQS8Kv8qtBZ2KUQYHcAPDKbxwYP9vYj5lSFLm3wvkmC2BUZY2wppFn0=
X-Received: by 2002:a17:90b:2d47:b0:3ad:ce24:acfa with SMTP id 98e67ed59e1d1-3b0db6b0d42mr5273408a91.20.1794040976168;
        Sat, 07 Nov 2026 00:42:56 -0800 (PST)
Received: from [127.0.0.1] ([52.156.141.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b10585df83sm2646325a91.16.2026.11.07.00.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 00:42:54 -0800 (PST)
Message-Id: <1b5f24329451984519cac3badd4bf6fade0c10c7.1794040968.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 07 Nov 2026 08:42:35 +0000
Subject: [PATCH 03/15] add-patch: handle NULL value for color slots
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
    Jeff King <peff@peff.net>,
    Taylor Blau <me@ttaylorr.com>,
    Derrick Stolee <stolee@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Colin Hinton <colinlewishinton@gmail.com>,
    Matt Hunter <m@lfurio.us>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Miklos Vajna <vmiklos@collabora.com>,
    Junio C Hamano <gitster@pobox.com>,
    Thomas Bachem <mail@thomasbachem.com>,
    Thomas Bachem <mail@thomasbachem.com>

From: Thomas Bachem <mail@thomasbachem.com>

With color on, a color slot without a value, such as
color.interactive.prompt or color.diff.frag, makes "git add -p",
"git add -i" and the other interactive patch modes segfault:
init_color() passes the NULL value to color_parse().

Read the slot with repo_config_get_string_tmp(), which rejects a
missing value with config_error_nonbool(), as "git diff" already does
for color.diff.frag and the other diff colors.

Assisted-by: Claude Fable 5.1
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 add-patch.c                |  2 +-
 t/t3701-add-interactive.sh | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/add-patch.c b/add-patch.c
index f27edcbe8d..ad581eb4ae 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -295,7 +295,7 @@ static void init_color(struct repository *r,
 
 	if (!want_color(use_color))
 		dst[0] = '\0';
-	else if (repo_config_get_value(r, key, &value) ||
+	else if (repo_config_get_string_tmp(r, key, &value) ||
 		 color_parse(value, dst))
 		strlcpy(dst, default_color, COLOR_MAXLEN);
 
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 6e120a4001..33050ccc53 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -815,6 +815,18 @@ test_expect_success 'colors can be overridden' '
 	test_cmp expect actual
 '
 
+test_expect_success 'a color without a value is rejected' '
+	git reset --hard &&
+	test_when_finished "git rm -f color-test" &&
+	test_write_lines context old >color-test &&
+	git add color-test &&
+	test_write_lines context new >color-test &&
+
+	test_must_fail git -c color.interactive=always \
+		-c color.interactive.prompt add -p </dev/null 2>err &&
+	test_grep "missing value for .color.interactive.prompt." err
+'
+
 test_expect_success 'brackets appear without color' '
 	git reset --hard &&
 	test_when_finished "git rm -f bracket-test" &&
-- 
gitgitgadget

