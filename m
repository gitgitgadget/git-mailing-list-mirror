Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1492A1292DB
	for <git@vger.kernel.org>; Thu, 23 May 2024 21:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716499581; cv=none; b=tFCHBLeciMMG07gVXl09aXo/wfud+0P0gy+hZz4HR1L8BksCZKF4YPzS9vPlzl5iP+Rgw+cokyZMghlMOiKNL98hfR86JfMOd/g1fBt+QnHeOvjQd0ixUdoc7Qi1jeG28ksEGzeP1nZ7+U9vuhFDGYM/aeY7BQfjbxIJssI+nAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716499581; c=relaxed/simple;
	bh=UUqJBbYLGvri/cPeuiJX+AnBv9WFynxOmX7r3gDBNok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZcl1Ant6+mweH2SoHtyeVJmYvQRYix25U7eQNVNZ8RKjnFe2e0xjq3dIsH8bwDa4J9XIrc6tlRtNJlay2gHxaWc2c9y7N+DFYlwyITQ/mnB1kpKn5R+UOaEkYSmzyq7MhbghHFe+xtWWcgPtAgVnTmF8G5KPvUYFz7/R/ggVPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=A+1jOO/s; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="A+1jOO/s"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-794aac9a2cdso14821585a.3
        for <git@vger.kernel.org>; Thu, 23 May 2024 14:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716499579; x=1717104379; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rwyaGdXvH0f0RbEJo0zZFvLi+livOxMw8FNsKZXpRbQ=;
        b=A+1jOO/sOOpMPT1eQB73UUgpr1Z5In6041NmAf1u4A+ee7NOtyOlMCWJRQ+eG8aMqG
         MdXyxypTBzFyp4GfcMGRJ9qHyv4s++sMGkodAActKhhXOnYcO/mnaX2avdHJdlHcPsDA
         uuOLaE77HAMSYnenRnLWyCvfsznr3GoP7CqHyBMukW8wtDKKBR21R4dgTpqylWZcBHUc
         aCt8+BAwxA8JwH0jSKcFl9vE6nPPYcMCC+AK3Lecv9zvo0HL/zWThZUMEq1LWhks/7+v
         fScsJdnwp/oluYXUqoH32ceLJO6tkOOiCrj3ufGegDFrbIlpMdnvZOrDQ85GrewSO8/Z
         HD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716499579; x=1717104379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rwyaGdXvH0f0RbEJo0zZFvLi+livOxMw8FNsKZXpRbQ=;
        b=hgSZb9Osqz8hzJWWbvXa6NKeCCDbjJ8CrnDWTnElqaTQLdtjp1SbelwjpzNv3oeJCM
         /yPz3kVxnBPe1Kkpc95Uj5CA7bhx8JCt50yo6gAnRNDDBrZ4d5mlBSvjsO7O4xvrvLIP
         +KX5RjFIAnyX9Xh/F5lid/cGP6n6Zyvd0UxHJUMM7RGCxpbNIZLMrU5bjcems98vaMxz
         SlCdfp8+K7cUFmM8IuCodHAYkbzWTDNdyRAiTLiRrJsHLK3xPFsqbZhlLI8WDsbUdiu+
         Qu7GspeUO+oAOB86ZzG4SOTlL4MjyXF5/76GX7L7SSxGIFjInda93lBOvYOWbPTUvRiJ
         txFw==
X-Gm-Message-State: AOJu0YywQ5jLjAsQTD/6B83rpfIGuCoT5olq7t93aVYtTcqP/iS4XJdG
	CuircnCxUXCHGW1dUaYA/4E5urmjLQJCLCSuiki2XsTqhaDipOp+RCrT+3bh4PNK4ssrPP0xhf8
	z
X-Google-Smtp-Source: AGHT+IHmkizSWYINhzUcYMy/+72hcWBkY+ECwNupLNreK6YIsInBRx50wuU5G++/bCi1o3mbxYNlkQ==
X-Received: by 2002:a05:620a:14a4:b0:792:cce6:cef8 with SMTP id af79cd13be357-794ab0a3242mr45753685a.25.1716499578517;
        Thu, 23 May 2024 14:26:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abcd9841sm2713885a.57.2024.05.23.14.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 14:26:17 -0700 (PDT)
Date: Thu, 23 May 2024 17:26:16 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 03/24] Documentation/technical: describe pseudo-merge
 bitmaps format
Message-ID: <44046f83c1a8a5971fd434debbf31df00658e2b8.1716499565.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1716499565.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1716499565.git.me@ttaylorr.com>

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
2.45.1.175.gcf0316ad0e9

