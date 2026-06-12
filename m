Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BC22F7EF3
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 03:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781233230; cv=none; b=n8J2LH8rlUE5kMt/36M4Jcipga3mrKKikxD+nKUeZJusv6l1XzHR6xG17NXvIViQJRQXjtZDW8wJNoOuCCcNeNo5xFn+4IC98gTVRzdhZSgOCNUW1Gl/hgmATDOiX2TIUpHYwZlS7j0qmcc2+/CoZWPvyDNObdpdsiigXCrKCQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781233230; c=relaxed/simple;
	bh=SSuQPHMNROlAwDvRhK8espOqSyk88IeonxhjKnwTn88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lYLeYMcw8sexVfdmn41tDp6gLXqyFfcCtpeDfWmVb9+vXmnxM0ZnlI/GbUQLziKQhKNp5HEi/Xpu7l/NeBMFRoQWOsGedW/h3++htp1HeZbPBZBnJElQUL+sTsVIRQy99p+I7XhAP4me9TgIU/CqWYnziKnCHanTcpebUG0oGDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKNCcKZq; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKNCcKZq"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-486d0e175e9so391155b6e.3
        for <git@vger.kernel.org>; Thu, 11 Jun 2026 20:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781233228; x=1781838028; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d+/WJPLketynGCcSySKlOP2JyARB7+dqQenD7ZRk3OA=;
        b=jKNCcKZql2RSYxEdmNYvZaYdlo8MLdMqQUb9s5libgwC2TRip3qAHmLpFnNwwzV9Zh
         04qBtmXmWTD7bOr8052Ky8M7WUt00wHdmlFBIP8taHHQ5N58o0PBnG+9sGI3y5K64pdG
         u/eds1Nj1lNpPIdhv1k8eQ3dUZQtt/iBKNQnNu6uBsMtvUvBkgu+5226vvvtoMIWPHwX
         ixuw38dxClTre2pywwHBNpPWuRsBhXLnTO4so7J/zdWqpmYZcvGFR3zT9T29xtmY4oh8
         owjw9A395I+DtpNyJz2ZyEm035an6xI0ShdLSsOpzAaPEX5QooSvdXj2tJtKtkQlUaIv
         8ung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781233228; x=1781838028;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d+/WJPLketynGCcSySKlOP2JyARB7+dqQenD7ZRk3OA=;
        b=Xx6hlyJvTv63cSNRKL2LDnr72CiXl++1fGgYmtI5OD4Bc+RgmGd7Tai5PN2R2U1/jF
         4AFSmDaIhlxqWcfigNtmMNGVcelflXuD8ZpA8awIX4rzKdsVN5OhIgusIyTLeNmynDhV
         RdX7GKR4UQyLBE01YvZats+j+QBPz9k74mClk/oSSTJLoJNEY92Qib61ZlJaafWmO6XE
         jvAFKLYM7ZxRWBikaOgpqgE0U4V2Bv7l6XGssH9HWX08ls1A5gzoyyNXdAiIuhXMKZ01
         O3Y4/bVq87PqFDQtoVIX5M6lm8l/5YwlKnYzoE5F6X55UEbITgcqRJQSRLX7Ju2OrP2g
         QE6A==
X-Gm-Message-State: AOJu0Yx7bMnG+QMlCz9vN5RDh88IhJHLYBQK5/PZQ6h8EZfKqqc3WE4m
	0ZLPnZCrAjHWpQUt5Mv2XovPHe1Mr4fcn/JX0VgfjQ2RKniB3EdpQZsX
X-Gm-Gg: Acq92OFFituv/lWb4edd3vWAI8RyUnYFdH3qzx+ki1aG4qit+VTyi3i+8vyrBVzthhP
	eSV4DsJ25q1G/5tBakIQWtIEGU6iXrcdrQ3iz1AE22Um/6bCnJZTKNkI/fFVkJemgpbmyOUKK3y
	BPoGY9cZlwSKKUcLHA4pt1ZXIxxGQu/+/oTPHy/AdwrIocwJY8CjzTNqes4LKzhw/y3A5JxrgP7
	14kPjUHphr4ex5lHtTpD2bVUO3jPzubW+VZKrLvwrAEbaAtu4L6FD0yuYWPlCN9PODDYLBf5D7W
	3Ur/vi+TnU9JzJN9/I1JNNGx/z5U59qJEYyrKE3RcC4PcSP2zth0mdCUMr5dN6IeF82KpVgCuFN
	gTJ+ttZcxAffeerx7irEeAksMdmzzs5fNBURSx1aHqDzFla75tE0HbPqydeqVUu7P4VQ7M+H/d4
	yD/RY2nqQuUk4KHU5bcFHKjdFlHo7slISmBUo0/HCKkAdfi7t5b70525lRCE6nTyus3umw4/CmJ
	FvLZfMEHP+RvNyxtxKxzhKWlTTqW3CH4rUVjcVQLgZdV78MDpL/iUJkXgCGzZHVs7DrJtQObgAz
	ZTPPbaZCA/o8fsgWoVYkaq9h9QOuJ/rdyIQTf3wtb+rAS3oNpWQ3
X-Received: by 2002:a05:6808:1442:b0:47c:b363:642a with SMTP id 5614622812f47-4872f40fb64mr791918b6e.12.1781233227717;
        Thu, 11 Jun 2026 20:00:27 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([50.237.239.3])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4426abe97c4sm702031fac.7.2026.06.11.20.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 20:00:26 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 11 Jun 2026 20:00:14 -0700
Subject: [PATCH v3 2/3] ref-filter: memoize --contains with generations
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-ref-filter-memoized-contains-v3-2-b26af3dba285@gmail.com>
References: <20260611-ref-filter-memoized-contains-v3-0-b26af3dba285@gmail.com>
In-Reply-To: <20260611-ref-filter-memoized-contains-v3-0-b26af3dba285@gmail.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>, 
 Derrick Stolee <stolee@gmail.com>, Elijah Newren <newren@gmail.com>, 
 Kristofer Karlsson <krka@spotify.com>, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1781233218; l=3957;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=SSuQPHMNROlAwDvRhK8espOqSyk88IeonxhjKnwTn88=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QNJeh20gaOAl+1XjEDy9L1eg3UT4dBqD7K2TJ9KFY97KvatAnvmD6t0VhWJxWj8Xnu8pInfwsIv
 3b1kbVf+C9Q0=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

git branch and git for-each-ref run a separate reachability walk for
each ref considered by --contains and --no-contains. Refs with shared
history therefore traverse the same commits repeatedly.

git tag instead uses a depth-first walk that caches results across
refs. That walk can perform poorly without generation numbers: a
negative check may walk to the root instead of stopping at a nearby
divergence. Generation numbers let it stop below the oldest target.

Use the memoized walk for all ref-filter callers when generation
numbers are available. Keep git tag on its existing path without
generations. Caching still helps when many tags share deep history:
ffc4b8012d (tag: speed up --contains calculation, 2011-06-11) reduced
git tag --contains HEAD~200 in linux-2.6 from 15.417 to 5.329 seconds.

The new shared-history perf test improves from 0.72 to 0.03 seconds. In
a repository with 62,174 remote-tracking refs, running:

    git branch -r --contains c78ae85f3ce7e

improves from 104.365 seconds to 468 milliseconds.

Link: https://lore.kernel.org/git/1445163904-24611-1-git-send-email-Karthik.188@gmail.com/
Link: https://lore.kernel.org/r/20230324191009.GA536967@coredump.intra.peff.net
Link: https://lore.kernel.org/git/20260527070510.3510836-1-krka@spotify.com/
Link: https://lore.kernel.org/r/20260608223430.GA340696@coredump.intra.peff.net
Link: https://lore.kernel.org/r/CAOLa=ZSezQOj56-TezVaAcisUyczxhJmu4VghyFBHcBB_mKJ2A@mail.gmail.com
Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 commit-reach.c              |  3 ++-
 t/perf/p1500-graph-walks.sh | 28 +++++++++++++++++++++++++++-
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 1d34d66fe8..572d2d47ff 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -820,7 +820,8 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
 int commit_contains(struct ref_filter *filter, struct commit *commit,
 		    struct commit_list *list, struct contains_cache *cache)
 {
-	if (filter->with_commit_tag_algo)
+	if (filter->with_commit_tag_algo ||
+	    generation_numbers_enabled(the_repository))
 		return contains_tag_algo(commit, list, cache) == CONTAINS_YES;
 	return repo_is_descendant_of(the_repository, commit, list);
 }
diff --git a/t/perf/p1500-graph-walks.sh b/t/perf/p1500-graph-walks.sh
index 5b23ce5db9..d167b4f7e1 100755
--- a/t/perf/p1500-graph-walks.sh
+++ b/t/perf/p1500-graph-walks.sh
@@ -32,7 +32,16 @@ test_expect_success 'setup' '
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
+	commit=$(git commit-tree HEAD^{tree}) &&
 	git update-ref refs/heads/disjoint-base $commit &&
 
 	git commit-graph write --reachable
@@ -62,6 +71,23 @@ test_perf 'contains: git tag --merged' '
 	xargs git tag --merged=HEAD <tags
 '
 
+test_perf 'contains: git for-each-ref' '
+	git for-each-ref --contains=refs/contains-perf-base --stdin <refs
+'
+
+test_perf 'contains: git branch' '
+	xargs git branch --contains=refs/contains-perf-base <branches
+'
+
+test_perf 'contains: git tag' '
+	xargs git tag --contains=refs/contains-perf-base <tags
+'
+
+test_perf 'contains: synthetic shared history' '
+	git for-each-ref --contains=refs/contains-perf-base \
+		refs/contains-perf/ >/dev/null
+'
+
 test_perf 'is-base check: test-tool reach (refs)' '
 	test-tool reach get_branch_base_for_tip <test-tool-refs
 '

-- 
2.54.0.548.gbe7bb2469c

