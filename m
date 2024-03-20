Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD782CA6
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 22:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710972310; cv=none; b=ELRFC32MkW9x4/ewkvFGRF5K/D9DanpQdoUhYTki9gC/W1lqQzhIf46O7vaVe1yQ60pl9Uy/afrediWHfqbKWe6WoSyYlv0Isqw+QW96ADrrt54bIykZXPTphkfKtym/t6WIVM0TSPK3nX1xDBOcTbRZCylrAZjLU2XxpREfEDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710972310; c=relaxed/simple;
	bh=Tj4Yd/9hQwoABD2rARMRe1PHP1U4NUg9j8xD20MPnfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9sD3tj+a3fFax8nHF4oZzkLPEHnnB+WomsDyiHKI8fjQD7acYJuDHkVJVPsC6BWNkL1tSABIMNpW9qeWu1V6k8TeIckr3teOaMY/Mb58+p4wMAWNYzk4KemGLkEDPhgy9IEukV0GHOCtaPcnK67Q5InjtSjxb4Ee0BMF7COizw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=HNARep7M; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="HNARep7M"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-789db18e24eso24705085a.1
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 15:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1710972303; x=1711577103; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p6wTwD2xUqlTlVpIWfygRxTyeS1SCis6PHQshfsFFHI=;
        b=HNARep7M8EMSk+waCSac2IGcxxoIHUxP9U1925Ly9OaekWRT1WymgGlyqFaZntUxh6
         PSzVmn64XjNqdNop7xZsgBaJ1rfiJJSVQUiRwQTup1/5ZbieBxidaLd1TspHkDkM+pqk
         saPhvUlG7O0GmO/vDveS5GVsY1m+PRYcUWZ/DSFDbXqUY66EXNGLWRBwRoSdA1c94X9D
         7ot6ylBZODF0NlRtUfWJrRVs+oQx+ue5ryKFbIGvNPjod1nzdf2bkm9FMuPpM2fACzei
         lbRLS85rJESrXMIfMK6t/Fb4SUXjUoUYSaB6oME/6A5n6xnenmHXEPjPvtclgLVhNrt0
         07Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710972303; x=1711577103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p6wTwD2xUqlTlVpIWfygRxTyeS1SCis6PHQshfsFFHI=;
        b=iM33CUMl+yzOFz+Kd7FyYWeMC3XBt4G4naxD8ymSbkYG1vqySWjV2Jwhy9/zfTbcy/
         7dkQ7ha2lGqyaacSGTwbqy1cGQdnDwVKV0xkAscvXsCOyf3EK8tmm/5l8cTCXZXEyaDG
         LSW+7JuKgAyP/82LdW0SS9oO7K6r7OsB5yKWFVLjzrJ4Nz74i4oN1w/wS5pWgNF6DYSo
         ZfiMIk6kwxBe+pyAn2K9iYLwJs0/+flMBZF/2OMddt6nol9Rwm3U4TM146N0JU7fCydN
         ZKW75wfI0BG4SqwiPE0e+jP3T1SXYS+qPehBHbbRMdL8LWii0p9OaVNTlTiwS//xfNpY
         XmLg==
X-Gm-Message-State: AOJu0Yy35KDqa3WPLtz6KCPBsolMSOi7bmQWuQefjs6bs4GgCrYQbRdt
	NItW9gpcFL4h+5HFfK4SP8KHNSSFI1ocVR6jItCEi01/PWlYf1dgG6N1hcShDEnVzL8xOAyLZAc
	DTgI=
X-Google-Smtp-Source: AGHT+IF4NVfMn7oucJNIM5jUKG8LYXSgx0zwoTs2NWQEWJR92S1w8NIe6PjeryoWtMxi9EnFYczUdw==
X-Received: by 2002:a37:e30a:0:b0:789:fb8a:fe3c with SMTP id y10-20020a37e30a000000b00789fb8afe3cmr223981qki.17.1710972303372;
        Wed, 20 Mar 2024 15:05:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x16-20020ae9e910000000b0078a132713b3sm1984980qkf.55.2024.03.20.15.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 15:05:03 -0700 (PDT)
Date: Wed, 20 Mar 2024 18:05:02 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 01/24] Documentation/technical: describe pseudo-merge bitmaps
 format
Message-ID: <76e7e3b9cca7fb957384ed98f2cd32cf11ff8488.1710972293.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1710972293.git.me@ttaylorr.com>

Prepare to implement pseudo-merge bitmaps over the next several commits
by first describing the serialization format which will store the new
pseudo-merge bitmaps themselves.

This format is implemented as an optional extension within the bitmap v1
format, making it compatible with previous versions of Git, as well as
the original .bitmap implementation within JGit.

The format (as well as a general description of pseudo-merge bitmaps,
and motivating use-case(s)) is described in detail in the patch contents
below, but the high-level description is as follows:

  - An array of pseudo-merge bitmaps, each containing a pair of EWAH
    bitmaps: one describing the set of pseudo-merge "parents", and
    another describing the set of object(s) reachable from those
    parents.

  - A lookup table to determine which pseudo-merge(s) a given commit
    appears in. An optional extended lookup table follows when there is
    at least one commit which appears in multiple pseudo-merge groups.

  - Trailing metadata, including the number of pseudo-merge(s), number
    of unique parents, the offset within the .bitmap file for the
    pseudo-merge commit lookup table, and the size of the optional
    extension itself.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/technical/bitmap-format.txt | 179 ++++++++++++++++++++++
 1 file changed, 179 insertions(+)

diff --git a/Documentation/technical/bitmap-format.txt b/Documentation/technical/bitmap-format.txt
index f5d200939b0..63a7177ac08 100644
--- a/Documentation/technical/bitmap-format.txt
+++ b/Documentation/technical/bitmap-format.txt
@@ -255,3 +255,182 @@ triplet is -
 	xor_row (4 byte integer, network byte order): ::
 	The position of the triplet whose bitmap is used to compress
 	this one, or `0xffffffff` if no such bitmap exists.
+
+Pseudo-merge bitmaps
+--------------------
+
+If the `BITMAP_OPT_PSEUDO_MERGES` flag is set, a variable number of
+bytes (preceding the name-hash cache, commit lookup table, and trailing
+checksum) of the `.bitmap` file is used to store pseudo-merge bitmaps.
+
+A "pseudo-merge bitmap" is used to refer to a pair of bitmaps, as
+follows:
+
+Commit bitmap::
+
+  A bitmap whose set bits describe the set of commits included in the
+  pseudo-merge's "merge" bitmap (as below).
+
+Merge bitmap::
+
+  A bitmap whose set bits describe the reachability closure over the set
+  of commits in the pseudo-merge's "commits" bitmap (as above). An
+  identical bitmap would be generated for an octopus merge with the same
+  set of parents as described in the commits bitmap.
+
+Pseudo-merge bitmaps can accelerate bitmap traversals when all commits
+for a given pseudo-merge are listed on either side of the traversal,
+either directly (by explicitly asking for them as part of the `HAVES`
+or `WANTS`) or indirectly (by encountering them during a fill-in
+traversal).
+
+=== Use-cases
+
+For example, suppose there exists a pseudo-merge bitmap with a large
+number of commits, all of which are listed in the `WANTS` section of
+some bitmap traversal query. When pseudo-merge bitmaps are enabled, the
+bitmap machinery can quickly determine there is a pseudo-merge which
+satisfies some subset of the wanted objects on either side of the query.
+Then, we can inflate the EWAH-compressed bitmap, and `OR` it in to the
+resulting bitmap. By contrast, without pseudo-merge bitmaps, we would
+have to repeat the decompression and `OR`-ing step over a potentially
+large number of individual bitmaps, which can take proportionally more
+time.
+
+Another benefit of pseudo-merges arises when there is some combination
+of (a) a large number of references, with (b) poor bitmap coverage, and
+(c) deep, nested trees, making fill-in traversal relatively expensive.
+For example, suppose that there are a large enough number of tags where
+bitmapping each of the tags individually is infeasible. Without
+pseudo-merge bitmaps, computing the result of, say, `git rev-list
+--use-bitmap-index --count --objects --tags` would likely require a
+large amount of fill-in traversal. But when a large quantity of those
+tags are stored together in a pseudo-merge bitmap, the bitmap machinery
+can take advantage of the fact that we only care about the union of
+objects reachable from all of those tags, and answer the query much
+faster.
+
+=== File format
+
+If enabled, pseudo-merge bitmaps are stored in an optional section at
+the end of a `.bitmap` file. The format is as follows:
+
+....
++-------------------------------------------+
+|               .bitmap File                |
++-------------------------------------------+
+|                                           |
+|  Pseudo-merge bitmaps (Variable Length)   |
+|  +---------------------------+            |
+|  | commits_bitmap (EWAH)     |            |
+|  +---------------------------+            |
+|  | merge_bitmap (EWAH)       |            |
+|  +---------------------------+            |
+|                                           |
++-------------------------------------------+
+|                                           |
+|  Lookup Table                             |
+|  +------------+--------------+            |
+|  | commit_pos |    offset    |            |
+|  +------------+--------------+            |
+|  |  4 bytes   |   8 bytes    |            |
+|  +------------+--------------+            |
+|                                           |
+|  Offset Cases:                            |
+|  -------------                            |
+|                                           |
+|  1. MSB Unset: single pseudo-merge bitmap |
+|     + offset to pseudo-merge bitmap       |
+|                                           |
+|  2. MSB Set: multiple pseudo-merges       |
+|     + offset to extended lookup table     |
+|                                           |
++-------------------------------------------+
+|                                           |
+|  Extended Lookup Table (Optional)         |
+|                                           |
+|  +----+----------+----------+----------+  |
+|  | N  | Offset 1 |   ....   | Offset N |  |
+|  +----+----------+----------+----------+  |
+|  |    |  8 bytes |   ....   |  8 bytes |  |
+|  +----+----------+----------+----------+  |
+|                                           |
++-------------------------------------------+
+|                                           |
+|  Pseudo-merge Metadata                    |
+|  +------------------+----------------+    |
+|  | # pseudo-merges  | # Commits      |    |
+|  +------------------+----------------+    |
+|  | 4 bytes          | 4 bytes        |    |
+|  +------------------+----------------+    |
+|                                           |
+|  +------------------+----------------+    |
+|  | Lookup offset    | Extension size |    |
+|  +------------------+----------------+    |
+|  | 8 bytes          | 8 bytes        |    |
+|  +------------------+----------------+    |
+|                                           |
++-------------------------------------------+
+....
+
+* One or more pseudo-merge bitmaps, each containing:
+
+  ** `commits_bitmap`, an EWAH-compressed bitmap describing the set of
+     commits included in the this psuedo-merge.
+
+  ** `merge_bitmap`, an EWAH-compressed bitmap describing the union of
+     the set of objects reachable from all commits listed in the
+     `commits_bitmap`.
+
+* A lookup table, mapping pseudo-merged commits to the pseudo-merges
+  they belong to. Entries appear in increasing order of each commit's
+  bit position. Each entry is 12 bytes wide, and is comprised of the
+  following:
+
+  ** `commit_pos`, a 4-byte unsigned value (in network byte-order)
+     containing the bit position for this commit.
+
+  ** `offset`, an 8-byte unsigned value (also in network byte-order)
+  containing either one of two possible offsets, depending on whether or
+  not the most-significant bit is set.
+
+    *** If unset (i.e. `offset & ((uint64_t)1<<63) == 0`), the offset
+	(relative to the beginning of the `.bitmap` file) at which the
+	pseudo-merge bitmap for this commit can be read. This indicates
+	only a single pseudo-merge bitmap contains this commit.
+
+    *** If set (i.e. `offset & ((uint64_t)1<<63) != 0`), the offset
+	(again relative to the beginning of the `.bitmap` file) at which
+	the extended offset table can be located describing the set of
+	pseudo-merge bitmaps which contain this commit. This indicates
+	that multiple pseudo-merge bitmaps contain this commit.
+
+* An (optional) extended lookup table (written if and only if there is
+  at least one commit which appears in more than one pseudo-merge).
+  There are as many entries as commits which appear in multiple
+  pseudo-merges. Each entry contains the following:
+
+  ** `N`, a 4-byte unsigned value equal to the number of pseudo-merges
+     which contain a given commit.
+
+  ** An array of `N` 8-byte unsigned values, each of which is
+     interpreted as an offset (relative to the beginning of the
+     `.bitmap` file) at which a pseudo-merge bitmap for this commit can
+     be read. These values occur in no particular order.
+
+* Positions for all pseudo-merges, each stored as an 8-byte unsigned
+  value (in network byte-order) containing the offset (relative to the
+  beginnign of the `.bitmap` file) of each consecutive pseudo-merge.
+
+* A 4-byte unsigned value (in network byte-order) equal to the number of
+  pseudo-merges.
+
+* A 4-byte unsigned value (in network byte-order) equal to the number of
+  unique commits which appear in any pseudo-merge.
+
+* An 8-byte unsigned value (in network byte-order) equal to the number
+  of bytes between the start of the pseudo-merge section and the
+  beginning of the lookup table.
+
+* An 8-byte unsigned value (in network byte-order) equal to the number
+  of bytes in the pseudo-merge section (including this field).
-- 
2.44.0.303.g1dc5e5b124c

