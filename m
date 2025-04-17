Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59AF20A5E5
	for <git@vger.kernel.org>; Thu, 17 Apr 2025 21:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744924338; cv=none; b=Gfs1kHMiK1FPbRggBP+0vultqVPrHG8YTnV7m4K70P1lKPAqgEUv8R/Ic46bNQm95w4ueB9dP+VVb5I/YOAohnJ2gt2eXduoyLuX8LU/b+ntzC+/jQ8WVtlGhjerjJ39VJN4jeDSlTmCXfiNnLqbMgcsF6zg5F/Nyi7nlkq1LDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744924338; c=relaxed/simple;
	bh=TBtfsBb0rpZ3p5zr6DC5bCU8oYGTHoxduAOhsz+7hGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3avKUv1rX7y3J6AL7WuO20XYUt3ozYNccud3SuRn1Gy8dt99hW3bq2+5uK+NSWk3952Yxv9Ezdf3XwhKTmpPhAHH4QOBB5gA7SoSjew+3de4eEsqzrVEzHzf53Jowxz6zaYf7FOGMcOayPn9zwGsbxD2RebqsV4uL0oSDCgK74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=y69yVHUE; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="y69yVHUE"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-476b89782c3so13736891cf.1
        for <git@vger.kernel.org>; Thu, 17 Apr 2025 14:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1744924335; x=1745529135; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cFPX1yxFSFqxQPyW4yacuwuhvQbulx/Xx1RTo7ASFps=;
        b=y69yVHUEXQvCOphL5/+0cW8/zaEqLtDY0HMDxSmXnEFe2qgrQP7HWJpP+y5ej2l9lX
         v4kHFB4RePjGtNBdUuUa6JsJpYtVAiz0BmI1Hs+awYU3hT1AIomA4pS1DoTSBwvSNGQm
         yQEWrlCC2L+X6TRno1E42S+qibumKhmSss5AUkXGOVBJ5V25rzYIs0ciAuulhVOsD5HA
         q6SXz84M0ToCGz4lyh+4i3WRYBxwo1ZW/9+ww7qfRBtdj973a+1j1GPI8GXmtjzWSNwG
         qTVqM5Nteg4i0U+ctP7l+mDuSO6ache1WHENcaU9+dxN2v1FOHa2RdlYQwNUrUyw0yCg
         oWow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744924335; x=1745529135;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFPX1yxFSFqxQPyW4yacuwuhvQbulx/Xx1RTo7ASFps=;
        b=Q/5aPujmjGA0dceGLiB8Xf3gGXVSeVzxOSCQOTqci2+j7LEds5cyiNXl+t4w6grZw8
         zl19OjLRV972YnbTWhV6eY5pbRKbFtQcPX0zhtyL0M/RGV5ZFdMTXvbM7r9qc/L0/srL
         ceaW3M2+3O+jMokLjmOhTbEme/hod+/e8GxmO/xRBwdHMp6Nwfd99CAptem0JiOKPaAu
         D8FSKHzituRsbCKMY3JvrChtabn8xhxTQLw6kf12tl1KISSkG5umLfcpp43PdWjzSHuM
         GP3yGzrOkOOL+GfvIp9aV44K7IJ2hPDyt8G+kBem39VCgeDK/Q3gj4HMwyQ5DAdAyzPS
         dzMQ==
X-Gm-Message-State: AOJu0Yxzlf2Ava3zRKJWUDxNdYJ1bwkhraAXYRVVem05jyc4pPvJHVfX
	VmwTDZfTDJ1wg82Vn/Xg7se44IeZu0w0rlsqy1pGuaEyVnz4FJ7d1Y+MgQ8QA6mboUawTjtBy/K
	A0O8=
X-Gm-Gg: ASbGncufeCr+uSUujp0C4SUwbNdrV3IlAuijz7NF+EN8Ncjhfvwvg46autjs9PwSIVC
	bKx6B0wdh0X0PnGerwQao2fz34tYGnZPHe3ha8gW8tic03u6oDEX5aXQv1oxuA+q4D5vlSizt1z
	g6jU+lIImo0MDnayjQ7djrh0rLT3uEAsdSKO1k9Afl1sv0bvJAm6h09xeYKp/ccOSsDOfO7zLts
	XBm5ifgVkuy/J2hfDSdBkvHyZAL6wasY626rwLgTjCieNp/x+xlZgLHLBHDiWiEl186eHaqPmaR
	gWznEylcFRjSX+OErzVVf4f78PPLGoPpDt+Wmv0LRiPJkqOPVuRu6Zxk9ArBNOOSADwQVOo3IUP
	AMk+6pUL8GLt4
X-Google-Smtp-Source: AGHT+IEeWI3GAm80r8yTt/X75jG2OsPLOk1m0zBxTXar2VvatDX6d7ytYawTVEq0H33VuKEa5cU3WA==
X-Received: by 2002:ac8:5e14:0:b0:476:a3c8:c78d with SMTP id d75a77b69052e-47aec3cf9cfmr5205081cf.29.1744924335522;
        Thu, 17 Apr 2025 14:12:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47ae9cf9a8dsm3178951cf.70.2025.04.17.14.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 14:12:15 -0700 (PDT)
Date: Thu, 17 Apr 2025 17:12:14 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/4] pack-bitmap: write lookup table extension by default
Message-ID: <b7cfb1267fdd7f50f414c9f79377cb338a0c1ab0.1744924321.git.me@ttaylorr.com>
References: <cover.1744924321.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1744924321.git.me@ttaylorr.com>

The lookup table extension for reachability bitmaps was first introduced
via 3fe0121479 (Merge branch 'ac/bitmap-lookup-table', 2022-09-05).
For each bitmapped commit, the lookup table encodes three unsigned
integers:

  - The pack position of the commit.
  - An offset within the *.bitmap itself where that commit's bitmap
    lives.
  - An index into the same table where information on that commit's XOR
    pair can be found.

Lookup tables make bitmap operations faster because they no longer have
to read the entire *.bitmap file to discover what commits have
corresponding reachability bitmaps.

When bitmap lookup tables were first introduced, we established a
baseline level of performance in p5310 with and without lookup tables.
Here is the baseline without:

    Test                                                    this tree
    -----------------------------------------------------------------------
    5310.6: simulated clone                               14.04(5.78+1.79)
    5310.7: simulated fetch                               1.95(3.05+0.20)
    5310.8: pack to file (bitmap)                         44.73(20.55+7.45)
    5310.9: rev-list (commits)                            0.78(0.46+0.10)
    5310.10: rev-list (objects)                           4.07(3.97+0.08)
    5310.11: rev-list with tag negated via --not          0.06(0.02+0.03)
             --all (objects)
    5310.12: rev-list with negative tag (objects)         0.21(0.15+0.05)
    5310.13: rev-list count with blob:none                0.24(0.17+0.06)
    5310.14: rev-list count with blob:limit=1k            7.07(5.92+0.48)
    5310.15: rev-list count with tree:0                   0.25(0.17+0.07)
    5310.16: simulated partial clone                      5.67(3.28+0.64)
    5310.18: clone (partial bitmap)                       16.05(8.34+1.86)
    5310.19: pack to file (partial bitmap)                59.76(27.22+7.43)
    5310.20: rev-list with tree filter (partial bitmap)   0.90(0.18+0.16)

, and here is the same set of tests, this time with the lookup table
enabled:

    Test                                                    this tree
    -----------------------------------------------------------------------
    5310.26: simulated clone                              13.69(5.72+1.78)
    5310.27: simulated fetch                              1.84(3.02+0.16)
    5310.28: pack to file (bitmap)                        45.63(20.67+7.50)
    5310.29: rev-list (commits)                           0.56(0.39+0.8)
    5310.30: rev-list (objects)                           3.77(3.74+0.08)
    5310.31: rev-list with tag negated via --not          0.05(0.02+0.03)
             --all (objects)
    5310.32: rev-list with negative tag (objects)         0.21(0.15+0.05)
    5310.33: rev-list count with blob:none                0.23(0.17+0.05)
    5310.34: rev-list count with blob:limit=1k            6.65(5.72+0.40)
    5310.35: rev-list count with tree:0                   0.23(0.16+0.06)
    5310.36: simulated partial clone                      5.57(3.26+0.59)
    5310.38: clone (partial bitmap)                       15.89(8.39+1.84)
    5310.39: pack to file (partial bitmap)                58.32(27.55+7.47)
    5310.40: rev-list with tree filter (partial bitmap)   0.73(0.18+0.15)

(All numbers here come from a ~2022-era copy of the kernel, via
Abhradeep Chakraborty who implemented the lookup table extension).

In the almost three years since lookup tables were introduced, GitHub
has used them in production without issue, taking advantage of the above
performance benefits along the way.

Since this feature has had sufficient time to flush out any bugs and/or
performance regressions, let's enable it by default so that all bitmap
users can reap similar performance benefits.

[1]: https://lore.kernel.org/git/pull.1266.git.1655728395.gitgitgadget@gmail.com/

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config/pack.adoc | 2 +-
 builtin/multi-pack-index.c     | 1 +
 builtin/pack-objects.c         | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/pack.adoc b/Documentation/config/pack.adoc
index da527377fa..ba538e3d9c 100644
--- a/Documentation/config/pack.adoc
+++ b/Documentation/config/pack.adoc
@@ -191,7 +191,7 @@ pack.writeBitmapLookupTable::
 	bitmap index (if one is written). This table is used to defer
 	loading individual bitmaps as late as possible. This can be
 	beneficial in repositories that have relatively large bitmap
-	indexes. Defaults to false.
+	indexes. Defaults to true.
 
 pack.readReverseIndex::
 	When true, git will read any .rev file(s) that may be available
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 2a938466f5..6ad6f814e3 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -142,6 +142,7 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
 	int ret;
 
 	opts.flags |= MIDX_WRITE_BITMAP_HASH_CACHE;
+	opts.flags |= MIDX_WRITE_BITMAP_LOOKUP_TABLE;
 
 	git_config(git_multi_pack_index_write_config, NULL);
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 3973267e9e..384fefbb1d 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -239,7 +239,7 @@ static enum {
 	WRITE_BITMAP_QUIET,
 	WRITE_BITMAP_TRUE,
 } write_bitmap_index;
-static uint16_t write_bitmap_options = BITMAP_OPT_HASH_CACHE;
+static uint16_t write_bitmap_options = BITMAP_OPT_HASH_CACHE | BITMAP_OPT_LOOKUP_TABLE;
 
 static int exclude_promisor_objects;
 static int exclude_promisor_objects_best_effort;
-- 
2.49.0.226.g0e6cae136d

