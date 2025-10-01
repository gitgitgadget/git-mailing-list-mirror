Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B87D2D3EC0
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 18:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759341756; cv=none; b=aGDf4kLXU175Zcoi1/o3WMJaXay+PnsW/zOuv17Xnqe79rPfe580h0LC77UbE1jyBcKBjRKm+R8ipcBPns9gYSK898L2l8nu8W4WN7A6+Pcctx1ZBC+U61y12AVA9aAKaxDWW2/P1THYzuO8du1ctmm29XwTGGwRMGP0dYHDAZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759341756; c=relaxed/simple;
	bh=xktpDG950DbCUzH62DQ5d4KJSacTKik6bBbJUlHlWX8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=cXvCR3Xla1oAvHbe0PlspKngR/avO+aK85HoiANGITZwD7mnkZc9Lo8i2vn0WeBnlkZcGeReeQo6NujgPGyOGGphAwoQK3xc33WPJ7ttqY1hhqqRZpnUffWo9DYFO8um1k4SB5f3PW9tVJwMUosoU1BUhU1lI6jJrUBmJ0DmuK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQvsaU3P; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQvsaU3P"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-42d8a0f09f6so878845ab.3
        for <git@vger.kernel.org>; Wed, 01 Oct 2025 11:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759341753; x=1759946553; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pw/SHLaGIEqGXKq2NxmEcGcEyUX44kBF5xX/JtkB57k=;
        b=PQvsaU3P3T2oK7NFHA0exP8whXVuJAtGz/fF1QRi+RyANmVRNNVmbV05G2P0UPSWWt
         bOgmN58fOaGXeqzWd6JOPY+uUZOCeM8H+EoyLHEmWsVv7YO0vcx41NIkTpJ0vT4fZpH/
         oKXxLwcR/XYBiQ8Zot63v2EERP0+6FqiWfx+6Yv3ZCZa2pJirt4SyhyNfU9lHWxZ5bC3
         nnP4fQPk+GJ37Zcdoq2x0QOrUU0e9iodd0QOulVk4eaTEo+Vh3qfgQX/Ax7b9rzymXcc
         3IQqvKpw8Ty7LkeYv1T6h6lfnJhpKyO1X+wWDN3upr7I1vr+TN/Z/vetrVP7rdI67Edv
         ZcwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759341753; x=1759946553;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pw/SHLaGIEqGXKq2NxmEcGcEyUX44kBF5xX/JtkB57k=;
        b=Z1hl14wUpxRQbpJcSpulSjrqkihK6QB2v6btvZvtHjpmtqdNkYlauz324/2vhlEjuM
         IupaljJ9RVrY6Ga1AZfrW3GsX4/tz+wP9Su94pnJwjBotHgtFtY2RCcxCfm6rhhWQ0hV
         Q1dVt7LKFlDBlKakTpWAGbN5XoOBlPIDNHY6uk4fYT4Yukh17GZOWKiquylq2AjbZu1U
         c+KNxEaAsQNTxHBLr7DRgc63Bel70QiQ4elW9H8ioe1YFctYmQ+t3Wc51dqH4G/dFlY/
         9O4iEjCrmI4TOB+ar8TAUOPHPxCnZIWYbWIsBTkyJ12u5nol7UD8MO9n5Hq7OfqTz/dK
         oefw==
X-Gm-Message-State: AOJu0YyWpvOB8SLLSSoFzpvyqUlbG7vJZoP6EAWUnq+vWBiJkivrET9G
	WD0bBvzW7Dc2h1yy79P/0ghcA8bhLVcQubxb5+dCEEDSt/bsQm5Uetaf9RxqDA==
X-Gm-Gg: ASbGncuEUdBU3BJHzP4y7iwo10FUYxtYKNIpHXsAlOpsye774SpqUtYJqIsFYwrLS6O
	2XQP9B+CPPyuHI7dx2LG2L0vBqDokcJ3LIvo6ZsLPPFRGCnEjOvMWU1FssSalHkK8snsOG/N1Yh
	ldKRNgJCP1a6I9Mh2I07r3X/4KUvi+F1Zd09AuwblHpZ4Yddf646rJ3spA+t+ZfSJipZZPtQvtZ
	lzUvmXCdwfb5H8ILDzFEjR5lg5K6A1GIzy/owxFiTpP0ECawyg+jPD8wTf/eo6nJhIvdw/d2H8O
	ly4rhfx2lB/TZzU2grLrMoIPddoSzmEW4WMuTWb1HfFKprMOz58Tr1pzYjQy9nOq31THBlHFguw
	yooKNdixcNggK4AlEBlI2ZvJGhMoi/RXqdjVvy63FuBWuMu/nkQ==
X-Google-Smtp-Source: AGHT+IHvRuKnholFeog2dx7R08uquATCzPD3SvHDvysG4aaYMAm0mAKFH9/pt2CKA4a4+bD8lK65BA==
X-Received: by 2002:a05:6e02:178b:b0:42d:86dc:5425 with SMTP id e9e14a558f8ab-42d86dc56femr32683825ab.6.1759341752619;
        Wed, 01 Oct 2025 11:02:32 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.176.149])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42d8b1f3992sm1231095ab.6.2025.10.01.11.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 11:02:32 -0700 (PDT)
Message-Id: <28e7fd27b632eeb681e7b9af4de2d18cd327be2a.1759341748.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2065.git.git.1759341748.gitgitgadget@gmail.com>
References: <pull.2065.git.git.1759341748.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 01 Oct 2025 18:02:27 +0000
Subject: [PATCH 2/3] make: delete XDIFF_LIB, add xdiff to LIB_OBJS
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

In a future patch series the 'xdiff' Rust crate will be added. Delete
the creation of the static library file for xdiff to avoid a name
conflict. This also moves toward the goal of Rust only needing to link
against libgit.a.

Changes to Meson are not required as the xdiff library is already
included in Meson's libgit.a.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 Makefile | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/Makefile b/Makefile
index e8fad803be..d89ba03286 100644
--- a/Makefile
+++ b/Makefile
@@ -918,7 +918,6 @@ export PYTHON_PATH
 TEST_SHELL_PATH = $(SHELL_PATH)
 
 LIB_FILE = libgit.a
-XDIFF_LIB = xdiff/lib.a
 REFTABLE_LIB = reftable/libreftable.a
 
 GENERATED_H += command-list.h
@@ -1397,8 +1396,7 @@ XDIFF_OBJS += xdiff/xmerge.o
 XDIFF_OBJS += xdiff/xpatience.o
 XDIFF_OBJS += xdiff/xprepare.o
 XDIFF_OBJS += xdiff/xutils.o
-.PHONY: xdiff-objs
-xdiff-objs: $(XDIFF_OBJS)
+LIB_OBJS += $(XDIFF_OBJS)
 
 REFTABLE_OBJS += reftable/basics.o
 REFTABLE_OBJS += reftable/error.o
@@ -1414,8 +1412,8 @@ REFTABLE_OBJS += reftable/table.o
 REFTABLE_OBJS += reftable/tree.o
 REFTABLE_OBJS += reftable/writer.o
 
-# xdiff and reftable libs may in turn depend on what is in libgit.a
-GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(LIB_FILE)
+# reftable lib may in turn depend on what is in libgit.a
+GITLIBS = common-main.o $(LIB_FILE) $(REFTABLE_LIB) $(LIB_FILE)
 EXTLIBS =
 
 GIT_USER_AGENT = git/$(GIT_VERSION)
@@ -2767,7 +2765,6 @@ OBJECTS += $(GIT_OBJS)
 OBJECTS += $(SCALAR_OBJS)
 OBJECTS += $(PROGRAM_OBJS)
 OBJECTS += $(TEST_OBJS)
-OBJECTS += $(XDIFF_OBJS)
 OBJECTS += $(FUZZ_OBJS)
 OBJECTS += $(REFTABLE_OBJS) $(REFTABLE_TEST_OBJS)
 OBJECTS += $(UNIT_TEST_OBJS)
@@ -2921,9 +2918,6 @@ scalar$X: scalar.o GIT-LDFLAGS $(GITLIBS)
 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
 
-$(XDIFF_LIB): $(XDIFF_OBJS)
-	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
-
 $(REFTABLE_LIB): $(REFTABLE_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
 
@@ -3765,7 +3759,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) git.rc git.res
 	$(RM) $(OBJECTS)
 	$(RM) headless-git.o
-	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB)
+	$(RM) $(LIB_FILE) $(REFTABLE_LIB)
 	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) $(OTHER_PROGRAMS)
 	$(RM) $(TEST_PROGRAMS)
 	$(RM) $(FUZZ_PROGRAMS)
@@ -3959,7 +3953,6 @@ endif
 LIBGIT_PUB_OBJS += contrib/libgit-sys/public_symbol_export.o
 LIBGIT_PUB_OBJS += libgit.a
 LIBGIT_PUB_OBJS += reftable/libreftable.a
-LIBGIT_PUB_OBJS += xdiff/lib.a
 
 LIBGIT_PARTIAL_EXPORT = contrib/libgit-sys/partial_symbol_export.o
 
-- 
gitgitgadget

