Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0EA40D565
	for <git@vger.kernel.org>; Sun, 21 Jun 2026 14:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782053806; cv=none; b=bVZTJP5Rv3Ju7mIWwMCMyV4E+A+o91Sbvu+3ZBYv8FsS9SZpQ11dytUuRj44ZpTGzjgXo8u75IRVXVU4Dqq35b5WLXP0zZ9lSmIm/J2CgQs6N/VqYNXIfBySZuwQ3zyq0aNu2oJVh63gxzTvg/ChwBUrz3kdH0PUR2qocF0tY4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782053806; c=relaxed/simple;
	bh=Po81yMur2D7iXDaa7Q2Ytw20qwQlznUXWk/PkuzvySw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BztKdiXBNS1SiYck8rlvBnTpvuCN2vWJXeAm5n846B4GIqFUOGl4zPz1ZIExTGcFo4Bm6uYGiiGJK+lZyhbelhheKm6rPy+8aTmrvHUAPwRQx4l17yDM3GfkfqkgF0nKjINkodhF1lrtVoY7j+9RqRi3yu/C3SIFXfTVRvPTc88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGNxwnOU; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGNxwnOU"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-517de710886so28754111cf.3
        for <git@vger.kernel.org>; Sun, 21 Jun 2026 07:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782053804; x=1782658604; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7SauMxOf67m52JEAlXIXpxky83HvScy3M9pvNWF7dCQ=;
        b=SGNxwnOUEt6moiZQIt5GRPrzSODym6EfV50uLqfdBovJ3i5xe23lp2NNd+OYXNdDvo
         9x9bOZZpyxGNv976E3VRul+5Non1ZX9zFSy14r+oX4c9ON8OlFS4LlLCRAsItsDSgCF7
         ZBwsDJOGqgjlAPzJaSMdrgH+uRryB+VG1iurwQKbfXl0U3bMs3l2JIaWxsiOkM1QCM45
         8fbDfmcsPhSthQ/YmlgEBruvzIF2kwN5QfJwP2HkelKxBgsAS0myLq+AXg5b49OKIK2T
         5h8hDw1iFbumgLIwPeucX1RlnBIRhKwR/16AfNRbq7t82eEkuN+0+Kmjr2t2xxnbvMBW
         ED6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782053804; x=1782658604;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7SauMxOf67m52JEAlXIXpxky83HvScy3M9pvNWF7dCQ=;
        b=Pe82ZqGnvHgA/+geDNg98UQj8dP8NOJW24ZfyE39kbC5+vjkuaZiJ1rVs47tZxBMeQ
         jAmI6zr7jnbeXChYio5/22sJ5jkbEizW9I7MdaBvl+fj3uhwr8i5d2g4eFSzbBaomGdg
         yPJPmX3vUY2fI4hQsSNFpchX6WkhefUIy5CLgXitupuK21IvzMwhgsHlnvuEfhZ9m3ze
         M4eldudDO2EiruAaFou/1JQC/Z0UnK4QkMlvf58vV5Kswo5FxoOoz/qSSitQtOVDOE3R
         QMj4yn0W4PYSM7d9nYvPPJBD8VbFgMBGfOjK5NvJp7KsxDFpvodQI8/V1dJ63oTyFvcX
         7cGA==
X-Gm-Message-State: AOJu0Yw29pkTogfkY4Lk/TUUXAtboTuykqWY2aqgoI7EoykAsEgY1euh
	7EMQJ+Hl0vbtmRZwzcbCt8H8QPn8HIPhnuBJM9JMZ3RV2WpUo8Ll1ZKz2myizQ==
X-Gm-Gg: AfdE7cm4ZtfPIMsKkIitqWdc83Tw+On3oolR4xfE1tSeJ7GlFbOXsUR+Jen10jex5UV
	nU+LF13cM5RYNmsrAsi2Cnjuk/ULzHMnFObenIwu+FKBjmi3GqKiu1DOZ78z8iogBG1J9mDqoeq
	TBJPcG1cON4dbABXwEn1/k3G6oP9lHfpxdDJzoj9n7jyYUmYsxyWUBIqZgjVw9eOitdo2JN0eDD
	tIlFhE5E1rw/hWKgqZBaA/gpPWa6xGviM3wWPyCf8u29wr9ZfmAQf4EuKwn4J+RlVOFG+CGTesh
	Le/H3sUUyVor6H1ki2czjoiN/5n4v7j0ilhZU05dRcrV+6BWi01ZCC51OOUlVpH4GQQOhzdls7j
	jRVLZzJB4ACBAy2FPY35YxCHWa2YDPh0a38sGLqCSmzLlkDTOgTNbdOHSwUPBT1ip4c1dmB+L2c
	wuW55juFkvpk6XAwc=
X-Received: by 2002:a05:622a:13c9:b0:517:8711:d46c with SMTP id d75a77b69052e-519f04919b4mr140999601cf.31.1782053804342;
        Sun, 21 Jun 2026 07:56:44 -0700 (PDT)
Received: from [127.0.0.1] ([74.235.70.225])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df7f0164fasm63802106d6.8.2026.06.21.07.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 07:56:43 -0700 (PDT)
Message-Id: <pull.2339.v3.git.git.1782053803.gitgitgadget@gmail.com>
In-Reply-To: <pull.2339.v2.git.git.1781995570677.gitgitgadget@gmail.com>
References: <pull.2339.v2.git.git.1781995570677.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 21 Jun 2026 14:56:41 +0000
Subject: [PATCH v3 0/2] Silence po catalog output under "make -s"
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>

The gitk and git-gui are noisy despite "make -s", quiet the builds.

Changes in v3:

 * Split the single combined commit into two, one per Makefile (gitk,
   git-gui)
 * gitk: gate the quiet helpers on -s in MAKEFLAGS and give the catalog rule
   a QUIET_MSGFMT prefix, so a silent build emits no MSGFMT/GEN lines
 * git-gui: replace the QUIET_MSGFMT0/QUIET_MSGFMT1 pair with a single
   QUIET_MSGFMT, since with --statistics gone there is no output left to
   reformat

Changes in v2:

 * Reworked from conditionally silencing msgfmt output under make -s to just
   removing --statistics outright, following 2f12b31b74 (Makefile: don't
   invoke msgfmt with --statistics, 2021-12-17)
 * Also drop gitk's Generating catalog echo, which is not needed either

Harald Nordgren (2):
  gitk: make "make -s" silent
  git-gui: silence statistics under "make -s"

 git-gui/Makefile  | 5 ++---
 gitk-git/Makefile | 6 ++++--
 2 files changed, 6 insertions(+), 5 deletions(-)


base-commit: 8d96f09e9245ddf80c1981476fcbac8c4bb4125f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2339%2FHaraldNordgren%2Fsilence-catalog-output-under-make-s-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2339/HaraldNordgren/silence-catalog-output-under-make-s-v3
Pull-Request: https://github.com/git/git/pull/2339

Range-diff vs v2:

 1:  ee57c25009 ! 1:  4d977d6f3f gitk, git-gui: drop msgfmt --statistics output
     @@ Metadata
      Author: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Commit message ##
     -    gitk, git-gui: drop msgfmt --statistics output
     +    gitk: make "make -s" silent
      
     -    The catalog rules ran msgfmt with --statistics, whose output went to
     -    stderr and so survived "make -s" (gitk also echoed "Generating
     -    catalog").
     +    The catalog rule runs msgfmt with --statistics, whose output goes to
     +    stderr and so survives "make -s", and the rule also echoes "Generating
     +    catalog". The Gitk Makefile guards its quiet helpers on V alone, so a
     +    silent build still prints these and the GEN line.
      
          The statistics are not needed, as in 2f12b31b746c (Makefile: don't
     -    invoke msgfmt with --statistics, 2021-12-17), and the "Generating
     -    catalog" line is not needed either. Remove them so a quiet build stays
     -    quiet.
     +    invoke msgfmt with --statistics, 2021-12-17). Drop them, suppress the
     +    quiet helpers when "s" is among the make flags, and give the catalog
     +    rule a quiet prefix so a quiet build stays quiet.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     - ## git-gui/Makefile ##
     -@@ git-gui/Makefile: $(PO_TEMPLATE): $(SCRIPT_SH) $(ALL_LIBFILES)
     - update-po:: $(PO_TEMPLATE)
     - 	$(foreach p, $(ALL_POFILES), echo Updating $p ; msgmerge -U $p $(PO_TEMPLATE) ; )
     - $(ALL_MSGFILES): %.msg : %.po
     --	$(QUIET_MSGFMT0)$(MSGFMT) --statistics --tcl -l $(basename $(notdir $<)) -d $(dir $@) $< $(QUIET_MSGFMT1)
     -+	$(QUIET_MSGFMT0)$(MSGFMT) --tcl -l $(basename $(notdir $<)) -d $(dir $@) $< $(QUIET_MSGFMT1)
     - 
     - lib/tclIndex: $(ALL_LIBFILES) generate-tclindex.sh GIT-GUI-BUILD-OPTIONS
     - 	$(QUIET_INDEX)$(SHELL_PATH) generate-tclindex.sh . ./GIT-GUI-BUILD-OPTIONS $(ALL_LIBFILES)
     -
       ## gitk-git/Makefile ##
     +@@ gitk-git/Makefile: PO_TEMPLATE = po/gitk.pot
     + ALL_POFILES = $(wildcard po/*.po)
     + ALL_MSGFILES = $(subst .po,.msg,$(ALL_POFILES))
     + 
     ++ifneq ($(findstring s,$(firstword -$(MAKEFLAGS))),s)
     + ifndef V
     + 	QUIET          = @
     + 	QUIET_GEN      = $(QUIET)echo '   ' GEN $@ &&
     ++	QUIET_MSGFMT   = $(QUIET)echo '   ' MSGFMT $@ &&
     ++endif
     + endif
     + 
     + all:: gitk-wish $(ALL_MSGFILES)
      @@ gitk-git/Makefile: update-po:: $(PO_TEMPLATE)
       	echo; \
       	echo "	git config filter.gettext-no-location.clean \"msgcat --no-location -\""
       $(ALL_MSGFILES): %.msg : %.po
      -	@echo Generating catalog $@
      -	$(MSGFMT) --statistics --tcl -l $(basename $(notdir $<)) -d $(dir $@) $<
     -+	$(MSGFMT) --tcl -l $(basename $(notdir $<)) -d $(dir $@) $<
     ++	$(QUIET_MSGFMT)$(MSGFMT) --tcl -l $(basename $(notdir $<)) -d $(dir $@) $<
       
       .PHONY: all install uninstall clean update-po
       .PHONY: FORCE
 -:  ---------- > 2:  b613d4ac4a git-gui: silence statistics under "make -s"

-- 
gitgitgadget
