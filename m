Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D34A13CF9C
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 02:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741834012; cv=none; b=MMUWDqxW2+FKXsl9rn1srfzMcIP+9vmCT08eO/3R1XeNIR0vbpIUPWSFKc1AvozKGih4TQz/VWqIz6IWBE8zTXkqqpgD7iRQ8Qi9Vco7YD3YCJ4yGI8ESgfQDLVhG8wiUfcvgc5+tExvUnVhm/+YpVdwmDbH/RKtJy9DfdIINvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741834012; c=relaxed/simple;
	bh=UUFw6+VUYHBmkpKv70O/p8+k2qGd1MG81EaFBOZNAvI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Y8gaGVpy5TRxH0ekoXoqGo9RANZ5IZkTg2pWnLLfGyBYdPnroljo9Q8kdKZL6ebyEowUt+9T1FjJy/uIqTODKrZWjrXxr+FipCJFhBEZYftAHsocq/ndi8hKGsjs5bQ2xUN5oD/I97ZenBHJH10ahRMFYsRtDmzxboRYK8yDguM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyxmDTDe; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyxmDTDe"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e5e22e6ed2so554490a12.3
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 19:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741834008; x=1742438808; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0L2g553xjOaDOe60VhZzNnI/qTrlgsQ+SYs2p0s4Dvk=;
        b=iyxmDTDeZlQr34FlcEkF9xcymJkp5aj7VePFYolpJ4ZJ3PvAOVt++Hg6UHOGaOlnJh
         K30qa0iqtNzxN9cIhZB124s+SWZATSwKBzmwopV7gnTrZQvO/lkgb7A7D6z7OKMJm4ui
         c8cZWl5fqVnWCdse4I5jBkN4MxhN2IcZCgtbUYOI6abnGKy1VbaSfSUpodXSjl3EZrmy
         P6zOL9UiXHXhx9dXbfnI08caBv9OakyZjPbImSs3T8KnfrwCVZxR7n+3XI43rMDe03Hu
         1IV9ojw3ENF3KmbEWC89I8/JvPxBZVlYiuU74Lk0kGyaP6Ev94uWcEY4Ae8Lq4myoWiJ
         Ppfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741834008; x=1742438808;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0L2g553xjOaDOe60VhZzNnI/qTrlgsQ+SYs2p0s4Dvk=;
        b=BsIy6upPHzRreD9lS/XGzSBu4y039hLt+f/t3ziyhlKrEQV0nL1Ew6VRyoyPGN5djN
         Z4V0fOw0ZwVpQoBWqhlS8zy9ngaQZneUysitpuKQ2TUxFYGuHUQVc6UvIRvOlsPBR/Wf
         x507RuuCgwV1fHOdojuSpoRMiQjIYf7es6mdmr8Ss0wod3yK9VcKx8l/Wmk8cZBVPMOo
         eXa4rC0b+YtHlUpLonvCqPbuvbBTiCvVAXvpampaaSfSFsNlj/Co+Rsj+aTOghiAkxn6
         BB6tdGPMmOX67ajp2lSv8XyoJ2Hk0tciEytGE9uxFUI0HaJ3Q7HLR9WUlIKgQ9QeMF2g
         0eOg==
X-Gm-Message-State: AOJu0YzmMlGWGA6uOeAXr7sKv9RvpxrfCeiiObDvebuLviezqU/VvFWt
	GbzFAPbP7wlR1X+3pVhm1rlTioW9CBG29T/xYlsEl5rWo5wIZpvmyNxrcg==
X-Gm-Gg: ASbGnctf1yjj58uaGL47P+diUXzNxNTrs5SGyai5MKY3as6bEvMNgb4vbpFZ1MUpK6D
	/npzKmIXmRHqLO1KczMKMpxZYXxIsCk0BCUOlBJAa4mK3ewllcOJ0GAlbmmNTxPUwDbRQX5/xKy
	AGZsKvP2IZjspsysjUYmhRZA4f0EbsvSVjoGr6Av00cUJWtlLqn2dL3IWjM+5WF94Iz5BP/2TLJ
	J68ddl8JJiUh2gr5oW9LWy+KZ5MyJjb2cjJuOsB6lw/eJaYmnTERLCu+SxBw2TPzh04cNadReRa
	AfgcMetmTMHY+hzufQ65+eIlpFE1hXdlLSfmh3nyqRHLX2UHiwwUi170
X-Google-Smtp-Source: AGHT+IFeAZ7Dznnq5mJMD1elny6nSaoBSEqziKVW6WOjRPeLa+E7QODVmw8lwnDVXcGJByq7AVlvgQ==
X-Received: by 2002:a05:6402:518a:b0:5e5:437b:74a7 with SMTP id 4fb4d7f45d1cf-5e5e22d915amr27911425a12.8.1741834007875;
        Wed, 12 Mar 2025 19:46:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816ad38f3sm195482a12.63.2025.03.12.19.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 19:46:47 -0700 (PDT)
Message-Id: <3f4b74eb3b934c62edb23b69db7460e3e0b44877.1741834001.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1875.v2.git.1741834001.gitgitgadget@gmail.com>
References: <pull.1875.git.1741362522.gitgitgadget@gmail.com>
	<pull.1875.v2.git.1741834001.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 13 Mar 2025 02:46:41 +0000
Subject: [PATCH v2 6/6] am: switch from merge_recursive_generic() to
 merge_ort_generic()
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Taylor Blau <me@ttaylorr.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

Switch from merge-recursive to merge-ort.  Adjust the following
testcases due to the switch:

* t4151: This test left an untracked file in the way of the merge.
  merge-recursive could only sometimes tell when untracked files were
  in the way, and by the time it discovers others, it has already made
  too many changes to back out of the merge.  So, instead of writing the
  results to e.g. 'file1' it would instead write them to
  'file1~branch1'.  This is confusing for users, because they might not
  notice 'file1~branch1' and accidentally add and commit 'file1'.
  In contrast, merge-ort correctly notices the file in the way before
  making any changes and aborts.  Since this test didn't care about the
  file in the way, just remove it before calling git-am.

* t4255: Usage of merge-ort allows us to change two known failures into
  successes.

* t6427: As noted a few commits ago, the choice of conflict label for
  diff3 markers for the ancestor commit was previously handled by
  merge-recursive.c rather than by callers.  Since that has now changed,
  `git am` needs to specify that label.  Although the previous conflict
  label ("constructed merge base") was already fairly somewhat slanted
  towards `git am`, let's use wording more along the lines of the
  related command-line flag from `git apply` and function involved to
  tie it more closely to `git am`.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/am.c                      | 5 +++--
 t/t4151-am-abort.sh               | 2 +-
 t/t4255-am-submodule.sh           | 1 -
 t/t6427-diff3-conflict-markers.sh | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 2921bb89ef1..3b61bd4c333 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -31,7 +31,7 @@
 #include "preload-index.h"
 #include "sequencer.h"
 #include "revision.h"
-#include "merge-recursive.h"
+#include "merge-ort-wrappers.h"
 #include "log-tree.h"
 #include "notes-utils.h"
 #include "rerere.h"
@@ -1638,12 +1638,13 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 	o.branch1 = "HEAD";
 	their_tree_name = xstrfmt("%.*s", linelen(state->msg), state->msg);
 	o.branch2 = their_tree_name;
+	o.ancestor = "constructed fake ancestor";
 	o.detect_directory_renames = MERGE_DIRECTORY_RENAMES_NONE;
 
 	if (state->quiet)
 		o.verbosity = 0;
 
-	if (merge_recursive_generic(&o, &our_tree, &their_tree, 1, bases, &result)) {
+	if (merge_ort_generic(&o, &our_tree, &their_tree, 1, bases, &result)) {
 		repo_rerere(the_repository, state->allow_rerere_autoupdate);
 		free(their_tree_name);
 		return error(_("Failed to merge in the changes."));
diff --git a/t/t4151-am-abort.sh b/t/t4151-am-abort.sh
index edb38da7010..8e1ecf8a685 100755
--- a/t/t4151-am-abort.sh
+++ b/t/t4151-am-abort.sh
@@ -112,7 +112,7 @@ test_expect_success 'am --abort will keep dirty index intact' '
 test_expect_success 'am -3 stops on conflict on unborn branch' '
 	git checkout -f --orphan orphan &&
 	git reset &&
-	rm -f otherfile-4 &&
+	rm -f file-1 otherfile-4 &&
 	test_must_fail git am -3 0003-*.patch &&
 	test 2 -eq $(git ls-files -u | wc -l) &&
 	test 4 = "$(cat otherfile-4)"
diff --git a/t/t4255-am-submodule.sh b/t/t4255-am-submodule.sh
index a7ba08f728c..e6679a01b44 100755
--- a/t/t4255-am-submodule.sh
+++ b/t/t4255-am-submodule.sh
@@ -19,7 +19,6 @@ am_3way () {
 	$2 git am --3way patch
 }
 
-KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
 test_submodule_switch_func "am_3way"
 
 test_expect_success 'setup diff.submodule' '
diff --git a/t/t6427-diff3-conflict-markers.sh b/t/t6427-diff3-conflict-markers.sh
index dd5fe6a4021..57569c4f4bd 100755
--- a/t/t6427-diff3-conflict-markers.sh
+++ b/t/t6427-diff3-conflict-markers.sh
@@ -207,7 +207,7 @@ test_expect_success 'rebase --apply describes fake ancestor base' '
 		cd rebase &&
 		git rebase --abort &&
 		test_must_fail git -c merge.conflictstyle=diff3 rebase --apply main &&
-		grep "||||||| constructed merge base" file
+		grep "||||||| constructed fake ancestor" file
 	)
 '
 
-- 
gitgitgadget
