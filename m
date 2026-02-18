Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC02224FA
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 05:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771391655; cv=none; b=KqlenkVBJRvlL/CmhyGR0vlI1zdEhZHszY3F0psVjxFo+OrDyd1dZXFsaTzBbvofFEP2L0ztxmTddUcrMVIDimEmPj0LLpeE8Gnapez75YoQe2BroJSlieKRDEcG1m/qsYExez5bjR6/YFfagX8uHpvX+gxvzdLhKpi8mE/GD9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771391655; c=relaxed/simple;
	bh=WPhQJPgONLQebIsatkMUS1Dbgwo2IXbeHolEA7rQLww=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=WvKZ946nzN0BYjNfL9KkJ96VOaCLC/XahVKi0EME9+ZvLlq0knZ2jIizAP4zMEqfnSjpVTnzK4ruckhUsyqSqQXcAeCY+PLG08LfZ1TyQhg0/kde15nWEaml+vquhgHv2j+wVR950NH4d1LdN/XfBcHzj3Q3VsXlJqPGeEXO+90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W1NW70Sx; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1NW70Sx"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8cb38e6d164so680629685a.3
        for <git@vger.kernel.org>; Tue, 17 Feb 2026 21:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771391652; x=1771996452; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qaIhp0K2Zl62sLSE7kl0KCe9KyY6iIW1vf7F1xQc/iw=;
        b=W1NW70SxW+8jKhUV8ktcLyl+lugxdbUdRzph8oWetpTx9rNJe7Ulg/OIqVzUbv9vUW
         0BDKBHt8oFerpYp3HFcwYkd6q/g0oZD+Wxk3ejgEk+r2avz1ce4136KwdXHDsoNOQA9b
         D20tcvxZMwjO3+aBHlZsaudUZUKTWGrSWoa3uV9/zvs8iDyWp71n1DwJZBLJ3vt7AcCc
         HdZSkXqr1TQP8MPLa7g4jQ+vC377ixGoAtN2FEf8xX1aDY/0W6MZmDe6NuAGqv7YHldl
         dhsC0A5lkqrPdU0W7KvT9azrSLSPDv0jA5J/mf1JwBXU3KMPzSgkE0AZqVKSi3fczMQV
         PZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771391652; x=1771996452;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qaIhp0K2Zl62sLSE7kl0KCe9KyY6iIW1vf7F1xQc/iw=;
        b=XY3OTZ6pwiu5Lce3Tn8H3JR/8mAzoYJeZID/rjhSUSGloSRVltPD3h4NMLt1vv34iW
         Sx4ORXWOkzAKBbewrosXew5x+AsPwMgK74JDuDM5Ky+9L1jKDg0uNrepshOPknQEvaSE
         YhvpHeAS9OAKf2GH4ivIkTSbqTidzMIBR9CmuZB98ZmkvYZ5V1cIDVmJnOxlR/mK/rl/
         epHW/M5jfGElF5r9EkTj7AdvdtjM5Hy5PO1jv6dLl2nke4NrBmJh9Y59aDHW3tL4TLn7
         Nb2/zwmhlapjBzkm7f31ayJKAznqaArVBlrC9eHYv25PxDAcnXO/S/dANJT3jq7OVJMb
         MdBA==
X-Gm-Message-State: AOJu0YzzCYXg6Nw3bKa7OuSu9JVSI6mHPPPq6QaLDtEP423sqoaiQS1s
	HLrFlSb7Jxf+l6584tJNSCTWJbEQLgUjSkLyEsiWESnbU0mEvnjVJf1fhnq5pw==
X-Gm-Gg: AZuq6aJ2Nf2V95na2fyEujkiTKb5loppLLLtEziTty7Cxe1yCTr/ZCna8Z7HcCH3Gzw
	vwK5Y+Ycw23qGBPtUvJgoCCqckfs2Q9e7I6LFXwZnwOxqwTBH/D+ywvb6J7F5OtCiWm3Q/mwm2O
	aV2wZIYFDlESD1zYc8HfsJD+63cdnvm5tQnaZqpVhpW705Adff6K6XuuW4albOHN7pp0Fz0kRdS
	iJZMuHpcaqCudF5D9H5f1G7jzoKN7bjmTnqKWHjSSdw6V/nNxeYYSt69gPy45mEyOpMr0shzwd3
	KNPiAnbDb8x55NKi+YScvgRoRuKo28vbcFkbv/KvYV41NSLH+cOQN2XNJekU4DmpDLy23YhwD6n
	7laFkmY0iMWOT5YEHfqQVSRKckYU19E+7ph8hDXo1stttBP+N/6BkVagN6cwRWNRBv5laFlgapU
	XG6HZR9LQB5W7UcuMND06YQE1PTTo=
X-Received: by 2002:a05:620a:31a2:b0:8b2:7435:f5ef with SMTP id af79cd13be357-8cb4c014729mr1620118185a.41.1771391652164;
        Tue, 17 Feb 2026 21:14:12 -0800 (PST)
Received: from [127.0.0.1] ([135.232.177.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89949b3d543sm41832046d6.16.2026.02.17.21.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 21:14:11 -0800 (PST)
Message-Id: <pull.2046.v3.git.1771391650713.gitgitgadget@gmail.com>
In-Reply-To: <pull.2046.v2.git.1770775169908.gitgitgadget@gmail.com>
References: <pull.2046.v2.git.1770775169908.gitgitgadget@gmail.com>
From: "Koji Nakamaru via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Feb 2026 05:14:10 +0000
Subject: [PATCH v3] osxkeychain: define build targets in the top-level
 Makefile.
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
Cc: Junio C Hamano <gitster@pobox.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Koji Nakamaru <koji.nakamaru@gree.net>,
    Koji Nakamaru <koji.nakamaru@gree.net>

From: Koji Nakamaru <koji.nakamaru@gree.net>

The fix for git-credential-osxkeychain in 4580bcd235 (osxkeychain: avoid
incorrectly skipping store operation) introduced linkage with libgit.a,
and its Makefile was adjusted accordingly. However, the build fails as
of 864f55e190 because several macOS-specific refinements were applied to
the top-level Makefile and config.mak.uname, such as:

  - 363837afe7 (macOS: make Homebrew use configurable, 2025-12-24)
  - cee341e9dd (macOS: use iconv from Homebrew if needed and present,
    2025-12-24)
  - d281241518 (utf8.c: enable workaround for iconv under macOS 14/15,
    2026-01-12)

Since libgit.a and its corresponding header files depend on many flags
defined in the top-level Makefile, these flags must be consistently
defined when building git-credential-osxkeychain. Continuing to manually
adjust the git-credential-osxkeychain Makefile is cumbersome and
fragile.

Define the build targets for git-credential-osxkeychain in the top-level
Makefile and modify its local Makefile to simply rely on those targets.

Helped-by: Junio C Hamano <gitster@pobox.com>
Reported-by: D. Ben Knoble <ben.knoble@gmail.com>
Signed-off-by: Koji Nakamaru <koji.nakamaru@gree.net>
---
    osxkeychain: define build targets in the top-level Makefile.
    
    Changes since v2:
    
     * Squash the double spaces after "-C" into one white.
     * Add explicit mkdir -p contrib/credential/osxkeychain/.depend for
       older versions of clang.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2046%2FKojiNakamaru%2Ffix%2Fosxkeychain-makefile-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2046/KojiNakamaru/fix/osxkeychain-makefile-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2046

Range-diff vs v2:

 1:  8c5d75f0c6 ! 1:  25a66e1b7d osxkeychain: define build targets in the top-level Makefile.
     @@ Commit message
          Makefile and modify its local Makefile to simply rely on those targets.
      
          Helped-by: Junio C Hamano <gitster@pobox.com>
     +    Reported-by: D. Ben Knoble <ben.knoble@gmail.com>
          Signed-off-by: Koji Nakamaru <koji.nakamaru@gree.net>
      
       ## Makefile ##
     @@ Makefile: $(LIBGIT_HIDDEN_EXPORT): $(LIBGIT_PARTIAL_EXPORT)
      +		$(filter %.o,$^) $(LIB_FILE) $(EXTLIBS) -framework Security -framework CoreFoundation
      +
      +contrib/credential/osxkeychain/git-credential-osxkeychain.o: contrib/credential/osxkeychain/git-credential-osxkeychain.c GIT-CFLAGS
     ++	@mkdir -p contrib/credential/osxkeychain/.depend
      +	$(QUIET_LINK)$(CC) -o $@ -c $(dep_args) $(compdb_args) $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
      +
      +install-git-credential-osxkeychain: contrib/credential/osxkeychain/git-credential-osxkeychain
     @@ contrib/credential/osxkeychain/Makefile
      --include ../../../config.mak.autogen
      --include ../../../config.mak
      +git-credential-osxkeychain:
     -+	$(MAKE) -C  ../../.. contrib/credential/osxkeychain/git-credential-osxkeychain
     ++	$(MAKE) -C ../../.. contrib/credential/osxkeychain/git-credential-osxkeychain
       
      -ifdef ZLIB_NG
      -	BASIC_CFLAGS += -DHAVE_ZLIB_NG
     @@ contrib/credential/osxkeychain/Makefile
      -../../../libgit.a:
      -	cd ../../..; make libgit.a
      +install:
     -+	$(MAKE) -C  ../../.. install-git-credential-osxkeychain
     ++	$(MAKE) -C ../../.. install-git-credential-osxkeychain
       
       clean:
      -	$(RM) git-credential-osxkeychain git-credential-osxkeychain.o
     -+	$(MAKE) -C  ../../.. clean-git-credential-osxkeychain
     ++	$(MAKE) -C ../../.. clean-git-credential-osxkeychain
       
      -.PHONY: all install clean
      +.PHONY: all git-credential-osxkeychain install clean


 Makefile                                | 18 +++++++
 contrib/credential/osxkeychain/Makefile | 65 +++----------------------
 2 files changed, 24 insertions(+), 59 deletions(-)

diff --git a/Makefile b/Makefile
index 4ac44331ea..1c2019a4cb 100644
--- a/Makefile
+++ b/Makefile
@@ -4060,3 +4060,21 @@ $(LIBGIT_HIDDEN_EXPORT): $(LIBGIT_PARTIAL_EXPORT)
 
 contrib/libgit-sys/libgitpub.a: $(LIBGIT_HIDDEN_EXPORT)
 	$(AR) $(ARFLAGS) $@ $^
+
+contrib/credential/osxkeychain/git-credential-osxkeychain: contrib/credential/osxkeychain/git-credential-osxkeychain.o $(LIB_FILE) GIT-LDFLAGS
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
+		$(filter %.o,$^) $(LIB_FILE) $(EXTLIBS) -framework Security -framework CoreFoundation
+
+contrib/credential/osxkeychain/git-credential-osxkeychain.o: contrib/credential/osxkeychain/git-credential-osxkeychain.c GIT-CFLAGS
+	@mkdir -p contrib/credential/osxkeychain/.depend
+	$(QUIET_LINK)$(CC) -o $@ -c $(dep_args) $(compdb_args) $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
+
+install-git-credential-osxkeychain: contrib/credential/osxkeychain/git-credential-osxkeychain
+	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
+	$(INSTALL) $(INSTALL_STRIP) $< '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
+
+.PHONY: clean-git-credential-osxkeychain
+clean-git-credential-osxkeychain:
+	$(RM) \
+		contrib/credential/osxkeychain/git-credential-osxkeychain \
+		contrib/credential/osxkeychain/git-credential-osxkeychain.o
diff --git a/contrib/credential/osxkeychain/Makefile b/contrib/credential/osxkeychain/Makefile
index c68445b82d..219b0d7f49 100644
--- a/contrib/credential/osxkeychain/Makefile
+++ b/contrib/credential/osxkeychain/Makefile
@@ -1,66 +1,13 @@
 # The default target of this Makefile is...
 all:: git-credential-osxkeychain
 
-include ../../../config.mak.uname
--include ../../../config.mak.autogen
--include ../../../config.mak
+git-credential-osxkeychain:
+	$(MAKE) -C ../../.. contrib/credential/osxkeychain/git-credential-osxkeychain
 
-ifdef ZLIB_NG
-	BASIC_CFLAGS += -DHAVE_ZLIB_NG
-        ifdef ZLIB_NG_PATH
-		BASIC_CFLAGS += -I$(ZLIB_NG_PATH)/include
-		EXTLIBS += $(call libpath_template,$(ZLIB_NG_PATH)/$(lib))
-        endif
-	EXTLIBS += -lz-ng
-else
-        ifdef ZLIB_PATH
-		BASIC_CFLAGS += -I$(ZLIB_PATH)/include
-		EXTLIBS += $(call libpath_template,$(ZLIB_PATH)/$(lib))
-        endif
-	EXTLIBS += -lz
-endif
-ifndef NO_ICONV
-        ifdef NEEDS_LIBICONV
-                ifdef ICONVDIR
-			BASIC_CFLAGS += -I$(ICONVDIR)/include
-			ICONV_LINK = $(call libpath_template,$(ICONVDIR)/$(lib))
-                else
-			ICONV_LINK =
-                endif
-                ifdef NEEDS_LIBINTL_BEFORE_LIBICONV
-			ICONV_LINK += -lintl
-                endif
-		EXTLIBS += $(ICONV_LINK) -liconv
-        endif
-endif
-ifndef LIBC_CONTAINS_LIBINTL
-	EXTLIBS += -lintl
-endif
-
-prefix ?= /usr/local
-gitexecdir ?= $(prefix)/libexec/git-core
-
-CC ?= gcc
-CFLAGS ?= -g -O2 -Wall -I../../.. $(BASIC_CFLAGS)
-LDFLAGS ?= $(BASIC_LDFLAGS) $(EXTLIBS)
-INSTALL ?= install
-RM ?= rm -f
-
-%.o: %.c
-	$(CC) $(CFLAGS) $(CPPFLAGS) -o $@ -c $<
-
-git-credential-osxkeychain: git-credential-osxkeychain.o ../../../libgit.a
-	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS) \
-		-framework Security -framework CoreFoundation
-
-install: git-credential-osxkeychain
-	$(INSTALL) -d -m 755 $(DESTDIR)$(gitexecdir)
-	$(INSTALL) -m 755 $< $(DESTDIR)$(gitexecdir)
-
-../../../libgit.a:
-	cd ../../..; make libgit.a
+install:
+	$(MAKE) -C ../../.. install-git-credential-osxkeychain
 
 clean:
-	$(RM) git-credential-osxkeychain git-credential-osxkeychain.o
+	$(MAKE) -C ../../.. clean-git-credential-osxkeychain
 
-.PHONY: all install clean
+.PHONY: all git-credential-osxkeychain install clean

base-commit: 864f55e1906897b630333675a52874c0fec2a45c
-- 
gitgitgadget
