Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683F0374E67
	for <git@vger.kernel.org>; Sun, 31 May 2026 23:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780269414; cv=none; b=so6icIKiL96qk6u0f4uKnWPCTqFevRhBxqtIQq85EzhNamFidixl4y1MDjVFn3tVYAQrpZHW2wM7Qu3v6J53szdgOxK6Dwh0tyfmqYON9O180ezFtxHhu+pfT5dudy9Q8VRfCPp3OFhwR6YnJj5dz05GyziwrRTD9Hszt0UuwCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780269414; c=relaxed/simple;
	bh=/hfLfnoTBH6LwPl2qxfCohw8YrmoMG2qqpDbGYxQCzc=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=fbozUQM4MLfMI23c1nceLOXR2Jbql/fu1LfAoMB1kGPaPejO8zUJ4cHsdtPTYejBQUGLCJzPNuVur6Fd40PXJG+RvKFrw5PVJTh5nRdjQJFujwo7tmk534f2wl3NWi35nCBl0Jyv9FXUKqCkEgjNawxqd+7ySKSsEUI1N8emCZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6sWfxR3; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6sWfxR3"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51758478240so483951cf.2
        for <git@vger.kernel.org>; Sun, 31 May 2026 16:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780269408; x=1780874208; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9KqQOxr3E3qMEcoFX5UD2Nf6VwFgoB4GQrjpVgpCi7g=;
        b=K6sWfxR3NFM4jUqZmKakjpNefkP6pCFbi/0xQ+Jlwg5ssTiKquqluENN5Uj/8KxiSo
         g2TTa754hrs51uNKgFhTbktMxLKE8OU/48d+CnoFx9UFPCuA/SQ5e7Br3aBYNQmhaeUw
         48nEwv6Bv66PRTIJMXvTyBZYAPeseU+P3MKDkRlxPEX+65yr951955HrUZPpMQxcVjAR
         zO2CKpxVHk9pl5RyINRZbAHHopdQjOGptNle6HgbYYlvLlpaFsYVHnGR+GXw7wFnbVKf
         7Bq69R4JcwWK/Ta9QhJNVdw50TW3AQ+jV2kZ9IejK7lwoMx+wNfxJnEqu29wOiWAx4PO
         rhig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780269408; x=1780874208;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9KqQOxr3E3qMEcoFX5UD2Nf6VwFgoB4GQrjpVgpCi7g=;
        b=WbQIUQGxta5MJgVe2BXdYCY4IgWaE4KB9rDZHGvqo8uVf9odE3rdEh7q6u8PYF/4Zt
         zH6RX45F8OH710HO8DQmcXgZGIgqe6HbmjrSr0dyrHF5/HegK/IyQMFTTZZUDZJG+MbP
         /5JIJ+wVCNGMlb3UpHX+HbOvpi+VXWlI73hyvcssk2Eun3eg/5IvkxDa6VZg37s3QXB2
         1ug6tZMzDy+6qGzjIoUmqiTyYUJI4lUCzAUst9MsNtnOqZoHHjQF8uu4bVyY6fm+SOqD
         WEfs7jmS5ij3lHJ4MqVEl9IkQzv92/6LV61c6UzsgSNVQW3CJfTeYiMZjxBUgdm8sqNh
         Sx4w==
X-Gm-Message-State: AOJu0YyvxGiCAinB/d53lQGKbr5xa1CYXS0jx+E7wXuwuswI6OzOeyyr
	DcoEjMsaZDYipRFjFaF20Av0qFaFiZT3TIVMVlyVNypQ+FVaRAE+F74E1z7Oo5R3
X-Gm-Gg: Acq92OETAN8Q/QLPMrDHdgl2UeG5UR4Bd7djjld0Ol27WuVyruyQ7t3Flxw/OCi+IFf
	wfVGyv1AgwLT93TMuOIXBaKWvJhBVThSZfepF0OoPIapV1cjLksnTw4bJvbkAjfR80assZhzlpi
	kzIDg543hc+LZ2vxL7NiVMlNKb1EDZXth+4JXehQn3GW67MeekxK+gYJbE7+rfFMgkobbV2Ju7j
	RQhB3fv+p52aFpQ+OCMD7I8Y1dRvArBm9zRMJpW5T0FkU/qFPwfnEejQKL//X4NL/T9A6OnPGDn
	yL0muLjfO7n63wMDCppv6kQBX2SQ0bFG+pC81jEp8yNk2N+AEV3YNXYouKhqCdIn8hH92ckOTd2
	flZsYBnnXdAEfkVItGEOzeLtXMiIa+lmco1s782IH41OKR3P0YwaWWPxvlCEYeMJGcKLaOid2Pi
	W9VcAGyYongmaR8GYMex/9edLsdapQmDdW04OSTv8=
X-Received: by 2002:a05:622a:4c0b:b0:516:d955:ea4 with SMTP id d75a77b69052e-5173a712bfbmr137233291cf.17.1780269408116;
        Sun, 31 May 2026 16:16:48 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.155.179])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51741b06870sm41058511cf.4.2026.05.31.16.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 16:16:47 -0700 (PDT)
Message-Id: <pull.2314.git.git.1780269406949.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 31 May 2026 23:16:46 +0000
Subject: [PATCH] Makefile: drop duplicate %.a from link recipes
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

Three link recipes list archive files twice on the link line: once
via $(filter %.a,$^) and again through $(LIBS), which expands to
$(filter-out %.o,$(GITLIBS)) $(EXTLIBS). On macOS the linker warns
about the duplicates:

  ld: warning: ignoring duplicate libraries: 'libgit.a', 'target/release/libgitcore.a'

Drop the redundant filter from the test-helper, fuzz-program, and
unit-test recipes so they match the pattern used by other link
recipes in the file.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    Makefile: drop duplicate %.a from test-helper link rule

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2314%2FHaraldNordgren%2Fmakefile-test-helper-dedup-libs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2314/HaraldNordgren/makefile-test-helper-dedup-libs-v1
Pull-Request: https://github.com/git/git/pull/2314

 Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index b31ecb0756..309d1d1e74 100644
--- a/Makefile
+++ b/Makefile
@@ -3392,7 +3392,7 @@ perf: all
 t/helper/test-tool$X: $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS)) $(UNIT_TEST_DIR)/test-lib.o
 
 t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITLIBS)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(filter %.a,$^) $(LIBS)
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
 
 check-sha1:: t/helper/test-tool$X
 	t/helper/test-sha1.sh
@@ -4015,13 +4015,13 @@ fuzz-all: $(FUZZ_PROGRAMS)
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

base-commit: 1666c1265231b0bc5f613fbbf3f0a9896cdef76e
-- 
gitgitgadget
