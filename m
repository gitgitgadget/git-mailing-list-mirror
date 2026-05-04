Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17737E56A
	for <git@vger.kernel.org>; Mon,  4 May 2026 00:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777853490; cv=none; b=SBdm6vzY61VZUt+nKwY8qewFQzYPi4UtsROBKT1/RfpVkRYU+hq40vo5BY3Cdd3JcSGoifud01kU4uqgphxRkgWjEZon+wgVgcdF6dOLuPrvZKJ+N7+vOOKMwOpoEAz3UxRWFt1jRcbiGz8d/IEj9FJ9SQjgP8Mxvmlc5XHhAKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777853490; c=relaxed/simple;
	bh=wJubTlNIBsebrUnGRE5SMlY7IBafJOG66GGnkFz7NlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QvnushjFX6q5pF44GvTy4Klf1l6uDWQ46397uGDuTcSO66QWIJSZrhAGhqPODSs2ydDeRGZRXyZVssnIzWD9rwO1Xr3mCRIAQwmLDpYa8rSYT1MJ1IUxZFFaFwhQ2j3mtSI2w+l4lu2M5FBqpn9PrDModuON3us61zYjtS/hAzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=Tu956UC/; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="Tu956UC/"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-79a46260385so42502667b3.3
        for <git@vger.kernel.org>; Sun, 03 May 2026 17:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1777853488; x=1778458288; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J//WEfqUvo6fqnEVirn1uWx6JECG6Jt5n0L0zePrHz4=;
        b=Tu956UC/jB1Q5bQpeY2+DJK++J2CPjMevTys7gZRs6Po2ekn1faMSdoqvwJ5SHHHqT
         OMpbU9H5A1o1Wco1gUzYi33ZT6EyAwioBdzOF+L2qnrBv3HvBx9jGYgu7NMyhqE6aQ9r
         kcVFyBJdoFVfBG2dQp7a2zrkEiKlORU3RpZ1CicEsz7A6mXkoKI1qIt3nnoZ5UrSTb9f
         C0PDvfY8ILDdRD5t0YoOg/BJhH5uNUnk86gLRNgc+OZ4Fo0ubhapU875GN2o2gmOgleK
         CKhTBbxhAaC9eoNNTxfZ4CUeh5Pn/ugcss42b7GGjL3OxTcBg6/Yh1RjsRUDQ4D/BGzk
         8DDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777853488; x=1778458288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J//WEfqUvo6fqnEVirn1uWx6JECG6Jt5n0L0zePrHz4=;
        b=mDsi3C2q6iWJRbEhBvYhyBILIeDz3HJRqzwB3vY1YRUvTrqksLlj+0+bAkhu+gdVRc
         pwJdGhSIp7Twj6pXb+/c+OYp7hF6ghk+kHusFqSUWKfjP3ynYQyYbyDCgp7WaegtJkhT
         RowMm0GF6xwttI6iwcA5sbKDN39nhPEEc+vwesFfysqYDBzbYzKmkNSIoLdZT4YtXmEM
         4J23XLfWCjzGeEiG0l582u0lQ/BY9umYwTGvTp8EDNqCGAZd4jKiC19uGuM67igMTQOE
         nGVAMxk0jMN9nQqhvwvtpEDw674qBc8h64m0nD85UK5KV11NcVf2l6Wl6P/EUYWQHfUI
         sOtg==
X-Gm-Message-State: AOJu0YykFdCvFNiWhLI/NFr424UYI4woSwFDngB94cw6mFlchQug3HqP
	T3KZ3bxw9lnnmWCa0u1vAd2l9kGu5wAcddmdog7N8nQQuqD/gcZV5ME/20VC/J2kk+4kBvqig/x
	r6H8soENP/A==
X-Gm-Gg: AeBDievF8DoMsLvdgb2yrN+hM0fb0fUKNEPM5vaoLB6cKDZ8y2DUKMfkB+zMucU0xX5
	lHVyG6IqAxZeJVVXmjj2DQQ5D2FqoQO55fFqsyi2PUoQ1eSG61UD4kgDBNZLMa5eltn7WMCMiNF
	skBxsd8QG/Q2soFIMFOpt5DcHXHthuAvztDbHaf1fOli5GuuL0ysTWp7oCAVk3WujOvBGZyeLN5
	NXsaW3Uz6hsCdhcqMyRIymBX0r/mZ1QS4mlV6Pxbb/haWUToiv1KmHhePPeVTO/pjtw0F8porMP
	OobhuCJs5/kvV1XADkxH2YVBwdaKZp5AezYRLMvR/qZIYqIoXCDVR35bH8FZjZoANA9c/ktbMhC
	6aqxWovmyYQqjUfqnbJVe45kIx2o28r5M+wIVdAn14r1Pg2Hoec9QgVIZmG3hcRWUW1ssVOLSCo
	kI+WhabvdjXXDESjEBf9mN8QnUcGQMS1wExzZDI6D5nmfXNMhA0y1Fl+qpSkDR1t5UxrgxzEZNo
	26uARqVNp2flS4aNZm1Au2ix+PoUn0iQgAaAW6NcQUfex0cSWj+s/bRiBzJB/PGFfQlMYIfUOzU
	0sQP2ohQW0C/DlnX1FsUfybn/FMzrUs36+T6Sg==
X-Received: by 2002:a05:690c:a018:b0:799:2b4c:1d49 with SMTP id 00721157ae682-7bd7710bb60mr74209017b3.36.1777853487767;
        Sun, 03 May 2026 17:11:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66839f63sm42746107b3.31.2026.05.03.17.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 17:11:27 -0700 (PDT)
Date: Sun, 3 May 2026 20:11:26 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Derrick Stolee <stolee@gmail.com>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 4/7] path-walk: support `combine` filter
Message-ID: <5a4c39d7ae18c2dafa0e9d80ce5aad9ee6db4245.1777853408.git.me@ttaylorr.com>
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
`list_objects_filter_release()` inside each case branch. That works fine
for top-level filters, but `combine` filters need to recurse over its
  child filters without releasing each one in turn (since the parent's
  release iterates the sub array). Split `prepare_filters()` into a
  recursive helper that performs only the mutation, plus a thin wrapper
  that calls the helper and then releases the top-level filter once.

The `LOFC_COMBINE` case in the helper just walks `sub_nr` and recurses;
child filters are released by the wrapper's single
`list_objects_filter_release()` call on the parent (which itself
recursively releases each sub-filter, the same way it always has).

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
---
 Documentation/git-pack-objects.adoc |  8 ++--
 path-walk.c                         | 31 +++++++++-----
 t/t6601-path-walk.sh                | 65 +++++++++++++++++++++++++++++
 3 files changed, 90 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-pack-objects.adoc b/Documentation/git-pack-objects.adoc
index 22c782611d2..6c7bbff5be5 100644
--- a/Documentation/git-pack-objects.adoc
+++ b/Documentation/git-pack-objects.adoc
@@ -404,10 +404,10 @@ will be automatically changed to version `1`.
 +
 Incompatible with `--delta-islands`. Path-walk supports
 the `--filter=<spec>` forms `blob:none`, `blob:limit=<n>`,
-`sparse:oid=<blob>`, `tree:0`, and `object:type=<type>`. Other filter
-forms fall back to the regular object traversal. The
-`--use-bitmap-index` option will be ignored in the presence of
-`--path-walk`.
+`sparse:oid=<blob>`, `tree:0`, `object:type=<type>`, and `combine:`
+over any of those. Other filter forms fall back to the regular object
+traversal. The `--use-bitmap-index` option will be ignored in the
+presence of `--path-walk`.
 
 
 DELTA ISLANDS
diff --git a/path-walk.c b/path-walk.c
index b9902abbb75..6d66da3dc3b 100644
--- a/path-walk.c
+++ b/path-walk.c
@@ -539,28 +539,26 @@ static int setup_pending_objects(struct path_walk_info *info,
 	return 0;
 }
 
-static int prepare_filters(struct path_walk_info *info,
-			   struct list_objects_filter_options *options)
+static int prepare_filters_one(struct path_walk_info *info,
+			       struct list_objects_filter_options *options)
 {
 	switch (options->choice) {
 	case LOFC_DISABLED:
 		return 1;
 
 	case LOFC_BLOB_NONE:
-		if (info) {
+		if (info)
 			info->blobs = 0;
-			list_objects_filter_release(options);
-		}
 		return 1;
 
 	case LOFC_BLOB_LIMIT:
 		if (info) {
 			if (!options->blob_limit_value) {
 				info->blobs = 0;
-			} else {
+			} else if (!info->blob_limit ||
+				   options->blob_limit_value < info->blob_limit) {
 				info->blob_limit = options->blob_limit_value;
 			}
-			list_objects_filter_release(options);
 		}
 		return 1;
 
@@ -573,7 +571,6 @@ static int prepare_filters(struct path_walk_info *info,
 		if (info) {
 			info->trees = 0;
 			info->blobs = 0;
-			list_objects_filter_release(options);
 		}
 		return 1;
 
@@ -583,7 +580,6 @@ static int prepare_filters(struct path_walk_info *info,
 			info->tags &= options->object_type == OBJ_TAG;
 			info->trees &= options->object_type == OBJ_TREE;
 			info->blobs &= options->object_type == OBJ_BLOB;
-			list_objects_filter_release(options);
 		}
 		return 1;
 
@@ -624,8 +620,13 @@ static int prepare_filters(struct path_walk_info *info,
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
 
@@ -636,6 +637,16 @@ static int prepare_filters(struct path_walk_info *info,
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
index 13016e62ab1..a7d5f0de4ec 100755
--- a/t/t6601-path-walk.sh
+++ b/t/t6601-path-walk.sh
@@ -721,6 +721,71 @@ test_expect_success 'all, object:type=blob filter' '
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
+	blobs:0
+	commits:4
+	tags:7
+	trees:0
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
+	0:blob:a:$(git rev-parse base~2:a)
+	1:blob:left/b:$(git rev-parse base~2:left/b)
+	2:blob:right/c:$(git rev-parse base~2:right/c)
+	3:blob:right/d:$(git rev-parse base~1:right/d)
+	blobs:4
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
2.54.0.4.g6aa0d38a4ec

