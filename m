Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437373;
	b=y6Lqcooq0wBW7dQgAFG8LrMCbNSV6S9QLXSd6BdzbYHIe1SpB0OnoJDwi4H60LX0DRJT
	 O4ur+dqgr492UdfFKCNUhGKeJIpanzxmRRmLWu13mr1GGlOCh9ruMhXGxGNX6jVPQUxDW
	 rk4uKUsmSsz4LS1brjvwrbIFehlPJkNPayLUXjv7O68jQbRZQOdMgg34ZsqAJTmpx7olz
	 BSLNuQFkYNnoAzWMlRbijtiHyeQ5vJN7V9K8EWYe+jNk/H4U9TJnVdAbOAOJUwm3MmeSn
	 Fowd2sHuzze1a86Xh5VYDtQsVCgBTO4td1vDKD6OVSD87cOy4uiwu0VuAVyLp0vwH3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437373;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=rLPko4udGJdiL4AV3GRLIevb7CkMqTaHSxQtbQwzmC0=;
	b=M24hEYmnvads5F+B4YyAYhImSdPIqx3nvEl7Jdw3CtSKQ1ZZm2bEyr8RuC2qrm6jgGCa
	 Af4Cei9o4Bl0dxd+00hUQQVlXrau8Jy2cdWsYY6MZSy1S5Cc5kLmf0lY9ZqyybY7wrxPE
	 dQcdDu6xXF8m2uS7V60UbuMBVwczr/bM7mNyZoqYbmrCDs8HXFKLYDi/SJIcYst+UfEvH
	 ZqS9SjkWSauRLHzkP2ffXiy2cEkmoxieHk9HVD5mRyQE/Sqj1bv4jSZiEoXhmWc/Vxf+P
	 t7mCFp8Ra70pBjexaBs8vnTzCf6QluM9H0H4l6om383kcWQ3BOk3Y7R9hWJUUvcX86w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aBGmekRX;
	arc=none smtp.remote-ip=209.85.161.42
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98123606B01D
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 22:49:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98123606B01D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aBGmekRX
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6d290b10a35so1511037eaf.2
        for <git@vger.kernel.org>; Wed, 11 Nov 2026 14:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794437371; x=1795042171; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rLPko4udGJdiL4AV3GRLIevb7CkMqTaHSxQtbQwzmC0=;
        b=aBGmekRX7q8sdkMLp+7ofS1RhlowwxlWl/B3XtArn/escSj+6Ojavwh46OAyOk7TRO
         u++KDHD/a19fmPF09CMAhaKtr1mBdtClS5gF4+M9PkxnkFPCbHtodgKBnEyPfSTAFcI6
         i2QFzTwQz7xjCHBXmxLJH971asUF5i7cLiNSr5sI3tbEEqawqmiBOTVHLzQQ12CKbSPZ
         pPiNkRYyyaqrsdAi0X81L0t1g32K3ehB8H5XA2ryGPatN15k1rxxGefhqZ9YYYPe1e4j
         9ZuJkIpJ+cv6G0XC3KQ9uq5eKhnxUni7glIgOHBT3XUfsfNCVJvGo1JmhYKr2OT53H30
         0XPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794437371; x=1795042171;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rLPko4udGJdiL4AV3GRLIevb7CkMqTaHSxQtbQwzmC0=;
        b=W2GhD8OeSftdBNCOlrscRQ2QS1ldsJD02oNP2AMcobooSnx4Ix0KDShuc1/nWCtSwj
         WfmTZkLDUvnBTKmmt41Dvxt+vtQWN+OcT7OanEtEVew/r/VAZUI+c4c0VopQOXTAQggT
         Zarf3LKYDdaPBnlfza5bi+d4uMgdpO0SMCZ5e+Ydgo7YPaHCmkbdo3DxBHoRC2Bpnd/+
         WPK9Hd1yQ/5Vw+R6NTYutJTIcDV4n+hXlpYVd7rJcKN8HMyNvo9m9ylLWuS6W9oqrgAB
         N7bwrMNOjIqcYNrqy/3P6CdvaTQnb8PL0epfR/qlqOxpoketov/VYUFKXIRD9HJDs1BC
         yYEw==
X-Gm-Message-State: APuU4Z891Dau6wkG2SD+YflsVimLPKbmIEjsf/xLBFo87Phkpe9d+EpY
	K33p5eaQ9zWJHTEK65UcZ8Oc0OtZymp6mSnEHm60grCK2SiYB9Kn3YvDk8cBFYXB
X-Gm-Gg: AYBFou1eA3rgWZCVga2GpOxGSTZOmWcqlwAC8gYdomyOLPL4qV5WCCTkmQHCIQS4FM0
	xDlJ5FXm4DyHZG0ebhO6a8vvPWYAivsRl96/bM3oMlFhJmrpsu8X9sQ/GwYe5ShIwDStgwL5lfs
	ORsY1/NxmgRA1faJVIgUnXVuUOuDlRNOMpogVcjFGnj10OduSsFXz9Jp4BytbNsVPI73mkES2ce
	gDl1IaLaTqeonks1ojMoE+T5dXMsvOrOGv2gr2ZZn+C2sHM6jo49Q45RC9GE2zUaBoKr+Eb3DeT
	4H5PWE74TXyqCY5LEz4YzKT/QHqnDFgm46T0HhKC9h6FD3ZQOiAOjQHLanZu6tvRE13U1ACORqW
	i7RJZmu6FuceS+03ADHH/6qSJZy0atj+q0xE89onbPKqAOaobigOOlYQ3z0HAMP7LKmlHoDeuIb
	gpHTxFo3i2uNI/5p59Gs8SzPPhpwZmiGcRLBKFOqBecf7GrEXK0f12sToMM+IW/t1biGIrqkrWp
	xGfSJbCEpJ2VQ4zO/neJbLVUkQAn+A65ke2K5Wz58KTjh2IsN3rf3IVS+d6q328YaMGIbiGq79E
	t44vFAvpyUs+Go2P+Tv7h01KljdImJVVwew=
X-Received: by 2002:a05:6820:a701:10b0:716:d887:17c6 with SMTP id 006d021491bc7-71917617548mr1867757eaf.10.1794437371597;
        Wed, 11 Nov 2026 14:49:31 -0800 (PST)
Received: from [127.0.0.1] ([130.131.199.169])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4ae22fbc9c5sm4515717fac.9.2026.11.11.14.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 14:49:30 -0800 (PST)
Message-Id: <ad50c4b35be75e0fa3b79c450ada25535c5c491f.1794437355.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2297.v3.git.1794437355.gitgitgadget@gmail.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
	<pull.2297.v3.git.1794437355.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 11 Nov 2026 22:49:07 +0000
Subject: [PATCH v3 07/15] blame: handle NULL values for color.blame.* config
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

A color.blame.repeatedLines or color.blame.highlightRecent without a
value makes "git blame" segfault: git_blame_config() passes the NULL
value to strlen() or to parse_color_fields().

An invalid color.blame.repeatedLines gets a warning and is ignored.
Treat a missing value the same way.

An invalid color.blame.highlightRecent makes "git blame" die, so
reject a missing value there with config_error_nonbool(), as
git_blame_config() already does for blame.date and blame.coloring.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Assisted-by: Claude Fable 5.1
Assisted-by: Claude Opus 5.5
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 builtin/blame.c         |  7 +++++++
 t/t8012-blame-colors.sh | 12 ++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/builtin/blame.c b/builtin/blame.c
index 1e753a0b60..55a3151942 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -783,12 +783,19 @@ static int git_blame_config(const char *var, const char *value,
 		return 0;
 	}
 	if (!strcmp(var, "color.blame.repeatedlines")) {
+		if (!value) {
+			warning(_("missing value for '%s'"),
+				"color.blame.repeatedLines");
+			return 0;
+		}
 		if (color_parse_mem(value, strlen(value), repeated_meta_color))
 			warning(_("invalid value for '%s': '%s'"),
 				"color.blame.repeatedLines", value);
 		return 0;
 	}
 	if (!strcmp(var, "color.blame.highlightrecent")) {
+		if (!value)
+			return config_error_nonbool(var);
 		parse_color_fields(value);
 		return 0;
 	}
diff --git a/t/t8012-blame-colors.sh b/t/t8012-blame-colors.sh
index d2653b3c31..2024047c85 100755
--- a/t/t8012-blame-colors.sh
+++ b/t/t8012-blame-colors.sh
@@ -69,4 +69,16 @@ test_expect_success 'blame color by age: new code is different' '
 	test_grep qfunc colored
 '
 
+test_expect_success 'color.blame.repeatedLines without a value only warns' '
+	git blame --color-lines hello.c >expect &&
+	git -c color.blame.repeatedLines blame --color-lines hello.c >actual 2>err &&
+	test_cmp expect actual &&
+	test_grep "missing value for .color.blame.repeatedLines." err
+'
+
+test_expect_success 'color.blame.highlightRecent needs a value' '
+	test_must_fail git -c color.blame.highlightRecent blame hello.c 2>err &&
+	test_grep "missing value for .color.blame.highlightrecent." err
+'
+
 test_done
-- 
gitgitgadget

