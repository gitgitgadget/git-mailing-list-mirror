Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794662685;
	b=0PeUl328uijConGiSK7fiP1DGgZT+s7bXt4M9Pd1bopdrlJJhgj3xYRuceS09xEfTcBc
	 wcJWS1UwPqJuEwfGjebE9fm5jY+gPhI5IG4NkvCH8Txqxfwzo4t+2CCh2MUyQxufk0vmh
	 gcqFSAwwPgnhVDEgYE4sKEUcE6ut0+is00icKpgYy3GyFr8HI0f+TrX2olWMNGzUe6lae
	 4dSnI47CS8IVGplWRyLynHimcp34YdxI/USg5t4iCKt5ZgrszskSCOG9IfM3sIvmzF4TD
	 Nt025tCUQifsMheeFJ4/1s1IV55lOXQO7r18ZbuESO417opNCvTQZvDRP9diO9hVsZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794662685;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=Y6VEMAYOztw3RT6nJjG5gzDEC15Z8OBamPAjggA8rHA=;
	b=35uGzlJexxyXsvJys1qtEHuMquLZ33y3I9/vNLcyW2o1ILIZjymMb5OWkvyeBPED07mB
	 Jw6nGC5NfrALQG9YsnECghiSz/V5p6O+wA2CYKVCkIgyn7TieHIFZVi7H4IduDoG6Z8hQ
	 9cSHtALkiWWJoqm7gMO+xhdsvl8W1UtMoUDivv3eH0ZhJjjIrLrLSK7pcKDGazEUz7zd1
	 3jp8YZoLdhBUFCrMdhLGTvRHgJB2OKkcPJ5hO3+AElTHSxPCl7mXqas6GMBhGwxL4Q7zD
	 Dmq4PB9qCTKeWvFO9lAdTFTO6/nT4gI5xNjUkoFKQ5mwS/CuWb6VIuWNVrQrQ0HN39Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gBzCq5e0;
	arc=none smtp.remote-ip=209.85.210.50
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1EC606A323
	for <git@vger.kernel.org>; Sat, 14 Nov 2026 13:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C1EC606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gBzCq5e0
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-86103aaac12so2247856a34.0
        for <git@vger.kernel.org>; Sat, 14 Nov 2026 05:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794662684; x=1795267484; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Y6VEMAYOztw3RT6nJjG5gzDEC15Z8OBamPAjggA8rHA=;
        b=gBzCq5e0wAHXV3teFq+fdlvzCN1scDmCdq8M5qxU4oZ6fVIQy22Ewupg11JDoG+Duj
         WlzBZ488JqSVA3KEYJppdD19hoCxQxkeEYgZInX1dVj8W7jo2AWt/03ymWPWlwfCj+I8
         IA48e9hS/oP0Eufe80dNl7e+6df8bDdAFkA/TgJNwwJnMJejjneTK45SDTm5MITAp+Jk
         LENCykSG0+AAKYbsbFJ74r8Ni1es9BRVntfONK8Twhmvovd4N4m+j7Jl1v2rYVFSqeuy
         An3pOo+LsRENEPUtQDaGb+r7AByhTQ0XA3iC/vpdlMN8JEhGmqabxt+RXMnZDRWAdYZq
         3s/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794662684; x=1795267484;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y6VEMAYOztw3RT6nJjG5gzDEC15Z8OBamPAjggA8rHA=;
        b=VE+8JE3KC/wKVVF3WxMxfRSLkuWzk4i2QAzPRWNknA3G1LVG63b71HH3lUM3Dw7bcC
         wE6ITBCNz1ZTIhRtAy2eJCaUB+HcxdIkZFugcFPVSmR2/f0GGY3b28m2rOXIwvUuZtHc
         mH+HaWTwAP59fUkVLdnPo+PnD++18pr/IgVIm06+JLTlgrvH7hLVg1EUvm7CNmWSKbUL
         IKejoNGpeem2QiKS8rVfdDlKd+YZyXkyWdTa5eUbjzOtIwxHRtkNXx+m50YrL4lDYO4E
         Q73seoojic8SoTjEtOmIB22mwRH8Jm+nGtVPEF6gecYMoR29ExZF1q41oZfwt/KBoFSy
         X/Pw==
X-Gm-Message-State: APuU4Z9k2GNlImykeovjFo40VZACjZ+3du0puvdpv90bkJClDHLGVUsT
	SZuwWQjyfpwPASYSjBTkcQbSIvthcl0lX65NKH2T5PWYkAhFretQQgN5p0Yrzg==
X-Gm-Gg: AYBFou2YYpiGCTeisIDezn28KxWtfvrKroky7Kq24IqKRdHsAk1hrqFC+s7o7f0HYyZ
	HGFr8QyfN8YI9EY/iZ3H9+e0MAF6FtZ9lzXEUI/oMfLU+sBSn55LAO3apqROIBxh0oLBLFa0OKN
	YgAq0KpQzZup8PBu0/0Fuv/16C7m/V3DStwe8TwxpEX+7vMVFgWef3Dz8RDz4MoqN5GbsjXQ10e
	zqQbnPcmIeEIrXnLYxOYVRdQW2rSOUi29NQdQVfIp5p28Ci4E0a51wQ3JMmrrkAQC1RSB0spT+W
	YKdjIrg/LasvNhAKdkkXqSDrw/UpwhINQpAKFkyH4uD+YKZKZrZj1Lb10zvJsHc2i9IVzbQY1eD
	Lb8+15BxktH3bz0vFGkLBHAkAKr8O1f6ImunXYwNnw1qWBBDqSjbceuoAQ5Q5l0G2wmKToshaMB
	suy6C1MfzsQzvXPZui52m4qw1J6lQUdn8eMtl5Qzj733dbBuAJj0A2reis66hfoAPeqKFqaeRq4
	H32XMjV2HvMa7exkgTyUIkbGrtgigZghh9bz5JlkBA1GwAcyDhk1b9Lsle60IusGwv8JN5kpYXw
	cr/0puzQT96ThxRRW6h80jkTDKSpHRJ+KePaFVG3Hd2GpXwVjps9Lg==
X-Received: by 2002:a05:6830:442a:b0:848:8d7d:4e47 with SMTP id 46e09a7af769-8615267812emr5189844a34.10.1794662684214;
        Sat, 14 Nov 2026 05:24:44 -0800 (PST)
Received: from [127.0.0.1] ([20.64.107.197])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862881a907csm5173539a34.24.2026.11.14.05.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 05:24:42 -0800 (PST)
Message-Id: <4b5485584e218e6136835c02a4e9b01ef9a5c574.1794662670.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2425.v7.git.git.1794662670.gitgitgadget@gmail.com>
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
	<pull.2425.v7.git.git.1794662670.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 14 Nov 2026 13:24:30 +0000
Subject: [PATCH v7 4/4] branch: let --delete-integrated find branches merged
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

The merge uses the attributes of this repository, from the working tree
and the index, the same as a merge run here would. A merge driver that
only the upstream repository has is not seen. In a bare repository only
info/attributes and the global file apply.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-branch.adoc | 13 +++--
 builtin/branch.c              | 72 ++++++++++++++++++++++----
 t/t3200-branch.sh             | 95 +++++++++++++++++++++++++++++++++++
 3 files changed, 165 insertions(+), 15 deletions(-)

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
