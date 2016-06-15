From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jul 2015, #05; Mon, 20)
Date: Mon, 20 Jul 2015 16:18:26 -0700
Message-ID: <xmqqwpxuwh8d.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 21 01:18:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHKKR-0004kd-95
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 01:18:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756862AbbGTXSa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2015 19:18:30 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33127 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753115AbbGTXS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2015 19:18:28 -0400
Received: by padck2 with SMTP id ck2so107854777pad.0
        for <git@vger.kernel.org>; Mon, 20 Jul 2015 16:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version
         :content-type;
        bh=Te9C5GKMmV7PlY+UHwvQIIKj+5OOu373HbBtjCU2bec=;
        b=MAtlMf4SENJduKlHWJASyG7YbrbzqBwxTuRNhYpmxVjRBlGLG1DnLjxPbDqYCF0Zj7
         2/js6qEYLrgfWieVzlzlZN+mgqLlatrUDUnzEUHJUTRVhh9VJF3MRfutS0oo8/drqZUS
         nrCnTr+a0jR28WiZkoit+7T5Qnu0GA8FsCu7T/uRfoDO+uPZuHg25+gYmow07lj1QRUF
         r8Ht6jw8CgbcIcmjKaRBzQj/sGNywHTOiJ8DM9IQy2Jpm2ZyU5c4HTocauQanEuqnpRx
         zVXEh7Nn7tX2QeueJyh/zp5Zj3nhMJ0r3i/Pjg6JuRyQF0J+xHpXHcfmYzuM5wFE30yh
         WksQ==
X-Received: by 10.70.38.231 with SMTP id j7mr66730378pdk.146.1437434307962;
        Mon, 20 Jul 2015 16:18:27 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:d4dc:19bb:f338:713b])
        by smtp.gmail.com with ESMTPSA id xo14sm14917805pac.24.2015.07.20.16.18.27
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 20 Jul 2015 16:18:27 -0700 (PDT)
X-master-at: fbdeabf1f0992e41237caee8fc357849e0038a82
X-next-at: 76e840bed084a99e9de166e429c25bc0b2d6a698
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274362>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* zb/userdiff-fountain (2015-07-17) 1 commit
 - userdiff: add support for Fountain documents

 New userdiff pattern definition for fountain screenwriting markup
 format.

 Needs another reroll? ($gmane/274354)


* as/sparse-checkout-removal (2015-07-17) 1 commit
 - unpack-trees: don't update files with CE_WT_REMOVE set

 Duy's replacement needs to be applied ($gmane/274158).


* cb/uname-in-untracked (2015-07-17) 1 commit
 - untracked: fix detection of uname(2) failure

 An experimental "untracked cache" feature used to use uname(2) in a
 slightly unportable way.

 Will merge to 'next'.


* jc/rerere-multi (2015-07-20) 5 commits
 - t4200: rerere a merge with two identical conflicts
 - rerere: delay the recording of preimage for the first time
 - rerere: handle leftover rr-cache/$ID directory and postimage files
 - rerere: scan $GIT_DIR/rr-cache/$ID when instantiating a rerere_id
 - rerere: split conflict ID further
 (this branch uses jc/rerere.)

 This is a contination of jc/rerere topic.


* bw/portability-solaris (2015-07-20) 3 commits
 - tests: fix sed usage in tests to work around broken xpg4/sed on Solaris
 - tests: fix sed usage in tests to work around broken xpg4/sed on Solaris
 - tests: modify tr expressions so that xpg4/tr handles it on Solaris

 Needs another reroll? ($gmane/274296)


* es/worktree-add (2015-07-20) 5 commits
  (merged to 'next' on 2015-07-20 at 76e840b)
 + config: rename "gc.pruneWorktreesExpire" to "gc.worktreePruneExpire"
 + Documentation/git-worktree: wordsmith worktree-related manpages
 + Documentation/config: fix stale "git prune --worktree" reference
 + Documentation/git-worktree: fix incorrect reference to file "locked"
 + Documentation/git-worktree: consistently use term "linked working tree"
 (this branch is used by es/worktree-add-cleanup.)

 Will merge to 'master'.


* sg/bash-prompt-untracked-optim (2015-07-20) 2 commits
 - bash prompt: faster untracked status indicator with untracked directories
 - bash prompt: test untracked files status indicator with untracked dirs

 Will merge to 'next'.

--------------------------------------------------
[Graduated to "master"]

* jc/diff-ws-error-highlight (2015-07-12) 1 commit
  (merged to 'next' on 2015-07-12 at 15b60ce)
 + diff: parse ws-error-highlight option more strictly

 A hotfix to a new feature in 2.5.0-rc.


* jk/still-interesting (2015-06-29) 1 commit
  (merged to 'next' on 2015-07-09 at e19fc0e)
 + revision.c: remove unneeded check for NULL

 Code clean-up.

 Will merge to 'master'.

--------------------------------------------------
[Stalled]

* sg/config-name-only (2015-05-28) 3 commits
 - completion: use new 'git config' options to reliably list variable names
 - SQUASH
 - config: add options to list only variable names

 "git config --list" output was hard to parse when values consist of
 multiple lines.  Introduce a way to show only the keys.

 Adding a single --name-only option may be a better way to go than
 adding two new options.

 Expecting a reroll.


* kk/log-merges-config (2015-04-21) 5 commits
 - bash-completion: add support for git-log --merges= and log.merges
 - t4202-log: add tests for --merges=
 - Documentation: add git-log --merges= option and log.merges config. var
 - log: honor log.merges= option
 - revision: add --merges={show|only|hide} option

 "git log" (but not other commands in the "log" family) learned to
 pay attention to the log.merges configuration variable that can be
 set to "show" (the normal behaviour), "only" (hide non-merge
 commits), or "hide" (hide merge commits).  --merges=(show|only|hide)
 can be used to override the setting from the command line.

 The documentation may need to be updated once more ($gmane/267250).
 Waiting for a reroll.


* mg/httpd-tests-update-for-apache-2.4 (2015-04-08) 2 commits
 - t/lib-git-svn: check same httpd module dirs as lib-httpd
 - t/lib-httpd: load mod_unixd

 This is the first two commits in a three-patch series $gmane/266962
 Will be rerolled.
 with updated log message ($gmane/268061).


* mh/numparse (2015-03-19) 14 commits
 - diff_opt_parse(): use convert_i() when handling --abbrev=<num>
 - diff_opt_parse(): use convert_i() when handling "-l<num>"
 - opt_arg(): simplify pointer handling
 - opt_arg(): report errors parsing option values
 - opt_arg(): use convert_i() in implementation
 - opt_arg(): val is always non-NULL
 - builtin_diff(): detect errors when parsing --unified argument
 - handle_revision_opt(): use convert_ui() when handling "--abbrev="
 - strtoul_ui(), strtol_i(): remove functions
 - handle_revision_opt(): use convert_i() when handling "-<digit>"
 - handle_revision_opt(): use skip_prefix() in many places
 - write_subdirectory(): use convert_ui() for parsing mode
 - cacheinfo_callback(): use convert_ui() when handling "--cacheinfo"
 - numparse: new module for parsing integral numbers

 Many codepaths use unchecked use of strtol() and friends (or even
 worse, atoi()).  Introduce a set of wrappers that try to be more
 careful.

 Expecting a reroll.
 ($gmane/268058).


* tf/gitweb-project-listing (2015-03-19) 5 commits
 - gitweb: make category headings into links when they are directories
 - gitweb: optionally set project category from its pathname
 - gitweb: add a link under the search box to clear a project filter
 - gitweb: if the PATH_INFO is incomplete, use it as a project_filter
 - gitweb: fix typo in man page

 Update gitweb to make it more pleasant to deal with a hierarchical
 forest of repositories.

 Any comments from those who use or have their own code in Gitweb?


* jc/a-lone-dash-stands-for-previous-branch (2015-03-16) 1 commit
 - "-" and "@{-1}" on various programs

 Lose special case code to make a lone dash "-" mean the previous
 branch aka "@{-1}" from a handful subcommands, and instead support
 the notation throughout the system by reimplementing it at the
 revisions layer.

 Needs tests, documentation updates, etc.  Also does only a half-way
 job dealing with range notation, which needs to be fixed before the
 series goes anywhere.


* nd/list-files (2015-02-09) 21 commits
 - t3080: tests for git-list-files
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
 - list-files: make alias 'ls' default to 'list-files'
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

 Reroll to base on wt-status work ($gmane/265142) has seen some
 positive discussions.

 Waiting for a further polished reroll ($gmane/265534).


* nd/pathspec-strip-fix (2015-04-18) 1 commit
 - pathspec: adjust prefixlen after striping trailing slash

 Does not quite fix ($gmane/267614).
 Will discard.


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


* pw/remote-set-url-fetch (2014-11-26) 1 commit
 - remote: add --fetch and --both options to set-url

 Expecting a reroll.


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

 Waiting for a reroll.
 ($gmane/256591).


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

 Waiting for the final step to lift the hard-limit.

--------------------------------------------------
[Cooking]

* es/worktree-add-cleanup (2015-07-20) 22 commits
 - checkout: drop intimate knowledge of newly created worktree
 - worktree: populate via "git reset --hard" rather than "git checkout"
 - worktree: avoid resolving HEAD unnecessarily
 - worktree: make setup of new HEAD distinct from worktree population
 - worktree: detect branch-name/detached and error conditions locally
 - worktree: add_worktree: construct worktree-population command locally
 - worktree: elucidate environment variables intended for child processes
 - worktree: make branch creation distinct from worktree population
 - worktree: add: suppress auto-vivication with --detach and no <branch>
 - worktree: make --detach mutually exclusive with -b/-B
 - worktree: introduce options container
 - worktree: simplify new branch (-b/-B) option checking
 - worktree: improve worktree setup message
 - branch: publish die_if_checked_out()
 - checkout: teach check_linked_checkout() about symbolic link HEAD
 - checkout: check_linked_checkout: simplify symref parsing
 - checkout: check_linked_checkout: improve "already checked out" aesthetic
 - checkout: generalize die_if_checked_out() branch name argument
 - checkout: die_if_checked_out: simplify strbuf management
 - checkout: improve die_if_checked_out() robustness
 - checkout: name check_linked_checkouts() more meaningfully
 - checkout: avoid resolving HEAD unnecessarily
 (this branch uses es/worktree-add.)

 Remove the "new-worktree-mode" hack in "checkout" that was added in
 nd/multiple-work-trees topic by updating the implementation of new
 "worktree add".

 Will merge to 'next'.


* ib/scripted-parse-opt-better-hint-string (2015-07-15) 1 commit
  (merged to 'next' on 2015-07-17 at 7bb1674)
 + rev-parse --parseopt: allow [*=?!] in argument hints

 The "rev-parse --parseopt" mode parsed the option specification
 and the argument hint in a strange way to allow '=' and other
 special characters in the option name while forbidding them from
 the argument hint.  This made it impossible to define an option
 like "--pair <key>=<value>" with "pair=key=value" specification,
 which instead would have defined a "--pair=key <value>" option.

 Will merge to 'master'.


* mh/fast-import-optimize-current-from (2015-07-13) 1 commit
  (merged to 'next' on 2015-07-15 at 2be8b1f)
 + fast-import: do less work when given "from" matches current branch head

 Often a fast-import stream builds a new commit on top of the
 previous commit it built, and it often unconditionally emits a
 "from" command to specify the first parent, which can be omitted in
 such a case.  This caused fast-import to forget the tree of the
 previous commit and then re-read it from scratch, which was
 inefficient.  Optimize for this common case.

 Will merge to 'master'.


* mh/notes-allow-reading-treeish (2015-07-13) 1 commit
 - notes: allow treeish expressions as notes ref

 Some "git notes" operations, e.g. "git log --notes=<note>", should
 be able to read notes from any tree-ish that is shaped like a notes
 tree, but the notes infrastructure required that the argument must
 be a ref under refs/notes/.  Loosen it to require a valid ref only
 when the operation would update the notes (in which case we must
 have a place to store the updated notes tree, iow, a ref).

 Needs update to docs.


* dt/log-follow-config (2015-07-09) 1 commit
  (merged to 'next' on 2015-07-10 at b8fbb43)
 + log: add "log.follow" configuration variable

 Add a new configuration variable to enable "--follow" automatically
 when "git log" is run with one pathspec argument.

 Will merge to 'master'.


* kn/tag-doc-fix (2015-07-10) 1 commit
  (merged to 'next' on 2015-07-15 at 7bd6038)
 + Documentation/tag: remove double occurance of "<pattern>"

 Will merge to 'master'.


* se/doc-checkout-ours-theirs (2015-07-12) 1 commit
 - checkout: document subtlety around --ours/--theirs

 A "rebase" replays changes of the local branch on top of something
 else, as such they are placed in stage #3 and referred to as
 "theirs", while the changes in the new base, typically a foreign
 work, are placed in stage #2 and referred to as "ours".  Clarify
 the "checkout --ours/--theirs".


* pt/am-tests (2015-07-20) 12 commits
 - t3901: test git-am encoding conversion
 - t3418: non-interactive rebase --continue with rerere enabled
 - t4150: tests for am --[no-]scissors
 - t4150: am with post-applypatch hook
 - t4150: am with pre-applypatch hook
 - t4150: am with applypatch-msg hook
 - t4150: am --resolved fails if index has unmerged entries
 - t4150: am --resolved fails if index has no changes
 - t4150: am refuses patches when paused
 - t4151: am --abort will keep dirty index intact
 - t4150: am fails if index is dirty
 - t4150: am.messageid really adds the message id

 Will merge to 'next'.


* kn/for-each-tag-branch (2015-07-13) 11 commits
  (merged to 'next' on 2015-07-15 at bf5418f)
 + for-each-ref: add '--contains' option
 + ref-filter: implement '--contains' option
 + parse-options.h: add macros for '--contains' option
 + parse-option: rename parse_opt_with_commit()
 + for-each-ref: add '--merged' and '--no-merged' options
 + ref-filter: implement '--merged' and '--no-merged' options
 + ref-filter: add parse_opt_merge_filter()
 + for-each-ref: add '--points-at' option
 + ref-filter: implement '--points-at' option
 + tag: libify parse_opt_points_at()
 + t6302: for-each-ref tests for ref-filter APIs
 (this branch uses kn/for-each-ref.)

 Port features over from tag -l and branch -l to for-each-ref
 so that eventually the unified implementation can be used to
 reimplement tag -l and branch -l, shared across all three, in
 a follow-up series or two.

 Will merge to 'master'.


* pt/am-builtin (2015-07-20) 46 commits
 - builtin-am: remove redirection to git-am.sh
 - builtin-am: check for valid committer ident
 - builtin-am: implement legacy -b/--binary option
 - builtin-am: implement -i/--interactive
 - builtin-am: support and auto-detect mercurial patches
 - builtin-am: support and auto-detect StGit series files
 - builtin-am: support and auto-detect StGit patches
 - builtin-am: rerere support
 - builtin-am: invoke post-applypatch hook
 - builtin-am: invoke pre-applypatch hook
 - builtin-am: invoke applypatch-msg hook
 - builtin-am: support automatic notes copying
 - builtin-am: invoke post-rewrite hook
 - builtin-am: implement -S/--gpg-sign, commit.gpgsign
 - builtin-am: implement --committer-date-is-author-date
 - builtin-am: implement --ignore-date
 - builtin-am: pass git-apply's options to git-apply
 - builtin-am: implement --[no-]scissors
 - builtin-am: support --keep-cr, am.keepcr
 - builtin-am: implement --[no-]message-id, am.messageid
 - builtin-am: implement -k/--keep, --keep-non-patch
 - builtin-am: implement -u/--utf8
 - builtin-am: handle stray state directory
 - builtin-am: bypass git-mailinfo when --rebasing
 - builtin-am: implement --rebasing mode
 - builtin-am: implement --3way, am.threeWay
 - cache-tree: introduce write_index_as_tree()
 - builtin-am: implement -s/--signoff
 - builtin-am: exit with user friendly message on failure
 - builtin-am: implement -q/--quiet
 - builtin-am: reject patches when there's a session in progress
 - builtin-am: implement --abort
 - builtin-am: implement --skip
 - builtin-am: don't parse mail when resuming
 - builtin-am: implement --resolved/--continue
 - builtin-am: refuse to apply patches if index is dirty
 - builtin-am: implement committing applied patch
 - builtin-am: apply patch with git-apply
 - builtin-am: extract patch and commit info with git-mailinfo
 - builtin-am: auto-detect mbox patches
 - builtin-am: split out mbox/maildir patches with git-mailsplit
 - builtin-am: implement patch queue mechanism
 - builtin-am: implement skeletal builtin am
 - wrapper: implement xfopen()
 - wrapper: implement xopen()
 - Merge branch 'pt/pull-builtin' into pt/am-builtin
 (this branch uses pt/pull-builtin.)

 Rewrite "am" in "C".


* ad/bisect-cleanup (2015-06-29) 6 commits
  (merged to 'next' on 2015-07-09 at 75e2a06)
 + bisect: don't mix option parsing and non-trivial code
 + bisect: simplify the addition of new bisect terms
 + bisect: replace hardcoded "bad|good" by variables
 + Documentation/bisect: revise overall content
 + Documentation/bisect: move getting help section to the end
 + bisect: correction of typo
 (this branch is used by ad/bisect-terms.)

 Code and documentation clean-up to "git bisect".

 Will merge to 'master'.


* mh/fast-import-get-mark (2015-07-01) 1 commit
  (merged to 'next' on 2015-07-15 at 5e034b9)
 + fast-import: add a get-mark command

 Will merge to 'master'.


* kb/i18n-doc (2015-07-01) 1 commit
  (merged to 'next' on 2015-07-09 at a12c7b3)
 + Documentation/i18n.txt: clarify character encoding support

 Will merge to 'master'.


* dt/refs-backend-preamble (2015-07-13) 7 commits
 - git-stash: use update-ref --create-reflog instead of creating files
 - update-ref and tag: add --create-reflog arg
 - refs: add REF_FORCE_CREATE_REFLOG flag
 - git-reflog: add exists command
 - refs: new public ref function: safe_create_reflog
 - refs: Break out check for reflog autocreation
 - refs.c: add err arguments to reflog functions

 In preparation for allowing different "backends" to store the refs
 in a way different from the traditional "one ref per file in $GIT_DIR
 or in a $GIT_DIR/packed-refs file" filesystem storage, reduce
 direct filesystem access to ref-like things like CHERRY_PICK_HEAD
 from scripts and programs.

 Still under discussion.

 Will hold.


* jk/date-mode-format (2015-06-29) 3 commits
  (merged to 'next' on 2015-07-09 at a01bfc3)
 + introduce "format" date-mode
 + convert "enum date_mode" into a struct
 + show-branch: use DATE_RELATIVE instead of magic number

 Teach "git log" and friends a new "--date=format:..." option to
 format timestamps using system's strftime(3).

 Will merge to 'master'.


* nd/export-worktree (2015-06-26) 1 commit
  (merged to 'next' on 2015-07-09 at 1581a9b)
 + setup: set env $GIT_WORK_TREE when work tree is set, like $GIT_DIR

 Running an aliased command from a subdirectory when the .git thing
 in the working tree is a gitfile pointing elsewhere did not work.

 Will merge to 'master'.


* jc/rerere (2015-07-18) 18 commits
 - rerere: un-nest merge() further
 - rerere: use "struct rerere_id" instead of "char *" for conflict ID
 - rerere: call conflict-ids IDs
 - rerere: further clarify do_rerere_one_path()
 - rerere: further de-dent do_plain_rerere()
 - rerere: refactor "replay" part of do_plain_rerere()
 - rerere: explain the remainder
 - rerere: explain "rerere forget" codepath
 - rerere: explain the primary codepath
 - rerere: explain MERGE_RR management helpers
 - rerere: explain the rerere I/O abstraction
 - rerere: stop looping unnecessarily
 - rerere: drop want_sp parameter from is_cmarker()
 - rerere: report autoupdated paths only after actually updating them
 - rerere: write out each record of MERGE_RR in one go
 - rerere: lift PATH_MAX limitation
 - rerere: plug conflict ID leaks
 - rerere: fix an off-by-one non-bug
 (this branch is used by jc/rerere-multi.)

 Code clean-up and minor fixes (so far).


* ad/bisect-terms (2015-06-29) 4 commits
 - bisect: allow setting any user-specified in 'git bisect start'
 - bisect: add 'git bisect terms' to view the current terms
 - bisect: add the terms old/new
 - bisect: sanity check on terms
 (this branch uses ad/bisect-cleanup.)

 The use of 'good/bad' in "git bisect" made it confusing to use when
 hunting for a state change that is not a regression (e.g. bugfix).
 The command learned 'old/new' and then allows the end user to
 say e.g. "bisect start --term-old=fast --term=new=slow" to find a
 performance regression.

 Michael's idea to make 'good/bad' more intelligent does have
 certain attractiveness ($gname/272867), and makes some of the work
 on this topic a moot point.

 Will hold.


* mh/tempfile (2015-06-10) 14 commits
 - credential-cache--daemon: use tempfile module
 - credential-cache--daemon: delete socket from main()
 - gc: use tempfile module to handle gc.pid file
 - lock_repo_for_gc(): compute the path to "gc.pid" only once
 - diff: use tempfile module
 - setup_temporary_shallow(): use tempfile module
 - write_shared_index(): use tempfile module
 - register_tempfile(): new function to handle an existing temporary file
 - tempfile: add several functions for creating temporary files
 - register_tempfile_object(): new function, extracted from create_tempfile()
 - commit_lock_file(): use get_locked_file_path()
 - lockfile: remove some redundant functions
 - tempfile: a new module for handling temporary files
 - Move lockfile API documentation to lockfile.h

 Rebuild "lockfile" API on top of a new "tempfile" API.
 This needs rerolling, to include "tempfile.h" in "lockfile.h", at
 least.

 Expecting a reroll.
 ($gmane/271353)


* js/fsck-opt (2015-06-23) 19 commits
  (merged to 'next' on 2015-07-10 at eb4da0a)
 + fsck: support ignoring objects in `git fsck` via fsck.skiplist
 + fsck: git receive-pack: support excluding objects from fsck'ing
 + fsck: introduce `git fsck --connectivity-only`
 + fsck: support demoting errors to warnings
 + fsck: document the new receive.fsck.<msg-id> options
 + fsck: allow upgrading fsck warnings to errors
 + fsck: optionally ignore specific fsck issues completely
 + fsck: disallow demoting grave fsck errors to warnings
 + fsck: add a simple test for receive.fsck.<msg-id>
 + fsck: make fsck_tag() warn-friendly
 + fsck: handle multiple authors in commits specially
 + fsck: make fsck_commit() warn-friendly
 + fsck: make fsck_ident() warn-friendly
 + fsck: report the ID of the error/warning
 + fsck (receive-pack): allow demoting errors to warnings
 + fsck: offer a function to demote fsck errors to warnings
 + fsck: provide a function to parse fsck message IDs
 + fsck: introduce identifiers for fsck messages
 + fsck: introduce fsck options

 Allow ignoring fsck errors on specific set of known-to-be-bad
 objects, and also tweaking warning level of various kinds of non
 critical breakages reported.

 Will merge to 'master'.


* ak/format-patch-odir-config (2015-06-19) 1 commit
 - format-patch: introduce format.outputDirectory configuration

 Reroll exists but didn't pick it up as it seems to be still
 collecting review comments.

 Expecting a reroll.
 ($gmane/272180).


* bc/gpg-verify-raw (2015-06-22) 7 commits
  (merged to 'next' on 2015-06-24 at 08a1164)
 + verify-tag: add option to print raw gpg status information
 + verify-commit: add option to print raw gpg status information
 + gpg: centralize printing signature buffers
 + gpg: centralize signature check
 + verify-commit: add test for exit status on untrusted signature
 + verify-tag: share code with verify-commit
 + verify-tag: add tests

 "git verify-tag" and "git verify-commit" have been taught to share
 more code, and then learned to optionally show the verification
 message from the underlying GPG implementation.

 Will merge to 'master'.


* cb/parse-magnitude (2015-06-22) 2 commits
  (merged to 'next' on 2015-06-24 at 2fd7205)
 + parse-options: move unsigned long option parsing out of pack-objects.c
 + test-parse-options: update to handle negative ints

 Move machinery to parse human-readable scaled numbers like 1k, 4M,
 and 2G as an option parameter's value from pack-objects to
 parse-options API, to make it available to other codepaths.

 Will merge to 'master'.


* jk/cat-file-batch-all (2015-06-26) 8 commits
  (merged to 'next' on 2015-07-10 at 80200cc)
 + cat-file: sort and de-dup output of --batch-all-objects
 + cat-file: add --batch-all-objects option
 + cat-file: split batch_one_object into two stages
 + cat-file: stop returning value from batch_one_object
 + cat-file: add --buffer option
 + cat-file: move batch_options definition to top of file
 + cat-file: minor style fix in options list
 + Merge branch 'jk/maint-for-each-packed-object' into jk/cat-file-batch-all

 "cat-file" learned "--batch-all-objects" option to enumerate all
 available objects in the repository more quickly than "rev-list
 --all --objects" (the output includes unreachable objects, though).

 Will merge to 'master'.


* jk/pkt-log-pack (2015-06-16) 3 commits
  (merged to 'next' on 2015-07-10 at ba33212)
 + pkt-line: support tracing verbatim pack contents
 + pkt-line: tighten sideband PACK check when tracing
 + pkt-line: simplify starts_with checks in packet tracing

 Enhance packet tracing machinery to allow capturing an incoming
 pack data to a file for debugging.

 Will merge to 'master'.


* kn/for-each-ref (2015-06-15) 11 commits
  (merged to 'next' on 2015-06-24 at 1a3a734)
 + ref-filter: make 'ref_array_item' use a FLEX_ARRAY for refname
 + for-each-ref: introduce filter_refs()
 + ref-filter: move code from 'for-each-ref'
 + ref-filter: add 'ref-filter.h'
 + for-each-ref: rename variables called sort to sorting
 + for-each-ref: rename some functions and make them public
 + for-each-ref: introduce 'ref_array_clear()'
 + for-each-ref: introduce new structures for better organisation
 + for-each-ref: rename 'refinfo' to 'ref_array_item'
 + for-each-ref: clean up code
 + for-each-ref: extract helper functions out of grab_single_ref()
 (this branch is used by kn/for-each-tag-branch.)

 GSoC project to rebuild ref listing by branch and tag based on the
 for-each-ref machinery.  This is its first part.

 Will merge to 'master'.


* mh/init-delete-refs-api (2015-06-22) 19 commits
  (merged to 'next' on 2015-07-10 at 121b26e)
 + delete_ref(): use the usual convention for old_sha1
 + cmd_update_ref(): make logic more straightforward
 + update_ref(): don't read old reference value before delete
 + check_branch_commit(): make first parameter const
 + refs.h: add some parameter names to function declarations
 + refs: move the remaining ref module declarations to refs.h
 + initial_ref_transaction_commit(): check for ref D/F conflicts
 + initial_ref_transaction_commit(): check for duplicate refs
 + refs: remove some functions from the module's public interface
 + initial_ref_transaction_commit(): function for initial ref creation
 + repack_without_refs(): make function private
 + prune_refs(): use delete_refs()
 + prune_remote(): use delete_refs()
 + delete_refs(): bail early if the packed-refs file cannot be rewritten
 + delete_refs(): make error message more generic
 + delete_refs(): new function for the refs API
 + delete_ref(): handle special case more explicitly
 + remove_branches(): remove temporary
 + delete_ref(): move declaration to refs.h

 Clean up refs API and make "git clone" less intimate with the
 implementation detail.

 Will merge to 'master'.


* mh/replace-refs (2015-06-12) 1 commit
  (merged to 'next' on 2015-06-24 at cb13adf)
 + Allow to control where the replace refs are looked for

 Add an environment variable to tell Git to look into refs hierarchy
 other than refs/replace/ for the object replacement data.

 Will merge to 'master'.


* gp/status-rebase-i-info (2015-07-06) 4 commits
  (merged to 'next' on 2015-07-10 at b121298)
 + status: add new tests for status during rebase -i
 + status: give more information during rebase -i
 + status: differentiate interactive from non-interactive rebases
 + status: factor two rebase-related messages together

 Teach "git status" to show a more detailed information regarding
 the "rebase -i" session in progress.

 Will merge to 'master'.


* mk/utf8-no-iconv-warn (2015-06-08) 1 commit
 - utf8.c: print warning about disabled iconv

 Warn when a reencoding is requested in a build without iconv
 support, as the end user is likely to get an unexpected result.  I
 think the same level of safety should be added to a build with
 iconv support when the specified encoding is not available, but the
 patch does not go there.

 Expecting a reroll.


* mr/rebase-i-customize-insn-sheet (2015-06-15) 1 commit
  (merged to 'next' on 2015-07-10 at ec383cd)
 + git-rebase--interactive.sh: add config option for custom instruction format

 "git rebase -i"'s list of todo is made configurable.

 Will merge to 'master'.


* pt/am-foreign (2015-06-15) 5 commits
  (merged to 'next' on 2015-06-24 at 838c702)
 + am: teach mercurial patch parser how to read from stdin
 + am: use gmtime() to parse mercurial patch date
 + t4150: test applying StGit series
 + am: teach StGit patch parser how to read from stdin
 + t4150: test applying StGit patch

 Various enhancements around "git am" reading patches generated by
 foreign SCM.

 Will merge to 'master'.


* pt/pull-builtin (2015-06-18) 19 commits
  (merged to 'next' on 2015-07-10 at 07b1794)
 + pull: remove redirection to git-pull.sh
 + pull --rebase: error on no merge candidate cases
 + pull --rebase: exit early when the working directory is dirty
 + pull: configure --rebase via branch.<name>.rebase or pull.rebase
 + pull: teach git pull about --rebase
 + pull: set reflog message
 + pull: implement pulling into an unborn branch
 + pull: fast-forward working tree if head is updated
 + pull: check if in unresolved merge state
 + pull: support pull.ff config
 + pull: error on no merge candidates
 + pull: pass git-fetch's options to git-fetch
 + pull: pass git-merge's options to git-merge
 + pull: pass verbosity, --progress flags to fetch and merge
 + pull: implement fetch + merge
 + pull: implement skeletal builtin pull
 + argv-array: implement argv_array_pushv()
 + parse-options-cb: implement parse_opt_passthru_argv()
 + parse-options-cb: implement parse_opt_passthru()
 (this branch is used by pt/am-builtin.)

 Reimplement 'git pull' in C.

 Will merge to 'master'.


* rl/send-email-aliases (2015-07-07) 10 commits
  (merged to 'next' on 2015-07-09 at c60553d)
 + send-email: suppress meaningless whitespaces in from field
 + send-email: allow multiple emails using --cc, --to and --bcc
 + send-email: consider quote as delimiter instead of character
 + send-email: reduce dependencies impact on parse_address_line
 + send-email: minor code refactoring
 + send-email: allow use of aliases in the From field of --compose mode
 + send-email: refactor address list process
 + t9001-send-email: refactor header variable fields replacement
 + send-email: allow aliases in patch header and command script outputs
 + t9001-send-email: move script creation in a setup test

 "git send-email" now performs alias-expansion on names that are
 given via --cccmd, etc.

 This round comes with a lot more enhanced e-mail address parser,
 which makes it a bit scary, but as long as it works as designed, it
 makes it wonderful ;-).

 Will merge to 'master'.


* wp/sha1-name-negative-match (2015-06-08) 2 commits
 - sha1_name.c: introduce '^{/!-<negative pattern>}' notation
 - test for '!' handling in rev-parse's named commits

 Introduce "branch^{/!-<pattern>}" notation to name a commit
 reachable from branch that does not match the given pattern.

 Expecting a reroll.


* bc/object-id (2015-06-17) 10 commits
 . remote.c: use struct object_id in many functions
 . object-id: use struct object_id in struct object
 . remote.c: use struct object_id in ref_newer()
 . transport-helper.c: use struct object_id in push_refs_with_export()
 . connect.c: use struct object_id in get_remote_heads()
 . remote-curl: use struct object_id in parse_fetch()
 . fetch-pack: use struct object_id in add_sought_entry_mem()
 . object_id: convert struct ref to use object_id.
 . sha1_file: introduce has_object_file() helper
 . refs: convert some internal functions to use object_id

 More transition from "unsigned char[40]" to "struct object_id".

 While GSoC and other topics are actively moving existing code
 around, this cannot go in; ejected from 'pu'.


* jk/log-missing-default-HEAD (2015-06-03) 1 commit
 - log: diagnose empty HEAD more clearly

 "git init empty && git -C empty log" said "bad default revision 'HEAD'",
 which was found to be a bit confusing to new users.

 What's the status of this one?


* gr/rebase-i-drop-warn (2015-06-30) 3 commits
  (merged to 'next' on 2015-07-15 at 6f4f2c8)
 + git rebase -i: add static check for commands and SHA-1
 + git rebase -i: warn about removed commits
 + git-rebase -i: add command "drop" to remove a commit

 Add "drop commit-object-name subject" command as another way to
 skip replaying of a commit in "rebase -i", and then punish those
 who do not use it (and instead just remove the lines) by throwing
 a warning.

 Will merge to 'master'.


* jh/strbuf-read-use-read-in-full (2015-06-01) 1 commit
 - strbuf_read(): skip unnecessary strbuf_grow() at eof

 Avoid one extra iteration and strbuf_grow() of 8kB in
 strbuf_read().

 Looked reasonable; perhaps a log message clarification is needed.

 Expecting a reroll.


* mg/index-read-error-messages (2015-06-01) 2 commits
 - messages: uniform error messages for index write
 - show-index: uniform error messages for index read

 The tip was RFC.
 Expecting a reroll.


* hv/submodule-config (2015-06-15) 4 commits
 - do not die on error of parsing fetchrecursesubmodules option
 - use new config API for worktree configurations of submodules
 - extract functions for submodule config set and lookup
 - implement submodule config API for lookup of .gitmodules values

 The gitmodules API accessed from the C code learned to cache stuff
 lazily.

 Needs another reroll? ($gmane/273743).


* jc/push-tags-also (2015-05-29) 1 commit
 - push --tags: push tags *in addition to* other stuff

 "git fetch --tags" learned to fetch tags in addition to other stuff
 a few years ago, but "git push --tags" didn't.  Now it does.

 A change to push out more than before always invites "what if the
 user makes a mistake" worries.

 Will discard.


* jc/commit-slab (2015-05-22) 1 commit
  (merged to 'next' on 2015-07-15 at 4c83475)
 + commit-slab: introduce slabname##_peek() function

 Memory use reduction when commit-slab facility is used to annotate
 sparsely (which is not recommended in the first place).

 Will merge to 'master'.


* jc/clone-bundle (2015-04-30) 1 commit
 - repack: optionally create a clone.bundle

 Waiting for further work.
 Still an early WIP.


* ee/clean-remove-dirs (2015-06-26) 6 commits
  (merged to 'next' on 2015-06-29 at d595659)
 + read_gitfile_gently: fix use-after-free
  (merged to 'next' on 2015-06-24 at 7c27821)
 + clean: improve performance when removing lots of directories
 + p7300: add performance tests for clean
 + t7300: add tests to document behavior of clean and nested git
 + setup: sanity check file size in read_gitfile_gently
 + setup: add gentle version of read_gitfile

 Replace "is this subdirectory a separate repository that should not
 be touched?" check "git clean" does by checking if it has .git/HEAD
 using the submodule-related code with a more optimized check.

 Will merge to 'master'.


* jc/merge-drop-old-syntax (2015-04-29) 1 commit
  (merged to 'next' on 2015-05-28 at 6bfd8b9)
 + merge: drop 'git merge <message> HEAD <commit>' syntax

 Stop supporting "git merge <message> HEAD <commit>" syntax that
 has been deprecated since October 2007.

 Will keep in 'next' during the 2.5 cycle.
