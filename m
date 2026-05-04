Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115663E7140
	for <git@vger.kernel.org>; Mon,  4 May 2026 20:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777926094; cv=none; b=QCaXAfgKT9XsdX5NCy2MZNT2tzfdmQoel80kimAcWTtavDs7Hjl3xrBC0QnQ28GahfGdfcLCFfAiTZjVLFMOevydAFJA2t3O/rvlgqh5Wz2ZkctiM/sug5BQQbcfWy+lvstJjhLL+64H8/PZmtX7HeAE+PNXBnfpKlcbOyiW1n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777926094; c=relaxed/simple;
	bh=1O+Ck+h7O3USzbb+Vs3caqnrs/oFo+z5Lwv54oQlu7I=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=stm4a5Q5FqgmPnuIJ5+I1oUrKkpxKA3J7lCU9JBFj4mXHDNEk0auh4CTTgzo8IkqrbLYpqdWuVlUmHQYyLwn7I0PX903G9C24FSKILTnA95mf2Ik5S98tCF7VAFgcUKK9UU7WI5E9eBEwqrNHd+h4ePLhNOexVI7N3llXWOzCyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKFAB8/R; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKFAB8/R"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8eae9229110so764940585a.1
        for <git@vger.kernel.org>; Mon, 04 May 2026 13:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777926092; x=1778530892; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PfFhHvqmnlcSqpGxiDOPZ/UANil5KFrWReRRO1AOaUU=;
        b=RKFAB8/RHB2wT9zEkD0LRnQam5jBxrugs5Az/XuE0Z8kgpdQALLHgdhrIrtoeP+2JD
         RodS+eotjAweWQlAhID40lj7gdRjabNVFkDVNfOja8+ez06va+4ZRyfsmGITYct9pKf8
         xu6fR33/jKDYr7qD7I8BUgdGwORXvtJC+OZjp/hOlqTEZEQjgcWmk+2r7E1zHVb7IUDo
         ++Ar+qU63v9+i1+hJIzIGjbWLORK9JnSDRlsVBGIc/a06K318UTWs18YhXjbIV7otLDE
         7/xqZQ7M8UFaIlSll0OBjpCXuUaQ6M1EGqYCa5ybN+ZlqYDETQlK54JxjW8UxY96PRz8
         FDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777926092; x=1778530892;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PfFhHvqmnlcSqpGxiDOPZ/UANil5KFrWReRRO1AOaUU=;
        b=i1ARv1GcypzADRM8lPDpZtWpLTVRiZ7ZOmX8Bl8ZQUPooLZTYf5ssVrmUJrrIluEoI
         zuRDNVMDBjUfDz5HTh04/o/TPnZ3sp0jlsJ06ewUc87hQfa+MYgjGQN9OI9Z4vGkXruy
         sqn1rjdfCAdsyktYbI5BRYF+yck3ujYNDHL00U51KaZ97K+RlC6SQvh35/fza+y6xJ2K
         6T+RYJDiljdYQlJbxfN4mD/olobX6L26Z9jc7acf3o/B9gtywo6/JM68l6yJA7FWiovt
         BkQsrNe1WfskSo6kyaxh+/cuEEgEHaStUk8YKc58MOMtxSO+33l+RAoCa7kTxDvJJE7o
         H01g==
X-Gm-Message-State: AOJu0YzJ7qN51TILgNHYlaFaOiMrRrNjOqAvxKnUZdlK2t3m02t2U2hc
	0eWQ6r9JmZPouM6QXi2tyyksntmhh1CD0zF5ntnja+9HKH8Jp7OH2K5AtdOc0A==
X-Gm-Gg: AeBDieufHSXbMbTbBRbN54nslFYYJtuWpjC3hC4wm4D95Re0Yv8Dp1GXdU0IZT9O8uw
	KpLYVn09eme2+dbZAV7Rw5jVgXqEqzHFVH1rQE0bgu9HrBAcyUxcQGPIinplzc3AhccfQaJcjgp
	iq7qZISLJUbVo57fc2uUTD0WX21DqxHqK6C7fErtDeUpbo1Qr0AiFAhm/GjFOb8b98Cvav3/FDD
	9xWVvabJzWhDILLsOZrCdkZ7KE+mWChSpzAn9cHydopnIc6u6jMy2dFW/i6jhbY3KuD/PKtAbiI
	+W3LQgTP19eYxk8msR7W/7UQnJvXlEaKdZMfbxVjCtufmuSWmNFwxaibqXC/FYITas7ncO9VmuE
	TOWyo92OIIvAde6Z6iO9JZwTk27Lm9lcvpa2lq5CA8SMJBzQhaXmbq/ttGHN88Vs92iE5rY3oYM
	rh26NuUInBUcYX+OrjS2qu2JTr3jav0F9YE0jI
X-Received: by 2002:a05:620a:c42:b0:8ef:c0b7:9e6b with SMTP id af79cd13be357-902e4dc6046mr62855585a.56.1777926091592;
        Mon, 04 May 2026 13:21:31 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.177.96])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c9229c8sm1244184985a.36.2026.05.04.13.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 13:21:30 -0700 (PDT)
Message-Id: <772cdcaeed69f81d6aa3f60d36f761e58aeb8cf3.1777926079.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2101.v2.git.1777926079.gitgitgadget@gmail.com>
References: <pull.2101.git.1777731354.gitgitgadget@gmail.com>
	<pull.2101.v2.git.1777926079.gitgitgadget@gmail.com>
From: "Taylor Blau via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 04 May 2026 20:21:17 +0000
Subject: [PATCH v2 08/10] path-walk: support `tree:0` filter
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
Cc: christian.couder@gmail.com,
    gitster@pobox.com,
    johannes.schindelin@gmx.de,
    johncai86@gmail.com,
    karthik.188@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    me@ttaylorr.com,
    newren@gmail.com,
    peff@peff.net,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>,
    Taylor Blau <me@ttaylorr.com>

From: Taylor Blau <me@ttaylorr.com>

The `tree:0` object filter omits all trees and blobs from the result,
keeping only commits and tags. Consequently, this filter type should
has a fairly straightforward integration with path-walk, as the decision
to include an object depends only on its type and does not depend on any
path-sensitive state.

Mapping it onto `path_walk_info` is direct: set `info->trees = 0` and
`info->blobs = 0` in `prepare_filters()` when the `LOFC_TREE_DEPTH`
choice is requested with depth zero. The existing code already plumbs
those flags through the rest of the walk:

 - 'walk_objects_by_path()' sets `revs->blob_objects = info->blobs` and
   `revs->tree_objects = info->trees` before `prepare_revision_walk()`,
   so the revision walk doesn't try to enumerate trees or blobs itself.

 - The commit-walk loop short-circuits the root-tree fetch with
   "if (!info->trees && !info->blobs) continue;", so we never even
   look up the root tree, let alone descend into it.

 - `setup_pending_objects()` skips pending trees and blobs based on
   the same flags.

This means the path-walk doesn't allocate or expand any tree structures
at all under `tree:0`, which matches the intended behavior of the
filter.

Non-zero tree-depth filters are not supported. Those depend on the depth
at which a tree is visited, which is a path-walk concept the filter
machinery doesn't currently share with the path-walk API. Reject them in
`prepare_filters()` with a helpful error and let pack-objects fall back
to the regular traversal, the same way it already does for unsupported
filters.

Add coverage in t6601 for both `--all` and a single-branch case to
confirm that no trees or blobs are emitted, and a separate test that
`tree:1` is rejected with the expected error message. Place the new
tests before "setup sparse filter blob" so they run on the original set
of refs, before the orphan branch that the sparse-tree tests create.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-pack-objects.adoc |  4 +--
 path-walk.c                         | 13 +++++++++
 t/t6601-path-walk.sh                | 45 +++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-pack-objects.adoc b/Documentation/git-pack-objects.adoc
index 026061a5bc..3e26f57b92 100644
--- a/Documentation/git-pack-objects.adoc
+++ b/Documentation/git-pack-objects.adoc
@@ -404,8 +404,8 @@ will be automatically changed to version `1`.
 +
 Incompatible with `--delta-islands`. The `--use-bitmap-index` option is
 ignored in the presence of `--path-walk`. Whe `--path-walk` option
-supports the `--filter=<spec>` form `blob:none`, `blob:limit=<n>`, and
-`sparse:<oid>`.
+supports the `--filter=<spec>` form `blob:none`, `blob:limit=<n>`,
+`tree:0`, and `sparse:<oid>`.
 
 
 DELTA ISLANDS
diff --git a/path-walk.c b/path-walk.c
index 700617ee2f..36a1e5b967 100644
--- a/path-walk.c
+++ b/path-walk.c
@@ -564,6 +564,19 @@ static int prepare_filters(struct path_walk_info *info,
 		}
 		return 1;
 
+	case LOFC_TREE_DEPTH:
+		if (options->tree_exclude_depth) {
+			error(_("tree:%lu filter not supported by the path-walk API"),
+			      options->tree_exclude_depth);
+			return 0;
+		}
+		if (info) {
+			info->trees = 0;
+			info->blobs = 0;
+			list_objects_filter_release(options);
+		}
+		return 1;
+
 	case LOFC_SPARSE_OID:
 		if (info) {
 			struct object_id sparse_oid;
diff --git a/t/t6601-path-walk.sh b/t/t6601-path-walk.sh
index 520269dfc6..72e09211e6 100755
--- a/t/t6601-path-walk.sh
+++ b/t/t6601-path-walk.sh
@@ -590,6 +590,51 @@ test_expect_success 'all, blob:limit=3 filter' '
 	test_cmp_sorted expect out
 '
 
+test_expect_success 'all, tree:0 filter' '
+	test-tool path-walk --filter=tree:0 -- --all >out &&
+
+	cat >expect <<-EOF &&
+	0:commit::$(git rev-parse topic)
+	0:commit::$(git rev-parse base)
+	0:commit::$(git rev-parse base~1)
+	0:commit::$(git rev-parse base~2)
+	1:tag:/tags:$(git rev-parse refs/tags/first)
+	1:tag:/tags:$(git rev-parse refs/tags/second.1)
+	1:tag:/tags:$(git rev-parse refs/tags/second.2)
+	1:tag:/tags:$(git rev-parse refs/tags/third)
+	1:tag:/tags:$(git rev-parse refs/tags/fourth)
+	1:tag:/tags:$(git rev-parse refs/tags/tree-tag)
+	1:tag:/tags:$(git rev-parse refs/tags/blob-tag)
+	blobs:0
+	commits:4
+	tags:7
+	trees:0
+	EOF
+
+	test_cmp_sorted expect out
+'
+
+test_expect_success 'topic only, tree:0 filter' '
+	test-tool path-walk --filter=tree:0 -- topic >out &&
+
+	cat >expect <<-EOF &&
+	0:commit::$(git rev-parse topic)
+	0:commit::$(git rev-parse base~1)
+	0:commit::$(git rev-parse base~2)
+	blobs:0
+	commits:3
+	tags:0
+	trees:0
+	EOF
+
+	test_cmp_sorted expect out
+'
+
+test_expect_success 'tree:1 filter is rejected' '
+	test_must_fail test-tool path-walk --filter=tree:1 -- --all 2>err &&
+	test_grep "tree:1 filter not supported by the path-walk API" err
+'
+
 test_expect_success 'setup sparse filter blob' '
 	# Cone-mode patterns: include root, exclude all dirs, include left/
 	cat >patterns <<-\EOF &&
-- 
gitgitgadget

