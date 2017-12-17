Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F1A71F404
	for <e@80x24.org>; Sun, 17 Dec 2017 22:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932180AbdLQWtk (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Dec 2017 17:49:40 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:45934 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932111AbdLQWtj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Dec 2017 17:49:39 -0500
Received: by mail-wm0-f66.google.com with SMTP id 9so26032628wme.4
        for <git@vger.kernel.org>; Sun, 17 Dec 2017 14:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZMtgbn0JZJp8CQ23RPoStG0uUu4GMAxUJFRcudkEk6c=;
        b=Y/i+iUVnatUqFmtIHE0w5tPaDZ5fiZiuX3FaQLT4GHxv1dXf1PK58Y6jc5Kr0Cqy2c
         /hl9O+SEXiJg+8XwPTZ1nKWIhl0VHn0biGU/4XpNJsze49B/AC2c39aH0klYPBFSwSWM
         V0WDqdmmscZFZ5Ugs730v3duGtlvRtspRspCDhi9M3uWTG5tdV8j8mKboLAzQBn7Kel2
         UACLDsC9Hnu64XFUJa3GM5IhrwAQe1piEzgisIFMA9ggLB95r+4ziMHdFicadouE8AOb
         WwHXquahBS5Ymd2tCDtPkqOzmMfqRRt1OI0hVbH9CPEmN/UBm9ml5ccPYJDO+M+FCi6l
         38Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZMtgbn0JZJp8CQ23RPoStG0uUu4GMAxUJFRcudkEk6c=;
        b=NvZHMNT9J38TymVhIPqRgNpani3BOPZrGvPx7JDW44/isx/dZq7wYl8xTe4tTHpDyk
         V5OLUvBpRDL+0oQpMiEWqWZetwrg/JcNB/CHgEkWKFBinQzt8nM+p9/9bMDQLmfIUI7z
         uKf7PZJgAQlcKLaKkaFUgKFiTKg3S80wOJNCsU+SI4eUtP5reHgYmikuftMYgBpXVKml
         Akvck5U4lo0jP4hFeguWYyjdzIPR/t+2xGO2SfdWiAmqAdFS+yizNOg4h9Oxkqxb7pst
         G/pCIliRJs9rLN+uPZY1e3TQJMqXUEEQW4X7o4uZYh1HJs50+80KLwSBKJc+j77BYND/
         V97Q==
X-Gm-Message-State: AKGB3mI7Tgvwg+YZDknVqs5E2b2eXK0aUpzm1I7AesreMecBF+1tDg6n
        AvnecKw/JCLPTAAKGAzZdTmaW4PB
X-Google-Smtp-Source: ACJfBosq+EttVFiH+A3RsIEW9taice946acA9vkkcraVQ6rcmS1+PdnvocCSzfq4FDw2p88Gh28oJQ==
X-Received: by 10.28.6.148 with SMTP id 142mr9797969wmg.26.1513550978135;
        Sun, 17 Dec 2017 14:49:38 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id k19sm26652wre.92.2017.12.17.14.49.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Dec 2017 14:49:36 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 0/3] fixes for split index mode
Date:   Sun, 17 Dec 2017 22:51:19 +0000
Message-Id: <20171217225122.28941-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670
In-Reply-To: <20171210212202.28231-1-t.gummerer@gmail.com>
References: <20171210212202.28231-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous round was at <20171210212202.28231-1-t.gummerer@gmail.com>.

Thanks Brandon, Eric, Szeder, Lars and Junio for the comments on the
previous round.  

Changes since the previous round:

- pass in the_repository to do_read_index_from, so we don't have to
  special case NULL anymore.
- free struct repository properly after allocating it in revision.c
- run the travis tests in the linux-gcc and linux 32-bit builds, to
  avoid clashes with the GETTEXT_POISON tests.

The travis tests now depend on sg/travis-fixes, as running the split
index tests separately gets simplified with the introduction of the
'$jobname' variable.  The script falls back gracefully to not runing
the split index test under linux with gcc and only running the
"normal" tests there, while the split index tests would still get run
in the linux 32-bit build.

Because it's a "soft" dependency I thought having this dependency
would be okay, but let me know if you it's getting to complicated and
we can use the environment variables set by travis for now, and then
switch to the '$jobname' variable when it's merged to next/master.

I kept the usage of struct repository for worktrees, as I didn't hear
anything back after my last reply in <20171211213948.GC25616@hank>,
and don't see a better way of doing it.

Interdiff below:
diff --git a/.travis.yml b/.travis.yml
index c83c766dee..281f101f31 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -39,7 +39,7 @@ env:
 
 matrix:
   include:
-    - env: GETTEXT_POISON=YesPlease GIT_TEST_SPLIT_INDEX=YesPlease
+    - env: GETTEXT_POISON=YesPlease
       os: linux
       compiler:
       addons:
diff --git a/ci/run-linux32-build.sh b/ci/run-linux32-build.sh
index e30fb2cddc..f173c9cf2a 100755
--- a/ci/run-linux32-build.sh
+++ b/ci/run-linux32-build.sh
@@ -27,4 +27,5 @@ linux32 --32bit i386 su -m -l $CI_USER -c '
     cd /usr/src/git &&
     make --jobs=2 &&
     make --quiet test
+    GIT_TEST_SPLIT_INDEX=YesPlease make --quiet test
 '
diff --git a/ci/run-tests.sh b/ci/run-tests.sh
index f0c743de94..c7aee5b9ff 100755
--- a/ci/run-tests.sh
+++ b/ci/run-tests.sh
@@ -8,3 +8,7 @@
 mkdir -p $HOME/travis-cache
 ln -s $HOME/travis-cache/.prove t/.prove
 make --quiet test
+if test "$jobname" = "linux-gcc"
+then
+	GIT_TEST_SPLIT_INDEX=YesPlease make --quiet test
+fi
diff --git a/read-cache.c b/read-cache.c
index 4d5c4ad79b..70357febdc 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1898,10 +1898,7 @@ static int do_read_index_from(struct index_state *istate, const char *path,
 		split_index->base = xcalloc(1, sizeof(*split_index->base));
 
 	base_sha1_hex = sha1_to_hex(split_index->base_sha1);
-	if (repo)
-		base_path = repo_git_path(repo, "sharedindex.%s", base_sha1_hex);
-	else
-		base_path = git_path("sharedindex.%s", base_sha1_hex);
+	base_path = repo_git_path(repo, "sharedindex.%s", base_sha1_hex);
 	ret = do_read_index(split_index->base, base_path, 1);
 	if (hashcmp(split_index->base_sha1, split_index->base->sha1))
 		die("broken index, expect %s in %s, got %s",
@@ -1921,7 +1918,7 @@ int read_index_for_repo(const struct repository *repo)
 
 int read_index_from(struct index_state *istate, const char *path)
 {
-	return do_read_index_from(istate, path, NULL);
+	return do_read_index_from(istate, path, the_repository);
 }
 
 int is_index_unborn(struct index_state *istate)
diff --git a/revision.c b/revision.c
index 9d8d9b96d1..34e1e4b799 100644
--- a/revision.c
+++ b/revision.c
@@ -1358,6 +1358,7 @@ void add_index_objects_to_pending(struct rev_info *revs, unsigned int flags)
 		if (repo_read_index(repo) > 0)
 			do_add_index_objects_to_pending(revs, repo->index);
 		discard_index(repo->index);
+		free(repo);
 	}
 	free_worktrees(worktrees);
 }

Thomas Gummerer (3):
  repository: fix repo_read_index with submodules
  prune: fix pruning with multiple worktrees and split index
  travis: run tests with GIT_TEST_SPLIT_INDEX

 cache.h                 |  1 +
 ci/run-linux32-build.sh |  1 +
 ci/run-tests.sh         |  1 +
 read-cache.c            | 16 ++++++++++++++--
 repository.c            | 13 ++++++++++++-
 repository.h            |  2 ++
 revision.c              | 14 +++++++++-----
 7 files changed, 40 insertions(+), 8 deletions(-)

-- 
2.15.1.620.gb9897f4670

