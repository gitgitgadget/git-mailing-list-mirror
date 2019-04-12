Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EDD220248
	for <e@80x24.org>; Fri, 12 Apr 2019 12:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfDLMAj (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 08:00:39 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42108 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbfDLMAi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 08:00:38 -0400
Received: by mail-ed1-f68.google.com with SMTP id x61so8075019edc.9
        for <git@vger.kernel.org>; Fri, 12 Apr 2019 05:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TK+BqPyov7hMK2nEAVYNtDmgaj2D2pd0bnVLeYSYIpI=;
        b=BZutH9qNC8QFaZk9lMs/Z1K7TKn0XNye/xTwkJ+ILooFINxp4nes/4QYAPfivuaCfO
         LvNUaRVqwjA6CtQd66fL2KbwJTBKNTNAHSyvzfIpVMK5quY8JrYcRQbzZwihjfcyrQdF
         7nI/MwOv92JnWj85y+N+Zo68sasQkIwkT0kXj5MEkD78TIC2PvseclMxWMDuPhR2haMQ
         t4mg4+FXsnyjyBv5Hvr1hQJzjqACzbBauB0HJ6z6HbMBK5XNqg6C72V9n6mhSa60naW4
         iCqgJk1DCaJVLlToZqzTF1quSat4GUDERlPeZhTCrU5i53C4W/keNGNWH4TL8dWHIzBQ
         ldnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TK+BqPyov7hMK2nEAVYNtDmgaj2D2pd0bnVLeYSYIpI=;
        b=Fmg5Ny34/QzeUyMuE5X1uelueFTNTW1y9Crpyum+qAw609K26/MlHbjsTY11CnQjkC
         i1+dUvwu+UYap6fUKUhKDaRnrYKJgFGBlyajydL7GV2u9pxo8papwptlfICrXn9DcmUr
         laNaAutOb/JhnTPze45VizuNb5QWNOrCJMX5WXsfRG3O88w53GyXhi5BZxi0mQlUm1M9
         D6zX6uKmOTicHBpR5t6ByD6Klpuin2DUcrUChrJjUXuuuyoTATrfxS0NO0uriZvPaQl0
         SGlaI4OiFBzMOAAjU1/QODKCeraBkPZxz4L1Jdvm1Vd1c2ZUCyzrbUFvfNOOsCVXvJX7
         pvyg==
X-Gm-Message-State: APjAAAV1zTc+t3WIAPfyPeYsTAR9HTBaZibRtZJvhQA/XiN76nSQdOic
        lTbvD/tYoafkBfm2BZ+gSAmpM856
X-Google-Smtp-Source: APXvYqx/zBvI3psoAmkTrCC9R9QqatV7RQAQ9rP57polYhOMPtujfdcnW92DNBQwgUSbIEtC2OUk0g==
X-Received: by 2002:a17:906:6406:: with SMTP id d6mr7023174ejm.103.1555070435262;
        Fri, 12 Apr 2019 05:00:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 59sm1806369edy.60.2019.04.12.05.00.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 05:00:34 -0700 (PDT)
Date:   Fri, 12 Apr 2019 05:00:34 -0700 (PDT)
X-Google-Original-Date: Fri, 12 Apr 2019 12:00:27 GMT
Message-Id: <31d8e43cbfaec36f662006a711b64bca47009e59.1555070430.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.168.git.gitgitgadget@gmail.com>
References: <pull.168.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 4/7] docs: exclude documentation for commands that have been
 excluded
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When building with certain build options, some commands are excluded
from the build. For example, `git-credential-cache` is skipped when
building with `NO_UNIX_SOCKETS`.

Let's not build or package documentation for those excluded commands.

This issue was pointed out rightfully when running `make check-docs` on
Windows, where we do not yet have Unix sockets, and therefore the
`credential-cache` command is excluded (yet its documentation was built
and shipped).

Note: building the documentation via `make -C Documentation` leaves the
build system with no way to determine which commands have been
excluded. If called thusly, we gracefully fail to exclude their
documentation. Only when building the documentation via the top-level
Makefile will it get excluded properly, or after building
`Documentation/GIT-EXCLUDED-PROGRAMS` manually.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/.gitignore |  1 +
 Documentation/Makefile   |  3 +++
 Makefile                 | 36 ++++++++++++++++++++----------------
 3 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/Documentation/.gitignore b/Documentation/.gitignore
index 3ef54e0adb..ea27148c59 100644
--- a/Documentation/.gitignore
+++ b/Documentation/.gitignore
@@ -13,3 +13,4 @@ mergetools-*.txt
 manpage-base-url.xsl
 SubmittingPatches.txt
 tmp-doc-diff/
+/GIT-EXCLUDED-PROGRAMS
diff --git a/Documentation/Makefile b/Documentation/Makefile
index af0e2cf11a..e22ea2f57c 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -7,7 +7,10 @@ ARTICLES =
 SP_ARTICLES =
 OBSOLETE_HTML =
 
+-include GIT-EXCLUDED-PROGRAMS
+
 MAN1_TXT += $(filter-out \
+		$(patsubst %,%.txt,$(EXCLUDED_PROGRAMS)) \
 		$(addsuffix .txt, $(ARTICLES) $(SP_ARTICLES)), \
 		$(wildcard git-*.txt))
 MAN1_TXT += git.txt
diff --git a/Makefile b/Makefile
index 5880d4d3a9..a5212c64bf 100644
--- a/Makefile
+++ b/Makefile
@@ -2455,22 +2455,25 @@ $(VCSSVN_LIB): $(VCSSVN_OBJS)
 
 export DEFAULT_EDITOR DEFAULT_PAGER
 
+Documentation/GIT-EXCLUDED-PROGRAMS: Makefile config.mak.uname
+	$(QUIET_GEN)echo "EXCLUDED_PROGRAMS := $(EXCLUDED_PROGRAMS)" >$@
+
 .PHONY: doc man man-perl html info pdf
-doc: man-perl
+doc: man-perl Documentation/GIT-EXCLUDED-PROGRAMS
 	$(MAKE) -C Documentation all
 
-man: man-perl
+man: man-perl Documentation/GIT-EXCLUDED-PROGRAMS
 	$(MAKE) -C Documentation man
 
 man-perl: perl/build/man/man3/Git.3pm
 
-html:
+html: Documentation/GIT-EXCLUDED-PROGRAMS
 	$(MAKE) -C Documentation html
 
-info:
+info: Documentation/GIT-EXCLUDED-PROGRAMS
 	$(MAKE) -C Documentation info
 
-pdf:
+pdf: Documentation/GIT-EXCLUDED-PROGRAMS
 	$(MAKE) -C Documentation pdf
 
 XGETTEXT_FLAGS = \
@@ -2907,33 +2910,33 @@ endif
 install-gitweb:
 	$(MAKE) -C gitweb install
 
-install-doc: install-man-perl
+install-doc: install-man-perl Documentation/GIT-EXCLUDED-PROGRAMS
 	$(MAKE) -C Documentation install
 
-install-man: install-man-perl
+install-man: install-man-perl Documentation/GIT-EXCLUDED-PROGRAMS
 	$(MAKE) -C Documentation install-man
 
-install-man-perl: man-perl
+install-man-perl: man-perl Documentation/GIT-EXCLUDED-PROGRAMS
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(mandir_SQ)/man3'
 	(cd perl/build/man/man3 && $(TAR) cf - .) | \
 	(cd '$(DESTDIR_SQ)$(mandir_SQ)/man3' && umask 022 && $(TAR) xof -)
 
-install-html:
+install-html: Documentation/GIT-EXCLUDED-PROGRAMS
 	$(MAKE) -C Documentation install-html
 
-install-info:
+install-info: Documentation/GIT-EXCLUDED-PROGRAMS
 	$(MAKE) -C Documentation install-info
 
-install-pdf:
+install-pdf: Documentation/GIT-EXCLUDED-PROGRAMS
 	$(MAKE) -C Documentation install-pdf
 
-quick-install-doc:
+quick-install-doc: Documentation/GIT-EXCLUDED-PROGRAMS
 	$(MAKE) -C Documentation quick-install
 
-quick-install-man:
+quick-install-man: Documentation/GIT-EXCLUDED-PROGRAMS
 	$(MAKE) -C Documentation quick-install-man
 
-quick-install-html:
+quick-install-html: Documentation/GIT-EXCLUDED-PROGRAMS
 	$(MAKE) -C Documentation quick-install-html
 
 
@@ -2988,7 +2991,7 @@ artifacts-tar:: $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) $(OTHER_PROGRAMS) \
 htmldocs = git-htmldocs-$(GIT_VERSION)
 manpages = git-manpages-$(GIT_VERSION)
 .PHONY: dist-doc distclean
-dist-doc:
+dist-doc: Documentation/GIT-EXCLUDED-PROGRAMS
 	$(RM) -r .doc-tmp-dir
 	mkdir .doc-tmp-dir
 	$(MAKE) -C Documentation WEBDOC_DEST=../.doc-tmp-dir install-webdoc
@@ -3035,6 +3038,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) $(GIT_TARNAME).tar.gz git-core_$(GIT_VERSION)-*.tar.gz
 	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
 	$(MAKE) -C Documentation/ clean
+	$(RM) Documentation/GIT-EXCLUDED-PROGRAMS
 ifndef NO_PERL
 	$(MAKE) -C gitweb clean
 	$(RM) -r perl/build/
@@ -3062,7 +3066,7 @@ ALL_COMMANDS += gitweb
 ALL_COMMANDS += git-gui git-citool
 
 .PHONY: check-docs
-check-docs::
+check-docs:: Documentation/GIT-EXCLUDED-PROGRAMS
 	$(MAKE) -C Documentation lint-docs
 	@(for v in $(patsubst %$X,%,$(ALL_COMMANDS)); \
 	do \
-- 
gitgitgadget

