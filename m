Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1D434CDE
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 17:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728667793; cv=none; b=EvMg1c/Ut4ypcAZFTiSvKdgj25X1Gv86VPGeuXTVGBO54rUkcQmBpaUKNsD0qOjA23yijfQxlA/DPWfUvaPWLUd5lXxHNjYdDu/4NbCTy/tzRtDf+Or+Z9fHk03drZXy96Yl/4gtPL8EzLZAv4Uv1Dzy/e7yZzcWMv6jAU2R5lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728667793; c=relaxed/simple;
	bh=0PGDvaMff2BSz3QWrumbSMP3mVK68WqpQ0PaXcVusIc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lGkuemQhwbVRIiwNYRC9Xi+1AA52xgF4uvAoPSojaYtIc//n+ie9NQWeD1CIKUV27Q/b2BP8xNdG2vKK6CAscPtfj9gFIeZI9D7k3TtX2k+B/yakjfCxt/AMHGWWQJ971VhLZjhCd9p054vbpHu6gdOHI4fxGw/yXjNcBI0o6+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crNsc+3r; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crNsc+3r"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a993f6916daso387979866b.1
        for <git@vger.kernel.org>; Fri, 11 Oct 2024 10:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728667789; x=1729272589; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+TXp7ZePseGFX/sq+oNYYUxUTVmQUBGctlemPNs5BX0=;
        b=crNsc+3rJVUA8Gxap5oGzKvxzW3hiRLCNulVO3JVdNNd3LXhw/vOkCdnr4FHZ60GXm
         LLqkyWlUWlf43AWcHylutNYOwrFUFCl/4FdHIyLFayMgjkM3jwpQlJBXwKeFE/lM05Ml
         I2X/Mu9+vEkAk1gynAnrU/NHLhtFaYxHN59Ra0lw229wZo26EBnaDp8UOj/lJvf/qZRa
         3It3cGtvpz50u5NLUHp5LF2yjUHXXBNbzDzdJAPVBRe9Sl4jVTV83jqtoKbeX8kzR7PC
         KZK8Uy7YiYTmoABh/j6itdyOdXYbeYOgLRQj1wfWU21QkEUzHIpJreZ+MoFtgycO4eaM
         hKvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728667789; x=1729272589;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+TXp7ZePseGFX/sq+oNYYUxUTVmQUBGctlemPNs5BX0=;
        b=GqVRc91plFI9w+5mhPnqGC3iqvIf3Av4DKmtmjWCXAEA5BV6D36Ui31MJR8LDs1YZJ
         eiwwKbIwenc/ILj/NLSUOgOsnKonNqziIQ++13UME04UI9IKD0g72igxkVzyjdOVdf4z
         2CgRsL+hmQbMhxAXNvz6K2pb+h1NwOdcuG4U+vKqoM5+uuovTfRKuIrsNcRCTeK0GU3L
         cKBA+jtt3uTfEkZrSbub+G833QaX2C1DOW23mPWo4WGbgIjAFAfvIO9/3H3EnPjBpSko
         F+QFZpJqk8hlOgz8ZDz7AfoPu+M0mA6hVHGAhlurQqhBgpd67HlbHG5FOPhKJCPoJ+PB
         Kt5g==
X-Gm-Message-State: AOJu0YwuILBN7p1mxTFQ9M27DbhcHiDEOrt301MdrJkAzd8Fo7GaKFSg
	4fF01zDeLKqfgRFP+Kmi4io1NdvznLN/JTTvk+mpzeZ3H3keNH8X1jSQFg==
X-Google-Smtp-Source: AGHT+IFYE7T0AhrfBdVjDoiz2xi6wZImRTTUpicCTIR5ljuSzkx+d3nvHh5mKwhBS1c3RNawO2FYPA==
X-Received: by 2002:a17:907:3dac:b0:a99:371e:7a91 with SMTP id a640c23a62f3a-a99b9585a78mr231339066b.52.1728667788891;
        Fri, 11 Oct 2024 10:29:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7f5c4c3sm234119766b.95.2024.10.11.10.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 10:29:48 -0700 (PDT)
Message-Id: <pull.1810.v2.git.1728667787227.gitgitgadget@gmail.com>
In-Reply-To: <pull.1810.git.1728323033680.gitgitgadget@gmail.com>
References: <pull.1810.git.1728323033680.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 11 Oct 2024 17:29:47 +0000
Subject: [PATCH v2] Makefile: fix dependency for $(UNIT_TEST_DIR)/clar/clar.o
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
    Philippe Blain <levraiphilippeblain@gmail.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>

From: Philippe Blain <levraiphilippeblain@gmail.com>

The clar source file '$(UNIT_TEST_DIR)/clar/clar.c' includes the
generated 'clar.suite', but this dependency is not taken into account by
our Makefile, so that it is possible for a parallel build to fail if
Make tries to build 'clar.o' before 'clar.suite' is generated.

Correctly specify the dependency.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
    Makefile: fix dependency for $(UNIT_TEST_DIR)/clar/clar.o
    
    v2: Compared to v1, I just moved the new line one line up to keep the
    dependencies of $(CLAR_TEST_OBJS) together.
    
    Regarding what I wrote in [1], I took a closer look and actually
    clar.suite is already added to GENERATED_H. The issue really is that for
    generated headers, the dependency must be specified manually. This is
    the case for other generated headers (command-list.h, etc). So my
    initial approach is correct.
    
    [1]
    https://lore.kernel.org/git/C05B01E0-5007-4FB9-94CD-CBE74E79F9B7@gmail.com/
    
    v1: Hi Patrick,
    
    I tried building v2.47.0 and stumbled onto this small issue. It
    reproduces for me from a fresh clone on my old 2009 Mac with make -j -l
    2.5, it's a little curious that no one ran into this yet.
    
    I found it best to declare the dependency directly on clar.o, instead of
    adjusting the dependencies of CLAR_TEST_OBJS on the line above, since it
    is really only this clar.c that includes clar.suite

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1810%2Fphil-blain%2Fclar-build-dep-fix-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1810/phil-blain/clar-build-dep-fix-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1810

Range-diff vs v1:

 1:  42ae65c5f82 ! 1:  f20c8a0f57b Makefile: fix dependency for $(UNIT_TEST_DIR)/clar/clar.o
     @@ Commit message
      
       ## Makefile ##
      @@ Makefile: $(UNIT_TEST_DIR)/clar-decls.h: $(patsubst %,$(UNIT_TEST_DIR)/%.c,$(CLAR_TEST_SUI
     + 	done >$@
       $(UNIT_TEST_DIR)/clar.suite: $(UNIT_TEST_DIR)/clar-decls.h
       	$(QUIET_GEN)awk -f $(UNIT_TEST_DIR)/clar-generate.awk $< >$(UNIT_TEST_DIR)/clar.suite
     - $(CLAR_TEST_OBJS): $(UNIT_TEST_DIR)/clar-decls.h
      +$(UNIT_TEST_DIR)/clar/clar.o: $(UNIT_TEST_DIR)/clar.suite
     + $(CLAR_TEST_OBJS): $(UNIT_TEST_DIR)/clar-decls.h
       $(CLAR_TEST_OBJS): EXTRA_CPPFLAGS = -I$(UNIT_TEST_DIR)
       $(CLAR_TEST_PROG): $(UNIT_TEST_DIR)/clar.suite $(CLAR_TEST_OBJS) $(GITLIBS) GIT-LDFLAGS
     - 	$(call mkdir_p_parent_template)


 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 2dde1fd2b8b..76926537ccd 100644
--- a/Makefile
+++ b/Makefile
@@ -3910,6 +3910,7 @@ $(UNIT_TEST_DIR)/clar-decls.h: $(patsubst %,$(UNIT_TEST_DIR)/%.c,$(CLAR_TEST_SUI
 	done >$@
 $(UNIT_TEST_DIR)/clar.suite: $(UNIT_TEST_DIR)/clar-decls.h
 	$(QUIET_GEN)awk -f $(UNIT_TEST_DIR)/clar-generate.awk $< >$(UNIT_TEST_DIR)/clar.suite
+$(UNIT_TEST_DIR)/clar/clar.o: $(UNIT_TEST_DIR)/clar.suite
 $(CLAR_TEST_OBJS): $(UNIT_TEST_DIR)/clar-decls.h
 $(CLAR_TEST_OBJS): EXTRA_CPPFLAGS = -I$(UNIT_TEST_DIR)
 $(CLAR_TEST_PROG): $(UNIT_TEST_DIR)/clar.suite $(CLAR_TEST_OBJS) $(GITLIBS) GIT-LDFLAGS

base-commit: 777489f9e09c8d0dd6b12f9d90de6376330577a2
-- 
gitgitgadget
