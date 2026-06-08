Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2097F2E1EE0
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 03:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780889618; cv=none; b=Fq7liD+OnC8eC+yR3HTQDmX/z4O7H1znld3Dtr0IbGHz0O94zN9XP7t82/HEPQK5m2woKD/DZoJ/FAFSjWIUcANRZ6WoJmoV5w4RvaaFg7grU2/hf8Muf3wnIWj/csq4erCGZ7fntzK7/hKDlORKKD86XxDGNn2MkcbxwQy0mlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780889618; c=relaxed/simple;
	bh=bduxlGWDJocFklnZd3BHcBaXanjHYfKdT5U2ZTVDCv0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=upBmVIX3FshHoWlnUgCPnbc1naCZoj21N5xQm9495WPDMBvi+FRGaRX1XtXqOgD4TawG/OLPaW4FxEeJ83DlUlvJPCQSapULDsGUCYiIQcZjTL2WExY3TZZP+awD5hNejf4j+YUp4dwIzitZPELLc0Vc1I5kKyH7ZAU3M4r7ST8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ild7Sq1S; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ild7Sq1S"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-304d8362a58so2224116eec.1
        for <git@vger.kernel.org>; Sun, 07 Jun 2026 20:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780889616; x=1781494416; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sdU5UpgSZaB+kSRzp0WsOaMXpgxZdjOGkonlWJ0upBs=;
        b=Ild7Sq1SCPzVBbUj+gocBTJgxdvqauuptQyfnYZpVcHSVaOKVG05XiCnUdsL3Td+fv
         Ve+DGheOJe+yTTS4VMqcH04wOptbjOD+wBQqlzzpq64TnPjnCIyImEh2CgHKNEk+m7G3
         xnOUTARUs++wofU5BeI4JguCGDvy+2dN7U+YuOzblcxt2uadNl5cJm+TkgBosjU+cULQ
         sCQZcMp1KfgZEv+//ddc9FT5DLsZfIXxCDt8PGplA1A0ofD5mJZleJl6DKpV89eD/Ey9
         fckbLeIhWzBLWOAby7I7vCFIcnbEh17XKFn+exw9+iHDPJHLm4OtMxne/4GyQq05tAfl
         dUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780889616; x=1781494416;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdU5UpgSZaB+kSRzp0WsOaMXpgxZdjOGkonlWJ0upBs=;
        b=KhPQuD22UXiwt+U6mOHQYlG2TAVXhuxpnL2uLxh9f553LHrOgmO7Av+rcYXPhaza2V
         wq3mSc8zFiqnFfulLIIcWnZ35kZHXbib7UEjn+nvyPe/qV3FSTQfAT4uW67xLnqhrCCi
         JlUsBkbMzBPKIy3pQp2DEZyktPPXYrg/L9SN9RxwiL2v5GQLg5AdH3Oo6W5GuRpIOt5F
         lwW/LrhldsTAoRqMo/buH1/7u7z1FHSnKcLPWi0FkvP4yHIYauMFUpMT3aPkavMixWRK
         GgOWCUKgU0vE8CWnT95mE42Vc+hOb/pW66N4OJ14tphSisNewcrZXynwVnVAJ5B+hRJt
         I+Yw==
X-Gm-Message-State: AOJu0YxO130RqGxU5bX5rpeyaploZad9yhdP9t7vUK1GU3sa/m4Qyjbe
	qlVBSv6ytExjt9Q+olqhTdWIBXRGs6A0f12i3cpBpDJ5T5pLTsEBphy+
X-Gm-Gg: Acq92OGNsplH3ctjeXjeB3VwdW3LDIEEObJM91kklHlJfI/Z1DTkNQL4YJQ8e90y4+K
	t0Bbbf5vWcm0SMdr/FjmXKR5eF7JD6LuNIVCCpIAKeAQzY/pfvHf/xgUBXGrcLzxWe1vc/P0FoS
	QmaI1+7ASqyW5dAts3NoDNvLoEkm8XXfQ7/M+etUDQwzlwgIS3WYvzrbPDlrk8nvPi0EorEv7YN
	lbo132luRRHWs0rOMa1EpRZe6tqJbxbnibijEjC1qp45H1cOUBijX/6qbKRUBDeOlZd+AU5AbP7
	q/oP+BsoQ8kjVF5nGIAXVhTJhQ1Zhvu4Xp+Ys4tWMLbZjHAgMgKZ9MbLLy3n76R7UpOccHMaX78
	zy+5Cb2Dnu82XxEAX72i+oTK7KW57WsYC0ssgvCtXUcbL1ptQIAf6KA7eTf0xMDKlrwlvyuwX3w
	31JPrTE2XL6P8wqo3q8EibYsD7jHsmJrGOajxn+d4jmHUXbhGIMQrsMJFUMAa2ABMbzMpR4Kr7T
	r/8spW27n+4nBd3umNyYM8R8LQZ+xOfmsEZldt7bBVHRe+VucDgmJRFJ5ru4r2BHBndrypWZ3Bp
	u+Zp6j8Rl6CREPo=
X-Received: by 2002:a05:7300:b296:b0:2ef:1d11:18b0 with SMTP id 5a478bee46e88-3078001f4eemr3582025eec.17.1780889615962;
        Sun, 07 Jun 2026 20:33:35 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([12.6.219.27])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db85e10sm15086676eec.7.2026.06.07.20.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 20:33:35 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sun, 07 Jun 2026 20:33:29 -0700
Subject: [PATCH] ref-filter: reuse --contains traversal results
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260607-ref-filter-memoized-contains-v1-1-a1972dde9c76@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrDsQFSL0KtJFMhnbKTUpmSil4
 t2N7fLB52+gnIUVrs0GmVdRSbGivTRADxfvjBKqoTOdNdYMmHnCSV6FM848J/lyQEqxOImKA3n
 re0/kQgt18a61fH778fa3Lv7JVM4n7PsBh7DdOYAAAAA=
X-Change-ID: 20260607-ref-filter-memoized-contains-7cb6b3bccad1
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>, 
 Derrick Stolee <stolee@gmail.com>, Elijah Newren <newren@gmail.com>, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1780889614; l=16261;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=bduxlGWDJocFklnZd3BHcBaXanjHYfKdT5U2ZTVDCv0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QPtlEY/C6kehT/Zg/yOf58bgrRD2u73tTfUspkeqNx6pUAfYVHLupVjxA5oNiQWXpoFxmSGGaoN
 jflaDhEie8w8=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

git branch and git for-each-ref call repo_is_descendant_of() for each
candidate selected by --contains or --no-contains. Each call starts a
new graph walk, so refs with shared history repeatedly traverse the same
commits.

ffc4b8012d (tag: speed up --contains calculation, 2011-06-11) introduced
the tag traversal that caches positive and negative answers across
candidates. ee2bd06b0f (ref-filter: implement '--contains' option,
2015-07-07) preserved the branch and tag implementations when ref-filter
learned --contains. 008ed7df930 (tag.c: use the correct algorithm for
the '--contains' option, 2015-10-18) noted that they should be unified.

Use the memoized traversal for every ref-filter contains check and
remove the implementation selector. The cache records answers for one
fixed target list, so document that callers must clear it before
changing the list.

The memoized depth-first walk assumes acyclic ancestry, but replacement
refs can create cycles. Track commits while they are on the walk. If a
cycle is found, discard partial cache entries and use
repo_is_descendant_of() for that candidate.

The branch and for-each-ref path passed repo_is_descendant_of() through
a Boolean interface. In configurations where it returned -1 for missing
ancestry, ref-filter treated the error as "contains". The memoized path
instead fails when ancestry cannot be parsed, as git tag already did.
During review of the 2018 reachability series, making parse failures
fatal was explicitly deferred because that series was intended to
preserve behavior. Unifying the implementations now makes all callers
fail consistently instead of preserving that accidental Boolean
interpretation.

The added p1500 case uses up to 8,192 packed refs along one first-parent
history. It improves from 0.68 to 0.03 seconds.

On a checkout with 62,174 remote-tracking refs, I ran:

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
milliseconds, respectively, for a 223x speedup. Both commands produced
output with SHA-256
2466f6e2b72aa16b1a2126eddb81c8a1b2764ee251204ac034c191a925aa896f.

Both revisions were rebuilt with the default -O2 flags using Apple clang
21.0.0 on macOS 26.5. The machine was a MacBook Pro (Mac16,6) with a
16-core Apple M4 Max (12 performance and four efficiency cores) and 128
GB RAM.

Link: https://lore.kernel.org/git/1445163904-24611-1-git-send-email-Karthik.188@gmail.com/
Link: https://lore.kernel.org/git/20180723204112.233274-1-jonathantanmy@google.com/
Link: https://lore.kernel.org/git/24424e55-7fa8-d05b-bc39-e14b4d5abcb6@gmail.com/
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 builtin/tag.c                  |  1 -
 commit-reach.c                 | 45 +++++++++++++++++++++++++++++++-----------
 commit-reach.h                 | 15 ++++++++++----
 ref-filter.c                   |  6 ++++--
 ref-filter.h                   |  7 +++----
 t/helper/test-reach.c          | 10 ++--------
 t/perf/p1500-graph-walks.sh    | 24 +++++++++++++++++++++-
 t/t6301-for-each-ref-errors.sh | 18 +++++++++++++++++
 t/t6302-for-each-ref-filter.sh | 21 ++++++++++++++++++++
 t/t6600-test-reach.sh          |  6 ++----
 10 files changed, 117 insertions(+), 36 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index d51c2e3349..9f34d948d4 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -71,7 +71,6 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting,
 
 	if (verify_ref_format(format))
 		die(_("unable to parse format string"));
-	filter->with_commit_tag_algo = 1;
 	filter_and_format_refs(filter, FILTER_REFS_TAGS, sorting, format);
 
 	free(to_free);
diff --git a/commit-reach.c b/commit-reach.c
index 9b3ea46d6f..6e599a3670 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -6,7 +6,6 @@
 #include "decorate.h"
 #include "hex.h"
 #include "prio-queue.h"
-#include "ref-filter.h"
 #include "revision.h"
 #include "tag.h"
 #include "commit-reach.h"
@@ -708,7 +707,8 @@ static int in_commit_list(const struct commit_list *want, struct commit *c)
 
 /*
  * Test whether the candidate is contained in the list.
- * Do not recurse to find out, though, but return -1 if inconclusive.
+ * Do not recurse to find out, though, but return CONTAINS_UNKNOWN if
+ * inconclusive.
  */
 static enum contains_result contains_test(struct commit *candidate,
 					  const struct commit_list *want,
@@ -743,9 +743,9 @@ static void push_to_contains_stack(struct commit *candidate, struct contains_sta
 	contains_stack->contains_stack[contains_stack->nr++].parents = candidate->parents;
 }
 
-static enum contains_result contains_tag_algo(struct commit *candidate,
-					      const struct commit_list *want,
-					      struct contains_cache *cache)
+static enum contains_result contains_algo(struct commit *candidate,
+					  struct commit_list *want,
+					  struct contains_cache *cache)
 {
 	struct contains_stack contains_stack = { 0, 0, NULL };
 	enum contains_result result;
@@ -765,6 +765,7 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
 	if (result != CONTAINS_UNKNOWN)
 		return result;
 
+	*contains_cache_at(cache, candidate) = CONTAINS_IN_PROGRESS;
 	push_to_contains_stack(candidate, &contains_stack);
 	while (contains_stack.nr) {
 		struct contains_stack_entry *entry = &contains_stack.contains_stack[contains_stack.nr - 1];
@@ -776,8 +777,8 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
 			contains_stack.nr--;
 		}
 		/*
-		 * If we just popped the stack, parents->item has been marked,
-		 * therefore contains_test will return a meaningful yes/no.
+		 * A parent may have just been popped and marked, or may still
+		 * be active when replacement refs create a cycle.
 		 */
 		else switch (contains_test(parents->item, want, cache, cutoff)) {
 		case CONTAINS_YES:
@@ -787,21 +788,41 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
 		case CONTAINS_NO:
 			entry->parents = parents->next;
 			break;
+		case CONTAINS_IN_PROGRESS:
+			/*
+			 * Partial negative answers are not safe across a cycle.
+			 * Discard them and use the cycle-safe reachability walk.
+			 */
+			goto cycle;
 		case CONTAINS_UNKNOWN:
+			*contains_cache_at(cache, parents->item) =
+				CONTAINS_IN_PROGRESS;
 			push_to_contains_stack(parents->item, &contains_stack);
 			break;
 		}
 	}
 	free(contains_stack.contains_stack);
 	return contains_test(candidate, want, cache, cutoff);
+
+cycle:
+	free(contains_stack.contains_stack);
+	clear_contains_cache(cache);
+	init_contains_cache(cache);
+
+	result = repo_is_descendant_of(the_repository, candidate, want);
+	if (result < 0)
+		exit(128);
+	*contains_cache_at(cache, candidate) =
+		result ? CONTAINS_YES : CONTAINS_NO;
+	return result ? CONTAINS_YES : CONTAINS_NO;
 }
 
-int commit_contains(struct ref_filter *filter, struct commit *commit,
-		    struct commit_list *list, struct contains_cache *cache)
+int commit_contains(struct commit *commit, struct commit_list *list,
+		    struct contains_cache *cache)
 {
-	if (filter->with_commit_tag_algo)
-		return contains_tag_algo(commit, list, cache) == CONTAINS_YES;
-	return repo_is_descendant_of(the_repository, commit, list);
+	if (!list)
+		return 1;
+	return contains_algo(commit, list, cache) == CONTAINS_YES;
 }
 
 int can_all_from_reach_with_flag(struct object_array *from,
diff --git a/commit-reach.h b/commit-reach.h
index 3f3a563d8a..144dc56275 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -5,7 +5,6 @@
 #include "commit-slab.h"
 
 struct commit_list;
-struct ref_filter;
 struct object_id;
 struct object_array;
 
@@ -73,13 +72,21 @@ int ref_newer(const struct object_id *new_oid, const struct object_id *old_oid);
 enum contains_result {
 	CONTAINS_UNKNOWN = 0,
 	CONTAINS_NO,
-	CONTAINS_YES
+	CONTAINS_YES,
+	CONTAINS_IN_PROGRESS
 };
 
 define_commit_slab(contains_cache, enum contains_result);
 
-int commit_contains(struct ref_filter *filter, struct commit *commit,
-		    struct commit_list *list, struct contains_cache *cache);
+/*
+ * Return whether "commit" is a descendant of any commit in "list". An empty
+ * list matches.
+ *
+ * "cache" records answers for one fixed "list". Clear it before changing the
+ * list.
+ */
+int commit_contains(struct commit *commit, struct commit_list *list,
+		    struct contains_cache *cache);
 
 /*
  * Determine if every commit in 'from' can reach at least one commit
diff --git a/ref-filter.c b/ref-filter.c
index 1da4c0e60d..7788147959 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2991,11 +2991,13 @@ static struct ref_array_item *apply_ref_filter(const struct reference *ref,
 			return NULL;
 		/* We perform the filtering for the '--contains' option... */
 		if (filter->with_commit &&
-		    !commit_contains(filter, commit, filter->with_commit, &filter->internal.contains_cache))
+		    !commit_contains(commit, filter->with_commit,
+				     &filter->internal.contains_cache))
 			return NULL;
 		/* ...or for the `--no-contains' option */
 		if (filter->no_commit &&
-		    commit_contains(filter, commit, filter->no_commit, &filter->internal.no_contains_cache))
+		    commit_contains(commit, filter->no_commit,
+				    &filter->internal.no_contains_cache))
 			return NULL;
 	}
 
diff --git a/ref-filter.h b/ref-filter.h
index 120221b47f..9e14afca9c 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -73,10 +73,9 @@ struct ref_filter {
 	struct commit_list *reachable_from;
 	struct commit_list *unreachable_from;
 
-	unsigned int with_commit_tag_algo : 1,
-		match_as_path : 1,
-		ignore_case : 1,
-		detached : 1;
+	unsigned int match_as_path : 1,
+		     ignore_case : 1,
+		     detached : 1;
 	unsigned int kind,
 		lines;
 	int abbrev,
diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index 5d86a96c17..82235f713e 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -6,7 +6,6 @@
 #include "gettext.h"
 #include "hex.h"
 #include "object-name.h"
-#include "ref-filter.h"
 #include "setup.h"
 #include "string-list.h"
 #include "tag.h"
@@ -138,16 +137,11 @@ int cmd__reach(int ac, const char **av)
 
 		printf("%s(X,_,_,0,0):%d\n", av[1], can_all_from_reach_with_flag(&X_obj, 2, 4, 0, 0));
 	} else if (!strcmp(av[1], "commit_contains")) {
-		struct ref_filter filter = REF_FILTER_INIT;
 		struct contains_cache cache;
 		init_contains_cache(&cache);
 
-		if (ac > 2 && !strcmp(av[2], "--tag"))
-			filter.with_commit_tag_algo = 1;
-		else
-			filter.with_commit_tag_algo = 0;
-
-		printf("%s(_,A,X,_):%d\n", av[1], commit_contains(&filter, A, X, &cache));
+		printf("%s(_,A,X,_):%d\n", av[1],
+		       commit_contains(A, X, &cache));
 		clear_contains_cache(&cache);
 	} else if (!strcmp(av[1], "get_reachable_subset")) {
 		const int reachable_flag = 1;
diff --git a/t/perf/p1500-graph-walks.sh b/t/perf/p1500-graph-walks.sh
index 5b23ce5db9..ac68fdbacd 100755
--- a/t/perf/p1500-graph-walks.sh
+++ b/t/perf/p1500-graph-walks.sh
@@ -5,6 +5,8 @@ test_description='Commit walk performance tests'
 
 test_perf_large_repo
 
+contains_ref_limit=8192
+
 test_expect_success 'setup' '
 	git for-each-ref --format="%(refname)" "refs/heads/*" "refs/tags/*" >allrefs &&
 	sort -r allrefs | head -n 50 >refs &&
@@ -32,10 +34,25 @@ test_expect_success 'setup' '
 		echo "X:$line" >>test-tool-tags || return 1
 	done &&
 
+	git rev-list --first-parent --max-count=$contains_ref_limit HEAD >contains-commits &&
+	contains_ref_count=$(wc -l <contains-commits) &&
+	test "$contains_ref_count" -gt 0 &&
+	contains_base=$(tail -n 1 contains-commits) &&
+	export contains_base &&
+	awk "{
+		printf \"update refs/contains-perf/%04d %s\\n\", NR, \$1
+	}" contains-commits |
+		git update-ref --stdin &&
+	git pack-refs --include "refs/contains-perf/*" &&
+
 	commit=$(git commit-tree $(git rev-parse HEAD^{tree})) &&
 	git update-ref refs/heads/disjoint-base $commit &&
 
-	git commit-graph write --reachable
+	git commit-graph write --reachable &&
+
+	git for-each-ref --contains="$contains_base" \
+		refs/contains-perf/ >actual &&
+	test_line_count = $contains_ref_count actual
 '
 
 test_perf 'ahead-behind counts: git for-each-ref' '
@@ -62,6 +79,11 @@ test_perf 'contains: git tag --merged' '
 	xargs git tag --merged=HEAD <tags
 '
 
+test_perf 'contains: git for-each-ref --contains' '
+	git for-each-ref --contains="$contains_base" \
+		refs/contains-perf/ >/dev/null
+'
+
 test_perf 'is-base check: test-tool reach (refs)' '
 	test-tool reach get_branch_base_for_tip <test-tool-refs
 '
diff --git a/t/t6301-for-each-ref-errors.sh b/t/t6301-for-each-ref-errors.sh
index e06feb06e9..169cc70c23 100755
--- a/t/t6301-for-each-ref-errors.sh
+++ b/t/t6301-for-each-ref-errors.sh
@@ -52,6 +52,24 @@ test_expect_success 'Missing objects are reported correctly' '
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
+	test_must_fail git for-each-ref --contains=HEAD \
+		refs/heads/missing-parent >out 2>err &&
+	test_must_be_empty out &&
+	test_grep "unable to parse commit $MISSING" err
+'
+
 test_expect_success 'ahead-behind requires an argument' '
 	test_must_fail git for-each-ref \
 		--format="%(ahead-behind)" 2>err &&
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 7f060d97bf..423505d1fb 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -177,6 +177,27 @@ test_expect_success 'filtering with --contains and --no-contains' '
 	test_cmp expect actual
 '
 
+test_expect_success 'contains handles cyclic replacement histories' '
+	one=$(git rev-parse one) &&
+	three=$(git rev-parse three) &&
+	test_when_finished "
+		git replace -d $one
+		git replace -d $three
+		git tag -d cycle-a cycle-b
+	" &&
+	git tag cycle-a "$one" &&
+	git tag cycle-b "$three" &&
+	git replace --graft "$one" "$three" two &&
+	git replace --graft "$three" "$one" &&
+	cat >expect <<-\EOF &&
+	refs/tags/cycle-a
+	refs/tags/cycle-b
+	EOF
+	git for-each-ref --format="%(refname)" --contains=two \
+		"refs/tags/cycle-*" >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success '%(color) must fail' '
 	test_must_fail git for-each-ref --format="%(color)%(refname)"
 '
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index b5b314e570..1ecc2571c2 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -286,8 +286,7 @@ test_expect_success 'commit_contains:hit' '
 	X:commit-9-3
 	EOF
 	echo "commit_contains(_,A,X,_):1" >expect &&
-	test_all_modes commit_contains &&
-	test_all_modes commit_contains --tag
+	test_all_modes commit_contains
 '
 
 test_expect_success 'commit_contains:miss' '
@@ -303,8 +302,7 @@ test_expect_success 'commit_contains:miss' '
 	X:commit-9-3
 	EOF
 	echo "commit_contains(_,A,X,_):0" >expect &&
-	test_all_modes commit_contains &&
-	test_all_modes commit_contains --tag
+	test_all_modes commit_contains
 '
 
 test_expect_success 'rev-list: basic topo-order' '

---
base-commit: 9ac3f193c05c2237e2b14ebaa1149e9fc8a1abe0
change-id: 20260607-ref-filter-memoized-contains-7cb6b3bccad1

Best regards,
--  
Tamir Duberstein <tamird@gmail.com>

