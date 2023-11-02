Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BCD1C295
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 13:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SH5hQFVN"
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C7A83
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 06:52:21 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-32f78dcf036so1253421f8f.0
        for <git@vger.kernel.org>; Thu, 02 Nov 2023 06:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698933139; x=1699537939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3YXTup2bwVt/FT/VNk+Owu8Ynqnqb3LWkT0De09rdA=;
        b=SH5hQFVNuAVdQZc5NW3R9Pu00NcFaU/ZxdAvQjNeqVluaGMTO/r38JFjihEFvhbG5P
         iqyZppo/zsrb2shY2T2Haz+TMXFA58qXA/JLY+0w/j4bbAfWxoRQI8+l0xEMKbFhG1t1
         /42iD4zQs0Bm+0O35ljhUsay6cIqYifwmiRh1splYWdKMvYmV/A+bA/tesgbBaLCM0q5
         fbGwEwLEg66mEPAQgQm6fVIS03Mh4Dsgyjue0PPJOeV0vWbq3yqLRwzbDe9QUj/Z8UXq
         zs9x5c2Fa8/+vPl09FWlLOylgKYXKQgOXduLEBhiVQW5K8n7AAyPcX+vH9jXy2IOLRTT
         CUnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698933139; x=1699537939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z3YXTup2bwVt/FT/VNk+Owu8Ynqnqb3LWkT0De09rdA=;
        b=EKzgtCBY3Czy4BqSpMEa7RoRqKZy+GgwHn3PWQwvZjGRtWU9nk9HNWZj0t6ehrg8jX
         FWOUEK7cXIH/sQDvkm3CLglQIEXVbu1UP8W20QITw4coCNgKzcddeXn0GTfH8jMizp3b
         yPvlmt3xJltQvURQdlYdMOAna9EEXdLkPIYQEJ+2tukRVcJVOfIIibZEPwjBlN1wMzOc
         fHSrr75HdrPxtxZwaR1zBXZYOu68L+8UA6/RhPORJbk2frlZEZk/d2xqvyROnreGeTyx
         quAGfHZW2nFfsy53kRVDets8zttibi3UFNV9bMnvnLdgmxzWnAfO+GXQpgfOLdGnIE+2
         935A==
X-Gm-Message-State: AOJu0Yx19zFApVF+NYLyRBMGS/oHQTnKEWHhbKRzIY7+vxaqSXZ+8Op1
	RogMC6rX1AY5ae/2WMebk0PhoxtbG3Y=
X-Google-Smtp-Source: AGHT+IF8MwUQYkwDgUTTwve0PT8O/NvHg8m/051DPWUi0DmBEflYp9f/q16MtqOhq5z7oJRAx52ANg==
X-Received: by 2002:a5d:59ab:0:b0:32f:7fa3:9fe2 with SMTP id p11-20020a5d59ab000000b0032f7fa39fe2mr10347824wrr.25.1698933139196;
        Thu, 02 Nov 2023 06:52:19 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:116d:4e46:313c:1f52:4963:91b6])
        by smtp.gmail.com with ESMTPSA id e6-20020adffc46000000b0030647449730sm2514996wrs.74.2023.11.02.06.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 06:52:18 -0700 (PDT)
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
Subject: [PATCH v6 06/14] replay: change rev walking options
Date: Thu,  2 Nov 2023 14:51:43 +0100
Message-ID: <20231102135151.843758-7-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.496.g529a7fda40
In-Reply-To: <20231102135151.843758-1-christian.couder@gmail.com>
References: <20231010123847.2777056-1-christian.couder@gmail.com>
 <20231102135151.843758-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Elijah Newren <newren@gmail.com>

Let's set the rev walking options we need after calling
setup_revisions() instead of before. This enforces options we always
want for now.

We want the command to work from older commits to newer ones by default.
Also we don't want history simplification, as we want to deal with all
the commits in the affected range.

When we see an option that we are going to override, we emit a warning
to avoid confusion as much as possible though.

Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replay.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index 5c4cbd11db..a0d27ab249 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -133,7 +133,7 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 	struct merge_result result;
 	struct strbuf reflog_msg = STRBUF_INIT;
 	struct strbuf branch_name = STRBUF_INIT;
-	int ret = 0;
+	int i, ret = 0;
 
 	const char * const replay_usage[] = {
 		N_("git replay --onto <newbase> <oldbase> <branch> # EXPERIMENTAL"),
@@ -173,22 +173,32 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 
 	repo_init_revisions(the_repository, &revs, prefix);
 
-	revs.verbose_header = 1;
-	revs.max_parents = 1;
-	revs.cherry_mark = 1;
-	revs.limited = 1;
-	revs.reverse = 1;
-	revs.right_only = 1;
-	revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
-	revs.topo_order = 1;
-
 	strvec_pushl(&rev_walk_args, "", argv[2], "--not", argv[1], NULL);
 
+	/*
+	 * TODO: For now, let's warn when we see an option that we are
+	 * going to override after setup_revisions() below. In the
+	 * future we might want to either die() or allow them if we
+	 * think they could be useful though.
+	 */
+	for (i = 0; i < argc; i++) {
+		if (!strcmp(argv[i], "--reverse") || !strcmp(argv[i], "--date-order") ||
+		    !strcmp(argv[i], "--topo-order") || !strcmp(argv[i], "--author-date-order") ||
+		    !strcmp(argv[i], "--full-history"))
+			warning(_("option '%s' will be overridden"), argv[i]);
+	}
+
 	if (setup_revisions(rev_walk_args.nr, rev_walk_args.v, &revs, NULL) > 1) {
 		ret = error(_("unhandled options"));
 		goto cleanup;
 	}
 
+	/* requirements/overrides for revs */
+	revs.reverse = 1;
+	revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
+	revs.topo_order = 1;
+	revs.simplify_history = 0;
+
 	strvec_clear(&rev_walk_args);
 
 	if (prepare_revision_walk(&revs) < 0) {
-- 
2.42.0.496.g529a7fda40

