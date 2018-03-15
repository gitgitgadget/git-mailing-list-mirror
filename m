Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D0081F404
	for <e@80x24.org>; Thu, 15 Mar 2018 16:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751600AbeCOQol (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 12:44:41 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:39860 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751372AbeCOQok (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 12:44:40 -0400
Received: by mail-lf0-f65.google.com with SMTP id f75-v6so11174447lfg.6
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 09:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AVyGpDBwb0yV083WHy2y/DVTIaWYYvnue87UKflxLzs=;
        b=FSUU4mu62ZRWVeCPKxWVnJviWoPKUMcWgHGj/qCkYXHydmDgT/JGy5YFzrBJGe7jNJ
         WP9jqmVIz0WfGhINWvDc9LcDoKfui/Uy6K9k43PonFm/Hx+74Io4IBAqBnc3Ex2rKG49
         ckZor9f5gh+uWpwkuTexCpP/o7+OFKvZK1aYUVALSgkBbPhGNSyTuvyJDbbvId4Phktx
         8bR1dLOnOfqEkYqqLuVxy/ipOZ/0dgZoP8rSAex6tP1McFL1lIy2wctvB5VYh8aKHBTy
         aC5km07Jrnfd2NT1Y6ZK45r0APctFXbhLBU/FMcWaJ5w1MxDg5v0yWZL04HQckGTDh9M
         gE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AVyGpDBwb0yV083WHy2y/DVTIaWYYvnue87UKflxLzs=;
        b=g4YViTbtQPoJR3H8J9O7gnfTMzJBRWAQRVkL1/ACWy1TvpM/WRsd1nQMaCAaFKI9wM
         +LVquc5YbOR+jp1VJ2rvChls8GN7dxsZli0KY/W9eFdUB5C5pvfNKKs55IWDfwZpWr2a
         aBMGYB7ZFs6CKr49N+xGRhrNNJz699THA2JEdyxKvJSeQ7LxlJ6siz5YUsTkxaXEutQJ
         pmGBkajNDN+oMqDCZ4xNJl6UwcGwRZtYyZANI/HKw6uCn8ingdHznUQfgX3xRCrXVbL/
         vZw9GfqBebPw48X5bQMk9HBEBvAfCI34Kkb6Nz57ZV5XAc9HokX200kPLQaUy/mWfzjj
         HK9Q==
X-Gm-Message-State: AElRT7HDUGcSs7fSHMptlqWtHffxJh9FgmYPwP9D489qpR8erAD3Oqms
        mdJcAXDhbDnx01JdKcU63Y6hwg==
X-Google-Smtp-Source: AG47ELtOTrdTq0+RpBcdEe7Lm6WVSV3attAKta8cv81WDj4xXdH3fhqXNhZpkMg2aA34jYdHTz5J9Q==
X-Received: by 2002:a19:ca41:: with SMTP id h1-v6mr2070265lfj.81.1521132278570;
        Thu, 15 Mar 2018 09:44:38 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id u24sm1037406lju.32.2018.03.15.09.44.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Mar 2018 09:44:37 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, sunshine@sunshineco.com,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/3] git worktree prune improvements
Date:   Thu, 15 Mar 2018 17:44:09 +0100
Message-Id: <20180315164412.14697-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.2.903.gd04caf5039
In-Reply-To: <20180303033918.15751-1-pclouds@gmail.com>
References: <20180303033918.15751-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2 fixes comments from Eric and rebases on 'master' since 'worktree
move' has been merged. Commit messages are updated to reflect this.

There's one thing I didn't do is moving the new paragraph up [1]. I
still feel this it's not right to put it there since it starts with
'gc --auto' introduction, then goes to loose objects and packs.
Inserting a note between the loose objects paragraph and the packs one
does not make much sense.

Interdiff

-- 8< --
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 862c931104..3126e0dd00 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -17,7 +17,7 @@ Runs a number of housekeeping tasks within the current repository,
 such as compressing file revisions (to reduce disk space and increase
 performance), removing unreachable objects which may have been
 created from prior invocations of 'git add', packing refs, pruning
-reflog, rerere or stale working trees.
+reflog, rerere metadata or stale working trees.
 
 Users are encouraged to run this task on a regular basis within
 each repository to maintain good disk space utilization and good
@@ -46,14 +46,14 @@ OPTIONS
 	With this option, 'git gc' checks whether any housekeeping is
 	required; if not, it exits without performing any work.
 	Some git commands run `git gc --auto` after performing
-	operations that could create many loose objects.
+	operations that could create many loose objects. Housekeeping
+	is required if there are too many loose objects or too many
+	packs in the repository.
 +
-Housekeeping is required if there are too many loose objects or
-too many packs in the repository. If the number of loose objects
-exceeds the value of the `gc.auto` configuration variable, then
-all loose objects are combined into a single pack using
-`git repack -d -l`.  Setting the value of `gc.auto` to 0
-disables automatic packing of loose objects.
+If the number of loose objects exceeds the value of the `gc.auto`
+configuration variable, then all loose objects are combined into a
+single pack using `git repack -d -l`.  Setting the value of `gc.auto`
+to 0 disables automatic packing of loose objects.
 +
 If the number of packs exceeds the value of `gc.autoPackLimit`,
 then existing packs (except those marked with a `.keep` file)
@@ -61,9 +61,10 @@ are consolidated into a single pack by using the `-A` option of
 'git repack'. Setting `gc.autoPackLimit` to 0 disables
 automatic consolidation of packs.
 +
-If `git gc --auto` goes ahead because of either too loose objects or
-packs, all other housekeeping tasks (e.g. rerere, working trees,
-reflog...) will also be be performed.
+If houskeeping is required due to many loose objects or packs, all
+other housekeeping tasks (e.g. rerere, working trees, reflog...) will
+be performed as well.
+
 
 --prune=<date>::
 	Prune loose objects older than date (default is 2 weeks ago,
@@ -138,9 +139,10 @@ The optional configuration variable `gc.pruneExpire` controls how old
 the unreferenced loose objects have to be before they are pruned.  The
 default is "2 weeks ago".
 
-The optional gc.worktreePruneExpire controls how old a stale working
-tree before `git worktree prune` deletes it. The default is "3 months
-ago".
+Optional configuration variable `gc.worktreePruneExpire` controls how
+old a stale working tree should be before `git worktree prune` deletes
+it. Default is "3 months ago".
+
 
 Notes
 -----
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 4d4404e97f..b1e8f0534c 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -100,10 +100,8 @@ static int prune_worktree(const char *id, struct strbuf *reason)
 	path[len] = '\0';
 	if (!file_exists(path)) {
 		free(path);
-		if (st.st_mtime <= expire) {
-			if (!stat(git_path("worktrees/%s/index", id), &st) &&
-			    st.st_mtime > expire)
-				return 0;
+		if (stat(git_path("worktrees/%s/index", id), &st) ||
+		    st.st_mtime <= expire) {
 			strbuf_addf(reason, _("Removing worktrees/%s: gitdir file points to non-existent location"), id);
 			return 1;
 		} else {
diff --git a/t/t2026-worktree-prune.sh b/t/t2026-worktree-prune.sh
index a0f1e3bb80..b7d6d5d45a 100755
--- a/t/t2026-worktree-prune.sh
+++ b/t/t2026-worktree-prune.sh
@@ -78,10 +78,9 @@ test_expect_success 'not prune locked checkout' '
 
 test_expect_success 'not prune recent checkouts' '
 	test_when_finished rm -r .git/worktrees &&
-	mkdir zz &&
-	mkdir -p .git/worktrees/jlm &&
-	echo "$(pwd)"/zz >.git/worktrees/jlm/gitdir &&
-	rmdir zz &&
+	git worktree add jlm HEAD &&
+	test -d .git/worktrees/jlm &&
+	rm -rf jlm &&
 	git worktree prune --verbose --expire=2.days.ago &&
 	test -d .git/worktrees/jlm
 '
-- 8< --


[1] https://public-inbox.org/git/CAPig+cSo_n7y3-qDT92+NYspTB+yF+NUL19MLvfztLJ_qZhXnw@mail.gmail.com/

Nguyễn Thái Ngọc Duy (3):
  gc.txt: more details about what gc does
  worktree: delete dead code
  worktree prune: improve prune logic when worktree is moved

 Documentation/git-gc.txt               | 28 +++++++++++++++++---------
 Documentation/gitrepository-layout.txt |  5 -----
 builtin/worktree.c                     | 11 ++--------
 t/t2026-worktree-prune.sh              |  7 +++----
 4 files changed, 24 insertions(+), 27 deletions(-)

-- 
2.16.2.903.gd04caf5039

