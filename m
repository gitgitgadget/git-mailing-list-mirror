Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8751033D502
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 23:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771026935; cv=none; b=BN3P6H2PeShBf8IJ+l6L1EnbLF9eCYJnPeM+EAj/Ddt+N+aqXhHgdPJrLIuDeuaDTQoE1ie0kZ7SnV2mz7aL0ogsWPw/l6joW6IWrVLDz6nS3q0gMs51RVRWsYDA+Yaw0AHSFSvXG1V0dJgPBur8n0xT6j4460L0p9r5IMgCe1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771026935; c=relaxed/simple;
	bh=umofSWplMG7ql3OwAbTav9cCAOfkuoIWIhifVgaC2dI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=UfNy/Pl3ipAlrJhnmvgLgpapGR7Z8JU+ECvl2moMA6Oci53jZs+V6wSMVy4GsNU1nqiEB7VeFaeKgVl3Kl4CWzOw1A0kHgUNOOQf5bENI7CjYoQvUnJjvxdWLjZbdZnaHBLkalUfz8JO0tp3d4omHG1eC1SnFO2Ze8u5SKLmVoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jya+9d4y; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jya+9d4y"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8ca01dc7d40so153366585a.1
        for <git@vger.kernel.org>; Fri, 13 Feb 2026 15:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771026933; x=1771631733; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJjeebgFU2k625MtZfx+TPWABPSwnSYbACBO7DiNUYo=;
        b=Jya+9d4ykfFCZfNIlumSOlUwsOeRaWDvPzWZavPFqX2sQPihbyZh3EfnLSS7W7IkB2
         HZTBf670OlTEeYJ0nhqQAVlkRp+207nP5uR4/OKEGED806r5+0fsQYZFw7cHWrElU6eH
         LcsDOmU+3qIwS9W+1JlcSZMSwdhejb1nXiiZr7XRBU60FFBXcIZZ3WatrhN+3XZN7FHv
         W5/ehvblM6c+6p6Ddcpwny0n6LTYLsaztjuyxLYi6xdj3SUhUs4HHr7w2e98VJG2ljrw
         +XZPU3NX9W/z8Yi7+9AgXdt7ug+8XGoq07xhAU9c9nlI/I2Orcir2Bgu7ZxpV42ccIKw
         GMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771026933; x=1771631733;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wJjeebgFU2k625MtZfx+TPWABPSwnSYbACBO7DiNUYo=;
        b=hRQcCGKZhF29w4cZYg+hQZBs3U5SrsLipScwWAVnY9FfULg2Ujvhu7yPzI06wpmrQU
         ZZ48MJ6UJ+PhxWPkSoF7zeePsyRjby+8m69tZRkOC10kgxr+HJm+B+AjQ/Ky+VE89Szt
         YTdH9Yr6LSb6pjnCBskuQjucuD2/KLVGnDtTcjuwn9y8Ep+Lw034YnEdUSs8Lii7jgWt
         zbUHQJXKJbsD60uyqt9DkyXbGw8NxZdlz04UrpDkeAAQOwTB/7FbO4y6c059t85XCiF4
         zTuKGKdruSqJgfIidk/fZbzRl5zDHWhofk7bcEfiiJn8rKZ892wdW3xdxtQlQkNeqeon
         A4cA==
X-Gm-Message-State: AOJu0Ywecu/+VOyED107aGuID/oNukjIX1DXu7GUQiKLr/Hyb8xTo5xy
	y9Zj06tR5DDqiCjKxYNS29JNZVVzCQIyrh1K/PHpFxo3PBLtMg73bNV7yOsDoozh
X-Gm-Gg: AZuq6aJwzNvEG06HoJ2yrLXPI58Xv+evrT6K9/FHeYCVrIZAdetn2nSq5YApmXGEmYT
	wra7GAZzd+ajfom/BXJOaXrypPL88VFw16PmCCJa+na6fk7fsMFhd3AgrlX0CDdP29UotxgYzVJ
	SxACaCG8lOGOrQp65Ad5gjanLxM2HX8cO6kbzPfji5JwXgacKEDuvI1AERfLh49mUhxDW2nN0dA
	5/SJzz5J2QOLTX997dvojNxJOr9xx7oSpn6ixiPCFh9giTezG4YNRE5EBk27xUR3n0EK6SMPRiM
	kfInYSXhrTeocMVdhKqtLiAAjgsP91XHqKWHABsrAGFQ24iGD8RtLdz7SYjiYlRgg/z7Y07iC+W
	MI6cEcZaysIr0oE/lvAYfNFz+4bsfohxK6/NuOeuHGw8XK3ra6zPPKk/bpQTzhXyNSGgHHScyg8
	RXoB5/JFBwWdxqHwPxPoQZ7BaB
X-Received: by 2002:a05:620a:40cf:b0:8c6:a5c7:a7ee with SMTP id af79cd13be357-8cb4243cb23mr441141485a.53.1771026933084;
        Fri, 13 Feb 2026 15:55:33 -0800 (PST)
Received: from [127.0.0.1] ([145.132.99.17])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-506b148c614sm17415171cf.11.2026.02.13.15.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 15:55:31 -0800 (PST)
Message-Id: <0a428d2ffe092c2af6789b5e698dc769b0eb883a.1771026918.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2044.v2.git.1771026918.gitgitgadget@gmail.com>
References: <pull.2044.git.1770698579.gitgitgadget@gmail.com>
	<pull.2044.v2.git.1771026918.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 13 Feb 2026 23:55:11 +0000
Subject: [PATCH v2 06/13] config: format bools or ints gently
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

Move the logic for formatting bool-or-int config values into a helper
method and use gentle parsing when needed.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/config.c | 40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 2c169fc126..2c93e1725b 100644
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
+		else if (git_parse_int(value_, &v))
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
-- 
gitgitgadget

