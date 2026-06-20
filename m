Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8780B4C6D
	for <git@vger.kernel.org>; Sat, 20 Jun 2026 22:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781995574; cv=none; b=ujyXKPbzOK4zYCk9aqMuRVG36XaF0uk2RQquqXsPZH6pxtpDrix8gNIjskeOIs3lX35jWnhHSgnyVKS3RkLWBykbhBBIf6A1KSl8e2MPz9uoa5QCqtMfH3acSMc64Eut+/hGrGKAJ2NCDQHbzgtKPMTsikh+TEYEJWT9BaNwLeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781995574; c=relaxed/simple;
	bh=eez1WJrshTjT2Vi2a01h3/OYAFaVp0RXBFX6d17/TAc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SfE6u9JduG0eaybYye4q9AQ+IbOUhUc3kkMnTq7aX3YQ+iYVZIGShPrPN1Y2KSKjxKRL3BHHy6MdegPX4VUAZiaG/aL9JE+t9xQlbpZXPLhZ7pGzQOvOUASGybG0TQ03iU5Yd7vpvR5zpxkBfkCL24nRLHAil9mOhgGHiqt+Ghw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=acm4E0gO; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acm4E0gO"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8df26121c88so11416146d6.0
        for <git@vger.kernel.org>; Sat, 20 Jun 2026 15:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781995572; x=1782600372; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B2A0dCEwYvpGSrrhK3o+npjINtonX96kCpNYJEBzjAk=;
        b=acm4E0gOHVADB36ZNmgQzFkM3YpU5THlXlTiRUcQJJ9RgJeQkOTUzZd1aX7RvpN3H/
         J25PFceoNV1JUoEEO1F2vrcqFXV+K5IsBBpHThkSzjZ1SvJB4DEN4mElqp+AmpYRo2U2
         OckGsRqxj50Eg4pDtSlxbQW1MMWq0Q5UPXqNgeryBgViIUge2fGGXDOPJC4p07XEREDy
         WZGJNsTuXAHYCGLqBRfUpBUcO7qCuqmvkrtz1NaOQ1ZgKqirAa/xlNqqp6BrgM3KZ0f8
         z81TQRvq0iuPdDCsBiEXCzGDkT7GAIXq29WiS3bqbubKvyTtrTzoqx76zwAvFaaot9Ip
         flrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781995572; x=1782600372;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B2A0dCEwYvpGSrrhK3o+npjINtonX96kCpNYJEBzjAk=;
        b=tGz+hKLlb1LCfRhlkDI/FglsExwv2ozZ3Jr32uYKD9RtDGeaGlWAbZpVzcwpmT8++o
         WO/DL1dmCW0rGjqZISuJqwrd9PePGG7BELU9LX705EEvS7gCl6Ozx4ck4YFUvAKOw6AP
         Ld8q8XvM1gwWPAETG9OjZ5Q6SQPXKkZNz7SLaF8HRHCH1We0yIq1j9xH3U0w0+NhBfyy
         /rxH+nEmVvV7pIvq9Q5ipIwv0IfIIX3SlqxLCYCHuDCaDYmdNCo4sqWZIGttzVe4HACu
         CWeCm6a7TPnNCKUkTwxbivbReN/iMWWZsV//m1RDaY8Np4wjcXfECIC0K3Oz4jpWfOa7
         +oLA==
X-Gm-Message-State: AOJu0YzadYL7i/hZwdVffSOm8xODcIC/rDUs8mmdqPtPQrdfxpHpRjCo
	XH813M6MIbFlVM2DpFvaDfgKOyltOS/n6SH8tjX8ikiesSsm4Dt3jntYXB9mqNMP
X-Gm-Gg: AfdE7ckpSjunTgwIPfHohea6Z0MxHBRpFN60+bgi4+guTUusKFU30BlB4u3hEx+0LcJ
	LL06xHASxv9jrj+BvPU7TpY14tvJrNcr/noM2lFKHOPAlKpwdai09UgmHea25JblSGwcIK0YbGA
	Ykar3aENfZ4rVf9iXbTvZqlmGQKcqp9pFEPUFFLDFeNg9VzFTKQWq+MnCsBUr1qg6prZQ30879n
	HRSDBspcg5mtzd/FMJQSanXokFzwGcfsCw9/zVLf72lnV+1LNeTRVtPrjsgOMsUopmm1f39eO43
	k7GQ8XRkjXZWR/DEpGaLhpll/LleiOvt6p20KhYaPVPVMedFcb/JTm+X7YVqorZjYxVI64Vb0fY
	LV9gllDqt0AZU48RhMhqqwayxSCgiv5cqJFC+9BrrE0+kTHyCwG5BRc/E+zIEa2vURfdBtaddiN
	SuYvq5BHrS1YARK80OBuy6QtiuOQ==
X-Received: by 2002:a05:6214:5b13:b0:8dc:2c21:32bd with SMTP id 6a1803df08f44-8de3b43e106mr145887176d6.1.1781995572374;
        Sat, 20 Jun 2026 15:46:12 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.215.50])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df81fcb4a4sm43449396d6.36.2026.06.20.15.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 15:46:11 -0700 (PDT)
Message-Id: <pull.2339.v2.git.git.1781995570677.gitgitgadget@gmail.com>
In-Reply-To: <pull.2339.git.git.1781459539.gitgitgadget@gmail.com>
References: <pull.2339.git.git.1781459539.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 20 Jun 2026 22:46:10 +0000
Subject: [PATCH v2] gitk, git-gui: drop msgfmt --statistics output
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

The catalog rules ran msgfmt with --statistics, whose output went to
stderr and so survived "make -s" (gitk also echoed "Generating
catalog").

The statistics are not needed, as in 2f12b31b746c (Makefile: don't
invoke msgfmt with --statistics, 2021-12-17), and the "Generating
catalog" line is not needed either. Remove them so a quiet build stays
quiet.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    Silence po catalog output under "make -s"
    
    The gitk and git-gui catalog rules sent msgfmt --statistics output (and
    a "Generating catalog" line) to stderr, so it survived "make -s". Emit
    it only when "-s" is absent, keeping a quiet build silent and a verbose
    build unchanged.
    
    Changes in v2:
    
     * Reworked from conditionally silencing msgfmt output under make -s to
       just removing --statistics outright, following 2f12b31b74 (Makefile:
       don't invoke msgfmt with --statistics, 2021-12-17)
     * Also drop gitk's Generating catalog echo, which is not needed either

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2339%2FHaraldNordgren%2Fsilence-catalog-output-under-make-s-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2339/HaraldNordgren/silence-catalog-output-under-make-s-v2
Pull-Request: https://github.com/git/git/pull/2339

Range-diff vs v1:

 1:  18451d46e4 < -:  ---------- gitk: silence catalog output under "make -s"
 2:  5071c5106a ! 1:  ee57c25009 git-gui: silence statistics under "make -s"
     @@ Metadata
      Author: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Commit message ##
     -    git-gui: silence statistics under "make -s"
     +    gitk, git-gui: drop msgfmt --statistics output
      
     -    The catalog rule passed --statistics to msgfmt unconditionally, and its
     -    output went to stderr, so it survived "make -s".
     +    The catalog rules ran msgfmt with --statistics, whose output went to
     +    stderr and so survived "make -s" (gitk also echoed "Generating
     +    catalog").
      
     -    Pass --statistics only when "-s" is absent, leaving a quiet build silent
     -    while default and V=1 builds are unchanged.
     +    The statistics are not needed, as in 2f12b31b746c (Makefile: don't
     +    invoke msgfmt with --statistics, 2021-12-17), and the "Generating
     +    catalog" line is not needed either. Remove them so a quiet build stays
     +    quiet.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## git-gui/Makefile ##
     -@@ git-gui/Makefile: ifndef V
     - 	REMOVE_F0 = dst=
     - 	REMOVE_F1 = && echo '   ' REMOVE `basename "$$dst"` && $(RM_RF) "$$dst"
     - endif
     -+	MSGFMT_STATS = --statistics
     - endif
     - 
     - TCLTK_PATH ?= wish
      @@ git-gui/Makefile: $(PO_TEMPLATE): $(SCRIPT_SH) $(ALL_LIBFILES)
       update-po:: $(PO_TEMPLATE)
       	$(foreach p, $(ALL_POFILES), echo Updating $p ; msgmerge -U $p $(PO_TEMPLATE) ; )
       $(ALL_MSGFILES): %.msg : %.po
      -	$(QUIET_MSGFMT0)$(MSGFMT) --statistics --tcl -l $(basename $(notdir $<)) -d $(dir $@) $< $(QUIET_MSGFMT1)
     -+	$(QUIET_MSGFMT0)$(MSGFMT) $(MSGFMT_STATS) --tcl -l $(basename $(notdir $<)) -d $(dir $@) $< $(QUIET_MSGFMT1)
     ++	$(QUIET_MSGFMT0)$(MSGFMT) --tcl -l $(basename $(notdir $<)) -d $(dir $@) $< $(QUIET_MSGFMT1)
       
       lib/tclIndex: $(ALL_LIBFILES) generate-tclindex.sh GIT-GUI-BUILD-OPTIONS
       	$(QUIET_INDEX)$(SHELL_PATH) generate-tclindex.sh . ./GIT-GUI-BUILD-OPTIONS $(ALL_LIBFILES)
     +
     + ## gitk-git/Makefile ##
     +@@ gitk-git/Makefile: update-po:: $(PO_TEMPLATE)
     + 	echo; \
     + 	echo "	git config filter.gettext-no-location.clean \"msgcat --no-location -\""
     + $(ALL_MSGFILES): %.msg : %.po
     +-	@echo Generating catalog $@
     +-	$(MSGFMT) --statistics --tcl -l $(basename $(notdir $<)) -d $(dir $@) $<
     ++	$(MSGFMT) --tcl -l $(basename $(notdir $<)) -d $(dir $@) $<
     + 
     + .PHONY: all install uninstall clean update-po
     + .PHONY: FORCE


 git-gui/Makefile  | 2 +-
 gitk-git/Makefile | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/git-gui/Makefile b/git-gui/Makefile
index d33204e875..48d848a59d 100644
--- a/git-gui/Makefile
+++ b/git-gui/Makefile
@@ -155,7 +155,7 @@ $(PO_TEMPLATE): $(SCRIPT_SH) $(ALL_LIBFILES)
 update-po:: $(PO_TEMPLATE)
 	$(foreach p, $(ALL_POFILES), echo Updating $p ; msgmerge -U $p $(PO_TEMPLATE) ; )
 $(ALL_MSGFILES): %.msg : %.po
-	$(QUIET_MSGFMT0)$(MSGFMT) --statistics --tcl -l $(basename $(notdir $<)) -d $(dir $@) $< $(QUIET_MSGFMT1)
+	$(QUIET_MSGFMT0)$(MSGFMT) --tcl -l $(basename $(notdir $<)) -d $(dir $@) $< $(QUIET_MSGFMT1)
 
 lib/tclIndex: $(ALL_LIBFILES) generate-tclindex.sh GIT-GUI-BUILD-OPTIONS
 	$(QUIET_INDEX)$(SHELL_PATH) generate-tclindex.sh . ./GIT-GUI-BUILD-OPTIONS $(ALL_LIBFILES)
diff --git a/gitk-git/Makefile b/gitk-git/Makefile
index 41116d8a14..0ae083c1ca 100644
--- a/gitk-git/Makefile
+++ b/gitk-git/Makefile
@@ -75,8 +75,7 @@ update-po:: $(PO_TEMPLATE)
 	echo; \
 	echo "	git config filter.gettext-no-location.clean \"msgcat --no-location -\""
 $(ALL_MSGFILES): %.msg : %.po
-	@echo Generating catalog $@
-	$(MSGFMT) --statistics --tcl -l $(basename $(notdir $<)) -d $(dir $@) $<
+	$(MSGFMT) --tcl -l $(basename $(notdir $<)) -d $(dir $@) $<
 
 .PHONY: all install uninstall clean update-po
 .PHONY: FORCE

base-commit: 8d96f09e9245ddf80c1981476fcbac8c4bb4125f
-- 
gitgitgadget
