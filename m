Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437396;
	b=pMU/BkO3aQmNnj+//PoiohHp6hu+tcNGLL/7EMLYOkW/uOIDSs0ZN7KBteHjrHRJFv6G
	 DM4YasuemwUctmz6koBCxGPCiqfG+dkmnAJ9E7xIX6aeTYVc8KxYVARpbz50+DLPCg91g
	 DNoLgfO6j/STH50KLpefnyN1EQu38PpP5GpmZQ2Ad+6jhZ222u0dwU1x8vSfqmOc9BWDd
	 8M9Zjn5LdaGbaCeHtWkt+kfBHNuQPgN8dH2PtdBvTCS8cFMXjQWkFj4k/SZw5cTBS+7eI
	 nkEx6FvdGx8JbitKGwgVak6fGlnw8sx21A/Cv8+E6y5C9rsqpl7Ac9KK5C8Xk3nEsLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437396;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=SO8YdVtJ59WtrVckJs4Y+gfGI1+aG8xdfxxj2hgU/TQ=;
	b=Ndeecl3i1pk7UWiwrAMzZrcWav61Ffox7g0VRHMnDqiXzRw9x/RrWvfcflZQ+VtByVTz
	 zNHEGwxgkorO26hoMEzcfcI+pFw3R+lCSPubQWxpImOgwdbPWjGCI+MJc+DS2+qmWZt/s
	 ty9ARWV+g7MMi+JsCskTI/v77tf84MA/CdybBogdoT+YJKEa+oA5za9m1Z/2RzLaecfBW
	 zdRNzhvSRTB6ghLl96oHijYOgTu0y8oMXUDtr6TVlhVu3s/SBcy4b2WhLwHCRW+C2/1kF
	 plr+clfmKhymi+3dIRdRy+LUBfxvDoj6bOtkksFV2Z6qomXjwfzXVuRuUZ75w/rPKPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BVAGy1q3;
	arc=none smtp.remote-ip=209.85.161.50
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C00F606B03A
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 22:49:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C00F606B03A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BVAGy1q3
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6b1afdf5196so1359499eaf.2
        for <git@vger.kernel.org>; Wed, 11 Nov 2026 14:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794437395; x=1795042195; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SO8YdVtJ59WtrVckJs4Y+gfGI1+aG8xdfxxj2hgU/TQ=;
        b=BVAGy1q3lISy1E53pgPYLtimAkEfD5/f7EL0SybZR8Z44KSNJU3L1uGglG6SG1j8bt
         dFwAM/67bBfiUTRpxnye5ayFdCuy73O9PaDV02QYIjw6bO34YvU4f8IjZI0jWxMhvXLk
         spLjjCCzb0cKMojBZ5Gx6zjR63Gbq3IcsV+KTwRBDrNdDJaCCL6MAxj4fQoO9foj+qRH
         U/XyyNsL1IItvE2f5h1IxwRLDqjISd9MNp2etDIpAr582DxtxLXJnadKUxhPvBtZxtI8
         S0h3oqnkyKikF2aJ0wTCFgN3zO7meAnu2HeWZpwdeCWu2sSP4KwmcFnrccDVNF3Vdqub
         /KFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794437395; x=1795042195;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SO8YdVtJ59WtrVckJs4Y+gfGI1+aG8xdfxxj2hgU/TQ=;
        b=pwM7SBRIoKKvho3PQn9LGp0Tbcfo046k/p9mjyzJ+Yh/USxQfIe30ErwYizs3rN/nO
         RhvmhSmKFV/lDHdvAVYx/OrSpNtLEyPavcpvkjCyLdQoKGs/9fLfqiUiw6xIq5zdYz5z
         RerFSgu3alSvde1o0br/YgM9clu1N9kodLPE+OF0Gq2DVf5bU6KiaXAeF19qknCHmFuA
         peR77WQ1GDSPxpPDi++ZfmJ27lWvYHIVflJSs5HNZo1sSKYqWP30IELGhKB/eeV5cD/C
         ltKZ48du00102HuIFQcxpNLuntnD2+zGhRPO32Ljz9XLUgXsY42D/BfV3vo2b0HAoqUf
         wJHQ==
X-Gm-Message-State: APuU4Z/fbpWy/zpSzo6uNx7Y1FcY/3UVHrcJ6mXyppONUt+V2a3sf0/y
	+WLno02LS6aM/lV606Q3FZI2gwEgdD/+9LCBLB66flkZbunSHh/OHStDoAQhhiHV
X-Gm-Gg: AYBFou0dfxs7wC947bxlT2fDxN8nytSU+vZF9pfwN9cRlZfY+NQIxuw9k6WUBpC4vb0
	ZSjwUnOYViB7ug/HTKr6w012MNziY7DJNoB4w8ImW+aP4OTeuQCL9lGnVWTwQxaHrwsF47oT4Fa
	5U/2f09LFU31z4jVk2pIuhU3P9MBYCYHs6IgVd83XXQAJYZDFR9h+zJaAV/IX0dUfUh4+Ydp84D
	6diucMjv+IRgEhsuxMnef89YCl38b7Bz7d9SKY/7dJyc2RL7wKTg+lKql1n4seNeTpsroM2xx2u
	i4YTxAQqsI0h+PJ86i+EUeI5SSiBNrhPsHEUsTWw7iTzdUw4v94BXQDW8JIkFYlVsEfzNRL6/00
	ML8vptANgHdyJrLoXIoSvxC40DUJenBfmAEON61rx5tSdSj8Lt7fw/mO7M+k4fnlNMCUwOQiA3L
	KNR3jLcyLnhpw5RhlNyJCr2lT4tcirU8TBuWprC3TITjV7U9IWlKz5JV2PnB2CJFuQPPoSepOjE
	tQsUXVhwI0+o9k0rbgnssLXKnpKBhQQypLV9gyJbxbzTtp4dWTiNvXoJQgEk1CnY24bwqh67T2B
	RPlhmS+xoxjLUA8ngLahhpB9cJk9/hbkoVYR
X-Received: by 2002:a05:6820:1386:b0:71a:17b:11ce with SMTP id 006d021491bc7-71a017b1252mr403527eaf.78.1794437390202;
        Wed, 11 Nov 2026 14:49:50 -0800 (PST)
Received: from [127.0.0.1] ([130.131.199.169])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-718aa034ad2sm4610888eaf.13.2026.11.11.14.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 14:49:48 -0800 (PST)
Message-Id: <f6f3295ff53a13b4b0093ca00ef9383b0ebf9b21.1794437355.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2297.v3.git.1794437355.gitgitgadget@gmail.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
	<pull.2297.v3.git.1794437355.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 11 Nov 2026 22:49:15 +0000
Subject: [PATCH v3 15/15] config: handle NULL values when listing colors and
 expiry dates
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

Since 2d4ab5a885 (config: format colors quietly, 2026-02-23) and
9cb4a5e1ba (config: format expiry dates quietly, 2026-02-23),
"git config list --type=color" and "--type=expiry-date" pass every
value to color_parse_quietly() or parse_expiry_date(), which do not
handle NULL. So both segfault when any key in the configuration has
no value.

Skip such a key quietly, as both already do with a value that does
not parse, and as "--type=int" does with a key without a value.

Assisted-by: Claude Opus 5.5
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 builtin/config.c  |  4 ++--
 t/t1300-config.sh | 10 ++++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 2554322317..f786c0b123 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -366,7 +366,7 @@ static int format_config_expiry_date(struct strbuf *buf,
 {
 	timestamp_t t;
 	if (quietly) {
-		if (parse_expiry_date(value_, &t))
+		if (!value_ || parse_expiry_date(value_, &t))
 			return -1;
 	} else if (git_config_expiry_date(&t, key_, value_) < 0) {
 		return -1;
@@ -384,7 +384,7 @@ static int format_config_color(struct strbuf *buf,
 	char v[COLOR_MAXLEN];
 
 	if (gently) {
-		if (color_parse_quietly(value_, v) < 0)
+		if (!value_ || color_parse_quietly(value_, v) < 0)
 			return -1;
 	} else if (git_config_color(v, key_, value_) < 0) {
 		return -1;
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 8fb920b1ba..3322b0bf4f 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -2648,6 +2648,16 @@ test_expect_success 'list --type=color shows only canonicalizable color values'
 	test_must_be_empty err
 '
 
+test_expect_success 'list --type=color and --type=expiry-date skip keys without a value' '
+	git -c section.valueless config ${mode_prefix}list --type=color >actual 2>err &&
+	test_grep ! valueless actual &&
+	test_must_be_empty err &&
+
+	git -c section.valueless config ${mode_prefix}list --type=expiry-date >actual 2>err &&
+	test_grep ! valueless actual &&
+	test_must_be_empty err
+'
+
 test_expect_success '--type rejects unknown specifiers' '
 	test_must_fail git config --type=nonsense section.foo 2>error &&
 	test_grep "unrecognized --type argument" error
-- 
gitgitgadget
