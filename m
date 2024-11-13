Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294CC203705
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 17:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731519183; cv=none; b=MjMpq0tyXqCrz+Mk1AkaQP/6vVzwf/P9uuKSjuYECsacdpNgC928yMjhCreklVUrhTbEWBl4gERslA7ORq9ijIThXS0bQB31SUotZ7WK/wgYHYcem0Fy9NUEkAbkXq8Mt0Wc3bGwwl2uN3QAk5oGFVR/aCgWgUNJm5iP/LySsns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731519183; c=relaxed/simple;
	bh=bNxNwPEX4s86ml7mwK0/jxiCPI38ol+nK7vf7k/YcCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6cBSboOTgzHcxtZRr7wlvJujL4DiT1JykEsY2NBXFD1tjpt52VyjvMGf82nJ6nvFbEzpoTRrSR/Wu+EPeVf/cuIn6nXJe7X1b+zps2E1h2YQKkrcGHwu/UaqyxeGIMtaW24OitvRMrmaXJiZpxGn559Goz414ycDzeY4VT6zuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=WpjZ2KnZ; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="WpjZ2KnZ"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6e5b7cd1ef5so62933447b3.1
        for <git@vger.kernel.org>; Wed, 13 Nov 2024 09:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1731519180; x=1732123980; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PeSYFvx79n5JDwW9PKZjwWIEALvfpf9i3QpuGiODegA=;
        b=WpjZ2KnZ1vKVxGgCBc4aDm14adobpi8OCXXnWpBxs7lxys3bfY1hajZwF9x10kguJS
         2I7BD0sEsOdwdBDlvnWUuBboAfyDsI73NbUilUSvY/7FZlFV3k1Tg1KVQarcYRi6LnKi
         nDZvfCqJKO8rc28WNOQDDgLVeWVw4ET6qrBzuPA2BkqBnCVxWKhL5oAWwfFZYktIowYv
         xsA4MfhWldgpUBBlCGU3X+n2B/dnvqhlcjNAmt45aafQt1jxybrHNcQbpBmN4iAJZgtY
         BYu+mkx+2akAXAVQtjQx5CRlF7yNzQzsX8UhMbnrZ3yWvW95DH9kgojut7UDSuPrYYUz
         aEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731519180; x=1732123980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PeSYFvx79n5JDwW9PKZjwWIEALvfpf9i3QpuGiODegA=;
        b=MWTTRC7vtE4wTTRYUkoIAgISHljn0cn4naJKVDd9QaFq0+Kuv9oEDNhbO2VAnhDoam
         tzC7LOliXdS7c/4Dehiwbqg4g0RK+PxQCz9pHVbzeZb7VBz2k4beJCkL17GClvbra6lO
         AS+5z6X0v+eDvEpJT+Wu8Iqh6MqxZQvsJ4a3PSGjbtxjNo8OMH8OPhmpifRClkzN8DLx
         SZqETYljGhbXHG9w8zrvWNc8T7lsizFqFbSOMjWoybFDODDhkdNWbavwD89oF3Gphcaz
         j1ev79+Ua47W8SxjGJ6RYvMwVY3yPvJosqSyQ0Yhg1bMyexPY/UTXUayqIeijNl2qQSs
         gTPQ==
X-Gm-Message-State: AOJu0YzML2IOkBc7C6BM8OsridH0i5d+cG9JC4n07QP01W7cs3+F1gsV
	melFwhQv8nSO+cUAOHXIKe/36I4b5x04nZ4NTPW55wUwRpeqG/VI+Sls/nZ3RnyxkI5SGa2H8m5
	fIDA=
X-Google-Smtp-Source: AGHT+IGCCVjHQfNMIgY0HkxfjaEzUztVU+2hYk5okTalrCojcIyOcVdOxYf+lZmjskgwqNnh3cuqwg==
X-Received: by 2002:a05:690c:67ca:b0:6e3:1063:91ca with SMTP id 00721157ae682-6eaddfbe8b4mr191582577b3.40.1731519179846;
        Wed, 13 Nov 2024 09:32:59 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eae5db4712sm26224867b3.52.2024.11.13.09.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 09:32:59 -0800 (PST)
Date: Wed, 13 Nov 2024 12:32:58 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH 2/2] pack-objects: only perform verbatim reuse on the
 preferred pack
Message-ID: <2520abf24a8a194b3f7040e218f878dc88a740a0.1731518931.git.me@ttaylorr.com>
References: <cover.1731518931.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1731518931.git.me@ttaylorr.com>

When reusing objects from source pack(s), write_reused_pack_verbatim()
is responsible for reusing objects whole eword_t's at a time. It works
by taking the longest continuous run of objects from the beginning of
each source pack that the caller wants, and reuses the entirety of that
section from each pack.

This is based on the assumption that we don't have any gaps within the
region. This assumption relieves us from having to patch any
OFS_DELTAs, since we know that there aren't any gaps between any delta
and its base in that region.

To illustrate why this assumption is necessary, suppose we have some
pack P, which has objects X, Y, and Z. If the MIDX's copy of Y was
selected from a pack other than P, then the bit corresponding to object
Y will appear earlier in the bitmap than the bits corresponding to X and
Z.

If pack-objects already has or will use the copy of Y from the pack it
was selected from in the MIDX, then it is an error to reuse all objects
between X and Z in the source pack. Doing so will cause us to reuse Y
from a different pack than the one which represents Y in the MIDX,
causing us to either:

 - include the object twice, assuming that the caller wants Y in the
   pack, or

 - include the object once, resulting in us packing more objects than
   necessary.

This regression comes from ca0fd69e37 (pack-objects: prepare
`write_reused_pack_verbatim()` for multi-pack reuse, 2023-12-14), which
incorrectly assumed that there would be no gaps in reusable regions of
non-preferred packs.

Instead, we can only safely perform the whole-word reuse optimization on
the preferred pack, where we know with certainty that no gaps exist in
that region of the bitmap. We can still reuse objects from non-preferred
packs, but we have to inspect them individually in write_reused_pack()
to ensure that any gaps that may exist are accounted for.

This allows us to simplify the implementation of
write_reused_pack_verbatim() back to almost its pre-multi-pack reuse
form, since we can now assume that the beginning of the pack appears at
the beginning of the bitmap, meaning that we don't have to account for
any bits up to the first word boundary (like we had to special case in
ca0fd69e37).

The only significant changes from the pre-ca0fd69e37 implementation are:

 - that we can no longer inspect words up to the end of
   reuse_packfile_bitmap->word_alloc, since we only want to look at
   words whose bits all correspond to objects in the given packfile, and

 - that we return early when given a reuse_packfile which is not
   preferred, making the call a noop.

In the future, it might be possible to restore this optimization if we
could guarantee that some reuse packs don't contain any gaps by
construction (similar to the "disjoint packs" idea in very early
versions of multi-pack reuse).

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c      | 101 +++++++++++++++---------------------
 t/t5332-multi-pack-reuse.sh |   2 +-
 2 files changed, 44 insertions(+), 59 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 08007142671..f413344e90c 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1100,78 +1100,64 @@ static void write_reused_pack_one(struct packed_git *reuse_packfile,
 
 static size_t write_reused_pack_verbatim(struct bitmapped_pack *reuse_packfile,
 					 struct hashfile *out,
-					 off_t pack_start,
 					 struct pack_window **w_curs)
 {
-	size_t pos = reuse_packfile->bitmap_pos;
+	size_t pos = 0;
 	size_t end;
 
-	if (pos % BITS_IN_EWORD) {
-		size_t word_pos = (pos / BITS_IN_EWORD);
-		size_t offset = pos % BITS_IN_EWORD;
-		size_t last;
-		eword_t word = reuse_packfile_bitmap->words[word_pos];
-
-		if (offset + reuse_packfile->bitmap_nr < BITS_IN_EWORD)
-			last = offset + reuse_packfile->bitmap_nr;
-		else
-			last = BITS_IN_EWORD;
-
-		for (; offset < last; offset++) {
-			if (word >> offset == 0)
-				return word_pos;
-			if (!bitmap_get(reuse_packfile_bitmap,
-					word_pos * BITS_IN_EWORD + offset))
-				return word_pos;
-		}
-
-		pos += BITS_IN_EWORD - (pos % BITS_IN_EWORD);
-	}
-
-	/*
-	 * Now we're going to copy as many whole eword_t's as possible.
-	 * "end" is the index of the last whole eword_t we copy, but
-	 * there may be additional bits to process. Those are handled
-	 * individually by write_reused_pack().
-	 *
-	 * Begin by advancing to the first word boundary in range of the
-	 * bit positions occupied by objects in "reuse_packfile". Then
-	 * pick the last word boundary in the same range. If we have at
-	 * least one word's worth of bits to process, continue on.
-	 */
-	end = reuse_packfile->bitmap_pos + reuse_packfile->bitmap_nr;
-	if (end % BITS_IN_EWORD)
-		end -= end % BITS_IN_EWORD;
-	if (pos >= end)
+	if (reuse_packfile->bitmap_pos) {
+		/*
+		 * We can't reuse whole chunks verbatim out of
+		 * non-preferred packs since we can't guarantee that
+		 * all duplicate objects were resolved in favor of
+		 * that pack.
+		 *
+		 * Even if we have a whole eword_t worth of bits that
+		 * could be reused, there may be objects between the
+		 * objects corresponding to the first and last bit of
+		 * that word which were selected from a different
+		 * pack, causing us to send duplicate or unwanted
+		 * objects.
+		 *
+		 * Handle non-preferred packs from within
+		 * write_reused_pack(), which inspects and reuses
+		 * individual bits.
+		 */
 		return reuse_packfile->bitmap_pos / BITS_IN_EWORD;
+	}
 
-	while (pos < end &&
-	       reuse_packfile_bitmap->words[pos / BITS_IN_EWORD] == (eword_t)~0)
-		pos += BITS_IN_EWORD;
+	/*
+	 * Only read through the last word whose bits all correspond
+	 * to objects in the given packfile, since we must stop at a
+	 * word boundary.
+	 *
+	 * If there is no whole word to read (i.e. the packfile
+	 * contains fewer than BITS_IN_EWORD objects), then we'll
+	 * inspect bits one-by-one in write_reused_pack().
+	 */
+	end = reuse_packfile->bitmap_nr / BITS_IN_EWORD;
+	if (reuse_packfile_bitmap->word_alloc < end)
+		BUG("fewer words than expected in reuse_packfile_bitmap");
 
-	if (pos > end)
-		pos = end;
+	while (pos < end && reuse_packfile_bitmap->words[pos] == (eword_t)~0)
+		pos++;
 
-	if (reuse_packfile->bitmap_pos < pos) {
-		off_t pack_start_off = pack_pos_to_offset(reuse_packfile->p, 0);
-		off_t pack_end_off = pack_pos_to_offset(reuse_packfile->p,
-							pos - reuse_packfile->bitmap_pos);
+	if (pos) {
+		off_t to_write;
 
-		written += pos - reuse_packfile->bitmap_pos;
+		written = (pos * BITS_IN_EWORD);
+		to_write = pack_pos_to_offset(reuse_packfile->p, written)
+			- sizeof(struct pack_header);
 
 		/* We're recording one chunk, not one object. */
-		record_reused_object(pack_start_off,
-				     pack_start_off - (hashfile_total(out) - pack_start));
+		record_reused_object(sizeof(struct pack_header), 0);
 		hashflush(out);
 		copy_pack_data(out, reuse_packfile->p, w_curs,
-			pack_start_off, pack_end_off - pack_start_off);
+			sizeof(struct pack_header), to_write);
 
 		display_progress(progress_state, written);
 	}
-	if (pos % BITS_IN_EWORD)
-		BUG("attempted to jump past a word boundary to %"PRIuMAX,
-		    (uintmax_t)pos);
-	return pos / BITS_IN_EWORD;
+	return pos;
 }
 
 static void write_reused_pack(struct bitmapped_pack *reuse_packfile,
@@ -1183,8 +1169,7 @@ static void write_reused_pack(struct bitmapped_pack *reuse_packfile,
 	struct pack_window *w_curs = NULL;
 
 	if (allow_ofs_delta)
-		i = write_reused_pack_verbatim(reuse_packfile, f, pack_start,
-					       &w_curs);
+		i = write_reused_pack_verbatim(reuse_packfile, f, &w_curs);
 
 	for (; i < reuse_packfile_bitmap->word_alloc; ++i) {
 		eword_t word = reuse_packfile_bitmap->words[i];
diff --git a/t/t5332-multi-pack-reuse.sh b/t/t5332-multi-pack-reuse.sh
index 8f403d9fdaa..06836a4206c 100755
--- a/t/t5332-multi-pack-reuse.sh
+++ b/t/t5332-multi-pack-reuse.sh
@@ -259,7 +259,7 @@ test_expect_success 'duplicate objects' '
 	)
 '
 
-test_expect_failure 'duplicate objects with verbatim reuse' '
+test_expect_success 'duplicate objects with verbatim reuse' '
 	git init duplicate-objects-verbatim &&
 	(
 		cd duplicate-objects-verbatim &&
-- 
2.46.0.421.g159f2d50e75
