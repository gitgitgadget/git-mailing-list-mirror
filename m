Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB321494BD
	for <git@vger.kernel.org>; Tue, 21 May 2024 19:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716318132; cv=none; b=jBrtnC0wiH0fqDAWPWcCi8lvbHXBo7yGEXc3xQ1SPuZcgiSVw6S1rs9qpR85baARDCqop/xB5l5Cl/9BK6kaOJhpYq24dUJfm/RyB5nYKuI3bQ/FuguyetofLzvdmK66bfShDBvHX8CcGibtSowx0PwDe2zbzg0CUk3NBSZLMDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716318132; c=relaxed/simple;
	bh=odCIASvmMA1FyARQEtQLMWzU4YVyIUW7KeJ2eARDXhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nx3BikFvqbUgnuQNgxf/1mYwUA7fUvUsrnmwMZmFqc/05HxpOKUCWA72ZmXoDBZOZB23Bbgelu9zXQDGh0B4wK58LTePhHgzAroDjFSmY0TKeSNP858ZFWI2xKc35xdIFNDJopWVfRQ68PkEWmZYXr6lvVLfi6Ep9dnrXuFE68I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=TzmEqe2G; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="TzmEqe2G"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-43e09dab877so28315351cf.1
        for <git@vger.kernel.org>; Tue, 21 May 2024 12:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716318128; x=1716922928; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xi19maJyBx+n/ZqJMPBU4/fw3iEjma+IG+fUnZ28vOI=;
        b=TzmEqe2GZ8XyZFzbYnvcyTwX//rOZiJq3RchH68OPGhE1qKbVPRWPeiafT6h7lCC02
         Z+iBuqbN20uzlSxKWtgLjpYtPvJL16oVR3jFpBl7ZvfHLS035atEhIiEJViB/TrLjF9L
         XkBZbJg6XHlZ0ok0MAa2EkrF2+s8DteeQPv8rQMSkbar+QDTF+xgRlUDY6RT+06/1ngI
         /QxYyq8/PaI5smU3gI+dUEumRjL8cisaWRZoDUbOrpIbd1GvAxc1A6x4cJJ87UEk1igv
         rZJ2FR6OXU+MWAV3i3hAsilujyAsKXjQNLj/3yBxBt/lwZ0a0g99da7hTJux8SW87RoK
         NYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716318128; x=1716922928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xi19maJyBx+n/ZqJMPBU4/fw3iEjma+IG+fUnZ28vOI=;
        b=jrOsXrdZbqFYcboDimZ+TegEMR6LW9k7l9COkFM8+v5oMNm9wYvpCvN6WKvmdXSAU+
         w+NiBVBPRp4QjWCczgO5nQv8G51dA/b+cgo+BxOxZm0RHCXVCQRs8VUoope9nhEBI6ct
         xnLhT5Rkcxvw5U6Y73Hx0gZgGO/ucvtc5kCsGoe/sjju9YfLReCxjm6s5Nh30n9bVq7O
         2SbvY6vDar7K8iZPcFIX1lejLPVcYxIR5Ja1NVeAgLaEnQG4UTV000M6/d3/S/FwJrgn
         qb7g/QJUdQb/UAUJW86lXgSMDAYSFWQkNgMFNnsPn7gmZyMXpec1+3K7a0uvkr+XZ6vk
         4ZSg==
X-Gm-Message-State: AOJu0YzA6ByE1TKaDMZr4Vm3bifPGN60OD+nOKO9CLoFFjcLQkTwtFX1
	v80r1y6K+g4fx+7hNox6bFzJCRaa2aN00Hh+JtppcSYU/EehVVGtTMJR4IuUfLQ4Fe5a/RJrkJA
	R
X-Google-Smtp-Source: AGHT+IGQw9KfQIfc8+bfADwapI1zBJ0o8GBq/AWj6Ei+jjsrQfD1Uqtgb+RBNKpVdWjyLcM+nfyIZA==
X-Received: by 2002:ac8:5954:0:b0:43a:c483:9fc3 with SMTP id d75a77b69052e-43dfdb299c0mr379817801cf.26.1716318128077;
        Tue, 21 May 2024 12:02:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43f7a6bd188sm48640481cf.19.2024.05.21.12.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 12:02:07 -0700 (PDT)
Date: Tue, 21 May 2024 15:02:06 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 09/30] Documentation/technical: describe pseudo-merge
 bitmaps format
Message-ID: <12f318b3d7e20ff0b6038d6be7f2534f885f3220.1716318089.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1716318088.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1716318088.git.me@ttaylorr.com>

Prepare to implement pseudo-merge bitmaps over the next several commits
by first describing the serialization format which will store the new
pseudo-merge bitmaps themselves.

This format is implemented as an optional extension within the bitmap v1
format, making it compatible with previous versions of Git, as well as
the original .bitmap implementation within JGit.

The format is described in detail in the patch contents below, but the
high-level description is as follows:

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
 Documentation/technical/bitmap-format.txt | 132 ++++++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/Documentation/technical/bitmap-format.txt b/Documentation/technical/bitmap-format.txt
index f5d200939b0..ee7775a2586 100644
--- a/Documentation/technical/bitmap-format.txt
+++ b/Documentation/technical/bitmap-format.txt
@@ -255,3 +255,135 @@ triplet is -
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
+For more information on what pseudo-merges are, why they are useful, and
+how to configure them, see the information in linkgit:gitpacking[7].
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
+|  +---------------------------+            |
+|  | commit_pos (4 bytes)      |            |
+|  +---------------------------+            |
+|  | offset (8 bytes)          |            |
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
+|  +----+----------+----------+----------+  |
+|  | N  | Offset 1 |   ....   | Offset N |  |
+|  +----+----------+----------+----------+  |
+|  |    |  8 bytes |   ....   |  8 bytes |  |
+|  +----+----------+----------+----------+  |
+|                                           |
++-------------------------------------------+
+|                                           |
+|  Pseudo-merge Metadata                    |
+|  +-----------------------------------+    |
+|  | # pseudo-merges (4 bytes)         |    |
+|  +-----------------------------------+    |
+|  | # commits (4 bytes)               |    |
+|  +-----------------------------------+    |
+|  | Lookup offset (8 bytes)           |    |
+|  +-----------------------------------+    |
+|  | Extension size (8 bytes)          |    |
+|  +-----------------------------------+    |
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
+  beginning of the `.bitmap` file) of each consecutive pseudo-merge.
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
2.45.1.175.gbea44add9db

