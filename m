Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63693F0744
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 08:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780995073; cv=none; b=hX1qo7uLZmIfoS/3FFN1obBsIoM6Z7WeuQUVeU0IVJSt5845qPbyB6Elbp/giUYS5szlyErJthUGcUoIhYrNciylR43CadnG0X/iCYXhVg8VCZdSuZuGy2RaX6AJEBJVoJEmMOqISY6CWcvSXphP1GW0fcNPEphWs02YBNdfgSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780995073; c=relaxed/simple;
	bh=u5aIdBt+60oSxscBNelbjaHbnyaWTl1tLbxkmcUJF5g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=SmOmsZoEDYRwizDdJWmHJEnvWmQZtjkPKPmjV/A+00TUN+BQvRiLae4ScqxufC9EeZCVLUmGYpITFBj3z8mK8T6EI4c3Fo+G+ZJLRZYzbEudiKprPX9yIHwTSPGV2d+l3t//2tyd3Yr+JSvnKoprEhj8tXW6KLu3j8vsK8hnRGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kwha/2zl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jlpi6eRr; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kwha/2zl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jlpi6eRr"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4926D7A01D8;
	Tue,  9 Jun 2026 04:51:10 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 09 Jun 2026 04:51:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780995070;
	 x=1781081470; bh=zHoW86WPcneU7yf0DTT2VL010J+Nko246o9HGz862gU=; b=
	kwha/2zl0lIh2XVuOc3TdtQr522d/bFN9gX6mapE6DqSo8sTGT7lr8LZ4PHJF1wq
	S4vne6mND2oo+qYLBv3ikzRfucCgotfPcjPliF+M/v303INBu3dL6cKsVFZi7ooJ
	ZInR8vqPCEqultYyIbucFrK1zt6GkQ9r5ZtCF8EBOmke/lbdsG523Mv9HA1hmfES
	rA1JYWWYkQQuNulUEyuiK0M4HgKJby3Sn/NZDOA+ubG1PLY4rqVbGNtJTQEeyjMZ
	TsQHxzXkSCC6hZ9S3nELo+4iT3os59zTGmBKaOaMptsnSRxCApgACJFNA1B5k2yg
	ZGJaEegWbA8jGkxATbi8cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780995070; x=
	1781081470; bh=zHoW86WPcneU7yf0DTT2VL010J+Nko246o9HGz862gU=; b=j
	lpi6eRr1slpvpxA231sg3vAbQLuAbTaNtM3ixKr1Kajop3NzBpH/NFC34x3YZ1ZL
	fDknd8jVU2hWgRW4bBZhFw4flhpV3/urNbRi3gSWLAbRrL/aOpJ7FWkFw6r6EZQR
	leshpwN3FPEqXtm5ZXcCsnNxAOMLb+wmI+V6lkVudEn2YI/xmJuyPO5lpQEMG4Ch
	Ez88nYlGLVWDL37zDV68nsNq9IDmjrJ2fjKaAsV2d3YwT9VZnKNwhA+Wo5cpZg3y
	extzVuQsLzKRjuhjdaXjE+n9SEyrN1925DmoKGHlePUMFd2p98iD2HP6Sqjtf5bv
	u0ptuJTeppsvK9sVxmWig==
X-ME-Sender: <xms:_dMnag_gn84X5CIkPGWUrHz4cbxvuDf0Zn3cyLM0d3YZ4MxUKspnZg>
    <xme:_dMnaut_xwUK6NM1S3gOWi98UbK3WSmw3Net_VmwDwINTLnhyRbDFMmxRlaynyCLn
    tdSPDPk0Wpt_F4OMtnWKqpnuFd8oN2SNMZje0WTnb7YIaGSWaWrgQ>
X-ME-Received: <xmr:_dMnajqPy51GkIiDdnwcbYntQLOqEXp6rxBueiSyYYJaSiRiAsYDh4LMamL3BTwS0wT58jJD45pPyQCJHv8cjS8y7R98k2r0Dnh9_6NBEQ0>
X-ME-Proxy-Cause: dmFkZTGuP93s74rTot6V+Vp+8Bg+LYR7+wo1tDukOntr8JhpDCuHbeogWqJyY7RXoEmZDX
    XdHzbGTF5v3VZFcJzd9xRipofoH7joz8gtG8rLSHa2+sTDkoFTd87fq9ZekU3z0/5DKV96
    x57tqQhBjOCp1ywc1W7nv9YH9duSXsYh8AYOXqeVxIDKwlt7G+BrORLZiU2WpVUwkN+gZN
    jE+oOwJbln9njSYg847D+Qle7snNncup8eRb/raQJXpDa5tUN3obMn74heq3qID9C3f+tP
    yNy/3JoieBoBMEICTxb17A+ifmU5b+VFoOaMjlomK5HYYP8ClKHtXZYgTkrPVeNWs6J3iU
    2N7DACQA1qrYpnm5QtbDGCzr9dcrb43g1UF4jqCaU+hbocAuiSAOD+zwKc9w888pX1qkbl
    8yf3mXi7YZzlpFcYH8fOfu5nDDJq3ranpkQIqyI/z4OZTewEPF3itZCpIRt9QJ8PUpBBwO
    FVNi/GyBESQx+IylEiD46O2GOtSeOluI4OFXT3unEauj5gTc4gPXUa5nK2xbgxOBNYxnrv
    A5zGinS/KHBE6j8rNZABh0eF6HXaSp2nUOnjwfW+03LCsB5z046wCktrsWGAfe6Xfb5XO0
    AVy1i6MLpivczT4e4CM1kMOsKq7dnGa7B2YIKrC/EsF0M/qYRHARRMC0MeLQ
X-ME-Proxy: <xmx:_dMnarlgrI-0yf04SjsCQl1prqJOGv_XcOzEer1Z78kP19pj70r2GQ>
    <xmx:_dMnanzinY15F2Bb4R1sM1clX1i6eZH7iKyK1_p_ZUfIPa9X2h56PQ>
    <xmx:_dMnajnCnBVE_P9hQO-_DlpB-iLQVG0Ed_fEba5edJaRm01E0_wV5A>
    <xmx:_dMnagebXmDHf2qEcTR4NB-V7h1rUKA5SUOfAueh1rD7-pba8NUKcQ>
    <xmx:_tMnavsDsgDvFIvhFQqnV_iliJREmlNDyPG9Soy2V3m29zaxZdS88uax>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 04:51:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id eb881627 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 9 Jun 2026 08:51:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 00/17] odb: make packed object source a proper `struct
 odb_source`
Date: Tue, 09 Jun 2026 10:50:53 +0200
Message-Id: <20260609-pks-odb-source-packed-v2-0-839089132c8b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO3TJ2oC/3WNyw6CMBBFf4XM2jFleKis/A/DgpZBKpGSDhAN4
 d8tGJcuT3LuPQsIe8sCRbSA59mKdX0AOkRg2qq/M9o6MJCiXOWKcOgEXa1R3OQN41CZjmtMzpS
 bJKNGZRcI28FzY1/77638skz6wWbczjajtTI6/97Dc7x5v0b6pzHHqJD4VOkk1qnOzDV4R/uEc
 l3XD/GVlNvJAAAA
X-Change-ID: 20260602-pks-odb-source-packed-3826c352f059
In-Reply-To: <20260604-pks-odb-source-packed-v1-0-2e7ab31b4b5c@pks.im>
References: <20260604-pks-odb-source-packed-v1-0-2e7ab31b4b5c@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

Hi,

this patch series converts the "packed" source into a proper `struct
odb_source`. It's thus the equivalent to [1], which did the same thing
for the "loose" source.

This series here is unfortunately a bit bigger, mostly because I'm also
renaming `struct packfile_store` to `struct odb_source_packed`. Back
when I introduced the packfile store I didn't yet have the full vision
of how the final layout will look like, so I didn't have the foresight
yet to call it `struct odb_source_packed`. But now that the layout has
materialized I think it's sensible to adjust its naming to match all the
other sources that we have.

Also: I don't have anything else in the pipeline anymore that moves
around large pieces of our code in the vicinity of the object database.
So after this series got merged, subsequent changes should be of a more
incremental nature.

This series is built on top of 9ac3f193c0 (The 11th batch, 2026-06-02)
with ps/odb-source-loose at ef4778bcba (odb/source-loose: drop pointer
to the "files" source, 2026-06-01) merged into it.

Changes in v2:
  - Split out `struct packfile_list` into a separate code unit to fix a
    cyclic dependency between "packfile.h" and "odb/souurce-packed.h".
  - Fix an extraneous newline.
  - Link to v1: https://patch.msgid.link/20260604-pks-odb-source-packed-v1-0-2e7ab31b4b5c@pks.im

Thanks!

Patrick

[1]: <20260521-b4-pks-odb-source-loose-v1-0-6553b399be2d@pks.im>

---
Patrick Steinhardt (17):
      packfile: rename `struct packfile_store` to `odb_source_packed`
      packfile: split out packfile list logic
      packfile: move packed source into "odb/" subsystem
      odb/source-packed: store pointer to "files" instead of generic source
      odb/source-packed: start converting to a proper `struct odb_source`
      odb/source-packed: wire up `close()` callback
      odb/source-packed: wire up `reprepare()` callback
      packfile: use higher-level interface to implement `has_object_pack()`
      odb/source-packed: wire up `read_object_info()` callback
      odb/source-packed: wire up `read_object_stream()` callback
      odb/source-packed: wire up `for_each_object()` callback
      odb/source-packed: wire up `count_objects()` callback
      odb/source-packed: wire up `find_abbrev_len()` callback
      odb/source-packed: wire up `freshen_object()` callback
      odb/source-packed: stub out remaining functions
      midx: refactor interfaces to work on "packed" source
      odb/source-packed: drop pointer to "files" parent source

 Makefile                   |   2 +
 builtin/cat-file.c         |   4 +-
 builtin/grep.c             |   2 +-
 builtin/multi-pack-index.c |  29 +-
 builtin/pack-objects.c     |   7 +-
 builtin/repack.c           |   8 +-
 commit-graph.c             |   4 +-
 meson.build                |   2 +
 midx-write.c               |  34 +-
 midx.c                     | 118 +++----
 midx.h                     |  30 +-
 odb/source-files.c         |  20 +-
 odb/source-files.h         |   4 +-
 odb/source-packed.c        | 764 +++++++++++++++++++++++++++++++++++++++++++
 odb/source-packed.h        |  94 ++++++
 odb/source.h               |   3 +
 pack-bitmap.c              |   8 +-
 pack-revindex.c            |   6 +-
 packfile-list.c            |  86 +++++
 packfile-list.h            |  28 ++
 packfile.c                 | 784 +--------------------------------------------
 packfile.h                 | 180 +----------
 repack-geometry.c          |   3 +-
 repack-midx.c              |   9 +-
 repack.c                   |   6 +-
 t/helper/test-read-midx.c  |   7 +-
 26 files changed, 1163 insertions(+), 1079 deletions(-)

Range-diff versus v1:

 1:  5fb0dcfef9 =  1:  8a5e5f5473 packfile: rename `struct packfile_store` to `odb_source_packed`
 -:  ---------- >  2:  179416a017 packfile: split out packfile list logic
 2:  a29ca59090 !  3:  6e54f9f918 packfile: move packed source into "odb/" subsystem
    @@ odb/source-packed.h (new)
     +#define ODB_SOURCE_PACKED_H
     +
     +#include "odb/source.h"
    ++#include "packfile-list.h"
     +#include "strmap.h"
     +
    -+struct packfile_list {
    -+	struct packfile_list_entry *head, *tail;
    -+};
    -+
    -+struct packfile_list_entry {
    -+	struct packfile_list_entry *next;
    -+	struct packed_git *pack;
    -+};
    -+
     +/*
     + * A store that manages packfiles for a given object database.
     + */
    @@ packfile.h
      #include "odb/source-files.h"
     +#include "odb/source-packed.h"
      #include "oidset.h"
    + #include "packfile-list.h"
      #include "repository.h"
     -#include "strmap.h"
      
    @@ packfile.h: struct packed_git {
      	char pack_name[FLEX_ARRAY]; /* more */
      };
      
    --struct packfile_list {
    --	struct packfile_list_entry *head, *tail;
    --};
    --
    --struct packfile_list_entry {
    --	struct packfile_list_entry *next;
    --	struct packed_git *pack;
    --};
    --
    - void packfile_list_clear(struct packfile_list *list);
    - void packfile_list_remove(struct packfile_list *list, struct packed_git *pack);
    - void packfile_list_prepend(struct packfile_list *list, struct packed_git *pack);
    -@@ packfile.h: void packfile_list_append(struct packfile_list *list, struct packed_git *pack);
    - struct packed_git *packfile_list_find_oid(struct packfile_list_entry *packs,
    - 					  const struct object_id *oid);
    - 
     -/*
     - * A store that manages packfiles for a given object database.
     - */
 3:  d0402d115b !  4:  85ebdcb253 odb/source-packed: store pointer to "files" instead of generic source
    @@ odb/source-packed.c
      }
     
      ## odb/source-packed.h ##
    -@@ odb/source-packed.h: struct packfile_list_entry {
    +@@
       * A store that manages packfiles for a given object database.
       */
      struct odb_source_packed {
 4:  d92302b497 !  5:  7d5605b9c7 odb/source-packed: start converting to a proper `struct odb_source`
    @@ odb/source-packed.c
      }
     
      ## odb/source-packed.h ##
    -@@ odb/source-packed.h: struct packfile_list_entry {
    +@@
       * A store that manages packfiles for a given object database.
       */
      struct odb_source_packed {
    @@ packfile.c: int parse_pack_header_option(const char *in, unsigned char *out, uns
      	for (struct packfile_list_entry *e = store->packs.head; e; e = e->next) {
     
      ## packfile.h ##
    -@@ packfile.h: void packfile_list_append(struct packfile_list *list, struct packed_git *pack);
    - struct packed_git *packfile_list_find_oid(struct packfile_list_entry *packs,
    - 					  const struct object_id *oid);
    +@@ packfile.h: struct packed_git {
    + 	char pack_name[FLEX_ARRAY]; /* more */
    + };
      
     -/*
     - * Free the packfile store and all its associated state. All packfiles
 5:  9a51dac274 !  6:  736dc22977 odb/source-packed: wire up `close()` callback
    @@ packfile.c: int parse_pack_header_option(const char *in, unsigned char *out, uns
      	struct packed_git *pack;
     
      ## packfile.h ##
    -@@ packfile.h: void packfile_list_append(struct packfile_list *list, struct packed_git *pack);
    - struct packed_git *packfile_list_find_oid(struct packfile_list_entry *packs,
    - 					  const struct object_id *oid);
    +@@ packfile.h: struct packed_git {
    + 	char pack_name[FLEX_ARRAY]; /* more */
    + };
      
     -/*
     - * Close all packfiles associated with this store. The packfiles won't be
 6:  b9571c28f1 !  7:  f2ec21206d odb/source-packed: wire up `reprepare()` callback
    @@ packfile.c: int packfile_store_read_object_info(struct odb_source_packed *store,
      		return 1;
     
      ## packfile.h ##
    -@@ packfile.h: void packfile_list_append(struct packfile_list *list, struct packed_git *pack);
    - struct packed_git *packfile_list_find_oid(struct packfile_list_entry *packs,
    - 					  const struct object_id *oid);
    +@@ packfile.h: struct packed_git {
    + 	char pack_name[FLEX_ARRAY]; /* more */
    + };
      
     -/*
     - * Prepare the packfile store by loading packfiles and multi-pack indices for
 7:  703181be7e =  8:  a41dbcf7d9 packfile: use higher-level interface to implement `has_object_pack()`
 8:  f1f1cb2044 =  9:  3fcdfc2686 odb/source-packed: wire up `read_object_info()` callback
 9:  91fad0e9ad = 10:  7b301ce67d odb/source-packed: wire up `read_object_stream()` callback
10:  0dc3c1b836 = 11:  5298ddece5 odb/source-packed: wire up `for_each_object()` callback
11:  461be09a17 ! 12:  929d7ad5af odb/source-packed: wire up `count_objects()` callback
    @@ odb/source-packed.c: static int odb_source_packed_for_each_object(struct odb_sou
     +out:
     +	return ret;
     +}
    -+
     +
      void (*report_garbage)(unsigned seen_bits, const char *path);
      
12:  c206556286 ! 13:  5de59e451d odb/source-packed: wire up `find_abbrev_len()` callback
    @@ odb/source-packed.c: static int odb_source_packed_count_objects(struct odb_sourc
     +	*out = min_len;
     +	return 0;
     +}
    - 
    ++
      void (*report_garbage)(unsigned seen_bits, const char *path);
      
    + static void report_helper(const struct string_list *list,
     @@ odb/source-packed.c: struct odb_source_packed *odb_source_packed_new(struct odb_source_files *parent)
      	packed->base.read_object_stream = odb_source_packed_read_object_stream;
      	packed->base.for_each_object = odb_source_packed_for_each_object;
13:  3ee5394ce8 = 14:  8e7b0f746c odb/source-packed: wire up `freshen_object()` callback
14:  875ca3572a = 15:  52967e0d24 odb/source-packed: stub out remaining functions
15:  5bd35384d6 = 16:  68cf451c52 midx: refactor interfaces to work on "packed" source
16:  d1a7ce9f17 ! 17:  fbed40d82a odb/source-packed: drop pointer to "files" parent source
    @@ odb/source-packed.c: struct odb_source_packed *odb_source_packed_new(struct odb_
      	return packed;
     
      ## odb/source-packed.h ##
    -@@ odb/source-packed.h: struct packfile_list_entry {
    +@@
       */
      struct odb_source_packed {
      	struct odb_source base;

---
base-commit: 06d49cec508464ced5d42541890ce5d749542a61
change-id: 20260602-pks-odb-source-packed-3826c352f059

