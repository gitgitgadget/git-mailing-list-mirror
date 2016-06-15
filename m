From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jun 2015, #04; Tue, 16)
Date: Tue, 16 Jun 2015 15:18:59 -0700
Message-ID: <xmqq616n5mb0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 17 00:19:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4zCI-00078r-6T
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 00:19:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757067AbbFPWTG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 18:19:06 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:34914 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752985AbbFPWTB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 18:19:01 -0400
Received: by igbzc4 with SMTP id zc4so89921257igb.0
        for <git@vger.kernel.org>; Tue, 16 Jun 2015 15:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version
         :content-type;
        bh=3208vK1HfwxHADKro7PjTjDOWoPh6WNZ48PaV5ioabY=;
        b=PTF9cj9xT3zjRuuZpeVBtsgSmQzB7TbyPGKB8om6qUB1aefiQlYexKJafyQsrv78Ip
         pA4KDBx0JpaoCJn4Za+gRLOyySDgu9M4ztS51HCX/+V0e/8K8tFaxD9ZiXJk5u+DZuv1
         jnKLZ3mVVQKr7wFFjzPqZZVu2lPbUw8oano3OVtFvK9JVE+W0MKIqP8GUEaxctlc5DNM
         QJ79v/zTFrhzC6RrpzgfFWBEBdkECFOYokfRdIEtvfoZCgpNvVxre3Lfwq8ybMKqK+lj
         I3tGaJ2mt+it6v/ZR0p0V2chPpQy/N+p4uNi0f6GH3g57pQ4/4aw0FQsXXGxZy1dvEH1
         0gkA==
X-Received: by 10.50.143.37 with SMTP id sb5mr30947625igb.13.1434493140889;
        Tue, 16 Jun 2015 15:19:00 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6c2b:219c:23d9:cf91])
        by mx.google.com with ESMTPSA id g3sm1944561igi.10.2015.06.16.15.19.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 16 Jun 2015 15:19:00 -0700 (PDT)
X-master-at: 16da57c7c6c1fe92b32645202dd19657a89dd67d
X-next-at: d7bed1d571a3164716149e236b028e1e8ae2619b
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271803>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

Hopefully the pre-release freeze can start late next week, and the
next cycle would reopen mid next month.  In the meantime, let's
shift the focus on making sure that what has already been merged to
'master' are good (i.e. regression hunting and fixes).

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* jk/pkt-log-pack (2015-06-16) 3 commits
 - pkt-line: support tracing verbatim pack contents
 - pkt-line: tighten sideband PACK check when tracing
 - pkt-line: simplify starts_with checks in packet tracing

 Enhance packet tracing machinery to allow capturing an incoming
 pack data to a file for debugging.


* jk/stash-require-clean-index (2015-06-15) 1 commit
  (merged to 'next' on 2015-06-16 at beb4883)
 + Revert "stash: require a clean index to apply"

 A hotfix for the topic already in 'master'.

 Will merge to 'master'.


* kb/i18n-doc (2015-06-15) 1 commit
 - Documentation/i18n.txt: clarify character encoding support

 Comments?


* kb/use-nsec-doc (2015-06-15) 1 commit
 - Makefile / racy-git.txt: clarify USE_NSEC prerequisites

 Comments?


* kn/for-each-ref (2015-06-15) 11 commits
 - ref-filter: make 'ref_array_item' use a FLEX_ARRAY for refname
 - for-each-ref: introduce filter_refs()
 - ref-filter: move code from 'for-each-ref'
 - ref-filter: add 'ref-filter.h'
 - for-each-ref: rename variables called sort to sorting
 - for-each-ref: rename some functions and make them public
 - for-each-ref: introduce 'ref_array_clear()'
 - for-each-ref: introduce new structures for better organisation
 - for-each-ref: rename 'refinfo' to 'ref_array_item'
 - for-each-ref: clean up code
 - for-each-ref: extract helper functions out of grab_single_ref()

 GSoC project to rebuild ref listing by branch and tag based on the
 for-each-ref machinery.

 Will merge to 'next'.


* mh/init-delete-refs-api (2015-06-15) 13 commits
 - SQUASH avoid die(variable)
 - refs: move the remaining ref module declarations to refs.h
 - initial_ref_transaction_commit(): check for ref D/F conflicts
 - initial_ref_transaction_commit(): check for duplicate refs
 - refs: remove some functions from the module's public interface
 - initial_ref_transaction_commit(): function for initial ref creation
 - repack_without_refs(): make function private
 - prune_remote(): use delete_refs()
 - delete_refs(): improve error message
 - delete_refs(): new function for the refs API
 - delete_ref(): handle special case more explicitly
 - remove_branches(): remove temporary
 - delete_ref(): move declaration to refs.h

 Clean up refs API and make "git clone" less intimate with the
 implementation detail.

 Needs reroll.


* mh/replace-refs (2015-06-12) 1 commit
 - Allow to control where the replace refs are looked for

 Add an environment variable to tell Git to look into refs hierarchy
 other than refs/replace/ for the object replacement data.


* nd/multiple-work-trees (2015-06-12) 1 commit
 - checkout: don't check worktrees when not necessary

 "git checkout [<tree-ish>] <paths>" spent unnecessary cycles
 checking if the current branch was checked out elsewhere, when we
 know we are not switching the branches ourselves.

 Will merge to 'next'.


* pa/auto-gc-mac-osx (2015-06-12) 1 commit
  (merged to 'next' on 2015-06-16 at 151ec95)
 + hooks/pre-auto-gc: adjust power checking for newer OS X

 Recent Mac OS X updates breaks the logic to detect that the machine
 is on the AC power in the sample pre-auto-gc script.

 Will merge to 'master'.


* pt/t0302-needs-sanity (2015-06-12) 1 commit
  (merged to 'next' on 2015-06-16 at f0d8e17)
 + t0302: "unreadable" test needs SANITY prereq

 Will merge to 'master'.

--------------------------------------------------
[Graduated to "master"]

* ah/send-email-sendmail-alias (2015-05-27) 2 commits
  (merged to 'next' on 2015-06-04 at 9d9bd68)
 + t9001: write $HOME/, not ~/, to help shells without tilde expansion
 + send-email: add sendmail email aliases format
 (this branch is used by es/send-email-sendmail-alias.)

 "git send-email" learned the alias file format used by the sendmail
 program (in an abbreviated form).


* jc/diff-ws-error-highlight (2015-05-26) 4 commits
  (merged to 'next' on 2015-06-01 at 6046560)
 + diff.c: --ws-error-highlight=<kind> option
 + diff.c: add emit_del_line() and emit_context_line()
 + t4015: separate common setup and per-test expectation
 + t4015: modernise style

 Allow whitespace breakages in deleted and context lines to be also
 painted in the output.


* jk/clone-dissociate (2015-05-27) 2 commits
  (merged to 'next' on 2015-06-01 at 19e3ec3)
 + clone: reorder --dissociate and --reference options
 + clone: use OPT_STRING_LIST for --reference

 Code clean-up.


* jk/color-diff-plain-is-context (2015-05-27) 2 commits
  (merged to 'next' on 2015-06-01 at bcd8f1d)
 + diff.h: rename DIFF_PLAIN color slot to DIFF_CONTEXT
 + diff: accept color.diff.context as a synonym for "plain"

 "color.diff.plain" was a misnomer; give it 'color.diff.context' as
 a more logical synonym.


* jk/diagnose-config-mmap-failure (2015-05-28) 5 commits
  (merged to 'next' on 2015-06-01 at ca750d5)
 + xmmap(): drop "Out of memory?"
 + config.c: rewrite ENODEV into EISDIR when mmap fails
 + config.c: avoid xmmap error messages
 + config.c: fix mmap leak when writing config
 + read-cache.c: drop PROT_WRITE from mmap of index

 The configuration reader/writer uses mmap(2) interface to access
 the files; when we find a directory, it barfed with "Out of memory?".


* jk/die-on-bogus-worktree-late (2015-05-29) 1 commit
  (merged to 'next' on 2015-06-04 at fac7a83)
 + setup_git_directory: delay core.bare/core.worktree errors

 The setup code used to die when core.bare and core.worktree are set
 inconsistently, even for commands that do not need working tree.


* jk/make-fix-dependencies (2015-05-29) 3 commits
  (merged to 'next' on 2015-06-04 at 28daf19)
 + Makefile: silence perl/PM.stamp recipe
 + Makefile: avoid timestamp updates to GIT-BUILD-OPTIONS
 + Makefile: drop dependency between git-instaweb and gitweb

 Build clean-up.


* jk/squelch-missing-link-warning-for-unreachable (2015-06-01) 3 commits
  (merged to 'next' on 2015-06-01 at 9ddc5d1)
 + suppress errors on missing UNINTERESTING links
 + silence broken link warnings with revs->ignore_missing_links
 + add quieter versions of parse_{tree,commit}

 Recent "git prune" traverses young unreachable objects to safekeep
 old objects in the reachability chain from them, which sometimes
 caused error messages that are unnecessarily alarming.


* mh/verify-lock-error-report (2015-05-27) 5 commits
  (merged to 'next' on 2015-06-01 at 7b450a7)
 + ref_transaction_commit(): do not capitalize error messages
 + verify_lock(): do not capitalize error messages
 + verify_lock(): report errors via a strbuf
 + verify_lock(): on errors, let the caller unlock the lock
 + verify_lock(): return 0/-1 rather than struct ref_lock *

 Bring consistency to error reporting mechanism used in "refs" API.


* mt/p4-depotFile-at-version (2015-05-27) 1 commit
  (merged to 'next' on 2015-06-01 at 33e8622)
 + p4: retrieve the right revision of the file in UTF-16 codepath


* nd/slim-index-pack-memory-usage (2015-06-04) 1 commit
  (merged to 'next' on 2015-06-04 at 328fd50)
 + index-pack: fix truncation of off_t in comparison

 An earlier optimization broke index-pack for a large object
 transfer; this fixes it before the breakage hits any released
 version.


* pt/pull-tests (2015-05-29) 8 commits
  (merged to 'next' on 2015-06-01 at c98370b)
 + t5520: check reflog action in fast-forward merge
 + t5521: test --dry-run does not make any changes
 + t5520: test --rebase failure on unborn branch with index
 + t5520: test --rebase with multiple branches
 + t5520: test work tree fast-forward when fetch updates head
 + t5520: test for failure if index has unresolved entries
 + t5520: test no merge candidates cases
 + t5520: prevent field splitting in content comparisons
 (this branch is used by pt/pull-optparse.)

 Add more test coverage to "git pull".


* sb/glossary-submodule (2015-05-29) 1 commit
  (merged to 'next' on 2015-06-01 at 84de87b)
 + glossary: add "remote", "submodule", "superproject"


* sb/pack-protocol-mention-smart-http (2015-06-02) 1 commit
  (merged to 'next' on 2015-06-04 at 8041cf6)
 + Documentation/technical/pack-protocol: mention http as possible protocol

 Doc updates.


* sb/submodule-doc-intro (2015-05-28) 1 commit
  (merged to 'next' on 2015-06-01 at b6798de)
 + submodule doc: reorder introductory paragraphs


* sg/merge-summary-config (2015-05-28) 1 commit
  (merged to 'next' on 2015-06-04 at 8c0946c)
 + Documentation: include 'merge.branchdesc' for merge and config as well

 Doc updates.


* tb/complete-sequencing (2015-06-01) 1 commit
  (merged to 'next' on 2015-06-01 at b7604e8)
 + completion: suggest sequencer commands for revert

 The bash completion script (in contrib/) learned a few options that
 "git revert" takes.

--------------------------------------------------
[Stalled]

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

 Will be rerolled.
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


* js/fsck-opt (2015-01-21) 19 commits
 - fsck: support ignoring objects in `git fsck` via fsck.skiplist
 - fsck: git receive-pack: support excluding objects from fsck'ing
 - fsck: introduce `git fsck --quick`
 - fsck: support demoting errors to warnings
 - fsck: document the new receive.fsck.* options
 - fsck: allow upgrading fsck warnings to errors
 - fsck: optionally ignore specific fsck issues completely
 - fsck: disallow demoting grave fsck errors to warnings
 - fsck: add a simple test for receive.fsck.*
 - fsck: make fsck_tag() warn-friendly
 - fsck: handle multiple authors in commits specially
 - fsck: make fsck_commit() warn-friendly
 - fsck: make fsck_ident() warn-friendly
 - fsck: report the ID of the error/warning
 - fsck: allow demoting errors to warnings via receive.fsck.warn = <key>
 - fsck: offer a function to demote fsck errors to warnings
 - fsck: provide a function to parse fsck message IDs
 - fsck: introduce identifiers for fsck messages
 - fsck: introduce fsck options

 "fsck.warnings = <list of error tokens>" I suggested turned out to
 be an unpopular choice (sorry Dscho).

 Expecting a reroll.


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

 Waiting for a reroll ($gmane/256591).


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

* af/tcsh-completion-noclobber (2015-06-09) 1 commit
  (merged to 'next' on 2015-06-16 at 621f205)
 + git-completion.tcsh: fix redirect with noclobber

 The tcsh completion writes a bash scriptlet but that would have
 failed for users with noclobber set.

 Will merge to 'master'.


* es/utf8-stupid-compiler-workaround (2015-06-05) 1 commit
  (merged to 'next' on 2015-06-11 at dc0f2d2)
 + utf8: NO_ICONV: silence uninitialized variable warning

 A compilation workaround.

 Will merge to 'master'.


* fk/doc-format-patch-vn (2015-06-10) 1 commit
  (merged to 'next' on 2015-06-16 at 9be3516)
 + doc: format-patch: fix typo

 Docfix.

 Will merge to 'master'.


* gp/status-rebase-i-info (2015-06-09) 5 commits
 - SQUASH??? fix misindent
 - status: add new tests for status during rebase -i
 - status: give more information during rebase -i
 - status: differentiate interactive from non-interactive rebases
 - status: factor two rebase-related messages together

 Teach "git status" to show a more detailed information regarding
 the "rebase -i" session in progress.

 Expecting a reroll.


* jc/prompt-document-ps1-state-separator (2015-06-10) 1 commit
 - git-prompt.sh: document GIT_PS1_STATESEPARATOR

 Docfix.

 Will merge to 'next'.


* jk/index-pack-reduce-recheck (2015-06-09) 1 commit
  (merged to 'next' on 2015-06-16 at ff83705)
 + index-pack: avoid excessive re-reading of pack directory

 Disable "have we lost a race with competing repack?" check while
 receiving a huge object transfer that runs index-pack.

 Will merge to 'master'.


* js/sleep-without-select (2015-06-05) 4 commits
  (merged to 'next' on 2015-06-11 at 278edb1)
 + lockfile: wait using sleep_millisec() instead of select()
 + lockfile: convert retry timeout computations to millisecond
 + help.c: wrap wait-only poll() invocation in sleep_millisec()
 + lockfile: replace random() by rand()

 Portability fix.

 Will merge to 'master'.


* ld/p4-changes-block-size (2015-06-10) 4 commits
  (merged to 'next' on 2015-06-16 at 09b7daa)
 + git-p4: fixing --changes-block-size handling
 + git-p4: add tests for non-numeric revision range
 + git-p4: test with limited p4 server results
 + git-p4: additional testing of --changes-block-size

 More Perforce row number limit workaround for "git p4".

 Will merge to 'master'.


* mh/fsck-reflog-entries (2015-06-08) 2 commits
  (merged to 'next' on 2015-06-16 at 44e3202)
 + fsck: report errors if reflog entries point at invalid objects
 + fsck_handle_reflog_sha1(): new function

 "git fsck" used to ignore missing or invalid objects recorded in reflog.

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
 - git-rebase--interactive.sh: add config option for custom instruction format

 "git rebase -i"'s list of todo is made configurable.

 Will merge to 'next'.


* nd/untracked-cache (2015-06-08) 1 commit
  (merged to 'next' on 2015-06-16 at 5e7df1d)
 + read-cache: fix untracked cache invalidation when split-index is used

 Hotfix for the 'untracked-cache' topic that is already in 'master'.

 Will merge to 'master'.


* pt/am-abort-fix (2015-06-08) 6 commits
  (merged to 'next' on 2015-06-16 at 9cac1de)
 + am --abort: keep unrelated commits on unborn branch
 + am --abort: support aborting to unborn branch
 + am --abort: revert changes introduced by failed 3way merge
 + am --skip: support skipping while on unborn branch
 + am -3: support 3way merge on unborn branch
 + am --skip: revert changes introduced by failed 3way merge

 Various fixes around "git am" that applies a patch to a history
 that is not there yet.

 Will merge to 'master'.


* pt/am-foreign (2015-06-15) 5 commits
 - am: teach mercurial patch parser how to read from stdin
 - am: use gmtime() to parse mercurial patch date
 - t4150: test applying StGit series
 - am: teach StGit patch parser how to read from stdin
 - t4150: test applying StGit patch

 Various enhancements around "git am" reading patches generated by
 foreign SCM.

 Will merge to 'next'.


* pt/pull-builtin (2015-06-15) 19 commits
 - pull: remove redirection to git-pull.sh
 - pull --rebase: error on no merge candidate cases
 - pull --rebase: exit early when the working directory is dirty
 - pull: configure --rebase via branch.<name>.rebase or pull.rebase
 - pull: teach git pull about --rebase
 - pull: set reflog message
 - pull: implement pulling into an unborn branch
 - pull: fast-forward working tree if head is updated
 - pull: check if in unresolved merge state
 - pull: support pull.ff config
 - pull: error on no merge candidates
 - pull: pass git-fetch's options to git-fetch
 - pull: pass git-merge's options to git-merge
 - pull: pass verbosity, --progress flags to fetch and merge
 - pull: implement fetch + merge
 - pull: implement skeletal builtin pull
 - argv-array: implement argv_array_pushv()
 - parse-options-cb: implement parse_opt_passthru_argv()
 - parse-options-cb: implement parse_opt_passthru()

 Reimplement 'git pull' in C.


* rl/send-email-aliases (2015-06-08) 5 commits
 - send-email: refactor address list process
 - send-email: allow multiple emails using --cc, --to and --bcc
 - t9001-send-email: refactor header variable fields replacement
 - send-email: allow aliases in patch header and command script outputs
 - t9001-send-email: move script creation in a setup test

 "git send-email" now performs alias-expansion on names that are
 given via --cccmd, etc.

 What's the doneness of this one?


* sg/commit-cleanup-scissors (2015-06-09) 1 commit
  (merged to 'next' on 2015-06-16 at 988e23d)
 + commit: cope with scissors lines in commit message

 "git commit --cleanup=scissors" was not careful enough to protect
 against getting fooled by a line that looked like scissors.

 Will merge to 'master'.


* sg/completion-commit-cleanup (2015-06-08) 1 commit
  (merged to 'next' on 2015-06-16 at a9d1c77)
 + completion: teach 'scissors' mode to 'git commit --cleanup='

 Will merge to 'master'.


* wp/sha1-name-negative-match (2015-06-08) 2 commits
 - sha1_name.c: introduce '^{/!-<negative pattern>}' notation
 - test for '!' handling in rev-parse's named commits

 Introduce "branch^{/!-<pattern>}" notation to name a commit
 reachable from branch that does not match the given pattern.

 Expecting a reroll.


* bc/object-id (2015-06-15) 8 commits
 - remote.c: use struct object_id in ref_newer()
 - transport-helper.c: use struct object_id in push_refs_with_export()
 - connect.c: use struct object_id in get_remote_heads()
 - remote-curl: use struct object_id in parse_fetch()
 - fetch-pack: use struct object_id in add_sought_entry_mem()
 - object_id: convert struct ref to use object_id.
 - sha1_file: introduce has_object_file() helper
 - refs: convert some internal functions to use object_id

 (incomplete - the last two not queued yet)


* jc/ll-merge-expose-path (2015-06-04) 1 commit
  (merged to 'next' on 2015-06-11 at 5c5fe41)
 + ll-merge: pass the original path to external drivers

 Traditionally, external low-level 3-way merge drivers are expected
 to produce their results based solely on the contents of the three
 variants given in temporary files named by %O, %A and %B on their
 command line.  Additionally allow them to look at the final path
 (given by %P).

 Will merge to 'master'.


* jk/log-missing-default-HEAD (2015-06-03) 1 commit
 - log: diagnose empty HEAD more clearly

 "git init empty && git -C empty log" said "bad default revision 'HEAD'",
 which was found to be a bit confusing to new users.

 What's the status of this one?


* gr/rebase-i-drop-warn (2015-06-01) 2 commits
 - git rebase -i: warn about removed commits
 - git-rebase -i: add command "drop" to remove a commit

 Add "drop commit-object-name subject" command as another way to
 skip replaying of a commit in "rebase -i", and then punish those
 who do not use it (and instead just remove the lines) by throwing
 a warning.

 What's the status of this one?


* jh/strbuf-read-use-read-in-full (2015-06-01) 1 commit
 - strbuf_read(): skip unnecessary strbuf_grow() at eof

 Avoid one extra iteration and strbuf_grow() of 8kB in
 strbuf_read().

 Looked reasonable; perhaps a log message clarification is needed.

 Expecting a reroll.


* mh/reporting-broken-refs-from-for-each-ref (2015-06-08) 4 commits
  (merged to 'next' on 2015-06-16 at 31af2b8)
 + read_loose_refs(): treat NULL_SHA1 loose references as broken
 + read_loose_refs(): simplify function logic
 + for-each-ref: report broken references correctly
 + t6301: new tests of for-each-ref error handling

 "git for-each-ref" reported "missing object" for 0{40} when it
 encounters a broken ref.  The lack of object whose name is 0{40} is
 not the problem; the ref being broken is.

 Will merge to 'master'.


* jc/apply-reject-noop-hunk (2015-06-01) 1 commit
  (merged to 'next' on 2015-06-11 at 8063665)
 + apply: reject a hunk that does not do anything

 "git apply" cannot diagnose a patch corruption when the breakage is
 to mark the length of the hunk shorter than it really is on the
 hunk header line "@@ -l,k +m,n @@"; one special case it could is
 when the hunk becomes no-op (e.g. k == n == 2 for two-line context
 patch output), and it learned how to do so.

 Will merge to 'master'.


* es/configure-getdelim (2015-06-03) 2 commits
  (merged to 'next' on 2015-06-11 at cdead14)
 + configure: add getdelim() check
 + config.mak.uname: Darwin: define HAVE_GETDELIM for modern OS X releases

 Auto-detect availability of getdelim() that helps optimized version
 of strbuf_getwholeline().

 Will merge to 'master'.


* es/osx-header-pollutes-mask-macro (2015-06-03) 2 commits
  (merged to 'next' on 2015-06-11 at cd8c39e)
 + ewah: use less generic macro name
 + ewah/bitmap: silence warning about MASK macro redefinition

 Will merge to 'master'.


* es/send-email-sendmail-alias (2015-06-01) 10 commits
  (merged to 'next' on 2015-06-11 at b5e310e)
 + send-email: further warn about unsupported sendmail aliases features
 + t9001: add sendmail aliases line continuation tests
 + t9001: refactor sendmail aliases test infrastructure
 + send-email: implement sendmail aliases line continuation support
 + send-email: simplify sendmail aliases comment and blank line recognizer
 + send-email: refactor sendmail aliases parser
 + send-email: fix style: cuddle 'elsif' and 'else' with closing brace
 + send-email: drop noise comments which merely repeat what code says
 + send-email: visually distinguish sendmail aliases parser warnings
 + send-email: further document missing sendmail aliases functionality

 "git send-email" learned to handle more forms of sendmail style
 aliases file.

 Will merge to 'master'.


* jc/do-not-feed-tags-to-clear-commit-marks (2015-06-01) 1 commit
  (merged to 'next' on 2015-06-11 at 65b4308)
 + format-patch: do not feed tags to clear_commit_marks()

 "git format-patch --ignore-if-upstream A..B" did not like to be fed
 tags as boundary commits.

 Will merge to 'master'.


* mg/index-read-error-messages (2015-06-01) 2 commits
 - messages: uniform error messages for index write
 - show-index: uniform error messages for index read

 The tip was RFC.
 Expecting a reroll.


* pt/pull-optparse (2015-06-02) 3 commits
  (merged to 'next' on 2015-06-11 at e252b4c)
 + pull: use git-rev-parse --parseopt for option parsing
 + pull: handle git-fetch's options as well
 + Merge branch 'pt/pull-tests' into pt/pull-optparse

 "git pull" has become more aware of the options meant for
 underlying "git fetch" and then learned to use parse-options
 parser.

 Will merge to 'master'.


* qn/blame-show-email (2015-06-01) 1 commit
  (merged to 'next' on 2015-06-11 at b4998e2)
 + blame: add blame.showEmail configuration

 "git blame" learned blame.showEmail configuration variable.

 Will merge to 'master'.


* rl/am-3way-config (2015-06-04) 3 commits
  (merged to 'next' on 2015-06-11 at 9b9910d)
 + git-am: add am.threeWay config variable
 + t4150-am: refactor am -3 tests
 + git-am.sh: fix initialization of the threeway variable

 "git am" learned am.threeWay configuration variable.

 Will merge to 'master'.


* hv/submodule-config (2015-06-15) 4 commits
 - do not die on error of parsing fetchrecursesubmodules option
 - use new config API for worktree configurations of submodules
 - extract functions for submodule config set and lookup
 - implement submodule config API for lookup of .gitmodules values

 The gitmodules API accessed from the C code learned to cache stuff
 lazily.

 Looked reasonable from a cursory read.


* sg/config-name-only (2015-05-28) 3 commits
 - completion: use new 'git config' options to reliably list variable names
 - SQUASH
 - config: add options to list only variable names

 "git config --list" output was hard to parse when values consist of
 multiple lines.  Introduce a way to show only the keys.

 Adding a single --name-only option may be a better way to go than
 adding two new options.

 Expecting reroll.


* jc/push-tags-also (2015-05-29) 1 commit
 - push --tags: push tags *in addition to* other stuff

 "git fetch --tags" learned to fetch tags in addition to other stuff
 a few years ago, but "git push --tags" didn't.  Now it does.


* jc/commit-slab (2015-05-22) 1 commit
 - commit-slab: introduce slabname##_peek() function

 Memory use reduction when commit-slab facility is used to annotate
 sparsely (which is not recommended in the first place).


* jc/clone-bundle (2015-04-30) 1 commit
 - repack: optionally create a clone.bundle

 Still an early WIP


* ee/clean-remove-dirs (2015-06-15) 5 commits
 - clean: improve performance when removing lots of directories
 - p7300: add performance tests for clean
 - t7300: add tests to document behavior of clean and nested git
 - setup: sanity check file size in read_gitfile_gently
 - setup: add gentle version of read_gitfile

 Replace "is this subdirectory a separate repository that should not
 be touched?" check "git clean" does by checking if it has .git/HEAD
 using the submodule-related code with a more optimized check.

 Looked reasonable from a cursory read.


* jc/merge-drop-old-syntax (2015-04-29) 1 commit
  (merged to 'next' on 2015-05-28 at 6bfd8b9)
 + merge: drop 'git merge <message> HEAD <commit>' syntax

 Stop supporting "git merge <message> HEAD <commit>" syntax that
 has been deprecated since October 2007.

 Will keep in 'next' during the 2.5 cycle.
