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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DB6E1F454
	for <e@80x24.org>; Thu,  7 Nov 2019 07:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfKGHFn (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 02:05:43 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41595 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfKGHFn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 02:05:43 -0500
Received: by mail-wr1-f66.google.com with SMTP id p4so1697203wrm.8
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 23:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YUTRM8Bs3T7Q+v4z8e8oV9Tu+c4/wv8Sa9JNOzhpUZ0=;
        b=Wo3IsPTk7eruHm+6nY0IMMu5Is+xn3z0vUTesGQzH/N8V7lXn5OaDIsyq6A7+6aU09
         Aq9OlLJLh6RiPAeXSl91gAd2xkxoF81IiEH/yE1RFI5o9hRLlBw3AE+DOgmOi5SB0hQT
         AOy9A3m3iRRuEHQFQYmIDVnkgmLrhAzpJ1mVVjZqa1fm0UJs5n10olUaJ3bYn66+DUNa
         2IVh7j8seO7ayIK0fYikupW9zgWQZ3/d9spGcWYFh7CwRI1ZcuBbdA/SacwDTmBrdFoh
         yJxtGn6wuvTzhL5iHa/ha3VLBbesm0DA0bwgQiXm1XVWQR/JPifGDpOyBT9DaHd5Ejg8
         8Bjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YUTRM8Bs3T7Q+v4z8e8oV9Tu+c4/wv8Sa9JNOzhpUZ0=;
        b=FSR653p07dZWPlqv6aYlQ7ydsU2ihtUkQCc7chusrOkWxf4XFUhj6h/YAWrFhv/0Ab
         /PPWWNZGlWRjersh7xye5C6TCCKykcdBom4TOHJjAVMOmvOpcTjGGISaVKPW12wzsWor
         B1vrJdHhVQHXz7UXlDEHu82B4UZOwnENIPzoe+1nH/AvzzW5pGpxnrWAH7ieI9UgaS2w
         2VuhZVwYj+Yej95gx1RUg6UejzVJPGwGm8ZjtgaWlTH60xtRs2HDs+nQzDRGxwF15Wrk
         LGLWyke4yAnx5/vQNZNnwTFo4lq0ncdXGCoGADMc80eyjWeBRt6HGkWqKCRmNmiMNV6e
         4ajA==
X-Gm-Message-State: APjAAAV3KM2GQt0bbjtiVa82WXzmRL0zhuwjxotC64OFaZdA4MT5AzoB
        TprHtm+N+csbv4T2JtxU0h+aiRhM
X-Google-Smtp-Source: APXvYqz7TDSiNGnPH71hittQju9m7Tchez7ed2aF5HIdJ0EbNhpnip//M4beGbKmGAlFu14CV35OBw==
X-Received: by 2002:adf:e386:: with SMTP id e6mr1250895wrm.397.1573110336510;
        Wed, 06 Nov 2019 23:05:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t134sm1097767wmt.24.2019.11.06.23.05.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 23:05:35 -0800 (PST)
Message-Id: <pull.436.v2.git.1573110335.gitgitgadget@gmail.com>
In-Reply-To: <pull.436.git.1572418123.gitgitgadget@gmail.com>
References: <pull.436.git.1572418123.gitgitgadget@gmail.com>
From:   "Jonathan Gilbert via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Nov 2019 07:05:33 +0000
Subject: [PATCH v2 0/2] git-gui: revert untracked files by deleting them
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Gilbert <rcq8n2xf3v@liamekaens.com>,
        Pratyush Yadav <me@yadavpratyush.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My development environment sometimes makes automatic changes that I don't
want to keep. In some cases, this involves new files being added that I
don't want to commit or keep (but I also don't want to outright .gitignore 
forever). I have typically had to explicitly delete those files externally
to Git Gui, which is a context switch to a manual operation, and I want to
be able to just select those newly-created untracked files in the UI and
"revert" them into oblivion.

This change updates the revert_helper proc to check for untracked files as
well as changes, and then changes to be reverted and untracked files are
handled by independent blocks of code. The user is prompted independently
for untracked files, since the underlying action is fundamentally different
(rm -f). If after deleting untracked files, the directory containing them
becomes empty, then the directory is removed as well. A new proc 
delete_files takes care of actually deleting the files, using the Tcler's
Wiki recommended approach for keeping the UI responsive.

Since the checkout_index and delete_files calls are both asynchronous and
could potentially complete in any order, a "chord" is used to coordinate
unlocking the index and returning the UI to a usable state only after both
operations are complete.

This is the third revision of this change, which differs from the second
version in the following ways:

 * A new construct called a "chord" is used to coordinate the completion of
   multiple asynchronous operations that can be kicked off by revert_helper.
   A chord is, conceptually, a procedure with multiple entrypoints whose
   body only executes once all entrypoints have been activated. The 
   chord.tcl file includes comprehensive documentation of how to use the
   chord classes.
   
   
 * Since we might not yet be ready to unlock the index when checkout_index 
   returns, the _close_updateindex proc where it was ultimately unlocking
   the index has been modified so that unlocking the index is the
   responsibility of the caller. Since the $after functionality ran after 
   unlock_index, that is also hoisted out. Nothing in _close_updateindex 
   appears to be asynchronous, so the caller can simply make the calls
   itself upon its return.
   
   
 * lexists has been renamed to path_exists.
   
   
 * Up to 10 deletion errors are now shown simultaneously. I also confirmed
   that Tcl's file delete code will always return a nicely-formatted error
   including the filename, and changed the message so that it isn't also 
   injecting the filename.

Jonathan Gilbert (2):
  git-gui: consolidate naming conventions
  git-gui: revert untracked files by deleting them

 lib/chord.tcl | 137 ++++++++++++++++++
 lib/index.tcl | 376 +++++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 429 insertions(+), 84 deletions(-)
 create mode 100644 lib/chord.tcl


base-commit: b524f6b399c77b40c8bf2b6217585fde4731472a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-436%2Flogiclrd%2Fgit-gui-revert-untracked-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-436/logiclrd/git-gui-revert-untracked-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/436

Range-diff vs v1:

 1:  da1704c56e = 1:  da1704c56e git-gui: consolidate naming conventions
 2:  0190f6f2f9 ! 2:  9469beb599 git-gui: revert untracked files by deleting them
     @@ -2,24 +2,233 @@
      
          git-gui: revert untracked files by deleting them
      
     -    Updates the revert_helper procedure to also detect untracked files. If
     -    files are present, the user is asked if they want them deleted. A new
     -    proc delete_files with helper delete_helper performs the deletion in
     -    batches, to allow the UI to remain responsive.
     +    Update the revert_helper procedure to also detect untracked files. If
     +    files are present, the user is asked if they want them deleted. Perform
     +    the deletion in batches, using new proc delete_files with helper
     +    delete_helper, to allow the UI to remain responsive. Coordinate the
     +    completion of multiple overlapping asynchronous operations using a new
     +    construct called a "chord". Migrate unlocking of the index out of
     +    _close_updateindex to a responsibility of the caller, to permit paths
     +    that don't directly unlock the index.
      
          Signed-off-by: Jonathan Gilbert <JonathanG@iQmetrix.com>
      
     + diff --git a/lib/chord.tcl b/lib/chord.tcl
     + new file mode 100644
     + --- /dev/null
     + +++ b/lib/chord.tcl
     +@@
     ++# SimpleChord class:
     ++#   Represents a procedure that conceptually has multiple entrypoints that must
     ++#   all be called before the procedure executes. Each entrypoint is called a
     ++#   "note". The chord is only "completed" when all the notes are "activated".
     ++#
     ++#   Constructor:
     ++#     set chord [SimpleChord new {body}]
     ++#       Creates a new chord object with the specified body script. The body
     ++#       script is evaluated at most once, when a note is activated and the
     ++#       chord has no other non-activated notes.
     ++#
     ++#   Methods:
     ++#     $chord eval {script}
     ++#       Runs the specified script in the same context (namespace) in which the
     ++#       chord body will be evaluated. This can be used to set variable values
     ++#       for the chord body to use.
     ++#
     ++#     set note [$chord add_note]
     ++#       Adds a new note to the chord, an instance of ChordNote. Raises an
     ++#       error if the chord is already completed, otherwise the chord is updated
     ++#       so that the new note must also be activated before the body is
     ++#       evaluated.
     ++#
     ++#     $chord notify_note_activation
     ++#       For internal use only.
     ++#
     ++# ChordNote class:
     ++#   Represents a note within a chord, providing a way to activate it. When the
     ++#   final note of the chord is activated (this can be any note in the chord,
     ++#   with all other notes already previously activated in any order), the chord's
     ++#   body is evaluated.
     ++#
     ++#   Constructor:
     ++#     Instances of ChordNote are created internally by calling add_note on
     ++#     SimpleChord objects.
     ++#
     ++#   Methods:
     ++#     [$note is_activated]
     ++#       Returns true if this note has already been activated.
     ++#
     ++#     $note
     ++#       Activates the note, if it has not already been activated, and completes
     ++#       the chord if there are no other notes awaiting activation. Subsequent
     ++#       calls will have no further effect.
     ++#
     ++# Example:
     ++#
     ++#   # Turn off the UI while running a couple of async operations.
     ++#   lock_ui
     ++#
     ++#   set chord [SimpleChord new {
     ++#     unlock_ui
     ++#     # Note: $notice here is not referenced in the calling scope
     ++#     if {$notice} { info_popup $notice }
     ++#   }
     ++#
     ++#   # Configure a note to keep the chord from completing until
     ++#   # all operations have been initiated.
     ++#   set common_note [$chord add_note]
     ++#
     ++#   # Pass notes as 'after' callbacks to other operations
     ++#   async_operation $args [$chord add_note]
     ++#   other_async_operation $args [$chord add_note]
     ++#
     ++#   # Communicate with the chord body
     ++#   if {$condition} {
     ++#     # This sets $notice in the same context that the chord body runs in.
     ++#     $chord eval { set notice "Something interesting" }
     ++#   }
     ++#
     ++#   # Activate the common note, making the chord eligible to complete
     ++#   $common_note
     ++#
     ++# At this point, the chord will complete at some unknown point in the future.
     ++# The common note might have been the first note activated, or the async
     ++# operations might have completed synchronously and the common note is the
     ++# last one, completing the chord before this code finishes, or anything in
     ++# between. The purpose of the chord is to not have to worry about the order.
     ++
     ++oo::class create SimpleChord {
     ++	variable Notes
     ++	variable Body
     ++	variable IsCompleted
     ++
     ++	constructor {body} {
     ++		set Notes [list]
     ++		set Body $body
     ++		set IsCompleted 0
     ++	}
     ++
     ++	method eval {script} {
     ++		namespace eval [self] $script
     ++	}
     ++
     ++	method add_note {} {
     ++		if {$IsCompleted} { error "Cannot add a note to a completed chord" }
     ++
     ++		set note [ChordNote new [self]]
     ++
     ++		lappend Notes $note
     ++
     ++		return $note
     ++	}
     ++
     ++	method notify_note_activation {} {
     ++		if {!$IsCompleted} {
     ++			foreach note $Notes {
     ++				if {![$note is_activated]} { return }
     ++			}
     ++
     ++			set IsCompleted 1
     ++
     ++			namespace eval [self] $Body
     ++			namespace delete [self]
     ++		}
     ++	}
     ++}
     ++
     ++oo::class create ChordNote {
     ++	variable Chord IsActivated
     ++
     ++	constructor {chord} {
     ++		set Chord $chord
     ++		set IsActivated 0
     ++	}
     ++
     ++	method is_activated {} {
     ++		return $IsActivated
     ++	}
     ++
     ++	method unknown {} {
     ++		if {!$IsActivated} {
     ++			set IsActivated 1
     ++			$Chord notify_note_activation
     ++		}
     ++	}
     ++}
     +
       diff --git a/lib/index.tcl b/lib/index.tcl
       --- a/lib/index.tcl
       +++ b/lib/index.tcl
     +@@
     + 	}
     + }
     + 
     +-proc _close_updateindex {fd after} {
     ++proc _close_updateindex {fd} {
     + 	global use_ttk NS
     + 	fconfigure $fd -blocking 1
     + 	if {[catch {close $fd} err]} {
     +@@
     + 	}
     + 
     + 	$::main_status stop
     +-	unlock_index
     +-	uplevel #0 $after
     + }
     + 
     + proc update_indexinfo {msg path_list after} {
     +@@
     + 	global file_states current_diff_path
     + 
     + 	if {$update_index_cp >= $total_cnt} {
     +-		_close_updateindex $fd $after
     ++		_close_updateindex $fd
     ++		unlock_index
     ++		uplevel #0 $after
     + 		return
     + 	}
     + 
     +@@
     + 	global file_states current_diff_path
     + 
     + 	if {$update_index_cp >= $total_cnt} {
     +-		_close_updateindex $fd $after
     ++		_close_updateindex $fd
     ++		unlock_index
     ++		uplevel #0 $after
     + 		return
     + 	}
     + 
     +@@
     + 	global file_states current_diff_path
     + 
     + 	if {$update_index_cp >= $total_cnt} {
     +-		_close_updateindex $fd $after
     ++		_close_updateindex $fd $do_unlock_index $after
     ++		uplevel #0 $after
     + 		return
     + 	}
     + 
      @@
       
       	if {![lock_index begin-update]} return
       
     -+	# The index is now locked. Some of the paths below include calls that
     -+	# unlock the index (e.g. checked_index). If we reach the end and the
     -+	# index is still locked, we need to unlock it before returning.
     -+	set need_unlock_index 1
     ++	# Common "after" functionality that waits until multiple asynchronous
     ++	# operations are complete (by waiting for them to activate their notes
     ++	# on the chord).
     ++	set after_chord [SimpleChord new {
     ++		unlock_index
     ++		if {$should_reshow_diff} { reshow_diff }
     ++		ui_ready
     ++	}]
     ++
     ++	$after_chord eval { set should_reshow_diff 0 }
     ++
     ++	# We don't know how many notes we're going to create (it's dynamic based
     ++	# on conditional paths below), so create a common note that will delay
     ++	# the chord's completion until we activate it, and then activate it
     ++	# after all the other notes have been created.
     ++	set after_common_note [$after_chord add_note]
      +
       	set path_list [list]
      +	set untracked_list [list]
     @@ -33,7 +242,12 @@
       		?M -
       		?T -
       		?D {
     -@@
     + 			lappend path_list $path
     + 			if {$path eq $current_diff_path} {
     +-				set after {reshow_diff;}
     ++				$after_chord eval { set should_reshow_diff 1 }
     + 			}
     + 		}
       		}
       	}
       
     @@ -110,14 +324,10 @@
      +			checkout_index \
      +				$txt \
      +				$path_list \
     -+				[concat $after [list ui_ready]]
     -+
     -+			set need_unlock_index 0
     ++				[$after_chord add_note]
      +		}
      +	}
      +
     -+	if {$need_unlock_index} { unlock_index }
     -+
      +	if {$untracked_cnt > 0} {
      +		# Split question between singular and plural cases, because
      +		# such distinction is needed in some languages.
     @@ -152,35 +362,40 @@
      +			]
      +
      +		if {$reply == 1} {
     -+			delete_files $untracked_list
     ++			$after_chord eval { set should_reshow_diff 1 }
     ++
     ++			delete_files $untracked_list [$after_chord add_note]
      +		}
      +	}
     ++
     ++	# Activate the common note. If no other notes were created, this
     ++	# completes the chord. If other notes were created, then this common
     ++	# note prevents a race condition where the chord might complete early.
     ++	$after_common_note
      +}
      +
      +# Delete all of the specified files, performing deletion in batches to allow the
      +# UI to remain responsive and updated.
     -+proc delete_files {path_list} {
     ++proc delete_files {path_list after} {
      +	# Enable progress bar status updates
      +	$::main_status start [mc "Deleting"] [mc "files"]
      +
      +	set path_index 0
      +	set deletion_errors [list]
     -+	set deletion_error_path "not yet captured"
      +	set batch_size 50
      +
      +	delete_helper \
      +		$path_list \
      +		$path_index \
      +		$deletion_errors \
     -+		$deletion_error_path \
     -+		$batch_size
     ++		$batch_size \
     ++		$after
      +}
      +
      +# Helper function to delete a list of files in batches. Each call deletes one
      +# batch of files, and then schedules a call for the next batch after any UI
      +# messages have been processed.
     -+proc delete_helper \
     -+	{path_list path_index deletion_errors deletion_error_path batch_size} {
     ++proc delete_helper {path_list path_index deletion_errors batch_size after} {
      +	global file_states
      +
      +	set path_cnt [llength $path_list]
     @@ -195,17 +410,13 @@
      +		set deletion_failed [catch {file delete -- $path} deletion_error]
      +
      +		if {$deletion_failed} {
     -+			lappend deletion_errors $deletion_error
     -+
     -+			# Optimistically capture the path that failed, in case
     -+			# there's only one.
     -+			set deletion_error_path $path
     ++			lappend deletion_errors [list "$deletion_error"]
      +		} else {
      +			remove_empty_directories [file dirname $path]
      +
      +			# Don't assume the deletion worked. Remove the file from
      +			# the UI, but only if it no longer exists.
     -+			if {![lexists $path]} {
     ++			if {![path_exists $path]} {
      +				unset file_states($path)
      +				display_file $path __
      +			}
     @@ -231,8 +442,8 @@
      -			[concat $after [list ui_ready]]
      +			$path_index \
      +			$deletion_errors \
     -+			$deletion_error_path \
      +			$batch_size \
     ++			$after
      +			]]
       	} else {
      -		unlock_index
     @@ -242,27 +453,33 @@
      +		# Report error, if any, based on how many deletions failed.
      +		set deletion_error_cnt [llength $deletion_errors]
      +
     -+		if {$deletion_error_cnt == 1} {
     -+			error_popup [mc \
     -+				"File %s could not be deleted: %s" \
     -+				$deletion_error_path \
     -+				[lindex $deletion_errors 0] \
     -+				]
     ++		if {($deletion_error_cnt > 0) && ($deletion_error_cnt <= [MAX_VERBOSE_FILES_IN_DELETION_ERROR])} {
     ++			set error_text "Encountered errors deleting files:\n"
     ++
     ++			foreach deletion_error $deletion_errors {
     ++				append error_text "* [lindex $deletion_error 0]\n"
     ++			}
     ++
     ++			error_popup $error_text
      +		} elseif {$deletion_error_cnt == $path_cnt} {
      +			error_popup [mc \
     -+				"None of the selected files could be deleted." \
     ++				"None of the %d selected files could be deleted." \
     ++				$path_cnt \
      +				]
      +		} elseif {$deletion_error_cnt > 1} {
      +			error_popup [mc \
     -+				"%d of the selected files could not be deleted." \
     -+				$deletion_error_cnt]
     ++				"%d of the %d selected files could not be deleted." \
     ++				$deletion_error_cnt \
     ++				$path_cnt \
     ++				]
      +		}
      +
     -+		reshow_diff
     -+		ui_ready
     ++		uplevel #0 $after
      +	}
      +}
      +
     ++proc MAX_VERBOSE_FILES_IN_DELETION_ERROR {} { return 10; }
     ++
      +# This function is from the TCL documentation:
      +#
      +#   https://wiki.tcl-lang.org/page/file+exists
     @@ -270,14 +487,15 @@
      +# [file exists] returns false if the path does exist but is a symlink to a path
      +# that doesn't exist. This proc returns true if the path exists, regardless of
      +# whether it is a symlink and whether it is broken.
     -+proc lexists name {
     ++proc path_exists {name} {
      +	expr {![catch {file lstat $name finfo}]}
      +}
      +
     -+# Remove as many empty directories as we can starting at the specified path.
     -+# If we encounter a directory that is not empty, or if a directory deletion
     -+# fails, then we stop the operation and return to the caller. Even if this
     -+# procedure fails to delete any directories at all, it does not report failure.
     ++# Remove as many empty directories as we can starting at the specified path,
     ++# walking up the directory tree. If we encounter a directory that is not
     ++# empty, or if a directory deletion fails, then we stop the operation and
     ++# return to the caller. Even if this procedure fails to delete any
     ++# directories at all, it does not report failure.
      +proc remove_empty_directories {directory_path} {
      +	set parent_path [file dirname $directory_path]
      +

-- 
gitgitgadget
