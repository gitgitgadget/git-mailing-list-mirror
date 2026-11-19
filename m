Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795069326;
	b=5GPY1A2WNcMI7rU5iSyft7NaugFJr4zTc7Pk/PKL6PmQcpzqZQ+2fmaS049Ss8A0eXk9
	 c++GQm1cc9MbJQRMM0Mmf7CgqkKlDv4SEbrrL+UK4EQSXIjxzjdZa2sc9oS4n7dDijtO1
	 9097m0zbnwOzSziSzKATzy0n+nnr4BquZGyugVPges6SHx8GLyFHnPkiGHpvxFIJiIldZ
	 4bXU8wNUyGh1aF8mJNT9yzniW2P1lGuNCriY4cLAXcBavsm3Om4PXz3qk6MdDYeyJwceW
	 WsdS48JkDl6wnzYlaFKGimgB9cxC5Qt+CWsl6Eefo6nNvY5FGoRUIMl+9yxXNNqE7AA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795069326;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+cRznS0gI+6wxVMlB3aaazelfwlgMwYaW9w8YG7XO9Q=;
	b=MqO3T0VDYBLReFZVlIPwaTseK8MvqwX2R8nYhlWggD1x6WnGS8P16TJiuVXbKTrit2yb
	 kK3q6YlFn08t+e9BTW6t+KrKERexyzYGhuinGiLVp3ugZGvQKVQClrQBJ2fA7f9wCd0y7
	 YrJqJSt/86gTGtj2migzFp+My7VKOo9X1FSs8euvQfmo/gWXhYDWS7W4cUQhGyibZ1AWF
	 eFhKyN1lrMFNZKjhosbqhjZrNC5hGKtcyKpYPsjaQh8HJ3BCNG3YPZcs+6mf1+YRAwqFf
	 iLoSKGbfIAfGXVhcmWCnD1u2jozpAZFuDy/whNZz8v0CafaW1Do3qRfmkTNIfC80xKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SHyujZod;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD92606A320
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 06:22:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CD92606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SHyujZod
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso13778035e9.0
        for <git@vger.kernel.org>; Wed, 18 Nov 2026 22:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795069324; x=1795674124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+cRznS0gI+6wxVMlB3aaazelfwlgMwYaW9w8YG7XO9Q=;
        b=SHyujZode2CjXZERBrj5iyNYAyH5pFyfwlL0zzazl3N7XAgPWe2xTyKHS7WQF0Rajz
         9tp6sWO1OPsYFWRy9D3ChkNrVeRNDXVd5qRQqKSQ1ZUWkFP6m0+z6YyNbtekaEN6kTwC
         6nm5g5FPyvQQ5LVpAC2lzD2mhxSEhvD4NBzwO7wXPWHxmj1EPw+AL2x9M/5nld17A5BM
         6iVu4Fnm+OA1jju7XfqrVvcPqoXm7qGyvYE2v+fM2DMejWPpYVVbuK3pwW8uik6xf0iD
         B/VV8+DGdjeHknCywZqgBkWp5jTKTErMJ4etbPK8/nNr6uvx5nx1pXw6x19RcdyL77j1
         3knw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795069324; x=1795674124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+cRznS0gI+6wxVMlB3aaazelfwlgMwYaW9w8YG7XO9Q=;
        b=kBLxF5xYuY2FHzAfIto1dMi+ew7jRMQzs3cjaJVidjL1XuI0+ICevuVJGOKNWEcaPg
         4Dx2MXrcIUjMWFO4siD2UfXmGdm/4lq8CMR7GQV7C4WpvcyessSRtiiyaKLdLCcFgKei
         smkgwaGDr74MhT7TfR3khzG++C0T3Dyhvdv46uG5O2l56tBkjemWMpgk0Lls7lEBJABT
         1faoR5AMW9jEhyvSvWRD+CKS7xBR3a8c9lU5xLnISOemSb8lZcmBBU2FEwBI/6GGsXqN
         vL0/8FmMrEpzFSgwzmavspdW9/aZW00k8/BoJYBH0ZPUPSTi725SscVvYhblKc3gpUUh
         LM7w==
X-Gm-Message-State: APuU4Z8BQzS084fqRcZa/wjZvzBNVQ+XgkIdGSJOqbCeXOIEmNUep5Nf
	iaLOMJ2yQ+8U9rWIbwx70IQ3mtw13mF1eE6QjLc9X9BqOfog5L8NanNeZMoXoQ==
X-Gm-Gg: AYBFou3Fi2zPAalkWuhXYJMKSWEtsWLDmLfogHRB0qgkaEkLIsmswpgA7WnkW26lc9r
	vkQagr7NXspSYO2ef2epwzlwFOKHiKJVQBcR3aOrB5DSBenIE33JKYyVBbl0az2kvqEbF6LCsy9
	fttGdNDs7JLQIHv9NH1gwQFgRuVtuRBkA7NH3reyxQ13Dhn28zR9bt1FmZiM8SIhurBLBBpoz87
	ukGHoaIbhv2hqaouljrcNnIeY2D0ATW62iNZAUx/xpPPxBIyCPm8xhLNOMMOR1QGB/Ay1bkYi+E
	EqlzVxK3QsCyjRRH7ouN3cdZMFEcQe1pOAI1iUbNf2l36hH9rcagn17CgWugTsHekatb17im152
	/aD1FWQDrwMAVMomg4D/FYCBIAPDtrpqdtPrdZDPKcNney2uVjHDRhZbHmwtPUWzLqYZ1B/8FS5
	1TIraEt/AYE3puw9el4SZ68D9OBM6stBjgHlom2MyDP95YsiPoJCvJxoJyekO++FGDXIEqoSOkk
	SQZbeySsc4e6faSseWvhqPVg9ZZRaPwopmt8oDBb+FZ6HKbFkgmnk2sacZ1wWOzvX5crByy3oeD
	b8KqqEPoGdDx0VwiVywwEo8RJ9huPhjqZRJjFK6oTI7iVrfCN52NWAeALSLCG50=
X-Received: by 2002:a05:600c:19d2:b0:4bb:5de1:e912 with SMTP id 5b1f17b1804b1-4bb7d5d6636mr97597645e9.1.1795069323630;
        Wed, 18 Nov 2026 22:22:03 -0800 (PST)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a654a8c406sm8508413f8f.14.2026.11.18.22.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 22:22:02 -0800 (PST)
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
Subject: [PATCH v3 0/5] loose object size checks and a few size truncations
Date: Thu, 19 Nov 2026 07:21:45 +0100
Message-ID: <cover.1795069177.git.gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794914210.git.gitter.spiros@gmail.com>
References: <cover.1794914210.git.gitter.spiros@gmail.com>
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

Changes since v2:

 - 1/5: a size mismatch now gets its own error message, "loose object
   '<oid>' has N bytes, but its header says M", as Patrick suggested,
   and the check is written as "total_out != hdrlen + size", as Junio
   preferred. The commit message explains the case of an object that
   fits entirely into the header buffer better.

 - 3/5: the new check no longer prints an error. Like the other
   failures in read_istream_loose() it returns -1 and leaves the
   message to the caller, as Junio suggested, so the oid member it
   needed is gone.

 - 2/5 now says why no st_add() is needed: the size is parsed with
   st_mult() and st_add(), and allocated before any other arithmetic
   is done on it.

 - Shorter commit messages, 4/5 in particular.

Not done: Patrick's suggestion to use memchr() instead of strlen() in
unpack_loose_rest(). parse_loose_header() has already made sure that
the header ends with a NUL, so I would leave that for a separate
patch.

The series, for those who missed v1 and v2:

 1/5 A loose object whose stream is shorter than the size in its header
     hands out uninitialized memory; a longer one is silently cut (all
     platforms).

 2/5 Where "long" has 32 bits while size_t has 64, the size from the
     loose object header is truncated and callers read past the buffer.

 3/5 The same check as 1/5 for the streaming reader.

 4/5 "git cat-file --batch" writes memory past the end of objects
     between 2GiB and 4GiB (all platforms).

 5/5 On 64-bit Windows, concatenating notes of 4GiB or more overflows a
     heap buffer.

All but 3/5 went to the git-security list first; they do not consider
them security issues. 1/5 and 3/5 have tests; the others would need
objects of several GiB, so their messages say how to reproduce them.

5/5 passes the size to odb_write_object() through
cast_size_t_to_ulong(), as its length is still an "unsigned long" on
master; with 1/4 of [1] the cast becomes unnecessary but harmless.

Based on master at e1ec09b23c (The 22nd batch).

[1] https://lore.kernel.org/git/cover.1793439137.git.gitter.spiros@gmail.com/

Elia Pinto (5):
  object-file: check size of inflated loose object against its header
  object-file: use size_t for loose object sizes
  odb/source-loose: check object size when streaming loose objects
  cat-file: use size_t for the length passed to batch_write()
  notes: avoid truncating the size of concatenated notes

 builtin/cat-file.c           |  2 +-
 notes.c                      |  7 +++----
 object-file.c                | 31 +++++++++++++++++++++----------
 object-file.h                |  6 +++---
 odb/source-loose.c           | 19 +++++++++++++++----
 t/lib-loose.sh               |  5 ++++-
 t/t1006-cat-file.sh          | 18 ++++++++++++++++++
 t/t1060-object-corruption.sh | 28 ++++++++++++++++++++++++++++
 8 files changed, 93 insertions(+), 23 deletions(-)

Range-diff against v2:
1:  edb5f34498 ! 1:  0d748dbd8e object-file: check size of inflated loose object against its header
    @@ Commit message
         object-file: check size of inflated loose object against its header
     
         unpack_loose_rest() allocates a buffer of the size given in the object
    -    header and inflates the rest of the stream into it, but it never checks
    -    that the stream actually produced that many bytes. If the compressed
    -    data ends early we return success with the tail of the buffer never
    -    written, and callers like odb_read_object() hand it out as object
    -    content. For example, "git cat-file commit" on a loose object whose
    -    header says "commit 200" but which contains only 44 bytes prints 156
    -    bytes of uninitialized heap memory.
    +    header, but never checks that the stream produced that many bytes:
     
    -    The opposite case slips through, too: when the whole object fits into
    -    the buffer filled by unpack_loose_header(), we copy only "size" bytes
    -    out of it, the stream has already ended, and the extra data is silently
    -    dropped.
    +     - If the stream is shorter, the unwritten tail of the buffer is handed
    +       out as object content: "git cat-file commit" on an object whose
    +       header says "commit 200" but which holds 44 bytes prints 156 bytes
    +       of uninitialized heap memory.
     
    -    The packfile reader in unpack_compressed_entry() and index-pack already
    -    compare total_out with the expected size. Do the same here and report
    -    the object as corrupt if they differ. Today fsck notices the first case
    -    only by accident, because it hashes the uninitialized bytes and gets a
    -    mismatch.
    +     - If the whole object fits into the MAX_HEADER_LEN bytes that
    +       unpack_loose_header() already inflated, the stream has ended before
    +       we get here; we copy only "size" bytes out of that buffer and
    +       silently drop the rest.
     
    -    Teach loose_obj() in lib-loose.sh to write a bogus size, so that the
    +    Compare total_out with the expected size, as unpack_compressed_entry()
    +    and index-pack already do, and say how many bytes we got when they
    +    differ.
    +
    +    Teach loose_obj() in t/lib-loose.sh to write a bogus size, so that the
         tests can create such objects.
     
         Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
    @@ object-file.c: void *unpack_loose_rest(git_zstream *stream,
      	if (bytes <= size) {
      		/*
     @@ object-file.c: void *unpack_loose_rest(git_zstream *stream,
    - 		}
    - 	}
    - 
    --	if (status != Z_STREAM_END) {
    -+	/*
    -+	 * Make sure that the stream produced exactly as many bytes as the
    -+	 * header claims. Otherwise we would hand back a buffer whose tail
    -+	 * was never written (if the stream is short), or silently drop data
    -+	 * (if the stream is long but ended before we noticed).
    -+	 */
    -+	if (status != Z_STREAM_END ||
    -+	    stream->total_out - hdrlen != size) {
    + 	if (status != Z_STREAM_END) {
      		error(_("corrupt loose object '%s'"), oid_to_hex(oid));
      		FREE_AND_NULL(buf);
    ++	} else if (stream->total_out != hdrlen + size) {
    ++		/*
    ++		 * A short stream would leave the tail of buf[] unwritten;
    ++		 * a long one can end inside the header buffer, so that
    ++		 * only "size" bytes were copied and the rest dropped.
    ++		 */
    ++		error(_("loose object '%s' has %"PRIuMAX" bytes, "
    ++			"but its header says %"PRIuMAX),
    ++		      oid_to_hex(oid), (uintmax_t)(stream->total_out - hdrlen),
    ++		      (uintmax_t)size);
    ++		FREE_AND_NULL(buf);
      	} else if (stream->avail_in) {
    + 		error(_("garbage at end of loose object '%s'"),
    + 		      oid_to_hex(oid));
     
      ## t/lib-loose.sh ##
     @@
    @@ t/t1060-object-corruption.sh: test_expect_success 'corrupted loose commit can be
     +
     +test_expect_success 'reading loose object shorter than its header fails' '
     +	test_must_fail git -C bogus-size cat-file commit $(cat oid-too-big) 2>err &&
    -+	test_grep "corrupt loose object" err
    ++	test_grep "has 5 bytes, but its header says 200" err
     +'
     +
     +test_expect_success 'reading loose object longer than its header fails' '
     +	test_must_fail git -C bogus-size cat-file commit $(cat oid-too-small) 2>err &&
    -+	test_grep "corrupt loose object" err
    ++	test_grep "has 11 bytes, but its header says 3" err
     +'
     +
     +test_expect_success 'fsck reports loose objects with bogus header size' '
     +	test_must_fail git -C bogus-size fsck 2>err &&
    -+	test_grep "corrupt loose object .$(cat oid-too-big)" err &&
    -+	test_grep "corrupt loose object .$(cat oid-too-small)" err
    ++	test_grep "loose object .$(cat oid-too-big). has 5 bytes" err &&
    ++	test_grep "loose object .$(cat oid-too-small). has 11 bytes" err
     +'
     +
      test_done
2:  eca5d3ddb8 ! 2:  c9facd8b3b object-file: use size_t for loose object sizes
    @@ Commit message
     
         Since c6a4629e32 (odb: use size_t for object_info.sizep and the size
         APIs, 2026-06-15), parse_loose_header() reports the object size as a
    -    size_t, but unpack_loose_rest() still takes it as an "unsigned long".
    -    On 64-bit Windows, where "long" has 32 bits while size_t has 64, the
    -    size is truncated on the way. A header claiming 4GiB + 5 bytes thus
    -    makes us allocate a 6-byte buffer, the size check added by the
    -    previous commit is happy because the stream really has 5 bytes, and
    -    the caller gets that buffer back together with *oi->sizep set to
    -    4GiB + 5. Any user of the object then reads far beyond the end of the
    -    buffer; read_loose_object() already does so when it hashes the
    -    contents.
    +    size_t, but unpack_loose_rest() takes it as an "unsigned long". Where
    +    "long" has 32 bits while size_t has 64, as on 64-bit Windows, a header
    +    claiming 4GiB + 5 bytes makes us allocate 6 bytes; the check added by
    +    the previous commit passes, as the stream does hold 5 bytes, and the
    +    caller then reads the object as 4GiB + 5 bytes long.
     
    -    Use size_t for the size in unpack_loose_rest() and check_stream_oid(),
    -    and while at it for the size of the mapped file in map_fd(),
    -    odb_source_loose_map_object() and unpack_loose_header(), so that the
    -    whole loose object reading path agrees on the type.
    +    Use size_t along the whole loose object reading path. No st_add() is
    +    needed on the way: the size is parsed with st_mult() and st_add(), and
    +    a buffer of that size is allocated with xmallocz() before anything is
    +    added to it or subtracted from it.
     
    -    There is no test, as the reader allocates a buffer of the size claimed
    -    in the header before it can notice that the stream is short, so a test
    -    would need 4GiB of memory. The problem can be reproduced on Windows
    -    with the loose_obj() helper from the previous commit:
    +    No test, as the reader allocates the claimed size before it notices
    +    the short stream. On Windows,
     
                 printf short |
                 loose_obj .git/objects commit $((4 * 1024 * 1024 * 1024 + 5))
     
    -    followed by "git cat-file commit" on the resulting object ID.
    +    and "git cat-file commit" on the resulting object reproduce it.
     
         Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
     
3:  a8572aa836 ! 3:  c694d3e128 odb/source-loose: check object size when streaming loose objects
    @@ Metadata
      ## Commit message ##
         odb/source-loose: check object size when streaming loose objects
     
    -    read_istream_loose() inflates a loose object until zlib reports the end
    -    of the stream, but never compares the number of bytes it produced with
    -    the size given in the object header. A corrupt object whose stream is
    -    shorter than its header claims is thus streamed out without any error,
    -    e.g. "git cat-file blob" exits with 0 after writing fewer bytes than
    -    "git cat-file -s" reports. The same happens if the stream is longer than
    -    the header claims.
    +    read_istream_loose() streams a loose object until zlib reports the end
    +    of the stream, but never compares the number of bytes with the size in
    +    the object header. "git cat-file blob" on an object whose stream is
    +    shorter or longer than its header claims thus exits with 0, writing a
    +    different number of bytes than "git cat-file -s" reports.
     
    -    Keep track of how many bytes we handed out and report the object as
    -    corrupt if that does not match the size from the header once the stream
    -    ends.
    -
    -    The tests create such objects with the loose_obj() helper, which can
    -    already write a bogus size into the header.
    +    Count the bytes handed out and fail the read if they do not match once
    +    the stream ends. Like the other errors in this function, this returns
    +    -1 silently and leaves the message to the caller, e.g. "unable to
    +    stream <oid> to stdout" from cat-file.
     
         Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
     
    @@ odb/source-loose.c: struct odb_loose_read_stream {
      	int hdr_avail;
      	int hdr_used;
     +	size_t total_read;
    -+	struct object_id oid;
      };
      
      static ssize_t read_istream_loose(struct odb_stream *_st, char *buf, size_t sz)
    @@ odb/source-loose.c: static ssize_t read_istream_loose(struct odb_stream *_st, ch
      			git_inflate_end(&st->z);
     +			/*
     +			 * The object must be exactly as large as its
    -+			 * header claims.
    ++			 * header claims; like the other errors below,
    ++			 * this is reported by our caller.
     +			 */
     +			if (st->total_read + total_read != st->base.size) {
    -+				error(_("corrupt loose object '%s'"),
    -+				      oid_to_hex(&st->oid));
     +				st->z_state = ODB_LOOSE_READ_STREAM_ERROR;
     +				return -1;
     +			}
    @@ odb/source-loose.c: static ssize_t read_istream_loose(struct odb_stream *_st, ch
      	return total_read;
      }
      
    -@@ odb/source-loose.c: static int odb_source_loose_read_object_stream(struct odb_stream **out,
    - 
    - 	st->mapped = mapped;
    - 	st->mapsize = mapsize;
    -+	oidcpy(&st->oid, oid);
    - 	st->hdr_used = strlen(st->hdr) + 1;
    - 	st->hdr_avail = st->z.total_out;
    - 	st->z_state = ODB_LOOSE_READ_STREAM_INUSE;
     
      ## t/t1006-cat-file.sh ##
     @@ t/t1006-cat-file.sh: test_expect_success PIPE 'concurrently written alternates are loaded' '
    @@ t/t1006-cat-file.sh: test_expect_success PIPE 'concurrently written alternates a
     +
     +test_expect_success 'streaming blob shorter than its header fails' '
     +	test_must_fail git -C bogus-size cat-file blob $(cat oid-too-big) >out 2>err &&
    -+	test_grep "corrupt loose object" err
    ++	test_grep "unable to stream" err
     +'
     +
     +test_expect_success 'streaming blob longer than its header fails' '
     +	test_must_fail git -C bogus-size cat-file blob $(cat oid-too-small) >out 2>err &&
    -+	test_grep "corrupt loose object" err
    ++	test_grep "unable to stream" err
     +'
     +
      test_done
4:  5b61a1b089 ! 4:  99bf45c606 cat-file: use size_t for the length passed to batch_write()
    @@ Commit message
         cat-file: use size_t for the length passed to batch_write()
     
         batch_write() takes the length of the data as an "int", but its callers
    -    pass the size of whole objects as returned by odb_read_object() or
    -    filter_object(), which is a size_t. For an object between 2GiB and
    -    4GiB the length wraps to a negative value, which fwrite() and
    -    write_or_die() then see as an enormous size_t. We happily write the
    -    object and then keep going past the end of the buffer, sending whatever
    -    memory follows to stdout, until we hit an unmapped page and die with
    -    "write error: Bad address". Objects of 4GiB and more are truncated
    -    instead, which desynchronizes the --batch output.
    -
    -    This affects all platforms, not only those with a 32-bit "long". It can
    -    be triggered with "--batch" on any non-blob object, or on blobs with
    -    --filters or --textconv, as blobs are otherwise streamed. For example:
    -
    -            blob=$(test-tool genzeros $((3 * 1024 * 1024 * 1024)) |
    -                   git hash-object -w --stdin) &&
    -            echo "$blob big" |
    -            git cat-file --batch="%(objectname) %(rest)" --filters >out
    -
    -    fails with "write error: Bad address"; with stdout going to /dev/null,
    -    strace shows write() being called on addresses far beyond the end of the
    -    3GiB buffer. There is no test, as it would need several GiB of memory
    -    and disk.
    -
    -    Both fwrite() and write_or_die() take a size_t already, so just change
    -    the parameter type.
    +    pass the size of whole objects, a size_t. On all platforms, an object
    +    between 2GiB and 4GiB gets a negative length, which fwrite() and
    +    write_or_die() see as an enormous size_t: "git cat-file --batch" writes
    +    memory past the end of the object to stdout until it dies with "write
    +    error: Bad address". Larger objects are truncated instead. Blobs are
    +    affected only with --filters or --textconv, as they are otherwise
    +    streamed.
    +
    +    Both callees take a size_t, so just change the parameter type.
     
         Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
     
5:  04f320d1de = 5:  d0cc63a8ed notes: avoid truncating the size of concatenated notes

base-commit: e1ec09b23c8e0deb21a0b95ac5996422277395d4
-- 
2.53.0

