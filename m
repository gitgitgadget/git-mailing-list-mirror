Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEA934F48B
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 12:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771849620; cv=none; b=t/pDGwfY30y5PcPbVrhOnIgMCf3/fCjCL/+yeCa/2BEKkzZDBun1UXqwR3EQgpRazhh5B4bfIVB1D135sTICiZDufKDRTkoa9imXOYS5U3yQBrWQxVWlfhp8nFUGEq7luWKShdPGIge1h2PNIgUVcjqnlk2N9bbn/tkhpeFdIaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771849620; c=relaxed/simple;
	bh=QHHI0mBz8j7fXuqNUsw96biNv7TLeJQj9LmvjCfmpvY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=olieXEbFb2NNlw3GXaLy34kKGGQucYAhvG+jgvQG13Q7ocB9JoUzxVaYdKgIR6U0ltbPvlXx6Rz2hFLgHr60mW1s0rFrJKK69A4jq6r9T66Vq7oc7Cryb+WazLmR0Wd2JEH1s2cixeUdgPqOmHvvPBsjhI52odIeugxkRqIkUKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUbGkWrM; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUbGkWrM"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79854193a54so147787b3.3
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 04:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771849618; x=1772454418; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6pvFJ6W0NUUZdBU+IKOKVV8AOz4rb89oVsaDv4X4TI=;
        b=bUbGkWrMxIp0wv6LI1loMu2LhmCZALah87f1HPB+lVJVK8iY+9a35arsiB0v83zpGA
         DNt1Alf6tVFO7qPNaX8C/sIxksklDnXRngBdqwbJxN1pmQPVuirtDloMYk9zCA3DqROH
         xHU+V1EfT6NW5HKH4ajavgqdV6yU4vMC8VgqoR+3FdHsygPr/nS1hVddFa3OfIJWp1oL
         ywdQxnVAnnnmRxehg2go+Zlv42SVV3G9OusO8q6NuSFLJWHLJ3UacDh0i3fXe8mXc35W
         JaqNjl2VhWVWPKExjzSN+muNU75Kx2LcK4tjghg9/E9kYpSROo+ihddWw2xI0g/DibXe
         hFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771849618; x=1772454418;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R6pvFJ6W0NUUZdBU+IKOKVV8AOz4rb89oVsaDv4X4TI=;
        b=UINRSa1o9HDC0ChhzTLR6J7mNu6Bd4b/+fLuG/eTMj/fJmy3NTaRzPm9IPa2E9Nn2r
         DbWzXOoR1+b2+Q04Q7jxgdUHnH5A0Co2ogYgfBIu4lEwNAPOeBqAaLRmbVYMVtpKOOJ6
         K68sHSBOUUuqGLh0r/pkyWnOF4RFhP5ovsqa329Anp145HBIamWhcdCW3zvBqTza392K
         NBzdqjaGYCU7/WoYtXEKWW9AZZoWmzcNm4XSpa0MXd8g7LogkuaedctgE7K0ti4rT0ES
         bQqPeOiCpw67wGLxNk6HCsWWkQ2dFE2IUAaoBh1f3jCpmVTZNxITM6blVfpU4wI465Pw
         Rs1A==
X-Gm-Message-State: AOJu0YyCfq4ZYe9Zes3v4v0Zrev/MjgQcfB3C57jVCFWYtr5gckZTtMs
	F5rqx/RVyuJPlmThBg0kDrontGnpDSBRnLrOftC+fsooIij81/7kIdonodzRMw==
X-Gm-Gg: ATEYQzxl0TtrG0oSEgwc6x13G1RGOWozf+mbrEY/7sNk4T/aidAwUdTGxzPR7vMVvyp
	JF0dzgh57cWpz64t1C07DIWbf+DvJtP04NitNnSKyIY4Ul6pVV+6WXltqyQZJWh98kwmyuLDqQG
	lhRa1GGs76HwGgsmDGBxZq8uVXYduoS+ToTDZkNrIbRuJWyRpm4Hi4DOeCD1nxJgy0JpPl6Mjsc
	JxWMRv76xod7J2sMjakHp1JbsMvkoIbE7xYoFD9C5+OjMY7XMQA+0qR8wqi4EDt79W8MKFb1IW+
	KKFiVzOhsYef8Epz4LDFXOD210voijSidSSrI61WyyCfxyaxH+Uzi5j4TAi7mGEZHGwUUpV+dLb
	wU4ic7Cdgm+yGnlXoxaHIWvGNY/pvMeQcT4uGFa6GEWKXTHO4PSNK4F8z11xYAV9Yt/MMGxt3YO
	10+P0kSoyZkB3FWfJpaFiSEJ0YGg==
X-Received: by 2002:a05:690c:d81:b0:795:3e1:ddac with SMTP id 00721157ae682-79828f1fce9mr80415977b3.21.1771849618042;
        Mon, 23 Feb 2026 04:26:58 -0800 (PST)
Received: from [127.0.0.1] ([20.171.125.131])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7982dbd8162sm30533827b3.14.2026.02.23.04.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 04:26:57 -0800 (PST)
Message-Id: <bca83d8ca86ead4df5cd424a8356367915248c43.1771849615.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2044.v3.git.1771849615.gitgitgadget@gmail.com>
References: <pull.2044.v2.git.1771026918.gitgitgadget@gmail.com>
	<pull.2044.v3.git.1771849615.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Feb 2026 12:26:43 +0000
Subject: [PATCH v3 01/13] config: move show_all_config()
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

