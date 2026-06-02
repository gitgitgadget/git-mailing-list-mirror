Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2597B31F985
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 22:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780438911; cv=none; b=JrYKGx8lilkHKKUQMuY+TgBKQ9YgJGPCBAzbRgtK/PlL5WlxIj+nQORqK3zC/ADrBRctRELcTngtzJgl0odcmHvek8QBLOXyzV/54MdoHcIdEVg/J8iUX/4Fg/LFLKVmW03ej5Aa4aJJc7WLakcM2P5AYUkbCdCzajv9jyAuGFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780438911; c=relaxed/simple;
	bh=U7vxE6VQPluXO6jxB31DbWByrcdjvtWzI43pgk5Dtgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r1BjB3DhThvu/z5nsNAuR0lt47HpTubjKDsBjIjZOdHSFClU17y1AkZTnZAROPs4/iPNGVGPi4sFq5h+/z3HMUO3it1I5+o+BALSR4cWnOuOasWTyvMJWDCL5iCb5vckzqltHJWexZNiDwY+M+rFphoaODbQw79FjAhO5C4Q5XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=EXouA9jz; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="EXouA9jz"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6604df9ba4eso49019d50.0
        for <git@vger.kernel.org>; Tue, 02 Jun 2026 15:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1780438909; x=1781043709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FnffWZijCRqdGl/9CWkfNRQsLeF6WAh5Nqaw5dCJg4c=;
        b=EXouA9jz0vWNjft3jRXTJhRwOpcXN6tuXR8SwnUB+27NRaigTZEb3SY92FZaRoFNzV
         LsFA5PUPPdL9CGE15N6pM/8uXRDVkkB0RRxczR+Qf/oED/zwJGuRDinjWswOwnquixLK
         h5rEsRawY7f5fWhn0FW2+k0tlY3RlNT2biHy3YEu38sMBrY4FUEMVpdho9JHAHOVX852
         SdKKOLqkLJvgGtOSDtFE4b6mPgO5eZvuEQBFzW4aZ6s5eqqeWO3oAHJkorK72ZVCJFyq
         DvSbqtCtFO/k6gq/Xr0Xht1B8Q+9zK3FTUpDJsMOhhbqDRQ417PJdbwMxFl3W0XtmcN+
         CQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780438909; x=1781043709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FnffWZijCRqdGl/9CWkfNRQsLeF6WAh5Nqaw5dCJg4c=;
        b=fXs4+HosSQlQ6/PswWbzFEoysibnRhNXZ6cmc/oh4yOj51PK3ift6hFIFGKm9MJdXX
         BRzlPBkBKVyTdMJvSVFNUwPxp8N8WML7jLD+B261SqmTo6vYbgoTF04nHquIvPxteeoK
         ZMKz62UXtDWSO7vcVslNv0Hs7UwSJjR2RwdUg2VEdnSQLcXCbuyRiHnVk2BxhOfBndpZ
         QWJHaqk+QF6NWlPYlDsro3/bveFHiVNZz1PxAgYc0Zd1sWQR2F1V/clnTVYa2VrT2hvo
         jFt7+lu5Nnfgld88kpC9ShP2FZoBTx3HD+6pUp0XCMBlo3HdiuD2sjU0HkgSfTRbM9qi
         2xiw==
X-Gm-Message-State: AOJu0Yzxd4vYRxvWkOY8IEScwabyM6nhmfDBqmeYwC43+uIJ5t1K1UHP
	Jmf6SGwJbRr+XngaGSrVEqOZysVgesOJi0YR+lVkXPyC0kwG8D0TkS5GtXQKska1Eg1a9RF/PhF
	OzCxE4kk=
X-Gm-Gg: Acq92OF9KxLL3kuJZxyU6BOiRGgPfoY0IMPb9MqtmZa7Og8l+UKhtxiD2gN8fkuTiZZ
	9WMXj/ZJ4SAe6ZWHaaI7bgTk+lKxOw5K4z+ZCPvmlFBRbhfDZgfkyUy881t8Y9HNONUJrOBpjtf
	XDypmQvc5JGh+HtJHeYbOZ2vkzJY5nTb+I19KrT7A6RIBISMqTMA92L5NQDhJ9o6QNMgbJOIb0E
	u1sVSVkQ7bwwSoyFIlI1ogIy83tlGT2z5V6uMmmU/3G+gsjsOnjGzBn6tvBrgmQVu3XTfGBmX8n
	cz5ciApruwTs6okMaIH9ydraxxgfIOLak7g1c2gm0i0veUbYLSJ807UbW8BKKyK4/a+GT6ywh0C
	H9/SKGY4BaJ3GtQw9hUw8S63ReWUYL+17P0vmTU5Wr5kjoGCOQfcZVmzMD7FtjA6ri1Re2M6U8x
	AG6mWU4tzJ8gUqq9qxYbKw+QvT5339WBJLgzyHfYuVSDFvvv9t6rsyuI/OQoxUjkef1R6Ug5IxM
	5Ob1FhnE/8zYxeN7WHJMIsg5mGN7L//4xSI6i+MjbBaHmJuyeHb6uNnMxhJh5McZ4QKNR3+nuTe
	1lY3WG2dEpegoaMgCZPLkkWVl3A=
X-Received: by 2002:a05:690e:4402:b0:660:a652:2913 with SMTP id 956f58d0204a3-660dc850b9fmr356246d50.3.1780438909027;
        Tue, 02 Jun 2026 15:21:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-660d644a68fsm730895d50.14.2026.06.02.15.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 15:21:48 -0700 (PDT)
Date: Tue, 2 Jun 2026 18:21:47 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 2/4] pack-objects: support reachability bitmaps with
 `--path-walk`
Message-ID: <ffad584a43ebf3cb2138e8dce7daef84ab72712f.1780438896.git.me@ttaylorr.com>
References: <cover.1779923907.git.me@ttaylorr.com>
 <cover.1780438896.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1780438896.git.me@ttaylorr.com>

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

As a result, we can see significantly reduced pack sizes from p5311
before this commit:

    Test                                      HEAD^             HEAD
    ----------------------------------------------------------------------------------
    5311.38: server (1 days, --path-walk)     2.56(2.52+0.03)   0.01(0.01+0.00) -99.6%
    5311.39: size   (1 days, --path-walk)              123.9K            123.9K +0.0%
    5311.40: client (1 days, --path-walk)     0.00(0.01+0.00)   0.00(0.00+0.00) =
    5311.42: server (2 days, --path-walk)     2.57(2.52+0.05)   0.01(0.01+0.00) -99.6%
    5311.43: size   (2 days, --path-walk)              123.9K            123.9K +0.0%
    5311.44: client (2 days, --path-walk)     0.00(0.00+0.00)   0.00(0.00+0.00) =
    5311.46: server (4 days, --path-walk)     2.58(2.51+0.07)   0.01(0.01+0.00) -99.6%
    5311.47: size   (4 days, --path-walk)              123.9K            123.9K +0.0%
    5311.48: client (4 days, --path-walk)     0.00(0.00+0.00)   0.00(0.00+0.00) =
    5311.50: server (8 days, --path-walk)     2.58(2.53+0.04)   0.02(0.02+0.00) -99.2%
    5311.51: size   (8 days, --path-walk)              152.4K            152.4K +0.0%
    5311.52: client (8 days, --path-walk)     0.00(0.01+0.00)   0.00(0.01+0.00) =
    5311.54: server (16 days, --path-walk)    2.58(2.52+0.05)   0.03(0.02+0.00) -98.8%
    5311.55: size   (16 days, --path-walk)             205.3K            205.3K +0.0%
    5311.56: client (16 days, --path-walk)    0.01(0.01+0.00)   0.01(0.01+0.00) +0.0%
    5311.58: server (32 days, --path-walk)    2.59(2.53+0.06)   0.03(0.03+0.00) -98.8%
    5311.59: size   (32 days, --path-walk)             209.3K            209.3K +0.0%
    5311.60: client (32 days, --path-walk)    0.01(0.02+0.00)   0.01(0.02+0.00) +0.0%
    5311.62: server (64 days, --path-walk)    2.70(2.76+0.06)   0.16(0.24+0.04) -94.1%
    5311.63: size   (64 days, --path-walk)               4.1M              4.1M +0.0%
    5311.64: client (64 days, --path-walk)    0.44(0.50+0.02)   0.44(0.51+0.02) +0.0%
    5311.66: server (128 days, --path-walk)   2.88(3.20+0.05)   0.34(0.65+0.05) -88.2%
    5311.67: size   (128 days, --path-walk)              9.0M              9.0M -0.0%
    5311.68: client (128 days, --path-walk)   0.93(1.22+0.07)   0.93(1.20+0.08) +0.0%

We get the same size of output pack, but this commit allows us to do so
in a significantly shorter amount of time. Intuitively, we're generating
the same pack (hence the unchanged 'test_size' output from run to run),
but varying how we get there. Before this commit, pack-objects prefers
'--path-walk' to '--use-bitmap-index', so we generate the output pack by
performing a normal '--path-walk' traversal. With this commit, we are
operating over a *repacked* state (that itself was done with a
'--path-walk' traversal), but are able to perform pack-reuse on that
repacked state via bitmaps.

There is one wrinkle when it comes to '--boundary', which we must not
pass into the bitmap walk in the presence of both '--path-walk' and
'--use-bitmap-index'. Path-walk needs boundary commits when it performs
its own traversal, in order to discover bases for thin packs, but the
bitmap traversal does not expect this. Work around this by setting
`revs->boundary` as late as possible within the '--path-walk' traversal,
after any bitmap attempt has either succeeded or declined to answer the
request.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-pack-objects.adoc |  6 +++--
 builtin/pack-objects.c              | 18 +++++++++++++--
 t/perf/p5311-pack-bitmaps-fetch.sh  | 14 +++++++----
 t/t5310-pack-bitmaps.sh             | 36 +++++++++++++++++++++++++++++
 4 files changed, 66 insertions(+), 8 deletions(-)

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
diff --git a/t/perf/p5311-pack-bitmaps-fetch.sh b/t/perf/p5311-pack-bitmaps-fetch.sh
index 5bea5c64e7b..1b115d921a1 100755
--- a/t/perf/p5311-pack-bitmaps-fetch.sh
+++ b/t/perf/p5311-pack-bitmaps-fetch.sh
@@ -4,15 +4,18 @@ test_description='performance of fetches from bitmapped packs'
 . ./perf-lib.sh
 
 test_fetch_bitmaps () {
+	argv=$1
+	export argv
+
 	test_expect_success 'setup test directory' '
 		rm -fr * .git
 	'
 
 	test_perf_default_repo
 
-	test_expect_success 'create bitmapped server repo' '
+	test_expect_success "create bitmapped server repo ${argv:+($argv)}" '
 		git config pack.writebitmaps true &&
-		git repack -ad
+		git repack -ad $argv
 	'
 
 	# simulate a fetch from a repository that last fetched N days ago, for
@@ -20,7 +23,7 @@ test_fetch_bitmaps () {
 	# and assume the first entry in the chain that is N days older than the current
 	# HEAD is where the HEAD would have been then.
 	for days in 1 2 4 8 16 32 64 128; do
-		title=$(printf '%10s' "($days days)")
+		title=$(printf '%10s' "($days days${argv:+, $argv})")
 		test_expect_success "setup revs from $days days ago" '
 			now=$(git log -1 --format=%ct HEAD) &&
 			then=$(($now - ($days * 86400))) &&
@@ -47,6 +50,9 @@ test_fetch_bitmaps () {
 	done
 }
 
-test_fetch_bitmaps
+for argv in '' --path-walk
+do
+	test_fetch_bitmaps $argv || return 1
+done
 
 test_done
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
2.54.0.23.gae57607b57f

