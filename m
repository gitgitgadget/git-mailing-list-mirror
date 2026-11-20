Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795184674;
	b=M9eXuqUT8KXT34FQS++b8J0jcWCJ7e4T7Nl+WJjBiZ5mCXwW4q/yLcqcwEsL6NHZyZ5u
	 /MIvxiZD4+L5lxsLbI3DU0DMQc0wgtIrgqUXIMHIlxoSqoCUjxtLe3RgDZJGmUubjoqaX
	 xW/jA84Qf4XZzIzxG9Z8uW0bXWVwI9uB8OBQRscjdP+lSA8sSarnXmxLfqYRQUna8nMDu
	 OJS09IgR7FZLqV31ZnXeXoDwk2zoIiM/KTdmnzXIHKWiDoha6/nSEiM2yiQS1lh6+FcoJ
	 cMdNopwQ1YyYpL+XcllgEr4YSioNKL1zzbOb3vZzkeQK+6ZV7HYgoiZhJMe9KSDOL9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795184674;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=smUruof9Y3X4H/wrjfRAghmUMVMmHjcS0dAkfpZFr5s=;
	b=bYubmkV4O3w9O6vshJ0PPEtDjAaqa1jfvRzrNTec1OltJeJPvi6mEfDDc/Wh4Pfycg4s
	 wJwzORZCx5Sade0sJX/t2Qyhb8nH6jpxqTC68AfjV13Fbaz8CmDRFdCGwUlFz3Ei5A3hK
	 ejW9NdHtI9DfD3QY3pzQciLHHj+YBHm1h0ufsdNyrj8BoiU905bn8jcJFqFkj1usAygRO
	 9wG4xKD3uC103XetXUUEQ7exQmS43e2KiG7+pMtJ8YZezkuBNh/cMVdpmmpw1RcAmv+43
	 MoBbf+NMOFPQQeVnByqGRLw0LIO61TrQkft3/e8iVxWJICWo0k1r4+xPRUUpEagzezg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gDTmy2Kx;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6D3606A325
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 14:24:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D6D3606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gDTmy2Kx
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-38587f3de36so1077285eec.0
        for <git@vger.kernel.org>; Fri, 20 Nov 2026 06:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795184673; x=1795789473; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=smUruof9Y3X4H/wrjfRAghmUMVMmHjcS0dAkfpZFr5s=;
        b=gDTmy2KxeDRzjU4WdXK0LknAYSBfvFnWrX6FTmUZV0rSPWxdLvTVDr0d/x9xJg/NhY
         lrA92bWYMzkh4MaqjkmLJceJ3Z4pMTM71Pn8/NtO43etA4IFMYKUr+vdUZFzprbfWDsw
         xCaRxlJ73yGNe1jSYdo1CGYcIf1AVTjWopr8KpfxSuKVlEHmPWoQZ5FuUjbD0a5oP7rd
         Vml8E07KwU9sfyuMJLjzHy2oyr55PvFGQ/nf13hplMITyKiwc3FAHMCMIxDnl6yiH45h
         cd8FFvymw3W8iJbNt6aEzUoOnDgk9+ULZcbmwgNlBCn/c4s3kbPT7nGeEwHG4F3bs2n1
         szdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795184673; x=1795789473;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=smUruof9Y3X4H/wrjfRAghmUMVMmHjcS0dAkfpZFr5s=;
        b=tMDvVQuR4XDVHDGio2R7l8NKfOgPdFpEMks8Z1rt/lNDjLCo5/3Ix9Cyrv6uvMwB9C
         lt1PizvNrbujxTe2bqZeBfvbFIgXDUCZDsA4axQ4jFzkEPhELykolengIiXnlRCko4qS
         drgt5PWWjDCKmn9amxGeaM0LVUu54wOlrPW+sIPSOhuI3LN80sz+NC2JieorgwQXwqGx
         CpFidtMzlyDqsQgnPcGQU/B+gjRCZDvWC3hjJl+n32X4LK2JCcLvUc3rUIDLog7cdsdY
         1xKOiScgXZ/HXrIE/jd4RinfHB+uydsQPODK5lz/qNeiqVj2j9nzA32X3ZibzSxzoDIe
         78Qg==
X-Gm-Message-State: APuU4Z+3LAWQkutkI3KgQXc2udrEiZTTeVQgGxBOhn9t/SOln0Q28s8H
	6fyMxWQTjG/ekALpkguVqVPOADBFNhOc3JdxbFMuC28pQWl0DlFOm6C1n/uHL/Y2
X-Gm-Gg: AZFdTZcTuAd8LhW3Neu8TI186OHjFJwflPcN18qPykA0rOb66e/VAH++R6rc2nUsukJ
	6bWeYnFKOh7gUfF7OZBACHxF5ScG4wZIRNHSwXuCKfG61O88zz6UtpSee5j+kos7pwMtYbH6Vbe
	tBDQC1y8s29r1YCrMRA9uhiU+QtGYzvnuCJitsY5xWxNShUqj7mgha/Fi+yKf06SUY732IRK+f4
	MxTru4MBI5nuk27PGBgQHBFn66cXYU7U25kceN0s1pSvlOAYa9f1xRVB9OElKV1lYE6DL2Rko4q
	vdyVrFAk7cIQ+8MjPYwrnA7bkQs/TVNrm0rVcKxo7SB4cOkRTG7Satt+H1/SyVivJqWCOzUaJio
	hm11eLiulcvCPJN2ZybN6cO7zMOpromHQWOAVSl+hh7Sqpqwd2hGp5MGZ5/Zq9L80NtyLvWXnRa
	7HQLhrd2pXnpEi9+dnY/uVrelKEfxD6PqcWhGUg/4+qzSguIbIc3ItRpuz+wv/jD4x2oOMEpPmt
	gFpypn/P71X+PQ4gG5mm0K85EeuKTZVFyPIPyBaMPpncpCwA+FBfdqeN1HBHt4Bx0U+s1i5ETY/
	oiwKrnwcv4TyQVNn75gpL5EpaQH7Vxxaww5IfAO09KkIBQGptwk=
X-Received: by 2002:a05:7301:714:b0:36a:7b3c:4e0a with SMTP id 5a478bee46e88-3856fd5e4a4mr2938838eec.24.1795184672758;
        Fri, 20 Nov 2026 06:24:32 -0800 (PST)
Received: from [127.0.0.1] ([20.171.3.187])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672cf745sm8456502eec.18.2026.11.20.06.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 06:24:32 -0800 (PST)
Message-Id: <ef6570030325b4fe18624c30ad1779552fe46b37.1795184664.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2425.v9.git.git.1795184664.gitgitgadget@gmail.com>
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
	<pull.2425.v9.git.git.1795184664.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 20 Nov 2026 14:24:24 +0000
Subject: [PATCH v9 4/4] branch: let --delete-integrated find branches merged
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
 Documentation/git-branch.adoc |  14 ++--
 builtin/branch.c              |  76 ++++++++++++++++---
 t/t3200-branch.sh             | 139 ++++++++++++++++++++++++++++++++++
 3 files changed, 213 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index b6d9cd01a4..814395d223 100644
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
index ee92e71f51..262cd82272 100644
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
-	unsigned short branch_mode;
+	struct object_id base_oid, branch_oid, upstream_oid;
+	unsigned short base_mode, branch_mode;
+	enum change_state state;
 };
 
 struct landing_search {
@@ -888,32 +897,76 @@ static void collect_branch_changes(struct landing_search *search,
 			   search->changes_alloc);
 		change = &search->changes[search->changes_nr++];
 		change->path = xstrdup(p->two->path);
+		oidcpy(&change->base_oid, DIFF_FILE_VALID(p->one) ?
+		       &p->one->oid : null_oid(the_hash_algo));
 		oidcpy(&change->branch_oid, DIFF_FILE_VALID(p->two) ?
 		       &p->two->oid : null_oid(the_hash_algo));
+		change->base_mode = p->one->mode;
 		change->branch_mode = p->two->mode;
 	}
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
+	    mode != change->branch_mode || !S_ISREG(mode) ||
+	    !S_ISREG(change->base_mode))
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
 
@@ -1015,6 +1068,7 @@ static void find_landed_commits(struct landing_search *searches,
 	diffopt.no_free = 1;
 	diff_setup_done(&diffopt);
 	init_changed_paths(&cache);
+	repo_read_index(the_repository);
 
 	for (size_t i = 0; i < searches_nr; i++) {
 		struct commit *landed;
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 54461e90b3..ed62164a95 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -2160,6 +2160,145 @@ test_expect_success '--delete-integrated deletes a squash merged branch that was
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
+test_expect_success '--delete-integrated keeps a branch that replaced a submodule with a file' '
+	(
+		cd upstream &&
+		git checkout next &&
+		git init lib &&
+		test_commit -C lib in-lib &&
+		git add lib &&
+		git commit -m "add lib as a submodule" &&
+		git checkout main
+	) &&
+	setup_repo_for_delete_merged &&
+	(
+		cd repo &&
+		git checkout -b replaces-lib --track origin/next &&
+		rmdir lib &&
+		echo "from the branch" >lib &&
+		git add lib &&
+		git commit -m "replace lib with a file" &&
+		git push origin replaces-lib &&
+		git checkout --detach
+	) &&
+	(
+		cd upstream &&
+		git checkout next &&
+		rm -rf lib &&
+		echo "from upstream" >lib &&
+		git add lib &&
+		git commit -m "replace lib with another file" &&
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
+		main
+		replaces-lib
+		EOF
+	)
+'
+
 test_expect_success '--delete-integrated reports a merge plainly next to an unmerged branch' '
 	setup_repo_for_delete_merged &&
 	push_topic a-unmerged unmerged-work &&
-- 
gitgitgadget
