Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7044318BAE
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 23:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771026925; cv=none; b=FNVRfWSWWKmTPeF4WFeS+bZYnQNOsRkyi0W+PBVaA2kH+EEGsx1ulye9b/X7/k5d1EWcFtoJdEBDSWCz9pzBHeVP8eVJjIla9LFG1k9pLRJsaycKcEg7dP2udqPl9GLM3kqO78vI2VzD3/9+FJfhTbfNuFo4XQRWF96uSXcDzo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771026925; c=relaxed/simple;
	bh=QHHI0mBz8j7fXuqNUsw96biNv7TLeJQj9LmvjCfmpvY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZPzZocNRD4Zyuf7LamCW1aOoNRBajxI/xgO+gD5FxmodjixJYQbsnBihc225oebMkXtqPe+z+gJdTPF6NJfwXhIxTvuBIgl7WaENkvXUAAGiT1CqaLu/qBYulTgE5scHKawZuPI+FGKhWDiPUaSliv5hkKSjR0711pSc2qO6jCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PtKTQs7y; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtKTQs7y"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8c6aaf3cd62so158652485a.3
        for <git@vger.kernel.org>; Fri, 13 Feb 2026 15:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771026922; x=1771631722; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6pvFJ6W0NUUZdBU+IKOKVV8AOz4rb89oVsaDv4X4TI=;
        b=PtKTQs7ySc5OMmgdKa4afLxvPdVoOuJCJkvTVm3vzs+LrHnvOBlvymXXdOwTbFm8F8
         XGYawpezcxiveJRpJu+AFKp0twpx+PM4b7G3MUADKNWT93JFlsjmRXsaiZsuPGTMoG2T
         0Kmr6JystlNAr7Lb1sML9kmtfL7FyDvRhPIUpNGq1qkJpwv3+AqGJqpeUH7KhEu5Usdl
         7Zh2D1V7OpW/mIOGosxH1zFyfpwpLSHe4ArCITrizYQsY9kwKaYQx76LUzjiQt2xWcgq
         8qUCkGwDowysT7q89QhuPy92dIdynepnDezQO5FiH0IUgck3IvDVpPNKdEF97s/384Or
         hbaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771026922; x=1771631722;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R6pvFJ6W0NUUZdBU+IKOKVV8AOz4rb89oVsaDv4X4TI=;
        b=ChlE7+hOU0frRXy6Qd1ffZYR7Ilu9wnliZxciIcjlq37I098QB6HMs0EBqN6G1aUDv
         l4nO/435hEsFQ6+mpOgTJZw9F+1tVMs//BsJUU6kWZ21l/NUhfA96DF9UMGS3t/hMbzT
         gx1f/krVeYWJMWrdr4+749xHpVwkXSvlf1YQxV+KX4M9mFkXFezYNjpqj061IcfoS1Lo
         XLfW2dh4o5JyHbNSLHNXo4TebWXzqB3Udsw1rkx9CTUdgrxci412NnSdaCBc2bOKEu+5
         qd9ZRXYPTd8AJey2JBoIljXxiSYsQJPUHeETY0qSNmhCtyorheJlpuNTpUaacEGoozzw
         BcwA==
X-Gm-Message-State: AOJu0YwBA38AP6TZ9qRiQ4zpLjPdI43TLe1/IWJbhlpnYpyftfWUAht0
	9VrtZpvWKY5W2neKUhEeqVujoM63KWMRjO1PJlbUNRX6vta+dIMxxQz+IyFke+hW
X-Gm-Gg: AZuq6aJzd64u8qA4dMIx4HeT6RmT/sgnbaSMDRg/mKcfAsspTmV/vFuvAH16Pqp/dJn
	hwy18i2YGGHjopAiRzUMRtGx1VoSkIULWb/BCrho0+qBlysFo84Zi1Z+10HZIuGbpXh37LwBeLi
	BGG3cHCVCcs0XrHL1sImzTdcd1ot/kbDLRQs4kU0p0hVObHsTK4hXhC64k3sGXRWtiTvQU98Q7J
	QcoYrahU5jK2XARlwh0yjD7E3oZ9bjrbuxCswsPkqoMl84QBfc8hXWxpt0xiOLa6igkC+Nv0xaO
	nR+1yGsvjXq1KAbJtfU8+VyJsOFsJD5sLF2SYnn8Yl6NmiZqkFQo+oDb1K5kjAl5UMm8wT13Ytu
	ETiLPX1XpJGJUyw4J3X4fhHD27ia6CrsfeNaSblbixkV0bRYKoXyHPH8qrk/ONdF5su2Ve4b1Yj
	jrqzAfKrTyI5Wt25e4Mx69tTAy
X-Received: by 2002:a05:620a:290c:b0:8b2:ea5a:4149 with SMTP id af79cd13be357-8cb4248158dmr480731985a.65.1771026922440;
        Fri, 13 Feb 2026 15:55:22 -0800 (PST)
Received: from [127.0.0.1] ([145.132.99.17])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb2b0f38afsm717978285a.22.2026.02.13.15.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 15:55:21 -0800 (PST)
Message-Id: <bca83d8ca86ead4df5cd424a8356367915248c43.1771026918.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2044.v2.git.1771026918.gitgitgadget@gmail.com>
References: <pull.2044.git.1770698579.gitgitgadget@gmail.com>
	<pull.2044.v2.git.1771026918.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 13 Feb 2026 23:55:06 +0000
Subject: [PATCH v2 01/13] config: move show_all_config()
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
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

In anticipation of using format_config() in this method, move
show_all_config() lower in the file without changes.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/config.c | 48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 288ebdfdaa..237f7a934d 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -231,30 +231,6 @@ static void show_config_scope(const struct config_display_options *opts,
 	strbuf_addch(buf, term);
 }
 
-static int show_all_config(const char *key_, const char *value_,
-			   const struct config_context *ctx,
-			   void *cb)
-{
-	const struct config_display_options *opts = cb;
-	const struct key_value_info *kvi = ctx->kvi;
-
-	if (opts->show_origin || opts->show_scope) {
-		struct strbuf buf = STRBUF_INIT;
-		if (opts->show_scope)
-			show_config_scope(opts, kvi, &buf);
-		if (opts->show_origin)
-			show_config_origin(opts, kvi, &buf);
-		/* Use fwrite as "buf" can contain \0's if "end_null" is set. */
-		fwrite(buf.buf, 1, buf.len, stdout);
-		strbuf_release(&buf);
-	}
-	if (!opts->omit_values && value_)
-		printf("%s%c%s%c", key_, opts->delim, value_, opts->term);
-	else
-		printf("%s%c", key_, opts->term);
-	return 0;
-}
-
 struct strbuf_list {
 	struct strbuf *items;
 	int nr;
@@ -332,6 +308,30 @@ static int format_config(const struct config_display_options *opts,
 	return 0;
 }
 
+static int show_all_config(const char *key_, const char *value_,
+			   const struct config_context *ctx,
+			   void *cb)
+{
+	const struct config_display_options *opts = cb;
+	const struct key_value_info *kvi = ctx->kvi;
+
+	if (opts->show_origin || opts->show_scope) {
+		struct strbuf buf = STRBUF_INIT;
+		if (opts->show_scope)
+			show_config_scope(opts, kvi, &buf);
+		if (opts->show_origin)
+			show_config_origin(opts, kvi, &buf);
+		/* Use fwrite as "buf" can contain \0's if "end_null" is set. */
+		fwrite(buf.buf, 1, buf.len, stdout);
+		strbuf_release(&buf);
+	}
+	if (!opts->omit_values && value_)
+		printf("%s%c%s%c", key_, opts->delim, value_, opts->term);
+	else
+		printf("%s%c", key_, opts->term);
+	return 0;
+}
+
 #define GET_VALUE_ALL        (1 << 0)
 #define GET_VALUE_KEY_REGEXP (1 << 1)
 
-- 
gitgitgadget

