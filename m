Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A831D6DCE
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 17:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728323039; cv=none; b=stb8AXRhiM7QhX4xMQoifimzE1Dvb4vC0WISt9m9shIWPuPFS7ndT/e8BvwbR2dUwZOS7Ij1kBV/qqA2YNUQOmhc+bZit876vGTmkkrJKE2ibyQxvVmr0jWzKdjHioN4Ucm4GkImteguYB1NzBU9I8/IiHC4GHDahKNtoIO0MIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728323039; c=relaxed/simple;
	bh=9hckLfA/Tk8eLTbkK/qtW59LWZMgMisZwECFeyMxl9s=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=TMmZ0QUJ4JxjW6Fh11Ax1PMiIpaJ2YyyknNx9MgMkmDy/pTU3DmZ/DHF+wMKJ+T+EZpeqEx3jqjevfA8xAAkY0O1vjrp9ReUNh0YmMIld4lR+U/t5L7mXji4ZXi1AejUUaEA9eH7Simv0qWLVOEdtcyh/4Ol+Sijlh+6J38LoCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hy6tN6nz; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hy6tN6nz"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9932aa108cso389075966b.2
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 10:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728323035; x=1728927835; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fOBFoL3DBxxixF/HDU+6zRIn+X6A9OxakUvme5r6kTg=;
        b=hy6tN6nz2s3AcZvbHcSz3b2oN0pebHftmIHqfq6zp6R+neLGLqSLfHAbsWksk47VCr
         X2MSNebtC72lZ+Fir6wbkp95zhHDsYj8sApxaYnFa+X+2w6YuSYXKwshdtP4b9ZKEpQC
         qlQ2Cz36hcoaq7ZvvrFpqjCc84RM0JjC18ExbBOe6QD4/EE4FIL29BXUibyp97h1mVGw
         3cZZ8QYbZAfMAJRMSxFCLDOq2JTDHHEihU17gWQLsmwSwAd/kCkwwY86BRF6un8WO2c1
         p0aFdeeFh3lxKNC9LaMH0S1o/1FIF6MglvoFnDEq97Jn89SU1kzUwnvCny+ijq6AV1GB
         XH3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728323035; x=1728927835;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fOBFoL3DBxxixF/HDU+6zRIn+X6A9OxakUvme5r6kTg=;
        b=aMjNotjfHsudo8kNc+CZAIbANkwKP4xOgWKt1EGAc13QWzIb+DLFaVj1GSkhCLpx2E
         Y7CH3Vdig700wWrG2uR3sAyhHcue2OBORsPWo0tv2nJsEe7aQjDktkOkz72/F8mds42R
         1+Msya39OWbbdg4yeMoXLmVbnS9KWZSPtnOJ9qOrvCaeTfILdDsMostEDAQHVOTpl8qv
         3Vugt5ty7ckbvZOxcDsonjaZKvY0CQYfPX6eDenS9yi+3KGpU6IWeCSlkuwPON01fW6D
         Ab+nYX6RCiNiOUNariFjkLsI0GJnA0voPtzNpVto/q7eL5TAVK8AL1QRRntqBTAntFGd
         VmBw==
X-Gm-Message-State: AOJu0YzDM24vD4n/QRe4gbotot8WJBgZG/abgFxch32snvqb5yrJll8N
	qqYo2WnnBNuiqKffKKkEv/nnf3WjqqjA6lY4uS7A6Bef29YfIy5kl1Xj3A==
X-Google-Smtp-Source: AGHT+IGpcy8ewmy4cFfWfMCMzvULpXdPmtaHfs1e+AGyI16olMkEEo8JZWpzlTBGiUrd5ZYgLgVt7A==
X-Received: by 2002:a17:907:3f8b:b0:a99:5985:bf15 with SMTP id a640c23a62f3a-a995985c0b6mr300590266b.12.1728323035090;
        Mon, 07 Oct 2024 10:43:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e787eecsm399904266b.125.2024.10.07.10.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 10:43:54 -0700 (PDT)
Message-Id: <pull.1810.git.1728323033680.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 07 Oct 2024 17:43:53 +0000
Subject: [PATCH] Makefile: fix dependency for $(UNIT_TEST_DIR)/clar/clar.o
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
    
    Hi Patrick,
    
    I tried building v2.47.0 and stumbled onto this small issue. It
    reproduces for me from a fresh clone on my old 2009 Mac with make -j -l
    2.5, it's a little curious that no one ran into this yet.
    
    I found it best to declare the dependency directly on clar.o, instead of
    adjusting the dependencies of CLAR_TEST_OBJS on the line above, since it
    is really only this clar.c that includes clar.suite

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1810%2Fphil-blain%2Fclar-build-dep-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1810/phil-blain/clar-build-dep-fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1810

 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 2dde1fd2b8b..b615de74811 100644
--- a/Makefile
+++ b/Makefile
@@ -3911,6 +3911,7 @@ $(UNIT_TEST_DIR)/clar-decls.h: $(patsubst %,$(UNIT_TEST_DIR)/%.c,$(CLAR_TEST_SUI
 $(UNIT_TEST_DIR)/clar.suite: $(UNIT_TEST_DIR)/clar-decls.h
 	$(QUIET_GEN)awk -f $(UNIT_TEST_DIR)/clar-generate.awk $< >$(UNIT_TEST_DIR)/clar.suite
 $(CLAR_TEST_OBJS): $(UNIT_TEST_DIR)/clar-decls.h
+$(UNIT_TEST_DIR)/clar/clar.o: $(UNIT_TEST_DIR)/clar.suite
 $(CLAR_TEST_OBJS): EXTRA_CPPFLAGS = -I$(UNIT_TEST_DIR)
 $(CLAR_TEST_PROG): $(UNIT_TEST_DIR)/clar.suite $(CLAR_TEST_OBJS) $(GITLIBS) GIT-LDFLAGS
 	$(call mkdir_p_parent_template)

base-commit: 777489f9e09c8d0dd6b12f9d90de6376330577a2
-- 
gitgitgadget
