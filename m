Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374241F4604
	for <git@vger.kernel.org>; Wed, 14 May 2025 05:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747199554; cv=none; b=bG9hC8EA60PrYB5hT5ruXxUic4uubkK96kylIOY99+CvurjWDbvytNW6d48o50qyHZ9NjDwzdMRrrxoa56QEav5BLbMQ8AgukCURhnNa8Q1F1wcYVymYv0M1ZYl7TYpCadbM2vp6ifvmKC6KgIe/68sIvchkcB6xwF5MiChHDxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747199554; c=relaxed/simple;
	bh=lw0vpNF4HIXCxdiEE/tM/AChhS2PActjVp2fXRFn+as=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=eI8JgjPPdYYwYgONXQQWFlLf910DviDWlLVlw7sByITu0Du+suvI0m63mf1nFE2Xo+kQj9FHz1i2zXZ3EG8FJwhp9iCaGPijBNhDT2nTxpD/w+peRJ/ealJN3sQ+k5vV7fb5uNrSWLVDOZlG3vpGdjaGpXQ6gk2ULhMdZFIQGfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YZlpZi+V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d96loywc; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YZlpZi+V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d96loywc"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 504F01380120;
	Wed, 14 May 2025 01:12:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 14 May 2025 01:12:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747199550;
	 x=1747285950; bh=SaIW20CUuYuz2SVtKFp9Z1RU/Wqedq07pkKUlvjtp7Y=; b=
	YZlpZi+Vj/Ad/TORUjMXTHm/jQAHsL+6jC6KagKDzNcL5DFsvdPipKeOv7uVwL02
	zMhAq53CZh6vy6qd5wxjyci5ZbGs0APxX0ontp9TRpGqnZbJNVVQ9INlApXqt7tn
	+5qXHOalkbaGLNHmgeTL4r3jdrSH07NClzQ2ccQxNED7z/pgKWW+BDDyO36j2zjN
	KYAOY+8MBak16R3OvKyYEobNmE0Ib2Lq93MkAnx5165mh10kcEnwy0Fn83mgiumg
	FBvNzd8KkC1fygXh5a0rC5D01qJx25yHe4XHgqNhatD0/Dfehd3h4dAxU1igAV/W
	zbAig44EkC6EcNeSdbmWgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747199550; x=
	1747285950; bh=SaIW20CUuYuz2SVtKFp9Z1RU/Wqedq07pkKUlvjtp7Y=; b=d
	96loywcTfFApylEcej6ZpBMx10bwnCmscJZWEthnZk3uaxjcjmUAJJszNaLTuAEb
	DxnApONHqqh/+JmfLFiLLHjZZuAz6VLVijzMM6qZUAsAd1eVirBLJuLutuR4Yu8I
	58ayguBIRtXD5Nskq48sBNYNaJR+2S++Tc6lMxdEafbXX9OLeBf8ZJ3q5LsPdv2Y
	+AcX4Y3/XikklZvwaQAH4IxMUMAvDG5aw1f9TW+3k3jepLodG020oNtk1rr93kme
	UYOwJrDMzDiqIYfgppO/GaaAHh98Gz9MiFfLjoEmPwy3Gzu/DZn0w9UHWWU8rBa8
	K38DUjBZGy7fS66HwN63g==
X-ME-Sender: <xms:PiYkaOjnMxSO7HHzEF0AQm9V31Ih3BQ1TWaSpOZ80m9ozfGQyc3d1A>
    <xme:PiYkaPBJSn5Rtbtjh70jy5ywesd0NexewAVgNuPlWhpdTar6EmWu4OSvrgiSaSiGW
    6kbDUVcagjKtnCQ9Q>
X-ME-Received: <xmr:PiYkaGFzr8RrIymUeeaV-HAcGoVh3sEUvSS2x_iYCeCFtXIJ6J5RpsOY9OrB6ehzCdZ9pRESV0J1iYqW78cz2y6Feq-kCfDHPe7oVtgqoCI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdeiudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffufffkgggtgfgjfhfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedt
    heefhfegffevgeegtdfhheeuvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepthhoohhnsehiohhttghlrdgtohhm
X-ME-Proxy: <xmx:PiYkaHSyrCCgRAdv_3wq7P1lFZlBl-VUwzfTxNaC4azCXftys2hL4Q>
    <xmx:PiYkaLz3D2kgpOTlF4epBHJeoY3AzewfTF1TZeFeW06lUUxjmayIUw>
    <xmx:PiYkaF7_lf4DWr9zaDjTonbte9nMLRtILI1M2n3l-KGXn0gysrdH0Q>
    <xmx:PiYkaIzAkYoIdHjJtLfAGExsW6oeGqD9HYrX1Dw1Wm18qCa1O62hcA>
    <xmx:PiYkaJ0lKhTUWdP-2Cbl9At4TUiqxW50sXktoRUn01_lvo84n_UEk9yl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 May 2025 01:12:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 35bd28e5 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 14 May 2025 05:12:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 00/17] object-store: carve out the object database
 subsystem
Date: Wed, 14 May 2025 07:12:23 +0200
Message-Id: <20250514-pks-object-store-wo-the-repository-v3-0-47df1d4ead22@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADgmJGgC/43NQQ6CMBAF0KuYrh3TFkFw5T2MC1umMhopaUmVE
 O7uQKJxSWb1f/LfjCJiIIziuBlFwESRfMsh226Eba7tDYFqzkJLnUs+6B4RvLmj7SH2PiC8PPQ
 NQsDOR+JmgMoW1tSurPdGCYa6gI7ey5PzhXND83JYfiY1t1++WMMnBRKszE2p8WCULk482tFTz
 HbS/161ytPsKZm5vDKuRF3+vGmaPt2Hh/whAQAA
X-Change-ID: 20250505-pks-object-store-wo-the-repository-9c6cbdf8d4b1
In-Reply-To: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
References: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

Hi,

this patch series refactors the object store subsystem to become more
self-contained by getting rid of `the_repository`. Instead of passing in
the repository explicitly, we start to pass in the object store itself,
which is in contrast to many other refactorings we did, but in line with
what we did for the ref store, as well.

This series also starts to properly scope functions to the carved out
object database subsystem, which requires a bit of shuffling. This
allows us to have a short-and-sweet `odb_` prefix for functions and
prepares us for a future with pluggable object backends.

The series is structured as follows:

  - Patches 1 to 3 rename `struct object_store` and `struct
    object_directory` as well as the code files.

  - Patches 4 to 12 refactor "odb.c" to get rid of `the_repository`.

  - Patches 13 to 17 adjust the name of remaining functions so that they
    can be clearly attributed to the ODB. I'm happy to kick these
    patches out of this series and resend them at a later point in case
    they create too much turmoil.

This series is built on top of 6f84262c44a (The eleventh batch,
2025-05-05) with ps/object-store-cleanup at 8a9e27be821 (object-store:
drop `repo_has_object_file()`, 2025-04-29) merged into it. There are a
couple of trivial conflicts when merged with "seen", I have appended the
merge conflict resolution as a patch at the end of this mail.

Changes in v2:
  - Fix for a copy-and-pasted commit message.
  - Rename `struct odb_backend` to `struct odb_alternate`. I'm happy to
    revert to the previous name if we ultimately think it's the better
    suited one.
  - A couple of fixes to move changes into the correct commit. `git
    rebase -x 'meson compile -C build'` is now clean.
  - I _didn't_ back out the rename to "odb.{c,h}". Junio has already
    fixed the fallout, so it's probably more work for him to kick it out
    again than to just leave it in.
  - Link to v1: https://lore.kernel.org/r/20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im

Changes in v3:
  - Polishing for some comments and commit messages.
  - Link to v2: https://lore.kernel.org/r/20250509-pks-object-store-wo-the-repository-v2-0-103f59bf8e28@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (17):
      object-store: rename `raw_object_store` to `object_database`
      object-store: rename `object_directory` to `odb_alternate`
      object-store: rename files to "odb.{c,h}"
      odb: introduce parent pointers
      odb: get rid of `the_repository` in `find_odb()`
      odb: get rid of `the_repository` in `assert_oid_type()`
      odb: get rid of `the_repository` in `odb_mkstemp()`
      odb: get rid of `the_repository` when handling alternates
      odb: get rid of `the_repository`  in `for_each()` functions
      odb: get rid of `the_repository` when handling the primary alternate
      odb: get rid of `the_repository` when handling submodule alternates
      odb: trivial refactorings to get rid of `the_repository`
      odb: rename `oid_object_info()`
      odb: rename `repo_read_object_file()`
      odb: rename `has_object()`
      odb: rename `pretend_object_file()`
      odb: rename `read_object_with_reference()`

 Documentation/user-manual.adoc          |   4 +-
 Makefile                                |   2 +-
 apply.c                                 |  14 +-
 archive-tar.c                           |   2 +-
 archive-zip.c                           |   2 +-
 archive.c                               |   6 +-
 attr.c                                  |   4 +-
 bisect.c                                |   8 +-
 blame.c                                 |  22 +-
 builtin/backfill.c                      |   6 +-
 builtin/blame.c                         |   6 +-
 builtin/cat-file.c                      |  62 +++--
 builtin/checkout.c                      |   2 +-
 builtin/clone.c                         |  14 +-
 builtin/commit-graph.c                  |  20 +-
 builtin/commit-tree.c                   |   4 +-
 builtin/count-objects.c                 |   6 +-
 builtin/describe.c                      |   5 +-
 builtin/difftool.c                      |   4 +-
 builtin/fast-export.c                   |  10 +-
 builtin/fast-import.c                   |  49 ++--
 builtin/fetch.c                         |  21 +-
 builtin/fsck.c                          |  31 +--
 builtin/gc.c                            |  16 +-
 builtin/grep.c                          |  26 +-
 builtin/hash-object.c                   |   2 +-
 builtin/index-pack.c                    |  29 +--
 builtin/log.c                           |   4 +-
 builtin/ls-files.c                      |   4 +-
 builtin/ls-tree.c                       |   6 +-
 builtin/merge-file.c                    |   2 +-
 builtin/merge-tree.c                    |  14 +-
 builtin/mktag.c                         |   6 +-
 builtin/mktree.c                        |  10 +-
 builtin/multi-pack-index.c              |   6 +-
 builtin/notes.c                         |   8 +-
 builtin/pack-objects.c                  |  70 +++---
 builtin/pack-redundant.c                |   2 +-
 builtin/prune.c                         |   6 +-
 builtin/receive-pack.c                  |   9 +-
 builtin/remote.c                        |   6 +-
 builtin/repack.c                        |   7 +-
 builtin/replace.c                       |  12 +-
 builtin/rev-list.c                      |   8 +-
 builtin/show-ref.c                      |   6 +-
 builtin/submodule--helper.c             |  11 +-
 builtin/tag.c                           |  10 +-
 builtin/unpack-file.c                   |   4 +-
 builtin/unpack-objects.c                |  12 +-
 bulk-checkin.c                          |   6 +-
 bundle-uri.c                            |   5 +-
 bundle.c                                |   6 +-
 cache-tree.c                            |  17 +-
 combine-diff.c                          |   4 +-
 commit-graph.c                          | 106 ++++----
 commit-graph.h                          |  20 +-
 commit.c                                |  15 +-
 config.c                                |   4 +-
 connected.c                             |   2 +-
 contrib/coccinelle/the_repository.cocci |   2 +-
 diagnose.c                              |  12 +-
 diff.c                                  |  20 +-
 dir.c                                   |   2 +-
 entry.c                                 |   6 +-
 fetch-pack.c                            |  17 +-
 fmt-merge-msg.c                         |   6 +-
 fsck.c                                  |   4 +-
 grep.c                                  |   6 +-
 http-backend.c                          |   2 +-
 http-push.c                             |  20 +-
 http-walker.c                           |  12 +-
 http.c                                  |   6 +-
 list-objects-filter.c                   |   4 +-
 list-objects.c                          |   6 +-
 log-tree.c                              |   2 +-
 loose.c                                 |  46 ++--
 mailmap.c                               |   4 +-
 match-trees.c                           |   6 +-
 merge-blobs.c                           |  10 +-
 merge-ort.c                             |   8 +-
 meson.build                             |   2 +-
 midx-write.c                            |   2 +-
 midx.c                                  |   6 +-
 notes-cache.c                           |   4 +-
 notes-merge.c                           |   4 +-
 notes.c                                 |  19 +-
 object-file.c                           |  94 ++++----
 object-file.h                           |  12 +-
 object-name.c                           |  24 +-
 object.c                                |   8 +-
 object-store.c => odb.c                 | 413 +++++++++++++++++---------------
 object-store.h => odb.h                 | 272 +++++++++++++++------
 oss-fuzz/fuzz-pack-idx.c                |   2 +-
 pack-bitmap-write.c                     |   9 +-
 pack-bitmap.c                           |  10 +-
 pack-check.c                            |   2 +-
 pack-mtimes.c                           |   2 +-
 pack-objects.h                          |   2 +-
 pack-revindex.c                         |   2 +-
 pack-write.c                            |  10 +-
 packfile.c                              |  29 +--
 packfile.h                              |   8 +-
 path.c                                  |   4 +-
 promisor-remote.c                       |   6 +-
 protocol-caps.c                         |   4 +-
 reachable.c                             |   2 +-
 read-cache.c                            |  14 +-
 ref-filter.c                            |   6 +-
 reflog.c                                |   8 +-
 refs.c                                  |   7 +-
 remote.c                                |   9 +-
 replace-object.c                        |   2 +-
 replace-object.h                        |   2 +-
 repository.c                            |  21 +-
 repository.h                            |   4 +-
 rerere.c                                |   7 +-
 revision.c                              |   5 +-
 send-pack.c                             |   4 +-
 sequencer.c                             |   7 +-
 server-info.c                           |   2 +-
 shallow.c                               |  14 +-
 streaming.c                             |  10 +-
 submodule-config.c                      |   9 +-
 submodule.c                             |  32 +--
 submodule.h                             |   9 -
 t/helper/test-find-pack.c               |   2 +-
 t/helper/test-pack-mtimes.c             |   2 +-
 t/helper/test-partial-clone.c           |   4 +-
 t/helper/test-read-graph.c              |   8 +-
 t/helper/test-read-midx.c               |   2 +-
 t/helper/test-ref-store.c               |   4 +-
 tag.c                                   |  10 +-
 tmp-objdir.c                            |  30 +--
 tree-walk.c                             |  18 +-
 tree.c                                  |   6 +-
 unpack-trees.c                          |   2 +-
 upload-pack.c                           |   4 +-
 walker.c                                |   6 +-
 xdiff-interface.c                       |   4 +-
 139 files changed, 1180 insertions(+), 1032 deletions(-)

Range-diff versus v2:

 1:  c113f51cc1a !  1:  40051831e0e object-store: rename `raw_object_store` to `object_database`
    @@ Commit message
         This conversion can be done by simply passing in an explicit pointer to
         a repository and then using its `->objects` pointer. But there is a
         second effort underway, which is to make the object subsystem more
    -    selfcontained so that we can eventually have pluggale object backends.
    +    selfcontained so that we can eventually have pluggable object backends.
         As such, passing in a repository wouldn't make a ton of sense, and the
         goal is to convert the object store interfaces such that we always pass
         in a reference to the `raw_object_store` instead.
 2:  05a6fb88bf3 !  2:  39f178ace57 object-store: rename `object_directory` to `odb_alternate`
    @@ Commit message
         Let's preempt this by renaming the structure to `odb_alternate` now
         already. This name is agnostic of how exactly objects are stored while
         still specifically pinpointing that this is about an alternate object
    -    database. In the future, it allows us to easily introduce e.g. a
    -    `odb_files_alternate` and other specific implementations over time.
    +    database. Furthermore, it is already used in Git to represent this
    +    context -- the only stretch is that the primary object directory is now
    +    the primary alternate.
    +
    +    In the future, this change allows us to easily introduce for example a
    +    `odb_files_alternate` and other format-specific implementations.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    @@ object-store.h: struct oidtree;
     -struct object_directory {
     -	struct object_directory *next;
     +/*
    -+ * An alternate part of an object database that stores the actual objects.
    ++ * The alternate is the part of the object database that stores the actual
    ++ * objects. It thus encapsulates the logic to read and write the specific
    ++ * on-disk format. An object database can have multiple alternates, and
    ++ * exactly one primary alternate that is used when writing new objects.
     + */
     +struct odb_alternate {
     +	struct odb_alternate *next;
 3:  bcc552e554c =  3:  7d79268aa73 object-store: rename files to "odb.{c,h}"
 4:  908e399cde6 =  4:  25777175ade odb: introduce parent pointers
 5:  939961a4eb3 =  5:  c8daaa9bd03 odb: get rid of `the_repository` in `find_odb()`
 6:  74dc4d61e37 =  6:  23cf77f4e83 odb: get rid of `the_repository` in `assert_oid_type()`
 7:  61f1302201f =  7:  58975fe2c7f odb: get rid of `the_repository` in `odb_mkstemp()`
 8:  81926adbd98 !  8:  27959349ffe odb: get rid of `the_repository` when handling alternates
    @@ odb.h: struct oidtree;
     +char *compute_alternate_path(const char *path, struct strbuf *err);
     +
      /*
    -  * An alternate part of an object database that stores the actual objects.
    -  */
    +  * The alternate is the part of the object database that stores the actual
    +  * objects. It thus encapsulates the logic to read and write the specific
     @@ odb.h: struct odb_alternate {
      	char *path;
      };
 9:  60693ef4805 =  9:  3bb54296615 odb: get rid of `the_repository`  in `for_each()` functions
10:  387e0311264 = 10:  b39a3d934a5 odb: get rid of `the_repository` when handling the primary alternate
11:  64503d9eeb8 = 11:  489c6b4c33f odb: get rid of `the_repository` when handling submodule alternates
12:  fd793aef552 = 12:  a3068a0ad76 odb: trivial refactorings to get rid of `the_repository`
13:  efcd16f5d14 = 13:  eb614efd08b odb: rename `oid_object_info()`
14:  1f020271cc5 = 14:  6c7c24739d1 odb: rename `repo_read_object_file()`
15:  8a51662e84d = 15:  07c2b387ace odb: rename `has_object()`
16:  3bd6d7e2ae4 = 16:  f1e8c7f10ab odb: rename `pretend_object_file()`
17:  7d63407a1b4 = 17:  d612f806675 odb: rename `read_object_with_reference()`

---
base-commit: 046efb6f2b050efd580e1c1750b77328a1790c0e
change-id: 20250505-pks-object-store-wo-the-repository-9c6cbdf8d4b1

