Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35C201F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 18:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbfJ1S6M (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 14:58:12 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38321 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728975AbfJ1S6L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 14:58:11 -0400
Received: by mail-wr1-f68.google.com with SMTP id v9so11056400wrq.5
        for <git@vger.kernel.org>; Mon, 28 Oct 2019 11:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nD4dKylKir1xAcRqHn/foyC9MKgXLaDhV51qUdraoyg=;
        b=Z4O1r/GDkLYW6yvHQ7+U9t0+zeheuvDPlLy2dwDF7bEh8lodaYpSBzAi1XaUqNgprk
         VmYpy/Xz5eOluEaKrfP/qTXxIM1fAYdtNXo8pXGIk0/+lveNI9ShmoSTXr2FobO8KhGF
         CAeR7k8M/qP1xk+hObsaRRINug108QILYO3LYEifIFyOssUuaW6o1qO7CnXXce1++9aL
         O010kY9aTzVltGjMhPtlQy2fLnpm/jdJyHlqMLZcGxbpZ6TAfFZUCc1L4MdsWKAQJ0X7
         z1XKh/4O+cMoxoiwm8C6oDjkpDgK533kBmPIe0PjIKGtvcUaUcCmbmacGCz0tjzlOq33
         YQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nD4dKylKir1xAcRqHn/foyC9MKgXLaDhV51qUdraoyg=;
        b=G25v3E4VJAFBmLbt57c/48Q+jSEEJo/1nTIRxHs7Y01400CzC9XY1Sgg4mafmONCUa
         2uqBIPxUX0R78cEkWmUsUIypDho+UvUDY0V1c6AFC5LwP/F82c8tQ2lNqsBgs+U8IPwx
         oBKsLf07UuaJJ8c8MSCuzBh2JijFcEnr4CTT7V5F/OBkHkIH5Qau8WHQfiA16pjOZZsP
         8KP1E+zdI9unxExljLWRvJdpakAaCgOFyI9XVMu/yVBuaPNtlKogd4Q9/75SXVSnOnfu
         Ro6gbmf0SKTkl5HNcGSlmglFOqY4w65woaDmP2dhD8nQSnolHbg8c+UaMUp1A80wyzdN
         XjPw==
X-Gm-Message-State: APjAAAV4rNQsvnjuQfrP64eHICsCfV8bSAmfZ3amJozwfuMDo3X2gstW
        MkL2/zM6hSsgZQW24hb+t5uDCkFf
X-Google-Smtp-Source: APXvYqz/M8Yr6ZMHbW4NV1l4b2zmrAnTZ28o7K9LPQNMga/actw0c0oeuN+fuYSCzL41jAYJiuIRcw==
X-Received: by 2002:adf:fc44:: with SMTP id e4mr17384628wrs.26.1572289089779;
        Mon, 28 Oct 2019 11:58:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q25sm22816639wra.3.2019.10.28.11.58.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Oct 2019 11:58:09 -0700 (PDT)
Message-Id: <56faba848676ffc5441f373bc2105392fc2a3e11.1572289087.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.423.git.1572289087.gitgitgadget@gmail.com>
References: <pull.423.git.1572289087.gitgitgadget@gmail.com>
From:   "Jonathan Gilbert via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Oct 2019 18:58:07 +0000
Subject: [PATCH 1/1] git-gui: Revert untracked files by deleting them
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Gilbert <rcq8n2xf3v@liamekaens.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Gilbert <JonathanG@iQmetrix.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Gilbert <JonathanG@iQmetrix.com>

My development environment sometimes makes automatic changes
that I don't want to keep. In some cases, this involves new
files being added that I don't want to commit or keep. I have
typically had to explicitly delete those files externally to
Git Gui, and I want to be able to just select those newly-
created untracked files and "revert" them into oblivion.

This change updates the revert_helper function to check for
untracked files as well as changes, and then any changes to be
reverted and untracked files are handled by independent
blocks of code. The user is prompted independently for
untracked files, since the underlying action is fundamentally
different (rm -f). If after deleting untracked files, the
directory containing them becomes empty, then the directory is
removed as well.

This introduces new strings in index.tcl. I have been told that
there is a separate process whereby the translations get updated.

Signed-off-by: Jonathan Gilbert <JonathanG@iQmetrix.com>
---
 git-gui/lib/index.tcl | 139 +++++++++++++++++++++++++++++++-----------
 1 file changed, 104 insertions(+), 35 deletions(-)

diff --git a/git-gui/lib/index.tcl b/git-gui/lib/index.tcl
index e07b7a3762..cc1b651d56 100644
--- a/git-gui/lib/index.tcl
+++ b/git-gui/lib/index.tcl
@@ -393,11 +393,24 @@ proc revert_helper {txt paths} {
 
 	if {![lock_index begin-update]} return
 
+	# If an action is taken that implicitly unlocks the index, this gets cleared. Either way, it is executed at the end of the procedure.
+	set epilogue [list]
+	lappend epilogue {unlock_index}
+
+	proc already_unlocked {} { upvar epilogue epilogue; set epilogue [lsearch -inline -all -not -exact $epilogue {unlock_index}] }
+
 	set pathList [list]
+	set untrackedList [list]
 	set after {}
 	foreach path $paths {
 		switch -glob -- [lindex $file_states($path) 0] {
 		U? {continue}
+		?O {
+			lappend untrackedList $path
+			if {$path eq $current_diff_path} {
+				set after {reshow_diff;}
+			}
+		}
 		?M -
 		?T -
 		?D {
@@ -410,45 +423,101 @@ proc revert_helper {txt paths} {
 	}
 
 
-	# Split question between singular and plural cases, because
-	# such distinction is needed in some languages. Previously, the
-	# code used "Revert changes in" for both, but that can't work
-	# in languages where 'in' must be combined with word from
-	# rest of string (in different way for both cases of course).
-	#
-	# FIXME: Unfortunately, even that isn't enough in some languages
-	# as they have quite complex plural-form rules. Unfortunately,
-	# msgcat doesn't seem to support that kind of string translation.
-	#
-	set n [llength $pathList]
-	if {$n == 0} {
-		unlock_index
-		return
-	} elseif {$n == 1} {
-		set query [mc "Revert changes in file %s?" [short_path [lindex $pathList]]]
-	} else {
-		set query [mc "Revert changes in these %i files?" $n]
-	}
+	set numPaths [llength $pathList]
+	set numUntracked [llength $untrackedList]
 
-	set reply [tk_dialog \
-		.confirm_revert \
-		"[appname] ([reponame])" \
-		"$query
+	if {$numPaths > 0} {
+		# Split question between singular and plural cases, because
+		# such distinction is needed in some languages. Previously, the
+		# code used "Revert changes in" for both, but that can't work
+		# in languages where 'in' must be combined with word from
+		# rest of string (in different way for both cases of course).
+		#
+		# FIXME: Unfortunately, even that isn't enough in some languages
+		# as they have quite complex plural-form rules. Unfortunately,
+		# msgcat doesn't seem to support that kind of string translation.
+		if {$numPaths == 1} {
+			set query [mc "Revert changes in file %s?" [short_path [lindex $pathList]]]
+		} else {
+			set query [mc "Revert changes in these %i files?" $numPaths]
+		}
+
+		set reply [tk_dialog \
+			.confirm_revert \
+			"[appname] ([reponame])" \
+			"$query
 
 [mc "Any unstaged changes will be permanently lost by the revert."]" \
-		question \
-		1 \
-		[mc "Do Nothing"] \
-		[mc "Revert Changes"] \
-		]
-	if {$reply == 1} {
-		checkout_index \
-			$txt \
-			$pathList \
-			[concat $after [list ui_ready]]
-	} else {
-		unlock_index
+			question \
+			1 \
+			[mc "Do Nothing"] \
+			[mc "Revert Changes"] \
+			]
+
+		if {$reply == 1} {
+			checkout_index \
+				$txt \
+				$pathList \
+				[concat $after [list ui_ready]]
+
+			already_unlocked
+		}
+	}
+
+	if {$numUntracked > 0} {
+		# Split question between singular and plural cases, because
+		# such distinction is needed in some languages.
+		#
+		# FIXME: Unfortunately, even that isn't enough in some languages
+		# as they have quite complex plural-form rules. Unfortunately,
+		# msgcat doesn't seem to support that kind of string translation.
+		if {$numUntracked == 1} {
+			set query [mc "Delete untracked file %s?" [short_path [lindex $untrackedList]]]
+		} else {
+			set query [mc "Delete these %i untracked files?" $numUntracked]
+		}
+
+		set reply [tk_dialog \
+			.confirm_revert \
+			"[appname] ([reponame])" \
+			"$query
+
+[mc "Files will be permanently deleted."]" \
+			question \
+			1 \
+			[mc "Do Nothing"] \
+			[mc "Delete Files"] \
+			]
+
+		if {$reply == 1} {
+			file delete -- {*}$untrackedList
+
+			foreach path $untrackedList {
+				set directoryPath [file dirname $path]
+
+				while {$directoryPath != $path} {
+					set contents [glob -nocomplain -dir $path *]
+
+					if {[llength $contents] > 0} { break }
+
+					try {
+						file delete -- $path
+					}
+					catch {
+						# This is just a best effort, don't annoy the user with failure to remove empty directories.
+						break
+					}
+
+					set path $directoryPath
+					set directoryPath [file dirname $path]
+				}
+			}
+
+			lappend epilogue {ui_do_rescan}
+		}
 	}
+
+	foreach epilogueCommand $epilogue { {*}$epilogueCommand }
 }
 
 proc do_revert_selection {} {
-- 
gitgitgadget
