Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78253B0AD6
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 20:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781294835; cv=none; b=Bm+5enwXrj8ZB4SLiUvmubUjNPTajYn30P96jhGMPbL+gDEHiTXiMhJcTqMg+mQ3cXD4Wtr3iGwR5un1xYtGEUq3Z0j/ruAJIf+B38ZO80/ZWwvYmK+2rx6R3p5zissbg5HrTbbLuzzNPcjpeX+tFGLZWBNUredUkXiAJoUfLDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781294835; c=relaxed/simple;
	bh=Ums5B6C6cSV1Ck5nqV1RtOLyqP9oiyijGtoGttTuCRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mAypNuG5IhDaQ0AnB6HWTsFQKeA/eomcsOmfqZYx/bXQR88Iz3q481Nktig2wtWBaQiZ7E2kFJvu3sxml8c4n9eljn9bH6ylpeu4GOGzLIWnKrNKSFb3hd3KMbKAm1DAxqICO8HP9u0t/n+j8ltWfXYRWt0eadyWH3ym5zs5onQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=gFAyWJE2; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="gFAyWJE2"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6607048fa62so1440096d50.1
        for <git@vger.kernel.org>; Fri, 12 Jun 2026 13:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1781294833; x=1781899633; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Iuv01nqraAyJvKUx2wkh0J9I2Gnha2o2mt8naSRSAc=;
        b=gFAyWJE2fW15n47ZLG26XLwmgZmhhpDkH9JyqwUf7yaF7q9Rj57e5FS38+fyGs/v5e
         VhS7ZhMh25mBf/tnAaw+sDDpNUXYhkZ/z2odbdt4nZMc/5ZGzCayeMaek2nGMJ6uhXkv
         AilR2hBfW+iGnrrnaSXA70izqGvo1q1CO24e7Q4NWOab2qmZcdd7iymdqyv6n29ck3vE
         I/ZMrmvXmp+RbvogVApjvjMGXCvbBuAAeDASepBHA8zjqqn3XPrWM45EbFmdnBb+83rT
         w1e/eKmzrwuH6GUZcvKgUBXjV4ALdZ+7Ndm96Ae3ljatR29lj8VcIiqT26XsI+QJtrO3
         Ut4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781294833; x=1781899633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Iuv01nqraAyJvKUx2wkh0J9I2Gnha2o2mt8naSRSAc=;
        b=Q8XzDtVU04WMQwMp+7BgcSHyGNUBPYVuQF3Zh2Gi1NU1RMxCUZzGN88PemcxKyUIHb
         wLw9BapUid/+Ne/3c8AqiNvRbbGThNGwdMhGEAfKsjU2IosO6mhMmYVqG5pLkz5TEIFv
         zMWnZt8bHzTaYUR6jin3JLKKnjhJ/kzNA27tdxSTYYo1teICGMFJ/PnDg6TJ5KK/eNWD
         rop57iOmfpIZmAMojoN9TRVDnoS/VSm9tXpRIP/XidGRMb6GfPwAeWwxlxeDONt3RTWt
         eOGpjA/GfOshyIUHHGylI6Un9KRbY8fKL9Oul+gAchXORa5KAnrMSCVZhwXc0Zx9s9E7
         ZOMA==
X-Gm-Message-State: AOJu0YzGnbV3it24DNuADB2YG+pI4SyOxZ4bU4Gv2sspcOg6muaotrHV
	0tsXDKZ8W2akyNA+YqILO2Hqbp0sKbUuaXcb3QNN1thITAk8TCuRZr3kRK+78STmU99lY2KSnD/
	tFAY6Ttc=
X-Gm-Gg: Acq92OE+jcaylWTXzmCzON7AR33Q512kAiQn+3y9yhbKxG4COarc1LmOlIVu8fz2q1i
	gjTkiem1i4+PtPdKQaXjaiadFh1dTgSA0tqqqG4uN56UxsYYfmfGVxY/0bY5WCSjSaNDx3I0Jlc
	JGWXyQnHJpx4FkwvR0T72VjrrrY+dmjPbRkoIwX1MoZD8hTvWrZ9QyBN/LGijQ1CfFhc7ZYBL9A
	wz4GhwqX9rPoqTidURoAD0kfmjsPYzSEnB4Lk5MQaKxGNgNZ++Dhg+z4ZyLdzaKy99Vc8AB+hHr
	5mrR+XztrG503m5qvH6xOMQHl/kTd86PIeh9CqGkJnwvfH5NZyhGPOxYU1iQJGa0xc6fL67Q7QZ
	U3wBaa5jINFN1ICeWTWhaeO67yqb5VvvnHgFtuWDnkvDEjbvfiNrKr1Weezl7ac77mPvCZ2bh2O
	WmSXdAveLdhmE9+kwieWjRel58kakrOvCLAedaMeUjViaJSt0bUUH+Q7H0NK2BM0/NlR7nsX1rt
	wGOe0u+GKnVKi2gau1rntf4jQwZcAVLO+dzezRpxWUAUD6fKy1Hfw+gV8mlVrMZ5kbgLJUtcGLE
	onyGyXR2mzOPto/f
X-Received: by 2002:a05:690e:1489:b0:65e:1d95:29d5 with SMTP id 956f58d0204a3-662782cee75mr3408106d50.41.1781294832688;
        Fri, 12 Jun 2026 13:07:12 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66274e02e8esm1597400d50.12.2026.06.12.13.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 13:07:12 -0700 (PDT)
Date: Fri, 12 Jun 2026 16:07:11 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH 2/3] midx: pass custom '--base' through incremental writes
Message-ID: <4115ee0a9a09351e47d557a1283fc6ec4d633304.1781294771.git.me@ttaylorr.com>
References: <cover.1781294771.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1781294771.git.me@ttaylorr.com>

The 'multi-pack-index' builtin parses '--base' for incremental writes,
but the normal write path does not pass that value through to
`write_midx_file()`.

As a result, something like:

    $ git multi-pack-index write --incremental --base=<base>

behaves as if no custom base had been given (unless the caller used the
'--stdin-packs' path).

Thread the parsed base through `write_midx_file()`, and update the
repack caller to pass NULL for the new argument where no custom base
selection is needed.

This exposes a pre-existing problem in incremental writes with custom
bases: the writer skips packs from the full existing MIDX chain, even
when the caller selected an older base or no base at all.

The affected t5334 cases fail while trying to write MIDX bitmaps. The
detached layer omits packs above the selected base, and thus the
resulting MIDX does not have a reachability closure, making it
impossible to generate reachability bitmaps.

Mark those tests as expected failures accordingly. The following commit
will fix the broken behavior and restore these tests.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/multi-pack-index.c              |  3 ++-
 builtin/repack.c                        |  2 +-
 midx-write.c                            |  2 ++
 midx.h                                  |  2 +-
 t/t5334-incremental-multi-pack-index.sh | 24 +++++++++++++++++++-----
 5 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 00ffb36394d..949bfa796b2 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -224,7 +224,8 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
 	}
 
 	ret = write_midx_file(source, opts.preferred_pack,
-			      opts.refs_snapshot, opts.flags);
+			      opts.refs_snapshot, opts.incremental_base,
+			      opts.flags);
 
 	free(opts.refs_snapshot);
 	return ret;
diff --git a/builtin/repack.c b/builtin/repack.c
index 1524a9c13ad..0092a72a996 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -629,7 +629,7 @@ int cmd_repack(int argc,
 		unsigned flags = 0;
 		if (git_env_bool(GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL, 0))
 			flags |= MIDX_WRITE_INCREMENTAL;
-		write_midx_file(existing.source, NULL, NULL, flags);
+		write_midx_file(existing.source, NULL, NULL, NULL, flags);
 	}
 
 cleanup:
diff --git a/midx-write.c b/midx-write.c
index 561e9eedc0e..aa438775ebd 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1850,12 +1850,14 @@ static int write_midx_internal(struct write_midx_opts *opts)
 int write_midx_file(struct odb_source *source,
 		    const char *preferred_pack_name,
 		    const char *refs_snapshot,
+		    const char *incremental_base,
 		    unsigned flags)
 {
 	struct write_midx_opts opts = {
 		.source = source,
 		.preferred_pack_name = preferred_pack_name,
 		.refs_snapshot = refs_snapshot,
+		.incremental_base = incremental_base,
 		.flags = flags,
 	};
 
diff --git a/midx.h b/midx.h
index 63853a03a47..92ed29d913d 100644
--- a/midx.h
+++ b/midx.h
@@ -131,7 +131,7 @@ int prepare_multi_pack_index_one(struct odb_source *source);
  */
 int write_midx_file(struct odb_source *source,
 		    const char *preferred_pack_name, const char *refs_snapshot,
-		    unsigned flags);
+		    const char *incremental_base, unsigned flags);
 int write_midx_file_only(struct odb_source *source,
 			 struct string_list *packs_to_include,
 			 const char *preferred_pack_name,
diff --git a/t/t5334-incremental-multi-pack-index.sh b/t/t5334-incremental-multi-pack-index.sh
index 68a103d13d2..69e96bf8d93 100755
--- a/t/t5334-incremental-multi-pack-index.sh
+++ b/t/t5334-incremental-multi-pack-index.sh
@@ -119,7 +119,7 @@ test_expect_success 'write MIDX layer with --base without --no-write-chain-file'
 	test_grep "cannot use --base without --no-write-chain-file" err
 '
 
-test_expect_success 'write MIDX layer with --base=none and --no-write-chain-file' '
+test_expect_failure 'write MIDX layer with --base=none and --no-write-chain-file' '
 	test_commit base-none &&
 	git repack -d &&
 
@@ -128,19 +128,33 @@ test_expect_success 'write MIDX layer with --base=none and --no-write-chain-file
 		--no-write-chain-file --base=none)" &&
 
 	test_cmp "$midx_chain.bak" "$midx_chain" &&
-	test_path_is_file "$midxdir/multi-pack-index-$layer.midx"
+	test_path_is_file "$midxdir/multi-pack-index-$layer.midx" &&
+
+	echo "$layer" >"$midx_chain" &&
+	test-tool read-midx --show-objects "$objdir" "$layer" >midx.objects &&
+	test_grep "^$(git rev-parse 2.2) " midx.objects &&
+	cp "$midx_chain.bak" "$midx_chain"
 '
 
-test_expect_success 'write MIDX layer with --base=<hash> and --no-write-chain-file' '
+test_expect_failure 'write MIDX layer with --base=<hash> and --no-write-chain-file' '
 	test_commit base-hash &&
 	git repack -d &&
 
 	cp "$midx_chain" "$midx_chain.bak" &&
+	base="$(nth_line 1 "$midx_chain")" &&
 	layer="$(git multi-pack-index write --bitmap --incremental \
-		--no-write-chain-file --base="$(nth_line 1 "$midx_chain")")" &&
+		--no-write-chain-file --base="$base")" &&
 
 	test_cmp "$midx_chain.bak" "$midx_chain" &&
-	test_path_is_file "$midxdir/multi-pack-index-$layer.midx"
+	test_path_is_file "$midxdir/multi-pack-index-$layer.midx" &&
+
+	{
+		echo "$base" &&
+		echo "$layer"
+	} >"$midx_chain" &&
+	test-tool read-midx --show-objects "$objdir" "$layer" >midx.objects &&
+	test_grep "^$(git rev-parse 2.2) " midx.objects &&
+	cp "$midx_chain.bak" "$midx_chain"
 '
 
 for reuse in false single multi
-- 
2.55.0.rc0.3.g7bf7c87b605

