Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFB961F97E
	for <e@80x24.org>; Sat, 13 Oct 2018 00:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbeJMIdq (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Oct 2018 04:33:46 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:54592 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbeJMIdp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Oct 2018 04:33:45 -0400
Received: by mail-pl1-f201.google.com with SMTP id v4-v6so10652929plz.21
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 17:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WFBpSyDKxVA82ztttPC6Q0UUb6Kpo8R7NNQjdudiW4U=;
        b=D6zupKRL7o2feHqkISRAO5hN4btmLfM8BrMDSyURkIyqDzfh4SEG1kYxDi5fkwJuKb
         MZbda+2b4htnzpEXIy1G3dgeEom16bQ+ahqOc3DXWlt/XhImja4MYJ6e0WgeKS53kj5x
         8Hq4Lmi21nrJyuF0pBTSrbdKbKSyvyTOXSboENEnyOhmlq3WHqbwsvlj02suwkONGzPW
         Y/MNfgoIFd3GDoYDUt+U4P3a6+VR/b40Caj19TRHpbcv8V/BMLbpA4GyVHtTisxoNSQQ
         j+UNba2pdy/7bcWfubbVufha39qs/RGxqD3aeEllJKy1rBPLL6IMUtKPEvzyQsh/zeRF
         JZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WFBpSyDKxVA82ztttPC6Q0UUb6Kpo8R7NNQjdudiW4U=;
        b=oco7VAWjF0d98wJphFMeJCzlDyc7r78t85r38VLaBfwkeYNVPloFmXwfC1R0usGZjd
         bG/4znZ6gu0VNSOJW8Y1SyFq1N/uEyF5IK/sK0Q6p5TbmHm0cEcP4rkvDoQEZhixwxag
         e/zxnkCuUlZ/rbGRlfNeioAXj4S91Csnm7Kp/W+ovQWeUDyqd/1K+MkU+gcxbQ3pY9V7
         RxxNYz1MMFxARQJn7oevPKIPEMGjJW49KYFAgNSHbVbmZompbeZu5M8YQWHtEjNraLDM
         BnhnEB7HAni9UiZyqJHltjSsM3rXSaC+LOSxcr8+M++5h05XM0z7wbwsPvsSxxBhPT5/
         mIfQ==
X-Gm-Message-State: ABuFfoj6TdbFhfWf1iVkalnxAGqoddc+BcSOTenWJorVt5pZt1ebT11X
        W02YiYA7jMbnrzlTIKO+wN7gGlxyVc2PWBSdn5bUAvQgLC8bPu/PwsZdcMIj8kgWaELqqkorlGc
        2fc398VdWJpuf1ltvVJm1ny6Nkm5ROriRndQvAUIEXOtXUTJFUOxbgHROV1swi3g=
X-Google-Smtp-Source: ACcGV616p/RBAEm9Zdodv9IE0saGF0N+Z+92rrjI44NQnT5HSGji765bojwacH14ES1rVLcJKqNbJ/GD3E6Dog==
X-Received: by 2002:a62:660b:: with SMTP id a11-v6mr4551521pfc.24.1539392323174;
 Fri, 12 Oct 2018 17:58:43 -0700 (PDT)
Date:   Fri, 12 Oct 2018 17:58:39 -0700
In-Reply-To: <cover.1538693039.git.steadmon@google.com>
Message-Id: <cover.1539391439.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1538693039.git.steadmon@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v2 0/2] add fuzzing targets for use with OSS-Fuzz
From:   steadmon@google.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Josh Steadmon <steadmon@google.com>

V2 of this series pulls the compiler flags out of the Makefile, to be
provided by the user depending on the combination of compiler and
fuzzing engine in use. This also makes it more compatible with
OSS-Fuzz's build process.

Josh Steadmon (2):
  fuzz: Add basic fuzz testing target.
  fuzz: Add fuzz testing for packfile indices.

 .gitignore          |  3 +++
 Makefile            | 33 +++++++++++++++++++++++++++++++++
 fuzz-pack-headers.c | 14 ++++++++++++++
 fuzz-pack-idx.c     | 13 +++++++++++++
 packfile.c          | 44 +++++++++++++++++++++++++-------------------
 packfile.h          | 13 +++++++++++++
 6 files changed, 101 insertions(+), 19 deletions(-)
 create mode 100644 fuzz-pack-headers.c
 create mode 100644 fuzz-pack-idx.c

Range-diff against v1:
1:  9456c41798 ! 1:  446d8081b1 fuzz: Add basic fuzz testing target.
    @@ -32,6 +32,9 @@
      
     +FUZZ_OBJS += fuzz-pack-headers.o
     +
    ++# Always build fuzz objects even if not testing, to prevent bit-rot.
    ++all:: $(FUZZ_OBJS)
    ++
     +FUZZ_PROGRAMS += $(patsubst %.o,%,$(FUZZ_OBJS))
     +
      # Empty...
    @@ -46,14 +49,13 @@
      	git.o
      ifndef NO_CURL
     @@
    - cocciclean:
    - 	$(RM) contrib/coccinelle/*.cocci.patch*
    - 
    --clean: profile-clean coverage-clean cocciclean
    -+clean: profile-clean coverage-clean cocciclean fuzz-clean
    - 	$(RM) *.res
    - 	$(RM) $(OBJECTS)
      	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(VCSSVN_LIB)
    + 	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) git$X
    + 	$(RM) $(TEST_PROGRAMS) $(NO_INSTALL)
    ++	$(RM) $(FUZZ_PROGRAMS)
    + 	$(RM) -r bin-wrappers $(dep_dirs)
    + 	$(RM) -r po/build/
    + 	$(RM) *.pyc *.pyo */*.pyc */*.pyo command-list.h $(ETAGS_TARGET) tags cscope*
     @@
      cover_db_html: cover_db
      	cover -report html -outputdir cover_db_html cover_db
    @@ -61,24 +63,24 @@
     +
     +### Fuzz testing
     +#
    -+.PHONY: fuzz-clean fuzz-objs fuzz-compile
    -+
    -+FUZZ_CFLAGS = $(CFLAGS) -fsanitize-coverage=trace-pc-guard -fsanitize=address
    -+FUZZ_LDFLAGS = $(FUZZ_CFLAGS)
    -+
    -+
    -+fuzz-clean:
    -+	$(RM) $(FUZZ_PROGRAMS) $(FUZZ_OBJS)
    -+
    -+fuzz-objs: $(FUZZ_OBJS)
    ++# Building fuzz targets generally requires a special set of compiler flags that
    ++# are not necessarily appropriate for general builds, and that vary greatly
    ++# depending on the compiler version used.
    ++#
    ++# An example command to build against libFuzzer from LLVM 4.0.0:
    ++#
    ++# make CC=clang CXX=clang++ \
    ++#      CFLAGS="-fsanitize-coverage=trace-pc-guard -fsanitize=address" \
    ++#      LIB_FUZZING_ENGINE=/usr/lib/llvm-4.0/lib/libFuzzer.a \
    ++#      fuzz-all
    ++#
    ++.PHONY: fuzz-all
     +
    -+fuzz-compile:
    -+	$(MAKE) CC=clang LD=clang CFLAGS="$(FUZZ_CFLAGS)" \
    -+		LDFLAGS="$(FUZZ_LDFLAGS)" all fuzz-objs
    ++$(FUZZ_PROGRAMS): all
    ++	$(QUIET_LINK)$(CXX) $(CFLAGS) $(LIB_OBJS) $(BUILTIN_OBJS) \
    ++		$(XDIFF_OBJS) $(EXTLIBS) git.o $@.o $(LIB_FUZZING_ENGINE) -o $@
     +
    -+$(FUZZ_PROGRAMS): fuzz-compile
    -+	clang++ $(FUZZ_LDFLAGS) $(LIB_OBJS) $(BUILTIN_OBJS) $(XDIFF_OBJS) \
    -+		$(EXTLIBS) git.o $@.o /usr/lib/llvm-4.0/lib/libFuzzer.a -o $@
    ++fuzz-all: $(FUZZ_PROGRAMS)
     
      diff --git a/fuzz-pack-headers.c b/fuzz-pack-headers.c
      new file mode 100644
2:  581eb8f817 ! 2:  c7b5a03d81 fuzz: Add fuzz testing for packfile indices.
    @@ -24,23 +24,8 @@
      FUZZ_OBJS += fuzz-pack-headers.o
     +FUZZ_OBJS += fuzz-pack-idx.o
      
    - FUZZ_PROGRAMS += $(patsubst %.o,%,$(FUZZ_OBJS))
    - 
    -@@
    - 
    - ### Fuzz testing
    - #
    --.PHONY: fuzz-clean fuzz-objs fuzz-compile
    -+.PHONY: fuzz-clean fuzz-objs fuzz-compile fuzz-all
    - 
    - FUZZ_CFLAGS = $(CFLAGS) -fsanitize-coverage=trace-pc-guard -fsanitize=address
    - FUZZ_LDFLAGS = $(FUZZ_CFLAGS)
    -@@
    - $(FUZZ_PROGRAMS): fuzz-compile
    - 	clang++ $(FUZZ_LDFLAGS) $(LIB_OBJS) $(BUILTIN_OBJS) $(XDIFF_OBJS) \
    - 		$(EXTLIBS) git.o $@.o /usr/lib/llvm-4.0/lib/libFuzzer.a -o $@
    -+
    -+fuzz-all: $(FUZZ_PROGRAMS)
    + # Always build fuzz objects even if not testing, to prevent bit-rot.
    + all:: $(FUZZ_OBJS)
     
      diff --git a/fuzz-pack-idx.c b/fuzz-pack-idx.c
      new file mode 100644
-- 
2.19.0.605.g01d371f741-goog

