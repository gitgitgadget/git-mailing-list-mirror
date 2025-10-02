Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFEE23B623
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 23:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759447652; cv=none; b=OkCMfVexhgLV3EHlBryUQMHupQScP76qK3UBiHlwWHdBUHqgfWBxsxybKJ2b+h1NagGSymTnCKwplnoZ79b7fNoXNIPmYaObBHOUc9Nuivqh2jolqd4Lp3ycQDY37SuzJ1EQypm4zQxGV1k6Zy9wB5ZMJ/Gn3OmFk8pUpLQSg4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759447652; c=relaxed/simple;
	bh=cXQbqyHCwehNTdCh6k4hj5bo+qLPPTQUuKSEf9U0Jcc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BlF4qGhPGfr7drnYfYeDENzk5qzX+rgDGkglz/AnQHYWZleHS4raTrrpfZjUAwIjp6P8tQaL+AyJMO+zMA+hp33DHt9PGpuH+RJfB2cw2zRCEadB5PeDGEeU/+TBuqM2BEnGDCXF63wiphpxZ8yrK8l2OQA/giLDCpLC4/cfdeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5t6rmu4; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5t6rmu4"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-42e758963e4so5996085ab.2
        for <git@vger.kernel.org>; Thu, 02 Oct 2025 16:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759447650; x=1760052450; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmgUZlEKWTF5V0DanGWGiGDP+e+XQ63OLt0vWCehApE=;
        b=C5t6rmu47iDPjezDVf82u5Uk3BejfjIybwUcUWQA+BuHYjwiWzwvfA8NZ2Tua9+hbj
         rS0lSpsB32ZpXe/DfuFkW+vmhizCUQdJKZw2R5edKTdWMRzIOs4ghv7pQbLC4INpFHl2
         1kDDPHMr1nv9y74mFb1I16IxtL1g10A+o3yAJA+diDhSzV3+7lxvquBpHceofa31SMOt
         j/iu8b9aZzJ2G0Zm/gf+e4MtblRRZSZ1Lo1l5nKPEEPLfuIPMc5PcrA/4VHUfva88D6h
         YzAHZkKx47Z9ShHkjjoi53Jr2RhPDkoBg9XWXzXPeR7xHjfkCNH0GNoKQzRovsSB3409
         5/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759447650; x=1760052450;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PmgUZlEKWTF5V0DanGWGiGDP+e+XQ63OLt0vWCehApE=;
        b=n/cWC5JKCl6hSY39K8mB4CWX1aO+qE2K6tLKMWTk5/IZmVDsYbbpIJXgBpnU3b+Kbc
         O1tV9JwiGlYZZtQMYDUQxa665B9Wu8dna5tl0UiAS7PLk7nV92SI+W3rNbAi0fdMl2tt
         SqqcTTe5o5b/BLfhzzo885wVFvTrvg88/ycjNN+59c/LsqZmmLu6gi3gVB0+Gvb+mJWI
         6wAC8fuHP3fvrvkfJGSVBesW7OGmlpVdBWCK1fUQU98ZrlQDE/fOZiUM6rEjpVASQywf
         MvuNXYKK+VU6eUWrCEXfCla5rl673f7W/M6pjZ+AwAtjBKQX76W5mpQfVI6kijTkT6z3
         GjXw==
X-Gm-Message-State: AOJu0YyDcFDrrqrayo+aZuavImXFzQqRN0EikJcergr/+zO5Aow8lT8i
	EEIho9EnmHXD7ognschfdZf0Nv6lRawq8i78fI0D6ArvfOk5qEt2RBZmovDALg==
X-Gm-Gg: ASbGnct4NgdFMzMX6m2it5NZBoZRFamctE8BLpjbZcNFGJ6hfeCAlFMHeuoqjQRckXo
	POq9F1bXoFZJv9WuH78uvaUYTcXkQFZTmh8tq6L6dBahXfqAUmVoAmHxch3ogf5t8E2+UJYSKOk
	IlVDZT5dFoC4dKd38Qcwscna/jhtn/BPAkzxkCmtY+HpdZwvpKJWJZL6whM7JcgbcLLE61LowZl
	mrA5N1TQLHZLi5MdUIqXNSEgIXX3/GVDUZF6RQB6Pmdrm8MURBQCVn0gHEbtXsJM2UPPIATILbK
	MfNYduyT1AXDetNdXAsXaogS/5j5NSEWXp4dAMUYpNMXpk2fB2Hpf83TAJrbhMl7+XGQMYIThzR
	xzEJJyvg71uKjgk0WHwU+ztOrZ3LVFt/5/JWUTJU5JECw9jZeaNA=
X-Google-Smtp-Source: AGHT+IFNPGPTCgWgMSO5wvwrhin+85UGRPY8KTjRPUM9bXRTgoZh/wqbRVvaPd84jD1dmJBpkmAYUQ==
X-Received: by 2002:a05:6e02:1aa7:b0:42b:2a51:f50a with SMTP id e9e14a558f8ab-42e7adb9792mr12700265ab.31.1759447649614;
        Thu, 02 Oct 2025 16:27:29 -0700 (PDT)
Received: from [127.0.0.1] ([172.212.171.144])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-57b5ebc8433sm1291096173.41.2025.10.02.16.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 16:27:28 -0700 (PDT)
Message-Id: <pull.2065.v2.git.git.1759447647.gitgitgadget@gmail.com>
In-Reply-To: <pull.2065.git.git.1759341748.gitgitgadget@gmail.com>
References: <pull.2065.git.git.1759341748.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 02 Oct 2025 23:27:25 +0000
Subject: [PATCH v2 0/2] Makefile update libgit.a: Include xdiff and reftable in libgit.a
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Ezekiel Newren <ezekielnewren@gmail.com>

Changes in v2:

 * Add xdiff and reftable objects directly to LIB_OBJS.
 * Explain why xdiff-objs is removed.


Original cover letter:
======================

Add xdiff and reftable to the static library libgit.a that Makefile
produces. Meson does not require any changes since it already includes those
libraries. The motivation is to simplify Rust's job of linking against the C
code by requiring it to only link against a single static library
(libgit.a).

The Rust compiler only needs to know how to link against libgit.a in 2 cases
that I can think of:

 * Rust unit tests
 * Rust defining the main function

Otherwise Rust can be compiled without linking, and then Makefile and Meson
can use Cargo's produced static lib files to build Git.

Note: The flag -fPIE or -fPIC is required for Makefile to build libgit.a in
a way that Cargo can use. It has been deliberately omitted from the
Makefile, for now, since Rust isn't part of Git (yet).

Ezekiel Newren (2):
  make: delete XDIFF_LIB, add xdiff to LIB_OBJS
  make: delete REFTABLE_LIB, add reftable to LIB_OBJS

 Makefile | 62 +++++++++++++++++++++-----------------------------------
 1 file changed, 23 insertions(+), 39 deletions(-)


base-commit: a91ca5db0318b6fda5a6721ee843f56e7e2fadfc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2065%2Fezekielnewren%2Fmerge_xdiff_and_reftable_with_libgit-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2065/ezekielnewren/merge_xdiff_and_reftable_with_libgit-v2
Pull-Request: https://github.com/git/git/pull/2065

Range-diff vs v1:

 1:  fdcf5a0de8 < -:  ---------- make: move xdiff and reftable objects before GITLIBS
 2:  28e7fd27b6 ! 1:  b535a456ae make: delete XDIFF_LIB, add xdiff to LIB_OBJS
     @@ Commit message
          Changes to Meson are not required as the xdiff library is already
          included in Meson's libgit.a.
      
     +    xdiff-objs was a historical make target to allow building just the
     +    objects in xdiff. Since it was defined in terms of XDIFF_OBJS (which
     +    no longer exists) this convenience make target no longer makes sense.
     +    Remove it.
     +
          Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
      
       ## Makefile ##
     @@ Makefile: export PYTHON_PATH
       REFTABLE_LIB = reftable/libreftable.a
       
       GENERATED_H += command-list.h
     -@@ Makefile: XDIFF_OBJS += xdiff/xmerge.o
     - XDIFF_OBJS += xdiff/xpatience.o
     - XDIFF_OBJS += xdiff/xprepare.o
     - XDIFF_OBJS += xdiff/xutils.o
     --.PHONY: xdiff-objs
     --xdiff-objs: $(XDIFF_OBJS)
     -+LIB_OBJS += $(XDIFF_OBJS)
     +@@ Makefile: LIB_OBJS += write-or-die.o
     + LIB_OBJS += ws.o
     + LIB_OBJS += wt-status.o
     + LIB_OBJS += xdiff-interface.o
     ++LIB_OBJS += xdiff/xdiffi.o
     ++LIB_OBJS += xdiff/xemit.o
     ++LIB_OBJS += xdiff/xhistogram.o
     ++LIB_OBJS += xdiff/xmerge.o
     ++LIB_OBJS += xdiff/xpatience.o
     ++LIB_OBJS += xdiff/xprepare.o
     ++LIB_OBJS += xdiff/xutils.o
       
     - REFTABLE_OBJS += reftable/basics.o
     - REFTABLE_OBJS += reftable/error.o
     -@@ Makefile: REFTABLE_OBJS += reftable/table.o
     - REFTABLE_OBJS += reftable/tree.o
     - REFTABLE_OBJS += reftable/writer.o
     + BUILTIN_OBJS += builtin/add.o
     + BUILTIN_OBJS += builtin/am.o
     +@@ Makefile: CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
     + 
     + UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
       
      -# xdiff and reftable libs may in turn depend on what is in libgit.a
      -GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(LIB_FILE)
     @@ Makefile: REFTABLE_OBJS += reftable/table.o
       EXTLIBS =
       
       GIT_USER_AGENT = git/$(GIT_VERSION)
     +@@ Makefile: reconfigure config.mak.autogen: config.status
     + .PHONY: reconfigure # This is a convenience target.
     + endif
     + 
     +-XDIFF_OBJS += xdiff/xdiffi.o
     +-XDIFF_OBJS += xdiff/xemit.o
     +-XDIFF_OBJS += xdiff/xhistogram.o
     +-XDIFF_OBJS += xdiff/xmerge.o
     +-XDIFF_OBJS += xdiff/xpatience.o
     +-XDIFF_OBJS += xdiff/xprepare.o
     +-XDIFF_OBJS += xdiff/xutils.o
     +-.PHONY: xdiff-objs
     +-xdiff-objs: $(XDIFF_OBJS)
     +-
     + REFTABLE_OBJS += reftable/basics.o
     + REFTABLE_OBJS += reftable/error.o
     + REFTABLE_OBJS += reftable/block.o
      @@ Makefile: OBJECTS += $(GIT_OBJS)
       OBJECTS += $(SCALAR_OBJS)
       OBJECTS += $(PROGRAM_OBJS)
 3:  8549f63415 ! 2:  9031610dc8 make: delete REFTABLE_LIB, add reftable to LIB_OBJS
     @@ Makefile: export PYTHON_PATH
       
       GENERATED_H += command-list.h
       GENERATED_H += config-list.h
     -@@ Makefile: REFTABLE_OBJS += reftable/system.o
     - REFTABLE_OBJS += reftable/table.o
     - REFTABLE_OBJS += reftable/tree.o
     - REFTABLE_OBJS += reftable/writer.o
     -+LIB_OBJS += $(REFTABLE_OBJS)
     +@@ Makefile: LIB_OBJS += refs/iterator.o
     + LIB_OBJS += refs/packed-backend.o
     + LIB_OBJS += refs/ref-cache.o
     + LIB_OBJS += refspec.o
     ++LIB_OBJS += reftable/basics.o
     ++LIB_OBJS += reftable/error.o
     ++LIB_OBJS += reftable/block.o
     ++LIB_OBJS += reftable/blocksource.o
     ++LIB_OBJS += reftable/iter.o
     ++LIB_OBJS += reftable/merged.o
     ++LIB_OBJS += reftable/pq.o
     ++LIB_OBJS += reftable/record.o
     ++LIB_OBJS += reftable/stack.o
     ++LIB_OBJS += reftable/system.o
     ++LIB_OBJS += reftable/table.o
     ++LIB_OBJS += reftable/tree.o
     ++LIB_OBJS += reftable/writer.o
     + LIB_OBJS += remote.o
     + LIB_OBJS += replace-object.o
     + LIB_OBJS += repo-settings.o
     +@@ Makefile: CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
     + 
     + UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
       
      -# reftable lib may in turn depend on what is in libgit.a
      -GITLIBS = common-main.o $(LIB_FILE) $(REFTABLE_LIB) $(LIB_FILE)
     @@ Makefile: REFTABLE_OBJS += reftable/system.o
       EXTLIBS =
       
       GIT_USER_AGENT = git/$(GIT_VERSION)
     +@@ Makefile: reconfigure config.mak.autogen: config.status
     + .PHONY: reconfigure # This is a convenience target.
     + endif
     + 
     +-REFTABLE_OBJS += reftable/basics.o
     +-REFTABLE_OBJS += reftable/error.o
     +-REFTABLE_OBJS += reftable/block.o
     +-REFTABLE_OBJS += reftable/blocksource.o
     +-REFTABLE_OBJS += reftable/iter.o
     +-REFTABLE_OBJS += reftable/merged.o
     +-REFTABLE_OBJS += reftable/pq.o
     +-REFTABLE_OBJS += reftable/record.o
     +-REFTABLE_OBJS += reftable/stack.o
     +-REFTABLE_OBJS += reftable/system.o
     +-REFTABLE_OBJS += reftable/table.o
     +-REFTABLE_OBJS += reftable/tree.o
     +-REFTABLE_OBJS += reftable/writer.o
     +-
     + TEST_OBJS := $(patsubst %$X,%.o,$(TEST_PROGRAMS)) $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
     + 
     + .PHONY: test-objs
      @@ Makefile: OBJECTS += $(SCALAR_OBJS)
       OBJECTS += $(PROGRAM_OBJS)
       OBJECTS += $(TEST_OBJS)

-- 
gitgitgadget
