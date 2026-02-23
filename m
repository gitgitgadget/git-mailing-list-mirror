Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E60A365A13
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 12:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771849627; cv=none; b=a9ltPUrQh0QUb5rF3bL2i+zspq0HIFFyg0qL0vPeKF21t+f9+Yunr5N/ONNC6GJyPUvj9NeBMXDAErv06NQLBxyf4pZVQnSMHdapUZckaoL1ibCe75Jl87pIin/mqJShHrLJTrhZHvW5QQ28649Je3mcY4nA8pkTC7eggH9NVU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771849627; c=relaxed/simple;
	bh=ZZPurD6GM4Tnh8YQBDwf1BDtgQpPvn5nZWLNCMmTzgQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=oqTSayykuSQoT2MYRwHBj692TWBHEn2IL+AFg3sLkzt4D7xnP6HvJIBtGsZtwZiLRX95I3iasN3CSKR78lccu2gP8ATr0Y/Loi1KtT8msnbnQU3UfZRbIb8xeZr/I04Uo6/Yq+V9BrrKXDtMrE5djimeVvD21O7JFRvoeXLAa4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X52YmGTX; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X52YmGTX"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-79430ef54c3so35831507b3.2
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 04:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771849625; x=1772454425; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tDBNuSsFN+lDECiO5EhWcLa1F+KR58bbfaN4iZTvIh0=;
        b=X52YmGTXY0Jxh7xMt9t2NcJID+/SJS3KslGlK/m59CXp+/uUEDPznVjeK7T9qLZunQ
         3t/NfXu9gXMvj8PG2e6ujlZysDU/tAzD6yTtYjEVx5OXUNZ7SDV9iQXjNkEUGTGWe8sX
         tfNtd7MNJAekqebWM5Iy62SfXhwLTH4REvYPjotbJSODJKx0C0Xv4cnR2yG2qKnxjmdi
         4TN3+vQvFJ6RuII2wIEiM2ZodTQq4cCyIKrY2mOofmn6r52nFgVy6KksbOrd2hymU3sB
         JrM/L1ghmBywah43aDZLs/E6TBadeSBqjH5F0Na2TGstW58eNMWgRS4I5MODZznyqmDa
         LXUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771849625; x=1772454425;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tDBNuSsFN+lDECiO5EhWcLa1F+KR58bbfaN4iZTvIh0=;
        b=D4gU0HMVo9fEVAw6n5Np9q0Zoe0kkQHnLELE5K5VSGz8UCJf7jN80pxOn3R5rfW/Vs
         X1LcwrI6t6beom9PNSZi2Nij/BPNM7nSQ610ksdZGsmBs5Hcd+oOtPDYHEPGewU8QyO1
         kAqnkMeJ7MxypqUAfx5lPKR3RI4PVP1NkKcgz13WCaOa2E8qs6DjKiq4x2GB1tCRl7XH
         ztZpHhGqR7mtWjDB/ES+0gT6zJDfzMyXaFHQjVbq4XyMc4AMQatXtTqEkdf+BAMAc5vT
         Y3AJXWgkHkbEhEVc3e2tK0AWPcOk9lHaJC8I/byoGjRoRkuEVBDLZsKScK+uhgiNQ240
         8sgg==
X-Gm-Message-State: AOJu0Yy48e2LWxMge3dcA9j65jSGfW9KX9L2NAKcvJDr4rmO+arf5IIy
	I8cRJWornDadsrlOF7orMzxVpVhEAf0qRNngeTLuSiY7MN6eG27X0X7vRyivLQ==
X-Gm-Gg: ATEYQzyiTwoSbd5pWc9ODPDs/xMN1mgHSMYF0tMdoTUiNymOOSk3ZZQrMwKR26T9L04
	N5FKL36t1JO2g05q6OMvDRHoptmwy2vhIP8KM56DZoffHGoEkgAnqTHSnQDfbFmbMGUna0l/UuS
	getr2sr7ckB+r7x6GAuZ3cRVt/faw8AIXEhNu0mOawHd4iduQg/7eOVoJSucCa8bCMTAdNA+QGJ
	qb+ISyOW1It16Mw37JY1K/3x/PABZWNdhbirYilwdy83awJhobMrCqgvtvIQhv8ao7sJkaIoI/T
	0W6/W1mzMlObCBhgH6L4bWHWV5aCDfVNiG8KF2CYnaxtO/kBAhweL7L0R/CD4rf24PlAhWwsdMx
	cgxs3JGM6DljhJiyqGX8hddVMEXyrZr9YStXQDuPDBboiVPsSN2hpjSQFPt7/CEhHOkcAxKwOxt
	jmn7UaQ67ILF4+pwGNrAMCYWx1xw==
X-Received: by 2002:a05:690c:6502:b0:798:3f7:83bb with SMTP id 00721157ae682-798291730cdmr73114617b3.61.1771849624794;
        Mon, 23 Feb 2026 04:27:04 -0800 (PST)
Received: from [127.0.0.1] ([20.171.125.131])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7982db8f922sm31177347b3.3.2026.02.23.04.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 04:27:04 -0800 (PST)
Message-Id: <02849ca62124f6d76359bdf22473e00b79822eac.1771849615.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2044.v3.git.1771849615.gitgitgadget@gmail.com>
References: <pull.2044.v2.git.1771026918.gitgitgadget@gmail.com>
	<pull.2044.v3.git.1771849615.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Feb 2026 12:26:48 +0000
Subject: [PATCH v3 06/13] config: format bools or ints gently
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
Cc: gitster@pobox.com,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    Patrick Steinhardt <ps@pks.im>,
    Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Move the logic for formatting bool-or-int config values into a helper
method and use gentle parsing when needed.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/config.c  | 40 +++++++++++++++++++++++++++++++---------
 t/t1300-config.sh |  4 +++-
 2 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index d8b38c51d3..491a880e56 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -274,6 +274,34 @@ static int format_config_bool(struct strbuf *buf,
 	return 0;
 }
 
+static int format_config_bool_or_int(struct strbuf *buf,
+				     const char *key_,
+				     const char *value_,
+				     const struct key_value_info *kvi,
+				     int gently)
+{
+	int v, is_bool = 0;
+
+	if (gently) {
+		v = git_parse_maybe_bool_text(value_);
+
+		if (v >= 0)
+			is_bool = 1;
+		else if (!git_parse_int(value_, &v))
+			return -1;
+	} else {
+		v = git_config_bool_or_int(key_, value_, kvi,
+					   &is_bool);
+	}
+
+	if (is_bool)
+		strbuf_addstr(buf, v ? "true" : "false");
+	else
+		strbuf_addf(buf, "%d", v);
+
+	return 0;
+}
+
 /*
  * Format the configuration key-value pair (`key_`, `value_`) and
  * append it into strbuf `buf`.  Returns a negative value on failure,
@@ -303,15 +331,9 @@ static int format_config(const struct config_display_options *opts,
 			res = format_config_int64(buf, key_, value_, kvi, gently);
 		else if (opts->type == TYPE_BOOL)
 			res = format_config_bool(buf, key_, value_, gently);
-		else if (opts->type == TYPE_BOOL_OR_INT) {
-			int is_bool, v;
-			v = git_config_bool_or_int(key_, value_, kvi,
-						   &is_bool);
-			if (is_bool)
-				strbuf_addstr(buf, v ? "true" : "false");
-			else
-				strbuf_addf(buf, "%d", v);
-		} else if (opts->type == TYPE_BOOL_OR_STR) {
+		else if (opts->type == TYPE_BOOL_OR_INT)
+			res = format_config_bool_or_int(buf, key_, value_, kvi, gently);
+		else if (opts->type == TYPE_BOOL_OR_STR) {
 			int v = git_parse_maybe_bool(value_);
 			if (v < 0)
 				strbuf_addstr(buf, value_);
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 568cfaa3c5..1fc8e788ee 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -2539,7 +2539,9 @@ test_expect_success 'list --type=bool-or-int shows only canonicalizable values'
 	section.big=1048576
 	EOF
 
-	test_must_fail git config ${mode_prefix}list --type=bool-or-int
+	git config ${mode_prefix}list --type=bool-or-int >actual 2>err &&
+	test_cmp expect actual &&
+	test_must_be_empty err
 '
 
 test_expect_success 'list --type=path shows only canonicalizable path values' '
-- 
gitgitgadget

