Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA1A1FBCB2
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 07:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755761951; cv=none; b=mTqpYAgjdFP0jpVzuKMOUxA/nsF/hnhz5Qt3lSvRLZ1cR7UcVCF+W0iNBGVfJ9/fNMnlE8dqjvELHKooOiNSg/l8csEjDtt5PEfEWEjOYY+IMeWSsRyxXaXjL4fK8v3aLlf3Q1x58NuuTtqJjg02XSuhAlC9+LjKY/xQrLzeilc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755761951; c=relaxed/simple;
	bh=ggSF5UeF7am1vKmsLUd0HFBgMxc3LsUbAVJah0SfWEk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=cXtaqD+xd1ZeH5o3p2P5FSr8yp5FlMD1mDL/tZj3DulEdHBPGD8bS4zL8nlVWr4nftb4u9hbi7zPY5vUsFfmStcmufdkqiuGdXQayX2emsQfIZ6cx0cUoXuu7HkprXTp9ZqbX8FwTk3eQEdnpx6+Y2KMoYAgV6hiWF9CvEU8Ju4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QslRpHrk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KhERtxrt; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QslRpHrk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KhERtxrt"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 15EBB14000B6;
	Thu, 21 Aug 2025 03:39:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 21 Aug 2025 03:39:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755761948;
	 x=1755848348; bh=SlBgIr9eNacHZcDb213B3WGPT+Y8fChOKiU3iIgIwkY=; b=
	QslRpHrkqQ5aDgfiNXSokNSRLM8fQ0H7t7+sQCbAHqO4RZVoJS97lLnuVgfeBidU
	tFq6wxASmkbnpHJGIypBoeZQO/RMchYRu4s3p+qLcdThp/zPZisyQs9ITRuhsM/A
	sNjUqA8VY8XsTsgJf7mlg45jNY+96bcZfWbpGapwvK6ugXHEekl/nZnitn1edA4E
	gLnHywFuvkgLbT9okuY6N2H4HvDLDzK01EmQ11uoSQfmGrRtU3b5XfB6Rta8Vy0a
	LpvfqSugGBNVQSyxoHV2+dUWd40p5o1F1kTQsWMqQ8D2RLAfEItX0C2qXh3DmDWe
	z6wt/NVBZjOP5OVK7ruunw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755761948; x=
	1755848348; bh=SlBgIr9eNacHZcDb213B3WGPT+Y8fChOKiU3iIgIwkY=; b=K
	hERtxrtWV6Rn3maNyvyCFntMbMnLn/LekMdCg54EsCR+7Wx9L/n65Nhq3/6KmfwU
	UNB1jprqmvJuoGB8ibn71la9ywUQkAeImt2hn5BHopUcN4yYOSubtien2RJSKktb
	ZASi9tJH2NvoDJdGlR/ZRzoaP3rd9LJ/8C4AnveGM6DKwQrgRijEqGJiUWn9Kfgx
	Exn60JjayPKqKmDgg6KBIaCQxendDJkHlfaTGnKPjAD8nbbxsVbVkgdaojNSJWWH
	lzqVcpzHs7RzfJLDW7EHam3Q4Bm8O+vEjhIPb5vPopkq+W87sl9lWSHybo2ie01r
	GelUCCOZ0zO0o4OkPsyfg==
X-ME-Sender: <xms:G82maI8lI813l2EdhKnNlbJyFLRkLMaXWdAYGHXMFL8YynTkU61VJw>
    <xme:G82maD-AB8I1DnPwl4V1GjEZl3LMh7fb2ffQQJIsTV2-J9RM6huQFqFLRlti-yGnX
    Pvf0tqwogQFN1xWYA>
X-ME-Received: <xmr:G82maHe4SB9IOya30OdVmZZ2OQ9Y5m9F72umqg7w76iWkqoJf5fnT29D9fWRdGC86caXYbpCA7YfBFXERaGX8Zul7tEcF_XecoHr1SvjCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedtieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedtheefhfegffevgeegtdfhheeuvden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    fedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:G82maEHwxlEEMB7EPqGkM9j6qwYavf0Ttt4jc14kEsGbUWdYVG1IiA>
    <xmx:G82maNcyDHKsvVHbcbZkTW_TuH_BdpbVBjOtQq1PNrcWcrO-ZOyUXw>
    <xmx:G82maGHZ5UKrCtZO74lt2VSILCGeZDM1AlCuCCcZW5S5YX5AmOy08g>
    <xmx:G82maOV0xeNcjzypuKVJdFLipw9G4pSDZEhETDnd2zKC0BnuuGBYww>
    <xmx:HM2maAn1EigXMnIQ5bxLBtk-YSFi_UdBGwS3dkeydW2ZNh55g17fjMFt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 03:39:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fd005bdd (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 21 Aug 2025 07:39:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 00/16] packfile: carve out a new packfile store
Date: Thu, 21 Aug 2025 09:38:58 +0200
Message-Id: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABLNpmgC/3WNwQ6CMBBEf4Xs2TVtLQ144j8Mh1oX2aDQtKbRk
 P67hXj1+CYzb1aIFJginKsVAiWOvMwF1KECN9r5Tsi3wqCEqkUjDF41+imit24a+EER42sJhFZ
 ra0Tj7Kk1UMY+0MDvXXzpC4+89T77T5Jb+lPK9p8ySRQoTbFqRVLVtiutIz+hzzl/AdsZGca5A
 AAA
X-Change-ID: 20250806-b4-pks-packfiles-store-a44a608ca396
In-Reply-To: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

Hi,

information about a object database's packfiles is currently distributed
across two different structures:

  - `struct packed_git` contains the `next` pointer as well as the
    `mru_head`, both of which serve to store the list of packfiles.

  - `struct object_database` contains several fields that relate to the
    packfiles.

So we don't really have a central data structure that tracks our
packfiles, and consequently responsibilities aren't always clear cut.
A consequence for the upcoming pluggable object databases is that this
makes it very hard to move management of packfiles from the object
database level down into the object database source.

This patch series introduces a new `struct packfile_store`, which is
about to become the single source of truth for managing packfiles, and
carves out the packfile store subsystem.

This is the first step to make packfiles work with pluggable object
databases. Next steps will be to:

  - Move the `struct packed_git::next` and `struct packed::mru_head`
    pointers into the packfile store so that `struct packed_git` only
    tracks a single packfile.

  - Push the `struct packfile_store` down one level so that it's not
    hosted by the object database anymore, but instead by the object
    database source.

Changes in v2:
  - Convert the `initialized` flag into a boolean.
  - Polish some commit messages.
  - Some smaller formatting changes to the layout of `struct
    object_database`.
  - Link to v1: https://lore.kernel.org/r/20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (16):
      packfile: introduce a new `struct packfile_store`
      odb: move list of packfiles into `struct packfile_store`
      odb: move initialization bit into `struct packfile_store`
      odb: move packfile map into `struct packfile_store`
      odb: move MRU list of packfiles into `struct packfile_store`
      odb: move kept cache into `struct packfile_store`
      packfile: reorder functions to avoid function declaration
      packfile: refactor `prepare_packed_git()` to work on packfile store
      packfile: split up responsibilities of `reprepare_packed_git()`
      packfile: refactor `install_packed_git()` to work on packfile store
      packfile: always add packfiles to MRU when adding a pack
      packfile: introduce function to load and add packfiles
      packfile: move `get_multi_pack_index()` into "midx.c"
      packfile: remove `get_packed_git()`
      packfile: refactor `get_all_packs()` to work on packfile store
      packfile: refactor `get_packed_git_mru()` to work on packfile store

 builtin/backfill.c          |   2 +-
 builtin/cat-file.c          |   2 +-
 builtin/count-objects.c     |   2 +-
 builtin/fast-import.c       |   8 +-
 builtin/fsck.c              |   8 +-
 builtin/gc.c                |  12 +-
 builtin/grep.c              |   2 +-
 builtin/index-pack.c        |  10 +-
 builtin/pack-objects.c      |  22 ++--
 builtin/pack-redundant.c    |   4 +-
 builtin/receive-pack.c      |   2 +-
 builtin/repack.c            |   8 +-
 bulk-checkin.c              |   2 +-
 connected.c                 |   4 +-
 fetch-pack.c                |   4 +-
 http-backend.c              |   4 +-
 http.c                      |   4 +-
 http.h                      |   2 +-
 midx.c                      |  26 ++--
 midx.h                      |   2 +
 object-name.c               |   6 +-
 odb.c                       |  37 ++++--
 odb.h                       |  34 ++---
 pack-bitmap.c               |   4 +-
 pack-objects.c              |   2 +-
 packfile.c                  | 293 ++++++++++++++++++++++++--------------------
 packfile.h                  | 110 ++++++++++++++---
 server-info.c               |   2 +-
 t/helper/test-find-pack.c   |   2 +-
 t/helper/test-pack-mtimes.c |   2 +-
 transport-helper.c          |   2 +-
 31 files changed, 353 insertions(+), 271 deletions(-)

Range-diff versus v1:

 1:  49001587ad !  1:  5f89325948 packfile: introduce a new `struct packfile_store`
    @@ odb.h: struct object_database {
      	 *
      	 * should only be accessed directly by packfile.c
      	 */
    +-
     +	struct packfile_store *packfiles;
    - 
      	struct packed_git *packed_git;
      	/* A most-recently-used ordered version of the packed_git list. */
    + 	struct list_head packed_git_mru;
     
      ## packfile.c ##
     @@ packfile.c: int parse_pack_header_option(const char *in, unsigned char *out, unsigned int *l
 2:  40e8926e48 !  2:  bf3e61a3ac odb: move list of packfiles into `struct packfile_store`
    @@ odb.c: void odb_clear(struct object_database *o)
     
      ## odb.h ##
     @@ odb.h: struct object_database {
    + 	 * should only be accessed directly by packfile.c
      	 */
      	struct packfile_store *packfiles;
    - 
     -	struct packed_git *packed_git;
      	/* A most-recently-used ordered version of the packed_git list. */
      	struct list_head packed_git_mru;
    @@ packfile.h: struct packed_git {
     +
     +	/*
     +	 * The list of packfiles in the order in which they are being added to
    -+	 * the store. The local packfile typically sits at the head of this
    -+	 * list.
    ++	 * the store.
     +	 */
     +	struct packed_git *packs;
      };
 3:  7dacc2aeb3 !  3:  e0a167b952 odb: move initialization bit into `struct packfile_store`
    @@ Commit message
         database. With the introduction of the `struct packfile_store` we have a
         better place to host this bit though.
     
    -    Move it accordingly.
    +    Move it accordingly. While at it, convert the field into a boolean now
    +    that we're allowed to use them in our code base.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    @@ packfile.c: static void prepare_packed_git(struct repository *r)
      
      	prepare_packed_git_mru(r);
     -	r->objects->packed_git_initialized = 1;
    -+	r->objects->packfiles->initialized = 1;
    ++	r->objects->packfiles->initialized = true;
      }
      
      void reprepare_packed_git(struct repository *r)
    @@ packfile.c: void reprepare_packed_git(struct repository *r)
      
      	r->objects->approximate_object_count_valid = 0;
     -	r->objects->packed_git_initialized = 0;
    -+	r->objects->packfiles->initialized = 0;
    ++	r->objects->packfiles->initialized = false;
      	prepare_packed_git(r);
      	obj_read_unlock();
      }
     
      ## packfile.h ##
     @@ packfile.h: struct packfile_store {
    - 	 * list.
    + 	 * the store.
      	 */
      	struct packed_git *packs;
     +
    @@ packfile.h: struct packfile_store {
     +	 * Whether packfiles have already been populated with this store's
     +	 * packs.
     +	 */
    -+	unsigned initialized : 1;
    ++	bool initialized;
      };
      
      /*
 4:  970ddf62ba =  4:  5940ac0cc3 odb: move packfile map into `struct packfile_store`
 5:  300f68f5f3 !  5:  e1c81f4258 odb: move MRU list of packfiles into `struct packfile_store`
    @@ odb.h
      #include "oidmap.h"
      #include "string-list.h"
     @@ odb.h: struct object_database {
    + 	 * should only be accessed directly by packfile.c
      	 */
      	struct packfile_store *packfiles;
    - 
     -	/* A most-recently-used ordered version of the packed_git list. */
     -	struct list_head packed_git_mru;
     -
 6:  97d9a8322e !  6:  96eb610300 odb: move kept cache into `struct packfile_store`
    @@ Commit message
     
         Move the cache accordingly.
     
    +    This moves the last bit of packfile-related state from the object
    +    database into the packfile store. Adapt the comment for the `packfiles`
    +    pointer in `struct object_database` to reflect this.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## odb.h ##
    @@ odb.h: struct object_database {
     +	 * Should only be accessed directly by packfile.c
      	 */
      	struct packfile_store *packfiles;
    - 
     -	struct {
     -		struct packed_git **packs;
     -		unsigned flags;
     -	} kept_pack_cache;
    --
    + 
      	/*
      	 * This is meant to hold a *small* number of objects that you would
    - 	 * want odb_read_object() to be able to return, but yet you do not want
     
      ## packfile.c ##
     @@ packfile.c: int find_pack_entry(struct repository *r, const struct object_id *oid, struct pa
 7:  7e5c801326 !  7:  2a4392afeb packfile: reorder functions to avoid function declaration
    @@ Metadata
      ## Commit message ##
         packfile: reorder functions to avoid function declaration
     
    -    Reorder functions so that we can avoid an extra declaration of
    +    Reorder functions so that we can avoid a forward declaration of
         `prepare_packed_git()`.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
 8:  967232564f !  8:  e92deae728 packfile: refactor `prepare_packed_git()` to work on packfile store
    @@ packfile.c: static int sort_pack(const struct packed_git *a, const struct packed
     +	sort_packs(&store->packs, sort_pack);
      
     -	prepare_packed_git_mru(r);
    --	r->objects->packfiles->initialized = 1;
    +-	r->objects->packfiles->initialized = true;
     +	packfile_store_prepare_mru(store);
    -+	store->initialized = 1;
    ++	store->initialized = true;
      }
      
      void reprepare_packed_git(struct repository *r)
     @@ packfile.c: void reprepare_packed_git(struct repository *r)
      
      	r->objects->approximate_object_count_valid = 0;
    - 	r->objects->packfiles->initialized = 0;
    + 	r->objects->packfiles->initialized = false;
     -	prepare_packed_git(r);
     +	packfile_store_prepare(r->objects->packfiles);
      	obj_read_unlock();
 9:  11860d282d !  9:  2fcc09332f packfile: split up responsibilities of `reprepare_packed_git()`
    @@ odb.h: struct object_database {
     
      ## packfile.c ##
     @@ packfile.c: static void packfile_store_prepare(struct packfile_store *store)
    - 	store->initialized = 1;
    + 	store->initialized = true;
      }
      
     -void reprepare_packed_git(struct repository *r)
    @@ packfile.c: static void packfile_store_prepare(struct packfile_store *store)
     -		odb_clear_loose_cache(source);
     -
     -	r->objects->approximate_object_count_valid = 0;
    --	r->objects->packfiles->initialized = 0;
    +-	r->objects->packfiles->initialized = false;
     -	packfile_store_prepare(r->objects->packfiles);
     -	obj_read_unlock();
    -+	store->initialized = 0;
    ++	store->initialized = false;
     +	packfile_store_prepare(store);
      }
      
10:  7472988a1f = 10:  3097fd3d85 packfile: refactor `install_packed_git()` to work on packfile store
11:  e705f1fbf4 = 11:  aff98b7a67 packfile: always add packfiles to MRU when adding a pack
12:  70b4d4921e = 12:  ab55a14dbc packfile: introduce function to load and add packfiles
13:  80326900fa = 13:  abb34ffc8a packfile: move `get_multi_pack_index()` into "midx.c"
14:  98219d6ed4 ! 14:  273f2d698e packfile: remove `get_packed_git()`
    @@ Commit message
         We have two different functions to retrieve packfiles for a packfile
         store:
     
    -      - `get_packed_git()` returns the list of packfiles directly.
    +      - `get_packed_git()` returns the list of packfiles after having called
    +        `prepare_packed_git()`.
     
    -      - `get_all_packs()` does more work and also prepares packfiles that
    -        are being indexed by a multi-pack-index.
    +      - `get_all_packs()` calls `prepare_packed_git()`, as well, but also
    +        calls `prepare_midx_pack()` for each pack.
     
    -    The distinction is not immediately obvious. Furthermore, to make the
    -    situation even worse, `get_packed_git()` would return the same result as
    -    `get_all_packs()` once the latter has been called once as they both
    -    refer to the same list.
    +    This means that the latter function also properly loads the info of
    +    whether or not a packfile is part of a multi-pack index. Preparing this
    +    extra information also shouldn't be significantly more expensive:
     
    -    As it turns out, the distinction isn't necessary. We only have a couple
    -    of callers of `get_packed_git()`, and all of those callers are prepared
    -    to call `get_all_packs()` instead:
    +      - We have already loaded all packfiles via `prepare_packed_git_one()`.
    +        So given that multi-pack indices may only refer to packfiles in the
    +        same object directory we know that we already loaded each packfile.
     
    -      - "builtin/gc.c": We explicitly check how many packfiles aren't
    -        contained in the multi-pack-index, so loading extra packfiles that
    -        are indexed by it won't change the result.
    +      - The multi-pack index was prepared via `packfile_store_prepare()`
    +        already, which calls `prepare_multi_pack_index_one()`.
     
    -      - "builtin/grep.c": We only care `get_packed_git()` to prepare eagerly
    -        load packfiles. In the preceding commit we have started to expose
    -        `packfile_store_prepare()`, which is a more direct way of achieving
    -        the same result.
    +      - So all that remains to be done is to look up the index of the pack
    +        in its multi-pack index so that we can store that info in both the
    +        pack itself and the MIDX.
     
    -      - "object-name.c": `find_abbrev_len_for_pack()` and `unique_in_pack()`
    -        exit early in case the multi-pack index is set, so both callsites of
    -        `get_packed_git()` know to handle packs loaded via the MIDX already.
    +    So it is somewhat confusing to readers that one of these two functions
    +    claims to load "all" packfiles while the other one doesn't, even though
    +    the ultimate difference is way more nuanced.
     
         Convert all of these sites to use `get_all_packs()` instead and remove
    -    `get_packed_git()`.
    +    `get_packed_git()`. There doesn't seem to be a good reason to discern
    +    these two functions.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
15:  3b39e6c4c4 = 15:  15bc2b858c packfile: refactor `get_all_packs()` to work on packfile store
16:  4b2a3429d6 = 16:  0bfb6cf52a packfile: refactor `get_packed_git_mru()` to work on packfile store

---
base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
change-id: 20250806-b4-pks-packfiles-store-a44a608ca396

