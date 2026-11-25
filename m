Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795611196;
	b=LRmX4dZTVLx3ChIK6KBcdMNblc10XigunlD/5BL8dg6AQZR5YxxyXmKMnWZOvplnUznq
	 m2giyvXraaJV+bQyYbdCNfkdL4upWKVTjdcxAnyf8BouboIPuIekU1RZuQdYT1U0wL1gs
	 UIpcDLBkDe+CoV8zPrm1klnrAEnaA+BiTgIhoFu/9B8DAaj/xuaSse13tjyuox47KHqZv
	 R3cV9DqQCAQVlemDQRX5Cic1qpwPci1+qBVQIP3JQ/08w86vlePS1Kpz4c4VMwePcN8hn
	 v1AQ43EtTyzXHtSd/eK1uqMyz/lw7INXz8Fluti/2FzskfYJwvPNgR7/oaMQCjxwM9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795611196;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=bhcdk0aN6UEPRLsDVagHK4AMU/2ndOcxI938D8y5ZDk=;
	b=TPU7ZphHfLk8F3Bcx3DuH4aS/vl9dgVviIhqoxVt78BNen1WEl5j8S07b0WkU2YVpl9I
	 gjPDbu8cW/TNfr/AbspcL9PCcoTdYVmOdxTVGwLaY26wOu6YEKMrH70CNYqL3fvbFbDwg
	 5YNz5OWn3fbhtTnnZPZ/R+Wpz+lFb8e2YBa4WM+WSZv5TNjqCHCxCeYft3jtlzYMw8YwS
	 +Dq4nq3SEclpp0T+zzeol5l8iLFtS15CRh8Oirg4CJnWFAvJ8+5JtWdRJwFr1N/EkaGEh
	 bGqx3O1rj5Tl1Rm/6bWtfGV/g191oAYkyZVeMJ5e7mt7x6e3EPJ9/DLxqSS9Ti+gSSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XU+5XfSu;
	arc=none smtp.remote-ip=209.85.210.41
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B657B606A684
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 12:53:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B657B606A684
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XU+5XfSu
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-862bb0a189aso2778783a34.1
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 04:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795611191; x=1796215991; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bhcdk0aN6UEPRLsDVagHK4AMU/2ndOcxI938D8y5ZDk=;
        b=XU+5XfSu5JieIUudeeq8atN8K2USBxcX7OaEbkJ6E1koNo/TsKkUNvdSIQAZbk/pWv
         Qx69txMJuRGXcdYy0RW1pACvXrw793WhjIqJe/SrnBxphkqTpqLUl0D18ipfwgLWSFQ7
         oh9A179zVdk86Verv1TREuePUomAOaML5qBah5GyHVomR8lEHCvL40TDkZlEKiexYNZs
         7pCdO0eoEfphcmybqN6ObljQ0Fd02WfCu10Ne7gxQwe/v4A6oRq/RF+gfnvf6PaEFaUd
         nAKjLN1okjx4we9hBUXwqEK6UlonsBAuZiAkF/rWcJ+puiMr//BtZTqNNA7MGLp2yUx0
         D6oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795611191; x=1796215991;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bhcdk0aN6UEPRLsDVagHK4AMU/2ndOcxI938D8y5ZDk=;
        b=rsJMWyxoNMDs38DiVHDhm1ioIsLvG0HpMOut1/W6AjaVvgQVtfIdG5AHQncaO9Wje9
         h+Jn6lhdRT1LdTd+ld+gWDEXqm5ftzyxump7TZ2g++cWj9aYjLewo0yrkkvouMRneSmT
         QlmEQQWW+ZKATG2ilDll0ysk9nId2mYwodDYtIlx+b4Mt4DLJNkJLFRhFPNdwxs+sPgE
         ySFatB72YTzL+SBlSuVDq9q8RTxrP2FW6SeY9IGa6r1LrVnFGyJNu+s5uOeBBsDFmjiq
         P7N4qKd0dGc4uz62RkLRRjz/ZnTBwp/NMUPb63mfkNb6Zd9Rw7RVA/35z7hgtvkaioNs
         jAYw==
X-Gm-Message-State: APuU4Z8gH4ke/8c22PmpBrd+y32CiK+6E+4Or2ohrlolLk2K8vZfWLPL
	CVumr3OnJymYIR5cLQY7uNKnqtmiPyxReFHh5FAWtZm+DSXNi9yfPUUQaJguTM9Y
X-Gm-Gg: AZFdTZfRBcuylp1WZaRMnG4vc3A+JIk/Kpx10c73RoJRk4nroVXZLSmMnfrAw72MTrn
	APni9lmmSu0/A3XiSzOChm8RCr5qCSTbwYJe6uInmkEMPpKZoxienG7XEJGXwuiBK9X3bc08Rfu
	PiLPUHyqC3MiYRBdA8zvObY8WR4BGavdxLgzsaFY2MPi8aWRSijeqd+puQELgBFvotXlSdKZWmi
	HMKivH8r5qqWySGAiil3qZOEiojVKJHLTJQTKfZVBswYIdOYZt6F4gUbWfFF9kRZmLIJemQrk1S
	1rTjtGDTOLwYBlOdCe8Rbd8UKnN+0xq50rlOSxl1YuUST+fWtx7y2Y5EI/NGVB8A7/uChHo7AY1
	JUGA5c8B7bis3JKQQzCF/SE3QrfBcnLHpg3QkpWwz4gky7kuWOpdRSb5FLalsyr52xnqL7V5OeL
	iU+dgADOjdGupKYEe6w4mIq8P2Fr9NQultrpPnWCW58Wtr5sBczVrTveakUiIRue1trdzIzI+9M
	v8DG7K/JCYZVaZakz34kyFnzYqHueK6FAoonysqiNohlUb83nB570+m7royXoh3x5VNLl5M7nVS
	0wvPq0jtbJo8p7MAaVKEkFNKkRVW10Y0
X-Received: by 2002:a05:6830:2e13:b0:818:56c:a8f6 with SMTP id 46e09a7af769-8631599b670mr22692597a34.26.1795611190617;
        Wed, 25 Nov 2026 04:53:10 -0800 (PST)
Received: from [127.0.0.1] ([20.12.245.213])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8631692f049sm13186520a34.25.2026.11.25.04.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 04:53:09 -0800 (PST)
Message-Id: <daed6147ec06ce1641cc135789114ee115868193.1795611175.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2425.v11.git.git.1795611175.gitgitgadget@gmail.com>
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
	<pull.2425.v11.git.git.1795611175.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 12:52:55 +0000
Subject: [PATCH v11 5/5] branch: let --delete-integrated find branches merged
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
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
index b496794d78..20945a35ee 100644
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
index bb4c52c69a..d608132e57 100644
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
index deead4be24..b47d52878e 100755
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
