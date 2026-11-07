Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794040979;
	b=pRxD1QVGba0ESdrk6k2d5H0W2vqZCeix4B06wQ/CtZgv0JmterdgRzOS+WmvgfDoWAoI
	 P75DqMiVOzoY0wpm9PL5urIcU13aa/NcWGKuKh+NpzUrl0kDJKpV5/CNS+9+WtVObOXyw
	 OZTCKtddFgngTA3RV1aW5ND/XIcQX8Ox+NGhx4W25ynt4IyunZZPUy6RxYeUVkDV+CzMi
	 Prxfiul381BzjoNnnQMmRhh9ix0D98vk7im6OY7SlpBiRqnJHu8cntyuADvqSbHejqKyW
	 lxMtbaUrxuIRjqGRRsdHjh/FlDEvgE9NLT6fy56fDwBwRmmwCkK6s956LVxuOsjaeFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794040979;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=FI675Eq3kAqyufGgyL+ae1aSnWyYNoA134Y0rEAj5Ds=;
	b=v1OcIQjeLXmSpvvKC8UxgOgCioC0FbWh0wLMMK0DUl7/eW7G919P/41fIEk8WIyODyhK
	 YwSlDncmp3UV23N7sPCQByvCzhRje4aLqer7HYNQooYYqBd8Yefpj9v5NmkqjxEBivzV9
	 FfHmFDTcnb0vJOest9WDKSqAOgoSUou2I0t6RbeJ9jnltvS0C61FGdbqnT1LBNSfS3vKl
	 ER3x5T7ztLXUE/5yRSW0jXXtSGtPuYLWjGaHCnVCJgmYxZX07rTH+zZpkKipdJJDtg1Ah
	 zYtG6IhbokG7uNU/yCuw1ZvoasL53G/vP0T/Z5gpPDaFmErG57coIf1t+BB/CuidJ4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KhV8bn6P;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049B4606A337
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 08:42:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 049B4606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KhV8bn6P
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e942864693so8211225ad.1
        for <git@vger.kernel.org>; Sat, 07 Nov 2026 00:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794040978; x=1794645778; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FI675Eq3kAqyufGgyL+ae1aSnWyYNoA134Y0rEAj5Ds=;
        b=KhV8bn6P9ywHciOhtzCtvDBwrWHtomfvCXqu/5u8EwxJFDQ7ljpFRVFi7b0Lhabffv
         01EDBN9loGHMwaOhaj7Fr39EmAizq27R2Kb3z4QVukHdxRiH9Y52LXXvUsf+nOBf9EFB
         Yvgn/Wdzmjxaq0eNYm5TZYwqt3apx8gbd6tMrcl238O4S0ApWt9xpjCOO4gbf7+1rmwu
         rCt/GsU216sfIUouDiDE1pqHNATQ/jFLP8hjVgNuyrjqiOL4fjY/g0R6ydjFCJZNvBAT
         V34EARQgdbECXu01Ru9dnWdvAXjiEGY/m5+g/KYNTMhn+P8PrfCFLRAGHldm9fb+Yic5
         bA1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794040978; x=1794645778;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FI675Eq3kAqyufGgyL+ae1aSnWyYNoA134Y0rEAj5Ds=;
        b=kKnbtV0tzrbhRcmN3+WhbVVs60kvBkBOFMK6u/ebHA4w0/qdSnQQkbjXrdmi09or6w
         LQ5j7vajjQC32hA5bS6KM/je2XT5r5zNjmO/Y7Uz0dPEvzJL+JXf6wAnvAmpvtmNUoCR
         vPRmdyqE4N3cvJ9L/QBqo6EZtNoB6x/ORSGciHR/4BWAtgSRCUOjUOAppmaT/flsAt4g
         09oOY+HHRNIFbABPINM1rflF6mBc76KAa9ksY1KXAojIdgy531VUZx+DH0wzRrs68aN2
         Z49agjhkRa/FFU5OzYsTWck9x1pnBWUNphhSiqBsgOrbYG0DCveSQlJZQ9gTCJBE5u1f
         dz6A==
X-Gm-Message-State: APuU4Z9cLGUVWJf7PJJYCKcahCFX5uBw9bxMcZVJnmVzQ48u1haZK4Er
	fy3ghy/h7+i+kL8eLjuG4EPA6/GuQR/s5ihppXaWX8JiVfEGr9091rZgskXQqA==
X-Gm-Gg: AYBFou2CnjWJ24ComnBMzppNcdXoGCFyfYGhXoruO2H4cq3NwSZyi26u9CRUN1ay/9O
	RESlYFGUbB6piUFLypUImuOJbMIK+3Hz/kznXSX/f2Htdy9sjiO+Dnu1FA9Bj+ijjVyLQ8r6fpM
	JpQJ58uHNVCKhnekGu+n1dor1HjjV4EfgV1DSbqXwU3czNPW18bKcuIXsfSJakUAjZF/KdikukI
	skv4XSsPHW0evCDu9D+iTXIToIQBK3W6fHIjS4PXfPT0kcY9byxiAJEJBKAzhEFcEf9AYt39eXP
	F6d+y0Ct0KnkRLdkA8LOfc4ql523kzWwxGlW3ip+z+fC89SYyoQ4kdt1GAJKFOF5DIt7klUbfox
	Dz64Rl3G60ZI+CQ7X+QZ+S52O1u1MZTbGi+ZbLZAU6xgDZDK5VZ5kBH5VmA+dX2FLWMvaDXJcaA
	sIoHETzQkS4lTz7LGxcDTGDgaCg5z6+bHpCivd5l59VzDkXb13uTes9YtWXI/YT7wnhgP9Xjs87
	IPnueJai1SPlwL/PjLAaHo5ajqIDEVtbz4lYdxlUe6otzc9+7ZKHzd7or1gy+Ei3lZdsbzPWliq
	Crvtj7CP3mfaZn4OGTpON3ercbsrMNhxhw==
X-Received: by 2002:a17:90b:46:b0:3b0:78c8:d56e with SMTP id 98e67ed59e1d1-3b0db6ca00amr4974962a91.27.1794040978384;
        Sat, 07 Nov 2026 00:42:58 -0800 (PST)
Received: from [127.0.0.1] ([52.156.141.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b105864390sm2548569a91.6.2026.11.07.00.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 00:42:57 -0800 (PST)
Message-Id: <88df66ab7ec29d1d25557652f40fbaa7c9874ede.1794040968.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 07 Nov 2026 08:42:37 +0000
Subject: [PATCH 05/15] grep: handle NULL value for grep.patternType
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

A grep.patternType without a value makes "git grep", "git log" and
"git show" segfault: grep_config(), which all three use, passes the
NULL value to parse_pattern_type_arg(), which hands it to strcmp().

Reject a missing value with config_error_nonbool(), as grep_config()
already does for the color.grep.* slots.

Assisted-by: Claude Fable 5.1
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 grep.c          | 2 ++
 t/t7810-grep.sh | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/grep.c b/grep.c
index 1d75d31421..ab082f963e 100644
--- a/grep.c
+++ b/grep.c
@@ -71,6 +71,8 @@ int grep_config(const char *var, const char *value,
 	}
 
 	if (!strcmp(var, "grep.patterntype")) {
+		if (!value)
+			return config_error_nonbool(var);
 		opt->pattern_type_option = parse_pattern_type_arg(var, value);
 		return 0;
 	}
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index ac7ea9cf8d..d323927e54 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -1551,6 +1551,11 @@ test_expect_success PCRE 'grep invalidpattern properly dies with grep.patternTyp
 	test_must_fail git -c grep.patterntype=perl grep "a["
 '
 
+test_expect_success 'grep.patternType without a value is rejected' '
+	test_must_fail git -c grep.patternType grep "a" 2>err &&
+	test_grep "missing value for .grep.patterntype." err
+'
+
 test_expect_success 'grep -G -E -F pattern' '
 	echo "ab:a+b*c" >expected &&
 	git grep -G -E -F "a+b*c" ab >actual &&
-- 
gitgitgadget

