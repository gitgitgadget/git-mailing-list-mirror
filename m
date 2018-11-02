Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 155801F453
	for <e@80x24.org>; Fri,  2 Nov 2018 22:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbeKCHrB (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 03:47:01 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34621 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728359AbeKCHrB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 03:47:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id j26-v6so3471684wre.1
        for <git@vger.kernel.org>; Fri, 02 Nov 2018 15:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZFdXPt83C7+I5xxrBX6P6Cl/LoZ4X/I57xbBvhThYf0=;
        b=QhkWqz23oUQNd601+bcNL9Lwh7JMuMwc9gQFKe4cTTHn0VpTMiiSksO390vLfAPK23
         ERlUvIPENrpQTR+FwSahKpivwsZUytw69v5BbFFYNb2+RpWB9/yf0pLUT9PBFb3XZbTT
         U7F+LuE+4KZNiug8ATf5lTfPE/ztGZSXaaHM8JQwVeoE13gbNF9LymtEvvXo8njxcg2b
         G3+muJkkeMc5WarTNGJRz0XR7zKAn7BCbUDAD1GdSv5cM8VbxvFltb/VCp8AXIlrrsuO
         jI1ExFGBuwsL6Jxf2SvSwPnl5lTJNtBA0zxdOEOykaZrPQG4Ft9Gl9uF8ffL6xJd7QSX
         MHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZFdXPt83C7+I5xxrBX6P6Cl/LoZ4X/I57xbBvhThYf0=;
        b=tf7+ckNagW/+9XJS5s8CrPMssbUJ6Caprm3VoGZYbnFNZ/iRGiEWpUxfSDwGC05D3g
         cAxKCmhyAgSj34aa9+jj7fmPLjPE9+iK5W3bi6JFSMz9+posnJVz+TvyomWCpEU/QO0y
         JdncwdmsSELtN67cF+lNL2evEvWZLPJ2aU4avcmZNNj2Mwhub7GzTyGP4DNZVYnD8sAR
         +uQB4oXbWeJjxkGpQawwn0jsKpJYIcAV7ahXtH16Cd5x7zTMGvXDNWrmBy0XKo+IAXs6
         emf5XYl8OOiqyyQbJrJgVZaiCsTKZGFu1KIsIV9KZMTtxIQDtwZD9YHaYQHN0TWWMEOb
         arAQ==
X-Gm-Message-State: AGRZ1gKQ3BmvToQobGEBGT2FYQ1krgxplwYJuz65Hc6bZLygn/zIA2Gs
        dIrcjRRnyDSu6Yt+dwsNUGV1t9VaxgM=
X-Google-Smtp-Source: AJdET5dyGu5wGKClQvWHVCzCQqXyPSV9UNEQDIg+JlXTTtiYnYQeEhRs8CO8WuvKD+UokxzOV1Otlw==
X-Received: by 2002:adf:bb0f:: with SMTP id r15-v6mr11745138wrg.24.1541198279738;
        Fri, 02 Nov 2018 15:37:59 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id a12-v6sm21461469wrr.71.2018.11.02.15.37.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 15:37:59 -0700 (PDT)
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
Subject: [RFC/PATCH 4/5] Makefile: add NO_INSTALL_SYMLINKS_FALLBACK switch
Date:   Fri,  2 Nov 2018 22:37:42 +0000
Message-Id: <20181102223743.4331-5-avarab@gmail.com>
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

Add a switch for use in conjunction with the INSTALL_SYMLINKS flag
added in ad874608d8 ("Makefile: optionally symlink libexec/git-core
binaries to bin/git", 2018-03-13).

Now it's possible to install git with:

    INSTALL_SYMLINKS=YesPlease NO_INSTALL_SYMLINKS_FALLBACK=YesPlease

And know for sure that there's not going to be any silent fallbacks on
hardlinks or copying of files if symlinking fails.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile         |  5 ++++
 install_programs | 69 ++++++++++++++++++++++++++++++++----------------
 2 files changed, 51 insertions(+), 23 deletions(-)

diff --git a/Makefile b/Makefile
index aa6ca1fa68..07c8b74353 100644
--- a/Makefile
+++ b/Makefile
@@ -342,6 +342,10 @@ all::
 # within the same directory in some cases, INSTALL_SYMLINKS will
 # always symlink to the final target directly.
 #
+# Define NO_INSTALL_SYMLINKS_FALLBACK if in conjunction with
+# INSTALL_SYMLINKS if you'd prefer not to have the install procedure
+# fallack on hardlinking or copying if "ln -s" fails.
+#
 # Define NO_CROSS_DIRECTORY_HARDLINKS if you plan to distribute the installed
 # programs as a tar, where bin/ and libexec/ might be on different file systems.
 #
@@ -2818,6 +2822,7 @@ endif
 		--flag-install-symlinks="$(INSTALL_SYMLINKS)" \
 		--flag-no-install-hardlinks="$(NO_INSTALL_HARDLINKS)" \
 		--flag-no-cross-directory-hardlinks="$(NO_CROSS_DIRECTORY_HARDLINKS)" \
+		--flag-no-install-symlinks-fallback="$(NO_INSTALL_SYMLINKS_FALLBACK)" \
 		--list-bindir-standalone="git$X $(filter $(install_bindir_programs),$(ALL_PROGRAMS))" \
 		--list-bindir-git-dashed="$(filter $(install_bindir_programs),$(BUILT_INS))" \
 		--list-execdir-git-dashed="$(BUILT_INS)" \
diff --git a/install_programs b/install_programs
index 367e9a6cdf..51e08019dd 100755
--- a/install_programs
+++ b/install_programs
@@ -30,6 +30,9 @@ do
 	--flag-no-cross-directory-hardlinks=*)
 		NO_CROSS_DIRECTORY_HARDLINKS="${1#--flag-no-cross-directory-hardlinks=}"
 		;;
+	--flag-no-install-symlinks-fallback=*)
+		NO_INSTALL_SYMLINKS_FALLBACK="${1#--flag-no-install-symlinks-fallback=}"
+		;;
 	--list-bindir-standalone=*)
 		list_bindir_standalone="${1#--list-bindir-standalone=}"
 		;;
@@ -55,41 +58,61 @@ if test "$bindir/" != "$execdir/"
 then
 	for p in $list_bindir_standalone; do
 		$RM "$execdir/$p" &&
-		test -n "$INSTALL_SYMLINKS" &&
-		ln -s "$destdir_from_execdir/$bindir_relative/$p" "$execdir/$p" ||
-		{ test -z "$NO_INSTALL_HARDLINKS$NO_CROSS_DIRECTORY_HARDLINKS" &&
-		  ln "$bindir/$p" "$execdir/$p" ||
-		  cp "$bindir/$p" "$execdir/$p" || exit; }
+		if test -n "$INSTALL_SYMLINKS" -a -n "$NO_INSTALL_SYMLINKS_FALLBACK"
+		then
+			ln -s "$destdir_from_execdir/$bindir_relative/$p" "$execdir/$p"
+		else
+			test -n "$INSTALL_SYMLINKS" &&
+			ln -s "$destdir_from_execdir/$bindir_relative/$p" "$execdir/$p" ||
+			{ test -z "$NO_INSTALL_HARDLINKS$NO_CROSS_DIRECTORY_HARDLINKS" &&
+			  ln "$bindir/$p" "$execdir/$p" ||
+			  cp "$bindir/$p" "$execdir/$p" || exit; }
+		fi
 	done
 fi &&
 
 for p in $list_bindir_git_dashed
 do
 	$RM "$bindir/$p" &&
-	test -n "$INSTALL_SYMLINKS" &&
-	ln -s "git$X" "$bindir/$p" ||
-	{ test -z "$NO_INSTALL_HARDLINKS" &&
-	  ln "$bindir/git$X" "$bindir/$p" ||
-	  ln -s "git$X" "$bindir/$p" ||
-	  cp "$bindir/git$X" "$bindir/$p" || exit; }
+	if test -n "$INSTALL_SYMLINKS" -a -n "$NO_INSTALL_SYMLINKS_FALLBACK"
+	then
+		ln -s "git$X" "$bindir/$p"
+	else
+		test -n "$INSTALL_SYMLINKS" &&
+		ln -s "git$X" "$bindir/$p" ||
+		{ test -z "$NO_INSTALL_HARDLINKS" &&
+		  ln "$bindir/git$X" "$bindir/$p" ||
+		  ln -s "git$X" "$bindir/$p" ||
+		  cp "$bindir/git$X" "$bindir/$p" || exit; }
+	fi
 done &&
 
 for p in $list_execdir_git_dashed; do
 	$RM "$execdir/$p" &&
-	test -n "$INSTALL_SYMLINKS" &&
-	ln -s "$destdir_from_execdir/$bindir_relative/git$X" "$execdir/$p" ||
-	{ test -z "$NO_INSTALL_HARDLINKS" &&
-	  ln "$execdir/git$X" "$execdir/$p" ||
-	  ln -s "git$X" "$execdir/$p" ||
-	  cp "$execdir/git$X" "$execdir/$p" || exit; }
+	if test -n "$INSTALL_SYMLINKS" -a -n "$NO_INSTALL_SYMLINKS_FALLBACK"
+	then
+		ln -s "$destdir_from_execdir/$bindir_relative/git$X" "$execdir/$p"
+	else
+		test -n "$INSTALL_SYMLINKS" &&
+		ln -s "$destdir_from_execdir/$bindir_relative/git$X" "$execdir/$p" ||
+		{ test -z "$NO_INSTALL_HARDLINKS" &&
+		  ln "$execdir/git$X" "$execdir/$p" ||
+		  ln -s "git$X" "$execdir/$p" ||
+		  cp "$execdir/git$X" "$execdir/$p" || exit; }
+	fi
 done &&
 
 for p in $list_execdir_curl_aliases; do
 	$RM "$execdir/$p" &&
-	test -n "$INSTALL_SYMLINKS" &&
-	ln -s "git-remote-http$X" "$execdir/$p" ||
-	{ test -z "$NO_INSTALL_HARDLINKS" &&
-	  ln "$execdir/git-remote-http$X" "$execdir/$p" ||
-	  ln -s "git-remote-http$X" "$execdir/$p" ||
-	  cp "$execdir/git-remote-http$X" "$execdir/$p" || exit; }
+	if test -n "$INSTALL_SYMLINKS" -a -n "$NO_INSTALL_SYMLINKS_FALLBACK"
+	then
+		ln -s "git-remote-http$X" "$execdir/$p"
+	else
+		test -n "$INSTALL_SYMLINKS" &&
+		ln -s "git-remote-http$X" "$execdir/$p" ||
+		{ test -z "$NO_INSTALL_HARDLINKS" &&
+		  ln "$execdir/git-remote-http$X" "$execdir/$p" ||
+		  ln -s "git-remote-http$X" "$execdir/$p" ||
+		  cp "$execdir/git-remote-http$X" "$execdir/$p" || exit; }
+	fi
 done
-- 
2.19.1.930.g4563a0d9d0

