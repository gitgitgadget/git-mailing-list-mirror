Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932D53E5585
	for <git@vger.kernel.org>; Sun, 20 Sep 2026 09:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789898018; cv=none; b=gEbPeWpttDAAZqSDWzbIh1TspbDAOjV7ell2ICIjmIqf+BL6y3pDwPUXZw4N4DG6Fy+1o7aO2HKuhhSZcjRSLShxJRIOChAb5oeQ4QuajB3Axsd9hJ2amiT0KeRLb5JJtWgSDhpTZAZPRRhWnSnYZCYOF5KE/WM+/tuXneiY1tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789898018; c=relaxed/simple;
	bh=mhuhHFjde0jXaXLeA4a8KZ0/eJmyozbu3V9j/tTxwSg=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Yk+axXwXvNOnxJaQT+COMZOqWiFVQe3B+2LqGj2Q1L2jo7vr0kXmL8quWnQaXStU87RFZ3lNkCjZNrV39Mg+ryzLgnftex/llE51N5E4Bzn+YA1tWxylZZjhmrKGvCsUsirQ2+kNQp50rifE757RKNwgDkkyVFJ1LLyXsQw36So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3K1d/JZ; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3K1d/JZ"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea4bfb6so877379a12.3
        for <git@vger.kernel.org>; Sun, 20 Sep 2026 02:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789898016; x=1790502816; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=E3++lUQzxEShyCBG4WFkSTRKfxgnJal4tkGIwT7lbZA=;
        b=D3K1d/JZARhIgN8nXP/zzwYGx6CIQ1SYAX+nakGKe39/wGQbr59nxBEOt0U2Cbf3hr
         nIqK/twSnJoVRExjnMojLXCI9WeAYOPuvUvrwI8cWKYqgMVYCCtLRqpklFx3CETJuEcX
         HtZ6aKlYdu58L9KJgYlisxox4fW9Ak7H/QM+tX3j9YDxuA/VS/oSBLLSzG5KI6uFSGGe
         9Mo/gEQP/s2M5spOYLkjY2zTATs76uWw89M8kRRbA4QaACAh6aajWo9NEeXaE/Dd/4tp
         rzw6YC8zH3DUGKaVb5mzaHcc5Uha5rumq45rWa4alTElctIvWnOrFfurjq8zbIsGKkxe
         Rnaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789898016; x=1790502816;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=E3++lUQzxEShyCBG4WFkSTRKfxgnJal4tkGIwT7lbZA=;
        b=K+rcxY6q4UOSV6lRKSLRBEHFGueAJ3OvNd94EMMUxRTONUXvqGaghWL69hicv5hP2f
         B6VaCFehLl3BRyAZVES0k6ybnVioj4uV//o0sUAc348CpEcR8LoeBtAtexmTo/EZDNAx
         nA4+RtfhVwErvZKq2ojYRFp//6LTO1P+BsvIgQIIbY2peqG1pyGaWu6Uug6agJxJgmOQ
         iUPxbIUEcy5MzqIsZP3jWDyuVQ0xMBjpQto8LyX28SOP7NfKlw4mF8oi2EHevWDKoFy3
         2agf55S+ih1QUR4CI+mPL9ZitspWHMR16O7EXtfmYXn3v8nRcgaS/PNOXFUdYWyzKjM4
         2pbA==
X-Gm-Message-State: AFuF++kGEX4WAcFVKD6PgJxRM19fHiBsaDE5wiZjjn7JliVigfiV2G7/
	DRNtEeFS8WGmlQAFE1v/uhZhUxeauyhtQRpXY/inpeFm3mDy/7VGZZXAe6kGuQ==
X-Gm-Gg: AYBFou3owbBRvcbOsUqhCKm0IJOcPS64NUuVD3rrTDSntTIjxJjc4dxQl1zpa/mnxJY
	c7BqK8FNhwkaXnbGiIDnGBBvD9oXInd6D4nMpl1Bi9+QuzmV42euv4INAeY2bV6Yph0TzxbxP/w
	P5d1eyb3cnyb7Hi4FhGRRKUmB3MKV7cTI5YIVDtF9Bgohpv6IcWJNhS7pjgzw7bD+sHU0/8KuX7
	Nm32jClkblyQ63hvL9y2sx17IIJEsTHFAe1IW4sMu0ehH7fipnhf1onUWNIK3zchMmsp/fsqLqJ
	8sKb2o4QULOIG21ngcNhoniUlDM+3Ck2FL/MKOcM6Ak4LZXiN5cPX3P80MXjtJk0lZSjp95fBc3
	2+s0AOpyLsMGa6ScQ8LSz4YrQIPCaCM8Ofq/gZIqehGaRNv7KCcrRwTzO0xlCVd3Fijl5HItEeP
	79vRFltUvOSJ6+vjLyynDi/1tUz307dIbXjD1pg7vvvM+jqZLkyKbLVz4ceFeXqrF43mQq9v6iU
	Q==
X-Received: by 2002:a05:6a20:d52d:b0:3dd:a196:309b with SMTP id adf61e73a8af0-3dda19632b8mr6047676637.75.1789898015659;
        Sun, 20 Sep 2026 02:53:35 -0700 (PDT)
Received: from [127.0.0.1] ([128.24.161.81])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c331d55cfsm14013789eec.30.2026.09.20.02.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 02:53:35 -0700 (PDT)
Message-Id: <pull.2413.git.git.1789898013916.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 20 Sep 2026 09:53:33 +0000
Subject: [PATCH] object-name: explain why <ref>~N fails in a shallow clone
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

Asking for a commit's ancestor with <ref>~N or <ref>^N in a shallow
clone that does not have N commits of history locally fails with a
bare "is not a commit" error, with no indication that the repository
being shallow is the reason, or what to do about it.

Add a hint, shown when the walk runs out of parents exactly at a
recorded shallow boundary, explaining that history was intentionally
truncated there. When <ref> looks like <remote>/<branch> and <remote>
is configured, the suggested command names that remote and branch
directly. For <ref>~N it suggests the exact --deepen needed,
accounting for any history already present instead of just N. For
<ref>^N the suggestion is always --deepen=1, regardless of N: a
shallow boundary commit has no parents recorded locally at all, so
deepening by one generation fetches its complete real parent list in
one step, whether that commit turns out to have one parent or several.
The hint only fires when the search stops at an actual shallow
boundary, not merely because the repository happens to be shallow
elsewhere, so it does not misfire on a short history that is not
shallow-truncated.

The advice is threaded through GET_OID_QUIETLY so it is not shown
during the internal re-resolution some commands do while building a
better error message, which would otherwise print it twice for the
same failing argument.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    object-name: explain why ~N fails in a shallow clone
    
    Asking for a commit's ancestor with <ref>~N in a shallow clone that
    doesn't have N commits of history locally fails with a "is not a commit"
    error, with no indication that the repository being shallow is the
    reason.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2413%2FHaraldNordgren%2Fshallow-history-advice-hint-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2413/HaraldNordgren/shallow-history-advice-hint-v1
Pull-Request: https://github.com/git/git/pull/2413

 Documentation/config/advice.adoc |   4 ++
 advice.c                         |   1 +
 advice.h                         |   1 +
 object-name.c                    |  75 +++++++++++++++++++--
 t/t1500-rev-parse.sh             | 108 +++++++++++++++++++++++++++++++
 5 files changed, 184 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/advice.adoc b/Documentation/config/advice.adoc
index 81f80a9274..5b44037fff 100644
--- a/Documentation/config/advice.adoc
+++ b/Documentation/config/advice.adoc
@@ -128,6 +128,10 @@ all advice messages.
 		give directions on how to proceed from the current state.
 	sequencerInUse::
 		Shown when a sequencer command is already in progress.
+	shallowHistory::
+		Shown when `~<n>` or `^<n>` cannot resolve enough ancestors
+		because history stops at a shallow boundary, to suggest
+		fetching more history.
 	skippedCherryPicks::
 		Shown when linkgit:git-rebase[1] skips a commit that has already
 		been cherry-picked onto the upstream branch.
diff --git a/advice.c b/advice.c
index 63bf8b0c5f..e22706ead5 100644
--- a/advice.c
+++ b/advice.c
@@ -80,6 +80,7 @@ static struct {
 	[ADVICE_RM_HINTS]				= { "rmHints" },
 	[ADVICE_SEQUENCER_IN_USE]			= { "sequencerInUse" },
 	[ADVICE_SET_UPSTREAM_FAILURE]			= { "setUpstreamFailure" },
+	[ADVICE_SHALLOW_HISTORY]			= { "shallowHistory" },
 	[ADVICE_SKIPPED_CHERRY_PICKS]			= { "skippedCherryPicks" },
 	[ADVICE_SPARSE_INDEX_EXPANDED]			= { "sparseIndexExpanded" },
 	[ADVICE_STATUS_AHEAD_BEHIND_WARNING]		= { "statusAheadBehindWarning" },
diff --git a/advice.h b/advice.h
index 66f6cd6a77..e80e3e82cc 100644
--- a/advice.h
+++ b/advice.h
@@ -47,6 +47,7 @@ enum advice_type {
 	ADVICE_RM_HINTS,
 	ADVICE_SEQUENCER_IN_USE,
 	ADVICE_SET_UPSTREAM_FAILURE,
+	ADVICE_SHALLOW_HISTORY,
 	ADVICE_SKIPPED_CHERRY_PICKS,
 	ADVICE_SPARSE_INDEX_EXPANDED,
 	ADVICE_STATUS_AHEAD_BEHIND_WARNING,
diff --git a/object-name.c b/object-name.c
index 4eda8c8eac..0a18d1d2e3 100644
--- a/object-name.c
+++ b/object-name.c
@@ -22,6 +22,7 @@
 #include "repo-settings.h"
 #include "repository.h"
 #include "setup.h"
+#include "shallow.h"
 #include "midx.h"
 #include "commit-reach.h"
 #include "date.h"
@@ -824,9 +825,65 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
 	return 0;
 }
 
+/*
+ * When a "name~<n>" or "name^<n>" walk runs out of parents at "commit",
+ * and that is because "commit" is where this shallow repository's history
+ * was cut off (rather than commit genuinely being a root commit), let the
+ * user know that fetching more history might be what they are after.
+ *
+ * "suggested_depth" is the --deepen value to recommend. For "name^<n>"
+ * this is always 1: deepening by one generation fetches "commit"'s real
+ * parent list in full, whatever it turns out to contain, regardless of
+ * which parent index <n> asked for. If "name" looks like
+ * "<remote>/<branch>" and <remote> is a configured remote, the suggested
+ * command names that remote and branch instead of leaving them as
+ * placeholders.
+ */
+static void advise_if_shallow_cutoff(struct repository *r,
+				     const char *name, int namelen,
+				     struct commit *commit,
+				     unsigned lookup_flags,
+				     int suggested_depth)
+{
+	struct commit_graft *graft;
+	const char *slash;
+	struct strbuf cmd = STRBUF_INIT;
+
+	if (lookup_flags & GET_OID_QUIETLY)
+		return;
+	if (!is_repository_shallow(r))
+		return;
+	graft = lookup_commit_graft(r, &commit->object.oid);
+	if (!graft || graft->nr_parent != -1)
+		return;
+
+	slash = memchr(name, '/', namelen);
+	if (slash) {
+		char *remote_candidate = xstrndup(name, slash - name);
+		if (remote_is_configured(remote_get(remote_candidate), 0))
+			strbuf_addf(&cmd, "git fetch --deepen=%d %s %.*s",
+				    suggested_depth, remote_candidate,
+				    (int)(name + namelen - (slash + 1)), slash + 1);
+		free(remote_candidate);
+	}
+	if (!cmd.len)
+		strbuf_addf(&cmd, "git fetch --deepen=%d <remote> <branch>",
+			    suggested_depth);
+
+	advise_if_enabled(ADVICE_SHALLOW_HISTORY,
+			   _("'%.*s' does not have that many ancestors locally.\n"
+			     "History stops at %s because this repository is a\n"
+			     "shallow clone. To fetch more of it, try:\n"
+			     "\n"
+			     "  %s"),
+			   namelen, name, oid_to_hex(&commit->object.oid), cmd.buf);
+	strbuf_release(&cmd);
+}
+
 static enum get_oid_result get_parent(struct repository *r,
 				      const char *name, int len,
-				      struct object_id *result, int idx)
+				      struct object_id *result, int idx,
+				      unsigned lookup_flags)
 {
 	struct object_id oid;
 	enum get_oid_result ret = get_oid_1(r, name, len, &oid,
@@ -851,13 +908,15 @@ static enum get_oid_result get_parent(struct repository *r,
 		}
 		p = p->next;
 	}
+	advise_if_shallow_cutoff(r, name, len, commit, lookup_flags, 1);
 	return MISSING_OBJECT;
 }
 
 static enum get_oid_result get_nth_ancestor(struct repository *r,
 					    const char *name, int len,
 					    struct object_id *result,
-					    int generation)
+					    int generation,
+					    unsigned lookup_flags)
 {
 	struct object_id oid;
 	struct commit *commit;
@@ -871,8 +930,14 @@ static enum get_oid_result get_nth_ancestor(struct repository *r,
 		return MISSING_OBJECT;
 
 	while (generation--) {
-		if (repo_parse_commit(r, commit) || !commit->parents)
+		if (repo_parse_commit(r, commit))
 			return MISSING_OBJECT;
+		if (!commit->parents) {
+			/* Remaining "generation" plus this failed step is the actual gap. */
+			advise_if_shallow_cutoff(r, name, len, commit,
+						 lookup_flags, generation + 1);
+			return MISSING_OBJECT;
+		}
 		commit = commit->parents->item;
 	}
 	oidcpy(result, &commit->object.oid);
@@ -1119,9 +1184,9 @@ static enum get_oid_result get_oid_1(struct repository *r,
 		else if (num > INT_MAX)
 			return MISSING_OBJECT;
 		if (has_suffix == '^')
-			return get_parent(r, name, len1, oid, num);
+			return get_parent(r, name, len1, oid, num, lookup_flags);
 		/* else if (has_suffix == '~') -- goes without saying */
-		return get_nth_ancestor(r, name, len1, oid, num);
+		return get_nth_ancestor(r, name, len1, oid, num, lookup_flags);
 	}
 
 	ret = peel_onion(r, name, len, oid, lookup_flags);
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 4174ca40c3..4b46ba546d 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -193,6 +193,114 @@ test_expect_success 'rev-parse --is-shallow-repository in non-shallow repo' '
 	test_cmp expect actual
 '
 
+check_shallow_history_advice () {
+	name=$1 oid=$2 cmd=$3 &&
+	grep '^hint:' err >actual &&
+	cat >expect <<-EOF &&
+	hint: '$name' does not have that many ancestors locally.
+	hint: History stops at $oid because this repository is a
+	hint: shallow clone. To fetch more of it, try:
+	hint:
+	hint:   $cmd
+	hint: Disable this message with "git config set advice.shallowHistory false"
+	EOF
+	test_cmp expect actual
+}
+
+test_expect_success 'shallowHistory advice on ~N beyond shallow boundary' '
+	test_commit shallow_advice_1 &&
+	test_commit shallow_advice_2 &&
+	git clone --no-local --depth=1 --branch main --single-branch \
+		.git shallow-advice &&
+	test_when_finished "rm -rf shallow-advice" &&
+	oid=$(git -C shallow-advice rev-parse origin/main) &&
+	test_must_fail git -C shallow-advice rev-parse origin/main~1 2>err &&
+	check_shallow_history_advice origin/main "$oid" \
+		"git fetch --deepen=1 origin main"
+'
+
+test_expect_success 'shallowHistory advice accounts for depth already present' '
+	test_commit shallow_partial_1 &&
+	test_commit shallow_partial_2 &&
+	test_commit shallow_partial_3 &&
+	test_commit shallow_partial_4 &&
+	test_commit shallow_partial_5 &&
+	test_commit shallow_partial_6 &&
+	git clone --no-local --depth=3 --branch main --single-branch \
+		.git shallow-advice-partial &&
+	test_when_finished "rm -rf shallow-advice-partial" &&
+	(
+		cd shallow-advice-partial &&
+		oid=$(git rev-parse origin/main~2) &&
+		test_must_fail git rev-parse origin/main~5 2>err &&
+		check_shallow_history_advice origin/main "$oid" \
+			"git fetch --deepen=3 origin main" &&
+		git fetch --deepen=3 origin &&
+		git rev-parse origin/main~5 &&
+		test_must_fail git rev-parse origin/main~6
+	)
+'
+
+test_expect_success 'shallowHistory advice on ^N (first parent) beyond shallow boundary' '
+	test_commit shallow_caret_1 &&
+	test_commit shallow_caret_2 &&
+	git clone --no-local --depth=1 --branch main --single-branch \
+		.git shallow-advice-caret &&
+	test_when_finished "rm -rf shallow-advice-caret" &&
+	oid=$(git -C shallow-advice-caret rev-parse origin/main) &&
+	test_must_fail git -C shallow-advice-caret rev-parse origin/main^1 2>err &&
+	check_shallow_history_advice origin/main "$oid" \
+		"git fetch --deepen=1 origin main"
+'
+
+test_expect_success 'shallowHistory advice on ^N suggests deepen=1 even for a merge parent' '
+	test_commit shallow_merge_base &&
+	git checkout -q -b shallow-merge-side &&
+	test_commit shallow_merge_side1 &&
+	git checkout -q main &&
+	test_commit shallow_merge_main1 &&
+	git merge -q --no-ff shallow-merge-side -m "shallow merge commit" &&
+	git clone --no-local --depth=1 --branch main --single-branch \
+		.git shallow-advice-merge &&
+	test_when_finished "rm -rf shallow-advice-merge" &&
+	(
+		cd shallow-advice-merge &&
+		oid=$(git rev-parse origin/main) &&
+		test_must_fail git rev-parse origin/main^2 2>err &&
+		check_shallow_history_advice origin/main "$oid" \
+			"git fetch --deepen=1 origin main" &&
+		git fetch -q --deepen=1 origin &&
+		git rev-parse origin/main^1 &&
+		git rev-parse origin/main^2
+	)
+'
+
+test_expect_success 'shallowHistory advice can be disabled' '
+	test_commit shallow_off_1 &&
+	git clone --no-local --depth=1 --branch main --single-branch \
+		.git shallow-advice-off &&
+	test_when_finished "rm -rf shallow-advice-off" &&
+	test_must_fail git -C shallow-advice-off \
+		-c advice.shallowHistory=false rev-parse origin/main~1 2>err &&
+	test_grep ! "^hint:" err
+'
+
+test_expect_success 'shallowHistory advice not shown for a non-shallow repository' '
+	test_must_fail git rev-parse HEAD~100000 2>err &&
+	test_grep ! "^hint:" err
+'
+
+test_expect_success 'shallowHistory advice not shown when resolution succeeds' '
+	test_commit shallow_ok_1 &&
+	test_commit shallow_ok_2 &&
+	test_commit shallow_ok_3 &&
+	git clone --no-local --depth=3 --branch main --single-branch \
+		.git shallow-advice-ok &&
+	test_when_finished "rm -rf shallow-advice-ok" &&
+	git -C shallow-advice-ok rev-parse origin/main~1 >actual 2>err &&
+	test_grep ! "^hint:" err
+'
+
 test_expect_success 'rev-parse --show-object-format in repo' '
 	test_oid algo >expect &&
 	git rev-parse --show-object-format >actual &&

base-commit: d38352cd43ab9745686d697872408bc3249a153f
-- 
gitgitgadget
