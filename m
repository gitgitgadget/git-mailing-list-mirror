Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D180B12CDA5
	for <git@vger.kernel.org>; Wed, 27 May 2026 23:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779923922; cv=none; b=tkOXuNgJVUEctBBJZ30KRS+aDetNq5yKzsyZtPahkbsCz465OVPvyHQwFCLtevsnuhmXsDZZGG/abqfBylgO85LQRC9B+F2s953E5VolIMCeC2jVGU4Nsdq6l+wXxtl9Jmm3ggPyPtebWVfzPi9ckWjhJNN+75Nfivtr3+P15NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779923922; c=relaxed/simple;
	bh=VMwS/hvYcIwULaRqc9knfZPbmerODanonEjll2qYoaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hidz65zPItBh2tT369YuKz5/OO4if7OZWsQOrwpWA3NP1hcPCKE1sW6t91GcNC9S36P6ACeMZTLe/uFg4WtEatWfbO1Zg4geMNVhKDGZSM1fer0/9vWyceQDFkwltUr9f+xFl8OowqYlSCBpRz1tgdejh4rpYLUkTR4naccHIXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=FNGhhxdM; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="FNGhhxdM"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7c0dea734b8so118574937b3.3
        for <git@vger.kernel.org>; Wed, 27 May 2026 16:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1779923920; x=1780528720; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dxJjClCh4ROzCABLs3dXnNX0AmdYCSgBtlo13uVBGmw=;
        b=FNGhhxdM1uhoV5h88O0E9jBp9t5Zz1wkduGiS1TxSZByNVb+LSygGZEm/ptG6qva0I
         g1tN4gfdkEbgXn5KEP0Kf465hKaRXUvfX/zIZnUf98sp2Kzv0gyTn0dirrL80ebBeYq0
         SA/mtBB21qShI18/eImDM7nLDje/QK+S1sZxlFlvA6cn9f+VeJJ/OyheBH1Oisi6UDic
         YQ8Irly/j4Fe12bUJO0gtv3/+kTFdFkXXz9G8HdPZdS9IENNNSCx+dfusrGM9fVDjg3r
         Q16JSq7jtJF3uNlN6rQFWUwBDRt5oSeH9tiNTOKZA+AXKz5f/KIPKU400qKrglLwkaGk
         RVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779923920; x=1780528720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dxJjClCh4ROzCABLs3dXnNX0AmdYCSgBtlo13uVBGmw=;
        b=Bgi5ITbvM4K4v7UluVDMVXpbxuO6ugfJ9ILhdUGx0Ap62hUvuE9hIuifShOQK9XP2m
         4kNJq+FT8XdiZUnV/5Z/4Ht/20gomzXc/nTep8qD5hkZy9zeDvHyEMN9Eg39arshIzla
         HM6YGpv6aOSHpwPX52XHg+xmcM6ua6qfKw43ACxKM74yrldEK7MWtKLV4aPQFCFUEpjP
         b8wmRynaEUPNuUoDy56znzG7rJ8pvQLZ1E8pZbJEiV2SwvAMX7tAGNxsj5pfNPrRAaUd
         Fes7M6uyayKzjJ7zBpewwaT8H+Nzsjcnkd/PeS9GzzEz1P3t+HNPa6MfL/55DENV/MMe
         QNEA==
X-Gm-Message-State: AOJu0Yy01av0nX1Ec/GuQ77BHfis4fTuVQ2G8s7y7Vf1h4QT7dpT7JQz
	mUFkGT9L3gXjp/RYRynsH3cKqJWcJnMCldQatrL2bg5Wtu1wM92PusLB2zIhxoohj0wpN9BDO9z
	gmyBaGZo=
X-Gm-Gg: Acq92OF2Zp2Wu/xvsMj+4m3rnLxVL/SlaT+CtW1vCW70Q8KuG5YAnCoTONZzVw50LE/
	ufcaIOGGYmY3/Pwl0rfDwgfpxDf7zzj89KHAYX9EfmqLhvBY7bDJxh0VbLugbYlGB8YG9hD3YKU
	sY8BPDznL82L8rcoQphE/N5/4KEwCGJeFsoczxox3CMb/mcSq/OP8zd8LILEClzryWOySv2WINb
	5dQzQZfMmrhEe4hB6Ka9Iaf/3BJMycWBqRE/XdKDiYoZmAUIBJZRAvX8EM425H8lbbi59deS1BK
	eWWiW2wswR4Yesok7FEsZDp21JkftLtTQh/xvXhTJu0C36502mdqMG2XMaNWNtLIT2CWiscsem0
	AVU6QVhtUV3ISxFOAjdGAdpBTgJHLhy9GW/7KHcqZEPb1SKKy8hzEfmAUBndtM1R5XSckNCajTo
	5FkxxYpssuAySStSfKcIa4W3lFc/I6ZRXrhO3uVmujM2h/6ZSk/7OruVn2YnCc0DGnYmbbm7KKq
	kw4v6kbn66P0h9hLY8I8gMQJlYZV13HZVbXPNIinWClkHbUDSVtbzQ82hqkqY/o65Ac+jwJfUjV
	Zm2QB3kZvfptMNOg319FybiCNjI=
X-Received: by 2002:a05:690c:e348:b0:7dc:61c7:5932 with SMTP id 00721157ae682-7dc61c76185mr9474257b3.28.1779923919782;
        Wed, 27 May 2026 16:18:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d38c839859sm83228737b3.47.2026.05.27.16.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 16:18:39 -0700 (PDT)
Date: Wed, 27 May 2026 19:18:38 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: [PATCH 1/3] pack-objects: support reachability bitmaps with
 `--path-walk`
Message-ID: <3fa8bfbfd59f5e287e516ed272cad0ef2230aa93.1779923907.git.me@ttaylorr.com>
References: <cover.1779923907.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1779923907.git.me@ttaylorr.com>

When 'pack-objects' is invoked with '--path-walk', it prevents us from
using reachability bitmaps.

This behavior dates back to 70664d2865c (pack-objects: add --path-walk
option, 2025-05-16), which included a comment in the relevant portion of
the command-line arguments handling that read as follows:

    /*
     * We must disable the bitmaps because we are removing
     * the --objects / --objects-edge[-aggressive] options.
     */

In fb2c309b7d3 (pack-objects: pass --objects with --path-walk,
2026-05-02), path-walk learned to pass '--objects' again, but still
kept bitmap traversal disabled. That leaves two useful cases
unsupported:

 * A path-walk repack that writes bitmaps does not give the bitmap
   selector any commits, because path-walk reveals commits through
   `add_objects_by_path()` rather than through `show_commit()`, where
   `index_commit_for_bitmap()` is normally called.

 * An invocation like "git pack-objects --use-bitmap-index --path-walk"
   never tries an existing bitmap, even when one is available and could
   answer the request.

Fortunately for us, neither restriction is required.

 * On the writing side: teach the path-walk object callback to call
   `index_commit_for_bitmap()` for commits that it adds to the pack.
   That gives the bitmap selector the commit candidates it would have
   seen from the regular traversal.

 * For bitmap reading, keep passing '--objects' to the internal rev_list
   machinery, but stop clearing `use_bitmap_index`. If an existing
   bitmap can answer the request, use it; otherwise fall back to
   path-walk's own enumeration.

There is one wrinkle when it comes to '--boundary', which we must not
pass into the bitmap walk in the presence of both '--path-walk' and
'--use-bitmap-index'. Path-walk needs boundary commits when it performs
its own traversal, in order to discover bases for thin packs, but the
bitmap traversal expects the usual non-boundary state. Work around this
by setting `revs->boundary` as late as possible within
`get_object_list_path_walk()`, after any bitmap attempt has either
succeeded or declined to answer the request.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-pack-objects.adoc |  6 +++--
 builtin/pack-objects.c              | 18 +++++++++++++--
 t/t5310-pack-bitmaps.sh             | 36 +++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-pack-objects.adoc b/Documentation/git-pack-objects.adoc
index 8a27aa19fd3..0adce8961a3 100644
--- a/Documentation/git-pack-objects.adoc
+++ b/Documentation/git-pack-objects.adoc
@@ -402,8 +402,10 @@ will be automatically changed to version `1`.
 	of filenames that cause collisions in Git's default name-hash
 	algorithm.
 +
-Incompatible with `--delta-islands`. The `--use-bitmap-index` option is
-ignored in the presence of `--path-walk`. The `--path-walk` option
+Incompatible with `--delta-islands`. When `--use-bitmap-index` is
+specified with `--path-walk`, a successful bitmap traversal is used for
+object enumeration, with path-walk remaining as the fallback traversal
+when the bitmap cannot satisfy the request. The `--path-walk` option
 supports the `--filter=<spec>` forms `blob:none`, `blob:limit=<n>`,
 `tree:0`, `object:type=<type>`, and `sparse:<oid>`. These supported filter
 types can be combined with the `combine:<spec>+<spec>` form.
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index b783dc62bc9..e4dcb563b7d 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4732,6 +4732,15 @@ static int add_objects_by_path(const char *path,
 			continue;
 
 		add_object_entry(oid, type, path, exclude);
+
+		if (type == OBJ_COMMIT && write_bitmap_index) {
+			struct commit *commit;
+
+			commit = lookup_commit(the_repository, oid);
+			if (!commit)
+				die(_("could not find commit %s"), oid_to_hex(oid));
+			index_commit_for_bitmap(commit);
+		}
 	}
 
 	oe_end = to_pack.nr_objects;
@@ -4764,6 +4773,13 @@ static int get_object_list_path_walk(struct rev_info *revs)
 	info.path_fn = add_objects_by_path;
 	info.path_fn_data = &processed;
 
+	/*
+	 * Path-walk needs boundary commits to discover thin-pack bases, but
+	 * bitmap traversal does not understand the boundary state. Set it
+	 * here so any prior bitmap attempt sees the usual non-boundary walk.
+	 */
+	revs->boundary = 1;
+
 	/*
 	 * Allow the --[no-]sparse option to be interesting here, if only
 	 * for testing purposes. Paths with no interesting objects will not
@@ -5195,9 +5211,7 @@ int cmd_pack_objects(int argc,
 		}
 	}
 	if (path_walk) {
-		strvec_push(&rp, "--boundary");
 		strvec_push(&rp, "--objects");
-		use_bitmap_index = 0;
 	} else if (thin) {
 		use_internal_rev_list = 1;
 		strvec_push(&rp, shallow
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index f693cb56691..69c5da1580a 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -577,6 +577,42 @@ test_bitmap_cases
 
 sane_unset GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL
 
+test_expect_success 'path-walk repack can write and use bitmap indexes' '
+	test_when_finished "rm -rf path-walk-bitmap" &&
+	git init path-walk-bitmap &&
+	(
+		cd path-walk-bitmap &&
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
+
+		git repack -a -d -b --path-walk &&
+		git rev-list --test-bitmap --use-bitmap-index HEAD &&
+
+		git rev-parse HEAD >in &&
+
+		git rev-list --objects --no-object-names HEAD >expect.raw &&
+		sort expect.raw >expect &&
+
+		for reuse in true false
+		do
+			: >trace.txt &&
+
+			GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
+			git -c pack.allowPackReuse=$reuse pack-objects \
+				--stdout --revs --path-walk --use-bitmap-index \
+				<in >out.pack &&
+			grep "\"category\":\"bitmap\",\"key\":\"bitmap/hits\"" trace.txt &&
+
+			git index-pack out.pack &&
+
+			list_packed_objects out.idx >actual.raw &&
+			sort actual.raw >actual &&
+			test_cmp expect actual || return 1
+		done
+	)
+'
+
 test_expect_success 'incremental repack fails when bitmaps are requested' '
 	test_commit more-1 &&
 	test_must_fail git repack -d 2>err &&
-- 
2.54.0.22.ga642305e3c9

