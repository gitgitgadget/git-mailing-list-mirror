Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BA73BBFB8
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 22:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780610626; cv=none; b=Ge62f/6TpCKaaeScL93kEzGhf030gXYsZWAgasJnbEwEGJliioMKxW+lry30VM8RrnAk5i9gWRlunGltPDoMYp6tzbyqZchExM8xPNqVk8SMO0VxWc5E+FcMlJp5u6SfFKz8CNyWT4l2W5WjUDXOoMtd4bkQT6xyEf5JLh5UavE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780610626; c=relaxed/simple;
	bh=jG2b4ykgF1mAUvf9iqaY796pyFvt/ZS7i1Tv8RQ4oUQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=amLcn+MRBNGvesgdDAkVWGJ4iVZEiXk1fXLR0iYgBbO9f7wJXZLhoumQKquehrfymfLbWS0Iiy3nOdq64uYERlSToR6mpqn9dZwj9DheXFdvEYRzy2eLbAwyoPjLfWrh6UXFvZ1AWH3JNCtcNdN7l2YMRoUCBff/L/Wtz9Op2wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USq9hm9Z; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USq9hm9Z"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7e6ec655c80so693487a34.0
        for <git@vger.kernel.org>; Thu, 04 Jun 2026 15:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780610624; x=1781215424; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHNFjD059GC0o7hXq4+uB+BytvdG3ACQFRNfX9ZRaC8=;
        b=USq9hm9ZkFW6ujBcuh9oz5nE4BpSb+/nd1PV40bPla8rp04QKNrIOOBVn/zBBIlZUr
         9PhqQUUJhs9y2FlBedvLQgIgZtlMbJidIbH9vq2IWqbIYBl/4Jv4DNvo7omVDgoRHKW8
         YO0V9O579fdYyR2iy1KUR3WLrMi05k7feka5WO1lG9CAxL/LGmE08858ABZGEGOa/5Eu
         blEVCv6XZoKggwPqAhjUh43r7t/5npFtDoxfwa4hsfjp0+UOZk6X3W7sSNhcl0HoTR3g
         WQzCHPaKOsACyUeJKyCVTnq5Fgdms8Ew3dLi0Nan13G0Vy3p8XTCV6IeELTYtjS3KZ9+
         hilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780610624; x=1781215424;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rHNFjD059GC0o7hXq4+uB+BytvdG3ACQFRNfX9ZRaC8=;
        b=M2/d+n5hmsWjUXAQ2I61GwgjjNryiiuuNJxDuj3Zfz7SeERAC3EW3IjvuI1WUjHprM
         jPjmkxapb4NDoK9TeFl9SC7b8jBV9ys+Pb4CtueF9QCFujoCdrgH9sCqPPbPE/fvbRG7
         BD6NtKyNGzAhEl/0kl909PtAk+RVth1gxXmLbb6aW6YPQdtQlB0KB4OWMXMPUUTkqSqe
         SxmydZBpdgoum/oG/q1GjZGaaXSj5H24hHB5GhZTRStAG8O9tJMAmeBFnpVjvOPwGQzl
         Bx1HB7HOE8k9pWqf5dXnfqbQKmv24mDWLUrwzd7agbVC7mtAvPVs41obyPbqHTyOdQlV
         RDIA==
X-Gm-Message-State: AOJu0YyIu//J74CX57CenPBKpN5RCopD4m2FMwIIFyoN9ifKdVBVrfgT
	C77G+W0ku8806ks9azJRHFFsvUEy3ckhh/dqd4BV73snKL3otYhvJl1c+qMWlg==
X-Gm-Gg: Acq92OF5XaPb6Jkn0VQskry/FDcjMlK65EB9Quv8cPtkab2MVceHAamx//YkNo9c8gT
	Wg1z49LO7x8l6Qm6HHWXzJ3/TxAhf3S5wFTexjdcOXswYCzoHZUB3Uh4U4T/P6gCho1sRxE9G7A
	CKDq6m7jZUUqCZYaxCDidzGSLJ0qX5GSjzgOJmAlAKcZ5o6lheN6wsyB91C0tvkEFZvM5caFa30
	BSF52j6ScJSVnIbATmb1Kh6F20wa02s9ald9r9D6i+c/LDMqmZzgNcXRTpdlq805HFz45VlWx5E
	xFxoTIyl2xQyrU5rc/DdwttwScdOfXw8q9C+zCPRl27BoOM1oIRooh2AL7iwyzaRrB/0zuuHb3G
	lWzxB1yUfnpSgDHZQ0YYUFPlpJLV4yf7mLq0pvviy33petWvk0CkWV/aH7hBAulTrWUCVpJRiqa
	Rl8Yy+zfG6fmC//t6Fb1EnM1JWpdh8/ZhmFgv4Eg==
X-Received: by 2002:a05:6820:178c:b0:69e:2b8:b6e4 with SMTP id 006d021491bc7-69e68cc42d6mr515667eaf.56.1780610624256;
        Thu, 04 Jun 2026 15:03:44 -0700 (PDT)
Received: from [127.0.0.1] ([52.173.163.129])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69e4620c6a3sm4356153eaf.1.2026.06.04.15.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 15:03:43 -0700 (PDT)
Message-Id: <pull.2314.v2.git.git.1780610623006.gitgitgadget@gmail.com>
In-Reply-To: <pull.2314.git.git.1780269406949.gitgitgadget@gmail.com>
References: <pull.2314.git.git.1780269406949.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 04 Jun 2026 22:03:42 +0000
Subject: [PATCH v2] Makefile: dedup archives in $(LIBS) so link recipes don't
 repeat them
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

A handful of link recipes listed archive files twice: once explicitly
via $(filter %.a,$^) and again implicitly through $(LIBS), which
expanded to $(filter-out %.o,$(GITLIBS)) $(EXTLIBS). On macOS the
linker warned about the duplicates:

  ld: warning: ignoring duplicate libraries: 'libgit.a', 'target/release/libgitcore.a'

Redefine $(LIBS) to list archive prerequisites from $^ first, then
the rest of the library list with those archives filtered out so each
appears only once.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    Makefile: drop duplicate %.a from test-helper link rule
    
    Redefine $(LIBS) to list archive prerequisites from $^ first, then the
    rest of the library list to avoid brittleness in the future.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2314%2FHaraldNordgren%2Fmakefile-test-helper-dedup-libs-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2314/HaraldNordgren/makefile-test-helper-dedup-libs-v2
Pull-Request: https://github.com/git/git/pull/2314

Range-diff vs v1:

 1:  f6166450b0 ! 1:  0ef442ea05 Makefile: drop duplicate %.a from link recipes
     @@ Metadata
      Author: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Commit message ##
     -    Makefile: drop duplicate %.a from link recipes
     +    Makefile: dedup archives in $(LIBS) so link recipes don't repeat them
      
     -    Three link recipes list archive files twice on the link line: once
     -    via $(filter %.a,$^) and again through $(LIBS), which expands to
     -    $(filter-out %.o,$(GITLIBS)) $(EXTLIBS). On macOS the linker warns
     -    about the duplicates:
     +    A handful of link recipes listed archive files twice: once explicitly
     +    via $(filter %.a,$^) and again implicitly through $(LIBS), which
     +    expanded to $(filter-out %.o,$(GITLIBS)) $(EXTLIBS). On macOS the
     +    linker warned about the duplicates:
      
            ld: warning: ignoring duplicate libraries: 'libgit.a', 'target/release/libgitcore.a'
      
     -    Drop the redundant filter from the test-helper, fuzz-program, and
     -    unit-test recipes so they match the pattern used by other link
     -    recipes in the file.
     +    Redefine $(LIBS) to list archive prerequisites from $^ first, then
     +    the rest of the library list with those archives filtered out so each
     +    appears only once.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Makefile ##
     +@@ Makefile: endif
     + #
     + # where we use it as a dependency. Since we also pull object files
     + # from the dependency list, that would make each entry appear twice.
     +-LIBS = $(filter-out %.o, $(GITLIBS)) $(EXTLIBS)
     ++# Archives from $^ come first, then the rest with those archives
     ++# filtered out so each appears only once.
     ++LIBS = $(filter %.a,$^) $(filter-out $(filter %.a,$^),$(filter-out %.o,$(GITLIBS)) $(EXTLIBS))
     + 
     + BASIC_CFLAGS += $(COMPAT_CFLAGS)
     + LIB_OBJS += $(COMPAT_OBJS)
      @@ Makefile: perf: all
       t/helper/test-tool$X: $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS)) $(UNIT_TEST_DIR)/test-lib.o
       


 Makefile | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index b31ecb0756..a828a66f28 100644
--- a/Makefile
+++ b/Makefile
@@ -2503,7 +2503,9 @@ endif
 #
 # where we use it as a dependency. Since we also pull object files
 # from the dependency list, that would make each entry appear twice.
-LIBS = $(filter-out %.o, $(GITLIBS)) $(EXTLIBS)
+# Archives from $^ come first, then the rest with those archives
+# filtered out so each appears only once.
+LIBS = $(filter %.a,$^) $(filter-out $(filter %.a,$^),$(filter-out %.o,$(GITLIBS)) $(EXTLIBS))
 
 BASIC_CFLAGS += $(COMPAT_CFLAGS)
 LIB_OBJS += $(COMPAT_OBJS)
@@ -3392,7 +3394,7 @@ perf: all
 t/helper/test-tool$X: $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS)) $(UNIT_TEST_DIR)/test-lib.o
 
 t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITLIBS)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(filter %.a,$^) $(LIBS)
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
 
 check-sha1:: t/helper/test-tool$X
 	t/helper/test-sha1.sh
@@ -4015,13 +4017,13 @@ fuzz-all: $(FUZZ_PROGRAMS)
 $(FUZZ_PROGRAMS): %: %.o oss-fuzz/dummy-cmd-main.o $(GITLIBS) GIT-LDFLAGS
 	$(QUIET_LINK)$(FUZZ_CXX) $(FUZZ_CXXFLAGS) -o $@ $(ALL_LDFLAGS) \
 		-Wl,--allow-multiple-definition \
-		$(filter %.o,$^) $(filter %.a,$^) $(LIBS) $(LIB_FUZZING_ENGINE)
+		$(filter %.o,$^) $(LIBS) $(LIB_FUZZING_ENGINE)
 
 $(UNIT_TEST_PROGS): $(UNIT_TEST_BIN)/%$X: $(UNIT_TEST_DIR)/%.o $(UNIT_TEST_OBJS) \
 	$(GITLIBS) GIT-LDFLAGS
 	$(call mkdir_p_parent_template)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
-		$(filter %.o,$^) $(filter %.a,$^) $(LIBS)
+		$(filter %.o,$^) $(LIBS)
 
 GIT-TEST-SUITES: FORCE
 	@FLAGS='$(CLAR_TEST_SUITES)'; \

base-commit: 9ac3f193c05c2237e2b14ebaa1149e9fc8a1abe0
-- 
gitgitgadget
