Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E061CB33A
	for <git@vger.kernel.org>; Wed, 29 May 2024 22:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717023347; cv=none; b=sGdAC68WerE7sY4zVDwg4AeapHvUul1b6x9K5beCXHPRKoLwvauiuLKiOXKLDJaHhDTWui+FoXDmzBNsd4RhfLLqXY8xZ6cG+FkXWQIGS8CICxPhwVquUCvZOBUvOaLdTqZ/kD8+jJHjtxT80xa1QpEvxCsiALxMDjk0NXLJP8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717023347; c=relaxed/simple;
	bh=ukeADAancgq8IGMI1ojGF+p3sxxbcBVYk43B3WJytwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgLbIMrCsT5Ij1nd2YkvYijCXBALTUbimglM0i0taorq7mQxEs5oHoi2lbTeY0R1abfcLn6cKlxlWzXYv4DgxUUb/WBHilFaAjWZ9b/tQqkiY2z1w0qNeFFyrx9uGBxHY/Z+pmABkQ3b+fhwyLz5xXDcUxMLeGEb5+/6KdXlpfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=lIPehZ55; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="lIPehZ55"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3d04c170118so74827b6e.1
        for <git@vger.kernel.org>; Wed, 29 May 2024 15:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1717023344; x=1717628144; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p4b4q/p62hnABvOLKsrxKFEtyh9sWfsD48Vnf+IZx3I=;
        b=lIPehZ55+nMuAMsP6uFEyBTfP30ZZlUnx6YtAchIZwAuGM30LwRmR6EVZ41tvCQ1ea
         RyWZ/mnyTDodpMxh46DzRLXJDiA7ZRoT62xlCk6HOSosNlku1o1S627IZtDqU9dkYTIG
         +FPauOOZEkB+mp+QL/JivJhQ50RJDW+/LnWQQepPnY/UDwdbi82rp2AJ7M5Ljj0AeJ3f
         V1AH8E0CAW0tZTC8n7ntAEeg03WNFdPSYeZRJFGNPIH3iBtKmVT9BwR0lVaMawcoeXNB
         wdFPF1qjaBX+laLJ57VrQe5e13Ovq0Rx7ZlYXFRLYzGscZljtQfBMEI7nNsTdW6/GyS0
         LQyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717023344; x=1717628144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4b4q/p62hnABvOLKsrxKFEtyh9sWfsD48Vnf+IZx3I=;
        b=RiZ6owjtn9pQkwgZvx0QSHCXodJI4/ZteScfTxfnSq+KmkHPu5euFhNrKxrmdFEbsj
         cckRe/dNX+a/AF7cbN00ePQ7unrdKZF1euNACjJu288WLtLcc/t9bCe3pxHA6Q1Rnj05
         JHDmsJNda2GfL6R1FXl5mXbcfAtfDxW7UEj5w5cHRa/sFLGpCYFLvF5rbRo6NTH5YDWb
         yYvTQK1Q9dOqyRp4HjyTIxlfJwxEJxsCcAQwE72SNaIkOD10Si5hil6wu3eytwl7+8S5
         VS8/kFt3viefAPQPZX8vKxPFv/7e9NH1uqeNxs0te0eVnCeJs4Q8gxj9fuuHoJlssirs
         MdOQ==
X-Gm-Message-State: AOJu0Yw8cUAyQOFbIGzK3MNmZtawbt5V50LPKcUqvyvnzgcMbiy3Kj5a
	rGTD2cpdmWxN5vK4HlRdNhgYGaM9hVkJGHWAihH+lxqMR5LLBtA2WSrZHBPt42vCOyrOx+HfXBO
	zDZY=
X-Google-Smtp-Source: AGHT+IGn1IZeiEBLx8HW50qItdMvFTE0yeEY/srLA0sdFEm9RljPimVklH63aaSss+yRAT7s1XHCaw==
X-Received: by 2002:a05:6808:2014:b0:3c8:69b6:9b7e with SMTP id 5614622812f47-3d1dcc9a0b1mr513727b6e.7.1717023344271;
        Wed, 29 May 2024 15:55:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ad7308a3ffsm43643606d6.106.2024.05.29.15.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 15:55:43 -0700 (PDT)
Date: Wed, 29 May 2024 18:55:42 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 7/8] midx: replace `get_midx_rev_filename()` with a
 generic helper
Message-ID: <f4f977c1c71ceed339361e8463bace9edc42ec45.1717023301.git.me@ttaylorr.com>
References: <cover.1716482279.git.me@ttaylorr.com>
 <cover.1717023301.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1717023301.git.me@ttaylorr.com>

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
2.45.1.321.gbcadaf92783

