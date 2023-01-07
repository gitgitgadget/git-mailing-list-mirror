Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B075C54EBC
	for <git@archiver.kernel.org>; Sat,  7 Jan 2023 13:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbjAGN5E (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Jan 2023 08:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjAGN5C (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2023 08:57:02 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664D46C7F3
        for <git@vger.kernel.org>; Sat,  7 Jan 2023 05:57:00 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id v10so4696574edi.8
        for <git@vger.kernel.org>; Sat, 07 Jan 2023 05:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wlectdDeKkTksrYVDoJIKMP8AFjhWnuRjKFpRKguyfs=;
        b=Qx2L9kPWuBY2Tzx61NcCq5TXvalCATi2AIBy0ypiXFC8rE3VltIDT4lEC0FTgMyTwq
         9ICtmyDdxy2nhnp0ypJts5N3aMHZoTnALsmGS+aWi8W6s9mNNrYwunp3Z0lDpcqkmv4T
         kn3v5pDhaMbaRHi1PCSi63Q6+uxBWOYklgj2s8NakgXjh4FZwAifK6DNIeU6lCwy8bCf
         NtjudgqHsB4wkFaNKOl25Sk+KzTzV3V3PGUHodyeSrpASwL5MFp6ipWPqBSajdpfyFnu
         /8NH6dkpR0mWTctW96SOWz9sNJNxmVafU8oygQaNR0XhudYfLVYGih+ecrlEG/+kHrgJ
         iH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wlectdDeKkTksrYVDoJIKMP8AFjhWnuRjKFpRKguyfs=;
        b=xa0okdR9dUI4w7JI+rXoXkmvXSfnAeHo2Fs8HaRwIk9YmMeu/TisMi4GoE1IuNZ0xp
         kDco5WTWc0UCunaMSvcF44PXIHfltY5fMZjLXtWT2P2ygPnNriS49KNuGBCUYo7b+FXy
         9ROXuCmhujHUhGpRh/GcLnJB4ZJNJ7Efz5z5EiJzSUOUxa9O4hjR5ghUE4kc89XsXE4E
         VlgvlKl06y8rGT0OU2rNV+FePZ0rQ/2UQgkoPa1koU88jfxf3lqKrKR3EHNdfs613YNv
         MUDzY2NGW7sVXwCJhIq4YozkN2sr24zNlrcP/7yte9p26sNSDa5tLZKCFxYWv/9B8SsU
         Pa6g==
X-Gm-Message-State: AFqh2kr/TxNIHiOGnc0D7eRcVxAeGTFVTiac37AhxdFirDih3s4lQsDR
        6ZLaAxYDMAr25k+Dxl96jlMPhM62dKbEzQ==
X-Google-Smtp-Source: AMrXdXvZleC7uKuSpCEex2VthB4yDDIcrZobbj9Bl/mVCBBQPiNSWMlYWthC6CuNAVQsC2oDE1WBwA==
X-Received: by 2002:a50:fe86:0:b0:48c:bd9b:1fa4 with SMTP id d6-20020a50fe86000000b0048cbd9b1fa4mr25824649edt.10.1673099818466;
        Sat, 07 Jan 2023 05:56:58 -0800 (PST)
Received: from titov.fritz.box ([45.88.97.217])
        by smtp.gmail.com with ESMTPSA id m2-20020a509302000000b0046892e493dcsm1526246eda.26.2023.01.07.05.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 05:56:57 -0800 (PST)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] *: fix typos which duplicate a word
Date:   Sat,  7 Jan 2023 14:56:55 +0100
Message-Id: <20230107135655.149892-1-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <CAPig+cTgUPWxMox_nSka52dML6_GHUUoY4HCtcq7+7J0oEyeNw@mail.gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix typos in code comments which repeat various words.  Most of the
cases are simple in that they repeat a word that usually cannot be
repeated in a grammatically correct sentence.  Just remove the
incorrectly duplicated word in these cases and rewrap text, if needed.

A tricky case is usage of "that that", which is sometimes grammatically
correct.  However, an instance of this in "t7527-builtin-fsmonitor.sh"
doesn't need two words "that", because there is only one daemon being
discussed, so replace the second "that" with "the".

Reword code comment "entries exist on on-disk index" in function
update_one in file cache-tree.c, by replacing incorrect preposition "on"
with "in".

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---

On 2023-01-06T23:37, Junio C Hamano wrote:
>> A tricky case is usage of "that that", which is sometimes grammatically
>> correct.  However, an instance of this in "t7527-builtin-fsmonitor.sh"
>> doesn't need two words "that", because there is only one daemon being
>> discussed, so the word "daemon" does not need a determiner.
> 
> Makes me wonder if it is more appropriage to replace the second
> "that" with "the" there, then.

On 2023-01-06T19:25, Eric Sunshine wrote:
> But...
> 
>> ---
>> diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
>> @@ -922,7 +922,7 @@ test_expect_success CASE_INSENSITIVE_FS 'case insensitive+preserving' '
>> -       # Rename .git using an alternate spelling to verify that that
>> +       # Rename .git using an alternate spelling to verify that
>>          # daemon detects it and automatically shuts down.
>>          mv test_insensitive/.GIT test_insensitive/.FOO &&
> 
> ... this doesn't read as well following the change. It would read well
> if you changed it to "that the".

Here's a v2 with "that the" and a corresponding update to the commit message.

> Not related to your patch at all, but I notice in this test that the
> call to test_when_finished() is commented out:
> 
>      # test_when_finished "stop_daemon_delete_repo test_insensitive" &&
> 
> which makes me wonder if it was commented out while the test was being
> debugged but then forgotten, and that the script is now potentially
> leaking a running daemon if something in the test fails after the
> daemon was started, or if the daemon does not shut down on its own as
> it's supposed to do. [cc:+Jeff Hostetler]

After looking at this and other places from:

    $ git grep -P '^\s*#\s*test_' -- 't/t[0-9]*'

it seems that e.g. "#test_expect_success" in t/t9200-git-cvsexportcommit.sh,
could be replaced with test_expect_failure.  There are also more complicated
cases like t/t6003-rev-list-topo-order.sh, where a helper function
"#test_output_expect_success" from t/lib-t6000.sh is commented out, so a
corresponding `test_output_expect_failure` will be needed to uncomment the test.

 Documentation/gitprotocol-v2.txt | 2 +-
 builtin/checkout.c               | 2 +-
 builtin/submodule--helper.c      | 5 ++---
 cache-tree.c                     | 2 +-
 config.c                         | 2 +-
 run-command.c                    | 2 +-
 t/t4301-merge-tree-write-tree.sh | 4 ++--
 t/t6421-merge-partial-clone.sh   | 4 ++--
 t/t7527-builtin-fsmonitor.sh     | 6 +++---
 9 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/Documentation/gitprotocol-v2.txt b/Documentation/gitprotocol-v2.txt
index 10bd2d40ce..acb97ad0c2 100644
--- a/Documentation/gitprotocol-v2.txt
+++ b/Documentation/gitprotocol-v2.txt
@@ -665,7 +665,7 @@ headers and their prerequisite relationships, or something else.
 +
 Server operators should feel confident in turning on "bundle-uri" and
 not worry if e.g. their CDN goes down that clones or fetches will run
-into hard failures. Even if the server bundle bundle(s) are
+into hard failures. Even if the server bundle(s) are
 incomplete, or bad in some way the client should still end up with a
 functioning repository, just as if it had chosen not to use this
 protocol extension.
diff --git a/builtin/checkout.c b/builtin/checkout.c
index cd04f0bf57..5963e1b74b 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1270,7 +1270,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 	 *       between A and B, A...B names that merge base.
 	 *
 	 *   (b) If <something> is _not_ a commit, either "--" is present
-	 *       or <something> is not a path, no -t or -b was given, and
+	 *       or <something> is not a path, no -t or -b was given,
 	 *       and there is a tracking branch whose name is <something>
 	 *       in one and only one remote (or if the branch exists on the
 	 *       remote named in checkout.defaultRemote), then this is a
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 450680fc70..4c173d8b37 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3219,9 +3219,8 @@ static void die_on_index_match(const char *path, int force)
 		ensure_full_index(&the_index);
 
 		/*
-		 * Since there is only one pathspec, we just need
-		 * need to check ps_matched[0] to know if a cache
-		 * entry matched.
+		 * Since there is only one pathspec, we just need to
+		 * check ps_matched[0] to know if a cache entry matched.
 		 */
 		for (i = 0; i < the_index.cache_nr; i++) {
 			ce_path_match(&the_index, the_index.cache[i], &ps,
diff --git a/cache-tree.c b/cache-tree.c
index c97111cccf..9af457f47c 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -405,7 +405,7 @@ static int update_one(struct cache_tree *it,
 		}
 
 		/*
-		 * CE_INTENT_TO_ADD entries exist on on-disk index but
+		 * CE_INTENT_TO_ADD entries exist in on-disk index but
 		 * they are not part of generated trees. Invalidate up
 		 * to root to force cache-tree users to read elsewhere.
 		 */
diff --git a/config.c b/config.c
index 27f38283ad..00090a32fc 100644
--- a/config.c
+++ b/config.c
@@ -3154,7 +3154,7 @@ int git_config_set_gently(const char *key, const char *value)
 int repo_config_set_worktree_gently(struct repository *r,
 				    const char *key, const char *value)
 {
-	/* Only use worktree-specific config if it is is already enabled. */
+	/* Only use worktree-specific config if it is already enabled. */
 	if (repository_format_worktree_config) {
 		char *file = repo_git_path(r, "config.worktree");
 		int ret = git_config_set_multivar_in_file_gently(
diff --git a/run-command.c b/run-command.c
index 756f1839aa..50cc011654 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1853,7 +1853,7 @@ enum start_bg_result start_bg_command(struct child_process *cmd,
 		 *
 		 * We also assume that `start_command()` does not add
 		 * us to the cleanup list.  And that it calls
-		 * calls `child_process_clear()`.
+		 * `child_process_clear()`.
 		 */
 		sbgr = SBGR_ERROR;
 		goto done;
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index a8983a0edc..250f721795 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -141,7 +141,7 @@ test_expect_success 'test conflict notices and such' '
 #   Commit O: foo, olddir/{a,b,c}
 #   Commit A: modify foo, newdir/{a,b,c}
 #   Commit B: modify foo differently & rename foo -> olddir/bar
-#   Expected: CONFLICT(content) for for newdir/bar (not olddir/bar or foo)
+#   Expected: CONFLICT(content) for newdir/bar (not olddir/bar or foo)
 
 test_expect_success 'directory rename + content conflict' '
 	# Setup
@@ -653,7 +653,7 @@ test_expect_success 'mod6: chains of rename/rename(1to2) and add/add via collidi
 #   Commit O: foo, olddir/{a,b,c}
 #   Commit A: delete foo, rename olddir/ -> newdir/, add newdir/bar/file
 #   Commit B: modify foo & rename foo -> olddir/bar
-#   Expected: CONFLICT(content) for for newdir/bar (not olddir/bar or foo)
+#   Expected: CONFLICT(content) for newdir/bar (not olddir/bar or foo)
 
 test_expect_success 'directory rename + rename/delete + modify/delete + directory/file conflict' '
 	# Setup
diff --git a/t/t6421-merge-partial-clone.sh b/t/t6421-merge-partial-clone.sh
index 5413e5dd9d..711b709e75 100755
--- a/t/t6421-merge-partial-clone.sh
+++ b/t/t6421-merge-partial-clone.sh
@@ -155,7 +155,7 @@ test_setup_repo () {
 #   Commit A:
 #     (Rename leap->jump, rename basename/ -> basename/subdir/, rename dir/
 #      -> folder/, move e into newsubdir, add newfile.rs, remove f, modify
-#      both both Makefiles and jumps)
+#      both Makefiles and jumps)
 #              general/{jump1_A, jump2_A}
 #              basename/subdir/{numbers_A, sequence_A, values_A}
 #              folder/subdir/{a,b,c,d,Makefile_TOP_A}
@@ -343,7 +343,7 @@ test_expect_merge_algorithm failure success 'Objects downloaded when a directory
 #   Commit A:
 #     (Rename leap->jump, rename basename/ -> basename/subdir/, rename dir/
 #      -> folder/, move e into newsubdir, add newfile.rs, remove f, modify
-#      both both Makefiles and jumps)
+#      both Makefiles and jumps)
 #              general/{jump1_A, jump2_A}
 #              basename/subdir/{numbers_A, sequence_A, values_A}
 #              folder/subdir/{a,b,c,d,Makefile_TOP_A}
diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index 76d0220daa..c2582d44a6 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -904,7 +904,7 @@ test_expect_success "submodule absorbgitdirs implicitly starts daemon" '
 
 # On a case-insensitive file system, confirm that the daemon
 # notices when the .git directory is moved/renamed/deleted
-# regardless of how it is spelled in the the FS event.
+# regardless of how it is spelled in the FS event.
 # That is, does the FS event receive the spelling of the
 # operation or does it receive the spelling preserved with
 # the file/directory.
@@ -922,8 +922,8 @@ test_expect_success CASE_INSENSITIVE_FS 'case insensitive+preserving' '
 	test_path_is_dir test_insensitive/.git &&
 	test_path_is_dir test_insensitive/.GIT &&
 
-	# Rename .git using an alternate spelling to verify that that
-	# daemon detects it and automatically shuts down.
+	# Rename .git using an alternate spelling to verify that
+	# the daemon detects it and automatically shuts down.
 	mv test_insensitive/.GIT test_insensitive/.FOO &&
 
 	# See [1] above.
-- 
2.38.1

