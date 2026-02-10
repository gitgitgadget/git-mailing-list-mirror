Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B1435957
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 04:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770698587; cv=none; b=qqWJzLpcSpRWxAlyXuJVOzw0TpheQ+iKBwm40OPDD7lacwG0574k/GkZTNHnsEeC5tmpQRZ1rmYSUh2OLCjIvUTxzn4SwE4OiQEO4gq4Q/VUlmyZEQdVdADoR0lExICtfW33NgfsQy4/t/eNvoC8Ck9Yi3l9PfzXzTHNfbzM2i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770698587; c=relaxed/simple;
	bh=QHHI0mBz8j7fXuqNUsw96biNv7TLeJQj9LmvjCfmpvY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=T4FthsE4guyTMgRy5RLvSKRSkrEsqvwIf9Lk+4SSMqmBNGKyzdzCx1diGEEku41ojeUcXEryUawPmlfH+iJd01OKHrBitzKn6IPaSfsOa7vTa/WHRxIbzdj1lZcB3bx16uJ5wuXHjiT/DLNmAfHPpm5Ad+Mm5I11HgYnOsKit1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jyja6mJe; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyja6mJe"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-662f91bba0fso3902745eaf.0
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 20:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770698585; x=1771303385; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6pvFJ6W0NUUZdBU+IKOKVV8AOz4rb89oVsaDv4X4TI=;
        b=jyja6mJemIzt/yfmBKyiCGHRTajefPrNOLkXUL5JGnmIkgDOMznfuLulvporpObc9p
         Ca2movp42vP/M/4kVO/ciJAnxgfYBFsNZ3PTREx3iIe/Bu1iZyMplAO9roLFqdYmDSpE
         CaXK7CgqWrXDAubN2zFN6R3moBhd+8jZ5WVZdKW92rREAzv0KiGnSMLVRisn5YuTOB0m
         o5MGaA9DIAznWAMNM/Oez/KP41AD+El3fIlWSl9Uls4r7uF/Fo9qaKOQLdGxgRZ4ZI0e
         z6o3aoqTp1DrtfwCpuE1v+KiCC5IWO7ZY1dE4zCYxevvP9AhHiFkeGKKbuqYTMKvnPER
         7glA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770698585; x=1771303385;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R6pvFJ6W0NUUZdBU+IKOKVV8AOz4rb89oVsaDv4X4TI=;
        b=Msj7gWv5z1Y2ZUBQCpQwmsAivj5kJTXL/VvX10ZOHHbzizguKu4frJhcDTmkAvgDtO
         BRpIpNSlGEF08ZplV5lnU+1NQ707OoteD4fp+IQ/7DIAu9rJ5/tG22E1yh9udROwENMp
         Gz7ygkrNvGpZOOURvP+Bzu5OX2ExKFl1sgFrVTCz6KoBrJiPd+h3Q/zrD3Z0zsG7hiwq
         d6AqWowSfHMNajPHDGAPx5GSzYt3UTvt/QXFgFd+jhxbIx8MyrJuGxjrLDNImsqGSrAT
         491tJSU8QwmAVn7I4jrIzk3vnVKT+NrNCOcxKGx6cpvdDnJVpasd30lm9+0FxLTo1XQP
         rjKg==
X-Gm-Message-State: AOJu0Yz1EyNvrzDwTGcAeN0nmXKRlkKydj9HelZfMfswzq5sq/U6IJbw
	eUsVHEfegYmN9sIembsLUw9blbrF5HR9OhnJhQmaGcrqV6TVhf5Kve6J+xT4yZAH
X-Gm-Gg: AZuq6aJhZJkviIj2T6csnmFxYBTX5bGFU5WRljCIRHe7+qdSbheLnY4wOPEN++SprR/
	3pFechbwMRe+Jz7I/Z3OWCzWcyO36rx+E+yF1hBq5udOlRepd6W2SR63RjPpcteY0QrSGjHsXrJ
	H3YNFxu+TSn84IBWFl06sXzDs9QBLUGSWL28tzESj1ibmj0TlfUw3xR0WwnFtpgVLdS2Kw1J7m7
	SM6tRnbeUXb7NsVLEVN4Fmr8LqX6Ldo9Qq+BBUKAoBFd39pAmT4O6LrO/kLJR34QWYKaQkNa787
	dLp5LcF/qh+hL/SJOJ2U0rFJ8lkqPBjAZWMicdQBJKMKlQm6AbE82B50lHPgLIzrVorRnIHAqiv
	kcGXm8npBSGByaIjMyXba25iqvhF0ux/VmQtu5yvgvsCoDYSlZMTNo3cC5fKcYQffgkxY4pi6V4
	rLgGGT+OZSMgAUWolT6V2HV0G3NQ==
X-Received: by 2002:a05:6820:602:b0:662:c0e8:40f0 with SMTP id 006d021491bc7-672eab094efmr559639eaf.2.1770698584714;
        Mon, 09 Feb 2026 20:43:04 -0800 (PST)
Received: from [127.0.0.1] ([52.173.178.210])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-66d3b2a75d4sm6937687eaf.15.2026.02.09.20.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 20:43:03 -0800 (PST)
Message-Id: <bca83d8ca86ead4df5cd424a8356367915248c43.1770698579.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2044.git.1770698579.gitgitgadget@gmail.com>
References: <pull.2044.git.1770698579.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Feb 2026 04:42:55 +0000
Subject: [PATCH 1/5] config: move show_all_config()
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

