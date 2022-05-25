Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E91AC433EF
	for <git@archiver.kernel.org>; Wed, 25 May 2022 15:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiEYPCZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 11:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237514AbiEYPBb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 11:01:31 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967BCAF31B
        for <git@vger.kernel.org>; Wed, 25 May 2022 08:01:30 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id p10so11874924wrg.12
        for <git@vger.kernel.org>; Wed, 25 May 2022 08:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yAYOyrQ7lGddulrPeFKr0D/52H8sH3I2rvMs5wugd2A=;
        b=hAExHOMPMEp8S/ZX98vqf/GkoeMHfZdbcJByy0yNQuRry5mHaONs9cwIxrFgyVcDb9
         hoQsdeDy911iB1KBC+seJxXXq/It0+t9AVEDuyDWMCHt2ZgVFmk5PkxCN+KylMmQc7Wh
         qbIKyX0QqEAqwLkMhzv1MZRNUyVT+dvRsOyZcvxVMUBbT5UH1XAs0ZP0V5O4LNrreerF
         /VOhudhpINufcmy/iNdVR/3AC5v8wOQ7Mi/YyV2XHuEb++xL1myBUEmEy1qd8b8sMhtN
         0xMn4kegr6hX2b53Xlqdtsos2P7/R0hoUbi+DEPiIcS5nF4FQA4hEnvt/h7WXCtk4hut
         0QNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yAYOyrQ7lGddulrPeFKr0D/52H8sH3I2rvMs5wugd2A=;
        b=lYXbyskLMagphYZ/W1nGLRiLbCqz4mMt+EyEKb3miXd3/bnU7IsT5Jmmfs2JlATuwD
         zvT7Z3+UlNs587T29ZV4ABono5Vy2xztZijlzJJBfk70kahVzzu8c99bx7tyZ0diLYsA
         DhS3MeaOab4106oJ+WJHjGPxfvsRvqnluf3aDi1dLW3dVQCpHAOqtISO9/ddV8eYXnxp
         c1lhKt3HqWjpqh7MChoWd2uKGBH5WIFGtjCqdap5bE8LIXZ5HaYNYSD0R1uwF+rNUBVi
         mPPfVoYiqZyKQsp7c9T/WjUV3pekFEg9bXvZoSauVmCWq2Oi2HG5/cbYPOr1FgYEz96k
         ZQRQ==
X-Gm-Message-State: AOAM530wC+5LkLKzyFS3CpuN0+EwIvaIUQnMLzwo3/kgjK9XVNWV38KX
        0e2vVxLdRizbW3LZ/sC0xlnWrrDMQvE=
X-Google-Smtp-Source: ABdhPJzouX8eII1r0fsLXMAnAQypEYGUHu7nJXusXd//Faa1+YybUuvsf/4+TIACBlP/qGTr01gUow==
X-Received: by 2002:adf:e710:0:b0:210:347:8dd4 with SMTP id c16-20020adfe710000000b0021003478dd4mr1804923wrm.295.1653490889471;
        Wed, 25 May 2022 08:01:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j20-20020a5d6e54000000b0020e5d8dbbb8sm2412755wrz.56.2022.05.25.08.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 08:01:28 -0700 (PDT)
Message-Id: <92f5c0d2c8b1a69aec4325ab35193fe257d481f1.1653490853.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
References: <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
        <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 May 2022 15:00:45 +0000
Subject: [PATCH v8 23/30] fsmonitor: never set CE_FSMONITOR_VALID on
 submodules
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Never set CE_FSMONITOR_VALID on the cache-entry of submodule
directories.

During a client command like 'git status', we may need to recurse
into each submodule to compute a status summary for the submodule.
Since the purpose of the ce_flag is to let Git avoid scanning a
cache-entry, setting the flag causes the recursive call to be
avoided and we report incorrect (no status) for the submodule.

We created an OS watch on the root directory of our working
directory and we receive events for everything in the cone
under it.  When submodules are present inside our working
directory, we receive events for both our repo (the super) and
any subs within it.  Since our index doesn't have any information
for items within the submodules, we can't use those events.

We could try to truncate the paths of those events back to the
submodule boundary and mark the GITLINK as dirty, but that
feels expensive since we would have to prefix compare every FS
event that we receive against a list of submodule roots.  And
it still wouldn't be sufficient to correctly report status on
the submodule, since we don't have any space in the cache-entry
to cache the submodule's status (the 'SCMU' bits in porcelain
V2 speak).  That is, the CE_FSMONITOR_VALID bit just says that
we don't need to scan/inspect it because we already know the
answer -- it doesn't say that the item is clean -- and we
don't have space in the cache-entry to store those answers.
So we should always do the recursive scan.

Therefore, we should never set the flag on GITLINK cache-entries.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 fsmonitor.c                  |   2 +
 fsmonitor.h                  |  11 ++++
 t/t7527-builtin-fsmonitor.sh | 111 +++++++++++++++++++++++++++++++++++
 3 files changed, 124 insertions(+)

diff --git a/fsmonitor.c b/fsmonitor.c
index e1229c289cf..57d6a483bee 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -580,6 +580,8 @@ void tweak_fsmonitor(struct index_state *istate)
 		if (fsmonitor_enabled) {
 			/* Mark all entries valid */
 			for (i = 0; i < istate->cache_nr; i++) {
+				if (S_ISGITLINK(istate->cache[i]->ce_mode))
+					continue;
 				istate->cache[i]->ce_flags |= CE_FSMONITOR_VALID;
 			}
 
diff --git a/fsmonitor.h b/fsmonitor.h
index 3f41f653691..edf7ce5203b 100644
--- a/fsmonitor.h
+++ b/fsmonitor.h
@@ -68,6 +68,15 @@ static inline int is_fsmonitor_refreshed(const struct index_state *istate)
  * Set the given cache entries CE_FSMONITOR_VALID bit. This should be
  * called any time the cache entry has been updated to reflect the
  * current state of the file on disk.
+ *
+ * However, never mark submodules as valid.  When commands like "git
+ * status" run they might need to recurse into the submodule (using a
+ * child process) to get a summary of the submodule state.  We don't
+ * have (and don't want to create) the facility to translate every
+ * FS event that we receive and that happens to be deep inside of a
+ * submodule back to the submodule root, so we cannot correctly keep
+ * track of this bit on the gitlink directory.  Therefore, we never
+ * set it on submodules.
  */
 static inline void mark_fsmonitor_valid(struct index_state *istate, struct cache_entry *ce)
 {
@@ -75,6 +84,8 @@ static inline void mark_fsmonitor_valid(struct index_state *istate, struct cache
 
 	if (fsm_mode > FSMONITOR_MODE_DISABLED &&
 	    !(ce->ce_flags & CE_FSMONITOR_VALID)) {
+		if (S_ISGITLINK(ce->ce_mode))
+			return;
 		istate->cache_changed = 1;
 		ce->ce_flags |= CE_FSMONITOR_VALID;
 		trace_printf_key(&trace_fsmonitor, "mark_fsmonitor_clean '%s'", ce->name);
diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index 3bc335b891d..cf4fb72c3f0 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -721,4 +721,115 @@ do
 	'
 done
 
+# Test fsmonitor interaction with submodules.
+#
+# If we start the daemon in the super, it will see FS events for
+# everything in the working directory cone and this includes any
+# files/directories contained *within* the submodules.
+#
+# A `git status` at top level will get events for items within the
+# submodule and ignore them, since they aren't named in the index
+# of the super repo.  This makes the fsmonitor response a little
+# noisy, but it doesn't alter the correctness of the state of the
+# super-proper.
+#
+# When we have submodules, `git status` normally does a recursive
+# status on each of the submodules and adds a summary row for any
+# dirty submodules.  (See the "S..." bits in porcelain V2 output.)
+#
+# It is therefore important that the top level status not be tricked
+# by the FSMonitor response to skip those recursive calls.  That is,
+# even if FSMonitor says that the mtime of the submodule directory
+# hasn't changed and it could be implicitly marked valid, we must
+# not take that shortcut.  We need to force the recusion into the
+# submodule so that we get a summary of the status *within* the
+# submodule.
+
+create_super () {
+	super="$1" &&
+
+	git init "$super" &&
+	echo x >"$super/file_1" &&
+	echo y >"$super/file_2" &&
+	echo z >"$super/file_3" &&
+	mkdir "$super/dir_1" &&
+	echo a >"$super/dir_1/file_11" &&
+	echo b >"$super/dir_1/file_12" &&
+	mkdir "$super/dir_1/dir_2" &&
+	echo a >"$super/dir_1/dir_2/file_21" &&
+	echo b >"$super/dir_1/dir_2/file_22" &&
+	git -C "$super" add . &&
+	git -C "$super" commit -m "initial $super commit"
+}
+
+create_sub () {
+	sub="$1" &&
+
+	git init "$sub" &&
+	echo x >"$sub/file_x" &&
+	echo y >"$sub/file_y" &&
+	echo z >"$sub/file_z" &&
+	mkdir "$sub/dir_x" &&
+	echo a >"$sub/dir_x/file_a" &&
+	echo b >"$sub/dir_x/file_b" &&
+	mkdir "$sub/dir_x/dir_y" &&
+	echo a >"$sub/dir_x/dir_y/file_a" &&
+	echo b >"$sub/dir_x/dir_y/file_b" &&
+	git -C "$sub" add . &&
+	git -C "$sub" commit -m "initial $sub commit"
+}
+
+my_match_and_clean () {
+	git -C super --no-optional-locks status --porcelain=v2 >actual.with &&
+	git -C super --no-optional-locks -c core.fsmonitor=false \
+		status --porcelain=v2 >actual.without &&
+	test_cmp actual.with actual.without &&
+
+	git -C super/dir_1/dir_2/sub reset --hard &&
+	git -C super/dir_1/dir_2/sub clean -d -f
+}
+
+test_expect_success 'submodule always visited' '
+	test_when_finished "git -C super fsmonitor--daemon stop; \
+			    rm -rf super; \
+			    rm -rf sub" &&
+
+	create_super super &&
+	create_sub sub &&
+
+	git -C super submodule add ../sub ./dir_1/dir_2/sub &&
+	git -C super commit -m "add sub" &&
+
+	start_daemon -C super &&
+	git -C super config core.fsmonitor true &&
+	git -C super update-index --fsmonitor &&
+	git -C super status &&
+
+	# Now run pairs of commands w/ and w/o FSMonitor while we make
+	# some dirt in the submodule and confirm matching output.
+
+	# Completely clean status.
+	my_match_and_clean &&
+
+	# .M S..U
+	echo z >super/dir_1/dir_2/sub/dir_x/dir_y/foobar_u &&
+	my_match_and_clean &&
+
+	# .M S.M.
+	echo z >super/dir_1/dir_2/sub/dir_x/dir_y/foobar_m &&
+	git -C super/dir_1/dir_2/sub add . &&
+	my_match_and_clean &&
+
+	# .M S.M.
+	echo z >>super/dir_1/dir_2/sub/dir_x/dir_y/file_a &&
+	git -C super/dir_1/dir_2/sub add . &&
+	my_match_and_clean &&
+
+	# .M SC..
+	echo z >>super/dir_1/dir_2/sub/dir_x/dir_y/file_a &&
+	git -C super/dir_1/dir_2/sub add . &&
+	git -C super/dir_1/dir_2/sub commit -m "SC.." &&
+	my_match_and_clean
+'
+
 test_done
-- 
gitgitgadget

