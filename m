Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6539C2512C8
	for <git@vger.kernel.org>; Sun, 21 Jun 2026 14:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782053807; cv=none; b=jZxhem3kfgenJub8wzRCT/Plj/w+5co5ZT8IBdIkUX+906EpT13UQ0kJK+CCNRAchWFd0GZlOIPBkBXLIvKUAXGg2ox+aeqiBhUwd/A2kqHp1A/45w5Vk2TIvW2fVAf117JDlO6yghlIA/4JB5O1du+pnFkC5f5w+9H/v+OZWLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782053807; c=relaxed/simple;
	bh=2g1aEhKD0HKkgB87NwSVmExrg31kjU2DRKg3ajb/VzY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=F2QvJfP2q06Woy4deaqvo9FhLyuGrNauak0zqyfTq1MYKsUAPXZ+DQnCsmn0ZrOMvEwYfW+60AdU9snIFaMJzWLJEkFBv3HZ/ywUFOSnUlmG5P9UKHyv8K/09yRrMgbeOArVibUIQtaPORZK5iCLQYk7K2FnKijf4uwTMg+u6JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bhHtTrso; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhHtTrso"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8dc09919aa2so62504216d6.3
        for <git@vger.kernel.org>; Sun, 21 Jun 2026 07:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782053805; x=1782658605; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jJ0EIKMMQnfVhymJSPtpJ6qqXYk50o6gwr1HFa2XGQ=;
        b=bhHtTrso4YF7pE2SS8Z+yfsTTWv1L+B+awv3J2noM8k6C6/gKSzupsFerabUbbF9W8
         0QJI0yQTuyYpzoHGYWOnBXH48JVsKeF+zOeZzhjoUIRjasdpdI1elWdABfLg87SWCuPO
         E9D3nve2oEdUFDzvuMEZHksZLpZkoO160YHBhSHTBqOPxwFnsW+nFUYgE3vuqWQlNUTL
         wxWA83YQa1ID7QhSGZSicItytR5PNzfc/4Jv9XnmydBwm6FnjB9GfoL9Mi+KqRjtBNmJ
         kekSv2Xeq6BKHT9T5MlO3GZk2fo6sX4FRxPXpfNWko8XQGZZH1JSI67fm5roKlIjGeoR
         6Scw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782053805; x=1782658605;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9jJ0EIKMMQnfVhymJSPtpJ6qqXYk50o6gwr1HFa2XGQ=;
        b=DK7dMMsWAXjUCZfxFoHX5srIeuAWj768Bn/aey02AvrrJ5JbZSigFSEM+df3MUAFBO
         /EgMVLhYOkEXPvXCwY28wEIFkpLa7Y1b7zJEVMCWZgufSQ4ShgEU00OUa8BgP64BgNBM
         Fqc1YSBlLd+R6gnkOv/6orM3qwMnyRZV9Ajnowqn1oYkVMRYMrfImK15YTpPiVD2JyIK
         OCs2jZH+tKQzDJBXJK/qC6vKjW69zSdEfLdq4dCWlWv+JmS/VxwUXR2hGapelJ9q7apB
         dHHowip+W2B/IsughNxra1WDBw/4+yV/NaTLs2SmGW/wLMWPN6Itqyxd36W2aTRJsvC/
         yFzA==
X-Gm-Message-State: AOJu0YylPQsG8l3DfRuYYIOOIjbCRT8uKpbV507AtnWiszeEV7JZMtrK
	Jbjcg2gxJDEXNIuWYE5hNWU447FlmpZtTTPERkmJAB1oFps+Np4UNX3JgvLrRA==
X-Gm-Gg: AfdE7cm95wzIECOMPmYDm3HON+anoEjwXVKuNG+sNNQl3i5SIEr049KkcArzlYvghBf
	Iop7tE0mbjDAk4chR34TwpplgoHYavnpaIxxnP8TIMkpHdB5MSonuhH64vKHY/qaGJSDcC+ruA+
	RlztqN0PsFP/2L7VoFvcXuAYi+m0ViDrxAVn16Yw7sL+4qqSYOuoKdTSiU8FvMRaRqeGLAn1QGy
	WLleCP5TlKJnzlFQpVkdL4L12Nn1qniD3ICUgaPmOXWQcaC01nAqT4alS7pnDMlX+7zwgu0rTdy
	L1rUFlGb2lFnvOgJdFdep18AI+coVIXESHdb803RDHpcdgRqy4uoo3vxaiVqt03uXVQXZ1pqDH4
	HZ83LWn8ZXw8PWMMBtv3dMWRPHTHJKRnrz0yTT/KUNK6ADwZrigic3M7t1poRAtFbGa/6Aauh8Z
	YDl21nvcHa4MkeKtM=
X-Received: by 2002:a05:6214:769:b0:8dc:2c11:e478 with SMTP id 6a1803df08f44-8de40dfe254mr210187746d6.28.1782053805295;
        Sun, 21 Jun 2026 07:56:45 -0700 (PDT)
Received: from [127.0.0.1] ([74.235.70.225])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df82693b9asm69146986d6.42.2026.06.21.07.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 07:56:44 -0700 (PDT)
Message-Id: <4d977d6f3fe716e8b3d5655b010fedbb8c9b8960.1782053803.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2339.v3.git.git.1782053803.gitgitgadget@gmail.com>
References: <pull.2339.v2.git.git.1781995570677.gitgitgadget@gmail.com>
	<pull.2339.v3.git.git.1782053803.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 21 Jun 2026 14:56:42 +0000
Subject: [PATCH v3 1/2] gitk: make "make -s" silent
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

The catalog rule runs msgfmt with --statistics, whose output goes to
stderr and so survives "make -s", and the rule also echoes "Generating
catalog". The Gitk Makefile guards its quiet helpers on V alone, so a
silent build still prints these and the GEN line.

The statistics are not needed, as in 2f12b31b746c (Makefile: don't
invoke msgfmt with --statistics, 2021-12-17). Drop them, suppress the
quiet helpers when "s" is among the make flags, and give the catalog
rule a quiet prefix so a quiet build stays quiet.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 gitk-git/Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/gitk-git/Makefile b/gitk-git/Makefile
index 41116d8a14..dd87f501e5 100644
--- a/gitk-git/Makefile
+++ b/gitk-git/Makefile
@@ -43,9 +43,12 @@ PO_TEMPLATE = po/gitk.pot
 ALL_POFILES = $(wildcard po/*.po)
 ALL_MSGFILES = $(subst .po,.msg,$(ALL_POFILES))
 
+ifneq ($(findstring s,$(firstword -$(MAKEFLAGS))),s)
 ifndef V
 	QUIET          = @
 	QUIET_GEN      = $(QUIET)echo '   ' GEN $@ &&
+	QUIET_MSGFMT   = $(QUIET)echo '   ' MSGFMT $@ &&
+endif
 endif
 
 all:: gitk-wish $(ALL_MSGFILES)
@@ -75,8 +78,7 @@ update-po:: $(PO_TEMPLATE)
 	echo; \
 	echo "	git config filter.gettext-no-location.clean \"msgcat --no-location -\""
 $(ALL_MSGFILES): %.msg : %.po
-	@echo Generating catalog $@
-	$(MSGFMT) --statistics --tcl -l $(basename $(notdir $<)) -d $(dir $@) $<
+	$(QUIET_MSGFMT)$(MSGFMT) --tcl -l $(basename $(notdir $<)) -d $(dir $@) $<
 
 .PHONY: all install uninstall clean update-po
 .PHONY: FORCE
-- 
gitgitgadget

