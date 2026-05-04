Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F4030EF89
	for <git@vger.kernel.org>; Mon,  4 May 2026 20:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777926097; cv=none; b=W8kbkxyuDpiQPCZllnr7kxSdZFFa9evp9I87tErrpFc1WfAtCl8G24gH8vbEe+zd0u/RJEDRGKdL1RnO/oeshb0fNXQKjYkBg/cC2inNWVPtXPxCVrgn8Jv/HST3VfVjEJzlWGkLz50fC2nFDWA7v7SjhPMRv0AkY+EvJgY5Cyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777926097; c=relaxed/simple;
	bh=xGpTSOY7ZTfQEHyJ1of/aNF6fHpNfBXnqHrub3WXVFE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tPqkcyvjQ0RqzwQXrU9yWn3YsHFSOPHDf+k9CWpn27DgIF9SahcE6rF0n3ThiIW353PQ+zao09kf9L048Pw2JlUBneG1qd71nIkHvGWik1EH6YbkjFRRl6szwDilwMcnWDEePs96jg8norQw4ZYrxNXu1T5m1TS6rA51aG2F3Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OALcRXKH; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OALcRXKH"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50d87c138e1so47241361cf.1
        for <git@vger.kernel.org>; Mon, 04 May 2026 13:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777926094; x=1778530894; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w7apoyCWVXFKpjHDcK6g6ntTZvpTZZYlQSloBbc6UCQ=;
        b=OALcRXKHgu9Ikgs+04sGx1AzWiMNdlQdoTjeOGfP7n0Qk8w0PzaohbLf8Gxx/JD3SK
         fX+Rg3kO9C+hAzPdHAjFR/Sjxy8pQIp5NQDd+w2oYFNqcJTh4mKMXGgXdYfDff1JFLLW
         PPg88IftWv+RwH0uhMvu7J2YqIEE6S+weiaPwtxRgXThKIJTEmxQSYtRUyG8rBr6Rdxf
         C5VDZwqx00/xH7lIc73HGj8bdXnjBUe9qfj9SZwU4JyPOT0qIbaIf15wPdr0EA+GNXIP
         pCvfNIBo9qtDsqtif497nuI1HMtwFY/JMFewPiIyzJmnypFm0pPPq8iYF7PT8Gcj643N
         OL3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777926094; x=1778530894;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w7apoyCWVXFKpjHDcK6g6ntTZvpTZZYlQSloBbc6UCQ=;
        b=RHLi679N+Tm96PC38BAT36JJUxNptefgbgxa79X1fP3xo6kD+FgG98nqdxDe7o8aJe
         /hIJTiMcxM/pdztkz+mlyMb6i5imrwOifnL4KaSuqDJz6PoVP7NEmjat9g4DAy4+ovdq
         PuuBCEXuK0Xzan00AyI/dYzNbBiHynwtWEAFYRhCd7gYr7PxYqEyhLpIAiVw0ooDemUX
         68q1kam+skShmBYt2q2gz50wa4x53C+GmbkVFLZJc6xY1IPkAn3YkOmme2fyC6cJ7S8M
         Ce+UT4TR5aUJpVM3aLtyvacoHIuh64ZdFE3ZkznXr8do1XEgLEH1UY36N0+6exKGFUC+
         7B/A==
X-Gm-Message-State: AOJu0Yy0l+MunDFKweqd5xYOSq2yj5noAPe493UWma7eS+fLUilguxMg
	rSxHOgDSoNpXpnNhPsjKEssJvOb8CNSW39hJzJ6F82qU1oLNCZtG3I1bbgozFA==
X-Gm-Gg: AeBDieuHcTNjjaz1PI8c0RpKh5RMneM151Tf69PWwA1+oNuH87A7Viof94I8gbGUUdG
	ccRVrCPIwqLVRfTliuYndsvIo1DUAVKCpFl5Sd7QNomLCCMp9bVxT0bQdQMrtvkPqAs89yyGUmy
	d6euSGpADtlq0/ukWyfYruNqRfozSSdsTKcbhQ0myglKSFDG61IV2MFyVudbY+V60G/MgLz/39o
	jYcTzrY0fRbRLKfJLAPTcFp3aWr5/mfiK6f272jYAqS/QcBbEEi+vUi4uqbhuckyUAqTM7TkT4n
	Tq025FFn1EphOZTCDi1OH0uBF2ttqB6NGpwUs3VifJSI+RsDRQYEzRd65HHUZEtvCADJoHi2IE1
	GxrF3DFOmAMpFZ0DuPUTS8Nm7QoyFWiVeY+T8NFlh5Ep6zUxHq+GwV8z0LamLpRmw2DNYoSL6HO
	n0rNlpkRZIdYIllYVP41NVQfQCGWjHLweN0DlG
X-Received: by 2002:a05:622a:2c1:b0:4ff:c17b:5ab0 with SMTP id d75a77b69052e-5130698bbeamr3429371cf.9.1777926094086;
        Mon, 04 May 2026 13:21:34 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.177.96])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51040b8174csm119465491cf.25.2026.05.04.13.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 13:21:33 -0700 (PDT)
Message-Id: <5423273edf7836b75fb79e2339f27bfcad994c15.1777926079.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2101.v2.git.1777926079.gitgitgadget@gmail.com>
References: <pull.2101.git.1777731354.gitgitgadget@gmail.com>
	<pull.2101.v2.git.1777926079.gitgitgadget@gmail.com>
From: "Taylor Blau via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 04 May 2026 20:21:19 +0000
Subject: [PATCH v2 10/10] path-walk: support `combine` filter
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
Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-pack-objects.adoc |  3 +-
 path-walk.c                         | 31 +++++++++-----
 t/t6601-path-walk.sh                | 65 +++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-pack-objects.adoc b/Documentation/git-pack-objects.adoc
index bd7c808eef..c12b63a040 100644
--- a/Documentation/git-pack-objects.adoc
+++ b/Documentation/git-pack-objects.adoc
@@ -405,7 +405,8 @@ will be automatically changed to version `1`.
 Incompatible with `--delta-islands`. The `--use-bitmap-index` option is
 ignored in the presence of `--path-walk`. Whe `--path-walk` option
 supports the `--filter=<spec>` form `blob:none`, `blob:limit=<n>`,
-`tree:0`, `object:type=<type>`, and `sparse:<oid>`.
+`tree:0`, `object:type=<type>`, and `sparse:<oid>`. These supported filter
+types can be combined with the `combine:<spec>+<spec>` form.
 
 
 DELTA ISLANDS
diff --git a/path-walk.c b/path-walk.c
index b9902abbb7..6d66da3dc3 100644
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
index 13016e62ab..a7d5f0de4e 100755
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
gitgitgadget
