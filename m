Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794040996;
	b=NlL6AIjNiUhDU36jeRVcF1kxLu0lP/YkVAdcPYduspYovba9MnQCUbp1Mty76njgFPKd
	 4vpGtUgwXnBDvFHr1rMVr+uWgzpkva/481u9XfJZ2K28iIzopBx3MuKsp1NXPvMP68cop
	 NX9S89fyQBqI5+U8ljKsOm1nQUYyVp/jXgkga9WyZfsVriQeHgrOyttTiiV2kjOtqF9G8
	 Hjlhb5vCHxet8wCj9Mvs97fCbq1Xjuu83kEkjDGx46yiqyFsDRQaRuhyyCgS0sKagUEi7
	 GHiIWe1AkFX8RFclZo2iF5W8E+swjixJ+P/z4W+f8QQLqges4TyJ2KSF9Yh6x2qWXhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794040996;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=SO8YdVtJ59WtrVckJs4Y+gfGI1+aG8xdfxxj2hgU/TQ=;
	b=cpYDFwiU9zcVntMJFl6nWYthN2TkHGJ0UD5y0Sz4TZ78dyYufzS49rfQfwCT73JPP3gC
	 a50cq18lX5W8tIj6J3898e5xR7yqAIkJuIvKuKuuaRkAjwTvUL1aS/jvDyV213uEarFqF
	 7qAz98UREmBm4v5lS9HpkYw3ECvQmSaIXMD7cHPnlfwu61nRQ4oRXNb5ZF+RDKrKaiUAe
	 cZaiZT8rpQBrWL9SUtIKXLK926IMgPsTFlNO53BLrg63rYASWh0t1PZ60o7emSNnq4BCf
	 mM23wKbTJkn52IXi04umAFST2i9gwLpKnkfbFt2dW/FwM/rDSwGwabMAkWQ7HGJqPNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U9mLp5rY;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E41606A32F
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 08:43:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77E41606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U9mLp5rY
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3acdcfa2bd3so1183377a91.3
        for <git@vger.kernel.org>; Sat, 07 Nov 2026 00:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794040996; x=1794645796; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SO8YdVtJ59WtrVckJs4Y+gfGI1+aG8xdfxxj2hgU/TQ=;
        b=U9mLp5rYBvVWdUxDxWIalgXfw6zSVduwK6atC+h6AoB6brYQnb5ca7pI+DSNBRT9zm
         LqhQEM+KemSLwQ3FtaIrMIymkzKCv04uQ05sik7k7HHssaJMjeKYhJ7Hhv4L/qNpdl+O
         IE/DodqheMJ+9E8zocbpxDaAvrNST/8PYqgEMlAPLwhNZYNlOE5mc91VouWZS+wkKFc6
         p8gmYYfwUo+xp9taWNvw7ii9KtnAjHhy8plnk4uPSEY0fAF7rtw+wqw3DdBmD4YyxUoN
         tKB3OlEcgCYSKnosSLJcOZiHwgkGYsgSgPFRMn4FURQLonlbXtPCk5yVhn04+AKCUhBu
         LQ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794040996; x=1794645796;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SO8YdVtJ59WtrVckJs4Y+gfGI1+aG8xdfxxj2hgU/TQ=;
        b=IlzoPfBZZ17++yBx+2JffXJoqylewvncFWErQZmKbRpFXuTw3TqXCxhm2fARlFnLnY
         ziPSJP+FptcINeDWHaetGGKV4r0Mv8H9V79AHTOpOXDy/GwX2LGsCCiZsj2TnPil/Itf
         OvDgxIv0N1eK3ungoXqGahN6G1kd1IKNNP5Suc/P+hVEdMoU7j6d0iKyokJt4w9l/9i5
         e69olzGQ8DATyB9idExJWU2jha+9nU3KnrE5eFZHW/ekdLKtFDw4qmPb2MCDw4U2TgmB
         s/LjwH8EFmgsH/h02dCxL/P3LuRsRDT61dVD0l+XQsmU1WyPpfBTt+cXEfPXM24SOXof
         8iYA==
X-Gm-Message-State: APuU4Z8Gc+Ij7ot0ifzSK7H2pQA9mZrqygCc+TTVYYt+0bZAXSJb3fQx
	afs6do8WGFnsEI8K6bBaiUlodQgbpfyFv39iRtKIEueoebarAtIvSgdRC0F4Ln1M
X-Gm-Gg: AYBFou214CAQ6Bs5gawO/Aol4Jzav8+ooUKucnc/BUmvos2AREpALS7aOIYvvH2UThj
	rqbdsHn3VR1Be3fZmE1oRiK4bLHs5PC4W+oY0R+wqEvbhDxGjRjdeRYwFlxL+zQQy9vYE9Mj4ht
	Thi4YryUy+zfybOlA5FzoMydRhTDUHRByNGYFA2sFySYhfAPkLtasMcRxSVQQXzS6zWIYzhl6Os
	odgVDuAtfP9rWYVYSNfl8rErA1csaS4Tc+0o0rlqEQB3Td2vFuesXv5I3dP9ouJioj8gaY/wWPP
	rbncDtormVaZPc71BNl7WqvvctWff+CLa9NmeSNQUNAbi7wL3X3OWj6e7lKsVHR01QLCzONOsvD
	ZvecISStM7oxvVi9pN21LPSUWi1C/U/PcJOkeFLkso6qqLNUxGnqePE8wN9aLsn2pFx+s8Cxp5A
	5PI2i9JDcfR2wbcWoGOd4FF5NkKI1y7jWeMlFCspLGKhgCEc0DQ00Jg1t6Ryat9a3TMsOaZZKRp
	xKxlIabSzZyg5b9TMacO3bSrKlj+YC0k8B3b6x9oAmS15881ne9XV3REAbHYccIG6aO6f8qI6W7
	2/yDFnNCTAHoNBhoFJRTHNrXKZLsrvOgOQ==
X-Received: by 2002:a17:90b:2650:b0:3ab:36c4:b500 with SMTP id 98e67ed59e1d1-3b0db6058fbmr5238291a91.5.1794040995870;
        Sat, 07 Nov 2026 00:43:15 -0800 (PST)
Received: from [127.0.0.1] ([52.156.141.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b10585df83sm2647698a91.16.2026.11.07.00.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 00:43:15 -0800 (PST)
Message-Id: <7ac4e3a3d9caded1a857dc415f05931330a5d366.1794040968.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 07 Nov 2026 08:42:47 +0000
Subject: [PATCH 15/15] config: handle NULL values when listing colors and
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
