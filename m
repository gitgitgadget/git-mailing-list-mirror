Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542F52D061D
	for <git@vger.kernel.org>; Tue,  5 May 2026 23:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778022151; cv=none; b=qKaKSdZTQyLqnRneIjYLiq+MOLAa+3aloy6svGeTrHm1jOhhP1boAVrXrcYthASx6QvWsj3Oa1E9ogyIJEQHbqLn5Y00FvbuQZjB/lbBOSFWK2YmUUASw5zRswpcTwLJ0ndoukRrrTPjbjPE5M2S6x3vhSFfrz6rjJ/O6vvYDfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778022151; c=relaxed/simple;
	bh=eT1yXqiLmllvVoRZQeuhlpxdpsVIDhrCm3QR8L4tOU0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=AAy7dAPLoWx2mk1bmnuc+uIxIxEAhPiLoAZNZKDOj0/xRoIFNaAmlMojrfw2f7wvN3BiKQ8Z3XrMoGa44t70Md30FDg0OTY17F6DcAdoRouxVr3VMElF/+SV0738HXSVc4HMn4jGJ8scUBN/n9fSxO1sINJpP4QBXXfvLvrIo+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fHQmhCT/; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHQmhCT/"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2ba895adfeaso6355559eec.0
        for <git@vger.kernel.org>; Tue, 05 May 2026 16:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778022149; x=1778626949; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMtQEZePQbh7W1BTrbBt9E1zsmj985sDf4jeUG2t3tQ=;
        b=fHQmhCT/Bsp+mEsBv0LFSceNCYDp5mUISf8+oNwZEL1pSa8PlxcU2WUbRkzhdj5eQr
         VXkjYH2svEaGZSVLCEEkjCJnv7eI7uVX6QmQk77wEAkRUuMpxxx7A7ebOif379/6SgG5
         7e9VnObUHaam2SldxtJQ0tpJ5wmZy8oN469U3TY244j7EMVVTlOnz/9Vk5q2IqD4s62w
         jzB/ABrM1BWSiAswzkZX+tsz9LppigLdvKkA2RtQLkmyIUE61u5d4rDNoGWloyCRACZJ
         fctkI0dbWIB2m3Bir2qA88Suw5/gjpTsXWln8t1zMF3fXuw6oZilbo4AyKmgmBRG+Epv
         JF/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778022149; x=1778626949;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vMtQEZePQbh7W1BTrbBt9E1zsmj985sDf4jeUG2t3tQ=;
        b=OIyEeiLS6ZCX+FScd6G8lDgZS1hAe7wFgnD/4RLPZTshj72heStrm+XzllYXq/y9o8
         nW+d1YCOnGb3mVF91caBuDOjaZFpQATmIXGkRkqZ6OtVNYXAaieq3m5jsJkRSwEqZNnO
         3X+UwEviEXYdFfuM79X520FlzOsBbwQ7H/25OaEKQlk0TVZ0uhLSHR/fj7hONZ9wCzU5
         I1yR5Tzc+gxJvtPGImTAshjPtsFarkmr9sDkBpwppA8SdP4zPJtJXZgsOx3ibWm6bYPt
         HQOHztAIiPrx0Tz2GGTB/4TwWS1MmC1KRLU9QLUnEtJYpeCNEav7XnLeXMc5OCxMR4h3
         9FKA==
X-Gm-Message-State: AOJu0YxaS1CGPFUf+bHwW4dRYklWg92KaoZ3A94rmaUCEMES5w1wHbnB
	xaTdOyTShpemgrgI6QbQcqiu5cc/5a6jBnB08N+bYdtTVwok6wbIdCGKFYjjChCl
X-Gm-Gg: AeBDieupJ3uIhxn2lX03FvCBXPu8EZiWXHUQPpdHiJJOnOripPuR1mhTsn46tC6eVuU
	OKrhFDtJkvTyaQqUUf24W7h/jUkC8Mvh1p9Ne1uvBejahGoVgiJ8IYsHrla6u9gM4BjvTI7ScpV
	4EDoJdzrkvsVJXHS9+ODzqCyv+rwzcRdMKW4pCe9dF1E0X1gg832PdyamF+hPTv6OsLU3uWbGc9
	zQQqmAYkxxf0J2jMfwq2f2bu1GgcerqfMgPm1LMNfeg2khQRs9oqRSTHfuViU6qH3CF6ViNckjp
	OPNz3fTnRYf3OVoiUoVNjeOngC/lk0lhZv/sgqXFrOyRg/zLC2Qxti+rYQxEv5OqcSE5XAcTLiC
	Oz3y/MBROsnk/Ly7Ipg9aYgeFgx2lIBitf2cKP4q6NyE/h8fAxlwglG9fEiD443GoixZFWXUfZh
	sqO/CSb2dfjbcUw4q4aEJttlMU2BZMm2KwkdyYbQfJBh8cBYUKdGwmiQ==
X-Received: by 2002:a05:7300:2387:b0:2c1:558c:16e1 with SMTP id 5a478bee46e88-2f54b897efemr610018eec.4.1778022148841;
        Tue, 05 May 2026 16:02:28 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.4.2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f56f88f566sm796577eec.16.2026.05.05.16.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 16:02:28 -0700 (PDT)
Message-Id: <f0478d434ce43e51fd92792c3e583df8a515bf05.1778022144.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2105.git.1778022144.gitgitgadget@gmail.com>
References: <pull.2105.git.1778022144.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 05 May 2026 23:02:22 +0000
Subject: [PATCH 2/4] diff: reject negative values for -U/--unified
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

Passing a negative value to -U is silently accepted and produces
corrupt unified diff output with malformed hunk headers:

    $ git log -1 -p -U-500 -- GIT-VERSION-GEN | grep '^@@'
    @@ -503,999- +503,999- @@

Line 503 of a 106-line file, count "999-" is not a valid integer.

The config variable diff.context already rejects negative values, but
the command line callback diff_opt_unified() uses strtol() with no
range check.

Change the type of diff_options.context and its static default from
int to unsigned int, matching the change to interhunkcontext in the
previous commit. The type change requires reworking the callback and
config parsing to validate in a local variable before assigning to
the now-unsigned field.

Unlike --inter-hunk-context which could be converted to OPT_UNSIGNED,
-U needs OPT_CALLBACK_F for PARSE_OPT_OPTARG (bare -U with no value
enables patch output). Add a range check in the callback instead.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 diff.c                  | 12 ++++++++----
 diff.h                  |  2 +-
 t/t4055-diff-context.sh |  5 +++++
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index 5df28e49c5..1771b2c444 100644
--- a/diff.c
+++ b/diff.c
@@ -60,7 +60,7 @@ static int diff_suppress_blank_empty;
 static enum git_colorbool diff_use_color_default = GIT_COLOR_UNKNOWN;
 static int diff_color_moved_default;
 static int diff_color_moved_ws_default;
-static int diff_context_default = 3;
+static unsigned int diff_context_default = 3;
 static unsigned int diff_interhunk_context_default;
 static char *diff_word_regex_cfg;
 static struct external_diff external_diff_cfg;
@@ -382,9 +382,10 @@ int git_diff_ui_config(const char *var, const char *value,
 		return 0;
 	}
 	if (!strcmp(var, "diff.context")) {
-		diff_context_default = git_config_int(var, value, ctx->kvi);
-		if (diff_context_default < 0)
+		int val = git_config_int(var, value, ctx->kvi);
+		if (val < 0)
 			return -1;
+		diff_context_default = val;
 		return 0;
 	}
 	if (!strcmp(var, "diff.interhunkcontext")) {
@@ -5924,9 +5925,12 @@ static int diff_opt_unified(const struct option *opt,
 	BUG_ON_OPT_NEG(unset);
 
 	if (arg) {
-		options->context = strtol(arg, &s, 10);
+		long val = strtol(arg, &s, 10);
 		if (*s)
 			return error(_("%s expects a numerical value"), "--unified");
+		if (val < 0)
+			return error(_("%s expects a non-negative integer"), "--unified");
+		options->context = val;
 	}
 	enable_patch_output(&options->output_format);
 
diff --git a/diff.h b/diff.h
index 033d633db4..bb5cddaf34 100644
--- a/diff.h
+++ b/diff.h
@@ -294,7 +294,7 @@ struct diff_options {
 	enum git_colorbool use_color;
 
 	/* Number of context lines to generate in patch output. */
-	int context;
+	unsigned int context;
 
 	unsigned int interhunkcontext;
 
diff --git a/t/t4055-diff-context.sh b/t/t4055-diff-context.sh
index 1384a81957..b26f6eea7c 100755
--- a/t/t4055-diff-context.sh
+++ b/t/t4055-diff-context.sh
@@ -82,6 +82,11 @@ test_expect_success 'negative integer config parsing' '
 	test_grep "bad config variable" output
 '
 
+test_expect_success '-U-1 is rejected' '
+	test_must_fail git diff -U-1 2>err &&
+	test_grep "expects a non-negative integer" err
+'
+
 test_expect_success '-U0 is valid, so is diff.context=0' '
 	test_config diff.context 0 &&
 	git diff >output &&
-- 
gitgitgadget

