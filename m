Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D26299A94
	for <git@vger.kernel.org>; Thu, 27 Nov 2025 01:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764205842; cv=none; b=DEgJrS2JIr/SSVGODv9LUf0vXjxN8siBfoPvYLYStObTMyfAuno6nmatuvCv3boA/ufzoStI1Ed3tSAOvvV0Q1o4EicXONB7K3wjUP/hKkJPYXWCCKLlYK/UUY6L/hjrOSgSDkotTc0tzWrcCUwh06IwYWqYZ3YcnYCH3h9rc88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764205842; c=relaxed/simple;
	bh=Wndj7prhJGD6cxcfvA8Ft5Rn265YIuOXXYBw4Dgm1VI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bCDnV0okmM+26GBGdLr8tPbXHDLadVl2uNsDSrroM2YCOeUdpUGXJczWbskaaHIZPry+j3nqPuqmYzRQKhTftiFGe0M81hxaUkcG+EAVjlvHo3g4Z5qIFAoqxJ/PsO8GSMmPUIzvwMB9aGhM4qtchA0bGO9mUpBPaUDp6tGjVdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fq0WITk4; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fq0WITk4"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-9490c862fcbso14868239f.2
        for <git@vger.kernel.org>; Wed, 26 Nov 2025 17:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764205840; x=1764810640; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+YAJABOGYmYr7NJbjwXugvu4LYxBNw84jHqmVk8QbE=;
        b=Fq0WITk4ngwfM8i6owRLHTE0l5KGjSWJ/W8RWERMpc/+QhAN7XWH6++ApJ/vEu73u3
         GnB/8Bj2budgwooRtTmSaPrOHNpkbCVo//7W4Ha14HnSWTskM4oHhIQGFMZ5+lTzVUxy
         dUT4yBEUNSc2l+Xf9l6lRM0gbI+4r+u83zBZQHbzLucsL8ujf8rIQA02JZRzARd+dFZF
         QNhDUwEJwbTlITLBHDvZk+Oy0FDdsFUOvy5gSapGbElXglQXVSuEEnp+Ley4QJbuAw8w
         3TLwW8fWvKBcasjPVvNA6V3+4ofznN6ISwq8v3jQQb0jZ5RtcQQQnI2Rop1UQrVo2PIX
         MY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764205840; x=1764810640;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F+YAJABOGYmYr7NJbjwXugvu4LYxBNw84jHqmVk8QbE=;
        b=KKfGPYx4iHlzwg+qTMycIy47iiI7muWI8q512fY1lRefd0ZytFch2HkMv3M3wtaCqe
         ZQ5uWNorgWX5+2G/XImn/yzkrsepbFg/arTOU4NcFsqy1YSIamORnrQmYHbZmvulkRhq
         Pn+T81CIUosqMgEblOKC6ttqGRSJus1agienFqUHveQJe2fHN9pae0/J7nKtqFwPuDvS
         T3Zl7yk3kbmdXjM8kR6lJ1PBRRJ3I09HWdh/sfFt/CEEAiDxXNJqJr8QvcWYahyjzznn
         SbNFilrhl20dC1txeG6ouiF0HS7xYB474UJRIAL23eHB3I0pcDRzH4ZUH3nwBMQl90sv
         rxyw==
X-Gm-Message-State: AOJu0Yz2wxWXlfczkHod7HYy9KionL0ZS0zVSZFpKErPJYaAUQszEZO1
	8p0h6RZGC3/0bk0Wk+cIdjJzULksA3G7XjQtmGMfTd/y1BGNU4NOourWi7YbX2Ai
X-Gm-Gg: ASbGncupNrRHnE/vgNGRbSZ74QPMxMpSwy7737uTIeCC7xIa6pj/MZt9FvY33WE2LA8
	PZq4Ppc7rjkWWfM9O8DRaFjAScIOqirBRiiPYGaxoxkWkDtjdzf0rJmNtbMSa3SIQy0GPu3jCPZ
	GE/fwicAWoTbyX4d83pEwkqukVMKS3/uqLQTVndGVRMETqQ6ZFqZ38wXcmCCTAx6ExYhtmTAJOu
	bTlgKSS7LIEjt47mFsFSXNwreQeKKIEhTr31Q+Lv1KLAiAn+OG3SMLUPq33Sfh+j9tCnWV0UNFM
	MtR13nPb4LqyKHoyZnboXNQ2pTlhFRJ8uJ0Vv6zHgOXC3vLt45sE432kBcBG2Jp/cbsXvXxQN3B
	JDHVFaIGJsVjrNHOe70STGN7J/bdymDuE322gBv0VhU9Fbox5Y+oFqyH7HPNmvXci29q8TRYalL
	6786tv/zo2oRUluw==
X-Google-Smtp-Source: AGHT+IFh6MHDshr24OQlk2ehunfAJmtbQrxjE20zG2yKm+LYZj1PdS2upxeDMyjg2kISNaZ97gDN2g==
X-Received: by 2002:a05:6602:2c03:b0:949:839d:3cf9 with SMTP id ca18e2360f4ac-949839d3ea6mr492501339f.14.1764205839631;
        Wed, 26 Nov 2025 17:10:39 -0800 (PST)
Received: from [127.0.0.1] ([64.236.141.183])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-9498fbee70csm2756839f.7.2025.11.26.17.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 17:10:38 -0800 (PST)
Message-Id: <12ab631072e6076f9dbcd905c62a42795ea9dbfa.1764205835.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2110.git.git.1764205835.gitgitgadget@gmail.com>
References: <pull.2110.git.git.1764205835.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 27 Nov 2025 01:10:23 +0000
Subject: [PATCH 01/13] make: undo Patrick's changes concerning Rust
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
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 Makefile   | 49 -------------------------------------------------
 shared.mak |  1 -
 2 files changed, 50 deletions(-)

diff --git a/Makefile b/Makefile
index 7e0f77e298..28bc00e648 100644
--- a/Makefile
+++ b/Makefile
@@ -483,14 +483,6 @@ include shared.mak
 # Define LIBPCREDIR=/foo/bar if your PCRE header and library files are
 # in /foo/bar/include and /foo/bar/lib directories.
 #
-# == Optional Rust support ==
-#
-# Define WITH_RUST if you want to include features and subsystems written in
-# Rust into Git. For now, Rust is still an optional feature of the build
-# process. With Git 3.0 though, Rust will always be enabled.
-#
-# Building Rust code requires Cargo.
-#
 # == SHA-1 and SHA-256 defines ==
 #
 # === SHA-1 backend ===
@@ -691,7 +683,6 @@ OBJECTS =
 OTHER_PROGRAMS =
 PROGRAM_OBJS =
 PROGRAMS =
-RUST_SOURCES =
 EXCLUDED_PROGRAMS =
 SCRIPT_PERL =
 SCRIPT_PYTHON =
@@ -928,18 +919,6 @@ TEST_SHELL_PATH = $(SHELL_PATH)
 
 LIB_FILE = libgit.a
 
-ifdef DEBUG
-RUST_TARGET_DIR = target/debug
-else
-RUST_TARGET_DIR = target/release
-endif
-
-ifeq ($(uname_S),Windows)
-RUST_LIB = $(RUST_TARGET_DIR)/gitcore.lib
-else
-RUST_LIB = $(RUST_TARGET_DIR)/libgitcore.a
-endif
-
 GITLIBS = common-main.o $(LIB_FILE)
 EXTLIBS =
 
@@ -963,15 +942,6 @@ BASIC_LDFLAGS =
 ARFLAGS = rcs
 PTHREAD_CFLAGS =
 
-# Rust flags
-CARGO_ARGS =
-ifndef V
-CARGO_ARGS += --quiet
-endif
-ifndef DEBUG
-CARGO_ARGS += --release
-endif
-
 # For the 'sparse' target
 SPARSE_FLAGS ?= -std=gnu99 -D__STDC_NO_VLA__
 SP_EXTRA_FLAGS =
@@ -1333,9 +1303,7 @@ LIB_OBJS += urlmatch.o
 LIB_OBJS += usage.o
 LIB_OBJS += userdiff.o
 LIB_OBJS += utf8.o
-ifndef WITH_RUST
 LIB_OBJS += varint.o
-endif
 LIB_OBJS += version.o
 LIB_OBJS += versioncmp.o
 LIB_OBJS += walker.o
@@ -1534,9 +1502,6 @@ CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 
 UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
 
-RUST_SOURCES += src/lib.rs
-RUST_SOURCES += src/varint.rs
-
 GIT-VERSION-FILE: FORCE
 	@OLD=$$(cat $@ 2>/dev/null || :) && \
 	$(call version_gen,"$(shell pwd)",GIT-VERSION-FILE.in,$@) && \
@@ -1566,14 +1531,6 @@ endif
 ALL_CFLAGS = $(DEVELOPER_CFLAGS) $(CPPFLAGS) $(CFLAGS) $(CFLAGS_APPEND)
 ALL_LDFLAGS = $(LDFLAGS) $(LDFLAGS_APPEND)
 
-ifdef WITH_RUST
-BASIC_CFLAGS += -DWITH_RUST
-GITLIBS += $(RUST_LIB)
-ifeq ($(uname_S),Windows)
-EXTLIBS += -luserenv
-endif
-endif
-
 ifdef SANITIZE
 SANITIZERS := $(foreach flag,$(subst $(comma),$(space),$(SANITIZE)),$(flag))
 BASIC_CFLAGS += -fsanitize=$(SANITIZE) -fno-sanitize-recover=$(SANITIZE)
@@ -2963,12 +2920,6 @@ scalar$X: scalar.o GIT-LDFLAGS $(GITLIBS)
 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
 
-$(RUST_LIB): Cargo.toml $(RUST_SOURCES)
-	$(QUIET_CARGO)cargo build $(CARGO_ARGS)
-
-.PHONY: rust
-rust: $(RUST_LIB)
-
 export DEFAULT_EDITOR DEFAULT_PAGER
 
 Documentation/GIT-EXCLUDED-PROGRAMS: FORCE
diff --git a/shared.mak b/shared.mak
index 0e7492076e..5c7bc94785 100644
--- a/shared.mak
+++ b/shared.mak
@@ -56,7 +56,6 @@ ifndef V
 	QUIET_MKDIR_P_PARENT  = @echo '   ' MKDIR -p $(@D);
 
 ## Used in "Makefile"
-	QUIET_CARGO    = @echo '   ' CARGO $@;
 	QUIET_CC       = @echo '   ' CC $@;
 	QUIET_AR       = @echo '   ' AR $@;
 	QUIET_LINK     = @echo '   ' LINK $@;
-- 
gitgitgadget

