Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794921889;
	b=d+9sh+E+biu4WsrBWGIe5WRjdLrqgYXZXSmsd1EMUmO+jERLPVp7TZf+kz5aaqjJm6wK
	 d3wmzjI1z10Y9AfZyFyWw6/L8jb7DrA10x3q1Pi4jD/El7zpqTo2+NkcqGMEw8nVwlIOp
	 tzxq09HqvvG3PyVpjYKyCn0JU12E/Hbi20wKXSgOLT163WTB3+zqf+kwxtOvwwKjxyAFd
	 VOe8lT/Vt46KfDQqx+IuH90q4aY5HGWz+/06rDcK22Tg0rfElfhINgc3eW11hkhx80i0T
	 1m3LEoKUzbPzkTW44m13kRgunxoNHBvfe//ekf0sv3wSJGVB0sMcvMNvz3RZV3avwkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794921889;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=76QK+OeQSYQj1r72+M1Jc4/qY5ERKsoRudAdwWf6UHI=;
	b=Zh3QSJND4f1HtszPEr985WrAywIqw/ULGRBNK7czpSlib8WG/zsbpXpXNoBELbqaJCrV
	 Owmz37AjNHoJrVEIL+lwX010swWDz8NfvYaD3N1M079wCM/4mV9DpACoCBtYlSNvOJXdY
	 7CfKE+WZlKTdn4cQCw6Jnq5YJYXlfTg4aI+q/8JZRZ7rKw23To39x61SB07A8QqaAQ5TH
	 nFm/Lfeb5Z3CAxYSpQjaCgyrB94pHTZTFEEWDKutz3aACkDzLBy2ACrIkOBGwQTi0Q3Ct
	 GYX8Q1Gi6MU73BBR9IGq9MP8gfOCL+D7ofS1JhtlwE4hyzcnQzXOk/k4uUHf0QzLwZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pHuMplZ1;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB00C606A32C
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 13:24:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB00C606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pHuMplZ1
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cdba1b5ed8dso588119a12.1
        for <git@vger.kernel.org>; Tue, 17 Nov 2026 05:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794921888; x=1795526688; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=76QK+OeQSYQj1r72+M1Jc4/qY5ERKsoRudAdwWf6UHI=;
        b=pHuMplZ1qDv+rPgWgs/IVYEPlCe0yugDHWvEtEvVDF5pfnS07yuwcbReeoVtAgROYd
         6aJhTRj+lh86ThUnMWGCE16+RKImyXrK6uKAlwCpTgcVVqL/wc8OtcFuY2qwU+F/GCnJ
         5VoPbjpHRwvA+FWoCY5YIhmBbNt+SFHETNQsaV+ZV385zz2G/OBpLMrxfQK0vMtR2xBv
         YAbj6Ea9G3MbZGHVXTmY0+2smy+CmKNNj9fHqBN06AUz0MBRxNTk8IJbYqEzfh796G9P
         vVsBEJSYkUT1DdCfHDbODHXXhaj5V/m6MI/96pGQR4BUiBJpTTCaf7M5wMk0QeoXan00
         5a5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794921888; x=1795526688;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=76QK+OeQSYQj1r72+M1Jc4/qY5ERKsoRudAdwWf6UHI=;
        b=QU8XrmZRwcLocAMYxYopiFe0T8dR9bqqgNE7uR1MHHM9FTypgG84TXrRMz6rv69oRm
         ksAylga7hVZ6xI99RYQeUks69ZKMGy/EWi1/UTMVKYsi6rw5i9cXWyc9EUaCWkjySHao
         1AsN/4TP0ryPD1rwL42QlKCugvB0jzIzzElA43Kt046ni5yyhewg8S4yzrQEd9TDZ5nY
         xANcC49WD8EgwaQKbggtQVPfFFiWwSRcG+G+LyGRByVDBlCxPjeVtQGUOFnG1jOnJE9t
         bKB/TSyxlwAGbY6hC/uNf12QUZ9WvMeFFGkjmnHr388TfB4BZf4HAkTQSPo1zVagY8v9
         MsBQ==
X-Gm-Message-State: APuU4Z83UiBOPUDXWs6B1NdE6PUABoBO4C3IPLivwNPp7FF8ps81WV+q
	kddJ90rw1NSbto6Htg0+gIWN7GsuEBytkgyEszxF78ajW3N8ZldAG11v5x/87A==
X-Gm-Gg: AYBFou2CqKVAow57iUpl59ETv4Fho7N8Q7Cpe5vHnS01XiIb4fQiHSCSPqalIiXe2vh
	uyCs3s6LpEKdLwY2NalJwzedkBOeCADoEYiUEEUY+kn+K6tmAGbbnWpgbOz95UUtfBPBtWzZ/2m
	cwlIdL+aAOh0eikQYDuDuFvwk90HELmI1JMcQ748GsrP4DNR6vZdj9btAVEKeUPxK8uVsQZyGuT
	NpgzRaRP3RCix6cXK2bJWF2i9ZpUP8AVeEGfVB9r4af7Rsu/KyV45UrtEFqtZsFsugPUJHyEY8I
	KEXLAAILCCUciFyLu57EdLRpC+OaMsy2qWP998DNB2UltOaU7jZ7VZ/K8s2dKDkpI7ZYLRhyAE1
	uiPLmFrFWkn12AMmvC5+I7gg7GXJh9vS+mlZcckWZCuH8Vuv/maZe3Oedzr8hpjYDxqDuv3S9wO
	Bm11dfLaoHTtdBBC/yAf+6gmtExenz8QIbW75SiOlRRM0sAQJgHWTE7UgptYhpkTF02ChbGwiYW
	rpEVC1IV/aoO83VeO8qxmnK/znC6Bs4XwETwaiohw3TTcZnRQScajqVsAVdha9Q66gX1dBYrxpt
	KdMifqvJHW3s3fOcUWCWC8Uxx1FIVaVBnKP0rey1ZvAlNaTKkPv1k6liXKlCLIrHJHqXm8NH9oW
	LvlrXANbn
X-Received: by 2002:a05:6a20:b598:b0:3fb:4856:bc4c with SMTP id adf61e73a8af0-3fd26e79a4cmr1803806637.0.1794921887732;
        Tue, 17 Nov 2026 05:24:47 -0800 (PST)
Received: from [127.0.0.1] (ec2-3-42-157-125.us-west-2.compute.amazonaws.com. [3.42.157.125])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed1a6db11sm4930690b3a.26.2026.11.17.05.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 05:24:45 -0800 (PST)
Message-Id: <22658105edeacf296a18373400e7b35141e053ef.1794921876.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2425.v8.git.git.1794921876.gitgitgadget@gmail.com>
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
	<pull.2425.v8.git.git.1794921876.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 17 Nov 2026 13:24:36 +0000
Subject: [PATCH v8 4/4] branch: let --delete-integrated find branches merged
 onto changed files
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Jasper Mayone <me@jaspermayone.com>,
    Tuomas Ahola <taahol@utu.fi>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

A branch that upstream integrated with

    git merge --squash topic
    git commit

after upstream had also changed the files the branch touches is still
kept by "git branch --delete-integrated". The squash commit has neither
the branch's version of those files nor the fork point's, so the
previous check cannot see that the work landed. This happens all the
time on hosting services such as GitHub, where the "Squash and merge"
button lands pull requests this way, and other pull requests often
touch the same files first. A rebase merge onto such changes looks the
same.

For each such file, merge the branch's version into the upstream one
and treat the change as landed when that leaves the upstream version
unchanged. This has to read the files, so in a partial clone it may
download blobs.

The merge uses the attributes of this repository, from the working tree
and the index, the same as a merge run here would. A merge driver that
only the upstream repository has is not seen. In a bare repository only
info/attributes and the global file apply.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-branch.adoc | 14 ++++--
 builtin/branch.c              | 72 ++++++++++++++++++++++----
 t/t3200-branch.sh             | 95 +++++++++++++++++++++++++++++++++++
 3 files changed, 166 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index 6be28c8a4e..ec468fcb8d 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -240,11 +240,15 @@ remove it anyway.
 	Like `--delete-merged`, but also delete a branch whose changes
 	the upstream already has even though its commits are not there,
 	as happens after a squash or rebase merge. Such a branch is
-	deleted when some upstream commit since the fork point has its
-	version of every file it changed, even if those changes were
-	later reverted, and the message names the first such commit.
-	It does not matter who made that commit. The same rules for
-	which branches are kept apply as for `--delete-merged`.
+	deleted when some upstream commit since the fork point has all
+	of its changes, even if they were later reverted, and the
+	message names the first such commit. It does not matter who made
+	that commit. A file counts when the commit has the branch's
+	version of it. It also counts when merging the branch's version
+	into the commit's version leaves the commit's version unchanged.
+	That merge reads the file, and in a partial clone it may download
+	blobs. The same rules for which branches are kept apply as for
+	`--delete-merged`.
 
 `--dry-run`::
 	With `--delete-merged` or `--delete-integrated`, print which
diff --git a/builtin/branch.c b/builtin/branch.c
index ee92e71f51..8547668fc4 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -33,8 +33,10 @@
 #include "diff.h"
 #include "diffcore.h"
 #include "hex.h"
+#include "merge-ll.h"
 #include "revision.h"
 #include "tree-walk.h"
+#include "xdiff-interface.h"
 
 static const char * const builtin_branch_usage[] = {
 	N_("git branch [<options>] [-r | -a] [--merged] [--no-merged] [(--forked <branch>)...]"),
@@ -853,10 +855,17 @@ static int branch_pushes_to_upstream(struct branch *branch,
 	return ret;
 }
 
+enum change_state {
+	CHANGE_MISSING,
+	CHANGE_LANDED,
+	CHANGE_NEEDS_MERGE,
+};
+
 struct branch_change {
 	char *path;
-	struct object_id branch_oid;
+	struct object_id base_oid, branch_oid, upstream_oid;
 	unsigned short branch_mode;
+	enum change_state state;
 };
 
 struct landing_search {
@@ -888,6 +897,8 @@ static void collect_branch_changes(struct landing_search *search,
 			   search->changes_alloc);
 		change = &search->changes[search->changes_nr++];
 		change->path = xstrdup(p->two->path);
+		oidcpy(&change->base_oid, DIFF_FILE_VALID(p->one) ?
+		       &p->one->oid : null_oid(the_hash_algo));
 		oidcpy(&change->branch_oid, DIFF_FILE_VALID(p->two) ?
 		       &p->two->oid : null_oid(the_hash_algo));
 		change->branch_mode = p->two->mode;
@@ -895,25 +906,65 @@ static void collect_branch_changes(struct landing_search *search,
 	diff_flush(&diffopt);
 }
 
-static int change_landed(const struct branch_change *change,
-			 struct commit *commit)
+static int merge_keeps_upstream(const struct branch_change *change)
+{
+	mmfile_t base, upstream, branch;
+	mmfile_t result = { 0 };
+	int ret;
+
+	read_mmblob(&base, the_repository->objects, &change->base_oid);
+	read_mmblob(&upstream, the_repository->objects, &change->upstream_oid);
+	read_mmblob(&branch, the_repository->objects, &change->branch_oid);
+	ret = ll_merge(&result, change->path, &base, "base",
+		       &upstream, "upstream", &branch, "branch",
+		       the_repository->index, NULL) == LL_MERGE_OK &&
+	      result.size == upstream.size &&
+	      !memcmp(result.ptr, upstream.ptr, upstream.size);
+
+	free(base.ptr);
+	free(upstream.ptr);
+	free(branch.ptr);
+	free(result.ptr);
+	return ret;
+}
+
+static enum change_state change_state_at(struct branch_change *change,
+					 struct commit *commit)
 {
-	struct object_id oid;
 	unsigned short mode;
 
 	if (get_tree_entry(the_repository, get_commit_tree_oid(commit),
-			   change->path, &oid, &mode))
-		return is_null_oid(&change->branch_oid);
-	return oideq(&oid, &change->branch_oid) &&
-	       mode == change->branch_mode;
+			   change->path, &change->upstream_oid, &mode))
+		return is_null_oid(&change->branch_oid) ?
+			CHANGE_LANDED : CHANGE_MISSING;
+	if (oideq(&change->upstream_oid, &change->branch_oid))
+		return mode == change->branch_mode ?
+			CHANGE_LANDED : CHANGE_MISSING;
+	if (is_null_oid(&change->base_oid) ||
+	    is_null_oid(&change->branch_oid) ||
+	    oideq(&change->upstream_oid, &change->base_oid) ||
+	    mode != change->branch_mode || !S_ISREG(mode))
+		return CHANGE_MISSING;
+	return CHANGE_NEEDS_MERGE;
 }
 
 static int changes_landed(struct landing_search *search,
 			  struct commit *commit)
 {
-	for (size_t i = 0; i < search->changes_nr; i++)
-		if (!change_landed(&search->changes[i], commit))
+	for (size_t i = 0; i < search->changes_nr; i++) {
+		struct branch_change *change = &search->changes[i];
+
+		change->state = change_state_at(change, commit);
+		if (change->state == CHANGE_MISSING)
 			return 0;
+	}
+	for (size_t i = 0; i < search->changes_nr; i++) {
+		struct branch_change *change = &search->changes[i];
+
+		if (change->state == CHANGE_NEEDS_MERGE &&
+		    !merge_keeps_upstream(change))
+			return 0;
+	}
 	return 1;
 }
 
@@ -1015,6 +1066,7 @@ static void find_landed_commits(struct landing_search *searches,
 	diffopt.no_free = 1;
 	diff_setup_done(&diffopt);
 	init_changed_paths(&cache);
+	repo_read_index(the_repository);
 
 	for (size_t i = 0; i < searches_nr; i++) {
 		struct commit *landed;
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 54461e90b3..088f029e72 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -2160,6 +2160,101 @@ test_expect_success '--delete-integrated deletes a squash merged branch that was
 	)
 '
 
+test_expect_success '--delete-integrated deletes a squash merged branch after upstream changed the same file' '
+	(
+		cd upstream &&
+		git checkout next &&
+		test_write_lines 1 2 3 4 5 6 7 8 9 10 >shared &&
+		git add shared &&
+		git commit -m "add shared" &&
+		git checkout main
+	) &&
+	setup_repo_for_delete_merged &&
+	(
+		cd repo &&
+		git checkout -b edits-shared --track origin/next &&
+		test_write_lines 1 two 3 4 5 6 7 8 9 10 >shared &&
+		git commit -a -m "edit line 2" &&
+		git push origin edits-shared &&
+		git checkout --detach
+	) &&
+	(
+		cd upstream &&
+		git checkout next &&
+		test_write_lines 1 2 3 4 five 6 7 8 9 10 >shared &&
+		git commit -a -m "edit line 5" &&
+		git checkout main
+	) &&
+	squash_merge_upstream edits-shared &&
+	squash=$(git -C upstream rev-parse --short next) &&
+	(
+		cd repo &&
+		git fetch origin &&
+		sha=$(git rev-parse --short edits-shared) &&
+
+		git branch --delete-integrated origin/next >actual 2>&1 &&
+		echo "Deleted branch edits-shared (was $sha, landed as $squash)." >expect &&
+		test_cmp expect actual &&
+
+		check_branches <<-\EOF
+		main
+		EOF
+	)
+'
+
+test_expect_success '--delete-integrated keeps branches whose changes did not land' '
+	(
+		cd upstream &&
+		git checkout next &&
+		test_write_lines 1 2 3 4 5 6 7 8 9 10 >doc &&
+		git add doc &&
+		git commit -m "add doc" &&
+		git checkout main
+	) &&
+	setup_repo_for_delete_merged &&
+	(
+		cd repo &&
+		git checkout -b unmerged --track origin/next &&
+		test_write_lines 1 2 3 4 5 6 7 eight 9 10 >doc &&
+		git commit -a -m "edit line 8" &&
+		git push origin unmerged &&
+		git checkout -b half-landed --track origin/next &&
+		test_write_lines one 2 3 4 5 6 7 8 9 ten >doc &&
+		git commit -a -m "edit lines 1 and 10" &&
+		git push origin half-landed &&
+		git checkout -b conflicting --track origin/next &&
+		test_write_lines 1 2 three 4 5 6 7 8 9 10 >doc &&
+		git commit -a -m "edit line 3" &&
+		git push origin conflicting &&
+		git checkout --detach
+	) &&
+	(
+		cd upstream &&
+		git checkout next &&
+		test_write_lines 1 2 3 4 five 6 7 8 9 10 >doc &&
+		git commit -a -m "edit line 5" &&
+		test_write_lines one 2 3 4 five 6 7 8 9 10 >doc &&
+		git commit -a -m "take line 1 from half-landed" &&
+		test_write_lines one 2 THREE 4 five 6 7 8 9 10 >doc &&
+		git commit -a -m "edit line 3 differently" &&
+		git checkout main
+	) &&
+	(
+		cd repo &&
+		git fetch origin &&
+
+		git branch --delete-integrated origin/next >actual 2>&1 &&
+		test_must_be_empty actual &&
+
+		check_branches <<-\EOF
+		conflicting
+		half-landed
+		main
+		unmerged
+		EOF
+	)
+'
+
 test_expect_success '--delete-integrated reports a merge plainly next to an unmerged branch' '
 	setup_repo_for_delete_merged &&
 	push_topic a-unmerged unmerged-work &&
-- 
gitgitgadget
