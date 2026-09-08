Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87FE50EC1A
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 10:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788863292; cv=none; b=shTBOhOtKRSzRWmk7G1nq8hB9rnCuPpSxa/5rBYXqilV/2PgDym4Ql1DTTukjKLHPAdAHj0DpkU9GC7Qd9SbQ9/B14/KbpJHjbQ/ImoDM1XXNGqy6dJOIstYbGpViMNxTDNYNfGSL9gPGcQ1dItS1ONF2Is8Da0b9LIxc2Xj+iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788863292; c=relaxed/simple;
	bh=wqWe/Ydb5jAiP39Kh8y5XCy9G45HBLIGTuEd8woLC2g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CJqGxkwSWDP8lwH7/BV+3Kzq71GctlNCwLJwpz3ghwgjuaPmpWCMnk75Y9FDtv4h694YoYglcVdYZ9bxEjlTF+T90NOiSzJuvt7fP8i4ZMQF6kifiOJixwbHqzxnG7gsLX2xUqMWz70+QP2svC02hmc8iZmka8iDtcEBs9L55r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGb9E3pZ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGb9E3pZ"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cc891373e0so46118185ad.2
        for <git@vger.kernel.org>; Tue, 08 Sep 2026 03:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788863290; x=1789468090; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ToxcUCy6mWKCiBxXSzNyVM7yGP88t3y/yCtWcl6z688=;
        b=JGb9E3pZZPqaAU3PmCv2c3wgIp6F0weNc77HNDsmlzlUGTxCkfLGuik70TtrnRp7Cf
         0a9QW1Zp4jUyX9DwP5Jb1+o2y7Ti6GMRsFcMBoOFcyjVUt4Zq3VBEDssuWCzEV61TK2m
         pIOukTmDzhm8fiqdsmLA6gMy+RpPD6V50Pdm1sSh2MzuG24k7jobLyF042kxzAiQOdaD
         6lyF0YXaAm5s6eSRFltNsFiRihsXWl87F/p52aO2CIMNIF2Ajt+jQaUU/DLfC3mBxSD3
         MvkH5M60r73GJ+lp0Edp30jPgc1SlwswrG98OQxc0XUNwHYDvOL2oGy+UWLQhhhGfjiy
         3ISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788863290; x=1789468090;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ToxcUCy6mWKCiBxXSzNyVM7yGP88t3y/yCtWcl6z688=;
        b=gjJCG5BJQEod+HvekwroxyItZqZnY4YJecoQ66YgSU1bbaER3TMnP2n2Qze/SGeORM
         8TYjknh0xtBegciq6h4nJnZjrw6cXbuySqmxJa2nXQcTF4Yv9npNLfEcx5EDtxAUBLLw
         MalaLaPmB92iNx7TOdVifJOOAn9Q8hzFpqMO77FNa/3Wph/RrwbO5NDhA9c3uitwpY8J
         IDtUVt1vusmEGwBly1yROrT7rv+xBbQsKA4m3xE80Na0AG7l5Fzzg92zJtfcmCd4c668
         20pIWBnKQ9Da38jT8PSLwNY+NBFXOc+KyRk6jspXfkgj+pmPzFZ/MCzq+IL184+Fmb2Y
         K+aw==
X-Gm-Message-State: AFuF++kEkBn+eKVA3808eljDskuzGFPspJxWs7bDlRxaS5Hzh6HiOmV1
	ejmqe5qe+rU4hzysnQ9EIhYsTmA2f3xlG4+WbH0KrZXhFAFEFokl2o7prFiu0w==
X-Gm-Gg: AYBFou2Wge6cvNAQi8BHtRydS/9dcam08l+b3VSnNzQtHVdubKxFox7yehjjShfme81
	Dsfz3J07EHLZ89s0RTBKkrHvPA53oxLjl76ufS2GX4p8p2k9KiDT7utxvl4hgwctUxVzeDs7QA0
	Z+hErRwLA1R24kdVIlieX1QZoNEx6mNQGF8wzF8u+RjA29sIwTjS4YBaV4k7rbUF8hUC2bh3j3o
	swxwA6xBoyoS1JnPlQdffpW1eXzC7Uh/bzHZ+kPGwddJGGxPCQRtgpnXI5wX+Zhwcql6ie1YdR3
	C5J4bCQKajsCoJfmX2EIcnmo2nTYEb/OEFD6QMwmHLVJgiTfLsYWWJT7uT/57WNgmIpoNgxmmUX
	0ZmcnS+Jr8lwMYsMnsAmuEov99RxNbTa1dzuTtPx+EnyCYWRLIUXCh836LOzLZiJzvAC/IS6VFZ
	EzFvNF7PUbBUd4/5CeUxm2ufY7rfqpjvrdIt8ebD6L47uUvz7G6yxVaytLEGBN0g==
X-Received: by 2002:a17:903:ac6:b0:2da:e634:370e with SMTP id d9443c01a7336-2db125ca3e8mr405054435ad.14.1788863290046;
        Tue, 08 Sep 2026 03:28:10 -0700 (PDT)
Received: from [127.0.0.1] ([68.220.60.10])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339ac24d7esm55677967eec.15.2026.09.08.03.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 03:28:09 -0700 (PDT)
Message-Id: <70db5ad0841bb3db7538d709e0f1583aa70ae8bd.1788863286.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2217.v3.git.1788863286.gitgitgadget@gmail.com>
References: <pull.2217.git.1788508426.gitgitgadget@gmail.com>
	<pull.2217.v3.git.1788863286.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 08 Sep 2026 10:28:04 +0000
Subject: [PATCH v3 1/3] config: add git_config_append_parameter()
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
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
    Patrick Steinhardt <ps@pks.im>,
    Junio C Hamano <gitster@pobox.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Thomas Bachem <mail@thomasbachem.com>,
    Thomas Bachem <mail@thomasbachem.com>

From: Thomas Bachem <mail@thomasbachem.com>

"git -c key=value" passes its settings on to the git commands it
spawns through the environment variable GIT_CONFIG_PARAMETERS. The
value is a space separated list of 'key'='value' pairs with both
sides single quoted, which git_config_from_parameters() reads back in
the child. The only place we write such an entry is
git_config_push_split_parameter(), and it writes straight into our
own environment.

Split the formatting out into git_config_append_parameter(), which
appends one entry to a strbuf, so that we can build such a value for
a child's environment without repeating the quoting. The sequencer
will use it in a later commit to pass settings to the commands it
spawns.

Assisted-by: Claude Fable 5.1
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 config.c | 20 +++++++++++++-------
 config.h | 13 +++++++++++++
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/config.c b/config.c
index d9019e7e6c..e0bb29b53d 100644
--- a/config.c
+++ b/config.c
@@ -450,18 +450,24 @@ static int git_config_include(const char *var, const char *value,
 	return ret;
 }
 
+void git_config_append_parameter(struct strbuf *env, const char *key,
+				 const char *value)
+{
+	if (env->len)
+		strbuf_addch(env, ' ');
+	sq_quote_buf(env, key);
+	strbuf_addch(env, '=');
+	if (value)
+		sq_quote_buf(env, value);
+}
+
 static void git_config_push_split_parameter(const char *key, const char *value)
 {
 	struct strbuf env = STRBUF_INIT;
 	const char *old = getenv(CONFIG_DATA_ENVIRONMENT);
-	if (old && *old) {
+	if (old && *old)
 		strbuf_addstr(&env, old);
-		strbuf_addch(&env, ' ');
-	}
-	sq_quote_buf(&env, key);
-	strbuf_addch(&env, '=');
-	if (value)
-		sq_quote_buf(&env, value);
+	git_config_append_parameter(&env, key, value);
 	setenv(CONFIG_DATA_ENVIRONMENT, env.buf, 1);
 	strbuf_release(&env);
 }
diff --git a/config.h b/config.h
index b66dd08007..838d1509a9 100644
--- a/config.h
+++ b/config.h
@@ -22,6 +22,7 @@
  */
 
 struct object_id;
+struct strbuf;
 
 /* git_config_parse_key() returns these negated: */
 #define CONFIG_INVALID_KEY 1
@@ -186,6 +187,18 @@ int git_config_from_blob_oid(config_fn_t fn, const char *name,
 			     enum config_scope scope);
 void git_config_push_parameter(const char *text);
 void git_config_push_env(const char *spec);
+
+/*
+ * Append a "-c key=value" setting to a GIT_CONFIG_PARAMETERS value in
+ * `env`. The variable carries such settings from a git process to the
+ * git commands it spawns, as a space separated list of 'key'='value'
+ * pairs with both sides single quoted, which git_config_from_parameters()
+ * reads back. A NULL `value` appends 'key'= with nothing after the equals
+ * sign, which stands for a boolean true, like "-c key" on the command
+ * line.
+ */
+void git_config_append_parameter(struct strbuf *env, const char *key,
+				 const char *value);
 int git_config_from_parameters(config_fn_t fn, void *data);
 
 /*
-- 
gitgitgadget

