Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A61991F453
	for <e@80x24.org>; Fri,  2 Nov 2018 22:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbeKCHq5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 03:46:57 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36163 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728318AbeKCHq5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 03:46:57 -0400
Received: by mail-wr1-f66.google.com with SMTP id z13-v6so1066944wrs.3
        for <git@vger.kernel.org>; Fri, 02 Nov 2018 15:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zHj5VizSg9THNiGlpS3vTyJpAYrkVmSmFOyLy0fyiCc=;
        b=ul6OHjLupabLkNb7rsmB/hoB2+8G0HvZPpi6MDumLEDYRlT1jJB3Nj753CBDiABDW0
         w9rXSPNJ6vg5qjif9gHD92WgH7hyqD0c4m9qI/0Ady4XJ073Z4vpcUo91NXqurRcZitr
         t0MyEHk7neH8FgurfmUaQZyGb21lPYM/Xa2dRT3d+Q5hMookNe8C5KwONNGmwaRtngtd
         hMBmwUKXAUM2P4Yjv3pbYBrfST0XawIt2N4v/wrAI18zZoPYz7f0gIEGoiQIuJEOKyi2
         w/MAPWPgCd8f3aeGX/iuM2FSK5knfn1u1adMXonE4aoTw16hokuUMDC3t4JxxubllSkK
         yAsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zHj5VizSg9THNiGlpS3vTyJpAYrkVmSmFOyLy0fyiCc=;
        b=WqidJ91n9J6IOc769fOP9yKBf0/wIP92VJ6p/3rQP4KgcvcN0m9xEpJDBZ6YF9Zi3l
         8Sdd1eS6cwNJABEvCHbDhsuKmvnJ+oQrwmJc4pJaDxQCMlgpGfTAZXXt0iP1fzSlpI48
         ovTNyt/m2iFNRFSkCwWPYtutoFQoSk0BRiPHbwV7qxfJo8UGm3sdCmUnzEa/Hy1qCkte
         oIjxktx0KVV4eAzk3tFxVGswxdnltUVVfolSksmSE2M20aNuJ1WyBMv3x0Vb4hNiEJl4
         mCoLxdEPnN0aYRHZu+oBtbr1QDDx5dxPOGDY/CURhgDXfoS4LcxYjznKU6/GDvhNFdID
         0YBA==
X-Gm-Message-State: AGRZ1gIibPuptEhhwTqhqS+c8lFcdr4YSqu1mhJEgchZpXyuJjJEpfTP
        e8aV5ju5QbCSd468vMDERXOWWGw/
X-Google-Smtp-Source: AJdET5dfflYXX+EU3LqFugCTa/Xh658kZyvFYFcOp9nlzV4CXokNvCmRP96zJLgPhW8SddHSyxjJlA==
X-Received: by 2002:adf:cf02:: with SMTP id o2-v6mr12443897wrj.258.1541198275036;
        Fri, 02 Nov 2018 15:37:55 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id a12-v6sm21461469wrr.71.2018.11.02.15.37.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 15:37:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Daniel Jacques <dnj@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Steffen Prohaska <prohaska@zib.de>,
        John Keeping <john@keeping.me.uk>, Stan Hu <stanhu@gmail.com>,
        Richard Clamp <richardc@unixbeard.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC/PATCH 1/5] Makefile: move long inline shell loops in "install" into helper
Date:   Fri,  2 Nov 2018 22:37:39 +0000
Message-Id: <20181102223743.4331-2-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0
In-Reply-To: <87efkkdwcv.fsf@evledraar.gmail.com>
References: <87efkkdwcv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move a 37 line for-loop mess out of "install" and into a helper
script. This started out fairly innocent but over the years has grown
into a hard-to-maintain monster, and my recent ad874608d8 ("Makefile:
optionally symlink libexec/git-core binaries to bin/git", 2018-03-13)
certainly didn't help.

The shell code is ported pretty much as-is (with getopts added), it'll
be fixed & prettified in subsequent commits.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile         | 52 ++++++++--------------------
 install_programs | 89 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+), 38 deletions(-)
 create mode 100755 install_programs

diff --git a/Makefile b/Makefile
index bbfbb4292d..aa6ca1fa68 100644
--- a/Makefile
+++ b/Makefile
@@ -2808,44 +2808,20 @@ endif
 	bindir=$$(cd '$(DESTDIR_SQ)$(bindir_SQ)' && pwd) && \
 	execdir=$$(cd '$(DESTDIR_SQ)$(gitexec_instdir_SQ)' && pwd) && \
 	destdir_from_execdir_SQ=$$(echo '$(gitexecdir_relative_SQ)' | sed -e 's|[^/][^/]*|..|g') && \
-	{ test "$$bindir/" = "$$execdir/" || \
-	  for p in git$X $(filter $(install_bindir_programs),$(ALL_PROGRAMS)); do \
-		$(RM) "$$execdir/$$p" && \
-		test -n "$(INSTALL_SYMLINKS)" && \
-		ln -s "$$destdir_from_execdir_SQ/$(bindir_relative_SQ)/$$p" "$$execdir/$$p" || \
-		{ test -z "$(NO_INSTALL_HARDLINKS)$(NO_CROSS_DIRECTORY_HARDLINKS)" && \
-		  ln "$$bindir/$$p" "$$execdir/$$p" 2>/dev/null || \
-		  cp "$$bindir/$$p" "$$execdir/$$p" || exit; } \
-	  done; \
-	} && \
-	for p in $(filter $(install_bindir_programs),$(BUILT_INS)); do \
-		$(RM) "$$bindir/$$p" && \
-		test -n "$(INSTALL_SYMLINKS)" && \
-		ln -s "git$X" "$$bindir/$$p" || \
-		{ test -z "$(NO_INSTALL_HARDLINKS)" && \
-		  ln "$$bindir/git$X" "$$bindir/$$p" 2>/dev/null || \
-		  ln -s "git$X" "$$bindir/$$p" 2>/dev/null || \
-		  cp "$$bindir/git$X" "$$bindir/$$p" || exit; } \
-	done && \
-	for p in $(BUILT_INS); do \
-		$(RM) "$$execdir/$$p" && \
-		test -n "$(INSTALL_SYMLINKS)" && \
-		ln -s "$$destdir_from_execdir_SQ/$(bindir_relative_SQ)/git$X" "$$execdir/$$p" || \
-		{ test -z "$(NO_INSTALL_HARDLINKS)" && \
-		  ln "$$execdir/git$X" "$$execdir/$$p" 2>/dev/null || \
-		  ln -s "git$X" "$$execdir/$$p" 2>/dev/null || \
-		  cp "$$execdir/git$X" "$$execdir/$$p" || exit; } \
-	done && \
-	remote_curl_aliases="$(REMOTE_CURL_ALIASES)" && \
-	for p in $$remote_curl_aliases; do \
-		$(RM) "$$execdir/$$p" && \
-		test -n "$(INSTALL_SYMLINKS)" && \
-		ln -s "git-remote-http$X" "$$execdir/$$p" || \
-		{ test -z "$(NO_INSTALL_HARDLINKS)" && \
-		  ln "$$execdir/git-remote-http$X" "$$execdir/$$p" 2>/dev/null || \
-		  ln -s "git-remote-http$X" "$$execdir/$$p" 2>/dev/null || \
-		  cp "$$execdir/git-remote-http$X" "$$execdir/$$p" || exit; } \
-	done && \
+	./install_programs \
+		--X="$$X" \
+		--RM="$(RM)" \
+		--bindir="$$bindir" \
+		--bindir-relative="$(bindir_relative_SQ)" \
+		--execdir="$$execdir" \
+		--destdir-from-execdir="$$destdir_from_execdir_SQ" \
+		--flag-install-symlinks="$(INSTALL_SYMLINKS)" \
+		--flag-no-install-hardlinks="$(NO_INSTALL_HARDLINKS)" \
+		--flag-no-cross-directory-hardlinks="$(NO_CROSS_DIRECTORY_HARDLINKS)" \
+		--list-bindir-standalone="git$X $(filter $(install_bindir_programs),$(ALL_PROGRAMS))" \
+		--list-bindir-git-dashed="$(filter $(install_bindir_programs),$(BUILT_INS))" \
+		--list-execdir-git-dashed="$(BUILT_INS)" \
+		--list-execdir-curl-aliases="$(REMOTE_CURL_ALIASES)" && \
 	./check_bindir "z$$bindir" "z$$execdir" "$$bindir/git-add$X"
 
 .PHONY: install-gitweb install-doc install-man install-man-perl install-html install-info install-pdf
diff --git a/install_programs b/install_programs
new file mode 100755
index 0000000000..e287108112
--- /dev/null
+++ b/install_programs
@@ -0,0 +1,89 @@
+#!/bin/sh
+
+while test $# != 0
+do
+	case "$1" in
+	--X=*)
+		X="${1#--X=}"
+		;;
+	--RM=*)
+		RM="${1#--RM=}"
+		;;
+	--bindir=*)
+		bindir="${1#--bindir=}"
+		;;
+	--bindir-relative=*)
+		bindir_relative="${1#--bindir-relative=}"
+		;;
+	--execdir=*)
+		execdir="${1#--execdir=}"
+		;;
+	--destdir-from-execdir=*)
+		destdir_from_execdir="${1#--destdir-from-execdir=}"
+		;;
+	--flag-install-symlinks=*)
+		INSTALL_SYMLINKS="${1#--flag-install-symlinks=}"
+		;;
+	--flag-no-install-hardlinks=*)
+		NO_INSTALL_HARDLINKS="${1#--flag-no-install-hardlinks=}"
+		;;
+	--flag-no-cross-directory-hardlinks=*)
+		NO_CROSS_DIRECTORY_HARDLINKS="${1#--flag-no-cross-directory-hardlinks=}"
+		;;
+	--list-bindir-standalone=*)
+		list_bindir_standalone="${1#--list-bindir-standalone=}"
+		;;
+	--list-bindir-git-dashed=*)
+		list_bindir_git_dashed="${1#--list-bindir-git-dashed=}"
+		;;
+	--list-execdir-git-dashed=*)
+		list_execdir_git_dashed="${1#--list-execdir-git-dashed=}"
+		;;
+	--list-execdir-curl-aliases=*)
+		list_execdir_curl_aliases="${1#--list-execdir-curl-aliases=}"
+		;;
+
+	*)
+		echo "Unknown option $1"
+		exit 1
+		;;
+	esac
+	shift
+done &&
+{ test "$bindir/" = "$execdir/" ||
+  for p in $list_bindir_standalone; do
+	$RM "$execdir/$p" &&
+	test -n "$INSTALL_SYMLINKS" &&
+	ln -s "$destdir_from_execdir/$bindir_relative/$p" "$execdir/$p" ||
+	{ test -z "$NO_INSTALL_HARDLINKS$NO_CROSS_DIRECTORY_HARDLINKS" &&
+	  ln "$bindir/$p" "$execdir/$p" 2>/dev/null ||
+	  cp "$bindir/$p" "$execdir/$p" || exit; }
+  done;
+} &&
+for p in $list_bindir_git_dashed; do
+	$RM "$bindir/$p" &&
+	test -n "$INSTALL_SYMLINKS" &&
+	ln -s "git$X" "$bindir/$p" ||
+	{ test -z "$NO_INSTALL_HARDLINKS" &&
+	  ln "$bindir/git$X" "$bindir/$p" 2>/dev/null ||
+	  ln -s "git$X" "$bindir/$p" 2>/dev/null ||
+	  cp "$bindir/git$X" "$bindir/$p" || exit; }
+done &&
+for p in $list_execdir_git_dashed; do
+	$RM "$execdir/$p" &&
+	test -n "$INSTALL_SYMLINKS" &&
+	ln -s "$destdir_from_execdir/$bindir_relative/git$X" "$execdir/$p" ||
+	{ test -z "$NO_INSTALL_HARDLINKS" &&
+	  ln "$execdir/git$X" "$execdir/$p" 2>/dev/null ||
+	  ln -s "git$X" "$execdir/$p" 2>/dev/null ||
+	  cp "$execdir/git$X" "$execdir/$p" || exit; }
+done &&
+for p in $list_execdir_curl_aliases; do
+	$RM "$execdir/$p" &&
+	test -n "$INSTALL_SYMLINKS" &&
+	ln -s "git-remote-http$X" "$execdir/$p" ||
+	{ test -z "$NO_INSTALL_HARDLINKS" &&
+	  ln "$execdir/git-remote-http$X" "$execdir/$p" 2>/dev/null ||
+	  ln -s "git-remote-http$X" "$execdir/$p" 2>/dev/null ||
+	  cp "$execdir/git-remote-http$X" "$execdir/$p" || exit; }
+done
-- 
2.19.1.930.g4563a0d9d0

