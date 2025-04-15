Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1B82DFA25
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 09:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744709903; cv=none; b=BCLA5Bo71FYKq4WoVb6F7bqAYSF8ngUacmNogw0hqSybuEshSRtDiw550DPLqoSiTtgatKI4U8cDEPBVl+Tx6qrDJ+1RLmRzRO9Xxe+R/pro2GjXhcGfcKIwRZjypx90BWEIacfgrmbdgRM8aqTsEgYDowB4HaM7kaWXpsBKFfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744709903; c=relaxed/simple;
	bh=z3chUBcHrisHG9V9oB8zn6bCjKMO6ERFATIBzyuJXDw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=EC1daEgq4ubwx6b32B7kRYYTgb3VqOb1l6D6gsVayqK1c+fK29UMd5R7bLUFD4mMfEr2HF7TlPAvhZvZqKqtIvOo/QSYpGNHitEW9VJW21zo+DAH1SRgLmyrPmrWrEBrTm/dvlRauMlZ8N+HvmFQJ97ff9At/+w/bSBrWe4lhjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lIQ64CJ5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H8NKMdrC; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lIQ64CJ5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H8NKMdrC"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 78567254031C;
	Tue, 15 Apr 2025 05:38:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 15 Apr 2025 05:38:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744709900;
	 x=1744796300; bh=/hfeyDYwbVAJuE0OCUjRD7l8CpC4vgf0UdRFn1cJMKk=; b=
	lIQ64CJ51aoWtl2EscYUsV3pdMBiyfz7BhhKylMfzdByr4lDBnVXBA5lVvB3q1pG
	Vqp9TTlVRD/lB64Kqvme/wVQ9ipDAOg2Dpwg85Z2jzT1KOYXWnCC2Gpg0c48XQ0x
	8sYZaC+VHF+ZQgwD6ytonmKBny4RzNivd65o+iwqs7yYiDz0zldE6G89wmRWnVaK
	WWHxCSjU+1KcGMjIBJ4B08Lf9oDh1eDXjZws+39T4h/54hUimM8GphDdgHOGh0Qs
	SydWhZBkzPGAI3Z2rd4AE8d9IKQWFx21OeXeazLpcrhtWw/84Jly9WlXSxIbzAKk
	wD0LD4DlgecTY76qDBdXKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744709900; x=
	1744796300; bh=/hfeyDYwbVAJuE0OCUjRD7l8CpC4vgf0UdRFn1cJMKk=; b=H
	8NKMdrCuaDa6FDltDl6+scPl7buI/LgZ0A6YN66ENPJhFH80WLJ2f6hwclWJEio3
	d0ZzpKuz6yk56x3zhOiTQG3FVYGHC/zSw+bpTuHWMDHvgm8yRgZEufO+76jYH4L8
	JCaYdPRC0qo8HRQFU1LTspa+ysjK8IeA8GFYjgDL8yLw9AIoR2DGk6rOO5fP1NWp
	ix+bBnSnP/NiRtL96PPzhXV1E+Cmv2P7uXnCqs/D320Bbk0CdodadNr+75E8Mqxo
	HQFr0vK1pv5qEYrmfPXdx+IB9JJzOztjPW4D2XgIiD3L2tTAu2Yfw/d/6G8yuZMW
	/nVoVK6TZQBtSjVJPu5Xw==
X-ME-Sender: <xms:DCn-Z7wH2GKFYMqWEmL8YqG_YuEMqAq3DErNdgEFJVKH0pykdmdCpg>
    <xme:DCn-ZzRPNJ6km1wRO0vOs_jR3z_nHIXIaqJrha0SQMHqjVIOKPHQudzcPt28Ay1Hg
    eZae3obVGHcNJwu-Q>
X-ME-Received: <xmr:DCn-Z1XJvm67nf0GpuNTPV_GcDPzW2l7oM88MejFib4WxkRnJBRlx8hpbMKHaeIDaFghiWn54ynCMOCA6nc5mrdqXBG1plL0vKNDWR_XXygFaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdefudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffufffkgggtgfgjfhfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedt
    heefhfegffevgeegtdfhheeuvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtph
    htthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehsuhhnshhhihhn
    vgesshhunhhshhhinhgvtghordgtohhm
X-ME-Proxy: <xmx:DCn-Z1iDXSVTLsLYzfL_5Grcj-ozW2-UETxXJbh4Z-3E-ObmjZgdPA>
    <xmx:DCn-Z9DANY7ZrGsVZnqnYSHLR1N1D06QTrtJhN7onMah_jBQsOZtGw>
    <xmx:DCn-Z-KUxHhiDGPn-OqHNckhYRGfu1imV7KflGctO1W5mEBiBGlIWA>
    <xmx:DCn-Z8ABbLi6hEaaDxetSXR6DdNooT0pd1q4u79lhUB1xZiAN9uV3w>
    <xmx:DCn-Z94QQLdmJyNt5AdsWoV2iryj2ROmGn80XyLzHwalM4TEs6TVQa8z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 05:38:18 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e71e296a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 15 Apr 2025 09:38:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 00/10] Split up "object-file.c"
Date: Tue, 15 Apr 2025 11:38:13 +0200
Message-Id: <20250415-pks-split-object-file-v3-0-6aa7db7ad7b0@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAYp/mcC/4XNwQ6CMAyA4VchO1uzbqDiyfcwHmDrpIpANrJoC
 O/u4GC8GI9/036dRCDPFMQxm4SnyIH7LoXeZMI0VXclYJtaKKkKmcsDDPcAYWh5hL6+kRnBcUt
 gdmj3xqpKoRPpdvDk+Lm650vqhsPY+9f6JuIy/SdGBAkOnS0kloi5PqW9LT/EwkX1RSD+IlQiV
 E2VNKXUuqIPMc/zGwnB/pH6AAAA
X-Change-ID: 20250408-pks-split-object-file-c61d7cd2a21f
In-Reply-To: <20250408-pks-split-object-file-v1-0-f1fd50191143@pks.im>
References: <20250408-pks-split-object-file-v1-0-f1fd50191143@pks.im>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, 
 Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Hi,

"object-file.c" is quite a grab-bag of all kinds of different functions.
Many of these functions aren't really a good fit though and should be
owned by a different subsystem. This patch series tries to split up
concerns a bit better by splitting out this functionality into other
files:

  - `safe_create_leading_directories()` is moved into "dir.c".
  - `xmmap()` is moved into "wrapper.c".
  - `git_open_cloexec()` is moved into "compat/open.c".
  - Several functions attached to `struct index_state` are moved into
    "read-cache.c".
  - Several functions related to `struct object_store` are moved into a
    new file "object-store.c".

"object-file.c" now mostly contains logic to read and write loose object
files, whereas "object-store.c" contains the higher-level logic to
manage different object directories for a repository. Eventually, these
will become the loose object backend as well as the `struct ref_store`
equivalent for objects, respectively.

The series is built on top of 9d22ac51228 (The third batch, 2025-04-07)
with ps/object-wo-the-repository at 9442b1c919a (Merge remote-tracking
branch 'junio/ps/object-wo-the-repository' into HEAD, 2025-04-08) merged
into it.

Changes in v2:
  - Fix a grammar issue in one of the commit messages.
  - Link to v1: https://lore.kernel.org/r/20250408-pks-split-object-file-v1-0-f1fd50191143@pks.im

Changes in v3:
  - Rename `mkdir_in_gitdir()` to `safe_create_dir_in_gitdir()` to match
    naming of similar functions.
  - Move `safe_create_leading_directories()` et al into "path.c" instead
    of into "dir.c". This also requires us to start injecting a repo via
    parameters as "path.c" doesn't have `the_repository` available
    anymore.
  - Drop the commit that moves `index_blob_stream()` and related
    functions.
  - Expand the reasoning why we want to have cached objects per object
    store instead of globally.
  - Drop `index_blob_stream()`, which is a trivial wrapper around
    `index_blob_bulk_checkin()`.
  - Link to v2: https://lore.kernel.org/r/20250411-pks-split-object-file-v2-0-2bea0c9033ae@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (10):
      object-file: move `mkdir_in_gitdir()` into "path.c"
      object-file: move `safe_create_leading_directories()` into "path.c"
      object-file: move `git_open_cloexec()` to "compat/open.c"
      object-file: move `xmmap()` into "wrapper.c"
      object-file: split out functions relating to object store subsystem
      object-file: split up concerns of `HASH_*` flags
      object-file: drop `index_blob_stream()`
      object: split out functions relating to object store subsystem
      object-store: remove global array of cached objects
      object-store: merge "object-store-ll.h" and "object-store.h"

 Makefile                           |    3 +-
 apply.c                            |    2 +-
 archive-tar.c                      |    2 +-
 archive-zip.c                      |    2 +-
 archive.c                          |    2 +-
 attr.c                             |    2 +-
 bisect.c                           |    2 +-
 blame.c                            |    4 +-
 builtin/backfill.c                 |    2 +-
 builtin/blame.c                    |    2 +-
 builtin/bugreport.c                |    4 +-
 builtin/cat-file.c                 |    2 +-
 builtin/checkout.c                 |    3 +-
 builtin/clone.c                    |    6 +-
 builtin/commit-graph.c             |    2 +-
 builtin/commit-tree.c              |    2 +-
 builtin/count-objects.c            |    2 +-
 builtin/credential-cache--daemon.c |    4 +-
 builtin/describe.c                 |    2 +-
 builtin/diagnose.c                 |    4 +-
 builtin/difftool.c                 |   31 +-
 builtin/fast-export.c              |    2 +-
 builtin/fast-import.c              |    4 +-
 builtin/fetch.c                    |    2 +-
 builtin/fsck.c                     |    4 +-
 builtin/gc.c                       |    9 +-
 builtin/grep.c                     |    2 +-
 builtin/hash-object.c              |   25 +-
 builtin/index-pack.c               |    2 +-
 builtin/init-db.c                  |    3 +-
 builtin/log.c                      |    6 +-
 builtin/ls-tree.c                  |    2 +-
 builtin/merge-file.c               |    1 +
 builtin/merge-tree.c               |    2 +-
 builtin/mktag.c                    |    2 +-
 builtin/mktree.c                   |    3 +-
 builtin/multi-pack-index.c         |    2 +-
 builtin/mv.c                       |    3 +-
 builtin/notes.c                    |    3 +-
 builtin/pack-objects.c             |    2 +-
 builtin/pack-redundant.c           |    2 +-
 builtin/prune.c                    |    2 +-
 builtin/rebase.c                   |    3 +-
 builtin/receive-pack.c             |    3 +-
 builtin/remote.c                   |    2 +-
 builtin/repack.c                   |    2 +-
 builtin/replace.c                  |    4 +-
 builtin/rev-list.c                 |    2 +-
 builtin/show-ref.c                 |    2 +-
 builtin/sparse-checkout.c          |    5 +-
 builtin/submodule--helper.c        |    6 +-
 builtin/tag.c                      |    3 +-
 builtin/unpack-file.c              |    3 +-
 builtin/unpack-objects.c           |    3 +-
 builtin/update-index.c             |    2 +-
 builtin/worktree.c                 |    8 +-
 bulk-checkin.c                     |    8 +-
 bulk-checkin.h                     |   15 +
 bundle-uri.c                       |    2 +-
 bundle.c                           |    2 +-
 cache-tree.c                       |    4 +-
 combine-diff.c                     |    2 +-
 commit-graph.c                     |    5 +-
 commit-graph.h                     |    2 +-
 commit.c                           |    3 +-
 compat/open.c                      |   29 +
 config.c                           |    2 +-
 connected.c                        |    2 +-
 convert.c                          |    2 +-
 diagnose.c                         |    2 +-
 diff.c                             |    2 +-
 diffcore-rename.c                  |    2 +-
 dir.c                              |    7 +-
 entry.c                            |    2 +-
 fetch-pack.c                       |    2 +-
 fmt-merge-msg.c                    |    2 +-
 fsck.c                             |    2 +-
 git-compat-util.h                  |    3 +
 grep.c                             |    2 +-
 http-backend.c                     |    2 +-
 http-push.c                        |    3 +-
 http-walker.c                      |    2 +-
 http.c                             |    2 +-
 list-objects-filter.c              |    2 +-
 list-objects.c                     |    2 +-
 log-tree.c                         |    2 +-
 mailmap.c                          |    2 +-
 match-trees.c                      |    3 +-
 merge-blobs.c                      |    2 +-
 merge-ort.c                        |    3 +-
 merge-recursive.c                  |    6 +-
 meson.build                        |    2 +
 midx-write.c                       |    2 +-
 midx.c                             |    1 -
 notes-cache.c                      |    3 +-
 notes-merge.c                      |    8 +-
 notes.c                            |    3 +-
 object-file.c                      | 1220 +-----------------------------------
 object-file.h                      |  121 ++--
 object-name.c                      |    2 +-
 object-store-ll.h                  |  556 ----------------
 object-store.c                     | 1050 +++++++++++++++++++++++++++++++
 object-store.h                     |  516 ++++++++++++++-
 object.c                           |   67 --
 oss-fuzz/fuzz-pack-idx.c           |    2 +-
 pack-bitmap-write.c                |    2 +-
 pack-bitmap.c                      |    3 +-
 pack-check.c                       |    2 +-
 pack-mtimes.c                      |    3 +-
 pack-objects.h                     |    2 +-
 pack-revindex.c                    |    3 +-
 packfile.c                         |    2 +-
 path.c                             |  111 +++-
 path.h                             |   45 ++
 promisor-remote.c                  |    2 +-
 protocol-caps.c                    |    2 +-
 prune-packed.c                     |    2 +-
 reachable.c                        |    2 +-
 read-cache.c                       |    6 +-
 ref-filter.c                       |    2 +-
 reflog.c                           |    2 +-
 refs.c                             |    2 +-
 refs/files-backend.c               |    4 +-
 remote.c                           |    2 +-
 replace-object.c                   |    2 +-
 replace-object.h                   |    2 +-
 repository.c                       |    2 +-
 rerere.c                           |    7 +-
 revision.c                         |    2 +-
 send-pack.c                        |    2 +-
 sequencer.c                        |    6 +-
 server-info.c                      |    4 +-
 shallow.c                          |    2 +-
 streaming.c                        |    2 +-
 submodule-config.c                 |    2 +-
 submodule.c                        |    4 +-
 t/helper/test-pack-mtimes.c        |    2 +-
 t/helper/test-partial-clone.c      |    2 +-
 t/helper/test-read-graph.c         |    2 +-
 t/helper/test-read-midx.c          |    2 +-
 t/helper/test-ref-store.c          |    2 +-
 tag.c                              |    2 +-
 tmp-objdir.c                       |    2 +-
 tree-walk.c                        |    2 +-
 tree.c                             |    2 +-
 unpack-trees.c                     |    2 +-
 upload-pack.c                      |    2 +-
 walker.c                           |    2 +-
 wrapper.c                          |   48 ++
 xdiff-interface.c                  |    2 +-
 150 files changed, 2147 insertions(+), 2067 deletions(-)

Range-diff versus v2:

 1:  ed337338970 <  -:  ----------- object-file: move `safe_create_leading_directories()` into "dir.c"
 -:  ----------- >  1:  8d838f92936 object-file: move `mkdir_in_gitdir()` into "path.c"
 -:  ----------- >  2:  c7c723db86c object-file: move `safe_create_leading_directories()` into "path.c"
 2:  48730ada01e =  3:  2b4db7b2090 object-file: move `git_open_cloexec()` to "compat/open.c"
 3:  a9436d9e4a6 =  4:  7e8b750d652 object-file: move `xmmap()` into "wrapper.c"
 4:  628d0bcce6c !  5:  3b90e8a5841 object-file: split out functions relating to object store subsystem
    @@ object-file.c: static int get_conv_flags(unsigned flags)
      		return 0;
      }
      
    --
     -int odb_mkstemp(struct strbuf *temp_filename, const char *pattern)
     -{
     -	int fd;
    @@ object-file.c: static int get_conv_flags(unsigned flags)
     -	/* slow path */
     -	/* some mkstemp implementations erase temp_filename on failure */
     -	repo_git_path_replace(the_repository, temp_filename, "objects/%s", pattern);
    --	safe_create_leading_directories(temp_filename->buf);
    +-	safe_create_leading_directories(the_repository, temp_filename->buf);
     -	return xmkstemp_mode(temp_filename->buf, mode);
     -}
     -
    @@ object-file.c: static int get_conv_flags(unsigned flags)
     -		return fd;
     -
     -	/* slow path */
    --	safe_create_leading_directories_const(name);
    +-	safe_create_leading_directories_const(the_repository, name);
     -	return open(name, O_RDWR|O_CREAT|O_EXCL, 0600);
     -}
     -
    @@ object-store.c (new)
     +	/* slow path */
     +	/* some mkstemp implementations erase temp_filename on failure */
     +	repo_git_path_replace(the_repository, temp_filename, "objects/%s", pattern);
    -+	safe_create_leading_directories(temp_filename->buf);
    ++	safe_create_leading_directories(the_repository, temp_filename->buf);
     +	return xmkstemp_mode(temp_filename->buf, mode);
     +}
     +
    @@ object-store.c (new)
     +		return fd;
     +
     +	/* slow path */
    -+	safe_create_leading_directories_const(name);
    ++	safe_create_leading_directories_const(the_repository, name);
     +	return open(name, O_RDWR|O_CREAT|O_EXCL, 0600);
     +}
     +
 5:  fd102d9e50a =  6:  6bc5d4811d3 object-file: split up concerns of `HASH_*` flags
 6:  298a867897d <  -:  ----------- object-file: split out functions relating to index subsystem
 -:  ----------- >  7:  c1e323f1673 object-file: drop `index_blob_stream()`
 7:  53e2bd9d117 =  8:  6b46541fe2a object: split out functions relating to object store subsystem
 8:  00b4a52b8ce !  9:  59df5f22b9d object-store: remove global array of cached objects
    @@ Commit message
         object-store: remove global array of cached objects
     
         Cached objects are virtual objects that can be set up without writing
    -    anything into the object store directly. This mechanism for example
    -    allows us to create fake commits in git-blame(1).
    +    anything into the object store directly, which is used by git-blame(1)
    +    to create fake commits for the working tree.
     
    -    The cached objects are stored in a global variable. Refactor the code so
    -    that we instead store the array as part of the raw object store. This is
    -    another step into the direction of libifying our object database.
    +    These cached objects are stored in a global variable, which is another
    +    roadblock for libification of the object subsystem. Refactor the code so
    +    that we instead store the array as part of the raw object store.
    +
    +    This refactoring raises the question whether virtual objects should
    +    really be specific to a single repository (or rather a single object
    +    store). Hypothetical usecases might for example span across submodules,
    +    and here it may or may not be the right thing to provide virtual objects
    +    across submodule boundaries.
    +
    +    The only existing usecase is git-blame(1) though, which does not know to
    +    blame across submodule boundaries in the first place. As such, storing
    +    these objects both globally and per-repository would achieve the same
    +    result right now. But arguably, if we learned to blame across submodule
    +    boundaries, we would likely want to create separate fare working tree
    +    commits for each of the submodules so that the user can learn which
    +    worktree a specific uncommitted change belongs to. And even if we would
    +    want to create the same fake commit for each of the submodules we could
    +    do that when storing separate virtual objects per object store.
    +
    +    While this is all rather hypothetical, the takeaway is that handling
    +    virtual objects per-object store gives us more flexibility compared to
    +    storing them globally. In a hypothetical future where we have achieved
    +    full libification one might be able to handle unrelated repositories in
    +    a single process, where the state of one repository should not have an
    +    impact on the state of another repository. As such, storing these cached
    +    objects per object store will enable more usecases and should lead to
    +    less surprising outcomes overall.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
 9:  6365dc7cd16 ! 10:  df6a749245f object-store: merge "object-store-ll.h" and "object-store.h"
    @@ builtin/replace.c
      #include "object-name.h"
     -#include "object-store-ll.h"
     +#include "object-store.h"
    - #include "read-cache.h"
      #include "replace-object.h"
      #include "tag.h"
    + #include "wildmatch.h"
     
      ## builtin/rev-list.c ##
     @@
    @@ notes-merge.c
     -#include "object-store-ll.h"
     +#include "object-store.h"
      #include "path.h"
    - #include "read-cache.h"
      #include "repository.h"
    + #include "diff.h"
     
      ## object-file.c ##
     @@
    - 
      #include "git-compat-util.h"
      #include "bulk-checkin.h"
    + #include "convert.h"
     +#include "dir.h"
      #include "environment.h"
    + #include "fsck.h"
      #include "gettext.h"
    - #include "hex.h"
     
      ## object-name.c ##
     @@

---
base-commit: 9442b1c919af9aed513eb0a484fe96358a500cf5
change-id: 20250408-pks-split-object-file-c61d7cd2a21f

