Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43D4320248
	for <e@80x24.org>; Thu, 18 Apr 2019 13:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388343AbfDRNQt (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Apr 2019 09:16:49 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46767 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388406AbfDRNQs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Apr 2019 09:16:48 -0400
Received: by mail-ed1-f68.google.com with SMTP id d1so1741607edd.13
        for <git@vger.kernel.org>; Thu, 18 Apr 2019 06:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=U/atmtP1TqN6Qofgb+CnGvxkPNH26y6LICkkBmVIcWM=;
        b=MLCnDMuPBYc0HJjOCmPHpKZyOiHVXONBA6OBLr5EzIesMJtcMV87DJYyKZmlZXOuSa
         COWH7OFHghhd/AO1qukzWKYcImAcofqBejmCh5bkZpQIWsC0JbIyso9/+jay4BNR1eds
         zZz9fqofWsiDusM92mRp9PwwirwYMZphyp/oj7iFEwdtvBRZbxiPOEyBK1MAEyNN7Klq
         2+IYv7o4MZKnTUJ8KLHe0yfGiHo31GwHvKksjJjV69do72gV5RMdqousoF3iJwuwLPHk
         2K43nbJ2gmCjkcO7vfaSXEZzUVom0ICekYA5fJpyi4kAoL1hsGYLkQNlOuJD4V15N5ba
         Ryyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=U/atmtP1TqN6Qofgb+CnGvxkPNH26y6LICkkBmVIcWM=;
        b=p3U7UQuqa+ffxwVIo/HpyS0vsDB2IJWa6oliOlCCyoPtCL8h04CuYAzzvGTzxuM6Fx
         zy+W/ssYGTSa4/MatKlGI/u22pBEweGoJkYSZ5yoXV+PQlsoikRWFOClZQkJMxEkUzL4
         U+lrpKayJJjHtn0Wavm2MDYluqSG8Av5mRwDPhIrPwJ9RhSjJ22lF0El1Vhk8++o/UVu
         IgSX4BxQuHhEsCRWcPD10EeMDOUKfAIQS9snCfkOELkGT+jrCODQyxY0OdXDMHSfhLGe
         SuiyxxGMGTJAG47PLQgGhXQCiHm4zy00yFINElVhYRCQmfKU7l4dq++x+2t+JofZEsxL
         6PVA==
X-Gm-Message-State: APjAAAUWZoA2h0w7D84yuTBiGlzOF6TEpOCfIeanBegRmLP/ZL/E9UBy
        XKu5h1mr51UlCbr4LUE1YsMpJqdL
X-Google-Smtp-Source: APXvYqxzpgkEuQDcQPyH9e+/d3A4Q22aZ3uZpkTv4aJprAiNWpXTj7T310ukf2g/UzngyYCYV5vlQw==
X-Received: by 2002:a17:906:5ad6:: with SMTP id x22mr47256031ejs.79.1555593405875;
        Thu, 18 Apr 2019 06:16:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r29sm511166eda.37.2019.04.18.06.16.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 06:16:44 -0700 (PDT)
Date:   Thu, 18 Apr 2019 06:16:44 -0700 (PDT)
X-Google-Original-Date: Thu, 18 Apr 2019 13:16:33 GMT
Message-Id: <f8d133c59725938afa85f6be349c2bba05fe98e7.1555593396.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.168.v2.git.gitgitgadget@gmail.com>
References: <pull.168.git.gitgitgadget@gmail.com>
        <pull.168.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 5/8] docs: exclude documentation for commands that have
 been excluded
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
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
 Documentation/.gitignore | 1 +
 Documentation/Makefile   | 3 +++
 Makefile                 | 9 +++++++++
 3 files changed, 13 insertions(+)

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
index d83104d884..6f90cec590 100644
--- a/Makefile
+++ b/Makefile
@@ -2451,6 +2451,14 @@ $(VCSSVN_LIB): $(VCSSVN_OBJS)
 
 export DEFAULT_EDITOR DEFAULT_PAGER
 
+Documentation/GIT-EXCLUDED-PROGRAMS: FORCE
+	@EXCLUDED='EXCLUDED_PROGRAMS := $(EXCLUDED_PROGRAMS)'; \
+	    if test x"$$EXCLUDED" != \
+		x"`cat Documentation/GIT-EXCLUDED-PROGRAMS 2>/dev/null`" ; then \
+		echo >&2 "    * new documentation flags"; \
+		echo "$$EXCLUDED" >Documentation/GIT-EXCLUDED-PROGRAMS; \
+            fi
+
 .PHONY: doc man man-perl html info pdf
 doc: man-perl
 	$(MAKE) -C Documentation all
@@ -3030,6 +3038,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) $(GIT_TARNAME).tar.gz git-core_$(GIT_VERSION)-*.tar.gz
 	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
 	$(MAKE) -C Documentation/ clean
+	$(RM) Documentation/GIT-EXCLUDED-PROGRAMS
 ifndef NO_PERL
 	$(MAKE) -C gitweb clean
 	$(RM) -r perl/build/
-- 
gitgitgadget

