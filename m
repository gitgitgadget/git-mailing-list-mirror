Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6083659F3
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 12:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771849625; cv=none; b=nNeGJWF4jKvyLPdXOKiO+LVXsxR/QZ50+oWQlDEM0IlPj36aXY3gxe1bErGDD36uNKCfm0J67Mrw2+grEqd+gJyU5YthFM6Ny9NcBabCSq6aqtp9GYlRWvn67Cn3o/4cqqM5hp8vb9UQBuhuiSQiHdcyJqVSxK52YMF2wS6eVCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771849625; c=relaxed/simple;
	bh=GvHyLLdq5zr5f67o7wACCABuPDFFnW50otGSKA90d64=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=IX1P+l2OuXOqDmqFBtskZUToN/k9+4QVxrpgJdyfARKJs5595atOyT3lnBTiJsLnMrd2UTT8Y9PNFkA6LLyNGDSl2FfV6pcGSnQTjmUGKR9vQ9VIopNflAPehDmCBl3xNn/f0lZjX47zw/Ru4uWGICmWcyCrsLKimeJyz0izxqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHz62wN/; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHz62wN/"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7964f1405a0so41660757b3.1
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 04:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771849623; x=1772454423; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71nFCR43NKhe83w39LyefSyoYAT06N7WaVJRIbf4miY=;
        b=lHz62wN/ZcNK0p8CCtoJaiqAN4NJ5X2hzaTt5oVygaIHbvFx5U0LPDde8ijpVLYKBa
         KsRp7KBJatHRe4i5AezL+IV/ho6LVSAOvoBwjLwr0XnRLoSKiyMTTsUUKMChkDH7kVOZ
         1wup+FEcR5NDJsqbyrWd1vgQ5BAD64+7Chp/Q6vFdRAZDP7ENzaMlPwIC5Ny68yF+8+V
         jzcsH6g2COZkBg0JmImEdIGiceTo4dVZYLK8DgS5sQ6x1PAljJBKPZlzfIAZBdYtUNzC
         PuQVcRSPAB3IJzFU9Yj7edasU3u+fwpvDMQtafTKBnVrgE6sw98ge4uCKpGqV2HBDWGZ
         4xnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771849623; x=1772454423;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=71nFCR43NKhe83w39LyefSyoYAT06N7WaVJRIbf4miY=;
        b=PLia5fOFs470nZMOHgiWVUWHyjTu1Qidd+S43W9TN6KufuoMUG1FDrx2WJCWvbmmdW
         JCZ+vUitt1nkO2AI3IbmSgRkCO6yhzCXLmM+s9x2P0TWiBF9j/MBHpU0kynX5unniecr
         /QjWhV1nqrMb1Yfj5kjCqIp6DIezU+tPjdn2VVI2AkNm9GzjpA+1Q4TAQ23JVBpZkNDq
         CBXqREUojdm5UmA0lSErcscGND+5XCcbClaeuqY1cxfPw+Y1nuK7aPlNLj78bQdr8hJR
         A2rSaWLUiaMJ94IN3pJMoXrRu9s2ma7s3CVDUcL6E+vQV36x6A8g3JaBF7U3vwHWY6Q1
         w7Bw==
X-Gm-Message-State: AOJu0YxH269fIeXRbOdORecFLCPuU9vVXnhK9kcudH8GYU2gnEza8Ecr
	08E6vXSUgcFbRtpKRFOxOnnlDhswWLouWraRFOwo/f07lewKKD7H9WCADgP+Kg==
X-Gm-Gg: ATEYQzwZJII6sBPdA1RsTEZgbQv7VwAWcFSzrvzSN1EdgOznhFvUKX1i8zfQcAunv+F
	ZRP8hh0DQOw4BBupTusJDICgkMzsmERlhj1Nzp9bteK3F3ld4RPfN3UDpwfpdkOaD/nkjzoE6xb
	exDCCgoK1Ca5FdxoCzfg4842l8rCvj5IeTOAmSk+yiq/k3FnIBZEvds5cXw4ECP36zBKnDYr+VO
	JWZbuEDhg6F88UasCBTQPoOYfDFOUUPBcs1QpcL7mDWTKSdCD3OER30MHaC/ytkGHSzZJiHMtYK
	o0OJZomR/D+p3YpcT3elicUt9Ov7ziRloYMTP3OidGlnI5EqvWwRxLvtpteSKex0R6pnNRobA3G
	gY1nY5tqIqv94fTMpMkFv9Jt75/aeMeUf0TJCp5YhVoRPeDnrFMKFFOcDfYXiDFajMK3T9GaWYM
	bwNjeV8bY4FaG6fIDRtP57kd56Ig==
X-Received: by 2002:a05:690c:4b85:b0:798:1219:c779 with SMTP id 00721157ae682-79829181626mr64795137b3.66.1771849623473;
        Mon, 23 Feb 2026 04:27:03 -0800 (PST)
Received: from [127.0.0.1] ([20.171.125.131])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7982ddc5a60sm31056497b3.35.2026.02.23.04.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 04:27:03 -0800 (PST)
Message-Id: <24eb757a4031c0c712d24b835a97e81c6b2a84f1.1771849615.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2044.v3.git.1771849615.gitgitgadget@gmail.com>
References: <pull.2044.v2.git.1771026918.gitgitgadget@gmail.com>
	<pull.2044.v3.git.1771849615.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Feb 2026 12:26:47 +0000
Subject: [PATCH v3 05/13] config: format bools gently
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

Move the logic for formatting bool config values into a helper method
and use gentle parsing when needed.

This makes 'git config list --type=bool' not fail when coming across a
non-boolean value. Such unparseable values are filtered out quietly.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/config.c  | 21 +++++++++++++++++++--
 t/t1300-config.sh |  4 +++-
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 448b148563..d8b38c51d3 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -256,6 +256,24 @@ static int format_config_int64(struct strbuf *buf,
 	return 0;
 }
 
+static int format_config_bool(struct strbuf *buf,
+			      const char *key_,
+			      const char *value_,
+			      int gently)
+{
+	int v = 0;
+	if (gently) {
+		if ((v = git_parse_maybe_bool(value_)) < 0)
+			return -1;
+	} else {
+		/* may die() */
+		v = git_config_bool(key_, value_);
+	}
+
+	strbuf_addstr(buf, v ? "true" : "false");
+	return 0;
+}
+
 /*
  * Format the configuration key-value pair (`key_`, `value_`) and
  * append it into strbuf `buf`.  Returns a negative value on failure,
@@ -284,8 +302,7 @@ static int format_config(const struct config_display_options *opts,
 		if (opts->type == TYPE_INT)
 			res = format_config_int64(buf, key_, value_, kvi, gently);
 		else if (opts->type == TYPE_BOOL)
-			strbuf_addstr(buf, git_config_bool(key_, value_) ?
-				      "true" : "false");
+			res = format_config_bool(buf, key_, value_, gently);
 		else if (opts->type == TYPE_BOOL_OR_INT) {
 			int is_bool, v;
 			v = git_config_bool_or_int(key_, value_, kvi,
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 05a812fd6d..568cfaa3c5 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -2527,7 +2527,9 @@ test_expect_success 'list --type=bool shows only canonicalizable bool values' '
 	section.big=true
 	EOF
 
-	test_must_fail git config ${mode_prefix}list --type=bool
+	git config ${mode_prefix}list --type=bool >actual 2>err &&
+	test_cmp expect actual &&
+	test_must_be_empty err
 '
 
 test_expect_success 'list --type=bool-or-int shows only canonicalizable values' '
-- 
gitgitgadget

