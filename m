Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B263C433F5
	for <git@archiver.kernel.org>; Sat,  9 Apr 2022 04:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235159AbiDIEcq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Apr 2022 00:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbiDIEcp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Apr 2022 00:32:45 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B4F1F0815
        for <git@vger.kernel.org>; Fri,  8 Apr 2022 21:30:39 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id j5-20020a05600c1c0500b0038ea8b53580so1601423wms.1
        for <git@vger.kernel.org>; Fri, 08 Apr 2022 21:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sNuvm1cgsqTMHoI6F+iEz2tiwzLnODUVPZvNC53miJ4=;
        b=YIco5nqTdRE0zCXHSGjDYJwtj3EnaeMpoOQr1vOqoOtTpDMD2NtUeeMMTqWUwj2RNw
         cYMLr5BhFyLxzPtMDFwJa9FXW7gR2tiO+TkDMiWSf3qB19CFH+8ZGfQdbmKO+uVrCxQI
         Ubq1VwIy8ghYhR4xRnm39AEsJUpaY5H6k6MjeUHtxmHOJ8JNvduTt/9Tn3UtALV/eATj
         3pKV+ltyjZ++8CoiaZiuZpZqw4T0pH+JFN2ZVswPk925BL1+taiHIxjidsJ7ShsJ2o8g
         G/2tRXerYvOY//SVdHawt/1HRAEDbdrzu29ZRlj5dWJv7EhZtuHSXhi5LPFzsnYTXnrH
         /Gww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sNuvm1cgsqTMHoI6F+iEz2tiwzLnODUVPZvNC53miJ4=;
        b=F2AM68yhwRY+no/rsBfc6QwAh6kS/32kXZm/QEBVcIjSRVlkNtQaXcDqrMOh+KBLfb
         GuFt9swYstLu0KIM3K4zgEL3wDgQDWyufHYWq0FyN21GZ8UUy73gVVFzmI+zIJ6ZwdeQ
         Jb0lIwmDi5mtgA1bin/NXDqmnuQVEd13qBw0h6M7TfhxGDCWNTbLHi8S/4JwTbGOWqva
         6tdNni/vrGxWCy/n4mHYe0nbzMykXGCSv8KdH4Tu465MuCGDN3bWen/2L9wvaTchKQOA
         yndTaG/96IZDS8eLUC4f2Z+X3lMGuYFxR5IADANfIwSuMUR5YCAg5H9/7PV1fJmE1z23
         l+ew==
X-Gm-Message-State: AOAM530p1MluyyGQcsEQCpkRWjRe4VEJ4m4d8pr2QBrMiHVQCNITAQ3M
        NaYskEiVJUg63u1HCCAMTqK/n05DUJs=
X-Google-Smtp-Source: ABdhPJxmE086GGAjRs7y16p+hnxdwZIEW4CKSzH7NTLB5ta4gu9N82MqgVeIP1aSOBGy23OPW/qxhQ==
X-Received: by 2002:a1c:29c3:0:b0:350:9797:b38f with SMTP id p186-20020a1c29c3000000b003509797b38fmr19777883wmp.22.1649478637331;
        Fri, 08 Apr 2022 21:30:37 -0700 (PDT)
Received: from fedora35.example.com ([151.24.233.140])
        by smtp.gmail.com with ESMTPSA id e10-20020a056000178a00b002078d640b29sm4447233wrg.83.2022.04.08.21.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 21:30:36 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH v2 1/1] Makefile: add a prerequisite to the coverage-report target
Date:   Sat,  9 Apr 2022 04:30:33 +0000
Message-Id: <20220409043033.1288946-1-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Directly invoking make coverage-report as a target results in an error because
its prerequisites are missing,

This patch adds the compile-test prerequisite, which is run only once each time
the compile-report target is invoked. In practice, the developer may decide to
review the coverage-report results without necessarily rerunning for this
coverage-test, if it has already been run.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
This is the second version of the patch.

With respect to the first version, we tried to eliminate the inefficient
coverage-test invocation if the target is coverage-report, introducing a more
useful invocation order

 Makefile | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index e8aba291d7..eacdffd748 100644
--- a/Makefile
+++ b/Makefile
@@ -3378,6 +3378,8 @@ check-builtins::
 .PHONY: coverage-untested-functions cover_db cover_db_html
 .PHONY: coverage-clean-results
 
+coverage-test.file?=coverage-test.file
+
 coverage:
 	$(MAKE) coverage-test
 	$(MAKE) coverage-untested-functions
@@ -3389,6 +3391,7 @@ coverage-clean-results:
 	$(RM) coverage-untested-functions
 	$(RM) -r cover_db/
 	$(RM) -r cover_db_html/
+	$(RM) -f $(coverage-test.file)
 
 coverage-clean: coverage-clean-results
 	$(RM) $(addsuffix *.gcno,$(object_dirs))
@@ -3404,12 +3407,16 @@ coverage-test: coverage-clean-results coverage-compile
 	$(MAKE) CFLAGS="$(COVERAGE_CFLAGS)" LDFLAGS="$(COVERAGE_LDFLAGS)" \
 		DEFAULT_TEST_TARGET=test -j1 test
 
+$(coverage-test.file):
+	@make coverage-test
+	touch $(coverage-test.file)
+
 coverage-prove: coverage-clean-results coverage-compile
 	$(MAKE) CFLAGS="$(COVERAGE_CFLAGS)" LDFLAGS="$(COVERAGE_LDFLAGS)" \
 		DEFAULT_TEST_TARGET=prove GIT_PROVE_OPTS="$(GIT_PROVE_OPTS) -j1" \
 		-j1 test
 
-coverage-report:
+coverage-report: $(coverage-test.file)
 	$(QUIET_GCOV)for dir in $(object_dirs); do \
 		$(GCOV) $(GCOVFLAGS) --object-directory=$$dir $$dir*.c || exit; \
 	done
-- 
2.35.1

