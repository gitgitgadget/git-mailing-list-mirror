Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AF72DF67
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 14:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAYe6ZJi"
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB73189
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 06:33:56 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4083f61322fso53646315e9.1
        for <git@vger.kernel.org>; Wed, 15 Nov 2023 06:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700058834; x=1700663634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ze0ZZh/TMWbCDcHijjRV14IrjUZbWlQ3RkhaWbRVZXI=;
        b=EAYe6ZJi85IMVCbf5hq7kfWRAw2UDfjcoqjObmPxBHI2fVIAhx90s835aPH+YALCh2
         qRAWJNyFpJtGSr0Ep6/pBOdZGfxYXAJHQcNrf5uJ3czKVIZDnDgz0mCdAo02qz1MHpt4
         uTkkil/UmQQ9vkF3CqeaSe+PhfxEWqwZ995u3gSx9CnDwhg7lkLz5FQYPH8ikPogqpyE
         qNGfVpJFtAa81WG0fY1vW1BTkRmTjJPf+4Uo5K0GKGWgFo81Mc5RWa1FQZnH7HuL8E30
         s57rzVV0Q4YseqQ+jmh53sDA3u7p5aolqH89z3YFDTz9mWQFS3liN3M25nb1e4DKSKT9
         qpwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700058834; x=1700663634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ze0ZZh/TMWbCDcHijjRV14IrjUZbWlQ3RkhaWbRVZXI=;
        b=HO8v7wvoflg3qTdKVKWbWujokJ58BIonC3OL6lmtqx3WiYC9X9m7F609y2s4jhpsua
         QBxEUuPUTXybVxipVrDtJCiald4QyB/Hv7uVYvFYDrMI1GZERxcXk+7PXJ0bzHI+q0Ue
         nhpX+h4H4GO8UXFYFSDO7DjaEQ9LmRDoSCINgMQJ/k2RrQQuU0bfSlMflT352WCT2QCL
         i2/cAm5S9QRxvAK5Q1OtzEFHJU0n84V5gXA72OXyw9+84i5frsmK9hpWmGv4EDhchuO9
         u5lEkxWk/fPCiWyvDoxs6pEKfrOrmxpIiwUsicKABzgmy3IwMhaUzG+OWybFvhG9lN0W
         gs/g==
X-Gm-Message-State: AOJu0YylZHpl0BYpXQ2tuDlemNVvCvF8ArWm63Zf3W8whTZhvLUJyB3m
	in2Ge7yHsQ4Fa5IH7N1Wa+PglYW8Ypw=
X-Google-Smtp-Source: AGHT+IG4zEuvIBgL9D7K/rCTwrBTdRleXGUdB2VScBuhFVzqYH7CFR5+UIWXR0U7UY7qcK9QUwbyew==
X-Received: by 2002:a05:600c:34ce:b0:409:773:cf62 with SMTP id d14-20020a05600c34ce00b004090773cf62mr10494296wmq.39.1700058834206;
        Wed, 15 Nov 2023 06:33:54 -0800 (PST)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:a40b:e654:dd4c:2f5f])
        by smtp.gmail.com with ESMTPSA id q15-20020a05600c46cf00b004060f0a0fd5sm15207643wmo.13.2023.11.15.06.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 06:33:52 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	John Cai <johncai86@gmail.com>,
	Derrick Stolee <stolee@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Calvin Wan <calvinwan@google.com>,
	Toon Claes <toon@iotcl.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Linus Arver <linusa@google.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v7 06/14] replay: change rev walking options
Date: Wed, 15 Nov 2023 15:33:19 +0100
Message-ID: <20231115143327.2441397-7-christian.couder@gmail.com>
X-Mailer: git-send-email 2.43.0.rc1.15.g29556bcc86
In-Reply-To: <20231115143327.2441397-1-christian.couder@gmail.com>
References: <20231102135151.843758-1-christian.couder@gmail.com>
 <20231115143327.2441397-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Elijah Newren <newren@gmail.com>

Let's force the rev walking options we need after calling
setup_revisions() instead of before.

This might override some user supplied rev walking command line options
though. So let's detect that and warn users by:

  a) setting the desired values, before setup_revisions(),
  b) checking after setup_revisions() whether these values differ from
     the desired values,
  c) if so throwing a warning and setting the desired values again.

We want the command to work from older commits to newer ones by default.
Also we don't want history simplification, as we want to deal with all
the commits in the affected range.

Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replay.c | 48 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 7 deletions(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index 5c4cbd11db..8302d35eca 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -173,22 +173,56 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 
 	repo_init_revisions(the_repository, &revs, prefix);
 
-	revs.verbose_header = 1;
-	revs.max_parents = 1;
-	revs.cherry_mark = 1;
-	revs.limited = 1;
+	strvec_pushl(&rev_walk_args, "", argv[2], "--not", argv[1], NULL);
+
+	/*
+	 * Set desired values for rev walking options here. If they
+	 * are changed by some user specified option in setup_revisions()
+	 * below, we will detect that below and then warn.
+	 *
+	 * TODO: In the future we might want to either die(), or allow
+	 * some options changing these values if we think they could
+	 * be useful.
+	 */
 	revs.reverse = 1;
-	revs.right_only = 1;
 	revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
 	revs.topo_order = 1;
-
-	strvec_pushl(&rev_walk_args, "", argv[2], "--not", argv[1], NULL);
+	revs.simplify_history = 0;
 
 	if (setup_revisions(rev_walk_args.nr, rev_walk_args.v, &revs, NULL) > 1) {
 		ret = error(_("unhandled options"));
 		goto cleanup;
 	}
 
+	/*
+	 * Detect and warn if we override some user specified rev
+	 * walking options.
+	 */
+	if (revs.reverse != 1) {
+		warning(_("some rev walking options will be overridden as "
+			  "'%s' bit in 'struct rev_info' will be forced"),
+			"reverse");
+		revs.reverse = 1;
+	}
+	if (revs.sort_order != REV_SORT_IN_GRAPH_ORDER) {
+		warning(_("some rev walking options will be overridden as "
+			  "'%s' bit in 'struct rev_info' will be forced"),
+			"sort_order");
+		revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
+	}
+	if (revs.topo_order != 1) {
+		warning(_("some rev walking options will be overridden as "
+			  "'%s' bit in 'struct rev_info' will be forced"),
+			"topo_order");
+		revs.topo_order = 1;
+	}
+	if (revs.simplify_history != 0) {
+		warning(_("some rev walking options will be overridden as "
+			  "'%s' bit in 'struct rev_info' will be forced"),
+			"simplify_history");
+		revs.simplify_history = 0;
+	}
+
 	strvec_clear(&rev_walk_args);
 
 	if (prepare_revision_walk(&revs) < 0) {
-- 
2.43.0.rc1.15.g29556bcc86

