From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Dec 2014, #05; Mon, 29)
Date: Mon, 29 Dec 2014 13:28:01 -0800
Message-ID: <xmqq387yywm6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 29 22:28:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5hrL-0004Ao-Jf
	for gcvg-git-2@plane.gmane.org; Mon, 29 Dec 2014 22:28:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752479AbaL2V2K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2014 16:28:10 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55798 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752237AbaL2V2I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2014 16:28:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 52A5F2B799;
	Mon, 29 Dec 2014 16:28:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=N
	srmJCTyeLRYyqe4YJxmTbR+QVc=; b=eYkuHzY/8leCNx/WaTBKarBKGleV5tF/O
	hXSx0tUvzO3p7iCCl+pnSYl89SSoCnQkxKzVYGf9zLoiO9WBQ7JCPvAYKzuV2hRw
	tdAxc/gK4cEosnbqR4zhp1ElpRINrlIcemvQhV5Kyi4XmnXz6qQsoI/LXp+4WdP/
	Ej6Kpc/Gms=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=yUR
	z3C3cEM77fl5Wexny4gW9EjYBkN4KwPc6gIMmnm0I/7K3bWfVOCqQZzNbRfZmyda
	8Z9YB0oThOTGZLas4irwtJSZAgITcYySNWisvedN6x0YzGaVOqfTebSA6Y22X9fs
	1dOlYyIYogsafu5e3VTfPpEI9pLTlBMVp4gg8ZLM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 47A112B798;
	Mon, 29 Dec 2014 16:28:07 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 55F892B797;
	Mon, 29 Dec 2014 16:28:06 -0500 (EST)
X-master-at: c5b9256360b06efb9453c1627b78b14598e288b8
X-next-at: cc831f245cfe79ce0a9b574baf3c07960f338270
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9401BCD2-8FA1-11E4-BAF1-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261879>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

It has been understandably somewhat a slow week, and this will be
the last issue of "What's cooking" report for this year.  See you
all in the new year.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* jc/t9001-modernise (2014-11-25) 5 commits
  (merged to 'next' on 2014-12-23 at 3a2ec87)
 + t9001: style modernisation phase #5
 + t9001: style modernisation phase #4
 + t9001: style modernisation phase #3
 + t9001: style modernisation phase #2
 + t9001: style modernisation phase #1


* mh/update-ref-verify (2014-12-11) 2 commits
  (merged to 'next' on 2014-12-23 at 3aa9a62)
 + update-ref: fix "verify" command with missing <oldvalue>
 + t1400: add some more tests of "update-ref --stdin"'s verify command

 "git update-ref --stdin"'s verify command did not work well when
 <oldvalue>, which is documented as optional, was missing.

--------------------------------------------------
[New Topics]

* bw/maint-0090-awk-tweak (2014-12-23) 1 commit
  (merged to 'next' on 2014-12-29 at 9301c36)
 + t0090: tweak awk statement for Solaris /usr/xpg4/bin/awk

 Will merge to 'master'.


* cc/bisect-rev-parsing (2014-12-29) 2 commits
 - bisect: add test to check that revs are properly parsed
 - bisect: parse revs before passing them to check_expected_revs()

 The logic in "git bisect bad HEAD" etc. to avoid forcing the test
 of the common ancestor of bad and good commits was broken.

 Will merge to 'next'.


* es/checkout-index-temp (2014-12-29) 5 commits
 - checkout-index: fix --temp relative path mangling
 - t2004: demonstrate broken relative path printing
 - t2004: standardize file naming in symlink test
 - t2004: drop unnecessary write-tree/read-tree
 - t2004: modernize style

 "git checkout-index --temp=$target $path" did not work correctly
 for paths outside the current subdirectory in the project.

 Will merge to 'next'.


* js/remote-add-with-insteadof (2014-12-23) 2 commits
 - Add a regression test for 'git remote add <existing> <same-url>'
 - git remote: allow adding remotes agreeing with url.<...>.insteadOf

 "git remote add $name $URL" is now allowed when "url.$URL.insteadOf"
 is already defined.


* rs/plug-strbuf-leak-in-lock-ref (2014-12-29) 1 commit
 - refs: plug strbuf leak in lock_ref_sha1_basic()

 Will merge to 'next'.


* rs/plug-strbuf-leak-in-merge (2014-12-29) 1 commit
 - merge: release strbuf after use in suggest_conflicts()

 Will merge to 'next'.


* rs/simplify-parsing-commit-tree-S (2014-12-29) 1 commit
 - commit-tree: simplify parsing of option -S using skip_prefix()

 Will merge to 'next'.


* rs/simplify-transport-get (2014-12-29) 1 commit
 - transport: simplify duplicating a substring in transport_get() using xmemdupz()

 Will merge to 'next'.


* sb/doc-submitting-patches-keep-notes (2014-12-29) 1 commit
 - Documentation/SubmittingPatches: Explain the rationale of git notes

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* pw/remote-set-url-fetch (2014-11-26) 1 commit
 - remote: add --fetch and --both options to set-url

 Expecting a reroll.


* ms/submodule-update-config-doc (2014-11-03) 1 commit
 - submodule: clarify documentation for update subcommand

 Needs a reroll ($gmane/259037).


* je/quiltimport-no-fuzz (2014-10-21) 2 commits
 - git-quiltimport: flip the default not to allow fuzz
 - git-quiltimport.sh: allow declining fuzz with --exact option

 "quiltimport" drove "git apply" always with -C1 option to reduce
 context of the patch in order to give more chance to somewhat stale
 patches to apply.  Add an "--exact" option to disable, and also
 "-C$n" option to customize this behaviour.  The top patch
 optionally flips the default to "--exact".

 Tired of waiting for an Ack; will discard.


* jc/push-cert-hmac-optim (2014-09-25) 2 commits
 - receive-pack: truncate hmac early and convert only necessary bytes
 - sha1_to_hex: split out "hex-format n bytes" helper and use it

 This is "we could do this if we wanted to", not "we measured and it
 improves performance critical codepath".

 Will perhaps drop.


* mt/patch-id-stable (2014-06-10) 1 commit
 - patch-id: change default to stable

 Teaches "git patch-id" to compute the patch ID that does not change
 when the files in a single patch is reordered. As this new algorithm
 is backward incompatible, the last bit to flip it to be the default
 is left out of 'master' for now.

 Nobody seems to be jumping up & down requesting this last step,
 which makes the result somewhat backward incompatible.
 Will perhaps drop.


* tr/remerge-diff (2014-11-10) 9 commits
 - t4213: avoid "|" in sed regexp
 - log --remerge-diff: show what the conflict resolution changed
 - name-hash: allow dir hashing even when !ignore_case
 - merge-recursive: allow storing conflict hunks in index
 - merge_diff_mode: fold all merge diff variants into an enum
 - combine-diff: do not pass revs->dense_combined_merges redundantly
 - merge-recursive: -Xindex-only to leave worktree unchanged
 - merge-recursive: internal flag to avoid touching the worktree
 - merge-recursive: remove dead conditional in update_stages()

 "log -p" output learns a new way to let users inspect a merge
 commit by showing the differences between the automerged result
 with conflicts the person who recorded the merge would have seen
 and the final conflict resolution that was recorded in the merge.

 Waiting for a reroll ($gmane/256591).


* hv/submodule-config (2014-11-11) 4 commits
 - do not die on error of parsing fetchrecursesubmodules option
 - use new config API for worktree configurations of submodules
 - extract functions for submodule config set and lookup
 - implement submodule config cache for lookup of submodule names

 Kicked back to 'pu' per request ($gmane/255610).


* ab/add-interactive-show-diff-func-name (2014-05-12) 2 commits
 - SQUASH??? git-add--interactive: Preserve diff heading when splitting hunks
 - git-add--interactive: Preserve diff heading when splitting hunks

 Waiting for a reroll.


* jn/gitweb-utf8-in-links (2014-05-27) 1 commit
 - gitweb: Harden UTF-8 handling in generated links

 $gmane/250758?


* ss/userdiff-update-csharp-java (2014-06-02) 2 commits
 - userdiff: support Java try keyword
 - userdiff: support C# async methods and correct C# keywords

 Reviews sent; waiting for a response.


* bg/rebase-off-of-previous-branch (2014-04-16) 1 commit
 - git-rebase: print name of rev when using shorthand

 Teach "git rebase -" to report the concrete name of the branch
 (i.e. the previous one).

 But it stops short and does not do the same for "git rebase @{-1}".
 Expecting a reroll.


* rb/merge-prepare-commit-msg-hook (2014-01-10) 4 commits
 - merge: drop unused arg from abort_commit method signature
 - merge: make prepare_to_commit responsible for write_merge_state
 - t7505: ensure cleanup after hook blocks merge
 - t7505: add missing &&

 Expose more merge states (e.g. $GIT_DIR/MERGE_MODE) to hooks that
 run during "git merge".  The log message stresses too much on one
 hook, prepare-commit-msg, but it would equally apply to other hooks
 like post-merge, I think.

 Waiting for a reroll.


* jc/graph-post-root-gap (2013-12-30) 3 commits
 - WIP: document what we want at the end
 - graph: remove unused code a bit
 - graph: stuff the current commit into graph->columns[]

 This was primarily a RFH ($gmane/239580).


* tg/perf-lib-test-perf-cleanup (2013-09-19) 2 commits
 - perf-lib: add test_perf_cleanup target
 - perf-lib: split starting the test from the execution

 Add test_perf_cleanup shell function to the perf suite, that allows
 the script writers to define a test with a clean-up action.

 Will hold.


* jc/show-branch (2014-03-24) 5 commits
 - show-branch: use commit slab to represent bitflags of arbitrary width
 - show-branch.c: remove "all_mask"
 - show-branch.c: abstract out "flags" operation
 - show-branch.c: lift all_mask/all_revs to a global static
 - show-branch.c: update comment style

 Waiting for the final step to lift the hard-limit before sending it out.

--------------------------------------------------
[Cooking]

* bb/update-unicode-table (2014-12-22) 5 commits
  (merged to 'next' on 2014-12-23 at b4ce669)
 + update_unicode.sh: delete the command group
 + update_unicode.sh: make the output structure visible
 + update_unicode.sh: shorten uniset invocation path
 + update_unicode.sh: set UNICODE_DIR only once
 + update_unicode.sh: simplify output capture

 Simplify the procedure to generate unicode table.

 Will merge to 'master'.


* bc/fetch-thin-less-aggressive-in-normal-repository (2014-12-29) 3 commits
 - pack-objects: use --objects-edge-aggressive for shallow repos
 - rev-list: add an option to mark fewer edges as uninteresting
 - Documentation: add missing article in rev-list-options.txt

 Earlier we made "rev-list --object-edge" more aggressively list the
 objects at the edge commits, in order to reduce number of objects
 fetched into a shallow repository, but the change affected cases
 other than "fetching into a shallow repository" and made it
 unusably slow (e.g. fetching into a normal repository should not
 have to suffer the overhead from extra processing).  Limit it to a
 more specific case by introducing --objects-edge-aggressive, a new
 option to rev-list.

 Will merge to 'next'.


* es/squelch-openssl-warnings-on-macosx (2014-12-18) 1 commit
  (merged to 'next' on 2014-12-23 at e88cf6a)
 + git-compat-util: suppress unavoidable Apple-specific deprecation warnings

 Squelch useless compiler warnings on Mac OS X.

 Will merge to 'master'.


* jh/pre-push-sample-no-custom-ifs (2014-12-22) 1 commit
  (merged to 'next' on 2014-12-29 at c516021)
 + pre-push.sample: remove unnecessary and misleading IFS=' '

 The sample pre-push hook used customized IFS=' ' for no good reason.

 Will merge to 'master'.


* sb/atomic-push (2014-12-22) 7 commits
 - t5543-atomic-push.sh: add basic tests for atomic pushes
 - push.c: add an --atomic argument
 - receive-pack: move execute_commands_non_atomic before execute_commands
 - receive-pack.c: receive-pack.c: use a single ref_transaction for atomic pushes
 - send-pack.c: add --atomic command line argument
 - send-pack: rename ref_update_to_be_sent to check_to_send_update
 - receive-pack.c: add protocol support to negotiate atomic-push
 (this branch uses mh/reflog-expire.)

 "git push" has been taught a "--atomic" option that makes push to
 update more than one ref an "all-or-none" affair.


* sb/dco-indentation-fix (2014-12-22) 1 commit
  (merged to 'next' on 2014-12-23 at c865690)
 + Documentation/SubmittingPatches: unify whitespace/tabs for the DCO

 Will merge to 'master'.


* sb/t5400-remove-unused (2014-12-16) 1 commit
  (merged to 'next' on 2014-12-23 at a992011)
 + t5400: remove dead code

 Will merge to 'master'.


* tf/prompt-preserve-exit-status (2014-12-22) 1 commit
  (merged to 'next' on 2014-12-23 at dfcd89f)
 + git-prompt: preserve value of $? inside shell prompt

 Using the exit status of the last command in the prompt, e.g.
 PS1='$(__git_ps1) $? ', did not work well because the helper
 function stomped on the exit status.

 Will merge to 'master'.


* ye/http-accept-language (2014-12-22) 1 commit
 - http: Add Accept-Language header if possible

 Expecting a reroll ($gmane/261810).


* jk/strbuf-doc-to-header (2014-12-12) 4 commits
 - strbuf.h: reorganize api function grouping headers
 - strbuf.h: format asciidoc code blocks as 4-space indent
 - strbuf.h: drop asciidoc list formatting from API docs
 - strbuf: migrate api-strbuf.txt documentation to strbuf.h

 Resolve the "doc vs header" to favor the latter.

 Expecting to be rerolled.


* mh/reflog-expire (2014-12-22) 24 commits
 - refs.c: let fprintf handle the formatting
 - refs.c: don't expose the internal struct ref_lock in the header file
 - lock_any_ref_for_update(): inline function
 - refs.c: remove unlock_ref/close_ref/commit_ref from the refs api
 - reflog_expire(): new function in the reference API
 - expire_reflog(): treat the policy callback data as opaque
 - Move newlog and last_kept_sha1 to "struct expire_reflog_cb"
 - expire_reflog(): move rewrite to flags argument
 - expire_reflog(): move verbose to flags argument
 - expire_reflog(): pass flags through to expire_reflog_ent()
 - struct expire_reflog_cb: a new callback data type
 - Rename expire_reflog_cb to expire_reflog_policy_cb
 - expire_reflog(): move updateref to flags argument
 - expire_reflog(): move dry_run to flags argument
 - expire_reflog(): add a "flags" argument
 - expire_reflog(): extract two policy-related functions
 - Extract function should_expire_reflog_ent()
 - expire_reflog(): use a lock_file for rewriting the reflog file
 - expire_reflog(): return early if the reference has no reflog
 - expire_reflog(): rename "ref" parameter to "refname"
 - expire_reflog(): it's not an each_ref_fn anymore
 - refs.c: add a function to append a reflog entry to a fd
 - refs.c: make ref_transaction_delete a wrapper for ref_transaction_update
 - refs.c: make ref_transaction_create a wrapper for ref_transaction_update
 (this branch is used by sb/atomic-push.)

 Restructure "reflog expire" to fit the reflogs better with the
 recently updated ref API.

 Looked reasonable (except that some shortlog entries stood out like
 a sore thumb).


* po/doc-core-ignorestat (2014-12-12) 1 commit
  (merged to 'next' on 2014-12-23 at d2b3e84)
 + doc: core.ignoreStat clarify the --assume-unchanged effect

 Will merge to 'master'.


* jk/add-i-read-error (2014-12-15) 1 commit
  (merged to 'next' on 2014-12-23 at 9b76001)
 + add--interactive: leave main loop on read error

 "git add -i" did not notice when the interactive command input
 stream went away and kept asking.

 Will merge to 'master'.


* pd/completion-filenames-fix (2014-12-15) 1 commit
  (merged to 'next' on 2014-12-23 at e2b10ab)
 + Update documentation occurrences of filename .sh

 The top-of-the-file instruction for completion scripts (in contrib/)
 did not name the files correctly.

 Will merge to 'master'.


* rd/send-email-2047-fix (2014-12-15) 2 commits
  (merged to 'next' on 2014-12-23 at 2b101ce)
 + send-email: handle adjacent RFC 2047-encoded words properly
 + send-email: align RFC 2047 decoding more closely with the spec

 "git send-email" did not handle RFC 2047 encoded headers quite
 right.

 Will merge to 'master'.


* jn/doc-api-errors (2014-12-04) 1 commit
 - doc: document error handling functions and conventions

 For discussion.


* jn/rerere-fail-on-auto-update-failure (2014-12-03) 2 commits
 - SQUASH???
 - rerere: error out on autoupdate failure

 Will be rerolled as a part of a larger series.


* jc/push-to-checkout (2014-12-01) 2 commits
 - receive-pack: support push-to-checkout hook
 - receive-pack: refactor updateInstead codepath

 Extending the js/push-to-deploy topic, the behaviour of "git push"
 when updating the working tree and the index with an update to the
 branch that is checked out can be tweaked by push-to-checkout hook.

 Needs docs.


* lh/send-email-hide-x-mailer (2014-12-15) 2 commits
  (merged to 'next' on 2014-12-23 at fc16c68)
 + test/send-email: --[no-]xmailer tests
 + send-email: add --[no-]xmailer option

 "git send-email" normally identifies itself via X-Mailer: header
 in the message it sends out.  A new command line flag allows the
 header to be squelched.

 Will merge to 'master'.


* nd/list-files (2014-12-01) 19 commits
 - list-files: -M aka diff-cached
 - list-files -F: show submodules with the new indicator '&'
 - list-files: add -F/--classify
 - list-files: show directories as well as files
 - list-files: do not show duplicate cached entries
 - list-files: sort output and remove duplicates
 - list-files: add -t back
 - list-files: add -1 short for --no-column
 - list-files: add -R/--recursive short for --max-depth=-1
 - list-files: -u does not imply showing stages
 - list-files: a user friendly version of ls-files and more
 - ls-files: support --max-depth
 - ls-files: add --column
 - ls-files: add --color to highlight file names
 - ls-files: buffer full item in strbuf before printing
 - ls_colors.c: highlight submodules like directories
 - ls_colors.c: add a function to color a file name
 - ls_colors.c: parse color.ls.* from config file
 - ls_colors.c: add $LS_COLORS parsing code

 A new "git list-files" Porcelain command, "ls-files" with bells and
 whistles.


* nd/multiple-work-trees (2014-12-01) 34 commits
 - git-common-dir: make "modules/" per-working-directory directory
 - checkout: do not fail if target is an empty directory
 - t2025: add a test to make sure grafts is working from a linked checkout
 - checkout: don't require a work tree when checking out into a new one
 - git_path(): keep "info/sparse-checkout" per work-tree
 - count-objects: report unused files in $GIT_DIR/worktrees/...
 - gc: support prune --worktrees
 - gc: factor out gc.pruneexpire parsing code
 - gc: style change -- no SP before closing parenthesis
 - checkout: clean up half-prepared directories in --to mode
 - checkout: reject if the branch is already checked out elsewhere
 - prune: strategies for linked checkouts
 - checkout: support checking out into a new working directory
 - use new wrapper write_file() for simple file writing
 - wrapper.c: wrapper to open a file, fprintf then close
 - setup.c: support multi-checkout repo setup
 - setup.c: detect $GIT_COMMON_DIR check_repository_format_gently()
 - setup.c: convert check_repository_format_gently to use strbuf
 - setup.c: detect $GIT_COMMON_DIR in is_git_directory()
 - setup.c: convert is_git_directory() to use strbuf
 - git-stash: avoid hardcoding $GIT_DIR/logs/....
 - *.sh: avoid hardcoding $GIT_DIR/hooks/...
 - git-sh-setup.sh: use rev-parse --git-path to get $GIT_DIR/objects
 - $GIT_COMMON_DIR: a new environment variable
 - commit: use SEQ_DIR instead of hardcoding "sequencer"
 - fast-import: use git_path() for accessing .git dir instead of get_git_dir()
 - reflog: avoid constructing .lock path with git_path
 - *.sh: respect $GIT_INDEX_FILE
 - git_path(): be aware of file relocation in $GIT_DIR
 - path.c: group git_path(), git_pathdup() and strbuf_git_path() together
 - path.c: rename vsnpath() to do_git_path()
 - git_snpath(): retire and replace with strbuf_git_path()
 - path.c: make get_pathname() call sites return const char *
 - path.c: make get_pathname() return strbuf instead of static buffer

 A replacement for contrib/workdir/git-new-workdir that does not
 rely on symbolic links and make sharing of objects and refs safer
 by making the borrowee and borrowers aware of each other.


* sb/copy-fd-errno (2014-11-17) 1 commit
 - copy.c: make copy_fd preserve meaningful errno

 Will be rerolled as a part of a larger series.


* jk/approxidate-avoid-y-d-m-over-future-dates (2014-11-13) 2 commits
  (merged to 'next' on 2014-12-15 at 397e986)
 + approxidate: allow ISO-like dates far in the future
 + pass TIME_DATE_NOW to approxidate future-check

 Traditionally we tried to avoid interpreting date strings given by
 the user as future dates, e.g. GIT_COMMITTER_DATE=2014-12-10 when
 used early November 2014 was taken as "October 12, 2014" because it
 is likely that a date in the future, December 10, is a mistake.

 Loosen this and do not tiebreak by future-ness of the date when

 (1) ISO-like format is used, and
 (2) the string can make sense interpreted as both y-m-d and y-d-m.

 Will merge to 'master'.


* br/imap-send-verbosity (2014-11-05) 1 commit
  (merged to 'next' on 2014-12-15 at 504af0b)
 + imap-send: use parse options API to determine verbosity
 (this branch is used by br/imap-send-via-libcurl.)

 Will merge to 'master'.


* br/imap-send-via-libcurl (2014-11-10) 1 commit
  (merged to 'next' on 2014-12-15 at 90db637)
 + git-imap-send: use libcurl for implementation
 (this branch uses br/imap-send-verbosity.)

 Newer libCurl knows how to talk IMAP; "git imap-send" has been
 updated to use this instead of a hand-rolled OpenSSL calls.

 Will merge to 'master'.


* nd/lockfile-absolute (2014-11-03) 1 commit
  (merged to 'next' on 2014-12-15 at 34db9af)
 + lockfile.c: store absolute path

 The lockfile API can get confused which file to clean up when the
 process moved the $cwd after creating a lockfile.

 Will merge to 'master'.


* jc/merge-bases (2014-10-30) 2 commits
  (merged to 'next' on 2014-12-15 at cac279e)
 + get_merge_bases(): always clean-up object flags
 + bisect: clean flags after checking merge bases

 The get_merge_bases*() API was easy to misuse by careless
 copy&paste coders, leaving object flags tainted in the commits that
 needed to be traversed.

 Will merge to 'master'.


* jc/strbuf-add-lines-avoid-sp-ht-sequence (2014-10-27) 1 commit
  (merged to 'next' on 2014-12-15 at b499889)
 + strbuf_add_commented_lines(): avoid SP-HT sequence in commented lines

 The commented output used to blindly add a SP before the payload
 line, resulting in "# \t<indented text>\n" when the payload began
 with a HT.  Instead, produce "#\t<indented text>\n".

 Will merge to 'master'.


* nd/untracked-cache (2014-12-15) 24 commits
 - SQUASH???
 - untracked cache: guard and disable on system changes
 - mingw32: add uname()
 - t7063: tests for untracked cache
 - update-index: test the system before enabling untracked cache
 - update-index: manually enable or disable untracked cache
 - status: enable untracked cache
 - untracked-cache: temporarily disable with $GIT_DISABLE_UNTRACKED_CACHE
 - untracked cache: mark index dirty if untracked cache is updated
 - untracked cache: print stats with $GIT_TRACE_UNTRACKED_STATS
 - untracked cache: avoid racy timestamps
 - read-cache.c: split racy stat test to a separate function
 - untracked cache: invalidate at index addition or removal
 - untracked cache: load from UNTR index extension
 - untracked cache: save to an index extension
 - ewah: add convenient wrapper ewah_serialize_strbuf()
 - untracked cache: don't open non-existent .gitignore
 - untracked cache: mark what dirs should be recursed/saved
 - untracked cache: record/validate dir mtime and reuse cached output
 - untracked cache: make a wrapper around {open,read,close}dir()
 - untracked cache: invalidate dirs recursively if .gitignore changes
 - untracked cache: initial untracked cache validation
 - untracked cache: record .gitignore information and dir hierarchy
 - dir.c: optionally compute sha-1 of a .gitignore file

 Comments?


* jc/diff-b-m (2014-10-23) 1 commit
  (merged to 'next' on 2014-12-15 at 59c6636)
 + diff -B -M: fix output for "copy and then rewrite" case

 Fix long-standing bug in "diff -B -M" output.

 Will merge to 'master'.


* jc/checkout-local-track-report (2014-10-14) 1 commit
  (merged to 'next' on 2014-12-15 at e91a7df)
 + checkout: report upstream correctly even with loosely defined branch.*.merge

 The report from "git checkout" on a branch that builds on another
 local branch by setting its branch.*.merge to branch name (not a
 full refname) incorrectly said that the upstream is gone.

 Will merge to 'master'.


* jc/clone-borrow (2014-10-15) 1 commit
  (merged to 'next' on 2014-12-15 at 08fdf77)
 + clone: --dissociate option to mark that reference is only temporary

 Allow "git clone --reference" to be used more safely.

 Will merge to 'master'.

--------------------------------------------------
[Discarded]

* mb/enable-lib-terminal-test-on-newer-darwin (2014-11-14) 1 commit
 . t/lib-terminal: allow TTY tests to run under recent Mac OS

 We probably should drop this ($gmane/259609).


* zk/grep-color-words (2014-10-27) 2 commits
 . Revert "grep: fix match highlighting for combined patterns with context lines"
 . grep: fix match highlighting for combined patterns with context lines

 rs/grep-color-words topic solves it in a different way.

 Will discard.


* jn/dedup-doc-header (2014-12-10) 2 commits
 . put string-list API documentation in one place
 . put strbuf API documentation in one place

 We would want to have an easy way for developers to learn about
 APIs, and also a way to encourage them to keep the API
 documentation up to date when they make changes.  Having header
 comments and API documentation duplicated in two different places
 risked them going out of sync.

 The approach taken by jk/strbuf-doc-to-header is the other way
 around, which people seem to prefer, so this is discarded.


* jt/timer-settime (2014-08-29) 6 commits
 . use timer_settime() for new platforms
 . autoconf: check for timer_settime()
 . autoconf: check for struct itimerspec
 . autoconf: check for struct sigevent
 . autoconf: check for struct timespec
 . autoconf: check for timer_t

 Was wanting for a reroll.


* rs/ref-transaction-reflog (2014-11-03) 15 commits
 . refs.c: allow deleting refs with a broken sha1
 . refs.c: remove lock_any_ref_for_update
 . refs.c: make unlock_ref/close_ref/commit_ref static
 . refs.c: rename log_ref_setup to create_reflog
 . reflog.c: use a reflog transaction when writing during expire
 . refs.c: allow multiple reflog updates during a single transaction
 . refs.c: only write reflog update if msg is non-NULL
 . refs.c: add a flag to allow reflog updates to truncate the log
 . refs.c: add a transaction function to append a reflog entry
 . copy.c: make copy_fd preserve meaningful errno
 . refs.c: add a function to append a reflog entry to a fd
 . refs.c: add a new update_type field to ref_update
 . refs.c: rename the transaction functions
 . refs.c: make ref_transaction_delete a wrapper for ref_transaction_update
 . refs.c make ref_transaction_create a wrapper to ref_transaction_update
 (this branch is used by rs/ref-transaction-rename and rs/ref-transaction-send-pack.)

 Stefan Beller started working on reorganizing these three series,
 which unfortunately did not see much reviews.


* rs/ref-transaction-rename (2014-11-07) 16 commits
 . refs.c: add an err argument to pack_refs
 . refs.c: make lock_packed_refs take an err argument
 . refs.c: make add_packed_ref return an error instead of calling die
 . refs.c: replace the onerr argument in update_ref with a strbuf err
 . refs.c: make the *_packed_refs functions static
 . refs.c: make repack_without_refs static
 . remote.c: use a transaction for deleting refs
 . refs.c: write updates to packed refs when a transaction has more than one ref
 . refs.c: move reflog updates into its own function
 . refs.c: rollback the lockfile before we die() in repack_without_refs
 . refs.c: update rename_ref to use a transaction
 . refs.c: add transaction support for renaming a reflog
 . refs.c: use a stringlist for repack_without_refs
 . refs.c: use packed refs when deleting refs during a transaction
 . refs.c: return error instead of dying when locking fails during transaction
 . refs.c: allow passing raw git_committer_info as email to _update_reflog
 (this branch is used by rs/ref-transaction-send-pack; uses rs/ref-transaction-reflog.)

 Stefan Beller started working on reorganizing these three series,
 which unfortunately did not see much reviews.


* rs/ref-transaction-send-pack (2014-11-07) 7 commits
 . refs.c: add an err argument to create_symref
 . refs.c: add an err argument to create_reflog
 . t5543-atomic-push.sh: add basic tests for atomic pushes
 . push.c: add an --atomic-push argument
 . receive-pack.c: use a single transaction when atomic-push is negotiated
 . send-pack.c: add an --atomic-push command line argument
 . receive-pack.c: add protocol support to negotiate atomic-push
 (this branch uses rs/ref-transaction-reflog and rs/ref-transaction-rename.)

 Stefan Beller started working on reorganizing these three series,
 which unfortunately did not see much reviews.


* sb/simplify-repack-without-refs (2014-11-20) 1 commit
 . refs.c: use a string_list for repack_without_refs


* sb/log-ref-write-fd (2014-11-20) 1 commit
 . refs.c: add a function to append a reflog entry to a fd

 Will be rerolled as a part of a larger series.


* sb/ref-transaction-unify-to-update (2014-11-20) 2 commits
 . refs.c: make ref_transaction_delete a wrapper for ref_transaction_update
 . refs.c: make ref_transaction_create a wrapper for ref_transaction_update
 (this branch is used by sb/ref-transaction-reflog.)

 Code simplification.

 Will be rerolled as a part of a larger series.


* sb/write-sha1-update-reflog (2014-11-24) 1 commit
 . refs.c: move reflog updates into its own function

 Moves a part of function around to add a helper that still only has
 one caller.  Need to see how this helps in a bigger picture.


* sb/ref-transaction-reflog (2014-12-03) 2 commits
 . refs.c: rename transaction.updates to transaction.ref_updates
 . refs.c: rename the transaction functions
 (this branch uses sb/ref-transaction-unify-to-update.)

 Will be rerolled as a part of a larger series.
