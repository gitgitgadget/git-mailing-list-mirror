Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34083AA1BD
	for <git@vger.kernel.org>; Sat, 13 Jun 2026 09:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781342197; cv=none; b=iY2Ywwa+6Pf6BWOpbhlncLtLVWtATfahO9gQqd4cZbC5rorCACGAp1V1olW3x47aBbsar5VQewIelrz30qZkvZmgWJbSeXh5MMYgjPZCiffODxPmvIX8wFWHfCLtTbqLEXqIQovAx79KNnppwmC4XE72V49F+a4/+GYFwbTQBkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781342197; c=relaxed/simple;
	bh=tUX2orAStOb1dK8CKySe604NKX12JLczbYeP2Z59Nq8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=URCbZiUQnyn2yNGJvZTzFiP8pkEv+cZ7gbBusZwHdIjeoyewkowV9NgHZMlNZap7zU1TrhH9yn9LPrUj7ASVpqJyHw7RNI7wujMhYwDVikZKYPkSvMz3UejQbZGlIe+OiVFjjJXMgxxLiAJn8djRJ50lb4d3B04CBLUo2b7VJEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EB12LN9z; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EB12LN9z"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5177945a279so19151011cf.0
        for <git@vger.kernel.org>; Sat, 13 Jun 2026 02:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781342194; x=1781946994; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hGxbjkRBvWdqnIUkYBgR7kJADReuG4xppjv8bVtUvZ8=;
        b=EB12LN9zFtGM4uNZWcFDsPRHqaKKhUO07gW3FBa8A2+qr8Uu840NoEG9pwuGhKoj8v
         SHbqQImGqLkFQYdC+T+Zuo7hNC/UGTy7p3hH7JqsISl+JMvOJmEPvDKU4gkM+NtBiR2A
         pMHfhCbaM5/2S6O2DJM3y6Vmhl+tHg97FXgUfIE353xCnSGIX10N0i+CW6PAdV5UirDl
         /ChL2P7fV/unz3mgflp5+CAlk/XvH6fXGorzT4oyNVsX4GMeWwb/8MWfc+0cZkKMozUg
         +6CcH5ID1E5LVPTMlAkKsculRVD3g+1NW84jPKAfK7T+etPgtL8LBZmtbelS/I+JywjI
         DhWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781342194; x=1781946994;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hGxbjkRBvWdqnIUkYBgR7kJADReuG4xppjv8bVtUvZ8=;
        b=qom7boT7smsemrW2ARzTLD9D4IFIESQ0BEy72vcUYt3yJgY0v643iZr27UkLEH7ZEU
         0+0vbCSeKPB7PC9BOfHnYYongUUYDUL5bREsE3cbJMWxSDBD3tidkAKPZyk0rlkKnEbw
         LS8uBrskUP0+JAuVRcGGaifrg3xuKvLMCY1kmu3vOk54ppoVP3SAiNJqDopMkfSMvqWw
         ysj0A+KuDYvUde9Wy6pMEAY96aRt+nSPnyLZaIonrLTpNw9HIjSZ1wuh3IpxVn8CpAGv
         USmaR4n8xlNntbXBoVtjHOXxvmIeu9smKoDuRld/1VTI+1VdbjqNf3mElXXP/bi2uieP
         LbKA==
X-Gm-Message-State: AOJu0YyymKVayo0QT0Efo0PWKxW7xJUo3Ia8ImMBAWw91dQzs7t/IaoC
	i+k6HB8sDX/KjVICpfkhLwv2xSrzEpirEQAfaqWoR7vonv6ay9/WLxU7pxybiA==
X-Gm-Gg: Acq92OENNjlUkye8Ao/qmm8l1+zejBUf6m7bqb76G648prApjtrGlFVNWX5lv/1GYeC
	ZiBEtBk5cvZ+mYPdnK6wB3KKF4mfF65b8jMpFWad7LibCLA1gUVZ2aWDUp/rit5+TgWXIs0UEOD
	tM6uB+LCdwigHRZ6D60ymWrPr9AC0FE+G26hoZ7RIrmCDqzqfmnFxRA3hKusVnZ3dcd/u0yxnJz
	z9KMQvXZgfhvfErXj1JfOkgE7+E/C8EVFcG4Ch5eGwJdwE2V+4/iP9gXx9sECvfVZ3POewgraIl
	5e6E/F8tavxAgNe+17K8BYyJIwOWO5h2c4fRHdZUfBERRufV6kjvQLSTuOCX0ov40hoV+Gl8coH
	tJ5X9HQw1Y/0RVHfSStKRHXF7qGHNBQDV1SU+NvxdA/KRAqozs80YifEKl05LmnBZyB9QKD81lg
	ilrlXijvAAf5h2rt9qDmYYzarwys8=
X-Received: by 2002:a05:622a:13d3:b0:517:75d8:b956 with SMTP id d75a77b69052e-517fe601cd9mr92542211cf.40.1781342194463;
        Sat, 13 Jun 2026 02:16:34 -0700 (PDT)
Received: from [127.0.0.1] ([20.102.134.103])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb79c5absm43251441cf.18.2026.06.13.02.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 02:16:33 -0700 (PDT)
Message-Id: <44be2f98d62d73a690c295c9b3c782aa9cebb0e8.1781342189.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2334.git.git.1781342189.gitgitgadget@gmail.com>
References: <pull.2334.git.git.1781342189.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 13 Jun 2026 09:16:29 +0000
Subject: [PATCH 2/2] commit: keep the commit on a no-op amend
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

"git commit --amend --no-edit" reset the committer date to "now" and
rewrote the commit even when nothing else changed, moving the branch tip
to a new hash for an effective no-op.

Build the amended commit reusing the existing committer date: if that
reproduces the current commit, leave the branch alone, report "nothing
to amend", and skip the reflog entry and the post-commit and post-rewrite
hooks.

Signing always rewrites the commit, since its signature cannot reproduce
the original, so it skips this detection.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-commit.adoc         |   6 ++
 builtin/commit.c                      |  56 ++++++++++++
 t/t7501-commit-basic-functionality.sh | 119 ++++++++++++++++++++++++++
 3 files changed, 181 insertions(+)

diff --git a/Documentation/git-commit.adoc b/Documentation/git-commit.adoc
index 8329c1034b..c433c60929 100644
--- a/Documentation/git-commit.adoc
+++ b/Documentation/git-commit.adoc
@@ -282,6 +282,12 @@ variable (see linkgit:git-config[1]).
 	parents and author as the current one (the `--reset-author`
 	option can countermand this).
 +
+If the amended commit would be identical to the original (its tree,
+message, author, parents, and committer are all unchanged), the original
+committer date is kept so that the commit, and thus the branch tip, is
+left untouched. A commit that is being signed (`-S`, or `commit.gpgsign`)
+is always rewritten, since its signature cannot reproduce the original.
++
 --
 It is a rough equivalent for:
 
diff --git a/builtin/commit.c b/builtin/commit.c
index 1a51450660..e330a53d5c 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -17,6 +17,7 @@
 #include "dir.h"
 #include "editor.h"
 #include "environment.h"
+#include "ident.h"
 #include "diff.h"
 #include "commit.h"
 #include "add-interactive.h"
@@ -760,6 +761,49 @@ static void prepare_amend_commit(struct commit *commit, struct strbuf *sb,
 	repo_unuse_commit_buffer(the_repository, commit, buffer);
 }
 
+/*
+ * Rebuild the amended commit reusing the existing committer date and report
+ * whether it reproduces the current commit. Because the committer date is the
+ * only field that an amend would otherwise replace with "now", an exact match
+ * means everything else (tree, message, author, parents, committer identity)
+ * is unchanged too.
+ */
+static int amend_is_noop(struct commit *current_head,
+				 const struct strbuf *message,
+				 const struct commit_list *parents,
+				 const char *author,
+				 const struct commit_extra_header *extra,
+				 struct object_id *oid)
+{
+	const char *buffer, *committer_line;
+	size_t len;
+	struct ident_split ident;
+	struct strbuf date = STRBUF_INIT;
+	int unchanged = 0;
+
+	buffer = repo_get_commit_buffer(the_repository, current_head, NULL);
+	committer_line = find_commit_header(buffer, "committer", &len);
+	if (committer_line && !split_ident_line(&ident, committer_line, len) &&
+	    ident.date_begin) {
+		const char *committer;
+
+		strbuf_add(&date, ident.date_begin,
+			   ident.tz_end - ident.date_begin);
+		committer = fmt_ident(getenv("GIT_COMMITTER_NAME"),
+				      getenv("GIT_COMMITTER_EMAIL"),
+				      WANT_COMMITTER_IDENT, date.buf,
+				      IDENT_STRICT);
+		if (!commit_tree_extended(message->buf, message->len,
+					  &the_repository->index->cache_tree->oid,
+					  parents, oid, author, committer, NULL,
+					  extra))
+			unchanged = oideq(oid, &current_head->object.oid);
+	}
+	repo_unuse_commit_buffer(the_repository, current_head, buffer);
+	strbuf_release(&date);
+	return unchanged;
+}
+
 static void change_data_free(void *util, const char *str UNUSED)
 {
 	struct wt_status_change_data *d = util;
@@ -1943,6 +1987,18 @@ int cmd_commit(int argc,
 		append_merge_tag_headers(parents, &tail);
 	}
 
+	if (amend && current_head && !sign_commit &&
+	    amend_is_noop(current_head, &sb, parents, author_ident.buf,
+			  extra, &oid)) {
+		commit_index_files_or_die();
+		if (!quiet)
+			fprintf(stderr,
+				_("nothing to amend; %s left unchanged\n"),
+				repo_find_unique_abbrev(the_repository, &oid,
+							DEFAULT_ABBREV));
+		goto cleanup;
+	}
+
 	if (commit_tree_extended(sb.buf, sb.len, &the_repository->index->cache_tree->oid,
 				 parents, &oid, author_ident.buf, NULL,
 				 sign_commit, extra)) {
diff --git a/t/t7501-commit-basic-functionality.sh b/t/t7501-commit-basic-functionality.sh
index a37509f004..160edb9c0a 100755
--- a/t/t7501-commit-basic-functionality.sh
+++ b/t/t7501-commit-basic-functionality.sh
@@ -11,6 +11,7 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-diff.sh"
+. "$TEST_DIRECTORY/lib-gpg.sh"
 
 author='The Real Author <someguy@his.email.org>'
 
@@ -654,6 +655,124 @@ test_expect_success 'amend commit to fix author' '
 
 '
 
+test_expect_success 'amend --no-edit that changes nothing keeps the commit' '
+	git reset --hard &&
+	old=$(git rev-parse HEAD) &&
+	test_tick &&
+	git commit --amend --no-edit 2>err &&
+	test_cmp_rev $old HEAD &&
+	test_grep "nothing to amend" err
+'
+
+test_expect_success 'amend --no-edit keeps the commit out of the reflog' '
+	git reset --hard &&
+	git rev-parse HEAD@{0} >before &&
+	test_tick &&
+	git commit --amend --no-edit &&
+	git rev-parse HEAD@{0} >after &&
+	test_cmp before after
+'
+
+test_expect_success 'amend --signoff is idempotent once signed off' '
+	git reset --hard &&
+	test_tick &&
+	git commit --amend --no-edit --signoff &&
+	signed=$(git rev-parse HEAD) &&
+	git log -1 --format=%B | grep "^Signed-off-by:" &&
+	test_tick &&
+	git commit --amend --no-edit --signoff &&
+	test_cmp_rev $signed HEAD
+'
+
+test_expect_success 'amend that changes the tree still rewrites the commit' '
+	git reset --hard &&
+	old=$(git rev-parse HEAD) &&
+	echo changed >>file &&
+	git add file &&
+	test_tick &&
+	git commit --amend --no-edit &&
+	test_cmp_rev ! $old HEAD
+'
+
+test_expect_success 'amend that changes the committer still rewrites the commit' '
+	git reset --hard &&
+	old=$(git rev-parse HEAD) &&
+	test_tick &&
+	GIT_COMMITTER_EMAIL=other@example.com \
+		git commit --amend --no-edit &&
+	test_cmp_rev ! $old HEAD
+'
+
+test_expect_success 'amend that changes only the message still rewrites the commit' '
+	git reset --hard &&
+	old=$(git rev-parse HEAD) &&
+	test_tick &&
+	git commit --amend -m "new message" &&
+	test_cmp_rev ! $old HEAD &&
+	echo "new message" >expect &&
+	git log -1 --format=%s >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'amend --allow-empty of an empty commit that changes nothing keeps it' '
+	test_when_finished "git reset --hard parent && git tag -d parent" &&
+	git tag parent &&
+	git commit --allow-empty -m "empty" &&
+	old=$(git rev-parse HEAD) &&
+	test_tick &&
+	git commit --amend --no-edit --allow-empty 2>err &&
+	test_cmp_rev $old HEAD &&
+	test_grep "nothing to amend" err
+'
+
+test_expect_success GPG 'amend --no-edit of a signed commit is not a no-op' '
+	git reset --hard &&
+	test_tick &&
+	git commit --amend --no-edit -S &&
+	signed=$(git rev-parse HEAD) &&
+	git verify-commit HEAD &&
+	test_tick &&
+	git commit --amend --no-edit -S &&
+	test_cmp_rev ! $signed HEAD &&
+	git verify-commit HEAD
+'
+
+test_expect_success GPG 'amend --no-edit with commit.gpgsign is not a no-op' '
+	git reset --hard &&
+	test_tick &&
+	old=$(git rev-parse HEAD) &&
+	git -c commit.gpgsign=true commit --amend --no-edit &&
+	test_cmp_rev ! $old HEAD &&
+	git verify-commit HEAD
+'
+
+test_expect_success 'amend --reset-author rewrites the commit' '
+	git reset --hard &&
+	old=$(git rev-parse HEAD) &&
+	test_tick &&
+	git commit --amend --no-edit --reset-author &&
+	test_cmp_rev ! $old HEAD
+'
+
+test_expect_success 'amend --date rewrites the commit' '
+	git reset --hard &&
+	old=$(git rev-parse HEAD) &&
+	test_tick &&
+	git commit --amend --no-edit --date="@1234567890 +0000" &&
+	test_cmp_rev ! $old HEAD
+'
+
+test_expect_success 'amend that changes nothing skips the post-commit hook' '
+	test_when_finished "rm -f post-commit.ran" &&
+	test_hook post-commit <<-\EOF &&
+	>post-commit.ran
+	EOF
+	git reset --hard &&
+	test_tick &&
+	git commit --amend --no-edit &&
+	test_path_is_missing post-commit.ran
+'
+
 test_expect_success 'git commit <file> with dirty index' '
 	echo tacocat >elif &&
 	echo tehlulz >chz &&
-- 
gitgitgadget
