Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F5421A06
	for <git@vger.kernel.org>; Thu, 23 May 2024 16:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716482307; cv=none; b=rWN6QXzPLjQu+qLwoQ6st6L1e4jmX4g5j3q2u4smcCjEnPzTDNfgtrpO1xhusbfo3hmMJ4l7nwbVc4DdKacZdeQ+Yj5+241zYc58sJ7ZkeHm01lNuosSrxftKOJDmqZLyELbL5bMzRlElmqDi4NuwMHQ1gf67uVt+2BJu1SiId4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716482307; c=relaxed/simple;
	bh=PRE9Dg0ztwG/uhXNrXgKE1kbMuG35HWy7L5vQpC5r64=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1v3ns+AxHHLMDbvK5zzs7iZhKd7BPIkimsrFwKULHxTOuhr3L6WC2xoXs5OgCigqh2txVKiis07hu5Bfb6JNaeeCjYjB5eHkx+Asz4bjs0UcfWOe/SCTlnxFwgy5lMURpBbwMwrREZfCamZEwQAqHM1j8AxaO5fGyrZa5JhHLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=B2XErPlY; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="B2XErPlY"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-69b24162dd6so32916766d6.2
        for <git@vger.kernel.org>; Thu, 23 May 2024 09:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716482304; x=1717087104; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O70Of1lM6JS3QdfGAW06FGIQHCm6akX1ozhJZJPsCfM=;
        b=B2XErPlYAtdo5ytqb6IYYYRlQdemTalYhVzVzpDBSC2+lHqMg9lAn9m7ud1btBBUaw
         combNGjOulQtMAvH4Tw0ShdOVr8XGPpnfhyxH3XhOSE267tSK21SJZ6IaYbygdbx1/Nz
         Q84y0/pHxHJ7c9ltOjimLzQ07I6h9qSckmlmEO8VltwadeWLCzhUusgrjqlEFMp7lgUv
         /4A1AZQJgHWPclA5/xNLLKI0TpLKC8v5EvwZgOGb+Vy/y1R9kzSegsAjTsdQMLfGVdtS
         4VSnvwhYfbtw0x+bG0Q729nAGtKz+zHH2o0liCLZW5FK+RpNege4zg0P0OsVTAMMSpDY
         c1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716482304; x=1717087104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O70Of1lM6JS3QdfGAW06FGIQHCm6akX1ozhJZJPsCfM=;
        b=tRbCCYrp/1PXh9n5xEUI9UPu8ZHSe9+q+9YbfIHSxSnTys+uxWt1JWGlCFX7Gb12om
         H2bFiFLiXMG3MUws6jlX/jkfMNGv0TRDrkX4avsWCW2Gs/CWdu2C36b9Ihvsn+3zbHJZ
         8pqqOaASfk/0qz+WSvAjJ9aGMVzAoS1QwzbZinX73k+EKJWj+18mn3YyHU9vAoWQ2VbF
         Bof9W987GpmHWl6ccs3tqNyInS2mudfs7SEog4EZGdrJf1Z4+695hq0aaoMpUjMuthNO
         5s1tnndFsl6ahhEQcqM7mESRmRRdtoUWdM1dzw1FiQcKuYEFn5UGSNhLEZ9KuPyydbdl
         cWlA==
X-Gm-Message-State: AOJu0YxBVyXSramw8yzTGEi4iWezj+2g+xVrnBzNAsShqjW0kBwR1CXi
	9h0gO2OE2QD6yxLvp/0yROxu1S0/saAQW8pl47LwLpsIwJd7qtYj9eG1n1ZhqXpEhEp9PpwEiKC
	f
X-Google-Smtp-Source: AGHT+IHVjZGgOE5XktEPn+ulsfj4lFvX1LdjWi+IEX49LunQ/ciMiRXIAyjY+u8OmwM/1Vy0soQX3w==
X-Received: by 2002:a05:6214:3b85:b0:6a9:879f:63fd with SMTP id 6a1803df08f44-6ab7f749fbemr64805946d6.37.1716482304235;
        Thu, 23 May 2024 09:38:24 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ab8af00036sm12741566d6.63.2024.05.23.09.38.23
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 09:38:23 -0700 (PDT)
Date: Thu, 23 May 2024 12:38:22 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Subject: [PATCH 7/8] midx: replace `get_midx_rev_filename()` with a generic
 helper
Message-ID: <f4c0167f437a04943b67d286ebcbbb7e0c5aa39e.1716482279.git.me@ttaylorr.com>
References: <cover.1716482279.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1716482279.git.me@ttaylorr.com>

Commit f894081deae (pack-revindex: read multi-pack reverse indexes,
2021-03-30) introduced the `get_midx_rev_filename()` helper (later
modified by commit 60980aed786 (midx.c: write MIDX filenames to
strbuf, 2021-10-26)).

This function returns the location of the classic ".rev" files we used
to write for MIDXs (prior to 95e8383bac1 (midx.c: make changing the
preferred pack safe, 2022-01-25)), which is always of the form:

    $GIT_DIR/objects/pack/multi-pack-index-$HASH.rev

Replace this function with a generic helper that populates a strbuf with
the above form, replacing the ".rev" extension with a caller-provided
argument.

This will allow us to remove a similarly-defined function in the
pack-bitmap code (used to determine the location of a MIDX .bitmap file)
by reimplementing it in terms of `get_midx_filename_ext()`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c          | 14 ++++++++------
 midx.h          |  6 +++++-
 pack-revindex.c |  3 ++-
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/midx.c b/midx.c
index 6f07de3688..bc4797196f 100644
--- a/midx.c
+++ b/midx.c
@@ -24,14 +24,16 @@ const unsigned char *get_midx_checksum(struct multi_pack_index *m)
 }
 
 void get_midx_filename(struct strbuf *out, const char *object_dir)
+{
+	get_midx_filename_ext(out, object_dir, NULL, NULL);
+}
+
+void get_midx_filename_ext(struct strbuf *out, const char *object_dir,
+			   const unsigned char *hash, const char *ext)
 {
 	strbuf_addf(out, "%s/pack/multi-pack-index", object_dir);
-}
-
-void get_midx_rev_filename(struct strbuf *out, struct multi_pack_index *m)
-{
-	get_midx_filename(out, m->object_dir);
-	strbuf_addf(out, "-%s.rev", hash_to_hex(get_midx_checksum(m)));
+	if (ext)
+		strbuf_addf(out, "-%s.%s", hash_to_hex(hash), ext);
 }
 
 static int midx_read_oid_fanout(const unsigned char *chunk_start,
diff --git a/midx.h b/midx.h
index dc477dff44..8554f2d616 100644
--- a/midx.h
+++ b/midx.h
@@ -74,9 +74,13 @@ struct multi_pack_index {
 #define MIDX_WRITE_BITMAP_HASH_CACHE (1 << 3)
 #define MIDX_WRITE_BITMAP_LOOKUP_TABLE (1 << 4)
 
+#define MIDX_EXT_REV "rev"
+#define MIDX_EXT_BITMAP "bitmap"
+
 const unsigned char *get_midx_checksum(struct multi_pack_index *m);
 void get_midx_filename(struct strbuf *out, const char *object_dir);
-void get_midx_rev_filename(struct strbuf *out, struct multi_pack_index *m);
+void get_midx_filename_ext(struct strbuf *out, const char *object_dir,
+			   const unsigned char *hash, const char *ext);
 
 struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local);
 int prepare_midx_pack(struct repository *r, struct multi_pack_index *m, uint32_t pack_int_id);
diff --git a/pack-revindex.c b/pack-revindex.c
index a7624d8be8..fc63aa76a2 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -381,7 +381,8 @@ int load_midx_revindex(struct multi_pack_index *m)
 	trace2_data_string("load_midx_revindex", the_repository,
 			   "source", "rev");
 
-	get_midx_rev_filename(&revindex_name, m);
+	get_midx_filename_ext(&revindex_name, m->object_dir,
+			      get_midx_checksum(m), MIDX_EXT_REV);
 
 	ret = load_revindex_from_disk(revindex_name.buf,
 				      m->num_objects,
-- 
2.45.1.217.g9bb58e2bf5a.dirty

