Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED4E11F453
	for <e@80x24.org>; Fri,  2 Nov 2018 22:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbeKCHrD (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 03:47:03 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56211 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727150AbeKCHrD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 03:47:03 -0400
Received: by mail-wm1-f66.google.com with SMTP id s10-v6so3217370wmc.5
        for <git@vger.kernel.org>; Fri, 02 Nov 2018 15:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hz7NzerkvRdQ5lxOe5vBJJzUnIdMslo+52BNU1YE8j0=;
        b=L/J8UBeEA2h3o7ockGm1sqUWNx46kJk9iWqOC4l5/btkNdRMjOk/D3fDs1j/hg+0Uh
         sd2ceyLqAaC8TvFC5VfXQ/XLif78XmYtunrRxMkRm7Ck/XTq5ANl34BxDh6ZrxVzYUKE
         CmfZrjDq80YH3APD47mjNpgfoAmn6DsAqOUKPCoycJNtzjyLYA2WhgMyqh6e1N5GXKOA
         UrhDDvXJKOYDTPt0lb++hoIU08O5RDpgilSind98/j6JIegU2Uqaql0EQzA91MQbHatr
         KBVxtno2APc1rE7RVdXFfBV7b15o8IFnwqGhD+DkruBXMxK4KYekQ34awdtXn6lwcQN5
         9SbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hz7NzerkvRdQ5lxOe5vBJJzUnIdMslo+52BNU1YE8j0=;
        b=E4ePgD27YWgL9kQWYScarXhW0Nhtk3Bq8KPxyE8jgacYNE/8NMGxvJBQFIkiNgSyCy
         xiTreMHAi2MQk/+2bCsOwlNLygIpqOP3gR790UNULLgAOYE3KcOSi1kUk+IvxHifCEb/
         cPEE0x/NXEzAV/+Ni+hC9oNWZdC8d5kpLzUP/atPiMOxASdSjH1Cas3BY4trL2fqp6V8
         WjNDNEltSOGgUi2PofwLe4g0ZoQyysKTR+H9GgwzcFcLF8QHEEPeZj6bDoalhsEFft4i
         PYHqcLTAZQKHnKdgWRh68LwutdiV4iZbGOCuZE4RbogLPX4aiShhJun0O9PVsyGOGV26
         UZEg==
X-Gm-Message-State: AGRZ1gJ1R9wesQsrEydQUmPMeKXil1tC+6ODD1oQ1fEGXJsu/1qTdFVu
        v0F32CtNJjH+DljkXcGlXzcNK4axIDg=
X-Google-Smtp-Source: AJdET5eIDF1UN1UO+cOB69deuGSreaweeFTFKgDBArnpziN5tvSdL7ekFk0E18NjGeAZgNubyZhSfQ==
X-Received: by 2002:a1c:af07:: with SMTP id y7-v6mr49221wme.33.1541198281219;
        Fri, 02 Nov 2018 15:38:01 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id a12-v6sm21461469wrr.71.2018.11.02.15.38.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 15:38:00 -0700 (PDT)
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
Subject: [RFC/PATCH 5/5] Makefile: Add a NO_INSTALL_BUILTIN_EXECDIR_ALIASES flag
Date:   Fri,  2 Nov 2018 22:37:43 +0000
Message-Id: <20181102223743.4331-6-avarab@gmail.com>
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

Back when git was initially written the likes of "git-add", "git-init"
etc. were installed in the user's $PATH. A few years later everything,
with a few exceptions like git-upload-pack and git-receive-pack, was
expected to be invoked as "git $cmd".

Now something like a decade later we're still installing these old
commands in gitexecdir. This is so someone with a shellscript that
still targets e.g. "git-init" can add $(git --exec-path) to their
$PATH and not have to change their script.

Let's add an option to break this backwards compatibility. Now with
NO_INSTALL_BUILTIN_EXECDIR_ALIASES=YesPlease there's only 3 programs
in the bindir that are hardlinked to "git" (receive-pack,
upload-archive & upload-pack), and 3 in the
gitexecdir (git-remote-{ftp,ftps,https} linked to git-remote-http).

There's no cross-directory links anymore, so the
"NO_CROSS_DIRECTORY_HARDLINKS" flag becomes redundant under this new
option.

1. https://public-inbox.org/git/87woyfdkoi.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile         |  8 ++++++++
 install_programs | 36 +++++++++++++++++++++---------------
 2 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/Makefile b/Makefile
index 07c8b74353..a849a7b6d1 100644
--- a/Makefile
+++ b/Makefile
@@ -346,6 +346,13 @@ all::
 # INSTALL_SYMLINKS if you'd prefer not to have the install procedure
 # fallack on hardlinking or copying if "ln -s" fails.
 #
+# Define NO_INSTALL_BUILTIN_EXECDIR_ALIASES if you'd like to skip
+# installing legacy such as "git-init" and "git-add" in the
+# gitexecdir. Unless you're on a system where "which git-init" is
+# expected to returns something set this. Users have been expected to
+# use the likes of "git init" for ages now, these programs were only
+# provided for legacy compatibility.
+#
 # Define NO_CROSS_DIRECTORY_HARDLINKS if you plan to distribute the installed
 # programs as a tar, where bin/ and libexec/ might be on different file systems.
 #
@@ -2823,6 +2830,7 @@ endif
 		--flag-no-install-hardlinks="$(NO_INSTALL_HARDLINKS)" \
 		--flag-no-cross-directory-hardlinks="$(NO_CROSS_DIRECTORY_HARDLINKS)" \
 		--flag-no-install-symlinks-fallback="$(NO_INSTALL_SYMLINKS_FALLBACK)" \
+		--flag-no-install-builtin-execdir-aliases="$(NO_INSTALL_BUILTIN_EXECDIR_ALIASES)" \
 		--list-bindir-standalone="git$X $(filter $(install_bindir_programs),$(ALL_PROGRAMS))" \
 		--list-bindir-git-dashed="$(filter $(install_bindir_programs),$(BUILT_INS))" \
 		--list-execdir-git-dashed="$(BUILT_INS)" \
diff --git a/install_programs b/install_programs
index 51e08019dd..8d89cd9984 100755
--- a/install_programs
+++ b/install_programs
@@ -33,6 +33,9 @@ do
 	--flag-no-install-symlinks-fallback=*)
 		NO_INSTALL_SYMLINKS_FALLBACK="${1#--flag-no-install-symlinks-fallback=}"
 		;;
+	--flag-no-install-builtin-execdir-aliases=*)
+		NO_INSTALL_BUILTIN_EXECDIR_ALIASES="${1#--flag-no-install-builtin-execdir-aliases=}"
+		;;
 	--list-bindir-standalone=*)
 		list_bindir_standalone="${1#--list-bindir-standalone=}"
 		;;
@@ -54,7 +57,7 @@ do
 	shift
 done &&
 
-if test "$bindir/" != "$execdir/"
+if test "$bindir/" != "$execdir/" -a -z "$NO_INSTALL_BUILTIN_EXECDIR_ALIASES"
 then
 	for p in $list_bindir_standalone; do
 		$RM "$execdir/$p" &&
@@ -87,20 +90,23 @@ do
 	fi
 done &&
 
-for p in $list_execdir_git_dashed; do
-	$RM "$execdir/$p" &&
-	if test -n "$INSTALL_SYMLINKS" -a -n "$NO_INSTALL_SYMLINKS_FALLBACK"
-	then
-		ln -s "$destdir_from_execdir/$bindir_relative/git$X" "$execdir/$p"
-	else
-		test -n "$INSTALL_SYMLINKS" &&
-		ln -s "$destdir_from_execdir/$bindir_relative/git$X" "$execdir/$p" ||
-		{ test -z "$NO_INSTALL_HARDLINKS" &&
-		  ln "$execdir/git$X" "$execdir/$p" ||
-		  ln -s "git$X" "$execdir/$p" ||
-		  cp "$execdir/git$X" "$execdir/$p" || exit; }
-	fi
-done &&
+if test -z "$NO_INSTALL_BUILTIN_EXECDIR_ALIASES"
+then
+	for p in $list_execdir_git_dashed; do
+		$RM "$execdir/$p" &&
+		if test -n "$INSTALL_SYMLINKS" -a -n "$NO_INSTALL_SYMLINKS_FALLBACK"
+		then
+			ln -s "$destdir_from_execdir/$bindir_relative/git$X" "$execdir/$p"
+		else
+			test -n "$INSTALL_SYMLINKS" &&
+			ln -s "$destdir_from_execdir/$bindir_relative/git$X" "$execdir/$p" ||
+			{ test -z "$NO_INSTALL_HARDLINKS" &&
+			  ln "$execdir/git$X" "$execdir/$p" ||
+			  ln -s "git$X" "$execdir/$p" ||
+			  cp "$execdir/git$X" "$execdir/$p" || exit; }
+		fi
+	done
+fi &&
 
 for p in $list_execdir_curl_aliases; do
 	$RM "$execdir/$p" &&
-- 
2.19.1.930.g4563a0d9d0

