Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792604041;
	b=uCaPa+IyvReS4f7ER6gkT5TRDtWoDljc0sIVmcto3HM7nj/gEFWP5ktTcy9/8gsB+TW8
	 cNp5Enk/ubv+ueDi/UMqvz09uYmemXAg/AS1lsLBxPjW6VgDAoCFx4Xm88lsTp6ka/Txp
	 a4+Lr6XFTlkS8e1TfR06BHv7JyHxE8fgVtJs/kHpJXC44tpMgYXJ8ZHdaVV9S5XM7a1dI
	 J3wJ/tmXjAx011Ea/KFXFJr2C0jESPu2Qex7ef3zcTMxGykTB2tfZMIVv2rxlipEN1yhF
	 F4DM0tQ1EukKU0slA4Jj0peE+JEnMcmP2M18Zm7pJrW2enkUoXQxAz3UPam0NK6leBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792604041;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NxbM4Uo6Fpbim69GZFiGueqQmb1u0D5p+X2Fh/B7sqg=;
	b=1hUiDhXF3YrKA9288CBVM/kx/tYLBRfAqW6dHLTu7vgMiKEFeH38zZeEh8siLkEd31+h
	 Sv7/C9IFG8sdV4jT97R5PenBHFeAqL/McRYoYsoIeHA0hbtpGmcRn01T9BL/TdjNh2X7y
	 hPBz4d8HbW7/d16MD+2YH0sTdsRc5evkKbVlSF4gYzHT65NiJCZPQOF4l1SDGP2lhAcM8
	 RcVpFU3ugPsV+H7I3oQ/GlR0lwP0k5nh195lU7J4Jhqh9cf389kZ+w3qY9ixOWXINc3uH
	 H0EOPyNIlKXzV79z8h57OfLf3xRI+oTqvWCV6cy7VfaiqBj0C9Keyoei+BD9D2I08dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jaspermayone.com;
	spf=pass smtp.mailfrom=singlefeather.com;
	dkim=pass header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=A1Jhw3Tx;
	arc=none smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38A4606A319
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 17:34:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F38A4606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaspermayone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=singlefeather.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=A1Jhw3Tx
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91ba8fcc684so10254236d6.3
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 10:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jaspermayone.com; s=google; t=1792604040; x=1793208840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NxbM4Uo6Fpbim69GZFiGueqQmb1u0D5p+X2Fh/B7sqg=;
        b=A1Jhw3Txn1LbTwX4eTFoYGqTibj3uIj9lCrtMHbCOeVTfpmDfFAZSyl0lIp/sMTNmO
         HGI89+fEkUcURmeHwwRN++OZmvrWSK1g4zkfuV69YsfVk7kGSa4+KC2/4mzCIUAb1mkd
         NUE/veQ9C6V51zSZTtTGL1OEWxw+LAWHzJ0EpbSzNTt4bU5bU3OicNVzqzS4AOXyYYdw
         BFJxbnILw+nWbCEMe5saO4jQkBTFCTvofMmJNfNeHHLktJKXMzooPZVeRVUGgXowEBGx
         y/oP2g1OpVssXyVKPxadE1e7p+Zx7y6Ky2hl67+nJNp6XOzfWLystS1RFv373Zk2LSBG
         scVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792604040; x=1793208840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NxbM4Uo6Fpbim69GZFiGueqQmb1u0D5p+X2Fh/B7sqg=;
        b=xPtlT+sO4V9uIxIWo/1xU7xmMPymVs/wvsO+URMeCAsJDapnAI7g98PETrbqVHnYcg
         DOe+xgGDNiGf78GNF0xHO/PtZ2ow383vzspRqF9iABfZmqkKS5GpREWswEcmRNp6yA41
         uj+dV/cDh2+wb8uc+9a7yYFeGeYem1vsNPPlb97Zl408ISuQhltoMMlBGzL8rNRkOwXv
         R2Z8fzsUiIVM56e70UBLfjjsqqlTr5lLBPolWj21zc4O9MUrsUFlOA2vOdF5oB+j2pzf
         6lMfBD9NAbv6tA+fZ4vW3gaf9uoPpfTQD60znlVXVBI8o1KUnMtXDXI9UH9Q8C6R/YC7
         M8hw==
X-Gm-Message-State: AFq9FYL5FmBDbzteUsz28NX6ORS49vgmebc8H43NJD7yzO4ESgh72h3+
	18/05sjqIumvppy+xZZJ2KIsbBYhmsuj5Jnz4WNXBG3UOHS25/xK92BGW+vdEXpiK1Uy763GhW1
	8CS2ru3xtjog9itLFJ3XOO4abpCj6tLBNtN5eiSkt8lwM41TVAk0YirpFeA/AMDbKtK2U82Akuz
	rktQtKrloUQefHbIbEFWb7USOesbeO9euhqaukKdYd7E2bz52lWczF88JNtJ7BlD6vuPLD2pCus
	KzE22q4cl1i5u3v8iLllIf/FQy8ru3WzHUmZ+BZ5dKZQQ==
X-Gm-Gg: AYBFou17a7e2AXveeVNt1+4nXQ3+ynxjqD504v4UQzePkdoOt67h3MFky1XHFUlFV9X
	rz9lIg6Kvi4VYSt2bGJzF7FQUu7rM/Nn7+Oz4TxL1TytGLYjxfAe55QUY+l3uen1+6L1zf7M3cF
	5wppL46slbAmhpNiTGFCY96xL0hZkohog0Rf5WtMaxBVR8h1hrJTPwYH8Ldr1CKnk1mlZ1jZ4kU
	Fjh8UA+Agt1QX3SLI03iVnmMfbmkRZUHJzCcDGqOF4sTW8Z1taio3qWdpMLlWBHlwI2/u0ir3oW
	gbQobg0DCzLgzMxSk9+ZnJBxL0P+NpaZ6jM3ewmRpcIIWcEpwZjt+ZkrLIQOwwo4yMMXhyQOfz6
	+UL/r9CAsoQdXkU4nxTGooFGUhJhQ7Zh44qTQ9YaEYTDRpnXArzJevALFbdxxwXY62B/zvsCmwv
	gMOqQodh8808Jq4qWCnA+zcor6sPXwmgi4HC+Sft2qgfJDeORH3nKLVVJamWNvuMeOI3BjU1G+a
	7NXh6LGv6glSMsH8om4k9JJ5GEpgDEMsgPAd5/nh+UGZ2Rxu6suhmpxeNPa2GNI58pWmnWKBI85
	nDQcrPb1cuQdYWXFt6G0OmfozLWrjqjHxW8Hk+8Ul4FS9A15cwuqBHAWTWyphbqH7eiHOaesJDM
	tNySc2q+x7d9W6A6dK3WrxiPdzaCVjo22SDtAaA+Bp+X0cdgRpqtAfq2uaS3dUSVfthLQEdH4U7
	XSdJ0Ia/j8Fh2lIGJyUtNsmfalVEXRjGHG2E04w1HrMm49EORlB3I4pttkDQZCqsp+FrsovQ==
X-Received: by 2002:a05:6214:ac3:b0:914:53ca:99e0 with SMTP id 6a1803df08f44-91c12edf340mr49928096d6.11.1792604039685;
        Wed, 21 Oct 2026 10:33:59 -0700 (PDT)
Received: from remus.wildebeest-stargazer.ts.net ([69.43.66.31])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10b71583sm30001186d6.15.2026.10.21.10.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 10:33:59 -0700 (PDT)
From: Jasper Mayone <me@jaspermayone.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	haraldnordgren@gmail.com,
	sunshine@sunshineco.com,
	ben.knoble@gmail.com,
	Jasper Mayone <me@jaspermayone.com>
Subject: [RFC PATCH 1/1] worktree list: add --merged and --no-merged
Date: Wed, 21 Oct 2026 13:33:37 -0400
Message-ID: <20261021173350.67854-2-me@jaspermayone.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021173350.67854-1-me@jaspermayone.com>
References: <20261021173350.67854-1-me@jaspermayone.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Users who keep one worktree per topic have no direct way to find the
worktrees whose work has already landed. "git branch --merged" lists
the branches, but the user then has to match each branch to a
worktree by hand, and a detached worktree has no branch to match.
"git branch --delete-merged" skips any branch that is checked out in
a worktree, so these are exactly the branches it leaves behind.

Teach "git worktree list" the same --merged and --no-merged filters
that "git branch", "git tag" and "git for-each-ref" have, applied to
the HEAD of each worktree. The options are parsed by the same
OPT_MERGED and OPT_NO_MERGED helpers, so the default (the HEAD of the
current worktree), the error messages and the rules for combining
them are the same: a worktree is shown when its HEAD is reachable
from at least one of the --merged commits and from none of the
--no-merged commits.

A bare worktree, a worktree on an unborn branch, and a worktree whose
HEAD cannot be read have no HEAD commit, so the filters leave them
out. Both output formats are kept, so the result can be used directly
with "--porcelain -z":

    git worktree list --porcelain -z --merged origin/main

Nothing is removed. Removing the worktrees stays a separate step with
"git worktree remove", which already refuses a dirty or locked
worktree.

Signed-off-by: Jasper Mayone <me@jaspermayone.com>
---
 Documentation/git-worktree.adoc |  24 +++++-
 builtin/worktree.c              |  80 +++++++++++++++++++-
 t/t2402-worktree-list.sh        | 125 ++++++++++++++++++++++++++++++++
 3 files changed, 226 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-worktree.adoc b/Documentation/git-worktree.adoc
index e6e77252ab..817766b07c 100644
--- a/Documentation/git-worktree.adoc
+++ b/Documentation/git-worktree.adoc
@@ -11,7 +11,7 @@ SYNOPSIS
 [synopsis]
 git worktree add [-f] [--detach] [--checkout] [--lock [--reason <string>]]
 		 [--orphan] [(-b | -B) <new-branch>] <path> [<commit-ish>]
-git worktree list [-v | --porcelain [-z]]
+git worktree list [-v | --porcelain [-z]] [--merged [<commit>]] [--no-merged [<commit>]]
 git worktree lock [--reason <string>] <worktree>
 git worktree move <worktree> <new-path>
 git worktree prune [-n] [-v] [--expire <expire>]
@@ -114,6 +114,11 @@ whether the worktree is bare, the revision currently checked out, the
 branch currently checked out (or "detached HEAD" if none), "locked" if
 the worktree is locked, "prunable" if the worktree can be pruned by the
 `prune` command.
++
+With `--merged` or `--no-merged`, only the worktrees whose `HEAD` is
+(or is not) reachable from the given commit are listed. This finds the
+worktrees whose work has landed, for example to remove them with
+`git worktree remove`.
 
 `lock`::
 
@@ -268,6 +273,23 @@ mismatch, even if the links are correct.
 	to parse the output when a worktree path contains a newline
 	character.
 
+`--merged [<commit>]`::
+	With `list`, only list worktrees whose `HEAD` is reachable from
+	_<commit>_. _<commit>_ defaults to the `HEAD` of the current
+	worktree.
+
+`--no-merged [<commit>]`::
+	With `list`, only list worktrees whose `HEAD` is not reachable
+	from _<commit>_. _<commit>_ defaults to the `HEAD` of the current
+	worktree.
++
+When `--merged` and `--no-merged` are combined or repeated, only
+worktrees whose `HEAD` is reachable from at least one of the
+`--merged` commits and from none of the `--no-merged` commits are
+listed. With either option, a bare worktree, a worktree on an unborn
+branch, and a worktree whose `HEAD` cannot be read are not listed,
+because they have no `HEAD` commit.
+
 `-q`::
 `--quiet`::
 	With `add`, suppress feedback messages.
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 77ecd0f71f..5db9efb435 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -5,6 +5,7 @@
 #include "abspath.h"
 #include "advice.h"
 #include "checkout.h"
+#include "commit-reach.h"
 #include "config.h"
 #include "copy.h"
 #include "dir.h"
@@ -18,8 +19,10 @@
 #include "strvec.h"
 #include "branch.h"
 #include "read-cache-ll.h"
+#include "ref-filter.h"
 #include "refs.h"
 #include "remote.h"
+#include "revision.h"
 #include "run-command.h"
 #include "hook.h"
 #include "sigchain.h"
@@ -33,7 +36,7 @@
 	   "                 [--orphan] [(-b | -B) <new-branch>] <path> [<commit-ish>]")
 
 #define BUILTIN_WORKTREE_LIST_USAGE \
-	N_("git worktree list [-v | --porcelain [-z]]")
+	N_("git worktree list [-v | --porcelain [-z]] [--merged [<commit>]] [--no-merged [<commit>]]")
 #define BUILTIN_WORKTREE_LOCK_USAGE \
 	N_("git worktree lock [--reason <string>] <worktree>")
 #define BUILTIN_WORKTREE_MOVE_USAGE \
@@ -1125,11 +1128,78 @@ static void pathsort(struct worktree **wt)
 	QSORT(wt, n, pathcmp);
 }
 
+/*
+ * Set result[i] when tips[i] is reachable from one of the commits in
+ * "bases".
+ */
+static void mark_reachable(struct repository *repo,
+			   struct commit **tips, size_t nr,
+			   struct commit_list *bases, int *result)
+{
+	tips_reachable_from_bases(repo, bases, tips, nr, UNINTERESTING);
+	for (size_t i = 0; i < nr; i++)
+		result[i] = !!(tips[i]->object.flags & UNINTERESTING);
+	clear_commit_marks_many(nr, tips, ALL_REV_FLAGS);
+	for (; bases; bases = bases->next)
+		clear_commit_marks(bases->item, ALL_REV_FLAGS);
+}
+
+/*
+ * Keep only the worktrees whose HEAD is reachable from one of the
+ * "--merged" commits and from none of the "--no-merged" commits, like
+ * the ref filters of "git branch". A bare or unborn worktree has no
+ * HEAD commit, and neither has a broken one, so these are dropped.
+ */
+static void filter_merged(struct repository *repo, struct worktree **wt,
+			  struct ref_filter *filter)
+{
+	struct commit **tips = NULL;
+	int *merged, *unmerged;
+	size_t nr = 0, alloc = 0, kept = 0;
+
+	for (size_t i = 0; wt[i]; i++) {
+		struct commit *commit = NULL;
+
+		if (!wt[i]->is_bare && !is_null_oid(&wt[i]->head_oid))
+			commit = lookup_commit_reference_gently(repo,
+								&wt[i]->head_oid, 1);
+		if (!commit) {
+			free_worktree(wt[i]);
+			continue;
+		}
+		ALLOC_GROW(tips, nr + 1, alloc);
+		tips[nr] = commit;
+		wt[nr++] = wt[i];
+	}
+	wt[nr] = NULL;
+
+	CALLOC_ARRAY(merged, nr);
+	CALLOC_ARRAY(unmerged, nr);
+	if (filter->reachable_from)
+		mark_reachable(repo, tips, nr, filter->reachable_from, merged);
+	if (filter->unreachable_from)
+		mark_reachable(repo, tips, nr, filter->unreachable_from,
+			       unmerged);
+
+	for (size_t i = 0; i < nr; i++) {
+		if ((!filter->reachable_from || merged[i]) && !unmerged[i])
+			wt[kept++] = wt[i];
+		else
+			free_worktree(wt[i]);
+	}
+	wt[kept] = NULL;
+
+	free(tips);
+	free(merged);
+	free(unmerged);
+}
+
 static int list(int ac, const char **av, const char *prefix,
-		struct repository *repo UNUSED)
+		struct repository *repo)
 {
 	int porcelain = 0;
 	int line_terminator = '\n';
+	struct ref_filter filter = REF_FILTER_INIT;
 
 	struct option options[] = {
 		OPT_BOOL(0, "porcelain", &porcelain, N_("machine-readable output")),
@@ -1138,6 +1208,8 @@ static int list(int ac, const char **av, const char *prefix,
 				N_("add 'prunable' annotation to missing worktrees older than <time>")),
 		OPT_SET_INT('z', NULL, &line_terminator,
 			    N_("terminate records with a NUL character"), '\0'),
+		OPT_MERGED(&filter, N_("show only worktrees whose HEAD is merged")),
+		OPT_NO_MERGED(&filter, N_("show only worktrees whose HEAD is not merged")),
 		OPT_END()
 	};
 
@@ -1157,6 +1229,9 @@ static int list(int ac, const char **av, const char *prefix,
 		/* sort worktrees by path but keep main worktree at top */
 		pathsort(worktrees + 1);
 
+		if (filter.reachable_from || filter.unreachable_from)
+			filter_merged(repo, worktrees, &filter);
+
 		if (!porcelain)
 			measure_widths(worktrees, &abbrev,
 				       &display, &path_maxwidth);
@@ -1174,6 +1249,7 @@ static int list(int ac, const char **av, const char *prefix,
 		free(display);
 		free_worktrees(worktrees);
 	}
+	ref_filter_clear(&filter);
 	return 0;
 }
 
diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
index eeaf800d74..0e0e3d7f06 100755
--- a/t/t2402-worktree-list.sh
+++ b/t/t2402-worktree-list.sh
@@ -318,4 +318,129 @@ test_expect_success 'worktree path when called in .git directory' '
 	test_cmp list1 list2
 '
 
+test_expect_success 'setup for "list --merged"' '
+	git init merged &&
+	(
+		cd merged &&
+		test_commit base &&
+		git branch landed &&
+		git branch pending &&
+		git worktree add ../wt-landed landed &&
+		git worktree add ../wt-pending pending &&
+		git worktree add --detach ../wt-detached main &&
+		git -C ../wt-landed commit --allow-empty -m landed &&
+		git -C ../wt-pending commit --allow-empty -m pending &&
+		git merge --ff-only landed
+	)
+'
+
+list_paths () {
+	git -C merged worktree list --porcelain "$@" >out &&
+	sed -n "s/^worktree //p" out >actual
+}
+
+test_expect_success '"list --merged" shows only merged worktrees' '
+	list_paths --merged main &&
+	cat >expect <<-EOF &&
+	$(pwd)/merged
+	$(pwd)/wt-detached
+	$(pwd)/wt-landed
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '"list --merged" defaults to the current worktree HEAD' '
+	git -C wt-pending worktree list --porcelain --merged >out &&
+	sed -n "s/^worktree //p" out >actual &&
+	cat >expect <<-EOF &&
+	$(pwd)/wt-detached
+	$(pwd)/wt-pending
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '"list --no-merged" shows only unmerged worktrees' '
+	list_paths --no-merged main &&
+	echo "$(pwd)/wt-pending" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '"list --merged" with several commits' '
+	list_paths --merged main --merged pending --no-merged base &&
+	cat >expect <<-EOF &&
+	$(pwd)/merged
+	$(pwd)/wt-landed
+	$(pwd)/wt-pending
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '"list --merged" keeps the normal output format' '
+	git -C merged worktree list --merged main >out &&
+	sed "s/  */ /g" <out >actual &&
+	cat >expect <<-EOF &&
+	$(pwd)/merged $(git -C merged rev-parse --short main) [main]
+	$(pwd)/wt-detached $(git -C merged rev-parse --short base) (detached HEAD)
+	$(pwd)/wt-landed $(git -C merged rev-parse --short landed) [landed]
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '"list --merged" rejects a bad commit' '
+	test_must_fail git -C merged worktree list --merged no-such-ref 2>err &&
+	test_grep "malformed object name" err &&
+	test_must_fail git -C merged worktree list --merged "main^{tree}" 2>err &&
+	test_grep "must point to a commit" err
+'
+
+test_expect_success '"list --merged" can list nothing' '
+	git -C merged worktree list --merged base --no-merged base >actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success '"list --merged" works with -z' '
+	git -C merged worktree list --porcelain -z --no-merged main >out &&
+	tr "\0" "\n" <out >actual &&
+	cat >expect <<-EOF &&
+	worktree $(pwd)/wt-pending
+	HEAD $(git -C merged rev-parse pending)
+	branch refs/heads/pending
+
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success '"list --merged" works with -v' '
+	test_when_finished "git -C merged worktree unlock wt-landed" &&
+	git -C merged worktree lock --reason "keep it" wt-landed &&
+	git -C merged worktree list -v --merged main >out &&
+	test_grep "^	locked: keep it" out
+'
+
+test_expect_success '"list --[no-]merged" omits unborn and broken worktrees' '
+	test_when_finished "rm -rf wt-unborn wt-broken && git -C merged worktree prune" &&
+	git -C merged worktree add --orphan -b unborn ../wt-unborn &&
+	git -C merged worktree add --detach ../wt-broken main &&
+	echo "$ZERO_OID" >merged/.git/worktrees/wt-broken/HEAD &&
+	git -C merged worktree list --porcelain >out &&
+	test_grep "^worktree $(pwd)/wt-unborn" out &&
+	test_grep "^worktree $(pwd)/wt-broken" out &&
+	git -C merged worktree list --porcelain --merged main >out &&
+	test_grep ! "wt-unborn" out &&
+	test_grep ! "wt-broken" out &&
+	git -C merged worktree list --porcelain --no-merged main >out &&
+	test_grep ! "wt-unborn" out &&
+	test_grep ! "wt-broken" out
+'
+
+test_expect_success '"list --merged" omits a bare main worktree' '
+	test_when_finished "rm -rf bare-merged there" &&
+	git clone --bare merged bare-merged &&
+	git -C bare-merged worktree add --detach ../there main &&
+	git -C bare-merged worktree list --porcelain --merged main >out &&
+	sed -n "s/^worktree //p" out >actual &&
+	git -C there rev-parse --show-toplevel >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.56.0

