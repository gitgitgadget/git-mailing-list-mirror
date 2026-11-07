Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794040983;
	b=MSebrE9YQTZdCh4lB338UtwDWxv16505W+cQ44Y74NVdqW4qmOMRFyhgj821genG3MIs
	 xVeBVpSv7ya+GkogfB+lO3yG6Kb/Nt28BMtPEdr11I5UfGQGoOkYMaaCkALhRgoEgpt/6
	 0GxySrrIhvsFEraOjP7SsQb/q1UQfkywHZVS6+ApVlh5aPi9wzKPfQmYiEzO27MA+zSuW
	 wGzRrg+iHETxYDpC62Akbju0faCyyeNQXCe63g7p1Ty6a4wLmw+sijmCrr0Gqj4dWMAnD
	 G+A+W4goG336mc87rGXyPJWw02HdRBUGFElueUVyIg0pEkNaXs679p0VTpvLN60QVrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794040983;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=Eki/vWEecVQc51MvK47ar0SIvpM+9TWbA0WtBs1hxbQ=;
	b=MPqDdU9/dxDPUSvBxgMvvRiXCF8QYen8FAVPcST6B9wh//JDDAFyEhtOaII/WD/H9L/Q
	 OdHIqs0P1yxW0/gx0dO8deqtDZXlyCvNK7KCYSmJY1siawzz+WFwmyk+2V77sVUkIXdCC
	 AjwDtM08dQqQ0xnBsxQvrFKndlnTJvr4diBkNYlk/P1kl3m8CfMNqlGFnd36aB/8CqnB+
	 DsOvHWTya6rVLM0rVlm2/3iwQneKHtVjVtQGMe/7HeGSj++eK7McSjxMQIwQjqa5KNYme
	 ifm5k33NKgXNpVhVV0BMMMjilum5dTwUsYlA0lFLpDaBZ3Ppwm8K2xuLUr7+3kU0bQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=byQAjoIu;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E452606A326
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 08:43:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E452606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=byQAjoIu
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e8da6ef7ddso8030145ad.3
        for <git@vger.kernel.org>; Sat, 07 Nov 2026 00:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794040983; x=1794645783; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Eki/vWEecVQc51MvK47ar0SIvpM+9TWbA0WtBs1hxbQ=;
        b=byQAjoIu32Ka7tZ0rG5gH3nxyKx5+ZddEq3y9um2TwsFeBR0cdiEyO5qXOgrLVNf6c
         feY6sUoYq6Eu2konuE/2CCMnOgQq4l/EAa6FFOVqd/kbmFsPdWAuT7L8qGxeGakHKoD3
         z4pqAEGnjMf7ImIl7DyOufDyXVNYYUO62QNeEGOyNUTknAGDzVQ+YPgCEGDskBGtY1zs
         wkmn4BkFMTCnL/KdLPSdZ8uewTTtuIndEbFmtMStJUpjCc1cZvZFTEec06M5/wFlD9y/
         YEODsIIJrYUTI7EWrtTJwmr27y2SERxczWwmzS7wnawBXowlhnKO7JaYx4UWJG/9LLHH
         WuaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794040983; x=1794645783;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Eki/vWEecVQc51MvK47ar0SIvpM+9TWbA0WtBs1hxbQ=;
        b=b8FZk+Ojmu/5nxSY5VB5Gr0d2LbArDCY4wYgE7EWPgS2lU5X3B0j45pxyAlIOSOKvS
         /GX6NlgMxPbOGV5FXyvpqRz4gwhNkUpilJp+6R8nsE9Y/6lGT0ec/SxZMYq74NgRuIYG
         goWgzUZQ/RiIBF06KVIqCnK6mOb/t6pPRgh3mylNT1xC9Y8P4UV00mPo40Sv0CYH1Cvx
         quQD18uXC2CwHMap7pN+cc0XnisxQ7WZV/ayWnw68JetcpvszwsGaLVND0y2zTru/jvX
         8GTkyis60SA51s+xcXlcdm72WzISW+QztAcrzuTij1BD9w1xfoj58+gnwRHjW3syWL58
         F0nQ==
X-Gm-Message-State: APuU4Z+HySUiAlWUyeQ893PuWEd0R1gwIx/+v8OR0R1maJ/vPDYapCOn
	dSDZplM2F47Pl9L4nkdKUEmLglJpR0ujmmv1axB60Kx5LeBVtgYDOCLEUX+kdKLo
X-Gm-Gg: AYBFou2yS6yYN8wFRaaEGyFfqgDzLkLaZ5ynWFmqTiTpWngD15r8/6Agg0/IwvSoFcT
	9HnZSvrvV01OdlvibYssCFOpFkXCS2QjYxCUacbdeJHIwDmUNAUasiox67cWmfqFXafPc92qm4V
	d7IAFFDS/+Ugkrm2+OLTzbMNUFMAWDGGUktoW3wLPWDZMQprnHveNkKH3QIevQC6scxtjtSEfD6
	8ZUHbs+QPcDNtTqVDgYwQnCaAhqdO4aWf/85R4uZTKCQFhFc5jX9n29Ta/in0SPuXSDhy/WzOE8
	Lm9lQ/Ooj4+LEOjjACo0qaJKAoLCYtUo79zPMI7P3p176ALa1xTUGXCkx4q/zXSFjxe9jbiAWFZ
	nK+AhyXmZKXhfixdGMM5g5DL6Ao7fnVRMaTeRkjF33BwhtU8PzKb/OolYUe4JqYhBnHd4fQCqZi
	qd5AsxLxz9gTngsqwqDidoiXmuWtFJ/gzdiM6xYMavi5aDL9K9QeAGEEtL+o+N1DioFhytASb6G
	y+HacJMnLmxvEfazkvFSrupk131+jk9ms4GHz7Zav/jDLgbtpfUS2EYVLn+0Vz4JLwegmMv6j+4
	8apfk9dPse1fA6TvDpW9AWmUJy02d6es1g==
X-Received: by 2002:a17:90b:388d:b0:3a7:9adb:2a0d with SMTP id 98e67ed59e1d1-3b0db13e119mr4438443a91.0.1794040982737;
        Sat, 07 Nov 2026 00:43:02 -0800 (PST)
Received: from [127.0.0.1] ([52.156.141.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b10583c8b5sm2792861a91.12.2026.11.07.00.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 00:43:02 -0800 (PST)
Message-Id: <260b90a4a23d9a94aea0ed2a2e28930a646d7fd6.1794040968.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 07 Nov 2026 08:42:39 +0000
Subject: [PATCH 07/15] blame: handle NULL values for color.blame.* config
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

Reject a missing value with config_error_nonbool(), as
git_blame_config() already does for blame.date and blame.coloring.

Assisted-by: Claude Fable 5.1
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 builtin/blame.c         | 4 ++++
 t/t8012-blame-colors.sh | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/builtin/blame.c b/builtin/blame.c
index 48d5251c6d..653449c0c9 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -782,12 +782,16 @@ static int git_blame_config(const char *var, const char *value,
 		return 0;
 	}
 	if (!strcmp(var, "color.blame.repeatedlines")) {
+		if (!value)
+			return config_error_nonbool(var);
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
index d2653b3c31..5eeb7338a3 100755
--- a/t/t8012-blame-colors.sh
+++ b/t/t8012-blame-colors.sh
@@ -69,4 +69,11 @@ test_expect_success 'blame color by age: new code is different' '
 	test_grep qfunc colored
 '
 
+test_expect_success 'color.blame.repeatedLines and highlightRecent need a value' '
+	test_must_fail git -c color.blame.repeatedLines blame hello.c 2>err &&
+	test_grep "missing value for .color.blame.repeatedlines." err &&
+	test_must_fail git -c color.blame.highlightRecent blame hello.c 2>err &&
+	test_grep "missing value for .color.blame.highlightrecent." err
+'
+
 test_done
-- 
gitgitgadget

