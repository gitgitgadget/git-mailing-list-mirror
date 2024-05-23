Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D453128F5
	for <git@vger.kernel.org>; Thu, 23 May 2024 20:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716496127; cv=none; b=m/H20xSAXzJ9ZzcU92GunYgteeFgRqkPV0TfaM3R1/XLDYtUZJ84MR6iYFnyDQuJFqb2scIUSJ0t4PUN6dq5upCoUwi417V+sP/cPBCkbmvM1lJsF62AIHGvl/dx8JzYFp9y8ym45hUSgn1BgzyXhXjabpiQva5D6pczQn43ces=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716496127; c=relaxed/simple;
	bh=nJDqAjpaQAvhcSPm2TjNiiIi2c+sdCEHc1ySbS2Xqzc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KFpI7SmV5IxVcRoG+6I8cMdRAFtCoVrAg5tjRp1ZLJB9+iEdEziPOoRqvAbOL5DZv86gxyE8e7hAxgt4qf4ri+QTEKv9aHWyhHuRijW0PJemNwdJQ2DclmSbo08ykRLSeIKHwiVwjSq0rGgG0zKeEZ3bFHPyO7LpCgE5Q/ygBLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2h67CVv; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2h67CVv"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-351b683f2d8so2082734f8f.3
        for <git@vger.kernel.org>; Thu, 23 May 2024 13:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716496124; x=1717100924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rZ05PJ/IDk0inYC5esQcr0fJDW7n5Zp4v+tdqeYVr/s=;
        b=G2h67CVvLlNc6j1qEJETJRCbIrj37bmZ3yY/oCBeF/IVIEc+B63RI9kMaEQ78oBwxM
         vs4zw4UL8D6mf7z951XkxriufSNhPw1jtHoZgbwb4t9Rv4dLK48Ss6sT6zms4m1ilcFX
         Pi2oYF5agYRHULQMPw/KiXsb1tuNn1XWduNYQfU5Lt+pb77xX9hT97WqENCLnn2PdAMe
         2Vw28dOdBeZK7yDq36LgVPsysEphxnTHcwHM7TVpCx9J3I8vKcqGL3Xg4h+Hw8M2abKX
         gl6WqJtvnrvjJb6OZen7fhW4BEyT5SUUeTftd3pMcVliao/XgypwTXCYpl5sfjMJjAlq
         XHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716496124; x=1717100924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rZ05PJ/IDk0inYC5esQcr0fJDW7n5Zp4v+tdqeYVr/s=;
        b=iXWOafyNqc2J/hHdo4KtFU4sb1IuMFxqHH3eGmzaY0kbC8sLzCITF7Z8H6GQ+8dKAz
         GKTPuzfG6N84f+BOpAtoSa6XM0BEtMq4nMKpe9+MTbuTqrrRgmE2P+mfmndo16badj+m
         nG2jEi6zcpil8NGQ5Hb34caO/YJ9gOpRzp6rQmj+TGoxqyFhsmkSoEq5WvAJHajHawe7
         Fo8mPAODVh1yRP1BhW6PyF7XaFBmCGpLiwXxGCa7mhEB/2mYnuIm24v3OJdnaAROQkMn
         nJMKp5GVm22YTdDR0EWG5fky65E1qFIIvxaLeOtwjnqEZrCruuqCmTc+bTda1oD8vdS7
         PbfQ==
X-Gm-Message-State: AOJu0Yy1EGC3JvAzZ+rRSrvJx5t9Oc4M84JQ0KrliYfEv1UwuP3mNePY
	dVMCcN+0MpNBjoOlRPAL01hMdwG/J0lh/fOm2pFnbeBLhntdNesS5rRF1w==
X-Google-Smtp-Source: AGHT+IGoSAg/CK7VhhJjDrHU2M/cfXq4J25idRFcGHEdvNkROqkwvL8MaeshAqkhgGyz1I5OZs0prg==
X-Received: by 2002:a05:600c:224e:b0:420:fb99:ed02 with SMTP id 5b1f17b1804b1-421089b2283mr1783365e9.6.1716496123912;
        Thu, 23 May 2024 13:28:43 -0700 (PDT)
Received: from shiban.redhat.com (host-95-193-73-141.mobileonline.telia.com. [95.193.73.141])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cda8f98sm5702366b.218.2024.05.23.13.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 13:28:43 -0700 (PDT)
From: =?UTF-8?q?Jonas=20=C3=85dahl?= <jadahl@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Jonas=20=C3=85dahl?= <jadahl@gmail.com>
Subject: [PATCH] gitk: Add desktop file
Date: Thu, 23 May 2024 22:28:38 +0200
Message-ID: <20240523202838.174760-1-jadahl@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This makes it properly integrate with desktop environments, by e.g.
grouping different gitk windows, getting an app icon, ability to add
keywords for searching.

It's marked as 'NoDisplay' meaning it will not show up as a launchable
application, as that makes no sense for gitk.

Signed-off-by: Jonas Ådahl <jadahl@gmail.com>
---
 gitk-git/Makefile        |   8 +++++++-
 gitk-git/gitk.desktop.in |  12 ++++++++++++
 gitk-git/gitk.png        | Bin 0 -> 4257 bytes
 3 files changed, 19 insertions(+), 1 deletion(-)
 create mode 100644 gitk-git/gitk.desktop.in
 create mode 100644 gitk-git/gitk.png

diff --git a/gitk-git/Makefile b/gitk-git/Makefile
index e1f0aff4a1..e738176fd6 100644
--- a/gitk-git/Makefile
+++ b/gitk-git/Makefile
@@ -15,6 +15,7 @@ RM ?= rm -f
 
 DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
 bindir_SQ = $(subst ','\'',$(bindir))
+sharedir_SQ = $(subst ','\'',$(sharedir))
 TCLTK_PATH_SQ = $(subst ','\'',$(TCLTK_PATH))
 
 ### Detect Tck/Tk interpreter path changes
@@ -47,12 +48,14 @@ ifndef V
 	QUIET_GEN      = $(QUIET)echo '   ' GEN $@ &&
 endif
 
-all:: gitk-wish $(ALL_MSGFILES)
+all:: gitk-wish $(ALL_MSGFILES) gitk.desktop
 
 install:: all
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(INSTALL) -m 755 gitk-wish '$(DESTDIR_SQ)$(bindir_SQ)'/gitk
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(msgsdir_SQ)'
+	$(INSTALL) gitk.desktop '$(DESTDIR_SQ)$(sharedir_SQ)'/applications/gitk.desktop
+	$(INSTALL) gitk.png '$(DESTDIR_SQ)$(sharedir_SQ)'/gitk/
 	$(foreach p,$(ALL_MSGFILES), $(INSTALL) -m 644 $p '$(DESTDIR_SQ)$(msgsdir_SQ)' &&) true
 
 uninstall::
@@ -76,5 +79,8 @@ $(ALL_MSGFILES): %.msg : %.po
 	@echo Generating catalog $@
 	$(MSGFMT) --statistics --tcl $< -l $(basename $(notdir $<)) -d $(dir $@)
 
+gitk.desktop: gitk.desktop.in
+	sed -e "s,@iconpath@,$(DESTDIR_SQ)$(sharedir_SQ)/gitk/gitk.png," $< > $@
+
 .PHONY: all install uninstall clean update-po
 .PHONY: FORCE
diff --git a/gitk-git/gitk.desktop.in b/gitk-git/gitk.desktop.in
new file mode 100644
index 0000000000..b18a50fe2f
--- /dev/null
+++ b/gitk-git/gitk.desktop.in
@@ -0,0 +1,12 @@
+[Desktop Entry]
+Name=Gitk
+GenericName=Gitk
+Comment=The Git repository browser
+Exec=gitk
+Icon=@iconpath@
+Terminal=false
+Type=Application
+Categories=Development;
+X-Desktop-File-Install-Version=0.26
+NoDisplay=true
+Keywords=git;repository
diff --git a/gitk-git/gitk.png b/gitk-git/gitk.png
new file mode 100644
index 0000000000000000000000000000000000000000..21f21b39ec44b14bb44161305b26ab4f0fc64ead
GIT binary patch
literal 4257
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
Px|d0>OC4N&*N^`LBXF6q

literal 0
HcmV?d00001

-- 
2.44.0

