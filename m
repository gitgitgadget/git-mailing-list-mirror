Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3DEF4F1
	for <git@vger.kernel.org>; Mon,  4 May 2026 00:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777853484; cv=none; b=QGYNHeu94hN/OkbzrpzQ2x0YCavOxsAsbEHrI+TFYG3de1GnxeDd8PBmREQXTkHqkkoIug9F0S6Dycct43Surybln9RsVIJgPe9uwDQba/TP39xLUm+q6Wd1duRng7noHcomVUw4l1zFaU8DGZvXo9ci9cXe1pSpjwG35G+Y6uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777853484; c=relaxed/simple;
	bh=VtqHRHTCF4sCteUg7DqSlS/SMz+4EPIZ6QgHfTOGGG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6dkWcLXWnopWd+ofOdBan2ha6pHyHgB2H0uhgp3IzzAf+1clyEEwP9OVN6iumQitTopC61RErOL3ynBpRJMD3w9HSyaP6ZQJultz1ynEzZOGn1wyPyWKv0bhDP398zQ2i3/QBrTYvh9TDdqltdtrPbPMxIsfQryUOj0XK1PzLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=MmGILBSA; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="MmGILBSA"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7bd65714dcaso23314897b3.3
        for <git@vger.kernel.org>; Sun, 03 May 2026 17:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1777853482; x=1778458282; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HI1nqSCx4irgzLBjWziFdfD54bX96pH4rcT6IpliGos=;
        b=MmGILBSAsrlUylp4YUABxGZd55qTuBLHkvjGrpaojCH1VvblCzi/c6Q0ntJ2l8Rhdx
         56VqKkk68FG8ZepsA1bSOsSNHJqGkn2OvKz1xaD3hELZ1IxZodadRtmeDhieaQ08TFrQ
         J73kHp7rET4fTG2QKtOwG8qhhvxW6JWk5ZqA50PCZE8oEOVX7g8sT7QqYJFUHIm8Xm2g
         QwnPSqADe+EMuHsCtdRn+boikaMsjb3kvoHRN7HZzuCw5SixZNjeKSky0AEMgRR6hF2L
         6rKZIsj29FG0T70T+cx3dF5I7QgdMPB47gM6iqg2iZpXyo6Edi8CiztYTl7VAHkXQ5SC
         5SyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777853482; x=1778458282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HI1nqSCx4irgzLBjWziFdfD54bX96pH4rcT6IpliGos=;
        b=IcgzPGyx4hxHI/84Nbg8tTheMEGVkwiO4hYd/2N1r9nzAXkBW5RWMAXZaSYr2D+JMg
         Q2GjiXYLqOe48+SMvhzrAE9JC+ouJ/yoGw7/f+7ggS1m+iiwNl8b10i0PljlFg9Xe1PY
         ve7nlpFkkLf2ProHzVvU6MGgWO+W/Hu5qteCWHpS7G/pM0X6HSU6H9Cth6H9LNXsjDvj
         m0pX+LftcxBIT3+WrQWqNpW+0dW5K3UsXaB7PUVGEummkhnQTZsfP1whUZ+PIapDcyeK
         CATTDFmPkOreFEtCrUN04NyuLcL69bQrf6RtIthFSkklOYobCofr69sqcg2reOFXhm5s
         HOWw==
X-Gm-Message-State: AOJu0Yxq7N25a0HbmxgIl5qu4rTQ9+yAsu8gDXZYo29cxLHHymL9yGYh
	e38qWFzNJ+uLJAaiY4mjTj2CpENicaEK+emHLTA1h6jhIkrlOoq2mAOKzBFXHPFgznMeHez/mCR
	YnKi8VcDyHw==
X-Gm-Gg: AeBDietVUbhJ+522MOXIoCvuw0OLgEmaVr5nX44jfo64R2KplDg6SLqtKS/KRhnjmfU
	bKcUA5G4ejX6ND444Linl2ZYSuHe3GpjE2YJd4EOf7S9NjwulK3eMdC8GY3Qvj61dEcjRswEIFQ
	AOGyeNROvl9V6+YTk4uMzlvRJFR4mPsS8iU1IE7EIrcOQ0SUjf96ABJetPdUoQuCfO5JMPYdpGK
	Cd/EGVI9yUeLFZeVYha05S0WTsY8ijsF1MPesXqXJVa4MbqDtVIsqIsy2CmOnNTB2Efhs/Snyc3
	NyAd5g4e8+vQ9UBQjIj1HJkK9OQhsueUT/9FgENBIZXg/m0yfiRFRAEykytxgWqEhT/UAvayjoO
	rfYN42rV4Kc1fe98dp1X+vX7wNC102JuK6SKNtKhKfWoaUMsZ1VaGx4fFAFlPXLD1Gr4NGTUs18
	NadDmMPtq1H8PQPVqZUinH9sAXILfJjb6ZGAxZZG4bQoDo3XWb9QsMAPfF2B8MwmWX9g/LnLtee
	OcXuQ3mMpC52k7TTjZDMZi5HWC/aaFFHSS0ruNL9KdR188/lAepS8s4rQDCFH/MMVjcftdVEXfL
	NdGHdRWmpUx1kukmbRTT6eDpKf6Qy3/wzzVSkg==
X-Received: by 2002:a05:690c:3181:b0:7ba:f784:579a with SMTP id 00721157ae682-7bd770b39f6mr77545897b3.24.1777853481955;
        Sun, 03 May 2026 17:11:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66558f35sm42191047b3.15.2026.05.03.17.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 17:11:21 -0700 (PDT)
Date: Sun, 3 May 2026 20:11:20 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Derrick Stolee <stolee@gmail.com>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 2/7] path-walk: support `tree:0` filter
Message-ID: <e1b7fd3cb2a2bba5f6404ac5f8ac3487a46d51b5.1777853408.git.me@ttaylorr.com>
References: <cover.1777853408.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1777853408.git.me@ttaylorr.com>

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

Update Documentation/git-pack-objects.adoc to drop --filter from
the unconditional incompatibility list and call out the supported
subset (which already includes the filters added by Stolee's
earlier patches: blob:none, blob:limit, and sparse:oid).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-pack-objects.adoc | 10 +++----
 path-walk.c                         | 13 +++++++++
 t/t6601-path-walk.sh                | 45 +++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-pack-objects.adoc b/Documentation/git-pack-objects.adoc
index 8dea8259787..cfb5bc0ae16 100644
--- a/Documentation/git-pack-objects.adoc
+++ b/Documentation/git-pack-objects.adoc
@@ -402,11 +402,11 @@ will be automatically changed to version `1`.
 	of filenames that cause collisions in Git's default name-hash
 	algorithm.
 +
-Incompatible with `--delta-islands`. Path-walk supports the
-`--filter=<spec>` forms `blob:none`, `blob:limit=<n>`, and
-`sparse:oid=<blob>`. Other filter forms fall back to the regular object
-traversal. The `--use-bitmap-index` option will be ignored in the
-presence of `--path-walk`.
+Incompatible with `--delta-islands`. Path-walk supports
+the `--filter=<spec>` forms `blob:none`, `blob:limit=<n>`,
+`sparse:oid=<blob>`, and `tree:0`. Other filter forms fall back to the
+regular object traversal. The `--use-bitmap-index` option will be
+ignored in the presence of `--path-walk`.
 
 
 DELTA ISLANDS
diff --git a/path-walk.c b/path-walk.c
index 700617ee2fe..36a1e5b967a 100644
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
index 520269dfc65..72e09211e63 100755
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
2.54.0.4.g6aa0d38a4ec

