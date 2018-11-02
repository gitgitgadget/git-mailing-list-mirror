Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C58F1F453
	for <e@80x24.org>; Fri,  2 Nov 2018 22:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbeKCHq6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 03:46:58 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37501 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728359AbeKCHq6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 03:46:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id z3-v6so3459045wru.4
        for <git@vger.kernel.org>; Fri, 02 Nov 2018 15:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0mG5HYtasFXHR/13Bu2eg6gFNOYVTofoWcqgaq3pv9Y=;
        b=hG6Rh6SK6LyuxZHx3gdxNI2x397L2TP1gUuqgB3OBLxLe1CoxtEC+dSDWTbGoRYs6n
         CXIx6AuxF5atDRz/5vh+DMfaqSa+BkCI2IUueiBCBD1vVpGeUsv67UPXMsZKzFX7+bQI
         rb+Q7yy9g1Z19O6QrBpKR4RWOa5o1ushE1HPFOMsRlLnyhCRNOepYq4uYLTAWjglLfDR
         wBudYaI5efE6+477nc6ru11UvsuU+6iq/zzpgGtgNbHQbF1MXATx0m+M6ZcvEmzflB5R
         mLbEom5hsBdiu1+IIvuXh8dr3SjIGrnpyz/uQDUhrO3TB6u7lTaXcRFgTiX9XANBU4dn
         Ku5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0mG5HYtasFXHR/13Bu2eg6gFNOYVTofoWcqgaq3pv9Y=;
        b=Hgcrj+pgZfFj0h7h9poOanrFDmxxDq25a5qQkOhqpmkW95pzD0XwA9CAzQtZv9ZLkC
         uXTApyzjU4xiJ1QE2T3dm/tBF4zJbF5JE0pFuDNNYGQXoo2Kb/ADz+BZmk8rFfrRg89U
         C06+JxxbwWZglCuCBfaSnL374N52VkyFqWKyT8VLSZZb5WDpSFE9OBLZdN4BtQ8bo2nF
         6446rNzyAdaHlvPY8fhC2b7bGLLORGoGLQcdvlYu6R1b1hg7YXrQ16qpmVPoMiwyj+FQ
         h+FL8yEeEUipjTVvtbt2t5jweejp6JuYG5R2ZnXF7NVEcKQIJet6iXYy3OjUCoaOYLqT
         RmiQ==
X-Gm-Message-State: AGRZ1gJPVit6E1k3QgQ/ZOHjN9WXlZRa4/d32qwUAdhF6UEGhWBXpplz
        8sRFhscjxa7RlWvrNtlnEhfDtz3v
X-Google-Smtp-Source: AJdET5fsGDlYh3kUtp3hfzfPz5XdF5evBjrMHYw3P/5xIjx4Ovref67MTAa8XwMstGkyn8hBO3H0qw==
X-Received: by 2002:adf:f082:: with SMTP id n2-v6mr7379578wro.88.1541198276533;
        Fri, 02 Nov 2018 15:37:56 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id a12-v6sm21461469wrr.71.2018.11.02.15.37.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 15:37:55 -0700 (PDT)
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
Subject: [RFC/PATCH 2/5] Makefile: conform some of the code to our coding standards
Date:   Fri,  2 Nov 2018 22:37:40 +0000
Message-Id: <20181102223743.4331-3-avarab@gmail.com>
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

This code is still very much unlike our usual style since it was
lifted from the Makefile, but we can at least make some of it use the
usual style and line spacing.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 install_programs | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/install_programs b/install_programs
index e287108112..d3333cd25f 100755
--- a/install_programs
+++ b/install_programs
@@ -50,17 +50,21 @@ do
 	esac
 	shift
 done &&
-{ test "$bindir/" = "$execdir/" ||
-  for p in $list_bindir_standalone; do
-	$RM "$execdir/$p" &&
-	test -n "$INSTALL_SYMLINKS" &&
-	ln -s "$destdir_from_execdir/$bindir_relative/$p" "$execdir/$p" ||
-	{ test -z "$NO_INSTALL_HARDLINKS$NO_CROSS_DIRECTORY_HARDLINKS" &&
-	  ln "$bindir/$p" "$execdir/$p" 2>/dev/null ||
-	  cp "$bindir/$p" "$execdir/$p" || exit; }
-  done;
-} &&
-for p in $list_bindir_git_dashed; do
+
+if test "$bindir/" != "$execdir/"
+then
+	for p in $list_bindir_standalone; do
+		$RM "$execdir/$p" &&
+		test -n "$INSTALL_SYMLINKS" &&
+		ln -s "$destdir_from_execdir/$bindir_relative/$p" "$execdir/$p" ||
+		{ test -z "$NO_INSTALL_HARDLINKS$NO_CROSS_DIRECTORY_HARDLINKS" &&
+		  ln "$bindir/$p" "$execdir/$p" 2>/dev/null ||
+		  cp "$bindir/$p" "$execdir/$p" || exit; }
+	done
+fi &&
+
+for p in $list_bindir_git_dashed
+do
 	$RM "$bindir/$p" &&
 	test -n "$INSTALL_SYMLINKS" &&
 	ln -s "git$X" "$bindir/$p" ||
@@ -69,6 +73,7 @@ for p in $list_bindir_git_dashed; do
 	  ln -s "git$X" "$bindir/$p" 2>/dev/null ||
 	  cp "$bindir/git$X" "$bindir/$p" || exit; }
 done &&
+
 for p in $list_execdir_git_dashed; do
 	$RM "$execdir/$p" &&
 	test -n "$INSTALL_SYMLINKS" &&
@@ -78,6 +83,7 @@ for p in $list_execdir_git_dashed; do
 	  ln -s "git$X" "$execdir/$p" 2>/dev/null ||
 	  cp "$execdir/git$X" "$execdir/$p" || exit; }
 done &&
+
 for p in $list_execdir_curl_aliases; do
 	$RM "$execdir/$p" &&
 	test -n "$INSTALL_SYMLINKS" &&
-- 
2.19.1.930.g4563a0d9d0

