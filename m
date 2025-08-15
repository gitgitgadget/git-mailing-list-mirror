Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4551D7E0FF
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 01:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755220980; cv=none; b=gaOiIEEvFQ3x8sQF5tLZYx4gXMFBgIAPj3voq4RmneCsfAU+rt4aZ6lBv8yDiyIhFrPov5gAfS2MmyRVmMqJtzYRFsvOk4ii0O/tRCUA502p6B0NSlnH85BPgpQRzjWpb1hfcsS1ZUa0vdjbA/uCnVr3BgZw1kYJfXsbu3bDV4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755220980; c=relaxed/simple;
	bh=NpLACLyPqLUA1VA9v40QqrBOOJmR8N2x80mTCJN39O4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=VHbjvuhs6ogS84mRpmA2jPQKj9sGhEaC6faWuzbje6PfQWnSAU0GeYtyUyWeyFwBivFrspzXZwooFvVV0eQuIHzDREmv9D7uZqTVfSqnHYi+W+AGqc6SRk5SIdGDxLRGF10ctm4+lK7PdAr9Ew7z3vnMGCDcSMGTCSCr9SNwarY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hcZPGRiS; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcZPGRiS"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45a1b04f8b5so7746075e9.1
        for <git@vger.kernel.org>; Thu, 14 Aug 2025 18:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755220975; x=1755825775; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUNfPXvn23ec1XSQSwRYOwlDxEkUlSap0fKMXZF0CSI=;
        b=hcZPGRiSObmYGSsiWcVkznWwTu+9LjKr9JbcbL+Rr/4ij4gaoMcXJj59fwil9wVUvj
         JCREnpF8SIq6e5RRfw8a2sqA+De+OLuEt2Qg5BxFyf4K6/lOFryR40g+9CV6vdhCNOsD
         PqgEqQ97RpO67zv6YeV1+eS8nBxgm8/hjbRTlTIeiBCFAtQcjQCobbDMzozKP419QizD
         6aqxmVCqxMuhtipoHV9L3pSujrOiSJ2CtKRKsndsi9qRJfXuCcY7xi9IigaHAAgAySzS
         W1foouSJXY3s5n9uszcmDHCKnDpxo0cGhlXQTAj13y5VQc/LcWGA8a+ATluTNShec1aZ
         VbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755220975; x=1755825775;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUNfPXvn23ec1XSQSwRYOwlDxEkUlSap0fKMXZF0CSI=;
        b=bMsDC6yemb9sWtIwFwiGpbuM+t796tFBYeYY+pTPbC1YGS+ahYkkGxL1D/H/J6TZdM
         3iMzSksS4ZabYmTajswIQtE1mqDEKozV4Z+tEIU2QCjE+fv2hJQdrUuO9aABNPZT6emR
         +xyl0PMQzkO0sK/57ik9DceOHMD0XZIKIZ7BVd1TBxRKuvrxb4prhluoNcfM8EOvf2lL
         TTK3MtQMUt9D4rE3zfqtrF9dWdBb4EdDoS7iAuGX8S5ILEbvHUncw9c95vD27lPLGSbL
         IZhonep1wjV5IvqBbHGMnnFPeq1rjObTi5XCFLrbE4dgXWQnm1o5vhyG/0lU3B63mukD
         nbXw==
X-Gm-Message-State: AOJu0Ywf9LzG2z9l9+WD9gtQdwVSnhErdJNPVVjS+W5OYbu8Lj8CM/rG
	MIDwUsRAbWJWlL808cyX3576CArkCjZbD03Nm6pUp7AauBJ3oXBfXczOOSr6yQ==
X-Gm-Gg: ASbGncvTkdDBIO1BJbFKgckeqe1OQniNCkn/jGcHvo3YBexIkXoaHL7k49NuNvJGBns
	6KlCQDjW0sZ+/fJmRF1GhZUfCA7kjAs8QJLw3C9eOK1flTJpfRj5d0YW62aFyZgK/XLz+chLgwd
	4gIqD99wpIG2hKVpPeEK2LAUmpvp3ANdp/YE0ntVqCWWNAnfwM7UrbtGk1G92k6wE5fy/1Jsamx
	rItv3LPiflOtRDrNdpjY+bfI/VlX62MKK38hOB2yPKcOLExvWSH0Dvivov0gMdqx0342lRSK7tt
	p65R/pTTGJ1/Z9nKkR2FzrDmtnQfX5n4PhhJUPotb6OXuVqNqTKxA+zpClTnFQBz9q8ivJkX/WR
	wVagRMjROxVg3qWMBoWREgRAwP17atb03nQ==
X-Google-Smtp-Source: AGHT+IExaOeVwAcMKJmLMmih2h5M8IQiwZPNvQeBZz55Gn3H9n1bOFnPZScU2zmbl/s54+I8tAGCKw==
X-Received: by 2002:a05:600c:3594:b0:456:191b:9e8d with SMTP id 5b1f17b1804b1-45a217ed6f9mr2823525e9.11.1755220974820;
        Thu, 14 Aug 2025 18:22:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1b1d4212sm26315905e9.0.2025.08.14.18.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 18:22:54 -0700 (PDT)
Message-Id: <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
In-Reply-To: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 15 Aug 2025 01:22:35 +0000
Subject: [PATCH v2 00/17] RFC: Accelerate xdiff and begin its rustification
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Taylor Blau <me@ttaylorr.com>,
    Christian Brabandt <cb@256bit.org>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Eli Schwartz <eschwartz@gentoo.org>,
    "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Matthias =?UTF-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
    Patrick Steinhardt <ps@pks.im>,
    Sam James <sam@gentoo.org>,
    Collin Funk <collin.funk1@gmail.com>,
    Mike Hommey <mh@glandium.org>,
    Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
    Ben Knoble <ben.knoble@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

Changes in this second round of this RFC:

 * Now builds and passes tests on all platforms (example run:
   https://github.com/ezekielnewren/git/actions/runs/16974821401). Special
   thanks to Johannes Schindelin for patches to things for Windows and
   linux32.
 * Includes brian’s rust-support documentation as the new 1st patch
 * Removed the Cargo.lock file from version control, but now CI will upload
   these files as build artifacts so we can audit dependencies and notice
   if/when new dependencies cause issues.
 * Added handling of whitespace flags. These are slower; see below

Particular points I’m interested in feedback on:

 * Code style: Should we adopt a Rust code style of some sort? Perhaps have
   the code always be formatted by rustfmt in its default configuration?
 * Rust version: We are not using the same Rust version on all platforms in
   CI; 32-bit builds and Windows builds require a newer Rust version to
   successfully build.
 * Performance with whitepsace flags: I originally intended to leave out the
   whitespace handling because I knew it was slower, and I think it’d be
   difficult to fix that until more of xdiff is converted to Rust, but since
   Junio requested it, I have an implementation here. I made sure that both
   –ignore-cr-at-eol (the default on Windows) and no whitespace flags remain
   fast (or are faster), but other whitespace flag combinations are
   currently significantly slower. Are folks okay with merging this, since
   it’ll only affect those that specify some special flag, should we perhaps
   only convert the code path with no whitespace flags for now, or something
   else?
 * Types/Aliases/Data passing: The discussion between Phillip on I on
   types/translation; this longer series has examples with e.g.
   xdl_line_hash() and line_hash() which might give us more to talk about,
   though I think we can’t fully address that discussion until we have an
   example which I’m planning with a later series with an IVec type.
 * There was lots of feedback on v1, and I might have missed some; let me
   know if there’s something I need to still look at.

==Original cover letter==

This series accelerates xdiff by 5-19%.

It also introduces Rust as a hard dependency.

…and it doesn’t yet pass a couple of the github workflows; hints from
Windows experts, and opinions on ambiguous primitives would be appreciated
(see below).

This is just the beginning of many patches that I have to convert portions
of, maybe eventually all of, xdiff to Rust. While working on that
conversion, I found several ways to clarify the code, along with some
optimizations.

So...

This obviously raises the question of whether we are ready to accept a hard
dependency on Rust. Previous discussions on the mailing list and at Git
Merge 2024 have not answered that question. If not now, will we be willing
to accept such a hard dependency later? And what route do we want to take to
get there?

About the optimizations in this series:

1. xdiff currently uses DJB2a for hashing (even though it is not explicitly named as such). This is an older hashing algorithm, and modern alternatives are superior. I chose xxhash because it’s faster, more collision resistant, and designed to be a standard. Other hash algorithms like aHash, MurMurHash, SipHash, and Fnv1a were considered, but my local testing made me feel like xxhash was the best choice for usage in xdiff.

2. In support of switching to xxhash, parsing and hashing were split into separate steps. And it turns out that memchr() is faster for parsing than character-by-character iteration.


About the workflow builds/tests that aren’t working with this series:

1. Windows fails to build. I don’t know which rust toolchain is even correct for this or if multiple are needed.  Example failed build: https://github.com/git/git/actions/runs/16353209191

2. I386/ubuntu:focal will build, but fails the tests. The kernel reports the bitness as 64 despite the container being 32. I believe the issue is that C uses ambiguous primitives (which differ in size between platforms). The new code should use unambiguous primitives from Rust (u32, u64, etc.) rather than perpetuating ambiguous primitive types.  Since the current xdiff API hardcodes the ambiguous types, though, those places will need to be migrated to unambiguous primitives. Much of the C code needs a slight refactor to be compatible with the Rust FFI and usually requires converting ambiguous to unambiguous types. What does this community think of this approach?


My brother (Elijah, cc’ed) has been guiding and reviewing my work here.

Ezekiel Newren (13):
  xdiff: introduce rust
  xdiff/xprepare: remove superfluous forward declarations
  xdiff: delete unnecessary fields from xrecord_t and xdfile_t
  xdiff: make fields of xrecord_t Rust friendly
  xdiff: separate parsing lines from hashing them
  xdiff: conditionally use Rust's implementation of xxhash
  github workflows: install rust
  github workflows: define rust versions and targets in the same place
  github workflows: upload Cargo.lock
  xdiff: implement a white space iterator in Rust
  xdiff: create line_hash() and line_equal()
  xdiff: optimize case where --ignore-cr-at-eol is the only whitespace
    flag
  xdiff: use rust's version of whitespace processing

Johannes Schindelin (3):
  Do support Windows again after requiring Rust
  win+Meson: allow for xdiff to be compiled with MSVC
  win+Meson: do allow linking with the Rust-built xdiff

brian m. carlson (1):
  doc: add a policy for using Rust

 .github/workflows/main.yml                    |  61 +++
 .gitignore                                    |   3 +
 Documentation/Makefile                        |   1 +
 Documentation/technical/platform-support.adoc |   2 +
 Documentation/technical/rust-support.adoc     | 119 ++++++
 Makefile                                      |  60 ++-
 build_rust.sh                                 |  59 +++
 ci/install-dependencies.sh                    |  14 +-
 ci/install-rust.sh                            |  37 ++
 ci/lib.sh                                     |   1 +
 ci/make-test-artifacts.sh                     |   7 +
 ci/run-build-and-tests.sh                     |  12 +
 config.mak.uname                              |   9 +
 git-compat-util.h                             |  17 +
 meson.build                                   |  48 ++-
 rust/Cargo.toml                               |   6 +
 rust/interop/Cargo.toml                       |  14 +
 rust/interop/src/lib.rs                       |   0
 rust/xdiff/Cargo.toml                         |  16 +
 rust/xdiff/src/lib.rs                         |  30 ++
 rust/xdiff/src/xutils.rs                      | 354 ++++++++++++++++++
 xdiff-interface.c                             |   4 +-
 xdiff/xdiffi.c                                |   8 +-
 xdiff/xemit.c                                 |   2 +-
 xdiff/xmerge.c                                |  10 +-
 xdiff/xpatience.c                             |   2 +-
 xdiff/xprepare.c                              | 219 +++++------
 xdiff/xtypes.h                                |   9 +-
 xdiff/xutils.c                                | 162 +-------
 xdiff/xutils.h                                |   4 +-
 30 files changed, 961 insertions(+), 329 deletions(-)
 create mode 100644 Documentation/technical/rust-support.adoc
 create mode 100755 build_rust.sh
 create mode 100755 ci/install-rust.sh
 create mode 100644 rust/Cargo.toml
 create mode 100644 rust/interop/Cargo.toml
 create mode 100644 rust/interop/src/lib.rs
 create mode 100644 rust/xdiff/Cargo.toml
 create mode 100644 rust/xdiff/src/lib.rs
 create mode 100644 rust/xdiff/src/xutils.rs


base-commit: 16bd9f20a403117f2e0d9bcda6c6e621d3763e77
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1980%2Fezekielnewren%2Fxdiff_rust_speedup-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1980/ezekielnewren/xdiff_rust_speedup-v2
Pull-Request: https://github.com/git/git/pull/1980

Range-diff vs v1:

  -:  ----------- >  1:  75dfb40ead3 doc: add a policy for using Rust
  1:  2a1f4be13df !  2:  7709e5eddba xdiff: introduce rust
     @@ Commit message
      
          Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
      
     + ## .gitignore ##
     +@@ .gitignore: Release/
     + /contrib/buildsystems/out
     + /contrib/libgit-rs/target
     + /contrib/libgit-sys/target
     ++/.idea/
     ++/rust/target/
     ++/rust/Cargo.lock
     +
       ## Makefile ##
      @@ Makefile: TEST_SHELL_PATH = $(SHELL_PATH)
       
     @@ meson.build: version_def_h = custom_target(
         link_with: static_library('git',
           sources: libgit_sources,
      
     - ## rust/Cargo.lock (new) ##
     -@@
     -+# This file is automatically @generated by Cargo.
     -+# It is not intended for manual editing.
     -+version = 4
     -+
     -+[[package]]
     -+name = "interop"
     -+version = "0.1.0"
     -+
     -+[[package]]
     -+name = "xdiff"
     -+version = "0.1.0"
     -+dependencies = [
     -+ "interop",
     -+]
     -
       ## rust/Cargo.toml (new) ##
      @@
      +[workspace]
  2:  b0b744b9acf =  3:  56c96d35554 xdiff/xprepare: remove superfluous forward declarations
  3:  cc05150d6e1 =  4:  ebec3689dce xdiff: delete unnecessary fields from xrecord_t and xdfile_t
  4:  6df9f50a8f4 !  5:  769d1a5b9d2 xdiff: make fields of xrecord_t Rust friendly
     @@ Commit message
          few variables to use these types. Which, for now, will
          require adding some casts.
      
     +    Also change xdlclass_t::ha to be u64 to match xrecord_t::ha, as
     +    pointed out by Johannes.
     +
     +    Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
          Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
      
       ## xdiff/xdiffi.c ##
     @@ xdiff/xpatience.c: static void insert_record(xpparam_t const *xpp, int line, str
       	if (map->last) {
      
       ## xdiff/xprepare.c ##
     +@@
     + 
     + typedef struct s_xdlclass {
     + 	struct s_xdlclass *next;
     +-	unsigned long ha;
     ++	u64 ha;
     + 	char const *line;
     + 	long size;
     + 	long idx;
      @@ xdiff/xprepare.c: static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
       	char const *line;
       	xdlclass_t *rcrec;
  5:  2db30cc739e =  6:  87623495994 xdiff: separate parsing lines from hashing them
  6:  5a959c9bdad !  7:  d74fd4ef67a xdiff: conditionally use Rust's implementation of xxhash
     @@ Commit message
      
          Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
      
     - ## rust/Cargo.lock ##
     -@@ rust/Cargo.lock: name = "xdiff"
     - version = "0.1.0"
     - dependencies = [
     -  "interop",
     -+ "xxhash-rust",
     - ]
     -+
     -+[[package]]
     -+name = "xxhash-rust"
     -+version = "0.8.15"
     -+source = "registry+https://github.com/rust-lang/crates.io-index"
     -+checksum = "fdd20c5420375476fbd4394763288da7eb0cc0b8c11deed431a91562af7335d3"
     -
       ## rust/xdiff/Cargo.toml ##
      @@ rust/xdiff/Cargo.toml: crate-type = ["staticlib", "rlib"]
       
  7:  0de0867ab44 !  8:  7dc241e6682 github_workflows: install rust
     @@ Metadata
      Author: Ezekiel Newren <ezekielnewren@gmail.com>
      
       ## Commit message ##
     -    github_workflows: install rust
     +    github workflows: install rust
      
          Since we have introduced rust, it needs to be installed for the
          continuous integration build targets. Create an install script
     @@ .github/workflows/main.yml: on: [push, pull_request]
       # If more than one workflow run is triggered for the very same commit hash
       # (which happens when multiple branches pointing to the same commit), only
      
     - ## .gitignore ##
     -@@ .gitignore: Release/
     - /contrib/buildsystems/out
     - /contrib/libgit-rs/target
     - /contrib/libgit-sys/target
     -+/rust/target
     -
       ## Makefile ##
      @@ Makefile: TEST_SHELL_PATH = $(SHELL_PATH)
       
  -:  ----------- >  9:  96041a10d54 Do support Windows again after requiring Rust
  -:  ----------- > 10:  1194de3f39c win+Meson: allow for xdiff to be compiled with MSVC
  -:  ----------- > 11:  382067a09e3 win+Meson: do allow linking with the Rust-built xdiff
  -:  ----------- > 12:  fffdb326710 github workflows: define rust versions and targets in the same place
  -:  ----------- > 13:  44784f0d672 github workflows: upload Cargo.lock
  -:  ----------- > 14:  f20efdff7aa xdiff: implement a white space iterator in Rust
  -:  ----------- > 15:  c8d41173274 xdiff: create line_hash() and line_equal()
  -:  ----------- > 16:  f7829c55871 xdiff: optimize case where --ignore-cr-at-eol is the only whitespace flag
  -:  ----------- > 17:  395609aff4b xdiff: use rust's version of whitespace processing

-- 
gitgitgadget
