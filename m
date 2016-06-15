From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Mar 2013, #07; Tue, 26)
Date: Tue, 26 Mar 2013 15:40:00 -0700
Message-ID: <7v620dss3j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 26 23:40:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKcXm-0004VB-OM
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 23:40:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752573Ab3CZWkI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 18:40:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56349 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752351Ab3CZWkF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 18:40:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A57E7A31F;
	Tue, 26 Mar 2013 18:40:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=n
	oJ5ZSS6qtqxPi+yUlsHzpkmATM=; b=NCe8H5Nbr1o0fS/z3/JUGaEMyEWGMgYsj
	CuQv/yqFjoCr6eJ1/mapHiwgfUDpmpJgXeY+Ds0JxKnjuR70ErkrQhv49MZje6SE
	OxNJn8O7mpohOt8E5asingDZw5wrJYQ7FuaGAyHTK30WSTDtmUOHhhmN/S0Lsoiw
	jgo07WmAV4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=BOz
	mbIaV5sAroBY6sLDYDchke9v0KfOOSwNLzDtbJM6qO7iJ52yePh32ULJcQta9Kn1
	yDXAq1Lecg5kuqjjZDINtro+q40YH6GS4M/JzkzpwOlDaJJvE+hn9W0K5+54spxJ
	OKhzzQz/cq8lcbCsobk10QnkMEVoSRV+jYbEUbBg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 96866A31E;
	Tue, 26 Mar 2013 18:40:04 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A6422A31B; Tue, 26 Mar 2013
 18:40:02 -0400 (EDT)
X-master-at: 2bba2f0e6542d541e9f27653d8c9d5fc8d0e679c
X-next-at: 21b325ca9d683712f5399553f0472ba31ad5cf0f
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 191FFE24-9666-11E2-9F12-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219227>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ap/maint-diff-rename-avoid-overlap (2013-03-06) 3 commits
  (merged to 'next' on 2013-03-19 at c3276cf)
 + tests: make sure rename pretty print works
 + diff: prevent pprint_rename from underrunning input
 + diff: Fix rename pretty-print when suffix and prefix overlap

 Originally merged to 'next' on 2013-03-06

 The logic used by "git diff -M --stat" to shorten the names of
 files before and after a rename did not work correctly when the
 common prefix and suffix between the two filenames overlapped.


* jc/describe (2013-02-28) 1 commit
  (merged to 'next' on 2013-03-19 at 89e6e47)
 + describe: --match=<pattern> must limit the refs even when used with --all

 Originally merged to 'next' on 2013-03-05

 The "--match=<pattern>" option of "git describe", when used with
 "--all" to allow refs that are not annotated tags to be used as a
 base of description, did not restrict the output from the command
 to those that match the given pattern.

 We may want to have a looser matching that does not restrict to tags,
 but that can be done as a follow-up topic; this step is purely a bugfix.


* jc/maint-reflog-expire-clean-mark-typofix (2013-03-05) 1 commit
  (merged to 'next' on 2013-03-19 at a4f9eac)
 + reflog: fix typo in "reflog expire" clean-up codepath

 Originally merged to 'next' on 2013-03-07

 In "git reflog expire", REACHABLE bit was not cleared from the
 correct objects.


* jc/push-follow-tag (2013-03-05) 4 commits
  (merged to 'next' on 2013-03-19 at d302a10)
 + push: --follow-tags
 + commit.c: use clear_commit_marks_many() in in_merge_bases_many()
 + commit.c: add in_merge_bases_many()
 + commit.c: add clear_commit_marks_many()

 Originally merged to 'next' on 2013-03-09

 The new "--follow-tags" option tells "git push" to push relevant
 annotated tags when pushing branches out.


* jc/reflog-reverse-walk (2013-03-23) 4 commits
  (merged to 'next' on 2013-03-25 at 1bcc1c4)
 + refs.c: fix fread error handling
  (merged to 'next' on 2013-03-19 at 25beb2a)
 + reflog: add for_each_reflog_ent_reverse() API
 + for_each_recent_reflog_ent(): simplify opening of a reflog file
 + for_each_reflog_ent(): extract a helper to process a single entry
 (this branch is tangled with nd/branch-show-rebase-bisect-state.)

 An internal function used to implement "git checkout @{-1}" was
 hard to use correctly.


* jk/alias-in-bare (2013-03-08) 3 commits
  (merged to 'next' on 2013-03-19 at d2b4227)
 + setup: suppress implicit "." work-tree for bare repos
 + environment: add GIT_PREFIX to local_repo_env
 + cache.h: drop LOCAL_REPO_ENV_SIZE

 Originally merged to 'next' on 2013-03-09

 An aliased command spawned from a bare repository that does not say
 it is bare with "core.bare = yes" is treated as non-bare by mistake.


* jk/empty-archive (2013-03-10) 2 commits
  (merged to 'next' on 2013-03-19 at bb4eb61)
 + archive: handle commits with an empty tree
 + test-lib: factor out $GIT_UNZIP setup

 Originally merged to 'next' on 2013-03-12

 "git archive" reports a failure when asked to create an archive out
 of an empty tree.  It would be more intuitive to give an empty
 archive back in such a case.


* jk/fast-export-object-lookup (2013-03-17) 2 commits
  (merged to 'next' on 2013-03-19 at 026ac3d)
 + fast-export: do not load blob objects twice
 + fast-export: rename handle_object function

 Originally merged to 'next' on 2013-03-18


* jk/fully-peeled-packed-ref (2013-03-18) 4 commits
  (merged to 'next' on 2013-03-19 at fa92bc7)
 + pack-refs: add fully-peeled trait
 + pack-refs: write peeled entry for non-tags
 + use parse_object_or_die instead of die("bad object")
 + avoid segfaults on parse_object failure

 Originally merged to 'next' on 2013-03-18

 Not that we do not actively encourage having annotated tags outside
 refs/tags/ hierarchy, but they were not advertised correctly to the
 ls-remote and fetch with recent version of Git.


* jk/peel-ref (2013-03-16) 3 commits
  (merged to 'next' on 2013-03-19 at f0d4c16)
 + upload-pack: load non-tip "want" objects from disk
 + upload-pack: make sure "want" objects are parsed
 + upload-pack: drop lookup-before-parse optimization

 Originally merged to 'next' on 2013-03-18

 Recent optimization broke shallow clones.


* jk/suppress-clang-warning (2013-02-25) 1 commit
  (merged to 'next' on 2013-03-19 at 1fd6858)
 + fix clang -Wtautological-compare with unsigned enum

 Originally merged to 'next' on 2013-03-14


* jl/submodule-deinit (2013-03-04) 1 commit
  (merged to 'next' on 2013-03-19 at d8367c5)
 + submodule: add 'deinit' command

 Originally merged to 'next' on 2013-03-05

 There was no Porcelain way to say "I no longer am interested in
 this submodule", once you express your interest in a submodule with
 "submodule init".  "submodule deinit" is the way to do so.


* kb/p4merge (2013-03-25) 6 commits
  (merged to 'next' on 2013-03-25 at 4db939e)
 + merge-one-file: force content conflict for "both sides added" case
 + git-merge-one-file: send "ERROR:" messages to stderr
 + git-merge-one-file: style cleanup
 + merge-one-file: remove stale comment
  (merged to 'next' on 2013-03-19 at 43cc599)
 + mergetools/p4merge: create a base if none available
 + mergetools/p4merge: swap LOCAL and REMOTE

 Originally merged to 'next' on 2013-03-14

 Adjust the order mergetools feeds the files to the p4merge backend
 to match the p4 convention.


* ks/rfc2047-one-char-at-a-time (2013-03-09) 1 commit
  (merged to 'next' on 2013-03-19 at 577ddf2)
 + format-patch: RFC 2047 says multi-octet character may not be split

 Originally merged to 'next' on 2013-03-09

 When "format-patch" quoted a non-ascii strings on the header files,
 it incorrectly applied rfc2047 and chopped a single character in
 the middle of it.


* lf/setup-prefix-pathspec (2013-03-14) 2 commits
  (merged to 'next' on 2013-03-19 at 0017e9e)
 + setup.c: check that the pathspec magic ends with ")"
 + setup.c: stop prefix_pathspec() from looping past the end of string

 Originally merged to 'next' on 2013-03-14

 "git cmd -- ':(top'" was not diagnosed as an invalid syntax, and
 instead the parser kept reading beyond the end of the string.


* mg/unsigned-time-t (2013-02-25) 2 commits
  (merged to 'next' on 2013-03-19 at 1fc1ad6)
 + Fix time offset calculation in case of unsigned time_t
 + date.c: fix unsigned time_t comparison

 Originally merged to 'next' on 2013-03-14

 A few workarounds for systems with unsigned time_t.


* pe/pull-rebase-v-q (2013-03-16) 1 commit
  (merged to 'next' on 2013-03-19 at 10b311c)
 + pull: Apply -q and -v options to rebase mode as well

 Originally merged to 'next' on 2013-03-18

 Teach "git pull --rebase" to pass "-v/-q" command line options to
 underlying "git rebase".


* ph/tag-force-no-warn-on-creation (2013-03-13) 1 commit
  (merged to 'next' on 2013-03-19 at b273fd3)
 + tag: --force does not have to warn when creating tags

 Originally merged to 'next' on 2013-03-14

 "git tag -f <tag>" always said "Updated tag '<tag>'" even when
 creating a new tag (i.e. not overwriting nor updating).


* pw/p4-symlinked-root (2013-03-11) 3 commits
  (merged to 'next' on 2013-03-19 at 9127e82)
 + git p4: avoid expanding client paths in chdir
 + git p4 test: should honor symlink in p4 client root
 + git p4 test: make sure P4CONFIG relative path works

 Originally merged to 'next' on 2013-03-12

 "git p4" did not behave well when the path to the root of the P4
 client was not its real path.

--------------------------------------------------
[New Topics]

* jc/apply-ws-fix-tab-in-indent (2013-03-22) 1 commit
 - apply --whitespace=fix: avoid running over the postimage buffer


* jk/no-more-self-assignment (2013-03-25) 2 commits
  (merged to 'next' on 2013-03-26 at 31ec9ac)
 + match-trees: simplify score_trees() using tree_entry()
 + submodule: clarify logic in show_submodule_summary

 This started as a topic to reduce "type var = var" self assignment
 tricks that were used to squelch "variable used uninitialized perhaps?"
 warning from some compilers, but resulted in rewriting logic with
 a version that is simpler and easier to understand for humans.


* jk/t7800-modernize (2013-03-23) 3 commits
 - t7800: run --dir-diff tests with and without symlinks
 - t7800: fix tests when difftool uses --no-symlinks
 - t7800: don't hide grep output

 Looked reasonable standalone; conflicts with other topics in flight
 needs to be resolved carefully, though.


* kk/revwalk-slop-too-many-commit-within-a-second (2013-03-22) 1 commit
  (merged to 'next' on 2013-03-26 at ea90e75)
 + Fix revision walk for commits with the same dates

 Allow the revision "slop" code to look deeper while commits with
 exactly the same timestamps come next to each other (which can
 often happen after a large "am" and "rebase" session).


* yd/use-test-config-unconfig (2013-03-25) 12 commits
 - t7600: use test_config to set/unset git config variables
 - t7502: remove clear_config
 - t7502: use test_config to set/unset git config variables
 - t9500: use test_config to set/unset git config variables
 - t7508: use test_config to set/unset git config variables
 - t7500: use test_config to set/unset git config variables
 - t5541: use test_config to set/unset git config variables
 - t5520: use test_config to set/unset git config variables
 - t4202: use test_config/test_unconfig to set/unset git config variables
 - t4034: use test_config/test_unconfig to set/unset git config variables
 - t4304: use test_config to set/unset git config variables
 - t3400: use test_config to set/unset git config variables

 Bulk-update of the test suite.


* ap/combine-diff-coalesce-lost (2013-03-25) 1 commit
 - combine-diff: coalesce lost lines optimally
 (this branch uses ap/combine-diff-ignore-whitespace.)

 Attempts to minimize "diff -c/--cc" output by coalescing the same
 lines removed from the parents better, but with an O(n^2)
 complexity.  I wonder


* bk/document-commit-tree-S (2013-03-25) 1 commit
  (merged to 'next' on 2013-03-26 at 8ee205f)
 + commit-tree: document -S option consistently

 Will merge to 'master'.


* jk/check-corrupt-objects-carefully (2013-03-25) 9 commits
 - clone: run check_everything_connected
 - clone: die on errors from unpack_trees
 - add tests for cloning corrupted repositories
 - streaming_write_entry: propagate streaming errors
 - add test for streaming corrupt blobs
 - avoid infinite loop in read_istream_loose
 - read_istream_filtered: propagate read error from upstream
 - check_sha1_signature: check return value from read_istream
 - stream_blob_to_fd: detect errors reading from stream

 Have the streaming interface and other codepaths more carefully
 examine for corrupt objects.


* js/iterm-is-on-osx (2013-03-25) 1 commit
 - git-web--browse: recognize iTerm as a GUI terminal on OS X

 Add more logic to detect graphic environment of OS X.


* tb/cygwin-shared-repository (2013-03-25) 2 commits
 - optimize set_shared_perm()
 - Make core.sharedRepository work under cygwin 1.7

 Cygwin port has a faster-but-lying lstat(2) emulation whose
 incorrectness does not matter in practice except for a few
 codepaths, and setting permission bits to directories is a codepath
 that needs to use a more correct one.


* jc/directory-attrs-regression-fix (2013-03-26) 4 commits
 - make sure a pattern without trailing slash matches a directory
 - attr.c::path_matches(): special case paths that end with a slash
 - dir.c::match_basename(): pay attention to the length of string parameters
 - attr.c::path_matches(): the basename is part of the pathname

 Fix 1.8.1.x regression that stopped matching "dir" (without
 trailing slash) to a directory "dir".


* nd/checkout-paths-reduce-match-pathspec-calls (2013-03-26) 1 commit
 - [NEEDSTEST] checkout: avoid unnecessary match_pathspec calls

--------------------------------------------------
[Stalled]

* jc/format-patch (2013-02-21) 2 commits
 - format-patch: --inline-single
 - format-patch: rename "no_inline" field

 A new option to send a single patch to the standard output to be
 appended at the bottom of a message.  I personally have no need for
 this, but it was easy enough to cobble together.  Tests, docs and
 stripping out more MIMEy stuff are left as exercises to interested
 parties.

 Not ready for inclusion.


* mg/qnx6 (2013-02-25) 1 commit
 - QNX: newer QNX 6.x.x is not so crippled

 Not ready for inclusion.


* po/help-guides (2013-03-03) 5 commits
 - help doc: include --guide option description
 - help.c: add list_common_guides_help() function
 - help.c: add --guide option
 - help.c: use OPT_COUNTUP
 - show 'git help <guide>' usage, with examples

 Give more visibility to "concept guides" to help "git help" users.

 Expecting a reroll.
 $gmane/217384


* hv/config-from-strbuf (2013-03-10) 4 commits
 - teach config parsing to read from strbuf
 - config: make parsing stack struct independent from actual data source
 - config: drop file pointer validity check in get_next_char()
 - config: factor out config file stack management

 Expecting a reroll.
 $gmane/217811


* mb/gitweb-highlight-link-target (2012-12-20) 1 commit
 - Highlight the link target line in Gitweb using CSS

 Expecting a reroll.
 $gmane/211935


* mb/remote-default-nn-origin (2012-07-11) 6 commits
 - Teach get_default_remote to respect remote.default.
 - Test that plain "git fetch" uses remote.default when on a detached HEAD.
 - Teach clone to set remote.default.
 - Teach "git remote" about remote.default.
 - Teach remote.c about the remote.default configuration setting.
 - Rename remote.c's default_remote_name static variables.

 When the user does not specify what remote to interact with, we
 often attempt to use 'origin'.  This can now be customized via a
 configuration variable.

 Expecting a reroll.
 $gmane/210151

 "The first remote becomes the default" bit is better done as a
 separate step.

--------------------------------------------------
[Cooking]

* jc/merge-tag-object (2013-03-19) 1 commit
 - merge: a random object may not necssarily be a commit

 "git merge $(git rev-parse v1.8.2)" behaved quite differently from
 "git merge v1.8.2" as if v1.8.2 were written as v1.8.2^0 and did
 not pay much attention to the annotated tag payload.

 This makes the code notice the type of the tag object, in addition
 to the dwim_ref() based classification the current code uses
 (i.e. the name appears in refs/tags/) to decide when to special
 case merging of tags.

 We may actually want to call the current behaviour a feature,
 though.  After all, the user went to great length to feed something
 different from the normal "v1.8.2" to the command.


* jk/index-pack-correct-depth-fix (2013-03-20) 1 commit
 - index-pack: always zero-initialize object_entry list

 "index-pack --fix-thin" used uninitialize value to compute delta
 depths of objects it appends to the resulting pack.


* jn/push-tests (2013-03-19) 3 commits
 - push test: rely on &&-chaining instead of 'if bad; then echo Oops; fi'
 - push test: simplify check of push result
 - push test: use test_config when appropriate

 Update t5516 with style fixes.


* nd/index-pack-threaded-fixes (2013-03-19) 2 commits
 - index-pack: guard nr_resolved_deltas reads by lock
 - index-pack: protect deepest_delta in multithread code

 "index-pack --verify-stat" used a few counters outside protection
 of mutex, possibly showing incorrect numbers.


* kb/status-ignored-optim (2013-03-19) 8 commits
 - dir.c: git-status: avoid is_excluded checks for tracked files
 - dir.c: replace is_path_excluded with now equivalent is_excluded API
 - dir.c: unify is_excluded and is_path_excluded APIs
 - dir.c: move prep_exclude and factor out parts of last_exclude_matching
 - dir.c: git-status --ignored: don't list empty directories as ignored
 - dir.c: git-status --ignored: don't list empty ignored directories
 - dir.c: git-status --ignored: don't list files in ignored directories
 - dir.c: git-status --ignored: don't drop ignored directories

 "git status --ignored" had many corner case bugs.  Also the command
 has been optimized by taking advantage of the fact that paths that
 are already known to the index do not have to be checked against
 the .gitignore mechanism most of the time.

 Expecting a review from others; this codepath is used not only by
 status but also in add and clean, so a bug in it can result in lost
 data.


* rr/tests-dedup-test-config (2013-03-19) 1 commit
  (merged to 'next' on 2013-03-26 at d314299)
 + t4018,7810,7811: remove test_config() redefinition

 Will merge to 'master'.


* jn/add-2.0-u-A-sans-pathspec (2013-03-20) 5 commits
 - git add: -u/-A now affects the entire working tree
 - add -A: only show pathless 'add -A' warning when changes exist outside cwd
 - add -u: only show pathless 'add -u' warning when changes exist outside cwd
 - add: make warn_pathless_add() a no-op after first call
 - add: make pathless 'add [-u|-A]' warning a file-global function

 Replaces jc/add-2.0-u-A-sans-pathspec topic by not warning against
 "add -u/-A" that is ran without pathspec when there is no change
 outside the current directory.


* rr/test-3200-style (2013-03-20) 1 commit
  (merged to 'next' on 2013-03-26 at 1214287)
 + t3200 (branch): modernize style

 Churns.

 Will merge to 'master'.


* tr/packed-object-info-wo-recursion (2013-03-25) 3 commits
 - sha1_file: remove recursion in unpack_entry
 - Refactor parts of in_delta_base_cache/cache_or_unpack_entry
 - sha1_file: remove recursion in packed_object_info

 Attempts to reduce the stack footprint of sha1_object_info()
 and unpack_entry() codepaths.


* sr/am-show-final-message-in-applying-indicator (2013-03-21) 1 commit
  (merged to 'next' on 2013-03-26 at 9ecb143)
 + git-am: show the final log message on "Applying:" indicator

 In addition to the case where the user edits the log message with
 the "e)dit" option of "am -i", replace the "Applying: this patch"
 message with the final log message contents after applymsg hook
 munges it.

 Will merge to 'master'.


* yd/doc-merge-annotated-tag (2013-03-21) 1 commit
  (merged to 'next' on 2013-03-26 at a11162f)
 + Documentation: merging a tag is a special case

 Document the 1.7.9 feature to merge a signed tag and keep that in
 the mergetag header in the resulting commit better.

 Will merge to 'master'.


* yd/doc-is-in-asciidoc (2013-03-21) 1 commit
  (merged to 'next' on 2013-03-26 at a980af2)
 + CodingGuidelines: our documents are in AsciiDoc

 Will merge to 'master'.


* ap/combine-diff-ignore-whitespace (2013-03-14) 1 commit
  (merged to 'next' on 2013-03-19 at dfb2c98)
 + Allow combined diff to ignore white-spaces
 (this branch is used by ap/combine-diff-coalesce-lost.)

 Originally merged to 'next' on 2013-03-18

 Teach "diff --cc" output to honor options to ignore various forms
 of whitespace changes.

 Will merge to 'master' in the 4th batch (Safe).


* jk/checkout-attribute-lookup (2013-03-20) 3 commits
  (merged to 'next' on 2013-03-20 at 43a89e8)
 + t2003: work around path mangling issue on Windows
  (merged to 'next' on 2013-03-19 at b063a55)
 + entry: fix filter lookup
 + t2003: modernize style

 Codepath to stream blob object contents directly from the object
 store to filesystem did not use the correct path to find conversion
 filters when writing to temporary files.

 Will merge to 'master' in the 4th batch (Safe).


* jk/difftool-dir-diff-edit-fix (2013-03-14) 3 commits
  (merged to 'next' on 2013-03-19 at e68014a)
 + difftool --dir-diff: symlink all files matching the working tree
 + difftool: avoid double slashes in symlink targets
 + git-difftool(1): fix formatting of --symlink description

 Originally merged to 'next' on 2013-03-15

 "git difftool --dir-diff" made symlinks to working tree files when
 preparing a temporary directory structure, so that accidental edits
 of these files in the difftool are reflected back to the working
 tree, but the logic to decide when to do so was not quite right.

 Will merge to 'master' in the 4th batch (Safe).


* nd/magic-pathspecs (2013-03-22) 46 commits
 - fixup
 - Rename field "raw" to "_raw" in struct pathspec
 - pathspec: support :(glob) syntax
 - pathspec: make --literal-pathspecs disable pathspec magic
 - pathspec: support :(literal) syntax for noglob pathspec
 - Kill limit_pathspec_to_literal() as it's only used by parse_pathspec()
 - parse_pathspec: preserve prefix length via PATHSPEC_PREFIX_ORIGIN
 - parse_pathspec: make sure the prefix part is wildcard-free
 - tree-diff: remove the use of pathspec's raw[] in follow-rename codepath
 - Remove match_pathspec() in favor of match_pathspec_depth()
 - Remove init_pathspec() in favor of parse_pathspec()
 - Remove diff_tree_{setup,release}_paths
 - Convert common_prefix() to use struct pathspec
 - Convert add_files_to_cache to take struct pathspec
 - Convert {read,fill}_directory to take struct pathspec
 - Convert refresh_index to take struct pathspec
 - Convert report_path_error to take struct pathspec
 - checkout: convert read_tree_some to take struct pathspec
 - Convert unmerge_cache to take struct pathspec
 - Convert run_add_interactive to use struct pathspec
 - Convert read_cache_preload() to take struct pathspec
 - reset: convert to use parse_pathspec
 - add: convert to use parse_pathspec
 - check-ignore: convert to use parse_pathspec
 - archive: convert to use parse_pathspec
 - ls-files: convert to use parse_pathspec
 - rm: convert to use parse_pathspec
 - checkout: convert to use parse_pathspec
 - rerere: convert to use parse_pathspec
 - status: convert to use parse_pathspec
 - commit: convert to use parse_pathspec
 - clean: convert to use parse_pathspec
 - Guard against new pathspec magic in pathspec matching code
 - parse_pathspec: support prefixing original patterns
 - parse_pathspec: support stripping/checking submodule paths
 - parse_pathspec: support stripping submodule trailing slashes
 - parse_pathspec: a special flag for max_depth feature
 - Convert some get_pathspec() calls to parse_pathspec()
 - parse_pathspec: add PATHSPEC_PREFER_{CWD,FULL}
 - parse_pathspec: save original pathspec for reporting
 - Add parse_pathspec() that converts cmdline args to struct pathspec
 - pathspec: add copy_pathspec
 - pathspec: i18n-ize error strings in pathspec parsing code
 - Move struct pathspec and related functions to pathspec.[ch]
 - clean: remove unused variable "seen"
 - setup.c: check that the pathspec magic ends with ")"

 Migrate the rest of codebase to use "struct pathspec" more.

 Haven't picked up the reroll yet.


* rs/archive-zip-raw-compression (2013-03-16) 1 commit
  (merged to 'next' on 2013-03-19 at 8cc1cb3)
 + archive-zip: use deflateInit2() to ask for raw compressed data

 Originally merged to 'next' on 2013-03-18

 Will merge to 'master' in the 4th batch (Safe).


* sw/safe-create-leading-dir-race (2013-03-17) 2 commits
 - SQUASH???
 - safe_create_leading_directories: fix race that could give a false negative

 Will merge to 'next' after squashing in the fix.


* nd/branch-show-rebase-bisect-state (2013-03-23) 7 commits
 - status, branch: fix the misleading "bisecting" message
 - branch: show more information when HEAD is detached
 - status: show more info than "currently not on any branch"
 - wt-status: move wt_status_get_state() out to wt_status_print()
 - wt-status: split wt_status_state parsing function out
 - wt-status: move strbuf into read_and_strip_branch()
 - Merge branch 'jc/reflog-reverse-walk' into nd/branch-show-rebase-bisect-state

 Will merge to 'next'.


* jc/add-2.0-delete-default (2013-03-08) 3 commits
 - git add <pathspec>... defaults to "-A"
 - git add: start preparing for "git add <pathspec>..." to default to "-A"
 - builtin/add.c: simplify boolean variables

 "git add dir/" updated modified files and added new files, but does
 not notice removed files, which may be "Huh?" to some users.  They
 can of course use "git add -A dir/", but why should they?

 There seemed to be some interest in this topic, so resurrected and
 rebased on top of recent documentation updates to propose a
 possible transition plan.

 Will cook in 'next' until Git 2.0.


* jc/nobody-sets-src-peer-ref (2013-03-04) 1 commit
 - match_push_refs(): nobody sets src->peer_ref anymore

 Dead code removal.

 Even though I think this change is correct, please report
 immediately if you find any unintended side effect.

 Will merge to 'master' in the 4th batch (Risky).


* kb/name-hash (2013-02-27) 1 commit
 - name-hash.c: fix endless loop with core.ignorecase=true

 The code to keep track of what directory names are known to Git on
 platforms with case insensitive filesystems can get confused upon
 a hash collision between these pathnames and looped forever.

 Even though I think this change is correct, please report
 immediately if you find any unintended side effect.

 Will merge to 'master' in the 4th batch (Risky).


* tr/line-log (2013-03-23) 6 commits
 - Speed up log -L... -M
 - log -L: :pattern:file syntax to find by funcname
 - Implement line-history search (git log -L)
 - Export rewrite_parents() for 'log -L'
 - fixup
 - Refactor parse_loc

 Rerolled; collides with nd/magic-pathspecs.


* jk/common-make-variables-export-safety (2013-02-25) 1 commit
 - Makefile: make mandir, htmldir and infodir absolute

 Make the three variables safer to be exported to submakes by
 ensuring that they are full paths so that they can be used as
 installation location.

 Even though I think this change is correct, please report
 immediately if you find any unintended side effect.

 Will merge to 'master' in the 4th batch (Risky).


* jk/pkt-line-cleanup (2013-03-21) 20 commits
 - do not use GIT_TRACE_PACKET=3 in tests
 - remote-curl: always parse incoming refs
 - remote-curl: move ref-parsing code up in file
 - remote-curl: pass buffer straight to get_remote_heads
 - teach get_remote_heads to read from a memory buffer
 - pkt-line: share buffer/descriptor reading implementation
 - pkt-line: provide a LARGE_PACKET_MAX static buffer
 - pkt-line: move LARGE_PACKET_MAX definition from sideband
 - pkt-line: teach packet_read_line to chomp newlines
 - pkt-line: provide a generic reading function with options
 - pkt-line: drop safe_write function
 - pkt-line: move a misplaced comment
 - write_or_die: raise SIGPIPE when we get EPIPE
 - upload-archive: use argv_array to store client arguments
 - upload-archive: do not copy repo name
 - send-pack: prefer prefixcmp over memcmp in receive_status
 - fetch-pack: fix out-of-bounds buffer offset in get_ack
 - upload-pack: remove packet debugging harness
 - upload-pack: do not add duplicate objects to shallow list
 - upload-pack: use get_sha1_hex to parse "shallow" lines

 Cleans up pkt-line API, implementation and its callers to make them
 more robust.  Even though I think this change is correct, please
 report immediately if you find any unintended side effect.

 Will merge to 'master' in the 3rd batch (Risky).


* jc/remove-export-from-config-mak-in (2013-03-05) 3 commits
 - Fix `make install` when configured with autoconf
 - Makefile: do not export mandir/htmldir/infodir
 - config.mak.in: remove unused definitions

 config.mak.in template had an "export" line to cause a few
 common makefile variables to be exported; if they need to be
 expoted for autoconf/configure users, they should also be exported
 for people who write config.mak the same way.  Move the "export" to
 the main Makefile.  Also, stop exporting mandir that used to be
 exported (only) when config.mak.autogen was used.  It would have
 broken installation of manpages (but not other documentation
 formats).

 Even though I think this change is correct, please report
 immediately if you find any unintended side effect.

 Will merge to 'master' in the 4th batch (Risky).


* jc/remove-treesame-parent-in-simplify-merges (2013-01-17) 1 commit
 - simplify-merges: drop merge from irrelevant side branch

 The --simplify-merges logic did not cull irrelevant parents from a
 merge that is otherwise not interesting with respect to the paths
 we are following.

 This touches a fairly core part of the revision traversal
 infrastructure; even though I think this change is correct, please
 report immediately if you find any unintended side effect.

 Will merge to 'master' in the 2nd batch (Risky).


* jc/push-2.0-default-to-simple (2013-03-18) 15 commits
 - advice: Remove unused advice_push_non_ff_default
 - t5570: do not assume the "matching" push is the default
 - t5551: do not assume the "matching" push is the default
 - t5550: do not assume the "matching" push is the default
 - doc: push.default is no longer "matching"
 - push: switch default from "matching" to "simple"
 - t9401: do not assume the "matching" push is the default
 - t9400: do not assume the "matching" push is the default
 - t7406: do not assume the "matching" push is the default
 - t5531: do not assume the "matching" push is the default
 - t5519: do not assume the "matching" push is the default
 - t5517: do not assume the "matching" push is the default
 - t5516: do not assume the "matching" push is the default
 - t5505: do not assume the "matching" push is the default
 - t5404: do not assume the "matching" push is the default

 Will cook in 'next' until Git 2.0.


* bc/append-signed-off-by (2013-02-23) 13 commits
 - git-commit: populate the edit buffer with 2 blank lines before s-o-b
 - Unify appending signoff in format-patch, commit and sequencer
 - format-patch: update append_signoff prototype
 - t4014: more tests about appending s-o-b lines
 - sequencer.c: teach append_signoff to avoid adding a duplicate newline
 - sequencer.c: teach append_signoff how to detect duplicate s-o-b
 - sequencer.c: always separate "(cherry picked from" from commit body
 - sequencer.c: require a conforming footer to be preceded by a blank line
 - sequencer.c: recognize "(cherry picked from ..." as part of s-o-b footer
 - t/t3511: add some tests of 'cherry-pick -s' functionality
 - t/test-lib-functions.sh: allow to specify the tag name to test_commit
 - commit, cherry-pick -s: remove broken support for multiline rfc2822 fields
 - sequencer.c: rework search for start of footer to improve clarity

 Consolidates codepaths that inspect log-message-to-be and decide to
 add a new Signed-off-by line in various commands.  I think there is
 no negative behaviour change in this series, but please report any
 iffy behaviour change immediately if you notice one.

 Will merge to 'master' in the 3rd batch (Risky).

--------------------------------------------------
[Discarded]

* nd/read-directory-recursive-optim (2013-02-17) 1 commit
 . read_directory: avoid invoking exclude machinery on tracked files

 "git status" has been optimized by taking advantage of the fact
 that paths that are already known to the index do not have to be
 checked against the .gitignore mechanism under some conditions.
 Even though I think this change is correct, please report
 immediately if you find any unintended side effect.

 kb/status-ignored-optim may supersede this.


* jc/add-2.0-u-A-sans-pathspec (2013-03-14) 1 commit
 . git add: -u/-A now affects the entire working tree

 "git add -u/-A" without pathspec has traditonally limited its
 operation to the current directory and its subdirectories, but in
 Git 1.8.2 we started encouraging users to be more explicit to
 specify "." when they mean it (and use ":/" to make it affect the
 entire working tree).  With this, we finally change the behaviour
 and make it affect the entire working tree in Git 2.0.


--------------------------------------------------
[Discarded]

* ja/directory-attrs (2013-03-20) 1 commit
 . trailing slash required in .gitattributes

 Now part of jc/directory-attrs-regression-fix.
