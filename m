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
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C4FB1F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 06:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfJ3Gst (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Oct 2019 02:48:49 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34507 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727377AbfJ3Gst (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Oct 2019 02:48:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id t16so971075wrr.1
        for <git@vger.kernel.org>; Tue, 29 Oct 2019 23:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=F+rbyI2a7cQT1iNxyupaI1GJFLwhkmuBlbRzCqDyois=;
        b=KXoNHocddTgXYLy8sDGY1wzjZqNYoDx1i20gFmAK0741Df6VuFOMKwmlKwm1G0VziV
         oDpoyBQep21oIcUJGkTLfVqlB25elhzfM/Hc2cRe2e3BBgpotaSxcfPTeOLFNNzeacKN
         ic2jSMGnPRcm0tcMOyCrzBEeHSCChjF8177g/l895nAL8TAtPQfT/UOcdA2lw8RtGfrj
         J4uoXQVH6vRO5hDBgDxbHgSItrSf43qeShhoL3JVorUqa1muvly8/kSTua0am0f20PKD
         DnkfZUKlSxM2NPSJJBQrWRn7cSzKfmfxm0WLBXzcc5V5cOEUfdLOz151n19E2lffit+n
         UQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=F+rbyI2a7cQT1iNxyupaI1GJFLwhkmuBlbRzCqDyois=;
        b=qe2ECQ0CzhZKr+uPp2muBTRyxjwZ5IwNi04lsSOPWEu8n4KliUJHxUroU7JnIqdh74
         1hPE1qiQ/YH9Vnn7hObK8O1GJhFqvbiqUlI2XgrtvDod3iOeat9ww6HHIU/6QkAgHHUV
         qpEtgABIAZReaGou8UlTbbyqB/x8Ly9iq/Ctfn7lhq9iXylXQSyz4VGiZ8FFUJFo0HRk
         BkG4B3K7c5vJJyVOb2BzgAMksdnLMh5fE1xfkySb7X3qsJ3o0YJHmzfUiny3t0hFfXwb
         K1mu4zc+cn3XIE7jP6eJoBOCb7y0XIj4AK0EuVpTxWTo5wESUzGOWsLaYxnOsGSPV/yP
         uCgw==
X-Gm-Message-State: APjAAAV1J3zlxzdNy3aX17B2MiZ8PueRBFCM7StpCYMKAwL+GzfKMAo6
        6/KOS6rYn90SdMO7O9gwY6jVdsvz
X-Google-Smtp-Source: APXvYqyA8iudWXbVupgiyOGH4KauLa0glOLjFgUm/Ny0mXV1Wr5e6kM3GIgFU8hzOS9RJ4/VcEF9NA==
X-Received: by 2002:a05:6000:1051:: with SMTP id c17mr22468123wrx.124.1572418126195;
        Tue, 29 Oct 2019 23:48:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p12sm1631545wrt.7.2019.10.29.23.48.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2019 23:48:45 -0700 (PDT)
Message-Id: <0190f6f2f978a674a29a1e2013d00bc289851c76.1572418123.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.436.git.1572418123.gitgitgadget@gmail.com>
References: <pull.436.git.1572418123.gitgitgadget@gmail.com>
From:   "Jonathan Gilbert via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 30 Oct 2019 06:48:43 +0000
Subject: [PATCH 2/2] git-gui: revert untracked files by deleting them
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Gilbert <rcq8n2xf3v@liamekaens.com>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Jonathan Gilbert <JonathanG@iQmetrix.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Gilbert <JonathanG@iQmetrix.com>

Updates the revert_helper procedure to also detect untracked files. If
files are present, the user is asked if they want them deleted. A new
proc delete_files with helper delete_helper performs the deletion in
batches, to allow the UI to remain responsive.

Signed-off-by: Jonathan Gilbert <JonathanG@iQmetrix.com>
---
 lib/index.tcl | 255 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 222 insertions(+), 33 deletions(-)

diff --git a/lib/index.tcl b/lib/index.tcl
index 28d4d2a54e..9661ddb556 100644
--- a/lib/index.tcl
+++ b/lib/index.tcl
@@ -393,11 +393,20 @@ proc revert_helper {txt paths} {
 
 	if {![lock_index begin-update]} return
 
+	# The index is now locked. Some of the paths below include calls that
+	# unlock the index (e.g. checked_index). If we reach the end and the
+	# index is still locked, we need to unlock it before returning.
+	set need_unlock_index 1
+
 	set path_list [list]
+	set untracked_list [list]
 	set after {}
 	foreach path $paths {
 		switch -glob -- [lindex $file_states($path) 0] {
 		U? {continue}
+		?O {
+			lappend untracked_list $path
+		}
 		?M -
 		?T -
 		?D {
@@ -409,45 +418,225 @@ proc revert_helper {txt paths} {
 		}
 	}
 
+	set path_cnt [llength $path_list]
+	set untracked_cnt [llength $untracked_list]
 
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
-	set n [llength $path_list]
-	if {$n == 0} {
-		unlock_index
-		return
-	} elseif {$n == 1} {
-		set query [mc "Revert changes in file %s?" [short_path [lindex $path_list]]]
-	} else {
-		set query [mc "Revert changes in these %i files?" $n]
-	}
+	if {$path_cnt > 0} {
+		# Split question between singular and plural cases, because
+		# such distinction is needed in some languages. Previously, the
+		# code used "Revert changes in" for both, but that can't work
+		# in languages where 'in' must be combined with word from
+		# rest of string (in different way for both cases of course).
+		#
+		# FIXME: Unfortunately, even that isn't enough in some languages
+		# as they have quite complex plural-form rules. Unfortunately,
+		# msgcat doesn't seem to support that kind of string
+		# translation.
+		#
+		if {$path_cnt == 1} {
+			set query [mc \
+				"Revert changes in file %s?" \
+				[short_path [lindex $path_list]] \
+				]
+		} else {
+			set query [mc \
+				"Revert changes in these %i files?" \
+				$path_cnt]
+		}
 
-	set reply [tk_dialog \
-		.confirm_revert \
-		"[appname] ([reponame])" \
-		"$query
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
+			question \
+			1 \
+			[mc "Do Nothing"] \
+			[mc "Revert Changes"] \
+			]
+
+		if {$reply == 1} {
+			checkout_index \
+				$txt \
+				$path_list \
+				[concat $after [list ui_ready]]
+
+			set need_unlock_index 0
+		}
+	}
+
+	if {$need_unlock_index} { unlock_index }
+
+	if {$untracked_cnt > 0} {
+		# Split question between singular and plural cases, because
+		# such distinction is needed in some languages.
+		#
+		# FIXME: Unfortunately, even that isn't enough in some languages
+		# as they have quite complex plural-form rules. Unfortunately,
+		# msgcat doesn't seem to support that kind of string
+		# translation.
+		#
+		if {$untracked_cnt == 1} {
+			set query [mc \
+				"Delete untracked file %s?" \
+				[short_path [lindex $untracked_list]] \
+				]
+		} else {
+			set query [mc \
+				"Delete these %i untracked files?" \
+				$untracked_cnt \
+				]
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
+			delete_files $untracked_list
+		}
+	}
+}
+
+# Delete all of the specified files, performing deletion in batches to allow the
+# UI to remain responsive and updated.
+proc delete_files {path_list} {
+	# Enable progress bar status updates
+	$::main_status start [mc "Deleting"] [mc "files"]
+
+	set path_index 0
+	set deletion_errors [list]
+	set deletion_error_path "not yet captured"
+	set batch_size 50
+
+	delete_helper \
+		$path_list \
+		$path_index \
+		$deletion_errors \
+		$deletion_error_path \
+		$batch_size
+}
+
+# Helper function to delete a list of files in batches. Each call deletes one
+# batch of files, and then schedules a call for the next batch after any UI
+# messages have been processed.
+proc delete_helper \
+	{path_list path_index deletion_errors deletion_error_path batch_size} {
+	global file_states
+
+	set path_cnt [llength $path_list]
+
+	set batch_remaining $batch_size
+
+	while {$batch_remaining > 0} {
+		if {$path_index >= $path_cnt} { break }
+
+		set path [lindex $path_list $path_index]
+
+		set deletion_failed [catch {file delete -- $path} deletion_error]
+
+		if {$deletion_failed} {
+			lappend deletion_errors $deletion_error
+
+			# Optimistically capture the path that failed, in case
+			# there's only one.
+			set deletion_error_path $path
+		} else {
+			remove_empty_directories [file dirname $path]
+
+			# Don't assume the deletion worked. Remove the file from
+			# the UI, but only if it no longer exists.
+			if {![lexists $path]} {
+				unset file_states($path)
+				display_file $path __
+			}
+		}
+
+		incr path_index 1
+		incr batch_remaining -1
+	}
+
+	# Update the progress bar to indicate that this batch has been
+	# completed. The update will be visible when this procedure returns
+	# and allows the UI thread to process messages.
+	$::main_status update $path_index $path_cnt
+
+	if {$path_index < $path_cnt} {
+		# The Tcler's Wiki lists this as the best practice for keeping
+		# a UI active and processing messages during a long-running
+		# operation.
+
+		after idle [list after 0 [list \
+			delete_helper \
 			$path_list \
-			[concat $after [list ui_ready]]
+			$path_index \
+			$deletion_errors \
+			$deletion_error_path \
+			$batch_size \
+			]]
 	} else {
-		unlock_index
+		# Finish the status bar operation.
+		$::main_status stop
+
+		# Report error, if any, based on how many deletions failed.
+		set deletion_error_cnt [llength $deletion_errors]
+
+		if {$deletion_error_cnt == 1} {
+			error_popup [mc \
+				"File %s could not be deleted: %s" \
+				$deletion_error_path \
+				[lindex $deletion_errors 0] \
+				]
+		} elseif {$deletion_error_cnt == $path_cnt} {
+			error_popup [mc \
+				"None of the selected files could be deleted." \
+				]
+		} elseif {$deletion_error_cnt > 1} {
+			error_popup [mc \
+				"%d of the selected files could not be deleted." \
+				$deletion_error_cnt]
+		}
+
+		reshow_diff
+		ui_ready
+	}
+}
+
+# This function is from the TCL documentation:
+#
+#   https://wiki.tcl-lang.org/page/file+exists
+#
+# [file exists] returns false if the path does exist but is a symlink to a path
+# that doesn't exist. This proc returns true if the path exists, regardless of
+# whether it is a symlink and whether it is broken.
+proc lexists name {
+	expr {![catch {file lstat $name finfo}]}
+}
+
+# Remove as many empty directories as we can starting at the specified path.
+# If we encounter a directory that is not empty, or if a directory deletion
+# fails, then we stop the operation and return to the caller. Even if this
+# procedure fails to delete any directories at all, it does not report failure.
+proc remove_empty_directories {directory_path} {
+	set parent_path [file dirname $directory_path]
+
+	while {$parent_path != $directory_path} {
+		set contents [glob -nocomplain -dir $directory_path *]
+
+		if {[llength $contents] > 0} { break }
+		if {[catch {file delete -- $directory_path}]} { break }
+
+		set directory_path $parent_path
+		set parent_path [file dirname $directory_path]
 	}
 }
 
-- 
gitgitgadget
