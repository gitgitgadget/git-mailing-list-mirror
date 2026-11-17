Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794915547;
	b=SrI97rPM4sYocwBBoz0y6+UK4ilUPaXcGg2TmmAMOkJmV0MdKWy/9XAtXXeCq2bTIBrZ
	 xQJFeT0BGhKp6o5hmHYzrThNIJM6OmJguh7LvZhuOTc9E614cKEaM/A8o0JnuYKRvnVQ0
	 7NA2xByoV/+CSAJ4FJo/SIXl1jHXAz0PMC++Z6zy+O9mmQRnUV+Oi5sVjDZ8VFAf18fwV
	 HZODmalCq2s6VnndAGNYGhUJ+aloYxMZBp/Dff1Qoei3AOdg4dr6ikK8QWkXjTdwG7AbB
	 uPe7YPOjYVsWwfl4FaTKUkCyz3UDOKKJ82YBi4Pt5LpGwE/fjwIIqG7iecGxuvfw45A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794915547;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=I2btuEi6Y7OTP/Cdn7Q9MKtdENFwHKKIldFI63EPjc8=;
	b=oO7QEHbjiwktpOLeC+zxZHJ6XPeAy0S2VjQyaZKbr4O7OsdJj6AojH8WVMA00T2k5cyF
	 Cl3N2FO5Q7wABvY+9trGrw0R+YsSuVLNn3fNy3H5crZYsOjkj1Sx+o1/vw9p2QpprSnvv
	 3eMHQQsYEQ88b+iStrpaV1gDHelDQOlNtmOsCh05RJy9PSE80TfxAXaDMS1du8szqSCBe
	 G46F1J/A7bv6v3saIxvVj9xA4h2gjIA3mICsaIJk4tdWsBfGXWePVi1GI9La7APNKrk3n
	 eUVi+QZKN+m3QeCu7ZDcvhFHmI1IYimpbdobJquwVZ5D6By3ueFrBK9/5TV0l7RvawQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q7SjoWaQ;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D8C606A334
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 11:39:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40D8C606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q7SjoWaQ
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so29183085e9.3
        for <git@vger.kernel.org>; Tue, 17 Nov 2026 03:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794915545; x=1795520345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I2btuEi6Y7OTP/Cdn7Q9MKtdENFwHKKIldFI63EPjc8=;
        b=Q7SjoWaQ46qV62FCrL1VxhKpnXsnDvQdklj6RqDoI6Fe/iJJacGrzgOGiNp/foeVsb
         9vj+/BnIAdDrMN21KSQqnUE76ulNYQtHbVRn24mPnLIylFNib/f7t9L5c89lkJR5smn4
         Bz8vs9FHbUKOrZy3OpfzOvDAVNOzVprVVv0jQbYmZ1g6jSlRe1EeY/FVmwLCu5FQUDGl
         Q8C70s9tWSOizrAdQjZ/fP2c6In0fezAd3ToHwgFYP8RyjXgcMJLd5oViJXNxa6ztft2
         XiMh9u73G0TbIeOrolMcXogVTNDLYOIq309AInWgleDfmATYx07YNAWlwc9QyMVQ1ZSm
         6d5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794915545; x=1795520345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I2btuEi6Y7OTP/Cdn7Q9MKtdENFwHKKIldFI63EPjc8=;
        b=0b6Tu99RQ+U+qtg9evkmhpp/HnJkLgMcg3D2m+xJAuiUR3nbL+i2l+FJ+piVg+OlPy
         cZBOru4uIPHcPuOBzYfRDSHBrfRvGhhA8X9il9/DX8uGDsbQV3VU9CsuWWUarhQns4TL
         lDEJt+ZD1L9RSHnJdAzWLwe6SXWF6d/GYO3lLEx5tTAXRsGDJ9ObA9Bbg8XnNXrW8LuQ
         ExWGK0GZJZv7jc72LGFVWtQ0MQrttlBPgQgAD8r5e0qKm0Mui82VFZ4bvw2ylVwl8MtC
         IN+ks3Cic6ft4iLBsFrxot1GVcvEDGsUGyxVyDOwHdRzZr4WMe17XBjuMDBInMD8xPaU
         zFOw==
X-Gm-Message-State: APuU4Z9ye2As1AZ989R1aptSlhufrYzwVXQhwIwgV2Ti+4karlbdv6hy
	HiOu1eRWwYqiQDd8VaQyYHd+TzfyEVgPCHIEIA8S/7xodw4rmIi4szk8Aeu7yA==
X-Gm-Gg: AYBFou2uHimlEyz8TTWE1ejGeG/x4FmlJ2yrytZnGq7W5HyC4GMQrK/AQPk+5vSpB4V
	zkJqtCx1WNqRNupRGEdy8XWoVXdVAs0O2la3JE79vB2LIedATfa+Cr2tbzwxqqN3ZczR6h5zm1h
	Y8rdRwltBq4CE91TKBgiICQ0IB+feOZXWKhM3+TMuBxDg4FCKcNa5sUoQxP5ONeR1IvRFP2brnt
	9qmvvMb8vg0UkhsDWPrw4d83f1EEeMWATwm7VJ0Z3t8I6xAb82aogtcNSIQCCU6W/+H6MfYWiBP
	mDE5sJ4q0Ez/NLfrfK15HcEgjTkhDddwb1g7oH5RTVSTauvU222RYEnZJ0F5kowflhg6PFyWOBs
	+nEzmtuRDwCTZO1WHscsixKlJrfRagvavQzhGTuy0gmULIboQQIoEFX1Qu7rVCp9iyExjfBHCIj
	+Vmy89QPvxFhWXZVlsGKXzVITSPtn/zgQIujkiWl+mp4Z6nK4ch20hy/OfyEdWluEJQfQq9x5KN
	9/ayjmKdcrkxBuLmJsIQaVtfkc2alH3GsAIgSSIlr7+rEyjoAtlP7Y/bK/mvXmGG8LPaWkaxGYx
	Cxz1qtJf9j3S0I+Ja3PDgoAssAJHwQzKXGqE7CyxzqzW8NIfQdvGcpK3ha06lI4=
X-Received: by 2002:a05:600c:46c9:b0:4a1:f8cb:7d70 with SMTP id 5b1f17b1804b1-4bb55aa51ecmr312985255e9.24.1794915545203;
        Tue, 17 Nov 2026 03:39:05 -0800 (PST)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78420edasm93555925e9.9.2026.11.17.03.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 03:39:04 -0800 (PST)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Toon Claes <toon@iotcl.com>,
	Patrick Steinhardt <ps@pks.im>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Jonathan Tan <jonathantanmy@fastmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: [PATCH v2 0/5] loose object size checks and a few size truncations
Date: Tue, 17 Nov 2026 12:38:53 +0100
Message-ID: <cover.1794914210.git.gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793355390.git.gitter.spiros@gmail.com>
References: <cover.1793355390.git.gitter.spiros@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v1:

 - v1's 6/6 ("diff: use size_t in count_trailing_blank()") is dropped.
   The same line is now changed by 2/4 of v2 of my series "widen a
   few sizes and counts that are 32 bits everywhere" [1], which also
   widens the counter of count_trailing_blank().

 - Rebased onto master at e1ec09b23c (The 22nd batch), as v1 no longer
   applied: f495b0e7b9 (odb/source-files: reload alternates on retry,
   2026-10-28) also adds a test at the end of t1006, where 3/5 adds its
   tests. The code of the five patches is unchanged.

 - The messages of 2/5 and 5/5 now say that on 64-bit Windows "long"
   has 32 bits while size_t has 64, which is what truncates the sizes.

There were no comments on v1.

These patches come from the same search for truncated sizes on LLP64
(64-bit Windows, where "long" is 32 bits but size_t is 64 bits) as the
"use size_t for a few more object and buffer sizes" series [2]. Its
cover letter explains the method (a MinGW cross build and clang-tidy
with -Wshorten-64-to-32). For these I followed each value back to where
it comes from and forward to where it is used, because they can lead to
out-of-bounds memory accesses. For that reason I sent all of them but
3/5 to the git-security list first; they do not consider them security
issues, so here they are. While checking the loose object reader I also
found two missing size checks that have nothing to do with LLP64 (1/5
and 3/5).

 1/5 A loose object whose zlib stream is shorter than the size in its
     header is accepted, and the uninitialized tail of the buffer is
     handed out as object content (all platforms; e.g. "git cat-file
     commit" prints heap memory). A longer stream is silently cut.

 2/5 On Windows the size from the loose object header is truncated, so
     the caller gets a buffer much smaller than the size it is told,
     and reads beyond its end.

 3/5 The same check as 1/5 for the streaming reader of loose objects,
     which today streams out a short or long object without an error.

 4/5 "git cat-file --batch" writes memory past the end of objects
     between 2GiB and 4GiB (all platforms; non-blob objects, or blobs
     with --filters/--textconv).

 5/5 On Windows, concatenating notes that add up to 4GiB or more
     overflows a heap buffer.

1/5 and 3/5 come with tests, which are cheap, and fail without the
fix. The others would need objects of several GiB (and 2/5 and 5/5 a
32-bit "long"), so their commit messages describe how to reproduce
them instead. I have not run anything on Windows: the Windows-only
issues are based on reading the code and on the cross-compiled build.

5/5 passes the combined size to odb_write_object() through
cast_size_t_to_ulong(), as the length parameter is still an "unsigned
long" on master. With 1/4 of [2], which makes it a size_t, the cast
becomes unnecessary but harmless; the two series do not conflict.

The series is based on master at e1ec09b23c (The 22nd batch).

[1] https://lore.kernel.org/git/cover.1794909894.git.gitter.spiros@gmail.com/
[2] https://lore.kernel.org/git/cover.1793439137.git.gitter.spiros@gmail.com/

Elia Pinto (5):
  object-file: check size of inflated loose object against its header
  object-file: use size_t for loose object sizes
  odb/source-loose: check object size when streaming loose objects
  cat-file: use size_t for the length passed to batch_write()
  notes: avoid truncating the size of concatenated notes

 builtin/cat-file.c           |  2 +-
 notes.c                      |  7 +++----
 object-file.c                | 29 ++++++++++++++++++-----------
 object-file.h                |  6 +++---
 odb/source-loose.c           | 22 ++++++++++++++++++----
 t/lib-loose.sh               |  5 ++++-
 t/t1006-cat-file.sh          | 18 ++++++++++++++++++
 t/t1060-object-corruption.sh | 28 ++++++++++++++++++++++++++++
 8 files changed, 93 insertions(+), 24 deletions(-)

Range-diff against v1:
1:  6c2efb87fb = 1:  edb5f34498 object-file: check size of inflated loose object against its header
2:  ee4439354a ! 2:  eca5d3ddb8 object-file: use size_t for loose object sizes
    @@ Commit message
     
         Since c6a4629e32 (odb: use size_t for object_info.sizep and the size
         APIs, 2026-06-15), parse_loose_header() reports the object size as a
    -    size_t. But unpack_loose_rest() still takes an "unsigned long", which
    -    is only 32 bits on Windows. A header claiming 4GiB + 5 bytes thus
    -    makes us allocate a 6-byte buffer, the size check added by the previous
    -    commit is happy because the stream really has 5 bytes, and the caller
    -    gets that buffer back together with *oi->sizep set to 4GiB + 5. Any
    -    user of the object then reads far beyond the end of the buffer;
    -    read_loose_object() already does so when it hashes the contents.
    +    size_t, but unpack_loose_rest() still takes it as an "unsigned long".
    +    On 64-bit Windows, where "long" has 32 bits while size_t has 64, the
    +    size is truncated on the way. A header claiming 4GiB + 5 bytes thus
    +    makes us allocate a 6-byte buffer, the size check added by the
    +    previous commit is happy because the stream really has 5 bytes, and
    +    the caller gets that buffer back together with *oi->sizep set to
    +    4GiB + 5. Any user of the object then reads far beyond the end of the
    +    buffer; read_loose_object() already does so when it hashes the
    +    contents.
     
         Use size_t for the size in unpack_loose_rest() and check_stream_oid(),
         and while at it for the size of the mapped file in map_fd(),
3:  dee492c3d8 ! 3:  a8572aa836 odb/source-loose: check object size when streaming loose objects
    @@ odb/source-loose.c: static int odb_source_loose_read_object_stream(struct odb_st
      	st->z_state = ODB_LOOSE_READ_STREAM_INUSE;
     
      ## t/t1006-cat-file.sh ##
    -@@ t/t1006-cat-file.sh: test_objects_filter "object:type=commit"
    - test_objects_filter "object:type=tag"
    - test_objects_filter "object:type=tree"
    +@@ t/t1006-cat-file.sh: test_expect_success PIPE 'concurrently written alternates are loaded' '
    + 	)
    + '
      
     +test_expect_success 'setup blobs with bogus size in header' '
     +	git init bogus-size &&
4:  b2083632a1 = 4:  5b61a1b089 cat-file: use size_t for the length passed to batch_write()
5:  21f5a4e009 ! 5:  04f320d1de notes: avoid truncating the size of concatenated notes
    @@ Commit message
     
         combine_notes_concatenate() reads both notes with odb_read_object(),
         which returns their sizes as size_t, but computes the size of the
    -    combined buffer in an "unsigned long". On platforms where that type is
    -    32 bits wide, like Windows, two notes adding up to 4GiB or more give a
    -    small buf_len: we allocate that many bytes and then memcpy() the full
    -    contents of both notes into the buffer, writing far past its end.
    +    combined buffer in an "unsigned long". On 64-bit Windows, where "long"
    +    has 32 bits while size_t has 64, two notes adding up to 4GiB or more
    +    give a small buf_len: we allocate that many bytes and then memcpy()
    +    the full contents of both notes into the buffer, writing far past its
    +    end.
     
         The notes can come from a fetched notes ref. Besides notes merges with
         the "union" strategy and notes.rewriteMode=concatenate (the default),
6:  79f1781abd < -:  ---------- diff: use size_t in count_trailing_blank()

base-commit: e1ec09b23c8e0deb21a0b95ac5996422277395d4
-- 
2.53.0

