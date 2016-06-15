From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Aug 2015, #05; Fri, 28)
Date: Fri, 28 Aug 2015 14:11:01 -0700
Message-ID: <xmqq4mjj15lm.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 28 23:11:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVQvZ-0003aA-Aw
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 23:11:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752938AbbH1VLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2015 17:11:08 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33388 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625AbbH1VLE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2015 17:11:04 -0400
Received: by pacgr6 with SMTP id gr6so653177pac.0
        for <git@vger.kernel.org>; Fri, 28 Aug 2015 14:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version
         :content-type;
        bh=GPbTe21ox6Qo4TDwRHVasrL+KbLEFtXXAPrHV872exw=;
        b=ftCWP437yy1TH7sc7flvZQamKqW0SCw0/b6FsKCpRYk3fpER/OFRIvhSZ0DS7Ht7Ri
         Q7Hj1b2nsgsbuRhx0a+2XgRFznOBKLsPGCvN4ET/a7PsBz0tjCWeDk/YrsB6OhOHbdM9
         7Qz0+pm2ej4ov9jsIrxkbPyi1e8ukCpSgwOhIXgtv3O+EUGflxTVJeO1uWg7/EEt3a03
         qz/9K8V1FpgyYQZCNLOWHpn5sNJQxQ9Ja9MbTexM1ejIE38bfKFU8EDkLYHFY8YAQgpy
         2VQuf71AYISDuWyDa4KQxDJ834A/lwj2vSWB78TpR+GC+5IAk3BaIZMQxZeDDZyE+CRw
         nKJQ==
X-Received: by 10.66.235.33 with SMTP id uj1mr25355514pac.10.1440796263380;
        Fri, 28 Aug 2015 14:11:03 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:c919:3f20:8560:5a06])
        by smtp.gmail.com with ESMTPSA id jr12sm6694812pbb.91.2015.08.28.14.11.02
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 28 Aug 2015 14:11:02 -0700 (PDT)
X-master-at: aecce6d0eff68a7144e32247d2e02d9974772ab1
X-next-at: bcd55f746af0c6584187e548b53df1562e68a14d
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276759>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* as/docfix-reflog-expire-unreachable (2015-08-21) 1 commit
  (merged to 'next' on 2015-08-25 at eb75d55)
 + Documentation/config: fix inconsistent label on gc.*.reflogExpireUnreachable

 Docfix.


* cc/trailers-corner-case-fix (2015-08-21) 1 commit
  (merged to 'next' on 2015-08-25 at ac25d80)
 + trailer: ignore first line of message

 "interpret-trailers" helper mistook a single-liner log message that
 has a colon as the end of existing trailer.


* dt/untracked-sparse (2015-08-19) 1 commit
  (merged to 'next' on 2015-08-25 at 2501a7e)
 + t7063: use --force-untracked-cache to speed up a bit
 (this branch is used by dt/untracked-subdir.)

 Test update.


* dt/untracked-subdir (2015-08-19) 2 commits
  (merged to 'next' on 2015-08-25 at ab4fd04)
 + untracked cache: fix entry invalidation
 + untracked-cache: fix subdirectory handling
 (this branch uses dt/untracked-sparse.)

 The experimental untracked-cache feature were buggy when paths with
 a few levels of subdirectories are involved.


* ep/http-configure-ssl-version (2015-08-17) 1 commit
  (merged to 'next' on 2015-08-19 at aab726b)
 + http: add support for specifying the SSL version

 A new configuration variable http.sslVersion can be used to specify
 what specific version of SSL/TLS to use to make a connection.


* jc/calloc-pathspec (2015-08-20) 1 commit
  (merged to 'next' on 2015-08-25 at 877490c)
 + ps_matched: xcalloc() takes nmemb and then element size

 Minor code cleanup.


* jv/send-email-selective-smtp-auth (2015-08-17) 1 commit
  (merged to 'next' on 2015-08-19 at 3f0c693)
 + send-email: provide whitelist of SMTP AUTH mechanisms

 "git send-email" learned a new option --smtp-auth to limit the SMTP
 AUTH mechanisms to be used to a subset of what the system library
 supports.


* po/po-readme (2015-08-17) 1 commit
  (merged to 'next' on 2015-08-19 at 1899e59)
 + po/README: Update directions for l10n contributors

 Doc updates for i18n.


* pt/am-builtin-abort-fix (2015-08-19) 1 commit
  (merged to 'next' on 2015-08-19 at 729e682)
 + am --skip/--abort: merge HEAD/ORIG_HEAD tree into index

 "git am" that was recently reimplemented in C had a performance
 regression in "git am --abort" that goes back to the version before
 an attempted (and failed) patch application.


* sg/help-group (2015-08-25) 1 commit
  (merged to 'next' on 2015-08-25 at 907e5a8)
 + generate-cmdlist: re-implement as shell script

 We rewrote one of the build scripts in Perl but this reimplements
 in Bourne shell.


* sg/t3020-typofix (2015-08-20) 1 commit
  (merged to 'next' on 2015-08-25 at 051d6c0)
 + t3020: fix typo in test description


* sg/wt-status-header-inclusion (2015-08-21) 1 commit
  (merged to 'next' on 2015-08-25 at fa5b2b2)
 + wt-status: move #include "pathspec.h" to the header


* ss/fix-config-fd-leak (2015-08-14) 1 commit
  (merged to 'next' on 2015-08-19 at 80d4880)
 + config: close config file handle in case of error

--------------------------------------------------
[New Topics]

* ah/pack-objects-usage-strings (2015-08-28) 1 commit
 - pack-objects: place angle brackets around placeholders in usage strings

 Usage string fix.

 Will merge to 'next'.


* ah/read-tree-usage-string (2015-08-28) 1 commit
 - read-tree: replace bracket set with parentheses to clarify usage

 Usage string fix.

 Will merge to 'next'.


* ah/reflog-typofix-in-error (2015-08-28) 1 commit
 - reflog: add missing single quote to error message

 Error string fix.

 Will merge to 'next'.


* ah/submodule-typofix-in-error (2015-08-28) 1 commit
 - git-submodule: remove extraneous space from error message

 Error string fix.

 Will merge to 'next'.


* br/svn-doc-include-paths-config (2015-08-26) 1 commit
 - git-svn doc: mention "svn-remote.<name>.include-paths"

 Will merge to 'next'.


* dt/commit-preserve-base-index-upon-opportunistic-cache-tree-update (2015-08-28) 1 commit
 - commit: don't rewrite shared index unnecessarily

 When re-priming the cache-tree opportunistically while committing
 the in-core index as-is, we mistakenly invalidated the in-core
 index too aggressively, causing the experimental split-index code
 to unnecessarily rewrite the on-disk index file(s).

 Will merge to 'next'.


* dt/refs-bisection (2015-08-28) 5 commits
 - bisect: make bisection refs per-worktree
 - refs: make refs/worktree/* per-worktree
 - SQUASH???
 - path: optimize common dir checking
 - refs: clean up common_list

 Move the refs used during a "git bisect" session to per-worktree
 hierarchy refs/worktree/* so that independent bisect sessions can
 be done in different worktrees.

 Will merge to 'next' after squashing the update in.


* ld/p4-import-labels (2015-08-28) 3 commits
 - git-p4: fix P4 label import for unprocessed commits
 - git-p4: do not terminate creating tag for unknown commit
 - git-p4: failing test for ignoring invalid p4 labels


* ls/p4-fold-case-client-specs (2015-08-28) 1 commit
 - git-p4: honor core.ignorecase when using P4 client specs

 On case insensitive systems, "git p4" did not work well with client
 specs.

 Will merge to 'next'.

* rs/archive-zip-many (2015-08-28) 3 commits
 - archive-zip: support more than 65535 entries
 - archive-zip: use a local variable to store the creator version
 - t5004: test ZIP archives with many entries

 "git archive" did not use zip64 extension when creating an archive
 with more than 64k entries, which nobody should need, right ;-)?

 Will merge to 'next'.


* rt/remove-hold-lockfile-for-append (2015-08-28) 1 commit
 - lockfile: remove function "hold_lock_file_for_append"

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* sb/remove-get-pathspec (2015-08-03) 1 commit
 - builtin/mv: remove get_pathspec()

 Will discard.
 ($gmane/276104)


* mk/submodule-gitdir-path (2015-08-05) 2 commits
 - path: implement common_dir handling in git_path_submodule()
 - submodule refactor: use git_path_submodule() in add_submodule_odb()

 The submodule code has been taught to work better with separate
 work trees created via "git worktree add".

 Waiting for a review.
 ($gmane/275340).


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


* mh/numparse (2015-03-19) 14 commits
 . diff_opt_parse(): use convert_i() when handling --abbrev=<num>
 . diff_opt_parse(): use convert_i() when handling "-l<num>"
 . opt_arg(): simplify pointer handling
 . opt_arg(): report errors parsing option values
 . opt_arg(): use convert_i() in implementation
 . opt_arg(): val is always non-NULL
 . builtin_diff(): detect errors when parsing --unified argument
 . handle_revision_opt(): use convert_ui() when handling "--abbrev="
 . strtoul_ui(), strtol_i(): remove functions
 . handle_revision_opt(): use convert_i() when handling "-<digit>"
 . handle_revision_opt(): use skip_prefix() in many places
 . write_subdirectory(): use convert_ui() for parsing mode
 . cacheinfo_callback(): use convert_ui() when handling "--cacheinfo"
 . numparse: new module for parsing integral numbers

 Many codepaths use unchecked use of strtol() and friends (or even
 worse, atoi()).  Introduce a set of wrappers that try to be more
 careful.

 Waiting for a reroll.
 ($gmane/268058).


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

 Waiting for a reroll.
 with updated log message ($gmane/268061).


* bw/portability-solaris (2015-07-20) 3 commits
 - tests: fix sed usage in tests to work around broken xpg4/sed on Solaris
 - tests: fix sed usage in tests to work around broken xpg4/sed on Solaris
 - tests: modify tr expressions so that xpg4/tr handles it on Solaris

 Needs another reroll?
 ($gmane/274296)


* jc/clone-bundle (2015-04-30) 1 commit
 - repack: optionally create a clone.bundle

 Waiting for further work.
 Still an early WIP.


* mg/index-read-error-messages (2015-06-01) 2 commits
 - messages: uniform error messages for index write
 - show-index: uniform error messages for index read

 The tip was RFC.
 Waiting for a reroll.


* jk/log-missing-default-HEAD (2015-06-03) 1 commit
 - log: diagnose empty HEAD more clearly

 "git init empty && git -C empty log" said "bad default revision 'HEAD'",
 which was found to be a bit confusing to new users.

 What's the status of this one?


* wp/sha1-name-negative-match (2015-06-08) 2 commits
 - sha1_name.c: introduce '^{/!-<negative pattern>}' notation
 - test for '!' handling in rev-parse's named commits

 Introduce "branch^{/!-<pattern>}" notation to name a commit
 reachable from branch that does not match the given pattern.

 Waiting for a reroll.


* mk/utf8-no-iconv-warn (2015-06-08) 1 commit
 - utf8.c: print warning about disabled iconv

 Warn when a reencoding is requested in a build without iconv
 support, as the end user is likely to get an unexpected result.  I
 think the same level of safety should be added to a build with
 iconv support when the specified encoding is not available, but the
 patch does not go there.

 Waiting for a reroll.


* ak/format-patch-odir-config (2015-06-19) 1 commit
 - format-patch: introduce format.outputDirectory configuration

 Reroll exists but didn't pick it up as it seemed to be still
 collecting review comments.

 Waiting for a reroll.
 ($gmane/272180).


* ad/bisect-terms (2015-08-03) 4 commits
 - bisect: allow setting any user-specified in 'git bisect start'
 - bisect: add 'git bisect terms' to view the current terms
 - bisect: add the terms old/new
 - bisect: sanity check on terms

 The use of 'good/bad' in "git bisect" made it confusing to use when
 hunting for a state change that is not a regression (e.g. bugfix).
 The command learned 'old/new' and then allows the end user to
 say e.g. "bisect start --term-old=fast --term=new=slow" to find a
 performance regression.

 Michael's idea to make 'good/bad' more intelligent does have
 certain attractiveness ($gname/272867), and makes some of the work
 on this topic a moot point.

 Will hold.


* mh/notes-allow-reading-treeish (2015-07-13) 1 commit
 - notes: allow treeish expressions as notes ref

 Some "git notes" operations, e.g. "git log --notes=<note>", should
 be able to read notes from any tree-ish that is shaped like a notes
 tree, but the notes infrastructure required that the argument must
 be a ref under refs/notes/.  Loosen it to require a valid ref only
 when the operation would update the notes (in which case we must
 have a place to store the updated notes tree, iow, a ref).

 Needs update to docs.
 ($gmane/273928)


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
 . remote: add --fetch and --both options to set-url

 Ejected.


* tr/remerge-diff (2014-11-10) 9 commits
 . t4213: avoid "|" in sed regexp
 . log --remerge-diff: show what the conflict resolution changed
 . name-hash: allow dir hashing even when !ignore_case
 . merge-recursive: allow storing conflict hunks in index
 . merge_diff_mode: fold all merge diff variants into an enum
 . combine-diff: do not pass revs->dense_combined_merges redundantly
 . merge-recursive: -Xindex-only to leave worktree unchanged
 . merge-recursive: internal flag to avoid touching the worktree
 . merge-recursive: remove dead conditional in update_stages()

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

* jc/am-state-fix (2015-08-25) 5 commits
  (merged to 'next' on 2015-08-25 at 4efcd88)
 + write_file(): drop caller-supplied LF from calls to create a one-liner file
 + write_file_v(): do not leave incomplete line at the end
 + write_file(): drop "fatal" parameter
 + builtin/am: make sure state files are text
 + builtin/am: introduce write_state_*() helper functions

 Recent reimplementation of "git am" changed the format of state
 files kept in $GIT_DIR/rebase-apply/ without meaning to do so,
 primarily because write_file() API was cumbersome to use and it was
 easy to mistakenly make text files with incomplete lines.  Update
 write_file() interface to make it harder to misuse.

 Will merge to 'master'.


* jc/log-p-cc (2015-08-25) 4 commits
  (merged to 'next' on 2015-08-25 at 2d6a6d4)
 + builtin/log.c: minor reformat
 + log: show merge commit when --cc is given
 + log: when --cc is given, default to -p unless told otherwise
 + log: rename "tweak" helpers

 "git log --cc" did not show any patch, even though most of the time
 the user meant "git log --cc -p -m" to see patch output for commits
 with a single parent, and combined diff for merge commits.  The
 command is taught to DWIM "--cc" (without "--raw" and other forms
 of output specification) to "--cc -p -m".

 Will merge to 'master'.


* jk/fix-alias-pager-config-key-warnings (2015-08-24) 1 commit
  (merged to 'next' on 2015-08-25 at 89eac5a)
 + config: silence warnings for command names with invalid keys

 Because the configuration system does not allow "alias.0foo" and
 "pager.0foo" as the configuration key, the user cannot use '0foo'
 as a custom command name anyway, but "git 0foo" tried to look these
 keys up and emitted useless warnings before saying '0foo is not a
 git command'.  These warning messages have been squelched.

 Will merge to 'master'.


* jk/rev-list-has-no-notes (2015-08-24) 1 commit
  (merged to 'next' on 2015-08-25 at 73cb2ad)
 + rev-list: make it obvious that we do not support notes

 "git rev-list" does not take "--notes" option, but did not complain
 when one is given.

 Will merge to 'master'.


* kn/for-each-tag (2015-08-25) 15 commits
 - SQUASH??? a tag longer than 15 bytes break alignment but keeps SP before the message
 - tag.c: implement '--merged' and '--no-merged' options
 - tag.c: implement '--format' option
 - tag.c: use 'ref-filter' APIs
 - tag.c: use 'ref-filter' data structures
 - ref-filter: add option to match literal pattern
 - ref-filter: add support to sort by version
 - ref-filter: support printing N lines from tag annotation
 - ref-filter: add option to filter out tags, branches and remotes
 - ref-filter: implement an `align` atom
 - utf8: add function to align a string into given strbuf
 - ref-filter: introduce ref_formatting_state and ref_formatting_stack
 - ref-filter: move `struct atom_value` to ref-filter.c
 - Merge 'jk/git-path' into kn/for-each-tag
 - Merge 'kn/for-each-tag-branch' into kn/for-each-tag
 (this branch uses kn/for-each-tag-branch.)

 The "ref-filter" code was taught about many parts of what "tag -l"
 does and then "tag -l" is reimplemented in terms of "ref-filter".

 Almost there...
 Waiting for a reroll.
 ($gmane/276615, $gmane/276529, $gmane/276607, $gmane/276606, etc.)


* nd/fixup-linked-gitdir (2015-08-25) 1 commit
  (merged to 'next' on 2015-08-26 at 7b8a1aa)
 + setup: update the right file in multiple checkouts

 The code in "multiple-worktree" support that attempted to recover
 from an inconsistent state updated an incorrect file.

 Will merge to 'master'.


* nd/ita-cleanup (2015-08-25) 6 commits
 - grep: make it clear i-t-a entries are ignored
 - checkout(-index): do not checkout i-t-a entries
 - apply: make sure check_preimage() does not leave empty file on error
 - apply: fix adding new files on i-t-a entries
 - Add and use convenient macro ce_intent_to_add()
 - blame: remove obsolete comment

 Paths that have been told the index about with "add -N" are not yet
 in the index, but various commands behaved as if they already are.

 Some commits need better explanation.

 Waiting for a reroll.


* sg/describe-contains (2015-08-25) 1 commit
  (merged to 'next' on 2015-08-26 at a7c66d9)
 + describe --contains: default to HEAD when no commit-ish is given

 "git describe" without argument defaulted to describe the HEAD
 commit, but "git describe --contains" didn't.  Arguably, in a
 repository used for active development, such defaulting would not
 be very useful as the tip of branch is typically not tagged, but it
 is better to be consistent.

 Will merge to 'master'.


* db/push-sign-if-asked (2015-08-19) 9 commits
  (merged to 'next' on 2015-08-26 at a7a32e9)
 + push: add a config option push.gpgSign for default signed pushes
 + push: support signing pushes iff the server supports it
 + builtin/send-pack.c: use parse_options API
 + config.c: rename git_config_maybe_bool_text and export it as git_parse_maybe_bool
 + transport: remove git_transport_options.push_cert
 + gitremote-helpers.txt: document pushcert option
 + Documentation/git-send-pack.txt: document --signed
 + Documentation/git-send-pack.txt: wrap long synopsis line
 + Documentation/git-push.txt: document when --signed may fail

 The client side codepaths in "git push" have been cleaned up
 and the user can request to perform an optional "signed push",
 i.e. sign only when the other end accepts signed push.

 Will merge to 'master'.


* dk/gc-idx-wo-pack (2015-08-17) 3 commits
 - DONTMERGE: log message, grace-period and tests $gmane/276058
 - gc: remove stale .idx files without corresponding .pack file
 - prepare_packed_git(): refactor garbage reporting in pack directory

 Having a leftover .idx file without correspoinding .pack file in
 the repository hurts performance; "git gc" learned to prune them.

 Waiting for a reroll.


* bb/remote-get-url (2015-08-05) 1 commit
 - remote: add get-url subcommand

 "git remote" learned "get-url" subcommand to show the URL for a
 given remote name used for fetching and pushing.

 Waiting for a reroll.
 ($gmane/275401)


* jk/notes-merge-config (2015-08-17) 6 commits
  (merged to 'next' on 2015-08-26 at 6dd2286)
 + notes: teach git-notes about notes.<name>.mergeStrategy option
 + notes: add notes.mergeStrategy option to select default strategy
 + notes: add tests for --commit/--abort/--strategy exclusivity
 + notes: extract parse_notes_merge_strategy to notes-utils
 + notes: extract enum notes_merge_strategy to notes-utils.h
 + notes: document cat_sort_uniq rewriteMode

 "git notes merge" can be told with "--strategy=<how>" option how to
 automatically handle conflicts; this can now be configured by
 setting notes.merge configuration variable.

 Will merge to 'master'.


* hv/submodule-config (2015-08-19) 4 commits
  (merged to 'next' on 2015-08-25 at 82adb30)
 + submodule: allow erroneous values for the fetchRecurseSubmodules option
 + submodule: use new config API for worktree configurations
 + submodule: extract functions for config set and lookup
 + submodule: implement a config API for lookup of .gitmodules values
 (this branch is used by sb/submodule-helper.)

 The gitmodules API accessed from the C code learned to cache stuff
 lazily.

 Will merge to 'master'.


* sb/submodule-helper (2015-08-26) 6 commits
 - submodule: helper to run foreach in parallel
 - thread-utils: add a threaded task queue
 - submodule: implement `module_clone` as a builtin helper
 - submodule: implement `module_name` as a builtin helper
 - submodule: implement `module_list` as a builtin helper
 - Merge 'hv/submodule-config' to 'sb/submodule-helper'
 (this branch uses hv/submodule-config.)

 The infrastructure to rewrite "git submodule" in C is being built
 incrementally.  These early part looks promising.


* ad/cygwin-wants-rename (2015-08-07) 1 commit
 - config.mak.uname: Cygwin needs OBJECT_CREATION_USES_RENAMES

 Will hold.
 ($gmane/275680).


* sg/config-name-only (2015-08-20) 6 commits
  (merged to 'next' on 2015-08-25 at 6cb3b7d)
 + get_urlmatch: avoid useless strbuf write
 + format_config: simplify buffer handling
 + format_config: don't init strbuf
 + config: restructure format_config() for better control flow
  (merged to 'next' on 2015-08-12 at c658fe4)
 + completion: list variable names reliably with 'git config --name-only'
 + config: add '--name-only' option to list only variable names

 "git config --list" output was hard to parse when values consist of
 multiple lines.  "--name-only" option is added to help this.

 Will merge to 'master'.


* kn/for-each-tag-branch (2015-08-03) 11 commits
  (merged to 'next' on 2015-08-03 at d9e94b9)
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
 (this branch is used by kn/for-each-tag.)

 Originally merged to 'next' on 2015-07-15

 Some features from "git tag -l" and "git branch -l" have been made
 available to "git for-each-ref" so that eventually the unified
 implementation can be shared across all three, in a follow-up
 series or two.


* jc/rerere (2015-07-24) 21 commits
  (merged to 'next' on 2015-08-26 at 8ae15ef)
 + rerere: un-nest merge() further
 + rerere: use "struct rerere_id" instead of "char *" for conflict ID
 + rerere: call conflict-ids IDs
 + rerere: further clarify do_rerere_one_path()
 + rerere: further de-dent do_plain_rerere()
 + rerere: refactor "replay" part of do_plain_rerere()
 + rerere: explain the remainder
 + rerere: explain "rerere forget" codepath
 + rerere: explain the primary codepath
 + rerere: explain MERGE_RR management helpers
 + rerere: fix benign off-by-one non-bug and clarify code
 + rerere: explain the rerere I/O abstraction
 + rerere: do not leak mmfile[] for a path with multiple stage #1 entries
 + rerere: stop looping unnecessarily
 + rerere: drop want_sp parameter from is_cmarker()
 + rerere: report autoupdated paths only after actually updating them
 + rerere: write out each record of MERGE_RR in one go
 + rerere: lift PATH_MAX limitation
 + rerere: plug conflict ID leaks
 + rerere: handle conflicts with multiple stage #1 entries
 + rerere: fix an off-by-one non-bug
 (this branch is used by jc/rerere-multi.)

 Code clean-up and minor fixes.

 Will merge to 'master'.


* jc/rerere-multi (2015-07-30) 7 commits
 . t4200: rerere a merge with two identical conflicts
 . WIP
 . rerere: allow multiple variants to exist
 - rerere: delay the recording of preimage
 - rerere: handle leftover rr-cache/$ID directory and postimage files
 - rerere: scan $GIT_DIR/rr-cache/$ID when instantiating a rerere_id
 - rerere: split conflict ID further
 (this branch uses jc/rerere.)

 "git rerere" can encounter two or more files with the same conflict
 signature that have to be resolved in different ways, but there was
 no way to record these separate resolutions.


* jc/merge-drop-old-syntax (2015-04-29) 1 commit
  (merged to 'next' on 2015-08-03 at a52c2b2)
 + merge: drop 'git merge <message> HEAD <commit>' syntax

 Originally merged to 'next' on 2015-05-28

 Stop supporting "git merge <message> HEAD <commit>" syntax that
 has been deprecated since October 2007.

 Will keep in 'next' during the 2.6 cycle.
