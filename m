Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B66390CB5
	for <git@vger.kernel.org>; Sun, 14 Jun 2026 17:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781459545; cv=none; b=MtOfdd0zxmEG3H23l2Oi1rl/Vy4LZ7xVLVYi/WklUCYsMcskS6laNtO3f69vIC5Wj1ADqSoCdX8aqVXt1uNS6LB+jnWICr4etPpRPD9GRom6/aPOHLeusFtqEZdnndbslavt2kb2MF7OjpRWdKsj7mVEnrhr53xryhT8dVTy4Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781459545; c=relaxed/simple;
	bh=KlwMmzKoTmWenPtMSSOi4Oy7jzhIVgf4Dyw27yfgT34=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=juevhsnP3qEmWd9ZjF6GU5oJ2/jLEkTbpi4Qbeq1tNNL6Tzsn/U8Ih4GaEUnM+d3j5B1y0Qrof4/ocRdgy7US6bCPY/rBO/tONncgC2a+QnAvPiVEsWmzEWlKRlGQjkLm9oJKu/ST+Spc235Frewo5/GKAprU58uMdDjzBxzjds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fBh66lb+; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBh66lb+"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3074adb8fcaso3204719eec.0
        for <git@vger.kernel.org>; Sun, 14 Jun 2026 10:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781459543; x=1782064343; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9EROru97BbYXYVcHFQluzOlj4CRQbA1zCKOoDyc01yw=;
        b=fBh66lb+LSho7Rsxd64PdJihbe09A65OaGaiysd5Fol+NHBk058vTbGAKzNUCY7M9L
         pFAki1UdP4Kr+Inp+XaBKgHTdM2t54eoPB3/X4T1SFGdCpyGNg4wEPKXVHxZa8guJiyy
         NXf1OeOFYrH8XbwPmWNLRMi0NXIUt06LiWhtECBjW731KW6Dy6L1tJyiVyHIBeGP8+W/
         n2kUK2sKD+IPzDmHnHp/iFbQHTfcir0tGAOjEzuD8vXewfFl2LNSRQImnT31XlzWKMdh
         O58heqIyZV1HLzC9J4FHmAR9oaCet7hrq88KYZTqbAG9qtetOkSqnsqKFoAgO1fGKmhB
         5j+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781459543; x=1782064343;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9EROru97BbYXYVcHFQluzOlj4CRQbA1zCKOoDyc01yw=;
        b=Yn14SWDH1d4OO/uEcpk5ymK99JDv7OzpxAEX2NjED6zhZj3mOo5dv6hOuFaYzRBGQR
         qwsVnuHPZ6zC1zwhpqzYbPvOVodSWoRnfdyMoN+OjBfFY2hGxe6CZ21BXdDJ6xXF/VfS
         lHtAZxxiE4CnwY2RrmCL53DBi+/8z/U6TpymFNYxfKBAarsgMtsF/xDtYEmcYsZhD4tU
         woOFH3bXa87Jy62nhIgAVN7knjZkFTwzTSCnZ/7N3EjBU8QH7eP/EJNDjxXLLMiM5oVK
         fH/2oEnagayVw+czXxSNJOsrDjXpLSuhJWUwJpKn60Jgs8kuleEvhq3mc6iGtBQoKgEf
         KAow==
X-Gm-Message-State: AOJu0YyNwtOvxG53fEbFppHnzm8U5cPnzfiwJQ3+5yCiMcm5d1a4f3sH
	e0rgV6BxCNLLmOzPnzQjo4v2KnIJ8DRYQYvm4jbpAPLZc07xkUuhlRGZANVGCw==
X-Gm-Gg: Acq92OHrwOkYYI6pldrXEWVdUldPrimZ6nJqswuPYQxD6kNt/fpY+AuX/WmQ56Hp35D
	eVKikazBMVeRP778ZYczF2HWOV4JVuTSduDHvzxMqhNka7r5stwJZBc2WXloqdtxbAM6slp+wDh
	Mxu3KmCMJNArJh8zqZVObGCjpOdS/4f/tNI5xdN50gL16qHNeQU+y62GMFbeHJzSthr+4c8fftz
	9yo7A6xdD+1WkdWE6jHE8C6afUdMmGmfQZjrH3koJCOQ12v4yuOPCwSN1+LEqA9YcHooes1yee9
	O2cEj/aPQvPGOaVwHF17oobPObKNcjVm/tJzUz+i9JSGUmq65x/VcfOpTY7DnMqHRI5HdpBOJ+r
	gutuGKYJb22Gozs3Mk6pSAuTwakAREmvleeIcizIkwOGyYuDrvcE5+Vz+a77c2/DZIOv85aTQYj
	c9lk3TOAerF7nH+7aImk5K6eDmocxYVdyU4YuXapw=
X-Received: by 2002:a05:7300:80ce:b0:2f2:8857:17f6 with SMTP id 5a478bee46e88-3081ff63daamr6278628eec.4.1781459543041;
        Sun, 14 Jun 2026 10:52:23 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.212.102])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081eb95450sm14194316eec.28.2026.06.14.10.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 10:52:22 -0700 (PDT)
Message-Id: <18451d46e431dec2ce3275d4837bd595298fc246.1781459539.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2339.git.git.1781459539.gitgitgadget@gmail.com>
References: <pull.2339.git.git.1781459539.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 14 Jun 2026 17:52:18 +0000
Subject: [PATCH 1/2] gitk: silence catalog output under "make -s"
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

The catalog rule unconditionally echoed "Generating catalog" and ran
msgfmt with --statistics, whose output went to stderr and so survived
"make -s".

Emit the "Generating catalog" line and the msgfmt statistics only when
"-s" is absent, leaving a quiet build silent while default and V=1
builds are unchanged.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 gitk-git/Makefile | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/gitk-git/Makefile b/gitk-git/Makefile
index 41116d8a14..10078c54d4 100644
--- a/gitk-git/Makefile
+++ b/gitk-git/Makefile
@@ -43,10 +43,16 @@ PO_TEMPLATE = po/gitk.pot
 ALL_POFILES = $(wildcard po/*.po)
 ALL_MSGFILES = $(subst .po,.msg,$(ALL_POFILES))
 
+MSGFMT_GEN = @:
+
+ifneq ($(findstring s,$(firstword -$(MAKEFLAGS))),s)
 ifndef V
 	QUIET          = @
 	QUIET_GEN      = $(QUIET)echo '   ' GEN $@ &&
 endif
+	MSGFMT_GEN   = @echo Generating catalog $@
+	MSGFMT_STATS = --statistics
+endif
 
 all:: gitk-wish $(ALL_MSGFILES)
 
@@ -75,8 +81,8 @@ update-po:: $(PO_TEMPLATE)
 	echo; \
 	echo "	git config filter.gettext-no-location.clean \"msgcat --no-location -\""
 $(ALL_MSGFILES): %.msg : %.po
-	@echo Generating catalog $@
-	$(MSGFMT) --statistics --tcl -l $(basename $(notdir $<)) -d $(dir $@) $<
+	$(MSGFMT_GEN)
+	$(MSGFMT) $(MSGFMT_STATS) --tcl -l $(basename $(notdir $<)) -d $(dir $@) $<
 
 .PHONY: all install uninstall clean update-po
 .PHONY: FORCE
-- 
gitgitgadget

