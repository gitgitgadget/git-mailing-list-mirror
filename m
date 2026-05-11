Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9041B47CC64
	for <git@vger.kernel.org>; Mon, 11 May 2026 18:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778523211; cv=none; b=bgxxXei3QIF6w8ratAcvWG4gmNY0+SmaMMo4RrRZeRwHxTy0qLi4pvqjTLbXSk+82+R08/+MHMnPIfRc05Td3F0b9NaeqJPtnlnwDwacesbueVxlAeqQXm2rq92/1K3dI3enjqggfI6+eVhkJB+cZNIcqjj8hXL5gDwA32RRGws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778523211; c=relaxed/simple;
	bh=R7wSqN7MdYI38lVpCS7y+bF4JcIWVL0G4kmwK+G9iQI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=aXmK1L1UvLkAnecEDXR2tqX/pAZ1Rm1DlLcal+f1SldkyrPz5cLTYHAG/4mmSDQUMdkBpzmK/5lHbYXNpCaIcwuQIGVUAQAzhpqXSnqkQmU4eThgWq4SodxQCOauyREX+dMLYcRrQmS7VuFvFB3OzaUZ3pSOQT1Wz2NEl1F8CnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3LreR4d; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3LreR4d"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7b41fdf9de2so35925637b3.0
        for <git@vger.kernel.org>; Mon, 11 May 2026 11:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778523208; x=1779128008; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNWPAWN26w/mGuRjEqw8UXc3H2PQ1iquoGYecoZb8qI=;
        b=b3LreR4docqFUe2KAq1AD4lgnwuo+01UEzMJARtODYP+eegN7V7rJtwDDccyEh49xV
         k/MplMzKCCHUM5FyikWL4epqaphunQ1JdH1NyFikiZBPqTA8NOeD0Cqiy5tgyciSJt5y
         l+tTllIF1mVxiFEPo6bX9e2MCYGAdQbTKJ9sV8adWmzO/QYskCFyn3grUSt52TROKBQn
         I9SUvKqnC4iN6TK1R27/DYAXytcJ3d8HZEDRoMTMm0HPcsXq8HGWmaFAayfsBPce5DUQ
         Sz7SSD0ZvM/zwmw36k6XdlmpCNgDXbmn63waAAnKQmsDCFJYsqufKRijsMJ3QTNta6ly
         m8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778523208; x=1779128008;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RNWPAWN26w/mGuRjEqw8UXc3H2PQ1iquoGYecoZb8qI=;
        b=ZrifpAYsUYjm44DAl85BcNQdP8GAciOIqdj5gSYBXRbJqLN7mKEAto+GxWIGrPgePG
         lCXB/aOelQapxvtQciIxkUDEDHG1ZDIlzDr9lT93ONh6pxHJKuChsnGF3zHpALBZSqit
         lXLLpo40BNf77n3CqsA8RUGujtH8gl37c9j8HotDzCOLA4WCxpsa7mluNANDXocdJj9y
         aTTDS/QXXyInR2AW41qP8DUfHX6KyL54dn2QlSU4CXs60mHZUeRydK2y56S5Gab2u1m0
         PBLLe+whtKVgrFfM2ZuKhyX1tQcVbJ2PjVGTvXFhc2yK86wXIUlKt+JMHInGwBMv3b5y
         yOXA==
X-Gm-Message-State: AOJu0YzdRJ1cVLLpiRL1bHa0EPOZNGJNzfPxci2AEoO3M9i7mu0t2LKw
	wesfBpd7WMxy1CH0iyW8/YtX6EnazDVdy8HuwtddAH+EnqEmKKqq6gZdnMDmRw==
X-Gm-Gg: Acq92OFeuEPa0nv3xkXiHnkEVs5LgYWvCfans4spD9/d8ngAkZZ9y3PPdrvOKyVeckO
	zAsFI39lV1Nx/29awSWaRx0xC9bOzyfZna2ZFWokqZFwzlOXjmBkYWCc9EZNFJYnqY+wP08YH0y
	OKqGfS+BMZytjji8qBddCgMEW0+JyHYBjePoGEyEZa955fDoewrLTVWWCexNszIXseAiKw9/qoy
	cgtIMADtMKjgRMwo8j8QgUatpkjrq/hgsC4I50pFZjHb3KA3m2WMEad/yNeUYURoAc+eVoZVA5k
	3S8iO8PS7va6ayq+n1O5LcVTHtEaQNp1nKYuDdWiaZ4FhRBg3gQw374Hqdd2zH5B7zLIsT1RCO9
	L/6UXLi5g9B5IXrETNHYvNL5K2SIz5LBor03Wg/Z3py0mNrB7uAnK0GkZHObGigWTGnfhOlxfvf
	oeJr85FJJLeHEEoGDQXeGJPZ41Kg==
X-Received: by 2002:a05:690c:6d83:b0:7bd:73f3:7a8d with SMTP id 00721157ae682-7bfb9e979f8mr141590637b3.42.1778523207974;
        Mon, 11 May 2026 11:13:27 -0700 (PDT)
Received: from [127.0.0.1] ([74.249.78.164])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66838851sm151285027b3.23.2026.05.11.11.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 11:13:27 -0700 (PDT)
Message-Id: <16bd3c3161bb695466c3ba1fc23bc90fee763246.1778523189.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2101.v3.git.1778523189.gitgitgadget@gmail.com>
References: <pull.2101.v2.git.1777926079.gitgitgadget@gmail.com>
	<pull.2101.v3.git.1778523189.gitgitgadget@gmail.com>
From: "Taylor Blau via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 May 2026 18:13:09 +0000
Subject: [PATCH v3 12/12] path-walk: support `combine` filter
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
    Taylor Blau <me@ttaylorr.com>,
    Derrick Stolee <stolee@gmail.com>,
    Taylor Blau <me@ttaylorr.com>

From: Taylor Blau <me@ttaylorr.com>

The `combine` filter takes the intersection of its children, that is:
objects are shown only when all child filters would admit the object.

The preceding patches added support for many individual filter types.
Enable users to compose these filters by implementing support for the
`combine` filter type.

Mapping intersection onto path_walk_info works because every supported
child filter is a monotonic restriction:

 - `blob:none`, `tree:0` unconditionally clear `info->blobs` and (for
   `tree:0`) `info->trees`; clearing an already-cleared flag is a
   no-op.

 - `object:type=X` is now expressed as an AND of each type flag with the
   filtered type, so applying multiple such filters only refines the
   existing set rather than overwrites it.

 - `blob:limit=N` has to compose too: the intersection of "size < L1"
   and "size < L2" is "size < min(L1, L2)".

   Update the `LOFC_BLOB_LIMIT` handler to take the running minimum when
   `info->blob_limit` is already set, so a combined filter with, e.g.,
   both "blob:limit=10" and "blob:limit=5" produces a limit of 5
   regardless of ordering.

 - `sparse:oid` is left unchanged. A `combine` filter that includes a
   `sparse:oid` is allowed at most once, since the existing handler
   refuses to overwrite `info->pl`. Two `sparse:oid` filters in a single
   `combine` would be unusual and are rejected with a warning, matching
   the standalone `sparse:oid` behavior.

Implementation-wise, the existing `prepare_filters()` called
`list_objects_filter_release()` inside each case branch. That works fine for
top-level filters, but `combine` filters need to recurse over its child
filters without releasing each one in turn (since the parent's release
iterates the sub array). Split `prepare_filters()` into a recursive helper
that performs only the mutation, plus a thin wrapper that calls the helper
and then releases the top-level filter once.

The `LOFC_COMBINE` case in the helper just walks `sub_nr` and recurses;
child filters are released by the wrapper's single
`list_objects_filter_release()` call on the parent (which itself recursively
releases each sub-filter, the same way it always has).

If any sub-filter is unsupported (e.g. "tree:1", "sparse:<path>", or a
not-yet-supported choice), the recursion bubbles a failure up and the
existing pack-objects/backfill fallback paths kick in.

Add coverage in t6601:

  - "combine:blob:none+tree:0" collapses to "tree:0"

  - "combine:object:type=blob+blob:limit=3" yields only the blobs
    smaller than three bytes

  - "combine:object:type=blob+object:type=tree" intersects to empty

  - "combine:tree:1+blob:none" reports the "tree:1" error.

Update Documentation/git-pack-objects.adoc to add combine to the
list of supported --filter forms.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-pack-objects.adoc |  3 +-
 path-walk.c                         | 25 ++++++++--
 t/t6601-path-walk.sh                | 71 +++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-pack-objects.adoc b/Documentation/git-pack-objects.adoc
index e96d2c00b3..2fd79f13ad 100644
--- a/Documentation/git-pack-objects.adoc
+++ b/Documentation/git-pack-objects.adoc
@@ -405,7 +405,8 @@ will be automatically changed to version `1`.
 Incompatible with `--delta-islands`. The `--use-bitmap-index` option is
 ignored in the presence of `--path-walk`. Whe `--path-walk` option
 supports the `--filter=<spec>` forms `blob:none`, `blob:limit=<n>`,
-`tree:0`, `object:type=<type>`, and `sparse:<oid>`.
+`tree:0`, `object:type=<type>`, and `sparse:<oid>`. These supported filter
+types can be combined with the `combine:<spec>+<spec>` form.
 
 
 DELTA ISLANDS
diff --git a/path-walk.c b/path-walk.c
index 839505839b..3c67b359f9 100644
--- a/path-walk.c
+++ b/path-walk.c
@@ -573,8 +573,8 @@ static int setup_pending_objects(struct path_walk_info *info,
 	return 0;
 }
 
-static int prepare_filters(struct path_walk_info *info,
-			   struct list_objects_filter_options *options)
+static int prepare_filters_one(struct path_walk_info *info,
+			       struct list_objects_filter_options *options)
 {
 	switch (options->choice) {
 	case LOFC_DISABLED:
@@ -591,7 +591,8 @@ static int prepare_filters(struct path_walk_info *info,
 		if (info) {
 			if (!options->blob_limit_value)
 				info->blobs = 0;
-			else
+			else if (!info->blob_limit ||
+				 info->blob_limit > options->blob_limit_value)
 				info->blob_limit = options->blob_limit_value;
 			list_objects_filter_release(options);
 		}
@@ -606,7 +607,6 @@ static int prepare_filters(struct path_walk_info *info,
 		if (info) {
 			info->trees = 0;
 			info->blobs = 0;
-			list_objects_filter_release(options);
 		}
 		return 1;
 
@@ -658,8 +658,13 @@ static int prepare_filters(struct path_walk_info *info,
 				warning(_("sparse filter is not cone-mode compatible"));
 				return 0;
 			}
+		}
+		return 1;
 
-			list_objects_filter_release(options);
+	case LOFC_COMBINE:
+		for (size_t i = 0; i < options->sub_nr; i++) {
+			if (!prepare_filters_one(info, &options->sub[i]))
+				return 0;
 		}
 		return 1;
 
@@ -670,6 +675,16 @@ static int prepare_filters(struct path_walk_info *info,
 	}
 }
 
+static int prepare_filters(struct path_walk_info *info,
+			   struct list_objects_filter_options *options)
+{
+	if (!prepare_filters_one(info, options))
+		return 0;
+	if (info)
+		list_objects_filter_release(options);
+	return 1;
+}
+
 int path_walk_filter_compatible(struct list_objects_filter_options *options)
 {
 	return prepare_filters(NULL, options);
diff --git a/t/t6601-path-walk.sh b/t/t6601-path-walk.sh
index 0515aaddbf..643d630d2a 100755
--- a/t/t6601-path-walk.sh
+++ b/t/t6601-path-walk.sh
@@ -729,6 +729,77 @@ test_expect_success 'all, object:type=blob filter' '
 	test_cmp_sorted expect out
 '
 
+test_expect_success 'all, combine:blob:none+tree:0 filter' '
+	test-tool path-walk \
+		--filter=combine:blob:none+tree:0 -- --all >out &&
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
+	2:blob:/tagged-blobs:$(git rev-parse refs/tags/blob-tag^{})
+	2:blob:/tagged-blobs:$(git rev-parse refs/tags/blob-tag2^{})
+	3:tree:/tagged-trees:$(git rev-parse refs/tags/tree-tag^{tree})
+	3:tree:/tagged-trees:$(git rev-parse refs/tags/tree-tag2)
+	blobs:2
+	commits:4
+	tags:7
+	trees:2
+	EOF
+
+	test_cmp_sorted expect out
+'
+
+test_expect_success 'all, combine:object:type=blob+blob:limit=3 filter' '
+	test-tool path-walk \
+		--filter=combine:object:type=blob+blob:limit=3 \
+		-- --all >out &&
+
+	cat >expect <<-EOF &&
+	0:blob:/tagged-blobs:$(git rev-parse refs/tags/blob-tag^{})
+	0:blob:/tagged-blobs:$(git rev-parse refs/tags/blob-tag2^{})
+	1:blob:a:$(git rev-parse base~2:a)
+	2:blob:left/b:$(git rev-parse base~2:left/b)
+	3:blob:right/c:$(git rev-parse base~2:right/c)
+	4:blob:right/d:$(git rev-parse base~1:right/d)
+	blobs:6
+	commits:0
+	tags:0
+	trees:0
+	EOF
+
+	test_cmp_sorted expect out
+'
+
+test_expect_success 'all, combine of disjoint object:types is empty' '
+	test-tool path-walk \
+		--filter=combine:object:type=blob+object:type=tree \
+		-- --all >out &&
+
+	cat >expect <<-EOF &&
+	blobs:0
+	commits:0
+	tags:0
+	trees:0
+	EOF
+
+	test_cmp_sorted expect out
+'
+
+test_expect_success 'combine: rejects unsupported subfilters' '
+	test_must_fail test-tool path-walk \
+		--filter=combine:tree:1+blob:none -- --all 2>err &&
+	test_grep "tree:1 filter not supported by the path-walk API" err
+'
+
 test_expect_success 'setup sparse filter blob' '
 	# Cone-mode patterns: include root, exclude all dirs, include left/
 	cat >patterns <<-\EOF &&
-- 
gitgitgadget
