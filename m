Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795293730;
	b=4SbuQulkMr7DmkVrMnVWpCaVUKiATs2JzdNl8A9aUv4+CiY/rdrz8hJm9A02HPCb4c3e
	 6qzrda6ZGNAdBfzRqsV1z/Lr6l9ETLapmm15ZVjFLuSIIuDq5BhKpKaYCKOvYnpb1Dlho
	 HuXX+eGdJvybF8fUBXSUfDbtAe+y1z9pw9hk+xhuR93wjSYCjdSDQiU0gEtfam/gNdgB+
	 qTICHE8h0KAS52GuVdq9rFK3f8GHwxvoLfFJO2YEpTFk9rCqwgutWFnC55DhniYl0MiMI
	 DoP1+bMUbTuM9eg/FybCLWWf7TFGJbWOAlT45LqJscS0K8dE42iILx8LOWhFefXjaWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795293730;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=Mx/8I0GLwbJePhTd09R+oBj7RATG05oEIj7/r3rtP1k=;
	b=O3tZu8xvj+LRMoIV0OdQJxRsgSYnPankLKElabNhPpKnWEq5zBgmk/cw/qSkZdE/SxKX
	 D+uey9ixaMYNOCKOsg36ibnSBkY6JOhSuvPz9GDUiJZrxrdN+LVpcUf77djAP397bXEnd
	 JnLf2IwPzvR9hVbYjtK7R4mjOfVonJ8tBiIeL3VXK83i/kgMbZo4iH4Pu3Juxf2OENwb8
	 8RRGfRmrXShrK6DcBIjzfHBTpbfyv+gGTIn577s9PWT8oc9FYuENo7tOil8TiPjotbl9n
	 5myZD3tG2ytRfdoU2hUkyj+ZviCv7g6t/ZkAw0gWkBDx/6w5eiViX1x/cfLYcj1AHAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hPxXYIIS;
	arc=none smtp.remote-ip=209.85.222.172
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C607606A334
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 20:42:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C607606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hPxXYIIS
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-93a40a9a01aso389302285a.0
        for <git@vger.kernel.org>; Sat, 21 Nov 2026 12:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795293729; x=1795898529; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Mx/8I0GLwbJePhTd09R+oBj7RATG05oEIj7/r3rtP1k=;
        b=hPxXYIISdd+lXeNZ+Sqaso/8x+qm5cSIxLiab0LCpcdLri142p7Mh1R/5IJQwQ79ci
         NSwZdpgkyRGfR6T4+RX6mprrIq5gQgUJn3LZpJdO4k4IGdkn/MaXW5GdBTV+DWemeCWC
         UrIsf55tZxpWnNG/3vxfmIRaus6JAVaz3eXov+hCEsJm1z1tfbQ5/SbcmRc6yXDoFzSN
         eyhrGORQ0p3fyWPXwHIzusdq2BlgHSkO/FtUx4rbIQ48D75WUMItwYafn1saA+O7CNB7
         2YGGWGmkpni5iUDtZRDJWchav05ncBMYkCVICvXeHDSl8hIM5cVVmNF2SBXICbZtIVdS
         Zang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795293729; x=1795898529;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mx/8I0GLwbJePhTd09R+oBj7RATG05oEIj7/r3rtP1k=;
        b=wzyH/84F2yRUqWu4bBzkJV67/94+iGiD1tF6x4N6D8ttI7aAw/LGn1tmb4kZItIwUi
         ulslfiT0hrzEYBqIeOfM4lBbnZNpxdjvWlHxKjoP5maeueAxrTJHJtBBo4ucDUEM7Sa3
         kN/8ZEVjvwsfBAFXHYjlBhXSxr9xt8VdNlgLbjGxwG6P7EVJHBLMXNSTdIwrR+9CYvAX
         asJoy6ZqZ2/0f0EtmpJUaLq0zQhKa6tvM0EjVyCW7YZ/o3T36CLm/WM8QeEcU+cE1CpF
         xhQgYxF6DvLgqnRBua3h+BAvULQr19wVCBtziGFA37006ZkIumYg5rCwXW5COpnOBIhP
         /66A==
X-Gm-Message-State: APuU4Z+UNnG+HSBL2pzsbvaCen0xlvmwDnnbpc5e/5HbZ+T5i5Bafaz6
	2CsXwoMR6o7TR9EslkzRk3TgvS8ee4xZJpJzP9XXTW3YEzZieSHqgPhszeI7Sw==
X-Gm-Gg: AZFdTZdiEVuc7H2axFiqU+k3qmXmX10W/xZMCyPzBBjIiYhN9EvwNjd7U5m20xJEDw5
	dJBaM18yT689orVZDDUlrtd2GkRROjMG0hX4yf6aMphql655tcuhgzZsQlsxk216PKGFS+WWRwM
	UH5NLcRey1RZiLrwY/61yQ86l8wn+HlwTTbzy8ZvUGebn8pfPTDbxv7whQpWhhFnAQvDvRtWwMq
	63XPbujL4314/w6J/ZdE4apXDDGuLqqeLpF+xdJbyPxDbmGMH9uCGhqBK4uK2tvE0EY8oeJQndi
	2SO85+viOhfg9TI72ZMbh2OQ1HpNyzQXfEFKY0knV/RhB+TRzNzOMtZB7bAPetH7MiRaZD81mT2
	3eavSqiKMB3QXNxJ3xggdrz/GHMIaZXRJIAnwVvdRjUV3WpT0V0AKqu1tz8xz3qduY1kw22rWcQ
	DclYEmF8K8TVW2qXngX7+vwKzgChyeXX8eqUje/xZcJRKq9deRH1IQ/Urx1i5HCietIuwX6PAhZ
	eSv/ovtemZOfgnBfE2JmlSe0pTa/N5Bd1zEhqZNlRx8PDJPLrNz0Tlb3YnshU6tti+RahZFBqcS
	1RimWbYroNRmb7v8buaEAdXAZohRcCQHlg==
X-Received: by 2002:a05:6214:8101:b0:921:2c26:96b8 with SMTP id 6a1803df08f44-92134ad7072mr100533746d6.11.1795293728967;
        Sat, 21 Nov 2026 12:42:08 -0800 (PST)
Received: from [127.0.0.1] ([172.203.213.88])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349f098bsm60557916d6.30.2026.11.21.12.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 12:42:08 -0800 (PST)
Message-Id: <5718110ba2755d7f15777495cf855815ba51bc01.1795293722.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2425.v10.git.git.1795293722.gitgitgadget@gmail.com>
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
	<pull.2425.v10.git.git.1795293722.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 21 Nov 2026 20:42:02 +0000
Subject: [PATCH v10 5/5] branch: let --delete-integrated find branches merged
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

The merge is always the built-in text merge, and merge drivers set
with attributes are not used. A driver that favors one side, as "union"
or a custom driver may, can leave the upstream version unchanged even
though the branch's change is nowhere upstream, and the branch would
then be deleted. A custom driver is also an arbitrary command that a
branch cleanup should not run.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-branch.adoc |  15 ++-
 builtin/branch.c              |  82 +++++++++++++---
 t/t3200-branch.sh             | 180 ++++++++++++++++++++++++++++++++++
 3 files changed, 261 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index 70117f3d14..71abc84d1f 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -240,11 +240,16 @@ remove it anyway.
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
+	That merge is a plain text merge that ignores merge drivers set
+	in linkgit:gitattributes[5]. It reads the file, and in a partial
+	clone it may download blobs. The same rules for which branches
+	are kept apply as for `--delete-merged`.
 
 `--dry-run`::
 	With `-d`, `-D`, `--delete-merged` or `--delete-integrated`,
diff --git a/builtin/branch.c b/builtin/branch.c
index d7065f7fe5..eb38a5bf54 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -35,6 +35,7 @@
 #include "hex.h"
 #include "revision.h"
 #include "tree-walk.h"
+#include "xdiff-interface.h"
 
 static const char * const builtin_branch_usage[] = {
 	N_("git branch [<options>] [-r | -a] [--merged] [--no-merged] [(--forked <branch>)...]"),
@@ -853,10 +854,17 @@ static int branch_pushes_to_upstream(struct branch *branch,
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
@@ -888,32 +896,84 @@ static void collect_branch_changes(struct landing_search *search,
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
+static bool mergeable_as_text(const mmfile_t *file)
+{
+	return file->size <= MAX_XDIFF_SIZE &&
+	       !buffer_is_binary(file->ptr, file->size);
+}
+
+static int merge_keeps_upstream(const struct branch_change *change)
+{
+	mmfile_t base, upstream, branch;
+	mmfile_t result = { 0 };
+	xmparam_t xmp = { .level = XDL_MERGE_ZEALOUS };
+	int ret;
+
+	read_mmblob(&base, the_repository->objects, &change->base_oid);
+	read_mmblob(&upstream, the_repository->objects, &change->upstream_oid);
+	read_mmblob(&branch, the_repository->objects, &change->branch_oid);
+	ret = mergeable_as_text(&base) && mergeable_as_text(&upstream) &&
+	      mergeable_as_text(&branch) &&
+	      !xdl_merge(&base, &upstream, &branch, &xmp, &result) &&
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
-			   change->path, &oid, &mode) || S_ISDIR(mode))
-		return is_null_oid(&change->branch_oid);
-	return oideq(&oid, &change->branch_oid) &&
-	       mode == change->branch_mode;
+			   change->path, &change->upstream_oid, &mode) ||
+	    S_ISDIR(mode))
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
 
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index e397b8ecb9..41f5a1770f 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -2160,6 +2160,186 @@ test_expect_success '--delete-integrated deletes a squash merged branch that was
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
+test_expect_success '--delete-integrated ignores merge drivers' '
+	(
+		cd upstream &&
+		git checkout next &&
+		test_write_lines 1 2 3 4 5 6 7 8 9 10 >unioned &&
+		git add unioned &&
+		git commit -m "add unioned" &&
+		git checkout main
+	) &&
+	setup_repo_for_delete_merged &&
+	(
+		cd repo &&
+		mkdir -p .git/info &&
+		echo "unioned merge=union" >.git/info/attributes &&
+		git checkout -b drops-line --track origin/next &&
+		test_write_lines 1 2 3 4 6 7 8 9 10 >unioned &&
+		git commit -a -m "drop line 5" &&
+		git push origin drops-line &&
+		git checkout --detach
+	) &&
+	(
+		cd upstream &&
+		git checkout next &&
+		test_write_lines 1 2 3 4 five 6 7 8 9 10 >unioned &&
+		git commit -a -m "edit line 5" &&
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
+		drops-line
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
