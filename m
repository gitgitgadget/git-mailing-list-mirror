Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCF751F404
	for <e@80x24.org>; Wed, 15 Aug 2018 15:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbeHOSHv (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 14:07:51 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37811 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729312AbeHOSHv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 14:07:51 -0400
Received: by mail-wm0-f67.google.com with SMTP id n11-v6so1648179wmc.2
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 08:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gg5GEHfj0PnJmEJ6jS0ZHh6NWFdwbPhHYkR+TtucLgQ=;
        b=cXQ1ZgvBSMUlp9Bzhzf+8j9RuRSo2jiJec+bMRhs2pdoSG//aLUP7qIAJeY12Gj6eJ
         +V1xB+U7uaiq9VNalHuU9+ds6Gd/X+85s6TJOF07Rd3C0QQHlMh15kOIOBZMjS7yaHUH
         nseBccju4phkgsZALgLv9ypal4ALjo1F//co2PCEMoMZyZjQs/8QO4YECSyfLPqFbYae
         ryBRW/KoLxgTp5+/899VmsP2hN0/Fk6z/BybZoxdhhwWAOyRsvYtpr5J4KLSNvgYpQnY
         TNtHTNCc8CRbM0O+QNdK04x7DoMcO9wupy8fxSS2JG6yaIeRlfpMdsnrZcGpYN2aldgC
         n9rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gg5GEHfj0PnJmEJ6jS0ZHh6NWFdwbPhHYkR+TtucLgQ=;
        b=V7k+rnVxeuUKUkoMW69giSggUYpLtPhFZCQWMgWVPMrzpCbWH91R4Ge7tZJDa0Tkf4
         gnQJJ2wnFixodGedJrnSoB5CcCds7zZ5x3kb5nni6eRIM9vkQ8SVAhldhvRrRvsqBkuu
         oGvYlyQ+7sPx16XwyTtdbZvamddgCJ3ceo2SEtdjpLVxlWZXpQ0vXsn+JOAjfC2LaJtf
         3Rgp977gT//FhOB/N91v7XKJnOtX5Hflo8JP5eWPomwqoTF8/C1yLPE6q5ibdBxsD8Uk
         6zWOYbL9dMgeXzLUVkVD6kdGP+Bs0sJgNco8dbO+R3dFYSIG4Gcsua0UmrHpr9rrOsjm
         vfkg==
X-Gm-Message-State: AOUpUlEmWODkpufWCzLSTGaE3dJAZxzXG/jnFa7INNE6owtWtcusyTaA
        XD3B56fQt1hJvRApfVpX5sI11B092Mw=
X-Google-Smtp-Source: AA+uWPw/HW3FUZms05iK5ndYO/3cI4wDm+TwXsY2go5gDHI8b07t2ICbiBLPU1L3qk8pD92S3Wnpuw==
X-Received: by 2002:a1c:3646:: with SMTP id d67-v6mr12877826wma.15.1534346116198;
        Wed, 15 Aug 2018 08:15:16 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l15-v6sm24678104wrt.67.2018.08.15.08.15.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 08:15:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eygene Ryabinkin <rea-git@codelabs.ru>,
        Philip Oakley <philipoakley@iee.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] Makefile: extend NO_TCLTK=NoThanks to cover docs
Date:   Wed, 15 Aug 2018 15:15:05 +0000
Message-Id: <20180815151505.12011-1-avarab@gmail.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend the NO_TCLTK=NoThanks flag to be understood by the
Documentation Makefile.

Before this change compiling and installing with NO_TCLTK would result
in no git-gui, gitk or git-citool being installed, but their
respective manual pages would still be installed.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/Makefile | 23 ++++++++++++++++++-----
 Makefile               | 39 +++++++++++++++++++++------------------
 2 files changed, 39 insertions(+), 23 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index d079d7c73a..d53979939e 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -1,5 +1,7 @@
 # Guard against environment variables
 MAN1_TXT =
+MAN1_TXT_WIP =
+TCLTK_FILES =
 MAN5_TXT =
 MAN7_TXT =
 TECH_DOCS =
@@ -7,13 +9,24 @@ ARTICLES =
 SP_ARTICLES =
 OBSOLETE_HTML =
 
-MAN1_TXT += $(filter-out \
+MAN1_TXT_WIP += $(filter-out \
 		$(addsuffix .txt, $(ARTICLES) $(SP_ARTICLES)), \
 		$(wildcard git-*.txt))
-MAN1_TXT += git.txt
-MAN1_TXT += gitk.txt
-MAN1_TXT += gitremote-helpers.txt
-MAN1_TXT += gitweb.txt
+MAN1_TXT_WIP += git.txt
+MAN1_TXT_WIP += gitremote-helpers.txt
+MAN1_TXT_WIP += gitweb.txt
+
+ifndef NO_TCLTK
+MAN1_TXT_WIP += gitk.txt
+MAN1_TXT = $(MAN1_TXT_WIP)
+else
+TCLTK_FILES += git-gui.txt
+TCLTK_FILES += gitk.txt
+TCLTK_FILES += git-citool.txt
+MAN1_TXT = $(filter-out \
+		$(TCLTK_FILES), \
+		$(MAN1_TXT_WIP))
+endif
 
 MAN5_TXT += gitattributes.txt
 MAN5_TXT += githooks.txt
diff --git a/Makefile b/Makefile
index bc4fc8eeab..8abb23f6ce 100644
--- a/Makefile
+++ b/Makefile
@@ -2372,21 +2372,21 @@ export DEFAULT_EDITOR DEFAULT_PAGER
 
 .PHONY: doc man man-perl html info pdf
 doc: man-perl
-	$(MAKE) -C Documentation all
+	$(MAKE) -C Documentation all NO_TCLTK='$(NO_TCLTK)'
 
 man: man-perl
-	$(MAKE) -C Documentation man
+	$(MAKE) -C Documentation man NO_TCLTK='$(NO_TCLTK)'
 
 man-perl: perl/build/man/man3/Git.3pm
 
 html:
-	$(MAKE) -C Documentation html
+	$(MAKE) -C Documentation html NO_TCLTK='$(NO_TCLTK)'
 
 info:
-	$(MAKE) -C Documentation info
+	$(MAKE) -C Documentation info NO_TCLTK='$(NO_TCLTK)'
 
 pdf:
-	$(MAKE) -C Documentation pdf
+	$(MAKE) -C Documentation pdf NO_TCLTK='$(NO_TCLTK)'
 
 XGETTEXT_FLAGS = \
 	--force-po \
@@ -2802,10 +2802,10 @@ install-gitweb:
 	$(MAKE) -C gitweb install
 
 install-doc: install-man-perl
-	$(MAKE) -C Documentation install
+	$(MAKE) -C Documentation install NO_TCLTK='$(NO_TCLTK)'
 
 install-man: install-man-perl
-	$(MAKE) -C Documentation install-man
+	$(MAKE) -C Documentation install-man NO_TCLTK='$(NO_TCLTK)'
 
 install-man-perl: man-perl
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(mandir_SQ)/man3'
@@ -2813,22 +2813,22 @@ install-man-perl: man-perl
 	(cd '$(DESTDIR_SQ)$(mandir_SQ)/man3' && umask 022 && $(TAR) xof -)
 
 install-html:
-	$(MAKE) -C Documentation install-html
+	$(MAKE) -C Documentation install-html NO_TCLTK='$(NO_TCLTK)'
 
 install-info:
-	$(MAKE) -C Documentation install-info
+	$(MAKE) -C Documentation install-info NO_TCLTK='$(NO_TCLTK)'
 
 install-pdf:
-	$(MAKE) -C Documentation install-pdf
+	$(MAKE) -C Documentation install-pdf NO_TCLTK='$(NO_TCLTK)'
 
 quick-install-doc:
-	$(MAKE) -C Documentation quick-install
+	$(MAKE) -C Documentation quick-install NO_TCLTK='$(NO_TCLTK)'
 
 quick-install-man:
-	$(MAKE) -C Documentation quick-install-man
+	$(MAKE) -C Documentation quick-install-man NO_TCLTK='$(NO_TCLTK)'
 
 quick-install-html:
-	$(MAKE) -C Documentation quick-install-html
+	$(MAKE) -C Documentation quick-install-html NO_TCLTK='$(NO_TCLTK)'
 
 
 
@@ -2875,13 +2875,16 @@ manpages = git-manpages-$(GIT_VERSION)
 dist-doc:
 	$(RM) -r .doc-tmp-dir
 	mkdir .doc-tmp-dir
-	$(MAKE) -C Documentation WEBDOC_DEST=../.doc-tmp-dir install-webdoc
+	$(MAKE) -C Documentation NO_TCLTK='$(NO_TCLTK)' \
+		WEBDOC_DEST=../.doc-tmp-dir install-webdoc
 	cd .doc-tmp-dir && $(TAR) cf ../$(htmldocs).tar .
 	gzip -n -9 -f $(htmldocs).tar
 	:
 	$(RM) -r .doc-tmp-dir
 	mkdir -p .doc-tmp-dir/man1 .doc-tmp-dir/man5 .doc-tmp-dir/man7
-	$(MAKE) -C Documentation DESTDIR=./ \
+	$(MAKE) -C Documentation \
+		NO_TCLTK='$(NO_TCLTK)' \
+		DESTDIR=./ \
 		man1dir=../.doc-tmp-dir/man1 \
 		man5dir=../.doc-tmp-dir/man5 \
 		man7dir=../.doc-tmp-dir/man7 \
@@ -2915,7 +2918,7 @@ clean: profile-clean coverage-clean
 	$(RM) $(GIT_TARNAME).tar.gz git-core_$(GIT_VERSION)-*.tar.gz
 	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
 	$(RM) contrib/coccinelle/*.cocci.patch*
-	$(MAKE) -C Documentation/ clean
+	$(MAKE) -C Documentation/ clean NO_TCLTK='$(NO_TCLTK)'
 ifndef NO_PERL
 	$(MAKE) -C gitweb clean
 	$(RM) -r perl/build/
@@ -2944,7 +2947,7 @@ ALL_COMMANDS += git-gui git-citool
 
 .PHONY: check-docs
 check-docs::
-	$(MAKE) -C Documentation lint-docs
+	$(MAKE) -C Documentation lint-docs NO_TCLTK='$(NO_TCLTK)'
 	@(for v in $(ALL_COMMANDS); \
 	do \
 		case "$$v" in \
@@ -2968,7 +2971,7 @@ check-docs::
 		    -e '/^#/d' \
 		    -e 's/[ 	].*//' \
 		    -e 's/^/listed /' command-list.txt; \
-		$(MAKE) -C Documentation print-man1 | \
+		$(MAKE) -C Documentation print-man1  NO_TCLTK='$(NO_TCLTK)' | \
 		grep '\.txt$$' | \
 		sed -e 's|Documentation/|documented |' \
 		    -e 's/\.txt//'; \
-- 
2.18.0.865.gffc8e1a3cd6

