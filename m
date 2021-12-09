Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F1CC433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 05:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhLIFMU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 00:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhLIFMP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 00:12:15 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B16C0617A1
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 21:08:41 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso5675786wml.1
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 21:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=g7RnDxkiEqqyUYSQPAELJjlZcXcMucqB/lErm05XjVs=;
        b=N2WOakEgQP0petfVgJuCmZvJy4qaWP/8zeECTfjm+a+XnZ1tKtiLBxkyb+PQXVHA/4
         5MuUpG+pqr3aqYDUt0wtu/6oOgOZmgNSQ4PHlTzg2bg4f5CYS2aKLiQsJL/haWetNToa
         PAWEq4eWMXoF27wWZHRuxfV3ChSqqwjqx6LxYuBJxs1tvf7X1qS/idpRBNcgTw+yo3Qx
         Hs0n8+VYXg7somrdqshwfJz9wXPprti6GWvlRMNsHzMo1My0uXVtsUJcPq5crPECzPYm
         hVpgwUWWDT/luPJ2YvgN9YGoT/24lVA+SJL6jkk6GN8XKoKNShlUGo9J9vHI7uDkGSYR
         LUhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=g7RnDxkiEqqyUYSQPAELJjlZcXcMucqB/lErm05XjVs=;
        b=39vmp/+7vimNrlGMD2zL5+q/1BLCo5IcJE48q8UOLC/e3SszwaECb+ZbKCfKVvqMhH
         psqqZsdBef855ft/dftp8rntRB01irUxk3K2JrJX4hubpm2ExSXzw/ExcJzv1Qfv1mvy
         6AuEYPzMcKCVLCcmG2XDYOwz7dIZfUVSMADAvbCV+S1EyGEOu33DwYotw22zrQJYoOpb
         gxEpOi4WyqbyQWMgnGuyEH9XhhGvikwT9kH1aWijjrA3pN0X9gbQqda9+NNac34gd4aV
         t5UG0L+hUG6DPBpQrEGSdDsCtq2RQl+mdLzL3JxiF8uwQgl3BhQdmfXjDAbvjk3v/Wk+
         I2vg==
X-Gm-Message-State: AOAM532iKH7fwYl3zleWtxlQLmmJ5fqy/t1ANG65FJtUYykNvCFfRvw2
        Cc8BvqYY2iAv6U4Tn5+wUQefuJCIQnI=
X-Google-Smtp-Source: ABdhPJyPzmb+8gyc7mWbxHoDxI2SuttD6qKNFWsVUM9avTnj0lo9LHypqmZhV2ny2DqeF3zF6wBDHA==
X-Received: by 2002:a05:600c:1d91:: with SMTP id p17mr4143525wms.193.1639026520201;
        Wed, 08 Dec 2021 21:08:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j40sm7505550wms.19.2021.12.08.21.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 21:08:39 -0800 (PST)
Message-Id: <4a1f62b662c7cc1429d67bef3b6b3db02427db0b.1639026515.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.v6.git.git.1639026515.gitgitgadget@gmail.com>
References: <pull.1140.v5.git.git.1638340854.gitgitgadget@gmail.com>
        <pull.1140.v6.git.git.1639026515.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Dec 2021 05:08:27 +0000
Subject: [PATCH v6 03/11] unpack-trees: refuse to remove
 startup_info->original_cwd
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In the past, when a directory needs to be removed to make room for a
file, we have always errored out when that directory contains any
untracked (but not ignored) files.  Add an extra condition on that: also
error out if the directory is the current working directory we inherited
from our parent process.

Acked-by: Derrick Stolee <stolee@gmail.com>
Acked-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t2501-cwd-empty.sh | 20 +++++++-------------
 unpack-trees.c       | 17 +++++++++++++----
 unpack-trees.h       |  1 +
 3 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/t/t2501-cwd-empty.sh b/t/t2501-cwd-empty.sh
index a05abd18187..398908dfc93 100755
--- a/t/t2501-cwd-empty.sh
+++ b/t/t2501-cwd-empty.sh
@@ -113,7 +113,7 @@ test_expect_success 'checkout does not clean cwd incidentally' '
 '
 
 test_expect_success 'checkout fails if cwd needs to be removed' '
-	test_required_dir_removal failure git checkout fd_conflict
+	test_required_dir_removal success git checkout fd_conflict
 '
 
 test_expect_success 'reset --hard does not clean cwd incidentally' '
@@ -144,23 +144,17 @@ test_expect_success 'merge fails if cwd needs to be removed; recursive friendly'
 	(
 		cd dirORfile &&
 
-		# We would rather this failed, but we test for existing
-		# rather than desired behavior
-		git merge fd_conflict 2>../error
+		test_must_fail git merge fd_conflict 2>../error
 	) &&
 
-	## Here is the behavior we would rather have:
-	#test_path_is_dir dirORfile &&
-	#grep "Refusing to remove the current working directory" error
-	## But instead we test for existing behavior
-	test_path_is_file dirORfile &&
-	test_must_be_empty error
+	test_path_is_dir dirORfile &&
+	grep "Refusing to remove the current working directory" error
 '
 
 GIT_TEST_MERGE_ALGORITHM=ort
 
 test_expect_success 'merge fails if cwd needs to be removed' '
-	test_required_dir_removal failure git merge fd_conflict
+	test_required_dir_removal success git merge fd_conflict
 '
 
 test_expect_success 'cherry-pick does not clean cwd incidentally' '
@@ -168,7 +162,7 @@ test_expect_success 'cherry-pick does not clean cwd incidentally' '
 '
 
 test_expect_success 'cherry-pick fails if cwd needs to be removed' '
-	test_required_dir_removal failure git cherry-pick fd_conflict
+	test_required_dir_removal success git cherry-pick fd_conflict
 '
 
 test_expect_success 'rebase does not clean cwd incidentally' '
@@ -184,7 +178,7 @@ test_expect_success 'revert does not clean cwd incidentally' '
 '
 
 test_expect_success 'revert fails if cwd needs to be removed' '
-	test_required_dir_removal failure git revert undo_fd_conflict
+	test_required_dir_removal success git revert undo_fd_conflict
 '
 
 test_expect_success 'rm does not clean cwd incidentally' '
diff --git a/unpack-trees.c b/unpack-trees.c
index 89ca95ce90b..6bc16f3a714 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -36,6 +36,9 @@ static const char *unpack_plumbing_errors[NB_UNPACK_TREES_WARNING_TYPES] = {
 	/* ERROR_NOT_UPTODATE_DIR */
 	"Updating '%s' would lose untracked files in it",
 
+	/* ERROR_CWD_IN_THE_WAY */
+	"Refusing to remove '%s' since it is the current working directory.",
+
 	/* ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN */
 	"Untracked working tree file '%s' would be overwritten by merge.",
 
@@ -131,6 +134,9 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 	msgs[ERROR_NOT_UPTODATE_DIR] =
 		_("Updating the following directories would lose untracked files in them:\n%s");
 
+	msgs[ERROR_CWD_IN_THE_WAY] =
+		_("Refusing to remove the current working directory:\n%s");
+
 	if (!strcmp(cmd, "checkout"))
 		msg = advice_enabled(ADVICE_COMMIT_BEFORE_MERGE)
 		      ? _("The following untracked working tree files would be removed by checkout:\n%%s"
@@ -2146,10 +2152,7 @@ static int verify_clean_subdirectory(const struct cache_entry *ce,
 		cnt++;
 	}
 
-	/*
-	 * Then we need to make sure that we do not lose a locally
-	 * present file that is not ignored.
-	 */
+	/* Do not lose a locally present file that is not ignored. */
 	pathbuf = xstrfmt("%.*s/", namelen, ce->name);
 
 	memset(&d, 0, sizeof(d));
@@ -2160,6 +2163,12 @@ static int verify_clean_subdirectory(const struct cache_entry *ce,
 	free(pathbuf);
 	if (i)
 		return add_rejected_path(o, ERROR_NOT_UPTODATE_DIR, ce->name);
+
+	/* Do not lose startup_info->original_cwd */
+	if (startup_info->original_cwd &&
+	    !strcmp(startup_info->original_cwd, ce->name))
+		return add_rejected_path(o, ERROR_CWD_IN_THE_WAY, ce->name);
+
 	return cnt;
 }
 
diff --git a/unpack-trees.h b/unpack-trees.h
index 71ffb7eeb0c..efb9edfbb27 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -19,6 +19,7 @@ enum unpack_trees_error_types {
 	ERROR_WOULD_OVERWRITE = 0,
 	ERROR_NOT_UPTODATE_FILE,
 	ERROR_NOT_UPTODATE_DIR,
+	ERROR_CWD_IN_THE_WAY,
 	ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN,
 	ERROR_WOULD_LOSE_UNTRACKED_REMOVED,
 	ERROR_BIND_OVERLAP,
-- 
gitgitgadget

