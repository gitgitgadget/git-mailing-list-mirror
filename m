Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793357598;
	b=TEP9MIt/JEkmgn2kQsvVfkAmzJvExNqRfLxhORr1C2rAj/PRDwja6voWEFlir2tvOT60
	 JKchEBcHfH/94wYwvSUsvviTiEXuCZYcX+N+nhrjkCZxJPlaZYoWyFQvejL625lnwZkDC
	 mg5HlyzF01p50p7Lc+5PTZK4ZcYyOEwrwkNaGY3hByAgDsS73LtWzwHldJ/vX3vki5tx4
	 a/29id1g+SZTBk10VVXlPQEwwBdo3le7ttLQBJpWTPrq5XXpN42URiBQBOvph8iqtZSff
	 M9ViCaK9NfNq6VMd+Xgec/xJeF6hkDlplcJJedNg158zemm4gYtKT+aOlFgao7pwOZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357598;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=LbFiomdnGPGeE9R08vjOA+ftnN9xQEXaVqeWQBrgJNQ=;
	b=lRzt0Fbyiv/9gCq6mTRi2EFAXQ9cV/rNFgkbEKveutbc8fFHl+nRFBuLLG1b6jnmQJPk
	 2z8FAAhEojSURCNoxljjAIaVgkocyuRbAT1sP98bLdlF9lQOxUbc1ycalr427TKtGR/bM
	 VJLij1OH0EFurFddxfQzI14nvMJhnpv8OBo6kVyv55j3WjqZMIhWK5oRPEzrcltRrXNXI
	 /MyhrGyx4f/foyoKrse/KmkMk6/fykgqccNSR7JkZZEHxKlU8Gx02YvKRreGDPpAYXwgT
	 WPBOX5AP1T8kYprWh56xV4bZASR3CzXHeFwx+BTLPHGz6PNkIzH4hGjz0wWuWzICaNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="arX3P/KE";
	arc=none smtp.remote-ip=209.85.160.54
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7437607080C
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 10:53:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7437607080C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=arX3P/KE
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-48ed0b68895so383436fac.1
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 03:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793357596; x=1793962396; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LbFiomdnGPGeE9R08vjOA+ftnN9xQEXaVqeWQBrgJNQ=;
        b=arX3P/KERSxc4bWsK1dmZK9iA+j+93UVKp+1QQj6uC9hgCbvexWJB29csb8S6HBf4T
         oG7rTNAxvlUFKx8U5VPSVkTkMFACrUDP8qPUyjWFPumZiVEs7EBapYwluU2SfkfNHzHc
         Nl+x60J0i2wAmu4yOoaXngRsBjw5ltJz985Cv6nfozXBeE4nf/bG6VM5N1bYr60P1CvW
         MLCEs1k1Fl0Omc1GnRD3hd52UXIqRvjAy06gsYQmDPFtO59+NWC9Y5yBh7Q1gmbCM6yN
         jOUOpt58SnsGKpUaLIR2+dZv1MFE5b8cQsWIPlV4dF3jydkqMpojeY0Jb1YoQCs3X85d
         nYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793357596; x=1793962396;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LbFiomdnGPGeE9R08vjOA+ftnN9xQEXaVqeWQBrgJNQ=;
        b=SVltsmqDnZE/4G0/dYb2pOkl+jlA5Fr9AnwW7d3X1/VDMEpAmJ5ReioO+u9JnN9K7S
         BQPPTmLGkSBc2aL1TVi8YZduuFtpUF3YzzLmsmhWT2j60u9aylkz+kwkCrxeIP9i6sXA
         4gTh6G8PI36m65ynrHG/iu/lANVT6KKwI/l4JQBvwlJ5uDRpbYWg9G1LtVjMT74dDlvr
         yZBFnE8kXcHMVXSXFrqc2vvGWe97f+VMasWcGQbU2USkYU7UzxcCDSFs07vU5eCxG1kX
         CdN+XPQkgJZcL4aPatzcEQwAPOF+E8NxYSUEQ/OLjQ70/NJ61h+tIe7tLmiGJiXAhZKu
         Xrjg==
X-Gm-Message-State: AFq9FYImmQlSjP1ZmOpwQ3FsuFDNKtapbAWrqDz+XpttOiJs/bWSwy8N
	440qryeFwlhAm4Eg+WBHK1mgMSHKGTBpWu+EFgk8HFbEY8Brtxip8TVPZpEdcSISKIg=
X-Gm-Gg: AYBFou0QSr9vKM/JIaCUvQlN8btg75xhSqMUx1NOaezF9o74jwp9bVlRk0s0c3i3PET
	aye7DmvO2/NnutdHTrToAFwEPuRElPnDsXzYLVno1BDHG46B7TxnrWsH4A6SQZMW4yHTJ7027sk
	sv0r/0pwTniEXbOBc7KtYo863HxVgOf0VUoPBSc2VkenJTJGiJUlGFvzyB/bhFpdsTya2AZMSaP
	WBzfViJg6J6SS8p1XMW0lg56rBwNmYJrT+6Xi8kyFcohHgu3BBg38eUvTUWmTjhM1sMT3C8DJ6T
	t9h9YTV8yVMaxKSwV7WLcfLHCBQLXRNJEclwWxxcI8z7NPysFz3InjcOQTHU/cdjFZQKyLdyMet
	11Ys8o+MQ3CDQSCcG0DxIX9/rzJVhaHA+95IwBY6rkgbWQD+wm+ACUwMMXev6XcTwnzUFxyuO36
	Uw3DvcZJLNs60vb2ce2cvUYgfMgTlcA77XbkElePxcp4ZkVs46dElSudumEfkvbWUxzfK5k1/zQ
	0+tyb7z82/Qbsc5SGrbvl1NB0Sd021Ex9jmwllw4evu2Anm47YdKvcX60P+1I0cjc+C+cqfY/5r
	L4DlSY+eYuAZc9XYWoSLtNXRKZKdlL+JeQ==
X-Received: by 2002:a05:6870:e988:b0:4a7:1d66:1463 with SMTP id 586e51a60fabf-4a907703200mr1056135fac.35.1793357596484;
        Fri, 30 Oct 2026 03:53:16 -0700 (PDT)
Received: from [127.0.0.1] ([132.196.62.244])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a90aeaa9e0sm1490936fac.7.2026.10.30.03.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 03:53:15 -0700 (PDT)
Message-Id: <9443055242b8968e7196530bc67614d5b43d1a45.1793357582.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2425.v5.git.git.1793357582.gitgitgadget@gmail.com>
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
	<pull.2425.v5.git.git.1793357582.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 30 Oct 2026 10:53:02 +0000
Subject: [PATCH v5 4/4] branch: let --delete-integrated find branches merged
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
 builtin/branch.c              | 71 ++++++++++++++++++++++++++++++-----
 t/t3200-branch.sh             | 42 +++++++++++++++++++++
 3 files changed, 111 insertions(+), 15 deletions(-)

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
index ac2dd68b23..36e67830e7 100644
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
 	diff_flush(&opt);
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
