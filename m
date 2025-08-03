Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372161C84A2
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 16:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754237445; cv=none; b=LV+LmExlCg1eVRXB6bFkcNQkzaCnRPjfIgtRwIghwcgtmFLRBP64yK0SZvNJYj7wbFwyEUjdi/LjyU3z05/OMQBYxvFmOlWIUdiKXV5Pgeq41AHPioPkUKZPNY7G+WRTMwhirm7h0B3723lMr6kb41/75SXIt57xKp+E+kNcaCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754237445; c=relaxed/simple;
	bh=ArXf25/TBnyUGQqs7/6UpC/FkRySw78m+XD1JT1H6Wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zu8wOhC2/BYYrrxR0uQzuB+Zt4/kZEyCzTtXEDnte1ME+taWQKuXeekrVrqcBd+ymntmDuujBxVOTlc9iZruX6IPG0olaOhAe9fxytrUKKqRqP2YjohVnFnP279fL/T8XCDWm/olqyXypr2JOhqFxgGYVJ0edABfCGVwUC0PSmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rk9M48i2; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rk9M48i2"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e8e14cf9e2aso3069805276.0
        for <git@vger.kernel.org>; Sun, 03 Aug 2025 09:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754237443; x=1754842243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7SelPu2SBfMlwqnEZ5jdrIXXqbMlt64yMXdbvZ05kI=;
        b=Rk9M48i2AK4Vqdw4qvqLwcm64uTDwsTGLG9csZPcqmnzlq4i2oMlEksFFVClQm7sbN
         S2M4bqay6tm24mVmuEJkb/0IGdQ41WE820QibIuCgyFKk56vIj148yp+i5fUudG75rWp
         WKmzMGKQsVY7NBRjszXIZ29XnCLLB7a2o23ju6df6Jf0c44RionD1l1h52ey4GI30TVl
         bTSATod9mDsEv6klkg37goX7YNrQ64C6xfT5RvR3aUgHZC2WaTt/iuJI94sjVvoKukzf
         Y4S3QvjmaL3JK76LGUbkgTUMat/aOMbMo6nbBsF218NjsdByQsftRr4EV94YtpvBCGB8
         ad6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754237443; x=1754842243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d7SelPu2SBfMlwqnEZ5jdrIXXqbMlt64yMXdbvZ05kI=;
        b=JnQnUgNu6eSfcCDUgbI/PzNGiRJZTkmTiE4FnfJwbsIWJhSC70gknE1koRDWZourxP
         K/GSh5GgdRh8qYsAxDKrASuwpNnbTobHoCDeXz5hWU15wZIywbb9ZVTtbykbkthRbHuo
         Bett+7nsKlpwuq5xNEr+zDB9qRMSro3aqiFPCeq4vXFmqYJi8qsVcZw8RsZwW0bz0Ko3
         xYpZmZhuHuSps0JrNtFvCexGqZd61xLA0C97NhmLfrtm1tNQ1NVqxsqq5LMAvp073Y8H
         om/yuIWe/JFH9YeqkDZw6khLtGlKrUSO9ftLXUXdJ93OAEqdqxMJ5T+05N1nvDnTtTsY
         QK7A==
X-Gm-Message-State: AOJu0Yw6yHozqAfJ4PAeWuG3fnwC417jg5potSRMxVA2oyqoFrckfF1p
	0116/MsBBoho8l6aTotATT1kydHYpiEv9+JAse/0s9mUxwlsRo7HS2cfOaCA8osp
X-Gm-Gg: ASbGnctru+46sSA+up+zR9ZzGzzbg0tSwnQHB969tULjGCURixgUCGPaLwRYZ2hbGFn
	ChqWG8gjg/nTBODjUC3o25kd/2MXERZZuQUVToyQE0rUIvRI5wf3l4Wkoz3AlFkfBn+v86qJG7l
	SmjA8zpab0kkimIOK936G5brwVEvJh0H5+iC1u3okOl0xufgc09sygf2vJT48sHbqKQvw30A+zX
	lVa7UKKyV6MKZqjfBJcYXENFmvf5Eask91FR8k0f/0n8xmR83lMCPjlNtwQDyIcxgYl4CArlXKu
	qhhZHtY4lG9tJCTav3MDCkf8Xm5dJo9R5e9RKr4iomzYJQz3AmKGwXcQwIkcW9cHj13KHm4vsFZ
	vcAsS9lXG9Q1+SCWsoBOjrMZPzo2LdANiqnWr2Icp4OPL4MCtS3peW5TOJlPvPBu8w/XcKww=
X-Google-Smtp-Source: AGHT+IEehxhjvl6A0DMynwfWzSNeqqfCDk/W5OVkcrFzOxFK/pYd9XK7gLyUKVmnDCNIeZDFg0EGzg==
X-Received: by 2002:a05:6902:1ac7:b0:e8f:eba6:60a1 with SMTP id 3f1490d57ef6-e8fee1277bcmr6853527276.12.1754237442675;
        Sun, 03 Aug 2025 09:10:42 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a8:8b00:a173:55da:e3b1:53f])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8fd3713e9fsm3100175276.5.2025.08.03.09.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 09:10:41 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Usman Akinyemi <usmanakinyemi202@gmail.com>,
	Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Andrzej Hunt <ajrhunt@google.com>
Subject: [PATCH v3 2/3] parse-options: refactor flags for usage_with_options_internal
Date: Sun,  3 Aug 2025 12:10:26 -0400
Message-ID: <20250803161033.77696-3-ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250803012613.54086-1-ben.knoble+github@gmail.com>
References: <20250803012613.54086-1-ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When reading or editing calls to usage_with_options_internal, it is
difficult to tell what trailing "0, 0", "0, 1", "1, 0" arguments mean
(NB there is never a "1, 1" case).

Give the flags readable names to improve call-sites without changing any
behavior.

Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---
 parse-options.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 5224203ffe..169d76fb65 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -953,10 +953,16 @@ static void free_preprocessed_options(struct option *options)
 	free(options);
 }
 
+#define USAGE_NORMAL 0
+#define USAGE_FULL 1
+#define USAGE_TO_STDOUT 0
+#define USAGE_TO_STDERR 1
+
 static enum parse_opt_result usage_with_options_internal(struct parse_opt_ctx_t *,
 							 const char * const *,
 							 const struct option *,
-							 int, int);
+							 int full_usage,
+							 int usage_to_stderr);
 
 enum parse_opt_result parse_options_step(struct parse_opt_ctx_t *ctx,
 					 const struct option *options,
@@ -1088,7 +1094,8 @@ enum parse_opt_result parse_options_step(struct parse_opt_ctx_t *ctx,
 		}
 
 		if (internal_help && !strcmp(arg + 2, "help-all"))
-			return usage_with_options_internal(ctx, usagestr, options, 1, 0);
+			return usage_with_options_internal(ctx, usagestr, options,
+							   USAGE_FULL, USAGE_TO_STDOUT);
 		if (internal_help && !strcmp(arg + 2, "help"))
 			goto show_usage;
 		switch (parse_long_opt(ctx, arg + 2, options)) {
@@ -1129,7 +1136,8 @@ enum parse_opt_result parse_options_step(struct parse_opt_ctx_t *ctx,
 	return PARSE_OPT_DONE;
 
  show_usage:
-	return usage_with_options_internal(ctx, usagestr, options, 0, 0);
+	return usage_with_options_internal(ctx, usagestr, options,
+					   USAGE_NORMAL, USAGE_TO_STDOUT);
 }
 
 int parse_options_end(struct parse_opt_ctx_t *ctx)
@@ -1444,7 +1452,8 @@ static enum parse_opt_result usage_with_options_internal(struct parse_opt_ctx_t
 void NORETURN usage_with_options(const char * const *usagestr,
 			const struct option *opts)
 {
-	usage_with_options_internal(NULL, usagestr, opts, 0, 1);
+	usage_with_options_internal(NULL, usagestr, opts,
+				    USAGE_NORMAL, USAGE_TO_STDERR);
 	exit(129);
 }
 
@@ -1453,7 +1462,8 @@ void show_usage_with_options_if_asked(int ac, const char **av,
 				      const struct option *opts)
 {
 	if (ac == 2 && !strcmp(av[1], "-h")) {
-		usage_with_options_internal(NULL, usagestr, opts, 0, 0);
+		usage_with_options_internal(NULL, usagestr, opts,
+					    USAGE_NORMAL, USAGE_TO_STDOUT);
 		exit(129);
 	}
 }
-- 
2.48.1

