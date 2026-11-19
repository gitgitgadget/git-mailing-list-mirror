Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795070644;
	b=kxhf/KNqKwLJyLGIQtyS2/RQgbojyeqSlZ4X2BKiXEF4t0HXf5k3dCZXs+Agw9skkc4+
	 uvv2uFtLgW3vkx6cM7+WM8NRr0o4uj5EqzIfyufFv0cmQkBUvca/CBn5tlzeR84ba4R/1
	 1GCnv4JpRpex037GIwKh/o7G885KBIVj295ulbICVrvS84bkchMUk0LwBa8awOyFX9lPY
	 ADiFMSxEsMN7kmWqwAPrsDQllzXsXVb1rzIrPkT/xrebKoIoexz4so4saQjvb1Aj+PlAr
	 cmBumaOwLiGI89LtHiii2eYqFmk1IhgNyhaSS0QrjOhc7z+qEDHM+it9txBvmx5DMng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795070644;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=oTxSwPHYdP+U+ZZiqX4Lr3A37C3vl5Ey9NiK/Acoh9k=;
	b=RUOBN8cDv+VrthZiWSReBxEZ3z8cn5l/QydlwYtSBqSe4FghgXJcgV+WPO0aXnMyaLcq
	 s1Nm6HJqvLZqF6M/z74GNGaPvU8IbwrOob1q4T/eRvvPeq+YXxrLZq6rnjiMd9dTX39zR
	 eu8PVN1/hi6ERZNeclE/7+fZ3hwPLmznZdEzsKyKmaFYHI9VqRA4+jduC+8vjZvkK1m2W
	 KTiJgZlFBughX69ggUyRm8q2G34nOozvRZWvRF6Gmvv3fEHpaRArdC7j1bMWlh86uOOtu
	 QHX5jCxldO+8LWf1A1dtS7kelANYoSfmzX8i+hCbN9u0HMcIpjDPm7dzhRFpsIBBjWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AIR92j8l;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3522A606A320
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 06:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3522A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AIR92j8l
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so19082585e9.3
        for <git@vger.kernel.org>; Wed, 18 Nov 2026 22:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795070642; x=1795675442; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oTxSwPHYdP+U+ZZiqX4Lr3A37C3vl5Ey9NiK/Acoh9k=;
        b=AIR92j8lgqF0Cmma5R3h/q4lDbvPdUSilbZXyXX/choIlIi01jq7TWqnnjwUb/pOWP
         AZZcd7GsaYFBp9pA4NDzgnKRj01aq8y+hRdprT5HlX+QQvw4hjWjmePJLdEftP3kginM
         78MbhzDCWRGWZntJ88j/9sGOMRoelvRkqUOpZlMbWh60WsZbyYEu+HW/1twsir8mo7tt
         OhRJhTT5C6orOmKt9SUGXsQyZO2cp4dyMiY0UIY9p/BiWBnfG5OaKf4TxdtiJ3xqdNYn
         446iBnKrshM4JtrIohya/x4OmNNFYBMOFIglaenK574z37S3ioJ6fevLU2fgxY6dZ7bu
         MWSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795070642; x=1795675442;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oTxSwPHYdP+U+ZZiqX4Lr3A37C3vl5Ey9NiK/Acoh9k=;
        b=CPhOzLfM+NZuFotNHZFvRHDXt/4we+pETMO2XGqGo7U4sTnICO5Zfi/zfSSQAHyjNV
         dHHLHGptFfmA5lUnwuwKchLI5AHTXJEq8JBJ1CnDTDF/V/6QHxJR+S2uHYNxcVd+9T8S
         oVv+aqWTO4QpVKOR9AemBFdeBlfeV/fHGqr/Tauz+UAeYNLoLAbR3mnuex9ewT+oe859
         zM+8HGPxuTdIUzVYfX/dnS/wr89WIAD4qKm2Vq8a+kfu5PJigo3DrNW4/aYuIPJfUUoA
         JfirPXEqVzRwfwiBtWCkIDDLqszURZHX9WKL2sanjqDVTdkSknnXKj667QP3nsgm8orq
         A04w==
X-Gm-Message-State: APuU4Z+NrnHHyhwel2te5bXlz1qwtE8FJyJ1oNLiijkqKijDdqj46EjX
	XdHZ0sqsR0pAmzgJv+XtnfK9zLxbVLyfOsQ+FfA9zmBfhBFGMYHe3B//KQrmIg==
X-Gm-Gg: AYBFou1001lEL6WUqR81uGMcQGEIbd1XaAETwt35wCBXbCPjvO7kxiExnUF7pWqbkXI
	46oxnhJHBL1zQgl+rdJzgkI3s9qMUTYGk0pX788uJgj9PeCVPOQTH6GRTiEMlokv4qp+W5G5pGb
	fGixjAAzvTMdi2TVA8irSImkKwvgfYCaKLEUEjR78ggYkiD5RTKQt71bFUO+a8VetXGgRT0C1IA
	R30sFGxT2X5W9U7aoPX2jJFgWQLFZynt/846GlZaCR8rn3iXJeXPrf1s0vTOE8i84Q6D31ZhYSX
	MPZ827yeCvmofEhvSWrIRMXeKRYWQBM0D2AftFOaRUVRDzn+sHdFYKyvJllkLfA7FfDSGE/yWIR
	Iq7vDqCee10YfcV3suir991iV5oQWKwBhjy8eJjhrcEz/WUqWZx8uvYqtohXqSjhZKQINH56hib
	l539i7NO6O4ObJDz78jJoMfG66gFYkkFUFmnxvMYnyo/TtHn68iwDslQa/d1yfW3GXNF2vAKLO7
	TSNZxtbbpZlJvdkESpkYdQs5DZMd9lR2xqH6z+QCZyKNE9o3P2NcvcutgRM7INHRweoJcccOogZ
	FiP0LQoS/NPvM3pBO6PKdTndGqPbm5Niw4szWmpZe70avkN3Nxn+GUqH/3JA+Kw=
X-Received: by 2002:a05:600c:6298:b0:4a2:397:73fd with SMTP id 5b1f17b1804b1-4bb7da1b37fmr97571505e9.12.1795070642310;
        Wed, 18 Nov 2026 22:44:02 -0800 (PST)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb85372d15sm15172955e9.14.2026.11.18.22.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 22:44:01 -0800 (PST)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Neeraj Singh <neerajsi@microsoft.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Michael Montalbo <mmontalbo@gmail.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Alexander Meshcheryakov <alexander.s.m@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3 0/4] widen a few sizes and counts that are 32 bits everywhere
Date: Thu, 19 Nov 2026 07:43:52 +0100
Message-ID: <cover.1795070117.git.gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794909894.git.gitter.spiros@gmail.com>
References: <cover.1794909894.git.gitter.spiros@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes since v2:

 - 1/4 no longer changes hashwrite(), which src/csum_file.rs declares
   with a u32 count. As Junio suggested and brian agreed, the callers
   that can write more than 4GiB at once now do it in pieces of at
   most 4GiB. There are three of them: the in-memory object in
   pack-objects, which v2 was about, plus copy_pack_data() in
   pack-objects and store_object() in fast-import, which I found while
   looking for the others.

 - 3/4 also widens the count of each span hash, as Junio asked. It
   adds up the bytes of all spans with the same hash, so with
   repetitive content it can wrap, and a count of 0 makes the entry
   look empty. A 16-bit simulation shows a missed rename for a file of
   zeros.

 - 4/4 says why a uintmax_t total does not overflow in practice, and
   describes the change to graph_width, as Junio asked.

 - Shorter commit messages, 2/4 and 4/4 in particular. Torsten's
   Tested-by is on 4/4, whose code is unchanged.

The series is still based on master at 50fe5cc63f (The 12th batch); it
merges cleanly with current master and seen.

Elia Pinto (4):
  pack-objects, fast-import: pass at most 4GiB at a time to hashwrite()
  diff: use size_t for sizes and line counts of complete rewrites
  diffcore-delta: use size_t for the buffer size and span counts
  diff: use uintmax_t for diffstat totals and graph scaling

 builtin/fast-import.c   |  9 ++++-
 builtin/pack-objects.c  | 15 ++++++-
 diff.c                  | 90 +++++++++++++++++++++++------------------
 diff.h                  |  2 +-
 diffcore-delta.c        |  6 +--
 t/t4022-diff-rewrite.sh | 51 ++++++++++++++++++++++-
 t/t4052-stat-output.sh  | 10 +++++
 7 files changed, 136 insertions(+), 47 deletions(-)

Range-diff against v2:
1:  07baad46b1 ! 1:  6399c46c3c csum-file: use size_t for the count passed to hashwrite()
    @@ Metadata
     Author: Elia Pinto <gitter.spiros@gmail.com>
     
      ## Commit message ##
    -    csum-file: use size_t for the count passed to hashwrite()
    +    pack-objects, fast-import: pass at most 4GiB at a time to hashwrite()
     
    -    hashwrite() takes the byte count as "uint32_t" on all platforms. When
    -    pack-objects writes the entire compressed buffer of an object in a
    -    single call, which can exceed 4GiB if the object is in memory, poorly
    -    compressible and core.bigFileThreshold is raised accordingly, it writes
    -    only "count mod 2^32" bytes, corrupting the pack.
    +    hashwrite() takes the byte count as a uint32_t. Three callers can hand
    +    it more than 4GiB at once, and then only "count mod 2^32" bytes end up
    +    in the pack, while the object header records the full size:
     
    -    This was verified using a 16-bit simulation, where "git cat-file" and
    -    "git fsck" failed after "git repack -a -d" with "offset beyond end of
    -    packfile (truncated pack?)".
    +     - write_no_reuse_object() in pack-objects writes a compressed object
    +       from memory in one call, which can exceed 4GiB when
    +       core.bigFileThreshold is raised above that;
     
    -    Make the count parameter of hashwrite() a "size_t". The internal loop
    -    already handles writing in buffer-sized blocks.
    +     - copy_pack_data() writes as much of a reused object as the pack
    +       window holds, which can exceed 4GiB when core.packedGitWindowSize
    +       is set that high;
     
    -    Triggering this requires processing an object of 4GiB or more, so no
    -    test is added.
    +     - store_object() in fast-import writes a compressed object from
    +       memory, like pack-objects, when its big file threshold allows it.
     
    +    Have these callers write in pieces of at most 4GiB, instead of widening
    +    hashwrite(), which src/csum_file.rs also declares with a u32.
    +
    +    With hashwrite() taking a 16-bit count and a 100KB random blob,
    +    "git repack -a -d", a second "git repack -a -d" reusing that pack, and
    +    "git fast-import" each leave a pack that fsck rejects with "offset
    +    beyond end of packfile"; with this patch fsck is happy. No test, as it
    +    would need an object of 4GiB or more.
    +
    +    Helped-by: Junio C Hamano <gitster@pobox.com>
    +    Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
         Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
     
    - ## csum-file.c ##
    -@@ csum-file.c: int finalize_hashfile(struct hashfile *f, unsigned char *result,
    - 	return fd;
    - }
    + ## builtin/fast-import.c ##
    +@@ builtin/fast-import.c: static int store_object(
    + 		pack_size += hdrlen;
    + 	}
    + 
    +-	hashwrite(pack_file, out, s.total_out);
    ++	/* hashwrite() takes at most 4GiB at a time */
    ++	for (size_t done = 0; done < s.total_out; ) {
    ++		uint32_t n = s.total_out - done > UINT32_MAX ?
    ++			     UINT32_MAX : s.total_out - done;
    ++
    ++		hashwrite(pack_file, (unsigned char *)out + done, n);
    ++		done += n;
    ++	}
    + 	pack_size += s.total_out;
    + 
    + 	e->idx.crc32 = crc32_end(pack_file);
    +
    + ## builtin/pack-objects.c ##
    +@@ builtin/pack-objects.c: static void copy_pack_data(struct hashfile *f,
    + 		in = use_pack(p, w_curs, offset, &avail);
    + 		if (avail > len)
    + 			avail = (unsigned long)len;
    ++		/* hashwrite() takes at most 4GiB at a time */
    ++		if (avail > UINT32_MAX)
    ++			avail = UINT32_MAX;
    + 		hashwrite(f, in, avail);
    + 		offset += avail;
    + 		len -= avail;
    +@@ builtin/pack-objects.c: static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
    + 		datalen = write_large_blob_data(st, f, &entry->idx.oid);
    + 		odb_stream_close(st);
    + 	} else {
    +-		hashwrite(f, buf, datalen);
    ++		const unsigned char *p = buf;
    ++		off_t left = datalen;
    ++
    ++		/* hashwrite() takes at most 4GiB at a time */
    ++		while (left) {
    ++			uint32_t n = left > UINT32_MAX ? UINT32_MAX : left;
    ++
    ++			hashwrite(f, p, n);
    ++			p += n;
    ++			left -= n;
    ++		}
    + 		free(buf);
    + 	}
      
    --void hashwrite(struct hashfile *f, const void *buf, uint32_t count)
    -+void hashwrite(struct hashfile *f, const void *buf, size_t count)
    - {
    - 	while (count) {
    - 		unsigned left = f->buffer_len - f->offset;
    -
    - ## csum-file.h ##
    -@@ csum-file.h: void free_hashfile(struct hashfile *f);
    -  * Finalize the hashfile by flushing data to disk and free'ing it.
    -  */
    - int finalize_hashfile(struct hashfile *, unsigned char *, enum fsync_component, unsigned int);
    --void hashwrite(struct hashfile *, const void *, uint32_t);
    -+void hashwrite(struct hashfile *, const void *, size_t);
    - void hashflush(struct hashfile *f);
    - void crc32_begin(struct hashfile *);
    - uint32_t crc32_end(struct hashfile *);
2:  e63ed0c49c ! 2:  aa16803558 diff: use size_t for sizes and line counts of complete rewrites
    @@ Commit message
         diff: use size_t for sizes and line counts of complete rewrites
     
         When "git diff -B" finds a complete rewrite, the diffstat comes from
    -    count_lines() and the patch from emit_rewrite_diff(). Neither goes
    -    through xdiff, so MAX_XDIFF_SIZE does not apply to them.
    -
    -    Without -B, a file this large does not get that far. If its contents
    -    have not been loaded yet and it is larger than core.bigFileThreshold
    -    (512MiB by default), it is treated as binary; otherwise xdiff refuses
    -    it, as it does not accept more than MAX_XDIFF_SIZE (just under 1GiB).
    -    With -B, should_break() in diffcore-break.c loads the contents without
    -    asking for the binary check, so core.bigFileThreshold is never looked
    -    at and a file too large for an "int" reaches count_lines().
    +    count_lines() and the patch from emit_rewrite_diff(), neither of which
    +    goes through xdiff and its MAX_XDIFF_SIZE limit. should_break() loads
    +    the contents without the binary check, so core.bigFileThreshold does
    +    not stop a large file either.
     
         count_lines() and emit_rewrite_lines() take the size as an "int". For
    -    a file of 2GiB or more the size is truncated, typically to a negative
    -    value, and both functions then see no data. As a result:
    -
    -     - "git diff -B --stat" reports 0 changed lines;
    -
    -     - "git diff -B -p" prints "@@ -0,0 +0,0 @@" with no body, a patch
    -       that "git apply" rejects as corrupt, and still exits with status 0.
    -
    -    Passing the size as a size_t is not enough. The size no longer bounds
    -    the "int" line counter in count_lines(), which overflows on a file of
    -    more than INT_MAX lines, and emit_rewrite_lines() would still truncate
    -    the size, leaving a correct hunk header above an empty body.
    -
    -    Use size_t throughout this code path instead:
    -
    -     - count_lines() takes a size_t and returns a size_t count, which
    -       struct diffstat_file already stores in uintmax_t;
    -
    -     - count_trailing_blank() uses size_t for its counter, which overflows
    -       on a file ending in more than INT_MAX blank lines, and for the size,
    -       which it stored in a "long". On LLP64 platforms such as 64-bit
    -       Windows, where "long" has 32 bits while size_t has 64, a size of
    -       2GiB or more would move the pointer before the start of the buffer.
    -       This was found by inspection and has not been tested on such a
    -       platform;
    -
    -     - emit_rewrite_diff(), add_line_count() and check_blank_at_eof() hold
    -       and print these counts as size_t, as do the line number and blank
    -       line fields of struct emit_callback;
    -
    -     - emit_rewrite_lines() takes the size as a size_t. The length of one
    -       line remains an "int" because emit_del_line() and emit_add_line()
    -       take one, so use cast_size_t_to_int() to die instead of truncating
    -       it when a single line is longer than INT_MAX;
    -
    -     - builtin_checkdiff() follows the type of the field it reads. It is
    -       still protected by the xdiff limit.
    -
    -    To reproduce, using about 2.2GiB of working tree data:
    +    a file of 2GiB or more it is truncated, typically to a negative value,
    +    and both see no data: "git diff -B --stat" reports 0 changed lines, and
    +    "git diff -B -p" prints "@@ -0,0 +0,0 @@" with no body, a patch that
    +    "git apply" rejects, and still exits with 0.
    +
    +    Widening the size alone is not enough, as the "int" line counter in
    +    count_lines() then overflows on a file of more than INT_MAX lines. Use
    +    size_t for the sizes and line counts along the whole path, up to struct
    +    emit_callback; struct diffstat_file already stores the counts in
    +    uintmax_t. A single line longer than INT_MAX goes through
    +    cast_size_t_to_int(), as emit_del_line() and emit_add_line() take an
    +    "int" length.
    +
    +    count_trailing_blank() gets a size_t counter too: without it, a build
    +    with "make SANITIZE=signed-integer-overflow" stops there on a rewrite
    +    to 2200MiB of newlines. Its size was a "long", which on 64-bit Windows,
    +    where "long" has 32 bits while size_t has 64, could move the pointer
    +    before the start of the buffer.
    +
    +    To reproduce, with about 2.2GiB of working tree data:
     
                 yes old | head -c 2200M >big &&
                 git add big &&
    @@ Commit message
                 yes new | head -c 2200M >big &&
                 git diff -B --stat
     
    -    Before this patch this reports 0 insertions and 0 deletions. With it,
    -    it reports 576716800 of each.
    -
    -    Add two tests to t4022, marked EXPENSIVE because they need several GiB
    -    of disk space and take minutes to run. The first checks the numstat
    -    and the patch for a file of 2GiB. The second checks the numstat for a
    -    file of 2^31 lines. Both fail before this patch, and also with only the
    -    size parameter of count_lines() changed.
    +    reports 0 insertions and 0 deletions before this patch, and 576716800
    +    of each with it.
     
    -    The tests run only where size_t and "long" have 64 bits. struct
    -    diff_filespec still holds the size of the file in an "unsigned long",
    -    and the tests have not been run on a platform where "long" has 32
    -    bits, such as Windows, whose CI would run them.
    -
    -    The count_trailing_blank() overflow is not covered by these tests. It
    -    only affects whitespace highlighting, so it is not visible in the
    -    uncoloured output. It was checked instead with a build using
    -    "make SANITIZE=signed-integer-overflow", by running "git diff -B -p"
    -    on a complete rewrite to a file of 2200MiB of newlines: the sanitizer
    -    stops in count_trailing_blank() without this change and reports nothing
    -    with it.
    +    The two tests added to t4022, for a file of 2GiB and one of 2^31
    +    lines, are marked EXPENSIVE, as they need several GiB of disk and take
    +    minutes. They also require "long" to have 64 bits, as struct
    +    diff_filespec still keeps the size in an "unsigned long".
     
         Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
         Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
    -    ---
    -    Changes since v1:
    -
    -     - v1 only changed the size parameter of count_lines(). Phillip pointed
    -       out that this removes the bound that kept the "int" counter from
    -       overflowing, so count_lines() now counts and returns a size_t.
    -
    -     - emit_rewrite_lines() now takes a size_t. With v1, "git diff -B -p"
    -       printed a correct hunk header above an empty body.
    -
    -     - count_trailing_blank() and the callers and fields that hold line
    -       counts now use size_t. This also fixes a "long" size that is too
    -       small on LLP64 platforms.
    -
    -     - Add EXPENSIVE tests to t4022. Both fail on master and with v1.
    -
    -     - The commit message is rewritten. v1 said that only the diffstat was
    -       affected and that there were no memory access issues; neither claim
    -       holds. The 16-bit simulation is replaced by a reproduction on a real
    -       file.
     
      ## diff.c ##
     @@ diff.c: static struct diff_tempfile {
3:  3427c3d2c8 ! 3:  621d98669e diffcore-delta: use size_t for the size of the buffer to hash
    @@ Metadata
     Author: Elia Pinto <gitter.spiros@gmail.com>
     
      ## Commit message ##
    -    diffcore-delta: use size_t for the size of the buffer to hash
    +    diffcore-delta: use size_t for the buffer size and span counts
     
    -    hash_chars() in diffcore-delta.c takes the buffer size as an "unsigned
    -    int". With a file of 4GiB or more, it hashes only a prefix; because the
    -    similarity score is calculated against the full size, similarity is
    -    undervalued, so true renames are missed, which also affects
    -    "git log --follow" and merges.
    +    hash_chars() takes the size of the buffer as an "unsigned int", so for
    +    a file of 4GiB or more only a prefix is hashed. The similarity score is
    +    computed against the full size, so true renames are missed, which also
    +    affects "git log --follow" and merges.
     
    -    This was verified using a 16-bit simulation, where
    -    "git diff --cached -M" reported a delete and add instead of a rename
    -    (e.g., "D a" and "A b" instead of "R099 a b").
    +    The count kept for each span hash is an "unsigned int" as well, and it
    +    adds up the bytes of all spans with that hash. With repetitive content
    +    most spans share a hash, so a file of 4GiB or more can wrap it, and a
    +    count that wraps to 0 makes its entry look empty.
     
    -    Make the size variable "size_t".
    +    Use size_t for both. The hash value can stay an "unsigned int", as it
    +    is below HASHBASE. A hash table has at most 2^17 entries, so making
    +    them larger costs at most 1MiB more per file.
     
    -    Triggering this requires processing a file of 4GiB or more, so no test
    -    is added.
    +    With a 16-bit size or count, "git diff --cached -M" reports "D a" and
    +    "A b" instead of "R099 a b", for a rename of a random file and of a
    +    64KiB file of zeros respectively. No test, as it would need a file of
    +    4GiB or more.
     
    +    Helped-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
     
      ## diffcore-delta.c ##
    +@@
    + 
    + struct spanhash {
    + 	unsigned int hashval;
    +-	unsigned int cnt;
    ++	size_t cnt;
    + };
    + struct spanhash_top {
    + 	int alloc_log2;
     @@ diffcore-delta.c: static struct spanhash_top *hash_chars(struct repository *r,
      	unsigned int accum1, accum2, hashval;
      	struct spanhash_top *hash;
    @@ diffcore-delta.c: static struct spanhash_top *hash_chars(struct repository *r,
      	int is_text = !diff_filespec_is_binary(r, one);
      
      	i = INITIAL_HASH_SIZE;
    +@@ diffcore-delta.c: int diffcore_count_changes(struct repository *r,
    + 	s = src_count->data;
    + 	d = dst_count->data;
    + 	for (;;) {
    +-		unsigned dst_cnt, src_cnt;
    ++		size_t dst_cnt, src_cnt;
    + 		if (!s->cnt)
    + 			break; /* we checked all in src */
    + 		while (d->cnt) {
4:  692c503e97 ! 4:  bf516f9b4d diff: use uintmax_t for diffstat totals and graph scaling
    @@ Metadata
      ## Commit message ##
         diff: use uintmax_t for diffstat totals and graph scaling
     
    -    struct diffstat_file stores the number of added and deleted lines of
    -    each file in uintmax_t, but show_stats() and show_shortstats() add them
    -    up in "int" variables. When the total goes over INT_MAX, the summary
    -    line overflows. With the previous patch, a single file is enough: for
    -    a complete rewrite into a file of 2^31 lines, "git diff -B --stat"
    -    ends with
    +    show_stats() and show_shortstats() add up the per-file line counts,
    +    which struct diffstat_file keeps in uintmax_t, in "int" variables, so
    +    the summary line overflows past INT_MAX lines. With the previous patch
    +    one file is enough: a complete rewrite into a file of 2^31 lines makes
    +    "git diff -B --stat" end with
     
                 1 file changed, -2147483648 insertions(+), 1000 deletions(-)
     
    -    Several files whose changes add up to more than INT_MAX lines lead to
    -    the same overflow even without -B.
    +    Add them up in uintmax_t and print them as such in
    +    print_stat_summary(), which "git apply --stat" also uses; apply.c keeps
    +    its own "int" totals for now. A uintmax_t total cannot overflow in
    +    practice: each line counted is at least one byte that git has read,
    +    and nobody feeds git 2^64 bytes.
     
    -    Use uintmax_t for these totals and for the parameters of
    -    print_stat_summary() and print_stat_summary_inserts_deletes(), which
    -    printed them with "%d". print_stat_summary() is also called by
    -    "git apply --stat", hence the change of its prototype in diff.h.
    -    apply.c still adds up its own totals in "int"; it is left alone here.
    +    The graph has two more problems:
     
    -    The graph has a similar problem. scale_linear() takes the number of
    -    changed lines and max_change as "int", although show_stats() holds
    -    them in uintmax_t, and computes "it * (width - 1)" in "int". The
    -    product overflows even for a small file when the graph is wide enough.
    -    For a new file of 50000 lines,
    +     - scale_linear() computes "it * (width - 1)" in "int", which overflows
    +       even for small files when the graph is wide: for a new file of 50000
    +       lines, "git diff --stat=46100 --stat-graph-width=46000" prints no
    +       "+" at all. It now works in uintmax_t; its result is at most
    +       "width", so it still fits in an "int".
     
    -            git diff --stat=46100 --stat-graph-width=46000
    +     - The "int" graph_width was set to max_change, which may not fit.
    +       Cap it at "width" instead. A wider graph is cut down to "width"
    +       right after anyway, so the output only changes where max_change did
    +       not fit.
     
    -    prints no "+" at all, because 50000 * 45999 is larger than INT_MAX.
    -    Make scale_linear() take uintmax_t, so that the product is computed in
    -    uintmax_t. Its result is at most "width", so it still fits in an
    -    "int".
    -
    -    show_stats() also assigned max_change to the "int" graph_width. Cap it
    -    at "width" instead: a wider graph is cut down to fit "width" right
    -    after, so the output does not change when max_change fits in an "int".
    -
    -    When the graph is not scaled, the numbers of added and deleted lines
    -    are copied as they are into "add" and "del", which stay "int": in that
    -    case both are smaller than graph_width.
    -
    -    Add the graph case to t4052. The test fails without this patch and is
    -    cheap enough to run by default. The totals are not tested, because
    -    going over INT_MAX lines needs a file of 2GiB or more.
    +    Add the scale_linear() case to t4052; it fails without this patch. The
    +    totals are not tested, as they need a file of 2GiB or more.
     
    +    Tested-by: Torsten Bögershausen <tboegi@web.de>
         Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
     
      ## diff.c ##

base-commit: 50fe5cc63f9cd6e89b87a2c9ccf96a444f4cfdb7
-- 
2.53.0

