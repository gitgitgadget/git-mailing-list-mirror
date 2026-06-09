Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CB2352C2C
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 02:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780972607; cv=none; b=t67Ib9S6v040XzBxMtZ0zTxK/lUPgLRuMsrhuR922JdoypLiGzgvo/Pqu297Fio8ZlbbvRPMMkiB4NiV2PZvZUY9u1WTMKGS0Iqo0GxihZfqSj3/hFq1OQTLZG62kscrxQkMJbezel7aWhlTmY4EQtU9XeoWi5SGQ3nnKU5O30I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780972607; c=relaxed/simple;
	bh=v3E8Gdem4ItflX8Xg3IjsLM39xpifB65HVU/bFg4wOM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rMRMy459gDwcKzs9unZvxproILg92kwesrikuJAELpunyRo5gALBnqWD7+tB6tjDno9Seuedv0d+d8d6Sk3DWREXmGh1untWUp/x1K5s65Lk0/+sITMkEnM0dSDmOYNO4RrzkzoVk3YYrNFliMTmVp7ijmZFEJPOoo7cap65Ra0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nS9t1xe+; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nS9t1xe+"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51758478240so24549791cf.2
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 19:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780972605; x=1781577405; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KHvRzEacZrPdtMvfNBOMQrKnshRVIn7Cy0xT+dG/t5c=;
        b=nS9t1xe+IsSxqsEq+Wg6W1f8XeOCaXxCPfBZszXQ1EdTY7rKfJY8SgdNprTKguDkz5
         9g5q9f8TWx0bWug2qhlFLU+IE1tuQzV6+hapyfmEa2XiW5Mf4+KvWhaYbPNTSrhzjts5
         aa8c7Lq1gIY2+H2BRL4JQ5/0Lr6WeRMHt6HVB39qRILQx7T14JlxvTq6S/G1NDzw/xhA
         YTWq6jJisOx3Y+ekcEQ+1Ew3jjVC24tl9ya5Bygj6r2vi/CM09LGmQounMjTHNMnt5oI
         cervZ0qK+8bQRX1Tk165+WBGoCSfK1JIcCoCuCVccP6Gbu5q51qTOafDRdywkSLnAH2n
         1Ijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780972605; x=1781577405;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KHvRzEacZrPdtMvfNBOMQrKnshRVIn7Cy0xT+dG/t5c=;
        b=XGd5jY4DN/MgJEJ7EjCDtPvkfO9Wh4StUrXBMWMVWkpt7ui02VA5GWTTMSdn/Qf8UP
         BK4xqnml/nEOyPRJ5mx9/yYP9DuNLMqb8DVpyBEBBBMASMIK3MyTHgLbOVHReXbJ3xvk
         CLwkNghFtkRyaGCJq8CiGrSb9SO8VTJE2LVqEV5lp/iUzPekTTEFCHkji5t038HIza6Z
         HRSbyj8yAi3IZJELfy7jtQtK99sADR+veilaUci6IdzcGk2dooQSP6CahT+6c6OHBaYE
         N0lVJGgU1k2Xw7GkBHJHBKaBrPgYTX9ObHPX1fck6Bf7jaWJjSl3U7xmchlPIz4IjPF0
         PAHg==
X-Gm-Message-State: AOJu0YzfK5UnOHOiYFbgDbEzEEaqwEjFbjJuCFf6tmY4CBheWZ3e8+lE
	71tYKDIWKtdb/czUsYstYHOM+bvTty0A28ONr++TmYD+Te8TIG7Mjfkw
X-Gm-Gg: Acq92OF+I4bXh8zjwQI62Zk3tHMghJb/aCSlX+BP+OJveJXzelkt56XGpn7zudADetS
	Je08MHWKNOZci/buTC/552EUZHBadE9jR6mFno7DF0p2ZqQULGozh+ErrFsW/ROV8UtgStQpoqe
	TmIoGdRNIMCEvIt4uw7O6v+lf/v0ntmrBHezg6prd+oIDdChvt57yRiNbrSWQWMg0a3cj/tsslu
	AfkD1HKtJnUxtpNwZ5FlH3V8ylZywVIEDEv2XP83VUk800aHMzhiDE8qBSvburICCpnDlu0K0I7
	Mch2GVD8m5sK+3h0DU85/rBODxHlVIh5SbSz4Knkim2WlS1T8wdyTG4HtfMojQd9DLvR2ubA6Yi
	QEwl/gfT3wwT04ZJwqQiObY4tpnguFANJJZbpIzcWzRQTKe4OIJ0gkwNYU3qurp/XA9JZm6Zv9o
	mwz1Sz9YO0xfkSqoChutd8Dg2TIvlU0fUSrR9/otWl86p2cgGfqXySd6HZdyxipJtaFF2sYFB/Q
	2zCAZyFRrYCYGSOlCcKXZZFPPYLMZDjQVSIeLdH8PVhzgget1OMd1tNNRyY/Cg1ME+2PWu7CY56
	nAPeOpf8pkewbdavFlAdRtMu3v/Q7RX01yq36H6Mb4DREdBXT4aYvZWa0hggVdfF3V+2FcdmFUl
	c
X-Received: by 2002:a05:622a:4108:b0:50d:83a4:2995 with SMTP id d75a77b69052e-51795b1d1c5mr273291421cf.21.1780972605088;
        Mon, 08 Jun 2026 19:36:45 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([209.249.37.132])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775c08234sm172718611cf.6.2026.06.08.19.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 19:36:44 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 08 Jun 2026 19:36:35 -0700
Subject: [PATCH v2 2/2] ref-filter: memoize --contains with generations
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-ref-filter-memoized-contains-v2-2-e72720344a7c@gmail.com>
References: <20260608-ref-filter-memoized-contains-v2-0-e72720344a7c@gmail.com>
In-Reply-To: <20260608-ref-filter-memoized-contains-v2-0-e72720344a7c@gmail.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>, 
 Derrick Stolee <stolee@gmail.com>, Elijah Newren <newren@gmail.com>, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1780972600; l=8337;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=v3E8Gdem4ItflX8Xg3IjsLM39xpifB65HVU/bFg4wOM=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QPWapVFKgz2HGDTpuh7WH99Llh3Xyi+8SoiyAUXKQTtDF8wBs9f91AcNfOKYw5RWZp9HKowfBW6
 tp7qkt7aHww0=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

git branch and git for-each-ref call repo_is_descendant_of() for
each candidate selected by --contains or --no-contains. Each call
starts a new graph walk, so refs with shared history repeatedly
traverse the same commits.

ffc4b8012d (tag: speed up --contains calculation, 2011-06-11)
introduced a depth-first walk for git tag that caches positive and
negative answers across candidates. ee2bd06b0f (ref-filter: implement
'--contains' option, 2015-07-07) preserved both implementations when
ref-filter learned --contains.

The memoized walk is not always faster. Without generation numbers,
a negative check can walk to the root even when the breadth-first
merge-base walk finds a nearby divergence. With generation numbers,
the depth-first walk can stop below the oldest target while still
reusing answers across candidates.

Keep the existing memoized selection for git tag. Select it for other
ref-filter callers when generation numbers are enabled, and retain
the breadth-first walk otherwise.

When generation numbers are unavailable, repo_is_descendant_of() can
return -1 if ancestry cannot be read. The ref-filter Boolean interface
treated that error as a match. Check it and exit instead. The memoized
path already dies on the same parse failure, so both selected paths now
fail rather than return a result.

Add p1500 cases for up to 8,192 packed refs along one first-parent
history and for sibling refs near the tip with generation numbers
forced off.

On a checkout with 62,174 remote-tracking refs and generation numbers
enabled, I ran:

    hyperfine --warmup 0 --runs 3 \
        --command-name parent \
        '"$parent" branch -r --contains c78ae85f3ce7e >/dev/null' \
        --command-name this-commit \
        '"$this" branch -r --contains c78ae85f3ce7e >/dev/null'

The results were:

             parent       this commit
  elapsed    104.365 s     467.7 ms
  user        93.702 s     220.2 ms
  system       0.723 s     182.7 ms

The wall-time standard deviations were 11.356 seconds and 133.8
milliseconds, respectively. Separate runs without redirection produced
the same output with SHA-256
2466f6e2b72aa16b1a2126eddb81c8a1b2764ee251204ac034c191a925aa896f.

Both revisions were built with the default -O2 flags using Apple
clang 21.0.0 on macOS 26.5. The machine was a MacBook Pro (Mac16,6)
with a 16-core Apple M4 Max (12 performance and four efficiency
cores) and 128 GB RAM.

Link: https://lore.kernel.org/git/1445163904-24611-1-git-send-email-Karthik.188@gmail.com/
Link: https://lore.kernel.org/r/20230324191009.GA536967@coredump.intra.peff.net
Link: https://lore.kernel.org/git/20260527070510.3510836-1-krka@spotify.com/
Link: https://lore.kernel.org/r/20260608223430.GA340696@coredump.intra.peff.net
Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 commit-reach.c                 | 13 +++++++++--
 commit-reach.h                 |  7 ++++++
 t/perf/p1500-graph-walks.sh    | 49 +++++++++++++++++++++++++++++++++++++++++-
 t/t6301-for-each-ref-errors.sh | 22 +++++++++++++++++++
 4 files changed, 88 insertions(+), 3 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 65b618959b..83a48004ef 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -821,9 +821,18 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
 int commit_contains(struct ref_filter *filter, struct commit *commit,
 		    struct commit_list *list, struct contains_cache *cache)
 {
-	if (filter->with_commit_tag_algo)
+	int result;
+
+	if (!list)
+		return 1;
+	if (filter->with_commit_tag_algo ||
+	    generation_numbers_enabled(the_repository))
 		return contains_tag_algo(commit, list, cache) == CONTAINS_YES;
-	return repo_is_descendant_of(the_repository, commit, list);
+
+	result = repo_is_descendant_of(the_repository, commit, list);
+	if (result < 0)
+		exit(128);
+	return result;
 }
 
 int can_all_from_reach_with_flag(struct object_array *from,
diff --git a/commit-reach.h b/commit-reach.h
index f908d305b1..da6796a354 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -79,6 +79,13 @@ enum contains_result {
 
 define_commit_slab(contains_cache, enum contains_result);
 
+/*
+ * Return whether "commit" is a descendant of any commit in "list". An empty
+ * list matches.
+ *
+ * The memoized traversal records answers in "cache" for one fixed "list".
+ * Clear it before changing the list.
+ */
 int commit_contains(struct ref_filter *filter, struct commit *commit,
 		    struct commit_list *list, struct contains_cache *cache);
 
diff --git a/t/perf/p1500-graph-walks.sh b/t/perf/p1500-graph-walks.sh
index 5b23ce5db9..99b54e274b 100755
--- a/t/perf/p1500-graph-walks.sh
+++ b/t/perf/p1500-graph-walks.sh
@@ -32,12 +32,47 @@ test_expect_success 'setup' '
 		echo "X:$line" >>test-tool-tags || return 1
 	done &&
 
-	commit=$(git commit-tree $(git rev-parse HEAD^{tree})) &&
+	git rev-list --first-parent --max-count=8192 HEAD >contains-commits &&
+	test_file_not_empty contains-commits &&
+	git update-ref refs/contains-perf-base "$(tail -n 1 contains-commits)" &&
+	awk "{
+		printf \"update refs/contains-perf/%04d %s\\n\", NR, \$1
+	}" contains-commits |
+		git update-ref --stdin &&
+	git pack-refs --include "refs/contains-perf/*" &&
+
+	tree=$(git rev-parse HEAD^{tree}) &&
+	base=$(git rev-parse HEAD) &&
+	target=$(echo target | git commit-tree "$tree" -p "$base") &&
+	git update-ref refs/contains-diverged/target "$target" &&
+	for i in $(test_seq 1 4)
+	do
+		commit=$(echo candidate-$i |
+			git commit-tree "$tree" -p "$base") &&
+		git update-ref refs/contains-diverged/candidate-$i "$commit" ||
+		return 1
+	done &&
+
+	commit=$(git commit-tree "$tree") &&
 	git update-ref refs/heads/disjoint-base $commit &&
 
 	git commit-graph write --reachable
 '
 
+test_expect_success 'verify contains results' '
+	git for-each-ref --contains=refs/contains-perf-base \
+		refs/contains-perf/ >actual &&
+	test_line_count = $(wc -l <contains-commits) actual &&
+
+	echo refs/contains-diverged/target >expect &&
+	GIT_TEST_COMMIT_GRAPH=0 \
+		git -c core.commitGraph=false for-each-ref \
+			--format="%(refname)" \
+			--contains=refs/contains-diverged/target \
+			refs/contains-diverged/ >actual &&
+	test_cmp expect actual
+'
+
 test_perf 'ahead-behind counts: git for-each-ref' '
 	git for-each-ref --format="%(ahead-behind:HEAD)" --stdin <refs
 '
@@ -62,6 +97,18 @@ test_perf 'contains: git tag --merged' '
 	xargs git tag --merged=HEAD <tags
 '
 
+test_perf 'contains: git for-each-ref --contains' '
+	git for-each-ref --contains=refs/contains-perf-base \
+		refs/contains-perf/ >/dev/null
+'
+
+test_perf 'contains without generations: divergent refs' '
+	GIT_TEST_COMMIT_GRAPH=0 \
+		git -c core.commitGraph=false for-each-ref \
+			--contains=refs/contains-diverged/target \
+			refs/contains-diverged/ >/dev/null
+'
+
 test_perf 'is-base check: test-tool reach (refs)' '
 	test-tool reach get_branch_base_for_tip <test-tool-refs
 '
diff --git a/t/t6301-for-each-ref-errors.sh b/t/t6301-for-each-ref-errors.sh
index e06feb06e9..72b27c8be3 100755
--- a/t/t6301-for-each-ref-errors.sh
+++ b/t/t6301-for-each-ref-errors.sh
@@ -52,6 +52,28 @@ test_expect_success 'Missing objects are reported correctly' '
 	test_must_be_empty brief-err
 '
 
+test_expect_success 'missing ancestors are reported by contains filters' '
+	test_when_finished "git update-ref -d refs/heads/missing-parent" &&
+	{
+		echo "tree $(git rev-parse HEAD^{tree})" &&
+		echo "parent $MISSING" &&
+		git cat-file commit HEAD |
+			sed -n -e "/^author /p" -e "/^committer /p" &&
+		echo &&
+		echo "missing parent"
+	} >commit &&
+	broken=$(git hash-object -t commit -w commit) &&
+	git update-ref refs/heads/missing-parent "$broken" &&
+	for option in --contains --no-contains
+	do
+		test_must_fail git for-each-ref "$option=HEAD" \
+			refs/heads/missing-parent >out 2>err &&
+		test_must_be_empty out &&
+		test_grep "parse commit $MISSING" err ||
+		return 1
+	done
+'
+
 test_expect_success 'ahead-behind requires an argument' '
 	test_must_fail git for-each-ref \
 		--format="%(ahead-behind)" 2>err &&

-- 
2.54.0.501.g0fb508de08

