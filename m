Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 857C81F97E
	for <e@80x24.org>; Sat, 13 Oct 2018 00:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbeJMIdt (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Oct 2018 04:33:49 -0400
Received: from mail-it1-f202.google.com ([209.85.166.202]:57206 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbeJMIds (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Oct 2018 04:33:48 -0400
Received: by mail-it1-f202.google.com with SMTP id f18so15010927itk.6
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 17:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GOTqwL2Ajx/3q8IaaiY9Tv/8YHBWHnENX1ekzD/2PRM=;
        b=jBQsIrUJ6eZ1+XHbIyctdyDZsx44wI/f7058rXn4tKhYF3r0A1tqUy5jwMCzJmTLot
         IJnJkEMEu5W3jIlXfNjLWgespYN+uNzQGDiYEvIp2uVF8GVfRLf4lej9f6JoVr+Nh+FF
         DAd9vKfTRn+/c/dxrWCa790m8zrJMOAPfKGT0YeOOZoo4J/ri9HQNGNbqcEosxd2O3y6
         i/wAgqKaPR/olMnRhWtRx1JbknAd/2nng2fjdtadKei7zbgZ8VwFj92oxStF4tRxcpQI
         TxueFsuVlms7KQ1ZtDhecL+eOrMYvwnkB4NZbiGdMS1v+Nh38o/kJNf51aZA5gbC+QPW
         ZZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GOTqwL2Ajx/3q8IaaiY9Tv/8YHBWHnENX1ekzD/2PRM=;
        b=foIR9uVPio5c2USvZqcWg+F0ooeukDVpoN1j7PRiw2rGvSyNcJX/BfMsBBNjcch6O4
         3/v+3Eyb5Z4duL/sQSFjwxGaYOotXtOyO2tOK+Ng0py1ANxFEF4IF0iZTc/5M1tEUqla
         tt+moVxmNhGOIrQvWeFWB3/feNFuwB/C0XFAPYO0k2nEzVem1QPn4+UEXd5tb4X0P5ID
         GMHaAe1ohLn4Zu0+on43GgSFKjrZZa+w86rBLuesLay62/VRl6LLeuYtqDdTp7KnNvsn
         AlpyY5eFI04bgp2VDVoKLo+1t7iGIKxUYRJpK6OLLN6Ogy+EFu/DmJhKrET2T7jd0OaZ
         TgQg==
X-Gm-Message-State: ABuFfogAeDlLgTTYU/iau1eGPIcNLMm7p+Rfvm/5Hc91w1aGpgxrjfTv
        NOD8WkNwFbKRcRf8sEGGp41ov0jCVP0so5Xf6po/IXmCMAI3ya9aR8RTJ6Rg1/oKYABframgzyl
        ik205uEEb5Xt0/wDbK97sjoANOTG2R+cWKXfxSMPNrv/OB2P2b6JIVYdQRkKiZGE=
X-Google-Smtp-Source: ACcGV60CKMRxQm5SAEJrlg9QyHQJHZI15dKdGg4jqn3DZBaCRy+0jkjqZZAXiuamyyHVyRVN5AM7eoxFhqT7SQ==
X-Received: by 2002:a24:dd45:: with SMTP id t66-v6mr9818977itf.5.1539392325407;
 Fri, 12 Oct 2018 17:58:45 -0700 (PDT)
Date:   Fri, 12 Oct 2018 17:58:40 -0700
In-Reply-To: <cover.1539391439.git.steadmon@google.com>
Message-Id: <446d8081b1a05250e69ae56a4fa41923039c69f6.1539391439.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1538693039.git.steadmon@google.com> <cover.1539391439.git.steadmon@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v2 1/2] fuzz: Add basic fuzz testing target.
From:   steadmon@google.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Josh Steadmon <steadmon@google.com>

fuzz-pack-headers.c provides a fuzzing entry point compatible with
libFuzzer (and possibly other fuzzing engines).

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 .gitignore          |  2 ++
 Makefile            | 32 ++++++++++++++++++++++++++++++++
 fuzz-pack-headers.c | 14 ++++++++++++++
 3 files changed, 48 insertions(+)
 create mode 100644 fuzz-pack-headers.c

diff --git a/.gitignore b/.gitignore
index 9d1363a1eb..87a28b3115 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,3 +1,5 @@
+/fuzz_corpora
+/fuzz-pack-headers
 /GIT-BUILD-OPTIONS
 /GIT-CFLAGS
 /GIT-LDFLAGS
diff --git a/Makefile b/Makefile
index 13e1c52478..7f5a19b8ab 100644
--- a/Makefile
+++ b/Makefile
@@ -590,6 +590,8 @@ XDIFF_OBJS =
 VCSSVN_OBJS =
 GENERATED_H =
 EXTRA_CPPFLAGS =
+FUZZ_OBJS =
+FUZZ_PROGRAMS =
 LIB_OBJS =
 PROGRAM_OBJS =
 PROGRAMS =
@@ -682,6 +684,13 @@ SCRIPTS = $(SCRIPT_SH_INS) \
 
 ETAGS_TARGET = TAGS
 
+FUZZ_OBJS += fuzz-pack-headers.o
+
+# Always build fuzz objects even if not testing, to prevent bit-rot.
+all:: $(FUZZ_OBJS)
+
+FUZZ_PROGRAMS += $(patsubst %.o,%,$(FUZZ_OBJS))
+
 # Empty...
 EXTRA_PROGRAMS =
 
@@ -2250,6 +2259,7 @@ TEST_OBJS := $(patsubst %$X,%.o,$(TEST_PROGRAMS)) $(patsubst %,t/helper/%,$(TEST
 OBJECTS := $(LIB_OBJS) $(BUILTIN_OBJS) $(PROGRAM_OBJS) $(TEST_OBJS) \
 	$(XDIFF_OBJS) \
 	$(VCSSVN_OBJS) \
+	$(FUZZ_OBJS) \
 	common-main.o \
 	git.o
 ifndef NO_CURL
@@ -2937,6 +2947,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(VCSSVN_LIB)
 	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) git$X
 	$(RM) $(TEST_PROGRAMS) $(NO_INSTALL)
+	$(RM) $(FUZZ_PROGRAMS)
 	$(RM) -r bin-wrappers $(dep_dirs)
 	$(RM) -r po/build/
 	$(RM) *.pyc *.pyo */*.pyc */*.pyo command-list.h $(ETAGS_TARGET) tags cscope*
@@ -3061,3 +3072,24 @@ cover_db: coverage-report
 cover_db_html: cover_db
 	cover -report html -outputdir cover_db_html cover_db
 
+
+### Fuzz testing
+#
+# Building fuzz targets generally requires a special set of compiler flags that
+# are not necessarily appropriate for general builds, and that vary greatly
+# depending on the compiler version used.
+#
+# An example command to build against libFuzzer from LLVM 4.0.0:
+#
+# make CC=clang CXX=clang++ \
+#      CFLAGS="-fsanitize-coverage=trace-pc-guard -fsanitize=address" \
+#      LIB_FUZZING_ENGINE=/usr/lib/llvm-4.0/lib/libFuzzer.a \
+#      fuzz-all
+#
+.PHONY: fuzz-all
+
+$(FUZZ_PROGRAMS): all
+	$(QUIET_LINK)$(CXX) $(CFLAGS) $(LIB_OBJS) $(BUILTIN_OBJS) \
+		$(XDIFF_OBJS) $(EXTLIBS) git.o $@.o $(LIB_FUZZING_ENGINE) -o $@
+
+fuzz-all: $(FUZZ_PROGRAMS)
diff --git a/fuzz-pack-headers.c b/fuzz-pack-headers.c
new file mode 100644
index 0000000000..99da1d0fd3
--- /dev/null
+++ b/fuzz-pack-headers.c
@@ -0,0 +1,14 @@
+#include "packfile.h"
+
+int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
+
+int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
+{
+	enum object_type type;
+	unsigned long len;
+
+	unpack_object_header_buffer((const unsigned char *)data,
+				    (unsigned long)size, &type, &len);
+
+	return 0;
+}
-- 
2.19.0.605.g01d371f741-goog

