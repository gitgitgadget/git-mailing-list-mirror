Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601B1C433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 16:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351972AbiCXQyD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 12:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351926AbiCXQx0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 12:53:26 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715CCB0A4B
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:51:54 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id m30so7513181wrb.1
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Xw77Y/zPhZ3GMHiijbMihSDlxzaRnZcra98dUmPkBvE=;
        b=VA8VjU9SCPHPzaJWjfYPpBZLy9sZ0ylCkeRUMpIOnZ+O2nNXK4VHJk/X3QBd/EOfHM
         jS9EIU6s6zDMtuEuib8nDA1x2BJmQWruiGy70mtFGBnGj+kbm7ZObzCF9LWy0IItm2uZ
         BY6yp4vNJaB3IQpeEOMlUrbNg8DOMoJ3QELHyNs5M8EYZrQQ/Y0KITBruM7sGkS2u89z
         PwSFMU9rNtGYQ7u4VvbvE+YJ7mA8wGHFsEvrpKk/9yfLy4nNKRqm2Zv3MeNQie29IU2G
         8M0yfcWGR2orSc5Qo5EWagZrhjhjmz7a3uuFCndHXDUUCJ7KW6WSQrkCNi/otGtkptqs
         ZwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Xw77Y/zPhZ3GMHiijbMihSDlxzaRnZcra98dUmPkBvE=;
        b=NkTQfgZ23tdVlGSbugYeVIW6KMIj+klAxm0C0qsdPwwvyO5VY3aWC6v56ltKQw3MXp
         s/t1tpwmRzFam8gOfbYg8qGaRch4QjIkRLZo1ztNYdxGKcGgLzJwRpFRe3+blDGOue2b
         P1NA53GEr+U6dfes/+8gHTAp5VbvfI+L80UdmAaQmuhbzoU0Wfo3wWOyTjtSRPtEIfPt
         lnZ/xKfd5VLxBRZUnj6urjRFc82sD7gsCis86HhBSyDz0/xcpd2ewM/2pcDn39D/jBWX
         u+/gzKmC97ukLhJ2NI9ywlUFykmYSvSm77BaALzOv4btl+cxCTwm1zSjkKDeI/M7DUy1
         dl2w==
X-Gm-Message-State: AOAM5311ETxW8k2BuBQj9Q7sa0h1sYjzf+k5FkcbCl/HcLKCBnHwqBT8
        idB9xpq35bO2cA2pGMidRfuYAbSc5aQ=
X-Google-Smtp-Source: ABdhPJwhOyTCWrHxbsFlU6LrXGfyw7CT/w2rCO1iBtApdaKQnGWavFSBv6Jag2t5eWhKz5vEtVtVsA==
X-Received: by 2002:a05:6000:1541:b0:204:18a5:5195 with SMTP id 1-20020a056000154100b0020418a55195mr5280585wry.148.1648140712571;
        Thu, 24 Mar 2022 09:51:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n8-20020a5d5988000000b00203d5f1f3e4sm3231913wri.105.2022.03.24.09.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 09:51:51 -0700 (PDT)
Message-Id: <29063455c8399e8226795c6ff609cff3c0ac96f3.1648140680.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
References: <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
        <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Mar 2022 16:51:16 +0000
Subject: [PATCH v4 23/27] fsmonitor: never set CE_FSMONITOR_VALID on
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
        rsbecker@nexbridge.com, Jeff Hostetler <jeffhost@microsoft.com>,
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
 fsmonitor.c                  |  2 +
 fsmonitor.h                  | 11 +++++
 t/t7527-builtin-fsmonitor.sh | 93 ++++++++++++++++++++++++++++++++++++
 3 files changed, 106 insertions(+)

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
index 3f794fb9821..7de178a9bf8 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -732,4 +732,97 @@ do
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
+# by the FSMonitor response to skip those recursive calls.
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
+test_expect_success "Submodule" '
+	test_when_finished "git -C super fsmonitor--daemon stop" &&
+
+	git init "super" &&
+	echo x >super/file_1 &&
+	echo y >super/file_2 &&
+	echo z >super/file_3 &&
+	mkdir super/dir_1 &&
+	echo a >super/dir_1/file_11 &&
+	echo b >super/dir_1/file_12 &&
+	mkdir super/dir_1/dir_2 &&
+	echo a >super/dir_1/dir_2/file_21 &&
+	echo b >super/dir_1/dir_2/file_22 &&
+	git -C super add . &&
+	git -C super commit -m "initial super commit" &&
+
+	git init "sub" &&
+	echo x >sub/file_x &&
+	echo y >sub/file_y &&
+	echo z >sub/file_z &&
+	mkdir sub/dir_x &&
+	echo a >sub/dir_x/file_a &&
+	echo b >sub/dir_x/file_b &&
+	mkdir sub/dir_x/dir_y &&
+	echo a >sub/dir_x/dir_y/file_a &&
+	echo b >sub/dir_x/dir_y/file_b &&
+	git -C sub add . &&
+	git -C sub commit -m "initial sub commit" &&
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

