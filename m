Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD7781F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 09:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbfKMJ4g (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 04:56:36 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:36121 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727487AbfKMJ4e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 04:56:34 -0500
Received: by mail-wm1-f47.google.com with SMTP id c22so1275755wmd.1
        for <git@vger.kernel.org>; Wed, 13 Nov 2019 01:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4pFieX0zY5lygCrQO7hdLPtvxoq3ylOuworRXRhYWUk=;
        b=cBjsqic3Vab7wfM2cENN3MB/vbXsxpMPpFD1Qvb2wDGnbMl7LcEuYlwFXkuoAmLF8Z
         A+wYE4DHHjUuByJ76U94tKplL1NibomE/+9jdqklAQMndrVbHCZpqH6t36h8sBUX3xrK
         JpGXqx/21GyrYBe1jtB1qJ8DHKq5Jy4cH2mnMv1xp2S7mUkvxLLUGuY6Aq9iO/uqKs/F
         qX+/jA2c6eimvqYW9JQLVDTRnZtsJD4g9vV7CaJsCShiQ845yZjIEsGMHWxs3t0yVsd1
         eBQECgPKC6ztpd5+OiBJ2cl5VreWTRN5LwpOr8uTNwxPXv+6ZOngDiqy5ycoQOy+diYO
         bGFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4pFieX0zY5lygCrQO7hdLPtvxoq3ylOuworRXRhYWUk=;
        b=b37uO5hmanA9gJ4Y1JALLjYRudsfZy+zlttywVmOQkPBHX5NW5ip3M7ggKZ4ZQ8AwL
         lsGEjpp00GBY//DNelUoCr8lVcAWOIaRc9kCz5uEMz3i9f7RjZJrMpDexkILEwZSsOXW
         NaNApN5Mjs34xgs4PoUHHyJJTg4Yf/CDDQ3D3d6BMfehgT+H88APfA3A7c9EYLQPL4od
         Y/5ymmoZErCtwtX1R3NxGsK4h7JL9H+SjNs/qqfqzaW9QHI4WM9uiEjlw9/kF8cFJVK2
         AJ8cK2v94AgRPN85jho8nMErU7VUwKXTfYE43oanbhcN5/K5Si39y+9e6TRFKhrzILWs
         9paA==
X-Gm-Message-State: APjAAAVREqfCUHgqc08sfBVYXb6CfHtV4mQGi3N6MzwYT4VXTimevss2
        iEvLAo977zcbho6RuD1DoLS4dWcI
X-Google-Smtp-Source: APXvYqwdf38I77W23JHCrxgDrXca0nDSHGK68Ujx8he6iukfN34OK/cwjyN1QsZi3MTpFwAGaw57xw==
X-Received: by 2002:a1c:7f44:: with SMTP id a65mr1897714wmd.19.1573638989657;
        Wed, 13 Nov 2019 01:56:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a16sm1791998wmd.11.2019.11.13.01.56.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2019 01:56:28 -0800 (PST)
Message-Id: <pull.436.v3.git.1573638988.gitgitgadget@gmail.com>
In-Reply-To: <pull.436.v2.git.1573110335.gitgitgadget@gmail.com>
References: <pull.436.v2.git.1573110335.gitgitgadget@gmail.com>
From:   "Jonathan Gilbert via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 13 Nov 2019 09:56:25 +0000
Subject: [PATCH v3 0/2] git-gui: revert untracked files by deleting them
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

The _close_updateindex proc contains error handling (added in d4e890e5) that
has the potential to interact badly with unlock_index running at the
completion of an async operation. I have refactored the procedure into
separate procs _close_updateindex and rescan_on_error, and the original
functionality is captured with _close_updateindex_rescan_on_error. Call
sites have been updated appropriately, and checkout_index has been reworked
to take a functor that captures any errors that occur in a caller-defined
way. revert_helper uses this to supply a lambda function that stashes the
error within the chord's body namespace, so that it can call rescan_on_error 
when the chord is completed, which might be substantially after 
checkout_index encounters its error. If a rescan is called for, it is done
once the deletion is complete.

This is the fourth revision of this change, which differs from the third
version in the following ways:

 * Merged some of the wording from the cover letter into the commit message.
   
   
 * The Tcl/Tk dependency is updated to 8.6.
   
   
 * The chord.tcl documentation has been reworked, moving the mechanistic
   class/member documentation next to the declarations, and including a more
   "human-readable" holistic explanation at the top.
   
   
 * Class variables defined within chord.tcl have snake_case names. When I
   made this switch, I saw one possible reason why the convention from the
   Tcl documentation was different: it's quite common to have a parameter to
   the constructor with the same name as a class variable, and if the names
   are literally identical then they conflict in the namespace (e.g. set
   body $body).
   
   
 * Removed unnecessary variable from revert_helper in index.tcl, added
   comments and split long line per feedback.
   
   
 * _close_updateindex's error handling is split out to new proc 
   rescan_on_error, and _close_updateindex_rescan_on_error calls 
   rescan_on_error if it catches an error from _close_updateindex. Most call
   sites are updated to call the wrapper function, but the split is crucial
   for error handling within revert_helper.
   
   
 * checkout_index uses the _close_updateindex without the error handler, and
   instead takes a functor from the caller that allows the caller to do
   whatever it wants with any errors that occur (but without abnormally
   terminating the execution of checkout_index the way throwing an error
   would).
   
   
 * revert_helper is where the most meaningful change is. The $after_chord 
   body now checks for a stashed error, and if there is one, it calls 
   rescan_on_error. I create a lambda function $capture_error that takes
   whatever error message is passed to it and stashes it in $after_chord's
   namespace. Then, this is passed to checkout_index. The result is that if
   an error happens closing the index, the error message is passed back up,
   and then the checkout note is activated, but the $after_chord body
   doesn't execute until the deletion note is also activated, delaying the
   rescan until after the deletion is complete too.
   
   

On Mon, Nov 11, 2019 at 1:25 PM Pratyush Yadav me@yadavpratyush.com
[me@yadavpratyush.com] wrote:

> The 'class' documentation [0] suggests adding a "package require TclOO". But
TclOO ships by default with Tcl 8.6 and above. So, I'm not really sure if we
need this.


I couldn't find any evidence that it is required in my testing.

On Tue, Nov 12, 2019 at 1:35 PM Pratyush Yadav me@yadavpratyush.com
[me@yadavpratyush.com] wrote:

> > > > +oo::class create SimpleChord {


This comes from the TclOO package, right?

git-gui has its own object-oriented system (lib/class.tcl). It was written
circa 2007. I suspect something like TclOO did not exist back then.

Why not use that? Does it have some limitations that TclOO does not have? I
do not mind using the "official" OO system. I just want to know why exactly
you made the choice.


Having limited experience with Tcl, I did a Google search for "tcl object
oriented" and ended up writing code using TclOO because that's what came up.
Do you think it makes sense to rework this to useclass.tcl, or perhaps
instead the opposite: have a policy of using the standard TclOO going
forward, and let the rest of Git Gui organically upgrade itself to some
hypothetical point in the future where class.tcl is no longer used by
anything?


Replacing class.tcl would be a big effort, and seeing how things stand as of
now in terms of active contributors, I don't think it would happen in the
near future.

So the question really boils down to "do we want to mix these two flavors of
OO frameworks?".

If TclOO gives us some benefit over our homegrown framework, or if our
framework is in some way hard to use, then I would certainly side on just
sticking with TclOO.


It looks like the "treat an object as a method" functionality that the 
unknown method provides is not easily duplicated with class.tcl. It would be
possible to just replace it with a named method, but the code using it
wouldn't look as nice. Also, not that it matters in this instance, but
purely as a matter of principle, from what I've read, it seems that TclOO is
significantly supported by native code in the runtime and has much better
performance and far less overhead than all pre-8.6 OO solutions. This
suggests that a long-term goal of eliminating class.tcl might not be a bad
idea. I haven't seen any way that having chord.tcl use TclOO could interfere
with other, unrelated things using class.tcl.

> > > >  * method notify_note_activation {} {


Since this method is for internal use only, can it be made "private"? Does
the OO library support something like this?


I don't think so, because it's called from outside the class. What we'd be
looking for is something like C++'s "friend" syntax. Tcl doesn't seem to
have this. Though, I just did some further Googling, and saw a hint that it
might be possible to bypass member security on a case-by-case basis, so that
the method is private but ChordNote is able to call it anyway. I'll see if I
can't figure this out. :-)


I don't think too much complexity/hacking is warranted for something like
this. If you can figure out a really simple way to do it, great! Otherwise,
just keep it like it is.


It seems that there isn't any way in TclOO to get into a class without it
having a public "door", whether it's the method itself, or some "accessor"
method that returns its [my] functor. You can choose to unexport a method,
but once you do that, there doesn't appear to exist any way at all to
override this for just one call site.

> > "This is a mechanism for making an object that can be called like a method."


Looks like this method would also be called if someone misspelled a method
name for this object. So say if someone by mistake writes

 $note is_activate

this method would be called. This is a clear bug. So, add a check here to
make sure 'methodName' is actually absent. And if it isn't, display an
error. Displaying an error to the user on a programmer error can get
annoying. But since we don't have something like assertions in git-gui yet,
maybe that's the best way to get bugs noticed.


I did some testing and discovered that I was mistaken, if unknown has no
parameters then it cannot receive calls to unknown method names, these
generate errors. As written, it is only capable of processing calls against
the object itself.

> > Hmm, so, yeah, the entire if statement only occurs if it can't close the
file descriptor. Is that something that actually happens? If so, then it
should perhaps be throwing an exception, because having started a rescan is
probably more than the caller bargained for. That would prevent the callers
from unlocking the index out from under the rescan, and also cancel any
other processing they might be doing that is probably making bad assumptions
with a rescan running.


This seems like defensive programming. It is accounting for somethingreally
bad happening.


[..]

> So, this recovery code has to go somewhere. Yes, a rescan is certainly more
than what the caller wanted, but it is better than working on an
inconsistent in-memory state of the repo.

The question then becomes where the best place to do so is. This seems like
a good one if we can get our locking requirements to work with it properly.>
The glaring problem is that we don't want the rescan to run while the
deletion task is still running because they will interfere with each other.
Also, deletion expects the index to be locked, so the rescan and deletion
should be mutually exclusive.


I came up with a fairly concise way to defer the rescan until all async
operations are completed, by splitting the error handling out into a
separate method and then making this flow call that method from the
$after_chord body.

Jonathan Gilbert (2):
  git-gui: consolidate naming conventions
  git-gui: revert untracked files by deleting them

 git-gui.sh    |   4 +-
 lib/chord.tcl | 160 ++++++++++++++++
 lib/index.tcl | 500 +++++++++++++++++++++++++++++++++++++-------------
 3 files changed, 538 insertions(+), 126 deletions(-)
 create mode 100644 lib/chord.tcl


base-commit: b524f6b399c77b40c8bf2b6217585fde4731472a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-436%2Flogiclrd%2Fgit-gui-revert-untracked-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-436/logiclrd/git-gui-revert-untracked-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/436

Range-diff vs v2:

 1:  da1704c56e = 1:  da1704c56e git-gui: consolidate naming conventions
 2:  9469beb599 ! 2:  dc12c1668d git-gui: revert untracked files by deleting them
     @@ -2,66 +2,72 @@
      
          git-gui: revert untracked files by deleting them
      
     -    Update the revert_helper procedure to also detect untracked files. If
     -    files are present, the user is asked if they want them deleted. Perform
     -    the deletion in batches, using new proc delete_files with helper
     -    delete_helper, to allow the UI to remain responsive. Coordinate the
     -    completion of multiple overlapping asynchronous operations using a new
     -    construct called a "chord". Migrate unlocking of the index out of
     -    _close_updateindex to a responsibility of the caller, to permit paths
     -    that don't directly unlock the index.
     +    Update the revert_helper proc to check for untracked files as well as
     +    changes, and then handle changes to be reverted and untracked files with
     +    independent blocks of code. Prompt the user independently for untracked
     +    files, since the underlying action is fundamentally different (rm -f).
     +    If after deleting untracked files, the directory containing them becomes
     +    empty, then remove the directory as well. Migrate unlocking of the index
     +    out of _close_updateindex to a responsibility of the caller, to permit
     +    paths that don't directly unlock the index, and refactor the error
     +    handling added in d4e890e5 so that callers can make flow control
     +    decisions in the event of errors.
     +
     +    A new proc delete_files takes care of actually deleting the files in
     +    batches, using the Tcler's Wiki recommended approach for keeping the UI
     +    responsive.
     +
     +    Since the checkout_index and delete_files calls are both asynchronous
     +    and could potentially complete in any order, a "chord" is used to
     +    coordinate unlocking the index and returning the UI to a usable state
     +    only after both operations are complete. The `SimpleChord` class,
     +    based on TclOO (Tcl/Tk 8.6), is added in this commit.
      
          Signed-off-by: Jonathan Gilbert <JonathanG@iQmetrix.com>
      
     + diff --git a/git-gui.sh b/git-gui.sh
     + --- a/git-gui.sh
     + +++ b/git-gui.sh
     +@@
     + ##
     + ## Tcl/Tk sanity check
     + 
     +-if {[catch {package require Tcl 8.4} err]
     +- || [catch {package require Tk  8.4} err]
     ++if {[catch {package require Tcl 8.6} err]
     ++ || [catch {package require Tk  8.6} err]
     + } {
     + 	catch {wm withdraw .}
     + 	tk_messageBox \
     +
       diff --git a/lib/chord.tcl b/lib/chord.tcl
       new file mode 100644
       --- /dev/null
       +++ b/lib/chord.tcl
      @@
     -+# SimpleChord class:
     -+#   Represents a procedure that conceptually has multiple entrypoints that must
     -+#   all be called before the procedure executes. Each entrypoint is called a
     -+#   "note". The chord is only "completed" when all the notes are "activated".
     -+#
     -+#   Constructor:
     -+#     set chord [SimpleChord new {body}]
     -+#       Creates a new chord object with the specified body script. The body
     -+#       script is evaluated at most once, when a note is activated and the
     -+#       chord has no other non-activated notes.
     -+#
     -+#   Methods:
     -+#     $chord eval {script}
     -+#       Runs the specified script in the same context (namespace) in which the
     -+#       chord body will be evaluated. This can be used to set variable values
     -+#       for the chord body to use.
     -+#
     -+#     set note [$chord add_note]
     -+#       Adds a new note to the chord, an instance of ChordNote. Raises an
     -+#       error if the chord is already completed, otherwise the chord is updated
     -+#       so that the new note must also be activated before the body is
     -+#       evaluated.
     -+#
     -+#     $chord notify_note_activation
     -+#       For internal use only.
     -+#
     -+# ChordNote class:
     -+#   Represents a note within a chord, providing a way to activate it. When the
     -+#   final note of the chord is activated (this can be any note in the chord,
     -+#   with all other notes already previously activated in any order), the chord's
     -+#   body is evaluated.
     ++# Simple Chord for Tcl
      +#
     -+#   Constructor:
     -+#     Instances of ChordNote are created internally by calling add_note on
     -+#     SimpleChord objects.
     ++# A "chord" is a method with more than one entrypoint and only one body, such
     ++# that the body runs only once all the entrypoints have been called by
     ++# different asynchronous tasks. In this implementation, the chord is defined
     ++# dynamically for each invocation. A SimpleChord object is created, supplying
     ++# body script to be run when the chord is completed, and then one or more notes
     ++# are added to the chord. Each note can be called like a proc, and returns
     ++# immediately if the chord isn't yet complete. When the last remaining note is
     ++# called, the body runs before the note returns.
      +#
     -+#   Methods:
     -+#     [$note is_activated]
     -+#       Returns true if this note has already been activated.
     ++# The SimpleChord class has a constructor that takes the body script, and a
     ++# method add_note that returns a note object. Since the body script does not
     ++# run in the context of the procedure that defined it, a mechanism is provided
     ++# for injecting variables into the chord for use by the body script. The
     ++# activation of a note is idempotent; multiple calls have the same effect as
     ++# a simple call.
      +#
     -+#     $note
     -+#       Activates the note, if it has not already been activated, and completes
     -+#       the chord if there are no other notes awaiting activation. Subsequent
     -+#       calls will have no further effect.
     ++# If you are invoking asynchronous operations with chord notes as completion
     ++# callbacks, and there is a possibility that earlier operations could complete
     ++# before later ones are started, it is a good practice to create a "common"
     ++# note on the chord that prevents it from being complete until you're certain
     ++# you've added all the notes you need.
      +#
      +# Example:
      +#
     @@ -97,61 +103,105 @@
      +# last one, completing the chord before this code finishes, or anything in
      +# between. The purpose of the chord is to not have to worry about the order.
      +
     ++# SimpleChord class:
     ++#   Represents a procedure that conceptually has multiple entrypoints that must
     ++#   all be called before the procedure executes. Each entrypoint is called a
     ++#   "note". The chord is only "completed" when all the notes are "activated".
      +oo::class create SimpleChord {
     -+	variable Notes
     -+	variable Body
     -+	variable IsCompleted
     ++	variable notes body is_completed
      +
     ++	# Constructor:
     ++	#   set chord [SimpleChord new {body}]
     ++	#     Creates a new chord object with the specified body script. The
     ++	#     body script is evaluated at most once, when a note is activated
     ++	#     and the chord has no other non-activated notes.
      +	constructor {body} {
     -+		set Notes [list]
     -+		set Body $body
     -+		set IsCompleted 0
     ++		set notes [list]
     ++		my eval [list set body $body]
     ++		set is_completed 0
      +	}
      +
     ++	# Method:
     ++	#   $chord eval {script}
     ++	#     Runs the specified script in the same context (namespace) in which
     ++	#     the chord body will be evaluated. This can be used to set variable
     ++	#     values for the chord body to use.
      +	method eval {script} {
      +		namespace eval [self] $script
      +	}
      +
     ++	# Method:
     ++	#   set note [$chord add_note]
     ++	#     Adds a new note to the chord, an instance of ChordNote. Raises an
     ++	#     error if the chord is already completed, otherwise the chord is
     ++	#     updated so that the new note must also be activated before the
     ++	#     body is evaluated.
      +	method add_note {} {
     -+		if {$IsCompleted} { error "Cannot add a note to a completed chord" }
     ++		if {$is_completed} { error "Cannot add a note to a completed chord" }
      +
      +		set note [ChordNote new [self]]
      +
     -+		lappend Notes $note
     ++		lappend notes $note
      +
      +		return $note
      +	}
      +
     ++	# This method is for internal use only and is intentionally undocumented.
      +	method notify_note_activation {} {
     -+		if {!$IsCompleted} {
     -+			foreach note $Notes {
     ++		if {!$is_completed} {
     ++			foreach note $notes {
      +				if {![$note is_activated]} { return }
      +			}
      +
     -+			set IsCompleted 1
     ++			set is_completed 1
      +
     -+			namespace eval [self] $Body
     ++			namespace eval [self] $body
      +			namespace delete [self]
      +		}
      +	}
      +}
      +
     ++# ChordNote class:
     ++#   Represents a note within a chord, providing a way to activate it. When the
     ++#   final note of the chord is activated (this can be any note in the chord,
     ++#   with all other notes already previously activated in any order), the chord's
     ++#   body is evaluated.
      +oo::class create ChordNote {
     -+	variable Chord IsActivated
     ++	variable chord is_activated
      +
     ++	# Constructor:
     ++	#   Instances of ChordNote are created internally by calling add_note on
     ++	#   SimpleChord objects.
      +	constructor {chord} {
     -+		set Chord $chord
     -+		set IsActivated 0
     ++		my eval set chord $chord
     ++		set is_activated 0
      +	}
      +
     ++	# Method:
     ++	#   [$note is_activated]
     ++	#     Returns true if this note has already been activated.
      +	method is_activated {} {
     -+		return $IsActivated
     ++		return $is_activated
      +	}
      +
     ++	# Method:
     ++	#   $note
     ++	#     Activates the note, if it has not already been activated, and
     ++	#     completes the chord if there are no other notes awaiting
     ++	#     activation. Subsequent calls will have no further effect.
     ++	#
     ++	# NB: In TclOO, if an object is invoked like a method without supplying
     ++	#     any method name, then this internal method `unknown` is what
     ++	#     actually runs (with no parameters). It is used in the ChordNote
     ++	#     class for the purpose of allowing the note object to be called as
     ++	#     a function (see example above). (The `unknown` method can also be
     ++	#     used to support dynamic dispatch, but must take parameters to
     ++	#     identify the "unknown" method to be invoked. In this form, this
     ++	#     proc serves only to make instances behave directly like methods.)
      +	method unknown {} {
     -+		if {!$IsActivated} {
     -+			set IsActivated 1
     -+			$Chord notify_note_activation
     ++		if {!$is_activated} {
     ++			set is_activated 1
     ++			$chord notify_note_activation
      +		}
      +	}
      +}
     @@ -164,16 +214,103 @@
       }
       
      -proc _close_updateindex {fd after} {
     +-	global use_ttk NS
     ++# Returns true if the operation succeeded, false if a rescan has been initiated.
     ++proc _close_updateindex_rescan_on_error {fd} {
     ++	if {![catch {_close_updateindex $fd} err]} {
     ++		return true
     ++	} else {
     ++		rescan_on_error $err
     ++		return false
     ++	}
     ++}
     ++
      +proc _close_updateindex {fd} {
     - 	global use_ttk NS
       	fconfigure $fd -blocking 1
     - 	if {[catch {close $fd} err]} {
     -@@
     - 	}
     +-	if {[catch {close $fd} err]} {
     +-		set w .indexfried
     +-		Dialog $w
     +-		wm withdraw $w
     +-		wm title $w [strcat "[appname] ([reponame]): " [mc "Index Error"]]
     +-		wm geometry $w "+[winfo rootx .]+[winfo rooty .]"
     +-		set s [mc "Updating the Git index failed.  A rescan will be automatically started to resynchronize git-gui."]
     +-		text $w.msg -yscrollcommand [list $w.vs set] \
     +-			-width [string length $s] -relief flat \
     +-			-borderwidth 0 -highlightthickness 0 \
     +-			-background [get_bg_color $w]
     +-		$w.msg tag configure bold -font font_uibold -justify center
     +-		${NS}::scrollbar $w.vs -command [list $w.msg yview]
     +-		$w.msg insert end $s bold \n\n$err {}
     +-		$w.msg configure -state disabled
     +-
     +-		${NS}::button $w.continue \
     +-			-text [mc "Continue"] \
     +-			-command [list destroy $w]
     +-		${NS}::button $w.unlock \
     +-			-text [mc "Unlock Index"] \
     +-			-command "destroy $w; _delete_indexlock"
     +-		grid $w.msg - $w.vs -sticky news
     +-		grid $w.unlock $w.continue - -sticky se -padx 2 -pady 2
     +-		grid columnconfigure $w 0 -weight 1
     +-		grid rowconfigure $w 0 -weight 1
     +-
     +-		wm protocol $w WM_DELETE_WINDOW update
     +-		bind $w.continue <Visibility> "
     +-			grab $w
     +-			focus %W
     +-		"
     +-		wm deiconify $w
     +-		tkwait window $w
     ++	close $fd
     ++	$::main_status stop
     ++}
     + 
     +-		$::main_status stop
     +-		unlock_index
     +-		rescan $after 0
     +-		return
     +-	}
     ++proc rescan_on_error {err} {
     ++	global use_ttk NS
     ++
     ++	set w .indexfried
     ++	Dialog $w
     ++	wm withdraw $w
     ++	wm title $w [strcat "[appname] ([reponame]): " [mc "Index Error"]]
     ++	wm geometry $w "+[winfo rootx .]+[winfo rooty .]"
     ++	set s [mc "Updating the Git index failed.  A rescan will be automatically started to resynchronize git-gui."]
     ++	text $w.msg -yscrollcommand [list $w.vs set] \
     ++		-width [string length $s] -relief flat \
     ++		-borderwidth 0 -highlightthickness 0 \
     ++		-background [get_bg_color $w]
     ++	$w.msg tag configure bold -font font_uibold -justify center
     ++	${NS}::scrollbar $w.vs -command [list $w.msg yview]
     ++	$w.msg insert end $s bold \n\n$err {}
     ++	$w.msg configure -state disabled
     ++
     ++	${NS}::button $w.continue \
     ++		-text [mc "Continue"] \
     ++		-command [list destroy $w]
     ++	${NS}::button $w.unlock \
     ++		-text [mc "Unlock Index"] \
     ++		-command "destroy $w; _delete_indexlock"
     ++	grid $w.msg - $w.vs -sticky news
     ++	grid $w.unlock $w.continue - -sticky se -padx 2 -pady 2
     ++	grid columnconfigure $w 0 -weight 1
     ++	grid rowconfigure $w 0 -weight 1
     ++
     ++	wm protocol $w WM_DELETE_WINDOW update
     ++	bind $w.continue <Visibility> "
     ++		grab $w
     ++		focus %W
     ++	"
     ++	wm deiconify $w
     ++	tkwait window $w
       
       	$::main_status stop
     --	unlock_index
     + 	unlock_index
      -	uplevel #0 $after
     ++	rescan ui_ready 0
       }
       
       proc update_indexinfo {msg path_list after} {
     @@ -182,8 +319,10 @@
       
       	if {$update_index_cp >= $total_cnt} {
      -		_close_updateindex $fd $after
     -+		_close_updateindex $fd
     -+		unlock_index
     ++		if {[_close_updateindex_rescan_on_error $fd]} {
     ++			unlock_index
     ++		}
     ++
      +		uplevel #0 $after
       		return
       	}
     @@ -193,37 +332,86 @@
       
       	if {$update_index_cp >= $total_cnt} {
      -		_close_updateindex $fd $after
     -+		_close_updateindex $fd
     -+		unlock_index
     ++		if {[_close_updateindex_rescan_on_error $fd]} {
     ++			unlock_index
     ++		}
     ++
      +		uplevel #0 $after
       		return
       	}
       
      @@
     + 	$::main_status update $update_index_cp $total_cnt
     + }
     + 
     +-proc checkout_index {msg path_list after} {
     ++proc checkout_index {msg path_list after capture_error} {
     + 	global update_index_cp
     + 
     + 	if {![lock_index update]} return
     +@@
     + 		$total_cnt \
     + 		$batch \
     + 		$after \
     ++		$capture_error \
     + 		]
     + }
     + 
     +-proc write_checkout_index {fd path_list total_cnt batch after} {
     ++proc write_checkout_index {fd path_list total_cnt batch after capture_error} {
     + 	global update_index_cp
       	global file_states current_diff_path
       
       	if {$update_index_cp >= $total_cnt} {
      -		_close_updateindex $fd $after
     -+		_close_updateindex $fd $do_unlock_index $after
     ++		if {[catch {_close_updateindex $fd} err]} {
     ++			uplevel #0 $capture_error [list $err]
     ++		}
     ++
      +		uplevel #0 $after
     ++
       		return
       	}
       
      @@
     + 	add_helper [mc "Adding all changed files"] $paths
     + }
     + 
     ++# Copied from TclLib package "lambda".
     ++proc lambda {arguments body args} {
     ++	return [list ::apply [list $arguments $body] {*}$args]
     ++}
     ++
     + proc revert_helper {txt paths} {
     + 	global file_states current_diff_path
       
       	if {![lock_index begin-update]} return
       
      +	# Common "after" functionality that waits until multiple asynchronous
      +	# operations are complete (by waiting for them to activate their notes
      +	# on the chord).
     ++	#
     ++	# The asynchronous operations are each indicated below by a comment
     ++	# before the code block that starts the async operation.
      +	set after_chord [SimpleChord new {
      +		unlock_index
     -+		if {$should_reshow_diff} { reshow_diff }
     -+		ui_ready
     ++		if {[string trim $err] != ""} {
     ++			rescan_on_error $err
     ++		} else {
     ++			if {$should_reshow_diff} { reshow_diff }
     ++			ui_ready
     ++		}
      +	}]
      +
      +	$after_chord eval { set should_reshow_diff 0 }
      +
     ++	# This function captures an error for processing when after_chord is
     ++	# completed. (The chord is curried into the lambda function.)
     ++	set capture_error [lambda \
     ++		{chord error} \
     ++		{ $chord eval [list set err $error] } \
     ++		$after_chord]
     ++
      +	# We don't know how many notes we're going to create (it's dynamic based
      +	# on conditional paths below), so create a common note that will delay
      +	# the chord's completion until we activate it, and then activate it
     @@ -231,8 +419,9 @@
      +	set after_common_note [$after_chord add_note]
      +
       	set path_list [list]
     +-	set after {}
      +	set untracked_list [list]
     - 	set after {}
     ++
       	foreach path $paths {
       		switch -glob -- [lindex $file_states($path) 0] {
       		U? {continue}
     @@ -253,26 +442,9 @@
       
      +	set path_cnt [llength $path_list]
      +	set untracked_cnt [llength $untracked_list]
     - 
     --	# Split question between singular and plural cases, because
     --	# such distinction is needed in some languages. Previously, the
     --	# code used "Revert changes in" for both, but that can't work
     --	# in languages where 'in' must be combined with word from
     --	# rest of string (in different way for both cases of course).
     --	#
     --	# FIXME: Unfortunately, even that isn't enough in some languages
     --	# as they have quite complex plural-form rules. Unfortunately,
     --	# msgcat doesn't seem to support that kind of string translation.
     --	#
     --	set n [llength $path_list]
     --	if {$n == 0} {
     --		unlock_index
     --		return
     --	} elseif {$n == 1} {
     --		set query [mc "Revert changes in file %s?" [short_path [lindex $path_list]]]
     --	} else {
     --		set query [mc "Revert changes in these %i files?" $n]
     --	}
     ++
     ++	# Asynchronous operation: revert changes by checking them out afresh
     ++	# from the index.
      +	if {$path_cnt > 0} {
      +		# Split question between singular and plural cases, because
      +		# such distinction is needed in some languages. Previously, the
     @@ -295,25 +467,31 @@
      +				"Revert changes in these %i files?" \
      +				$path_cnt]
      +		}
     - 
     --	set reply [tk_dialog \
     --		.confirm_revert \
     --		"[appname] ([reponame])" \
     --		"$query
     ++
      +		set reply [tk_dialog \
      +			.confirm_revert \
      +			"[appname] ([reponame])" \
      +			"$query
       
     - [mc "Any unstaged changes will be permanently lost by the revert."]" \
     --		question \
     --		1 \
     --		[mc "Do Nothing"] \
     --		[mc "Revert Changes"] \
     --		]
     --	if {$reply == 1} {
     --		checkout_index \
     --			$txt \
     +-	# Split question between singular and plural cases, because
     +-	# such distinction is needed in some languages. Previously, the
     +-	# code used "Revert changes in" for both, but that can't work
     +-	# in languages where 'in' must be combined with word from
     +-	# rest of string (in different way for both cases of course).
     +-	#
     +-	# FIXME: Unfortunately, even that isn't enough in some languages
     +-	# as they have quite complex plural-form rules. Unfortunately,
     +-	# msgcat doesn't seem to support that kind of string translation.
     +-	#
     +-	set n [llength $path_list]
     +-	if {$n == 0} {
     +-		unlock_index
     +-		return
     +-	} elseif {$n == 1} {
     +-		set query [mc "Revert changes in file %s?" [short_path [lindex $path_list]]]
     +-	} else {
     +-		set query [mc "Revert changes in these %i files?" $n]
     ++[mc "Any unstaged changes will be permanently lost by the revert."]" \
      +			question \
      +			1 \
      +			[mc "Do Nothing"] \
     @@ -324,10 +502,16 @@
      +			checkout_index \
      +				$txt \
      +				$path_list \
     -+				[$after_chord add_note]
     ++				[$after_chord add_note] \
     ++				$capture_error
      +		}
     -+	}
     -+
     + 	}
     + 
     +-	set reply [tk_dialog \
     +-		.confirm_revert \
     +-		"[appname] ([reponame])" \
     +-		"$query
     ++	# Asynchronous operation: Deletion of untracked files.
      +	if {$untracked_cnt > 0} {
      +		# Split question between singular and plural cases, because
      +		# such distinction is needed in some languages.
     @@ -348,7 +532,16 @@
      +				$untracked_cnt \
      +				]
      +		}
     -+
     + 
     +-[mc "Any unstaged changes will be permanently lost by the revert."]" \
     +-		question \
     +-		1 \
     +-		[mc "Do Nothing"] \
     +-		[mc "Revert Changes"] \
     +-		]
     +-	if {$reply == 1} {
     +-		checkout_index \
     +-			$txt \
      +		set reply [tk_dialog \
      +			.confirm_revert \
      +			"[appname] ([reponame])" \
     @@ -453,8 +646,9 @@
      +		# Report error, if any, based on how many deletions failed.
      +		set deletion_error_cnt [llength $deletion_errors]
      +
     -+		if {($deletion_error_cnt > 0) && ($deletion_error_cnt <= [MAX_VERBOSE_FILES_IN_DELETION_ERROR])} {
     -+			set error_text "Encountered errors deleting files:\n"
     ++		if {($deletion_error_cnt > 0)
     ++		 && ($deletion_error_cnt <= [MAX_VERBOSE_FILES_IN_DELETION_ERROR])} {
     ++			set error_text [mc "Encountered errors deleting files:\n"]
      +
      +			foreach deletion_error $deletion_errors {
      +				append error_text "* [lindex $deletion_error 0]\n"

-- 
gitgitgadget
