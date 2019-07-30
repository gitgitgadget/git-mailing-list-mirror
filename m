Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1F1D1F462
	for <e@80x24.org>; Tue, 30 Jul 2019 16:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbfG3Qxk (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 12:53:40 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44706 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfG3Qxk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 12:53:40 -0400
Received: by mail-qk1-f195.google.com with SMTP id d79so47069415qke.11
        for <git@vger.kernel.org>; Tue, 30 Jul 2019 09:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/hn20sPfjl8y4JKBbbcKH8G8QbXbF1HtHFzUQZDXEGQ=;
        b=QpXh0rwcVNSFGWP/2cAIZ7u/LVq6+rcz6UoC59qODWC7J9ZZv9/b3jZ/mw2J6qSuwS
         braR2yoUKlpr8YMXvxJZTvBzGLhVnZ0dol2CISFgAe9rxA3ZXVHD/ApQmeNfgcSKU89u
         qz9vSj37PZNUrW+yAGj6rVx2H0QILBH9/z8jN9QqgzPgPQWuCJtJBSFRCJ8HfoMKB0wq
         PX2W8KghKBt/scoFKVMYjmAjCc1uiSPTOH67DmbhY614CXd0JMLGLq8p8opbfWePVhhO
         RFGc9ViMNpjHj3KfdL2p6Ow3BfQwpCdg5lEBoAZ9pIjthTURjxprNJnhTp8ULqG0ebE7
         3e0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/hn20sPfjl8y4JKBbbcKH8G8QbXbF1HtHFzUQZDXEGQ=;
        b=OppPJkNvDzYrEDQNHwsaK5O5I6JJIx3vV5DNtGLvDSGZxuhQ6gXe7ZuUdqU1Vie+jJ
         NGFpfJ/f3lz/y2MWG1CPelqOtJ7eev6LIzt5XNJvjdi/E8UHtAG91bDutj4DeDJ1o5ih
         zpjXhmGsxll7JbnN1rMRgLApxz84xwDsVOwlU9cHRAzNUtmK4UPltQiCgxcoWCla/pOk
         3xdiDQu54VTBv+A8t09D5SMYo3hO80+ivLVKfimIWauCnBKX0LPzJHGcNnYEZJDcHH4k
         shHqcL5r/eb6YFhvyAXFIa+amK6VAq1eS9z9ilSK6iO67n137USxL3hyy0Vc2GOxMCbg
         jCiw==
X-Gm-Message-State: APjAAAVGNo09Tu3YlrEdJ7B6PaOZZB/kQSDVLgBNJJBB9P5uyLM1A5Bn
        dMrp3GeC4FugrvU0Vpw9eXZq2g9P3aw=
X-Google-Smtp-Source: APXvYqx40HUZ96pQdc6g8rDYIRNyMVWGG39218PN6+vpEHcVV6PMIQRm8DMqdV5j8XFF5LyI7R4FIQ==
X-Received: by 2002:a37:484a:: with SMTP id v71mr76224052qka.29.1564505619150;
        Tue, 30 Jul 2019 09:53:39 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::3])
        by smtp.gmail.com with ESMTPSA id i5sm26377214qtp.20.2019.07.30.09.53.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 09:53:38 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        kernel-usp@googlegroups.com, jackdanielz@eyomi.org,
        Antonio Ospite <ao2@ao2.it>,
        Stefan Beller <stefanbeller@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [GSoC][PATCH] grep: fix worktree case in submodules
Date:   Tue, 30 Jul 2019 13:53:27 -0300
Message-Id: <ba3d8a953a2cc5b4ff03fefa434ffd7bd6a78f15.1564505605.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <CAHd-oW61RFCySF+gUj8iYuV6afEoD0RD9oYE+N6rYd7rv3J2nA@mail.gmail.com>
References: <CAHd-oW61RFCySF+gUj8iYuV6afEoD0RD9oYE+N6rYd7rv3J2nA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Running git-grep with --recurse-submodules results in a cached grep for
the submodules even when --cached is not used. This makes all
modifications in submodules' tracked files be always ignored when
grepping. Solve that making git-grep respect the cached option when
invoking grep_cache() inside grep_submodule(). Also, add tests to
ensure that the desired behavior is performed.

Reported-by: Daniel Zaoui <jackdanielz@eyomi.org>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/grep.c                     | 10 ++++++----
 t/t7814-grep-recurse-submodules.sh | 21 +++++++++++++++++++++
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 560051784e..2699001fbd 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -403,7 +403,7 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 static int grep_submodule(struct grep_opt *opt,
 			  const struct pathspec *pathspec,
 			  const struct object_id *oid,
-			  const char *filename, const char *path)
+			  const char *filename, const char *path, int cached)
 {
 	struct repository subrepo;
 	struct repository *superproject = opt->repo;
@@ -475,7 +475,7 @@ static int grep_submodule(struct grep_opt *opt,
 		strbuf_release(&base);
 		free(data);
 	} else {
-		hit = grep_cache(&subopt, pathspec, 1);
+		hit = grep_cache(&subopt, pathspec, cached);
 	}
 
 	repo_clear(&subrepo);
@@ -523,7 +523,8 @@ static int grep_cache(struct grep_opt *opt,
 			}
 		} else if (recurse_submodules && S_ISGITLINK(ce->ce_mode) &&
 			   submodule_path_match(repo->index, pathspec, name.buf, NULL)) {
-			hit |= grep_submodule(opt, pathspec, NULL, ce->name, ce->name);
+			hit |= grep_submodule(opt, pathspec, NULL, ce->name,
+					      ce->name, cached);
 		} else {
 			continue;
 		}
@@ -598,7 +599,8 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 			free(data);
 		} else if (recurse_submodules && S_ISGITLINK(entry.mode)) {
 			hit |= grep_submodule(opt, pathspec, &entry.oid,
-					      base->buf, base->buf + tn_len);
+					      base->buf, base->buf + tn_len,
+					      1); /* ignored */
 		}
 
 		strbuf_setlen(base, old_baselen);
diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index a11366b4ce..946f91fa57 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -408,4 +408,25 @@ test_expect_success 'grep --recurse-submodules with submodules without .gitmodul
 	test_cmp expect actual
 '
 
+reset_and_clean () {
+	git reset --hard &&
+	git clean -fd &&
+	git submodule foreach --recursive 'git reset --hard' &&
+	git submodule foreach --recursive 'git clean -fd'
+}
+
+test_expect_success 'grep --recurse-submodules without --cached considers worktree modifications' '
+	reset_and_clean &&
+	echo "A modified line in submodule" >>submodule/a &&
+	echo "submodule/a:A modified line in submodule" >expect &&
+	git grep --recurse-submodules "A modified line in submodule" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'grep --recurse-submodules with --cached ignores worktree modifications' '
+	reset_and_clean &&
+	echo "A modified line in submodule" >>submodule/a &&
+	test_must_fail git grep --recurse-submodules --cached "A modified line in submodule" >actual 2>&1 &&
+	test_must_be_empty actual
+'
 test_done
-- 
2.22.0

