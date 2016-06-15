From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jun 2015, #03; Wed, 10)
Date: Wed, 10 Jun 2015 16:32:45 -0700
Message-ID: <xmqqtwufgmw2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 11 01:32:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2pUO-00050d-5f
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 01:32:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203AbbFJXcv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 19:32:51 -0400
Received: from mail-ig0-f193.google.com ([209.85.213.193]:33200 "EHLO
	mail-ig0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155AbbFJXcs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 19:32:48 -0400
Received: by igdj8 with SMTP id j8so7399876igd.0
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 16:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version
         :content-type;
        bh=qGykojU4mKZwrbgTjygAkGrSRTe7LleA1RYbNGdTBFg=;
        b=y6p5665Wr5VuMPnrRmOig43kgo931PrSLVzSIytlToR03RnLRHixq9DC3CX0DVrX8t
         ZoP3yugmbWTldK71B8yhg/nad5rIIRlLJe5wFmLloUyZFavnrE46uDmM/Bzf7y2gUIeM
         tel7KXfRl1rE3mU7YDBv1Qc8LvzcwLYajEoUedV3HF6/3D/lkJ6ZiKVVaO7D5WM0omr+
         euGtQ8UYsU9a7Yxx4Ck435D7x7XemT0As2infCBfBwWgf7ch5fLfskvZvL8+z7gYl6jc
         52ripEForFt60VO76cBHX9MsYFzsVXDwvYOfYXb8x49rbLJWt3IVTY5+ptKvItgKf+t2
         WXAQ==
X-Received: by 10.50.23.116 with SMTP id l20mr31418690igf.13.1433979167818;
        Wed, 10 Jun 2015 16:32:47 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:683f:a599:6eb8:1b1d])
        by mx.google.com with ESMTPSA id a2sm4247905igx.3.2015.06.10.16.32.46
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Jun 2015 16:32:46 -0700 (PDT)
X-master-at: 7974889a053574e449b55ca543a486e38e74864f
X-next-at: 1a18470cb8c6fbcf40b535cf669aa165844706d5
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271366>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

Somehow we are getting quite a many new topics in the past few
weeks.  All the new contributors we acquired recently, including but
not limited to the GSoC and Matthieu's students, are making good
progress, throwing patches and responding to reviews in a reasonable
way, proving themselves to be real assets to the community.

Which, I am very happy about, even though I am a bit behind catching
up with them.  "Let's skip commute to gain an extra productive hour"
I tried yesterday did not help enough X-<.  I am sure I've either
missed or postponed more than a few topics.  I'll try to get to them
but some of them may fall in the cracks; please help by reviewing on
uncommented patches.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* af/tcsh-completion-noclobber (2015-06-09) 1 commit
 - git-completion.tcsh: fix redirect with noclobber

 The tcsh completion writes a bash scriptlet but that would have
 failed for users with noclobber set.

 Will merge to 'next'.


* es/utf8-stupid-compiler-workaround (2015-06-05) 1 commit
 - utf8: NO_ICONV: silence uninitialized variable warning

 A compilation workaround.

 Will merge to 'next'.


* fk/doc-format-patch-vn (2015-06-10) 1 commit
 - doc: format-patch: fix typo

 Docfix.

 Will merge to 'next'.


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
 - index-pack: avoid excessive re-reading of pack directory

 Disable "have we lost a race with competing repack?" check while
 receiving a huge object transfer that runs index-pack.

 Will merge to 'next'.


* js/sleep-without-select (2015-06-05) 4 commits
 - lockfile: wait using sleep_millisec() instead of select()
 - lockfile: convert retry timeout computations to millisecond
 - help.c: wrap wait-only poll() invocation in sleep_millisec()
 - lockfile: replace random() by rand()

 Portability fix.

 Will merge to 'next'.


* ld/p4-changes-block-size (2015-06-10) 4 commits
 - git-p4: fixing --changes-block-size handling
 - git-p4: add tests for non-numeric revision range
 - git-p4: test with limited p4 server results
 - git-p4: additional testing of --changes-block-size

 More Perforce row number limit workaround for "git p4".

 Will merge to 'next'.


* mh/fsck-reflog-entries (2015-06-08) 2 commits
 - fsck: report errors if reflog entries point at invalid objects
 - fsck_handle_reflog_sha1(): new function

 "git fsck" used to ignore missing or invalid objects recorded in reflog.

 Will merge to 'next'.


* mk/utf8-no-iconv-warn (2015-06-08) 1 commit
 - utf8.c: print warning about disabled iconv

 Warn when a reencoding is requested in a build without iconv
 support, as the end user is likely to get an unexpected result.  I
 think the same level of safety should be added to a build with
 iconv support when the specified encoding is not available, but the
 patch does not go there.

 Expecting a reroll.


* mr/rebase-i-customize-insn-sheet (2015-06-08) 1 commit
 - git-rebase--interactive.sh: add config option for custom instruction format

 Breaks tests.

 Expecting a reroll.


* nd/untracked-cache (2015-06-08) 1 commit
 - read-cache: fix untracked cache invalidation when split-index is used

 Hotfix for a topic already in 'master'.

 Will merge to 'next'.


* pt/am-abort-fix (2015-06-08) 6 commits
 - am --abort: keep unrelated commits on unborn branch
 - am --abort: support aborting to unborn branch
 - am --abort: revert changes introduced by failed 3way merge
 - am --skip: support skipping while on unborn branch
 - am -3: support 3way merge on unborn branch
 - am --skip: revert changes introduced by failed 3way merge

 Various fixes around "git am" that applies a patch to a history
 that is not there yet.

 Will merge to 'next'.


* pt/am-foreign (2015-06-08) 6 commits
 - SQUASH??? do not cat a single file into a pipe
 - am: teach mercurial patch parser how to read from stdin
 - am: use gmtime() to parse mercurial patch date
 - t4150: test applying StGit series
 - am: teach StGit patch parser how to read from stdin
 - t4150: test applying StGit patch

 Various enhancements around "git am" reading patches generated by
 foreign SCM.

 Expecting a reroll.


* pt/pull-builtin (2015-06-09) 20 commits
 . SQUASH??? adjust to new world order after 9e3751d4 (remote.c: drop "remote" pointer from "struct branch", 2015-05-21)
 . pull: remove redirection to git-pull.sh
 . pull --rebase: error on no merge candidate cases
 . pull --rebase: exit early when the working directory is dirty
 . pull: configure --rebase via branch.<name>.rebase or pull.rebase
 . pull: teach git pull about --rebase
 . pull: set reflog message
 . pull: implement pulling into an unborn branch
 . pull: fast-forward working tree if head is updated
 . pull: check if in unresolved merge state
 - pull: support pull.ff config
 - pull: error on no merge candidates
 - pull: pass git-fetch's options to git-fetch
 - pull: pass git-merge's options to git-merge
 - pull: pass verbosity, --progress flags to fetch and merge
 - pull: implement fetch + merge
 - pull: implement skeletal builtin pull
 - argv-array: implement argv_array_pushv()
 - parse-options-cb: implement parse_opt_pass_argv_array()
 - parse-options-cb: implement parse_opt_pass_strbuf()

 Expecting a reroll.


* rl/send-email-aliases (2015-06-08) 5 commits
 - send-email: refactor address list process
 - send-email: allow multiple emails using --cc, --to and --bcc
 - t9001-send-email: refactor header variable fields replacement
 - send-email: allow aliases in patch header and command script outputs
 - t9001-send-email: move script creation in a setup test

 "git send-email" now performs alias-expansion on names that are
 given via --cccmd, etc.

 Expecting a reroll.


* sg/commit-cleanup-scissors (2015-06-09) 1 commit
 - commit: cope with scissors lines in commit message

 "git commit --cleanup=scissors" was not careful enough to protect
 against getting fooled by a line that looked like scissors.

 Will merge to 'next'.


* sg/completion-commit-cleanup (2015-06-08) 1 commit
 - completion: teach 'scissors' mode to 'git commit --cleanup='

 Will merge to 'next'.


* wp/sha1-name-negative-match (2015-06-08) 2 commits
 - sha1_name.c: introduce '^{/!-<negative pattern>}' notation
 - test for '!' handling in rev-parse's named commits

 Introduce "branch^{/!-<pattern>}" notation to name a commit
 reachable from branch that does not match the given pattern.

 Expecting a reroll.


* bc/object-id (2015-06-10) 7 commits
 - ref_newer: convert to use struct object_id
 - parse_fetch: convert to use struct object_id
 - add_sought_entry_mem: convert to struct object_id
 - Add a utility function to make parsing hex values easier.
 - Convert struct ref to use object_id.
 - sha1_file: introduce has_object_file helper.
 - refs: convert some internal functions to use object_id

 (incomplete)

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

* jc/ll-merge-expose-path (2015-06-04) 1 commit
 - ll-merge: pass the original path to external drivers

 Traditionally, external low-level 3-way merge drivers are expected
 to produce their results based solely on the contents of the three
 variants given in temporary files named by %O, %A and %B on their
 command line.  Additionally allow them to look at the final path
 (given by %P).

 Will merge to 'next'.


* jk/log-missing-default-HEAD (2015-06-03) 1 commit
 - log: diagnose empty HEAD more clearly

 "git init empty && git -C empty log" said "bad default revision 'HEAD'",
 which was found to be a bit confusing to new users.

 What's the status of this one?


* nd/slim-index-pack-memory-usage (2015-06-04) 1 commit
  (merged to 'next' on 2015-06-04 at 328fd50)
 + index-pack: fix truncation of off_t in comparison

 An earlier optimization broke index-pack for a large object
 transfer; this fixes it before the breakage hits any released
 version.

 Will merge to 'master'.


* gr/rebase-i-drop-warn (2015-06-01) 2 commits
 - git rebase -i: warn about removed commits
 - git-rebase -i: add command "drop" to remove a commit

 Add "drop commit-object-name subject" command as another way to
 skip replaying of a commit in "rebase -i", and then punish those
 who do not use it (and instead just remove the lines) by throwing
 a warning.

 Expecting a reroll.


* jh/strbuf-read-use-read-in-full (2015-06-01) 1 commit
 - strbuf_read(): skip unnecessary strbuf_grow() at eof

 Avoid one extra iteration and strbuf_grow() of 8kB in
 strbuf_read().

 Looked reasonable; perhaps a log message clarification is needed.

 Expecting a reroll.


* jk/squelch-missing-link-warning-for-unreachable (2015-06-01) 3 commits
  (merged to 'next' on 2015-06-01 at 9ddc5d1)
 + suppress errors on missing UNINTERESTING links
 + silence broken link warnings with revs->ignore_missing_links
 + add quieter versions of parse_{tree,commit}

 Recent "git prune" traverses young unreachable objects to safekeep
 old objects in the reachability chain from them, which causes
 error messages that are unnecessarily alarming.

 Will merge to 'master'.


* mh/reporting-broken-refs-from-for-each-ref (2015-06-08) 4 commits
 - read_loose_refs(): treat NULL_SHA1 loose references as broken
 - read_loose_refs(): simplify function logic
 - for-each-ref: report broken references correctly
 - t6301: new tests of for-each-ref error handling

 "git for-each-ref" reported "missing object" for 0{40} when it
 encounters a broken ref.  The lack of object whose name is 0{40} is
 not the problem; the ref being broken is.

 Will merge to 'next'.


* tb/complete-sequencing (2015-06-01) 1 commit
  (merged to 'next' on 2015-06-01 at b7604e8)
 + completion: suggest sequencer commands for revert

 The bash completion script (in contrib/) learned a few options that
 "git revert" takes.

 Will merge to 'master'.


* jc/apply-reject-noop-hunk (2015-06-01) 1 commit
 - apply: reject a hunk that does not do anything

 "git apply" cannot diagnose a patch corruption when the breakage is
 to mark the length of the hunk shorter than it really is on the
 hunk header line "@@ -l,k +m,n @@"; one special case it could is
 when the hunk becomes no-op (e.g. k == n == 2 for two-line context
 patch output), and it learned how to do so.

 Will merge to 'next'.


* es/configure-getdelim (2015-06-03) 2 commits
 - configure: add getdelim() check
 - config.mak.uname: Darwin: define HAVE_GETDELIM for modern OS X releases

 Auto-detect availability of getdelim() that helps optimized version
 of strbuf_getwholeline().

 Will merge to 'next'.


* es/osx-header-pollutes-mask-macro (2015-06-03) 2 commits
 - ewah: use less generic macro name
 - ewah/bitmap: silence warning about MASK macro redefinition

 Will merge to 'next'.


* es/send-email-sendmail-alias (2015-06-01) 10 commits
 - send-email: further warn about unsupported sendmail aliases features
 - t9001: add sendmail aliases line continuation tests
 - t9001: refactor sendmail aliases test infrastructure
 - send-email: implement sendmail aliases line continuation support
 - send-email: simplify sendmail aliases comment and blank line recognizer
 - send-email: refactor sendmail aliases parser
 - send-email: fix style: cuddle 'elsif' and 'else' with closing brace
 - send-email: drop noise comments which merely repeat what code says
 - send-email: visually distinguish sendmail aliases parser warnings
 - send-email: further document missing sendmail aliases functionality
 (this branch uses ah/send-email-sendmail-alias.)

 "git send-email" learned to handle more forms of sendmail style
 aliases file.

 Will merge to 'next'.


* jc/do-not-feed-tags-to-clear-commit-marks (2015-06-01) 1 commit
 - format-patch: do not feed tags to clear_commit_marks()

 "git format-patch --ignore-if-upstream A..B" did not like to be fed
 tags as boundary commits.

 Will merge to 'next'.


* mg/index-read-error-messages (2015-06-01) 2 commits
 - messages: uniform error messages for index write
 - show-index: uniform error messages for index read

 The tip was RFC.
 Expecting a reroll.


* pt/pull-optparse (2015-06-02) 3 commits
 - pull: use git-rev-parse --parseopt for option parsing
 - pull: handle git-fetch's options as well
 - Merge branch 'pt/pull-tests' into pt/pull-optparse
 (this branch uses pt/pull-tests.)

 "git pull" has become more aware of the options meant for
 underlying "git fetch" and then learned to use parse-options
 parser.

 Will merge to 'next'.


* qn/blame-show-email (2015-06-01) 1 commit
 - blame: add blame.showEmail configuration

 "git blame" learned blame.showEmail configuration variable.

 Will merge to 'next'.


* rl/am-3way-config (2015-06-04) 3 commits
 - git-am: add am.threeWay config variable
 - t4150-am: refactor am -3 tests
 - git-am.sh: fix initialization of the threeway variable

 "git am" learned am.threeWay configuration variable.

 Will merge to 'next'.


* sb/pack-protocol-mention-smart-http (2015-06-02) 1 commit
  (merged to 'next' on 2015-06-04 at 8041cf6)
 + Documentation/technical/pack-protocol: mention http as possible protocol

 Doc updates.

 Will merge to 'master'.


* hv/submodule-config (2015-06-02) 4 commits
 - do not die on error of parsing fetchrecursesubmodules option
 - use new config API for worktree configurations of submodules
 - extract functions for submodule config set and lookup
 - implement submodule config cache for lookup of submodule names

 The gitmodules API accessed from the C code learned to cache stuff
 lazily.

 What's the doneness of this one?


* jc/diff-ws-error-highlight (2015-05-26) 4 commits
  (merged to 'next' on 2015-06-01 at 6046560)
 + diff.c: --ws-error-highlight=<kind> option
 + diff.c: add emit_del_line() and emit_context_line()
 + t4015: separate common setup and per-test expectation
 + t4015: modernise style

 Allow whitespace breakages in deleted and context lines to be also
 painted in the output.

 Will merge to 'master'.


* jk/clone-dissociate (2015-05-27) 2 commits
  (merged to 'next' on 2015-06-01 at 19e3ec3)
 + clone: reorder --dissociate and --reference options
 + clone: use OPT_STRING_LIST for --reference

 Code clean-up.

 Will merge to 'master'.


* jk/color-diff-plain-is-context (2015-05-27) 2 commits
  (merged to 'next' on 2015-06-01 at bcd8f1d)
 + diff.h: rename DIFF_PLAIN color slot to DIFF_CONTEXT
 + diff: accept color.diff.context as a synonym for "plain"

 "color.diff.plain" was a misnomer; give it 'color.diff.context' as
 a more logical synonym.

 Will merge to 'master'.


* jk/diagnose-config-mmap-failure (2015-05-28) 5 commits
  (merged to 'next' on 2015-06-01 at ca750d5)
 + xmmap(): drop "Out of memory?"
 + config.c: rewrite ENODEV into EISDIR when mmap fails
 + config.c: avoid xmmap error messages
 + config.c: fix mmap leak when writing config
 + read-cache.c: drop PROT_WRITE from mmap of index

 The configuration reader/writer uses mmap(2) interface to access
 the files; when we find a directory, it barfed with "Out of memory?".

 Will merge to 'master'.


* mh/verify-lock-error-report (2015-05-27) 5 commits
  (merged to 'next' on 2015-06-01 at 7b450a7)
 + ref_transaction_commit(): do not capitalize error messages
 + verify_lock(): do not capitalize error messages
 + verify_lock(): report errors via a strbuf
 + verify_lock(): on errors, let the caller unlock the lock
 + verify_lock(): return 0/-1 rather than struct ref_lock *

 Bring consistency to error reporting mechanism used in "refs" API.

 Will merge to 'master'.


* mt/p4-depotFile-at-version (2015-05-27) 1 commit
  (merged to 'next' on 2015-06-01 at 33e8622)
 + p4: retrieve the right revision of the file in UTF-16 codepath

 Will merge to 'master'.


* sb/glossary-submodule (2015-05-29) 1 commit
  (merged to 'next' on 2015-06-01 at 84de87b)
 + glossary: add "remote", "submodule", "superproject"

 Will merge to 'master'.


* sg/config-name-only (2015-05-28) 3 commits
 - completion: use new 'git config' options to reliably list variable names
 - SQUASH
 - config: add options to list only variable names

 "git config --list" output was hard to parse when values consist of
 multiple lines.  Introduce a way to show only the keys.

 Adding a single --name-only option may be a better way to go than
 adding two new options.

 Expecting reroll.


* sg/merge-summary-config (2015-05-28) 1 commit
  (merged to 'next' on 2015-06-04 at 8c0946c)
 + Documentation: include 'merge.branchdesc' for merge and config as well

 Doc updates.

 Will merge to 'master'.


* jc/push-tags-also (2015-05-29) 1 commit
 - push --tags: push tags *in addition to* other stuff

 "git fetch --tags" learned to fetch tags in addition to other stuff
 a few years ago, but "git push --tags" didn't.  Now it does.


* jk/die-on-bogus-worktree-late (2015-05-29) 1 commit
  (merged to 'next' on 2015-06-04 at fac7a83)
 + setup_git_directory: delay core.bare/core.worktree errors

 The setup code used to die when core.bare and core.worktree are set
 inconsistently, even for commands that do not need working tree.

 Will merge to 'master'.


* jk/make-fix-dependencies (2015-05-29) 3 commits
  (merged to 'next' on 2015-06-04 at 28daf19)
 + Makefile: silence perl/PM.stamp recipe
 + Makefile: avoid timestamp updates to GIT-BUILD-OPTIONS
 + Makefile: drop dependency between git-instaweb and gitweb

 Build clean-up.

 Will merge to 'master'.


* ah/send-email-sendmail-alias (2015-05-27) 2 commits
  (merged to 'next' on 2015-06-04 at 9d9bd68)
 + t9001: write $HOME/, not ~/, to help shells without tilde expansion
 + send-email: add sendmail email aliases format
 (this branch is used by es/send-email-sendmail-alias.)

 "git send-email" learned the alias file format used by the sendmail
 program (in an abbreviated form).

 Will merge to 'master'.


* jc/commit-slab (2015-05-22) 1 commit
 - commit-slab: introduce slabname##_peek() function

 Memory use reduction when commit-slab facility is used to annotate
 sparsely (which is not recommended in the first place).


* sb/submodule-doc-intro (2015-05-28) 1 commit
  (merged to 'next' on 2015-06-01 at b6798de)
 + submodule doc: reorder introductory paragraphs

 Will merge to 'master'.


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

 Will merge to 'master'.


* jc/clone-bundle (2015-04-30) 1 commit
 - repack: optionally create a clone.bundle

 Still an early WIP


* ee/clean-remove-dirs (2015-06-09) 5 commits
 - clean: improve performance when removing lots of directories
 - p7300: add performance tests for clean
 - t7300: add tests to document behavior of clean and nested git
 - setup: sanity check file size in read_gitfile_gently
 - setup: add gentle version of read_gitfile

 Replace "is this subdirectory a separate repository that should not
 be touched?" check "git clean" does by checking if it has .git/HEAD
 using the submodule-related code with a more optimized check.

 Haven't seen reviews on this updated round, and I haven't read it myself.


* jc/merge-drop-old-syntax (2015-04-29) 1 commit
  (merged to 'next' on 2015-05-28 at 6bfd8b9)
 + merge: drop 'git merge <message> HEAD <commit>' syntax

 Stop supporting "git merge <message> HEAD <commit>" syntax that
 has been deprecated since October 2007.

 Will keep in 'next' during the 2.5 cycle.
