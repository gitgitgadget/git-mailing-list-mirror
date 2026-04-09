Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA56040855
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 07:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775719477; cv=none; b=fL4YlML/dk5MPldTrjwtTDTDD8JDw9P+m2A57rks6f4Af0JqxUDoGqEt+ehF8s9xyAgnM8xHIZYq7WbD0KzVuszVJ9inXgT2OL1+A+JR0KbxYfRc2iv5qBN+WberZ/WNNc1n1Ebl3ivo+8yWf34cx9hjcY0ehILH9HnuMDgh080=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775719477; c=relaxed/simple;
	bh=zARagarksiO8BnxqhwNrQk817xunbFJOFVshL6QCJE8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=EXmFOn8hqz/SM5tk2lRF9a4Xpy+X2VC2+HCBt+Kur1xrpdxn0UXFyzFX1QSuJcgLbNmoC+nfHTsJPTX7eXrg7UVz1Lb8gOISNaYLt+ZcxdSyYnwNF4kJOp+nfKgRdyzCyHE3DedpOvFdaKRKmSD72gGcSMmsjR+BvmPciLy8GcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=V/EgDYOL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kqKkxVpq; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V/EgDYOL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kqKkxVpq"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3637114001F1;
	Thu,  9 Apr 2026 03:24:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 09 Apr 2026 03:24:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775719474;
	 x=1775805874; bh=SCSA8jjHMvndUV5Hl7L4UDwN4tm+HAknhF1sDA4HqUg=; b=
	V/EgDYOLgiAU7F9ZpmC6yAqjc2pUVH5I+1imoynfFFJTsUoafFAlK9mYWcc/z64k
	WLGrVdkX0FUDxABIc9/BV0QUSdHNsxTxf8EvuHZgfueVL0itZ+patH4ceAnmow9R
	LjEEQH5ikkWEfpx1Ue9SAKyi4ugb70Hre6VG/4s4F0Sr6dAws+CxzLLsUELrKwvI
	gnmOUTo5JEiU5oNeoDLsuVr2tgOCkuH8aVmXpw8kRMAM2cix6Q+hfDQ9L+tHzx9u
	V1IEvPKG6tZwLsY8zLWn5B2q1Q8xcQCOeg7RbX6Zvayk6D9/ObgzM9Tg3kJYBfBQ
	0npZSNmTk1HIfTESO1HU7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775719474; x=
	1775805874; bh=SCSA8jjHMvndUV5Hl7L4UDwN4tm+HAknhF1sDA4HqUg=; b=k
	qKkxVpqvD2PlSRlxDd6919NIvrthMe4bpWJYfVY82UmB3xglOWTl9ol3bqyibtLA
	jHxGNvG9TNTdVouhyySB2COOwM4GT9Tx2H2qgjX0rLmiwHriMGrurDmfv2U7VvK5
	FCeN6RwhBuLesqA+wGYV9IqyJtsB2Eeab5m2ygWSbQ81BRdnehtyTRTe9GIdOpLR
	hHitIERZYIwhn65I1bl1zFV5Re9P3HoDTejYVGs9ZXXEYyDJviRy/Jlf92CWsC9p
	+P797yjkKa0/bV+S7d2KpYG+Ncgc8ETy6DL2Hq0TceSwoeetsnyvzB7fk1XzD+Qj
	q0au9YlqAm33uygkbUCqQ==
X-ME-Sender: <xms:MVTXadUcXhtQwvubCnC4eD-QXN34xC4srvMH9PCVI8hR4F28T6oKnw>
    <xme:MVTXaVCcJzGFrFpuLiz_K26JHCWbzJxX7eyO8F-L-PetutEX65ELJucUs4a9eIQ7Q
    VO9ixMl3RvumcdI1Op0obXEUFoW9cfcu5BrZMp_MzdiQUtQzYnz>
X-ME-Received: <xmr:MVTXaWx2izJQreRFFgYXKQpaxrGR3MLJiiuRaX9tTc_a-LwnvOm89qZXpZI4po8Rr0ruKYtinnCIkJPByD6I69DrX_nnHszTrD4jzSYGvdk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvheekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhufffkfggtgfgjghfvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvdffkeektdefleetveegueethedtfeeugeegvddvhfdvtdetieeiueekhefgfeehnecu
    ffhomhgrihhnpehmshhgihgurdhlihhnkhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:MVTXaaD3II5isoAOW1NHM1MVxlPoRRiPTwKcd7-oYuQMy8O0HpMpOw>
    <xmx:MVTXabaqZJTl8s4srZOj5BAPyyq0k_DGNE2NcYLQ5b4SxNQV8BSMtg>
    <xmx:MVTXaai0ld4ofsZSJx4l8t2tCWNDf00ZIAua8ezxjnNdcZn1Ew-8tQ>
    <xmx:MVTXaV7lv-4qlr05PlJlMumqBjeV-hjRiyiwu5mHbwLJ-f2qygq8ww>
    <xmx:MlTXaZDKBTjLkbCs7fvwDSXGh96KQg3nmNztrCPFDg7Tvrv76QM5J_ot>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 03:24:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ca08dd74 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Apr 2026 07:24:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 00/17] odb: introduce "in-memory" source
Date: Thu, 09 Apr 2026 09:24:21 +0200
Message-Id: <20260409-b4-pks-odb-source-inmemory-v2-0-f02b4f1c0f13@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACZU12kC/32Nyw6CMBBFf4V07Zi2oKAr/8Ow6GOU0UBJB4iG8
 O8WjFuXNzn3nFkwRkIW52wWESdiCl0aepcJ15jujkA+baGlPspCKrAF9E+G4C1wGKNLQNdiG+I
 bSqtKV+X+hEUukqCPeKPXJr/W382jfaAbVuNKNMRDem71Sa3cL5T/C00KJFS28spYY/QBL4ncU
 yvqZVk+/wNoWNMAAAA=
X-Change-ID: 20260401-b4-pks-odb-source-inmemory-7b17c83d9e43
In-Reply-To: <20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im>
References: <20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.1

Hi,

this patch series introduces the second object database source type,
which is the "in-memory" source.

This source may seem somewhat odd at first: it always starts out empty,
and any object written into it will only exist in memory until the
process exits. But the source already serves a purpose in our codebase,
where some commands, for example git-blame(1), write an in-memory
worktree commit.

Furthermore, I think that going forward it can serve more purposes as we
now have an easy way to write and read objects that will not get
persisted. I could see that this may be useful when for example
re-merging diffs. But eventually, once we have the object storage format
extension wired up, callers might even want to manually set up an
in-memory database as the primary ODB for write operations so that no
data will be persisted in an arbitrary write.

Last but not least, this patch series also serves the purpose of
eventually getting rid of the `struct object_info::whence` member.
Instead, we'll simply yield the ODB source a specific object has been
read from, together with some backend-specific data, which gives
strictly more information compared to the status quo.

The series is based onb15384c06f (A bit more post -rc1, 2026-04-08)
with jt/odb-transaction-write at ddf6aee9c6 (odb/transaction: make
`write_object_stream()` pluggable, 2026-04-02) merged into it.

Changes in v2:
  - Fix handling of object IDs when writing objects.
  - I've changed the base of this series to include Justin's
    refactorings for the ODB write streams. I've updated the above
    paragraph detailing the merge base accordingly. @Junio: I'm fine to
    defer this patch series a bit until Justin's patch series has been
    merged to `next` in case this causes inconvenience.
  - Use "in-memory" instead of "inmemory" in commit messages.
  - Link to v1: https://patch.msgid.link/20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (17):
      odb: introduce "in-memory" source
      odb/source-inmemory: implement `free()` callback
      odb: fix unnecessary call to `find_cached_object()`
      odb/source-inmemory: implement `read_object_info()` callback
      odb/source-inmemory: implement `read_object_stream()` callback
      odb/source-inmemory: implement `write_object()` callback
      odb/source-inmemory: implement `write_object()` callback
      odb/source-inmemory: implement `write_object_stream()` callback
      cbtree: allow using arbitrary wrapper structures for nodes
      oidtree: add ability to store data
      odb/source-inmemory: convert to use oidtree
      odb/source-inmemory: implement `for_each_object()` callback
      odb/source-inmemory: implement `find_abbrev_len()` callback
      odb/source-inmemory: implement `count_objects()` callback
      odb/source-inmemory: implement `freshen_object()` callback
      odb/source-inmemory: stub out remaining functions
      odb: generic in-memory source

 Makefile                 |   1 +
 cbtree.c                 |  25 +++-
 cbtree.h                 |  11 +-
 loose.c                  |   2 +-
 meson.build              |   1 +
 object-file.c            |   3 +-
 odb.c                    |  82 ++--------
 odb.h                    |   4 +-
 odb/source-inmemory.c    | 378 +++++++++++++++++++++++++++++++++++++++++++++++
 odb/source-inmemory.h    |  33 +++++
 odb/source.h             |   3 +
 oidtree.c                |  66 ++++++---
 oidtree.h                |  12 +-
 t/unit-tests/u-oidtree.c |  26 +++-
 14 files changed, 532 insertions(+), 115 deletions(-)

Range-diff versus v1:

 1:  b7cd1ae8d1 !  1:  df8567d908 odb: introduce "inmemory" source
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
     
      ## Commit message ##
    -    odb: introduce "inmemory" source
    +    odb: introduce "in-memory" source
     
         Next to our typical object database sources, each object database also
         has an implicit source of "cached" objects. These cached objects only
    @@ Commit message
             for example the empty tree.
     
           - They can be used to store temporary objects that we don't want to
    -        persist to disk.
    +        persist to disk, which is used by git-blame(1) to create a fake
    +        worktree commit.
     
         Overall, their use is somewhat restricted though. For example, we don't
         provide the ability to use it as a temporary object database source that
    @@ Commit message
         as one.
     
         This is about to change over the following commits, where we will turn
    -    cached objects into a new "inmemory" source. This will allow us to use
    +    cached objects into a new "in-memory" source. This will allow us to use
         it exactly the same as any other source by providing the same common
         interface as the "files" source.
     
    -    For now, the inmemory source only hosts the cached objects and doesn't
    +    For now, the in-memory source only hosts the cached objects and doesn't
         provide any logic yet. This will change with subsequent commits, where
         we move respective functionality into the source.
     
    @@ Makefile: LIB_OBJS += object.o
      LIB_OBJS += odb/source-files.o
     +LIB_OBJS += odb/source-inmemory.o
      LIB_OBJS += odb/streaming.o
    + LIB_OBJS += odb/transaction.o
      LIB_OBJS += oid-array.o
    - LIB_OBJS += oidmap.o
     
      ## meson.build ##
     @@ meson.build: libgit_sources = [
    @@ meson.build: libgit_sources = [
        'odb/source-files.c',
     +  'odb/source-inmemory.c',
        'odb/streaming.c',
    +   'odb/transaction.c',
        'oid-array.c',
    -   'oidmap.c',
     
      ## odb.c ##
     @@
 2:  298758b4d5 !  2:  e1ffe26ca9 odb/source-inmemory: implement `free()` callback
    @@ Metadata
      ## Commit message ##
         odb/source-inmemory: implement `free()` callback
     
    -    Implement the `free()` callback function for the "inmemory" source.
    +    Implement the `free()` callback function for the "in-memory" source.
     
         Note that this requires us to define `struct cached_object_entry` in
         "odb/source-inmemory.h", as it is accessed in both "odb.c" and
 3:  b57997d027 =  3:  f58424bb80 odb: fix unnecessary call to `find_cached_object()`
 4:  9ae26b9aa1 !  4:  786a240391 odb/source-inmemory: implement `read_object_info()` callback
    @@ Metadata
      ## Commit message ##
         odb/source-inmemory: implement `read_object_info()` callback
     
    -    Implement the `read_object_info()` callback function for the inmemory
    +    Implement the `read_object_info()` callback function for the in-memory
         source.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
 5:  5d9781009e !  5:  22d3e7134b odb/source-inmemory: implement `read_object_stream()` callback
    @@ Metadata
      ## Commit message ##
         odb/source-inmemory: implement `read_object_stream()` callback
     
    -    Implement the `read_object_stream()` callback function for the inmemory
    +    Implement the `read_object_stream()` callback function for the in-memory
         source.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
 6:  bc9620c608 !  6:  139e7f2beb odb/source-inmemory: implement `write_object()` callback
    @@ Metadata
      ## Commit message ##
         odb/source-inmemory: implement `write_object()` callback
     
    -    Implement the `write_object()` callback function for the inmemory
    +    Implement the `write_object()` callback function for the in-memory
         source.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
 -:  ---------- >  7:  7f5ab16d1c odb/source-inmemory: implement `write_object()` callback
 7:  6d9f8634e1 !  8:  6006f5e782 odb/source-inmemory: implement `write_object_stream()` callback
    @@ Metadata
      ## Commit message ##
         odb/source-inmemory: implement `write_object_stream()` callback
     
    -    Implement the `write_object_stream()` callback function for the inmemory
    +    Implement the `write_object_stream()` callback function for the in-memory
         source.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    @@ odb/source-inmemory.c: static int odb_source_inmemory_write_object(struct odb_so
     +						   size_t len,
     +						   struct object_id *oid)
     +{
    ++	char buf[16384];
     +	size_t total_read = 0;
     +	char *data;
     +	int ret;
     +
     +	CALLOC_ARRAY(data, len);
     +	while (!stream->is_finished) {
    -+		unsigned long bytes_read;
    -+		const void *in;
    ++		ssize_t bytes_read;
     +
    -+		in = stream->read(stream, &bytes_read);
    ++		bytes_read = odb_write_stream_read(stream, buf, sizeof(buf));
     +		if (total_read + bytes_read > len) {
     +			ret = error("object stream yielded more bytes than expected");
     +			goto out;
     +		}
     +
    -+		memcpy(data, in, bytes_read);
    ++		memcpy(data, buf, bytes_read);
     +		total_read += bytes_read;
     +	}
     +
 8:  45f9c761ce =  9:  392d9bf6ed cbtree: allow using arbitrary wrapper structures for nodes
 9:  5eb7742886 = 10:  9fd88ffd16 oidtree: add ability to store data
10:  4f95cd0a51 ! 11:  6d4a77b47c odb/source-inmemory: convert to use oidtree
    @@ Metadata
      ## Commit message ##
         odb/source-inmemory: convert to use oidtree
     
    -    The inmemory source stores its objects in a simple array that we grow as
    +    The in-memory source stores its objects in a simple array that we grow as
         needed. This has a couple of downsides:
     
           - The object lookup is O(n). This doesn't matter in practice because
    @@ odb/source-inmemory.c: static int odb_source_inmemory_write_object(struct odb_so
     -	struct cached_object_entry *object;
     +	struct inmemory_object *object;
      
    + 	hash_object_file(source->odb->repo->hash_algo, buf, len, type, oid);
    + 
     -	ALLOC_GROW(inmemory->objects, inmemory->objects_nr + 1,
     -		   inmemory->objects_alloc);
     -	object = &inmemory->objects[inmemory->objects_nr++];
11:  fc231e22dc ! 12:  5f345d76ef odb/source-inmemory: implement `for_each_object()` callback
    @@ Metadata
      ## Commit message ##
         odb/source-inmemory: implement `for_each_object()` callback
     
    -    Implement the `for_each_object()` callback function for the inmemory
    +    Implement the `for_each_object()` callback function for the in-memory
         source.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
12:  c2437b2ba5 ! 13:  b428a1760b odb/source-inmemory: implement `find_abbrev_len()` callback
    @@ Metadata
      ## Commit message ##
         odb/source-inmemory: implement `find_abbrev_len()` callback
     
    -    Implement the `find_abbrev_len()` callback function for the inmemory
    +    Implement the `find_abbrev_len()` callback function for the in-memory
         source.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
13:  fee0586da7 ! 14:  564cc60392 odb/source-inmemory: implement `count_objects()` callback
    @@ Metadata
      ## Commit message ##
         odb/source-inmemory: implement `count_objects()` callback
     
    -    Implement the `count_objects()` callback function for the inmemory
    +    Implement the `count_objects()` callback function for the in-memory
         source.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
14:  634392eaf9 ! 15:  9ddfb6f67b odb/source-inmemory: implement `freshen_object()` callback
    @@ Metadata
      ## Commit message ##
         odb/source-inmemory: implement `freshen_object()` callback
     
    -    Implement the `freshen_object()` callback function for the inmemory
    +    Implement the `freshen_object()` callback function for the in-memory
         source.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
15:  3d1f08a849 = 16:  d76329a424 odb/source-inmemory: stub out remaining functions
16:  29deff493d ! 17:  41cd562975 odb: generic inmemory source
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
     
      ## Commit message ##
    -    odb: generic inmemory source
    +    odb: generic in-memory source
     
         Make the in-memory source generic.
     

---
base-commit: a3ebc5a08e67ccac4c915622049a968a31e48662
change-id: 20260401-b4-pks-odb-source-inmemory-7b17c83d9e43

