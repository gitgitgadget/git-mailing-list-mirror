From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Dec 2015, #05; Tue, 15)
Date: Tue, 15 Dec 2015 14:48:42 -0800
Message-ID: <xmqq8u4ve3at.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 15 23:48:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8yOq-0002Wo-MD
	for gcvg-git-2@plane.gmane.org; Tue, 15 Dec 2015 23:48:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933759AbbLOWss (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 17:48:48 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58323 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933740AbbLOWsq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 17:48:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E3EFE32206;
	Tue, 15 Dec 2015 17:48:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=Y
	uA2I+8eOqpDr+CAPphgbWRphW4=; b=Uz0Uhq6U0+7w54s+rY+SQ21snTlQB2nWW
	jmtanY8KaTuc10mLXcwcQoCJ3rzCBIlDs8pL7FOhWBKPL2vd14Mj8EQbmwKg9rrd
	3XSKal+eoBR4n+Gz6pAK6Eh3KabZAnm19WD+wn1TIgUuSMKxlv726vzm51wnfAJV
	9MT2jQb5hs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=N7k
	y9cm+m+cDb2Qsuzda0e+GxZ7ouuzhPXWuP1tXUC0rPGnGeiqf00upDKKUPJAsq3L
	goiKp9VS36t4wbTSl2vRcniPXsjE8IAfCjNOyk9Zw3SfH7j/jH2gmx0q0iksH8d8
	LnwQZHs2aAd1o+K50xe6bs5FEvyzv1IsLzQrG+50=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DB048321FE;
	Tue, 15 Dec 2015 17:48:44 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2070C321FD;
	Tue, 15 Dec 2015 17:48:44 -0500 (EST)
X-master-at: f900c8326a43303685c46b279b9f70411bff1a4b
X-next-at: 94414c4510aaf2ba48821f6dd770ae47f2829dce
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FE8B3FC4-A37D-11E5-86B2-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282501>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

2.7-rc1 has been tagged.

I notice that quite a few topics have been in "waiting for review"
state without getting anybody helping the review process, leaving
them in 'pu'--they will not be part of 2.7 anyway, but the sooner
they are reviewed, in the more polished shape they can start in
the cycle after 2.7 gets tagged.

On the other hand, I've marked a handful of topics below as "Will
discard". They were all dormant after waiting for updates for quite
a long time; interested people may want to help resurrect them.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* cc/untracked (2015-12-15) 10 commits
 - dir: do not use untracked cache ident anymore
 - t7063: add tests for core.untrackedCache
 - config: add core.untrackedCache
 - dir: free untracked cache when removing it
 - dir: add remove_untracked_cache()
 - dir: add add_untracked_cache()
 - update-index: move 'uc' var declaration
 - update-index: add untracked cache notifications
 - update-index: add --test-untracked-cache
 - update-index: use enum for untracked cache options

 Update the untracked cache subsystem and change its primary UI from
 "git update-index" to "git config".

 Needs review.


* ep/make-phoney (2015-12-15) 1 commit
 - Makefile: add missing phony target

 A slight update to the Makefile.

 Needs review.
 Comments?

--------------------------------------------------
[Graduated to "master"]

* ep/ident-with-getaddrinfo (2015-12-14) 1 commit
  (merged to 'next' on 2015-12-15 at 2c19123)
 + ident: fix undefined variable when NO_IPV6 is set

 A fix-up for a recent topic.


* jk/prune-mtime (2015-08-12) 1 commit
  (merged to 'next' on 2015-12-14 at 4fba3f3)
 + prune: close directory earlier during loose-object directory traversal

 The helper used to iterate over loose object directories to prune
 stale objects did not closedir() immediately when it is done with a
 directory--a callback such as the one used for "git prune" may want
 to do rmdir(), but it would fail on open directory on platforms
 such as WinXP.


* jk/send-email-complete-aliases (2015-12-14) 1 commit
  (merged to 'next' on 2015-12-15 at 6978ff4)
 + completion: fix completing unstuck email alias arguments

 A fix-up for a recent topic.


* ls/p4-keep-empty-commits (2015-12-10) 1 commit
  (merged to 'next' on 2015-12-11 at 1827062)
 + git-p4: add option to keep empty commits

 "git p4" used to import Perforce CLs that touch only paths outside
 the client spec as empty commits.  It has been corrected to ignore
 them instead, with a new configuration git-p4.keepEmptyCommits as a
 backward compatibility knob.

--------------------------------------------------
[Stalled]

* kf/http-proxy-auth-methods (2015-11-04) 3 commits
 . SQUASH???
 . http: use credential API to handle proxy authentication
 . http: allow selection of proxy authentication method

 New http.proxyAuthMethod configuration variable can be used to
 specify what authentication method to use, as a way to work around
 proxies that do not give error response expected by libcurl when
 CURLAUTH_ANY is used.  Also, the codepath for proxy authentication
 has been taught to use credential API to store the authentication
 material in user's keyrings.

 I ejected this from pu for the moment, as it conflicts with the
 pt/http-socks-proxy topic. That is now in master, so it can
 be re-rolled on top.

 Anybody wants to help rerolling this?  Otherwise will discard. 


* nd/ita-cleanup (2015-09-06) 6 commits
 - grep: make it clear i-t-a entries are ignored
 - checkout(-index): do not checkout i-t-a entries
 - apply: make sure check_preimage() does not leave empty file on error
 - apply: fix adding new files on i-t-a entries
 - add and use a convenience macro ce_intent_to_add()
 - blame: remove obsolete comment

 Paths that have been told the index about with "add -N" are not yet
 in the index, but various commands behaved as if they already are.

 Some commits need better explanation.
 Becoming tired of waiting for a reroll.
 Will discard.


* mg/httpd-tests-update-for-apache-2.4 (2015-04-08) 2 commits
 - t/lib-git-svn: check same httpd module dirs as lib-httpd
 - t/lib-httpd: load mod_unixd

 This is the first two commits in a three-patch series $gmane/266962

 Becoming tired of waiting for a reroll.
 with updated log message ($gmane/268061).
 Will discard.


* wp/sha1-name-negative-match (2015-06-08) 2 commits
 - sha1_name.c: introduce '^{/!-<negative pattern>}' notation
 - test for '!' handling in rev-parse's named commits

 Introduce "branch^{/!-<pattern>}" notation to name a commit
 reachable from branch that does not match the given pattern.

 Becoming tired of waiting for a reroll.
 ($gmane/271213).
 Anybody wants to help rerolling this?  Otherwise will discard. 


* ak/format-patch-odir-config (2015-06-19) 1 commit
 - format-patch: introduce format.outputDirectory configuration

 Becoming tired of waiting for a reroll.
 Anybody wants to help rerolling this?  Otherwise will discard. 
 ($gmane/272180).


* jc/diff-b-m (2015-02-23) 5 commits
 . WIPWIP
 . WIP: diff-b-m
 - diffcore-rename: allow easier debugging
 - diffcore-rename.c: add locate_rename_src()
 - diffcore-break: allow debugging

 "git diff -B -M" produced incorrect patch when the postimage of a
 completely rewritten file is similar to the preimage of a removed
 file; such a resulting file must not be expressed as a rename from
 other place.

 The fix in this patch is broken, unfortunately.
 Will discard.

--------------------------------------------------
[Cooking]

* vl/grep-configurable-threads (2015-12-15) 3 commits
 - grep: add --threads=<num> option and grep.threads configuration
 - grep: slight refactoring to the code that disables threading
 - grep: allow threading even on a single-core machine

 "git grep" can now be configured (or told from the command line)
 how many threads to use when searching in the working tree files.

 Needs review.


* fr/rebase-i-continue-preserve-options (2015-12-11) 1 commit
  (merged to 'next' on 2015-12-15 at e99677a)
 + rebase -i: remember merge options beyond continue actions

 "git rebase -i" started with merge strategy options did not
 propagate them upon "git rebase --continue".

 Will merge to 'master'.


* jk/ident-loosen-getpwuid (2015-12-14) 3 commits
  (merged to 'next' on 2015-12-15 at 0c8137b)
 + ident: loosen getpwuid error in non-strict mode
 + ident: keep a flag for bogus default_email
 + ident: make xgetpwuid_self() a static local helper

 When getpwuid() on the system returned NULL (e.g. the user is not
 in the /etc/passwd file or other uid-to-name mappings), the
 codepath to find who the user is to record it in the reflog barfed
 and died.  Loosen the check in this codepath, which already accepts
 questionable ident string (e.g. host part of the e-mail address is
 obviously bogus), and in general when we operate fmt_ident() function
 in non-strict mode.

 Will merge to 'master'.


* sg/completion-no-column (2015-12-11) 1 commit
  (merged to 'next' on 2015-12-15 at 01a2476)
 + completion: remove 'git column' from porcelain commands

 The completion script (in contrib/) used to list "git column"
 (which is not an end-user facing command) as one of the choices

 Will merge to 'master'.


* ps/push-delete-option (2015-12-14) 2 commits
 - push: add '-d' as shorthand for '--delete'
 - push: add '--delete' flag to synopsis

 "branch --delete" has "branch -d" but "push --delete" does not.


* sh/p4-multi-depot (2015-12-14) 3 commits
 - git-p4: reduce number of server queries for fetches
 - git-p4: support multiple depot paths in p4 submit
 - git-p4: failing test case for skipping changes with multiple depots

 "git p4" when interacting with multiple depots at the same time
 used to incorrectly drop changes.

 Reported to be broken.
 ($gmane/282447)


* bc/format-patch-null-from-line (2015-12-15) 3 commits
 - format-patch: check that header line has expected format
 - format-patch: add an option to suppress commit hash
 - sha1_file.c: introduce a null_oid constant

 "format-patch" has learned a new option to zero-out the commit
 object name on the mbox "From " line.

 Will merge to 'next'.


* dt/refs-backend-lmdb (2015-12-04) 16 commits
 - refs: tests for lmdb backend
 - refs: add LMDB refs backend
 - refs: allow ref backend to be set for clone
 - init: allow alternate backends to be set for new repos
 - refs: always handle non-normal refs in files backend
 - refs: move duplicate check to common code
 - refs: make lock generic
 - refs: add method to rename refs
 - refs: add methods to init refs backend and db
 - refs: add method for delete_refs
 - refs: add method for initial ref transaction commit
 - refs: add methods for reflog
 - refs: add do_for_each_per_worktree_ref
 - refs: add methods for the ref iterators
 - refs: add methods for misc ref operations
 - refs: add a backend method structure with transaction functions

 Building on top of a few refs-backend preparatory series, LMDB
 based refs backend has been plugged into the system.

 Waiting for review.


* dw/subtree-split-do-not-drop-merge (2015-12-10) 1 commit
 - contrib/subtree: fix "subtree split" skipped-merge bug

 The "split" subcommand of "git subtree" (in contrib/) incorrectly
 skipped merges when it shouldn't, which was corrected.

 Waiting for review from 'subtree' folks.


* nd/clear-gitenv-upon-use-of-alias (2015-12-07) 3 commits
 . git.c: make sure we do not leak GIT_* to alias scripts
 - setup.c: re-fix d95138e (setup: set env $GIT_WORK_TREE when ..
 - git.c: make it clear save_env() is for alias handling only

 d95138e6 (setup: set env $GIT_WORK_TREE when work tree is set, like
 $GIT_DIR, 2015-06-26) attempted to work around a glitch in alias
 handling by overwriting GIT_WORK_TREE environment variable to
 affect subprocesses when set_git_work_tree() gets called, which
 resulted in a rather unpleasant regression to "clone" and "init".
 Try to address the same issue by always restoring the environment
 and respawning the real underlying command when handling alias.

 The tip one seems to break tests under "prove".

 Waiting for review.


* kn/ref-filter-atom-parsing (2015-12-11) 10 commits
 - ref-filter: introduce objectname_atom_parser()
 - ref-filter: introduce contents_atom_parser()
 - ref-filter: introduce remote_ref_atom_parser()
 - ref-filter: introduce align_atom_parser()
 - strbuf: introduce strbuf_split_str_without_term()
 - ref-filter: introduce color_atom_parser()
 - ref-filter: skip deref specifier in match_atom_name()
 - ref-filter: bump match_atom() name to the top
 - ref-filter: introduce struct used_atom
 - ref-filter: introduce a parsing function for each atom in valid_atom

 Refactoring of ref-filter's format-parsing code, in preparation
 for "branch --format" and friends.

 This replaces (for now) kn/for-each-ref-remainder, which will be built
 on top.

 Reviewed mostly by Eric.

 Waiting for a reroll.
 ($gmane/281180).


* bb/merge-marker-crlf (2015-11-24) 1 commit
 - merge-file: consider core.crlf when writing merge markers

 Write out merge markers using system end-of-line convention.

 Waiting for a re-roll to handle gitattributes.
 ($gmane/281701)


* dk/gc-more-wo-pack (2015-11-24) 3 commits
 - gc: Clean garbage .bitmap files from pack dir
 - t5304: Add test for .bitmap garbage files
 - prepare_packed_git(): find more garbage

 Follow-on to dk/gc-idx-wo-pack topic, to clean up stale
 .bitmap and .keep files.

 Waiting for review.


* jk/send-email-ssl-errors (2015-12-11) 1 commit
  (merged to 'next' on 2015-12-15 at 104f448)
 + send-email: enable SSL level 1 debug output

 Improve error reporting when SMTP TLS fails.

 Will merge to 'master'.


* ps/rebase-keep-empty (2015-11-24) 2 commits
 - rebase: fix preserving commits with --keep-empty
 - rebase: test broken behavior with --keep-empty

 Keep duplicate commits via rebase --keep-empty.

 Of dubious or negative value.
 Will discard.
 ($gmane/282107).


* rm/subtree-unwrap-tags (2015-11-24) 1 commit
 - contrib/subtree: unwrap tag refs

 Waiting for review from subtree folks.


* sg/sh-require-clean-orphan (2015-11-24) 2 commits
 - sh-setup: make require_clean_work_tree() work on orphan branches
 - Add tests for git-sh-setup's require_clean_work_tree()

 Allow users of git-sh-setup to handle orphan branch state.

 This series takes the conservative route of requiring scripts to opt
 into the looser behavior, at the expense of carrying around a new
 option-flag forever. I'm not sure if we need to do so.

 Needs review.


* tb/ls-files-eol (2015-11-28) 2 commits
 - convert.c: mark a file-local function static
 - ls-files: Add eol diagnostics

 Add options to ls-files to help diagnose end-of-line problems.

 This latest round hasn't gotten any review yet.

 Waiting for review.


* ec/annotate-deleted (2015-11-20) 1 commit
 - annotate: skip checking working tree if a revision is provided

 Usability fix for annotate-specific "<file> <rev>" syntax with deleted
 files.

 Waiting for review.


* mc/push-recurse-submodules-config (2015-12-04) 3 commits
  (merged to 'next' on 2015-12-08 at 1b81967)
 + push: follow the "last one wins" convention for --recurse-submodules
 + push: test that --recurse-submodules on command line overrides config
  (merged to 'next' on 2015-11-24 at 3644d4b)
 + push: add recurseSubmodules config option

 Add new config to avoid typing "--recurse-submodules" on each push.

 Waiting for review from submodule folks.


* sb/submodule-parallel-fetch (2015-12-14) 8 commits
 - submodules: allow parallel fetching, add tests and documentation
 - fetch_populated_submodules: use new parallel job processing
 - run-command: add an asynchronous parallel child processor
 - sigchain: add command to pop all common signals
 - strbuf: add strbuf_read_once to read without blocking
 - xread_nonblock: add functionality to read from fds without blocking
 - xread: poll on non blocking fds
 - submodule.c: write "Fetching submodule <foo>" to stderr
 (this branch is used by sb/submodule-parallel-update.)

 Add a framework to spawn a group of processes in parallel, and use
 it to run "git fetch --recurse-submodules" in parallel.

 Rerolled and this seems to be a lot cleaner.  The merge of the
 earlier one to 'next' has been reverted.

 Will merge to 'next' after a few days.

 
* sb/submodule-parallel-update (2015-12-14) 8 commits
 - clone: allow an explicit argument for parallel submodule clones
 - submodule update: expose parallelism to the user
 - git submodule update: have a dedicated helper for cloning
 - fetching submodules: respect `submodule.fetchJobs` config option
 - submodule-config: introduce parse_generic_submodule_config
 - submodule-config: remove name_and_item_from_var
 - submodule-config: drop check against NULL
 - submodule-config: keep update strategy around
 (this branch uses sb/submodule-parallel-fetch.)

 Builds on top of the "fetch --recurse-submodules" work to introduce
 parallel downloading into multiple submodules for "submodule update".

 Needs review.


* jc/strbuf-gets (2015-10-28) 17 commits
 - test-sha1-array: read command stream with strbuf_gets()
 - grep: read -f file with strbuf_gets()
 - send-pack: read list of refs with strbuf_gets()
 - column: read lines with strbuf_gets()
 - cat-file: read batch stream with strbuf_gets()
 - transport-helper: read helper response with strbuf_gets()
 - clone/sha1_file: read info/alternates with strbuf_gets()
 - remote.c: read $GIT_DIR/remotes/* with strbuf_gets()
 - ident.c: read /etc/mailname with strbuf_gets()
 - rev-parse: read parseopt spec with strbuf_gets()
 - revision: read --stdin with strbuf_gets()
 - hash-object: read --stdin-paths with strbuf_gets()
 - mktree: read textual tree representation with strbuf_gets()
 - update-index: read list of paths with strbuf_gets() under --stdin
 - update-index: read --index-info with strbuf_gets()
 - check-attr, check-ignore, checkout-index: read paths with strbuf_gets()
 - strbuf: add strbuf_gets()

 Teach codepaths that communicate with users by reading text files
 to be more lenient to editors that write CRLF-terminated lines.
 Note that this is only about communication with Git, like feeding
 list of object names from the standard input instead of from the
 command line, and does not involve files in the working tree.

 Waiting for review.


* mh/notes-allow-reading-treeish (2015-10-08) 3 commits
  (merged to 'next' on 2015-10-23 at 8a697f0)
 + notes: allow treeish expressions as notes ref
 + Merge branch 'jk/notes-dwim-doc' into next
 + Merge branch 'jc/merge-drop-old-syntax' into next
 (this branch uses jc/merge-drop-old-syntax.)

 Some "git notes" operations, e.g. "git log --notes=<note>", should
 be able to read notes from any tree-ish that is shaped like a notes
 tree, but the notes infrastructure required that the argument must
 be a ref under refs/notes/.  Loosen it to require a valid ref only
 when the operation would update the notes (in which case we must
 have a place to store the updated notes tree, iow, a ref).

 As the patch was done on top of the 'drop old-syntax from merge',
 this has to wait until that other topic can graduate, unfortunately.
 It can be redone in a way that does not depend on that topic after
 this cycle, though.

 Will keep in 'next'.


* jc/mailinfo (2015-10-21) 1 commit
 - mailinfo: ignore in-body header that we do not care about

 Some people write arbitrary garbage at the beginning of a piece of
 e-mail (or after -- >8 -- scissors -- >8 -- line) in the commit log
 message and expect them to be discarded, even though "From:" and
 "Subject:" are the only documented in-body headers that you are
 supposed to have there.  Allow some garbage (specifically, what may
 look like RFC2822 headers like "MIME-Version: ...") to be there and
 ignore them.

 No comments after waiting for a long time.
 Will discard.


* js/am-3-merge-recursive-direct (2015-10-12) 2 commits
  (merged to 'next' on 2015-10-23 at dc631e5)
 + am: make a direct call to merge_recursive
 + merge_recursive_options: introduce the "gently" flag

 The merge_recursive_generic() function has been made a bit safer to
 call from inside a process.  "git am -3" was taught to make a direct
 call to the function when falling back to three-way merge.

 Being able to make a direct call would be good in general, but as a
 performance thing, we would want to see it backed up by numbers.

 I haven't gone through the "gently" change with fine toothed comb;
 I can see that the change avoids calling die(), but I haven't made
 sure that the program states (e.g. what's in the in-core index) are
 adjusted sensibly when it returns to the caller instead of dying,
 or the codepaths that used to die() are free of resource leaks.
 The original code certainly did not care the program states at the
 point of dying exactly because it knew it is going to exit, but now
 they have to care, and they need to be audited.

 Will keep in 'next'.


* sg/pretty-more-date-mode-format (2015-10-07) 1 commit
 - pretty: add format specifiers for short and raw date formats

 Introduce "%as" and "%aR" placeholders for "log --format" to show
 the author date in the short and raw formats.

 No comments after waiting for a long time.
 Will discard.


* jk/graph-format-padding (2015-09-14) 1 commit
 - pretty: pass graph width to pretty formatting for use in '%>|(N)'

 Redefine the way '%>|(N)' padding and the "--graph" option
 interacts.  It has been that the available columns to display the
 log message was measured from the edge of the area the graph ended,
 but with this it becomes the beginning of the entire output.

 I have a suspicion that 50% of the users would appreciate this
 change, and the remainder see this break their expectation.  If
 that is the case, we might need to introduce a similar but
 different alignment operator so that this new behaviour is
 available to those who want to use it, without negatively affecting
 existing uses.

 No comments after waiting for a long time.
 Will discard.
 ($gmane/278326)


* ad/cygwin-wants-rename (2015-08-07) 1 commit
 - config.mak.uname: Cygwin needs OBJECT_CREATION_USES_RENAMES

 Will hold.
 ($gmane/275680).


* jc/rerere-multi (2015-09-14) 7 commits
 - rerere: do use multiple variants
 - t4200: rerere a merge with two identical conflicts
 - rerere: allow multiple variants to exist
 - rerere: delay the recording of preimage
 - rerere: handle leftover rr-cache/$ID directory and postimage files
 - rerere: scan $GIT_DIR/rr-cache/$ID when instantiating a rerere_id
 - rerere: split conflict ID further

 "git rerere" can encounter two or more files with the same conflict
 signature that have to be resolved in different ways, but there was
 no way to record these separate resolutions.

 Needs review.


* jc/merge-drop-old-syntax (2015-04-29) 1 commit
  (merged to 'next' on 2015-10-07 at 50fed71)
 + merge: drop 'git merge <message> HEAD <commit>' syntax
 (this branch is used by mh/notes-allow-reading-treeish.)

 Originally merged to 'next' on 2015-05-28

 Stop supporting "git merge <message> HEAD <commit>" syntax that has
 been deprecated since October 2007.  It has been reported that
 git-gui still uses the deprecated syntax, which needs to be fixed
 before this final step can proceed.

 Will keep in 'next'.

--------------------------------------------------
[Discarded]

* kn/for-each-branch-remainder (2015-10-02) 9 commits
 . branch: implement '--format' option
 . branch: use ref-filter printing APIs
 . ref-filter: make %(upstream:track) prints "[gone]" for invalid upstreams
 . ref-filter: introduce format_ref_array_item()
 . ref-filter: adopt get_head_description() from branch.c
 . ref-filter: modify "%(objectname:short)" to take length
 . ref-filter: add support for %(path) atom
 . ref-filter: implement %(if:equals=<string>) and %(if:notequals=<string>)
 . ref-filter: implement %(if), %(then), and %(else) atoms

 More unification among "branch -l", "tag -l" and "for-each-ref --format".

 Ejected from pu for now, as a re-roll should come on top of
 kn/ref-filter-atom-parsing.

 Expecting a reroll.
 ($gmane/278926)
