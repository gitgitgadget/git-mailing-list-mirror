Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793521338;
	b=SsQD18tchDCbO5to+o2O5hy1U6jSRq9h5JtQ3gT2Nr/bfAkejsc1xiSOGfx8wuYe0XRu
	 xlpfbIYCfZlerH99Ukjky+n1CPpb402BOAFBjmVnk7RBymkDt8hIqAvCTwpPl7WFYCEku
	 xjKDAQQN+mOUrujMViQtLDMo0tws1o1/sW8qiiit869YvF4cTydZ1TwgX/1FJq3pc0McC
	 X1L8evnQhJbSSE0N+TpVWPche58ar1Oa4S+OBtN7XzIAHld3bQWt453c9nMmQQMVOKABN
	 ptxSDy4HyFrSFzALA1FG7fK9/2vCnXIcdmN1FqwNM7JYUQSjrW9dZ8ozAoIlaYYs2rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793521338;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=B8Jn+Qefs3oKAY5fijNl0bHoci1wbnahdzBLS3D4aww=;
	b=nzYtQSHa5HyqSrcG1CkxJ9xk0lWa5XOwJkFfmoJHxx5zapG7HsrX0AaIRuTbzdXGoUGP
	 DvKLqvVdR9RRRwWfq0AmstDtM455LifIW991oWYJyXrfc6RUISlCPhcf5Lgs6E0Ze6GvO
	 fOzsEVmo6ZLe5ZsTxsJeV80nQfeJPNf0rObNAdGoQxzzk0VbmNeP+NX/QfVDL2pszauvI
	 NG6vZq3SAwgXeKOyUBQO+a1rIlUrWdg5dj1ftUqVidEYuaEqv+aZBv6QV54u4x6Qh7Mqc
	 kQpZtjreIrJn7+i8uH6tp6bI1DpQtjpwCYG8TL9sCzV8d/ES53lsHOjsT+GpWE1qbvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o+meHLra;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7AB606A32D
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 08:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B7AB606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o+meHLra
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3535a54bed9so3102915eec.1
        for <git@vger.kernel.org>; Sun, 01 Nov 2026 01:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793521337; x=1794126137; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=B8Jn+Qefs3oKAY5fijNl0bHoci1wbnahdzBLS3D4aww=;
        b=o+meHLraVJjIgY4lGaGifZtvz5+OR91ZiA6DgrYlnWROrVytJ+jomE36hMzbCDyyfQ
         VIYr+/MNrfPEZRwCmUIWITkoAje11KPsdK0PAC5cEyVD7Ii6+wkHkkK2ZFBY3sBjrvOy
         R6Kzs9Plha7hGV8lyphdLU7tmnuy9qXexYM+keGL36FaBFD4tnaKH7J94H6Pjo87q2id
         qVs9brxlJZL4ZKyWhkKrgKMm42LjJ5VAyTOUEv8ULcsBu8ubobmbNPE0kwQFF/5AbbPT
         Elql3s86NBA4J0cPHZczruL7TPLiJz5ZeSoKh8juQXuVpNepYKHnTAG/mO/rCygf03AX
         2R3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793521337; x=1794126137;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B8Jn+Qefs3oKAY5fijNl0bHoci1wbnahdzBLS3D4aww=;
        b=NCx7uNND6NRctSYaA30v3+qGDYESHX0hql5pcFImQmmVDR2mHEO6xUQdO02QsrTp3P
         tOF8L+hMl/dqf+kH3naHuSRK4lXmLtGI3MWVY5V7ivcTPV4/Hh6lPmFWmYNSF7oBo34u
         y06SgfVcWKBoknuZFydzGV2GlKpjFDyhzk2hRpOUoQijNDK1bOTSeEY4LvqISH730ea3
         Fsa6xPg8APXCDowy1YXeNgggAcZcp0+wizweD3ekp4eDuvlbtuoCw3oLAmIg5R/O9lZ5
         bzC8esr+OJC+/K5UFQ2E0Eln48fTaU6infvdaV9OHe1QPNjncWkfm/jBOQd5BVHW2epb
         T71A==
X-Gm-Message-State: APuU4Z86D6DJLfec9EucUp3xrN6JLKbn3OKfnI3o4GrDCbVZVaro3Qfq
	KCJ5FVmCj/lCEJ1oY3MARy+8PCCv8k9NCprlyHYOlvW1nXcUE5fmophY5xKqfF+d1Bc=
X-Gm-Gg: AYBFou0jvUnwxXPTem/xbmYMygr4OLUtX9DAWA2ZhUkG7LTakaCbhZKrWb0l1V38y9w
	nmG3qdwKbZDxLZLByJG6u+VVGk++K0nZnLHKMQCVqOEOAOt7fkaaKDyTkv8dUeMbQgFBNhLqLjQ
	UT/uZdy7CyPKUDtgI80tOsCpN1E7LPMJWhBQcDNNbBhJAWOi5l2aXu/j49wvjsvhXs/rDXjKg9M
	0QFBLYpG3yBytySYSZ+43NuoMZH9V9sEqVDLMURe3Tw1TsWC2vvNiSnKEcymJ/RMtHEIHzWndYS
	MwV++OHHM+BObcAQZ0QfQHUKxTF3qAw4IILNJaPr+kf8TTLxk28s0+iiWeUiOQvPFOzcF26G5Hn
	myMvTmLk5eqz4E2mKhOr1lpHFRA9pkOEdStx9tA8efJQQ8c1hTtyEAn1B+FLzQuT9U7pCcD2C+7
	pDXSSs1mjS39XhOMvNJUhB8XSBgN/O58WmUq94ziyj5mnY3rChT0+10r8UKEW+hjTIDSNubl/L7
	7qFBX7svZ51lTZjg7SEGvGNtRNtsUJXnUhxulwbWp3N5MBC//QVqyg4MqEJJ5ct097+5Ly/f3rD
	ke9gbg9J1v/Sty0tgDSdQFu0JfDmITA=
X-Received: by 2002:a05:693c:87cd:20b0:366:fbdb:2070 with SMTP id 5a478bee46e88-36a424de53amr11363814eec.34.1793521337167;
        Sun, 01 Nov 2026 01:22:17 -0700 (PDT)
Received: from [127.0.0.1] ([4.242.197.197])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a504c6sm25490391eec.21.2026.11.01.01.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 01:22:16 -0700 (PDT)
Message-Id: <006a57d7d150d581c920e2d2933bd9d9faa43eca.1793521331.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2425.v6.git.git.1793521331.gitgitgadget@gmail.com>
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
	<pull.2425.v6.git.git.1793521331.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 01 Nov 2026 08:22:11 +0000
Subject: [PATCH v6 4/4] branch: let --delete-integrated find branches merged
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
time on hosting services, where the "Squash and merge" button on GitHub
lands pull requests this way while the main branch keeps moving. A
rebase merge onto such changes looks the same.

For each such file, merge the branch's version into the upstream one
and treat the change as landed when that leaves the upstream version
unchanged. This has to read the files, so in a partial clone it may
download blobs.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-branch.adoc | 13 ++++---
 builtin/branch.c              | 72 ++++++++++++++++++++++++++++++-----
 t/t3200-branch.sh             | 42 ++++++++++++++++++++
 3 files changed, 112 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index 6be28c8a4e..489a9d5fd0 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -240,11 +240,14 @@ remove it anyway.
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
+	version of it, or when merging the branch's version into the
+	commit's leaves it unchanged, which reads the file and may
+	download blobs in a partial clone. The same rules for which
+	branches are kept apply as for `--delete-merged`.
 
 `--dry-run`::
 	With `--delete-merged` or `--delete-integrated`, print which
diff --git a/builtin/branch.c b/builtin/branch.c
index 818c916791..477b4a92c4 100644
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
@@ -895,25 +906,66 @@ static void collect_branch_changes(struct landing_search *search,
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
+	repo_read_index(the_repository);
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
 
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 1fbb173ad4..d4ebbd0ae9 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -2122,6 +2122,48 @@ test_expect_success '--delete-integrated deletes a squash merged branch that was
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
 test_expect_success '--delete-integrated reports a merge plainly next to an unmerged branch' '
 	setup_repo_for_delete_merged &&
 	push_topic a-unmerged unmerged-work &&
-- 
gitgitgadget
