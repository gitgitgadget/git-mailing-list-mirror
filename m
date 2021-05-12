Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35AE3C433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 07:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9A4661432
	for <git@archiver.kernel.org>; Wed, 12 May 2021 07:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhELHrM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 03:47:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50279 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhELHrM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 03:47:12 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C90BC7A58;
        Wed, 12 May 2021 03:46:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=Y
        A7oznZ9tR3xcusFNjIVbe+EW3ZDX00axXeJq/lkJDE=; b=EjLf0CdnQeINpj3FH
        c0hb7FKC6H7VUm98LR6LClnWwswe5DOupw2PvdOhLhooJLJANcUeev3WIJf0Gz0L
        JT56ySwcAKgYTZvi2EAbzfJAKqFDCie4rX6ehtwY9+ox0RNftkdyl3PbLnPp7yJH
        Uz3m5qBvzxwV3wRPn84pqaqLiI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 33C8BC7A57;
        Wed, 12 May 2021 03:46:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8B01EC7A56;
        Wed, 12 May 2021 03:46:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (May 2021, #02; Wed, 12)
X-master-at: df6c4f722c94641d5a9ea5496511f7043433abc2
X-next-at: a26e31b5bc8c25bf0f70407da361b41b06153806
Date:   Wed, 12 May 2021 16:46:02 +0900
Message-ID: <xmqqo8dgfl8l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1A2DD7C2-B2F6-11EB-872D-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'seen' (formerly 'pu'---proposed updates) while commits prefixed
with '+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

Copies of the source code to Git live in many repositories, and the
following is a list of the ones I push into or their mirrors.  Some
repositories have only a subset of branches.

With maint, master, next, seen, todo:

	git://git.kernel.org/pub/scm/git/git.git/
	git://repo.or.cz/alt-git.git/
	https://kernel.googlesource.com/pub/scm/git/git/
	https://github.com/git/git/
	https://gitlab.com/git-vcs/git/

With all the integration branches and topics broken out:

	https://github.com/gitster/git/

Even though the preformatted documentation in HTML and man format
are not sources, they are published in these repositories for
convenience (replace "htmldocs" with "manpages" for the manual
pages):

	git://git.kernel.org/pub/scm/git/git-htmldocs.git/
	https://github.com/gitster/git-htmldocs.git/

Release tarballs are available at:

	https://www.kernel.org/pub/software/scm/git/

--------------------------------------------------
[Graduated to 'master']

* ab/doc-lint (2021-04-10) 7 commits
  (merged to 'next' on 2021-04-30 at 285b9c4d64)
 + docs: fix linting issues due to incorrect relative section order
 + doc lint: lint relative section order
 + doc lint: lint and fix missing "GIT" end sections
 + doc lint: fix bugs in, simplify and improve lint script
 + doc lint: Perl "strict" and "warnings" in lint-gitlink.perl
 + Documentation/Makefile: make doc.dep dependencies a variable again
 + Documentation/Makefile: make $(wildcard howto/*.txt) a var

 Dev support.


* ab/pretty-date-format-tests (2021-04-27) 2 commits
  (merged to 'next' on 2021-04-30 at bd2d680c23)
 + pretty tests: give --date/format tests a better description
 + pretty tests: simplify %aI/%cI date format test
 (this branch is used by zh/pretty-date-human.)

 Tweak a few tests for "log --format=..." that show timestamps in
 various formats.


* ab/rebase-no-reschedule-failed-exec (2021-04-10) 2 commits
  (merged to 'next' on 2021-04-30 at 97d56cc674)
 + rebase: don't override --no-reschedule-failed-exec with config
 + rebase tests: camel-case rebase.rescheduleFailedExec consistently

 "git rebase --[no-]reschedule-failed-exec" did not work well with
 its configuration variable, which has been corrected.


* ab/svn-tests-set-e-fix (2021-04-12) 2 commits
  (merged to 'next' on 2021-04-30 at 41f7907187)
 + svn tests: refactor away a "set -e" in test body
 + svn tests: remove legacy re-setup from init-clone test

 Test clean-up.


* ad/cygwin-no-backslashes-in-paths (2021-04-30) 1 commit
  (merged to 'next' on 2021-04-30 at e2cf03a8aa)
 + cygwin: disallow backslashes in file names

 Cygwin pathname handling fix.


* ah/plugleaks (2021-04-28) 12 commits
  (merged to 'next' on 2021-04-30 at ccb3984029)
 + builtin/rm: avoid leaking pathspec and seen
 + builtin/rebase: release git_format_patch_opt too
 + builtin/for-each-ref: free filter and UNLEAK sorting.
 + mailinfo: also free strbuf lists when clearing mailinfo
 + builtin/checkout: clear pending objects after diffing
 + builtin/check-ignore: clear_pathspec before returning
 + builtin/bugreport: don't leak prefixed filename
 + branch: FREE_AND_NULL instead of NULL'ing real_ref
 + bloom: clear each bloom_key after use
 + ls-files: free max_prefix when done
 + wt-status: fix multiple small leaks
 + revision: free remainder of old commit list in limit_list

 Plug various leans reported by LSAN.


* bc/hash-transition-interop-part-1 (2021-04-27) 13 commits
  (merged to 'next' on 2021-05-03 at 19dba33d17)
 + hex: print objects using the hash algorithm member
 + hex: default to the_hash_algo on zero algorithm value
 + builtin/pack-objects: avoid using struct object_id for pack hash
 + commit-graph: don't store file hashes as struct object_id
 + builtin/show-index: set the algorithm for object IDs
 + hash: provide per-algorithm null OIDs
 + hash: set, copy, and use algo field in struct object_id
 + builtin/pack-redundant: avoid casting buffers to struct object_id
 + Use the final_oid_fn to finalize hashing of object IDs
 + hash: add a function to finalize object IDs
 + http-push: set algorithm when reading object ID
 + Always use oidread to read into struct object_id
 + hash: add an algo member to struct object_id

 SHA-256 transition.


* dl/complete-stash (2021-03-24) 3 commits
  (merged to 'next' on 2021-03-24 at ce573a99cc)
 + git-completion.bash: use __gitcomp_builtin() in _git_stash()
 + git-completion.bash: extract from else in _git_stash()
 + git-completion.bash: pass $__git_subcommand_idx from __git_main()
 (this branch is used by dl/complete-stash-updates.)

 The command line completion (in contrib/) for "git stash" has been
 updated.


* dl/complete-stash-updates (2021-04-27) 4 commits
  (merged to 'next' on 2021-05-03 at 8901a9c431)
 + git-completion.bash: consolidate cases in _git_stash()
 + git-completion.bash: use $__git_cmd_idx in more places
 + git-completion.bash: rename to $__git_cmd_idx
 + git-completion.bash: separate some commands onto their own line
 (this branch uses dl/complete-stash.)

 Further update the command line completion (in contrib/) for "git
 stash".


* hn/trace-reflog-expiry (2021-04-27) 1 commit
  (merged to 'next' on 2021-04-30 at 6bc9a79b61)
 + refs/debug: trace into reflog expiry too

 The reflog expiry machinery has been taught to emit trace events.


* jc/test-allows-local (2021-05-03) 1 commit
  (merged to 'next' on 2021-05-04 at 768071c554)
 + CodingGuidelines: explicitly allow "local" for test scripts

 Document that our test can use "local" keyword.


* jk/doc-format-patch-skips-merges (2021-05-03) 1 commit
  (merged to 'next' on 2021-05-04 at cac68f7193)
 + docs/format-patch: mention handling of merges

 Document that "format-patch" skips merges.


* jk/pack-objects-negative-options-fix (2021-05-03) 5 commits
  (merged to 'next' on 2021-05-04 at 4a61f68cf0)
 + pack-objects: clamp negative depth to 0
 + t5316: check behavior of pack-objects --depth=0
 + pack-objects: clamp negative window size to 0
 + t5300: check that we produced expected number of deltas
 + t5300: modernize basic tests

 Options to "git pack-objects" that take numeric values like
 --window and --depth should not accept negative values; the input
 validation has been tightened.


* jk/prune-with-bitmap-fix (2021-04-29) 2 commits
  (merged to 'next' on 2021-04-30 at bede558f31)
 + prune: save reachable-from-recent objects with bitmaps
 + pack-bitmap: clean up include_check after use

 When the reachability bitmap is in effect, the "do not lose
 recently created objects and those that are reachable from them"
 safety to protect us from races were disabled by mistake, which has
 been corrected.


* jk/symlinked-dotgitx-cleanup (2021-05-04) 9 commits
  (merged to 'next' on 2021-05-04 at deca6ca662)
 + docs: document symlink restrictions for dot-files
 + fsck: warn about symlinked dotfiles we'll open with O_NOFOLLOW
 + t0060: test ntfs/hfs-obscured dotfiles
 + t7450: test .gitmodules symlink matching against obscured names
 + t7450: test verify_path() handling of gitmodules
 + t7415: rename to expand scope
 + fsck_tree(): wrap some long lines
 + fsck_tree(): fix shadowed variable
 + t7415: remove out-dated comment about translation

 Various test and documentation updates about .gitsomething paths
 that are symlinks.


* js/merge-already-up-to-date-message-reword (2021-05-03) 2 commits
  (merged to 'next' on 2021-05-04 at b2e696ecd7)
 + merge: fix swapped "up to date" message components
 + merge(s): apply consistent punctuation to "up to date" messages

 A few variants of informational message "Already up-to-date" has
 been rephrased.


* jz/apply-3way-first-message-fix (2021-04-29) 1 commit
  (merged to 'next' on 2021-04-30 at 829167e135)
 + apply: adjust messages to account for --3way changes

 When we swapped the order of --3way fallback, we forgot to adjust
 the message we give when the first method fails and the second
 method is attempted (which used to be "direct application failed
 hence we try 3way", now it is the other way around).


* ll/clone-reject-shallow (2021-05-05) 1 commit
  (merged to 'next' on 2021-05-06 at 4a165ffc96)
 + t5601: mark protocol v2-only test

 Fix tests when forced to use v0 protocol.


* ls/subtree (2021-04-28) 30 commits
  (merged to 'next' on 2021-05-03 at 12c5fe8677)
 + subtree: be stricter about validating flags
 + subtree: push: allow specifying a local rev other than HEAD
 + subtree: allow 'split' flags to be passed to 'push'
 + subtree: allow --squash to be used with --rejoin
 + subtree: give the docs a once-over
 + subtree: have $indent actually affect indentation
 + subtree: don't let debug and progress output clash
 + subtree: add comments and sanity checks
 + subtree: remove duplicate check
 + subtree: parse revs in individual cmd_ functions
 + subtree: use "^{commit}" instead of "^0"
 + subtree: don't fuss with PATH
 + subtree: use "$*" instead of "$@" as appropriate
 + subtree: use more explicit variable names for cmdline args
 + subtree: use git-sh-setup's `say`
 + subtree: use `git merge-base --is-ancestor`
 + subtree: drop support for git < 1.7
 + subtree: more consistent error propagation
 + subtree: don't have loose code outside of a function
 + subtree: t7900: add porcelain tests for 'pull' and 'push'
 + subtree: t7900: add a test for the -h flag
 + subtree: t7900: rename last_commit_message to last_commit_subject
 + subtree: t7900: fix 'verify one file change per commit'
 + subtree: t7900: delete some dead code
 + subtree: t7900: use 'test' for string equality
 + subtree: t7900: comment subtree_test_create_repo
 + subtree: t7900: use consistent formatting
 + subtree: t7900: use test-lib.sh's test_count
 + subtree: t7900: update for having the default branch name be 'main'
 + .gitignore: ignore 'git-subtree' as a build artifact

 "git subtree" updates.


* mt/add-rm-in-sparse-checkout (2021-04-08) 7 commits
  (merged to 'next' on 2021-04-30 at ddead90eaf)
 + rm: honor sparse checkout patterns
 + add: warn when asked to update SKIP_WORKTREE entries
 + refresh_index(): add flag to ignore SKIP_WORKTREE entries
 + pathspec: allow to ignore SKIP_WORKTREE entries on index matching
 + add: make --chmod and --renormalize honor sparse checkouts
 + t3705: add tests for `git add` in sparse checkouts
 + add: include magic part of pathspec on --refresh error
 (this branch is used by ds/status-with-sparse-index.)

 "git add" and "git rm" learned not to touch those paths that are
 outside of sparse checkout.


* nc/submodule-update-quiet (2021-05-03) 1 commit
  (merged to 'next' on 2021-05-04 at 09bed89b60)
 + submodule update: silence underlying fetch with "--quiet"

 "git submodule update --quiet" did not propagate the quiet option
 down to underlying "git fetch", which has been corrected.


* po/diff-patch-doc (2021-04-28) 1 commit
  (merged to 'next' on 2021-04-30 at 58af0f4b5e)
 + doc: point to diff attribute in patch format docs

 Doc update.


* ps/config-env-option-with-separate-value (2021-04-30) 2 commits
  (merged to 'next' on 2021-04-30 at 46fbcd08c1)
 + git: support separate arg for `--config-env`'s value
 + git.txt: fix synopsis of `--config-env` missing the equals sign

 "git --config-env var=val cmd" weren't accepted (only
 --config-env=var=val was).


* ps/config-global-override (2021-04-27) 4 commits
  (merged to 'next' on 2021-04-30 at 5ce435d98f)
 + t1300: fix unset of GIT_CONFIG_NOSYSTEM leaking into subsequent tests
  (merged to 'next' on 2021-04-20 at 82578c696d)
 + config: allow overriding of global and system configuration
 + config: unify code paths to get global config paths
 + config: rename `git_etc_config()`

 Replace GIT_CONFIG_NOSYSTEM mechanism to decline from reading the
 system-wide configuration file with GIT_CONFIG_SYSTEM that lets
 users specify from which file to read the system-wide configuration
 (setting it to an empty file would essentially be the same as
 setting NOSYSTEM), and introduce GIT_CONFIG_GLOBAL to override the
 per-user configuration in $HOME/.gitconfig.


* ps/rev-list-object-type-filter (2021-04-19) 8 commits
  (merged to 'next' on 2021-04-30 at fa0ceacde4)
 + rev-list: allow filtering of provided items
 + pack-bitmap: implement combined filter
 + pack-bitmap: implement object type filter
 + list-objects: implement object type filter
 + list-objects: support filtering by tag and commit
 + list-objects: move tag processing into its own function
 + revision: mark commit parents as NOT_USER_GIVEN
 + uploadpack.txt: document implication of `uploadpackfilter.allow`

 "git rev-list" learns the "--filter=object:type=<type>" option,
 which can be used to exclude objects of the given kind from the
 packfile generated by pack-objects.


* rj/bisect-skip-honor-terms (2021-04-30) 1 commit
  (merged to 'next' on 2021-05-04 at f7c11bba06)
 + bisect--helper: use BISECT_TERMS in 'bisect skip' command

 "git bisect skip" when custom words are used for new/old did not
 work, which has been corrected.


* rs/repack-without-loosening-promised-objects (2021-04-28) 1 commit
  (merged to 'next' on 2021-05-03 at 6681b49209)
 + repack: avoid loosening promisor objects in partial clones

 "git repack -A -d" in a partial clone unnecessarily loosened
 objects in promisor pack.


* si/zsh-complete-comment-fix (2021-05-04) 1 commit
  (merged to 'next' on 2021-05-04 at a15c1ea590)
 + work around zsh comment in __git_complete_worktree_paths

 Portability fix for command line completion script (in contrib/).


* zh/format-ref-array-optim (2021-04-20) 2 commits
  (merged to 'next' on 2021-04-30 at b6c835cc51)
 + ref-filter: reuse output buffer
 + ref-filter: get rid of show_ref_array_item

 "git (branch|tag) --format=..." has been micro-optimized.


* zh/pretty-date-human (2021-04-27) 1 commit
  (merged to 'next' on 2021-04-30 at 2320ad8fb0)
 + pretty: provide human date format
 (this branch uses ab/pretty-date-format-tests.)

 "git log --format=..." placeholders learned %ah/%ch placeholders to
 request the --date=human output.


* zh/trailer-cmd (2021-05-04) 2 commits
  (merged to 'next' on 2021-05-04 at fb677877f7)
 + trailer: add new .cmd config option
 + docs: correct descript of trailer.<token>.command

 The way the command line specified by the trailer.<token>.command
 configuration variable receives the end-user supplied value was
 both error prone and misleading.  An alternative to achieve the
 same goal in a safer and more intuitive way has been added, as
 the trailer.<token>.cmd configuration variable, to replace it.

--------------------------------------------------
[New Topics]

* mt/clean-clean (2021-05-07) 1 commit
  (merged to 'next' on 2021-05-07 at 51e40b7ddd)
 + clean: remove unnecessary variable

 Code clean-up.

 Will merge to 'master'.


* ah/merge-ort-i18n (2021-05-11) 1 commit
  (merged to 'next' on 2021-05-12 at bda497af01)
 + merge-ort: split "distinct types" message into two translatable messages

 An i18n fix.

 Will merge to 'master'.


* en/dir-traversal (2021-05-12) 8 commits
 - dir: update stale description of treat_directory()
 - dir: traverse into untracked directories if they may have ignored subfiles
 - dir: avoid unnecessary traversal into ignored directory
 - t3001, t7300: add testcase showcasing missed directory traversal
 - t7300: add testcase showing unnecessary traversal into ignored directory
 - ls-files: error out on -i unless -o or -c are specified
 - dir: report number of visited directories and paths with trace2
 - dir: convert trace calls to trace2 equivalents

 "git clean" and "git ls-files -i" had confusion around working on
 or showing ignored paths inside an ignored directory, which has
 been corrected.

 Will merge to 'next'?


* ma/typofixes (2021-05-10) 2 commits
  (merged to 'next' on 2021-05-12 at 99cc0d265e)
 + pretty-formats.txt: add missing space
 + git-repack.txt: remove spurious ")"

 A couple of trivial typofixes.

 Will merge to 'master'.


* zh/ref-filter-push-remote-fix (2021-05-12) 1 commit
 - ref-filter: fix read invalid union member bug

 The handling of "%(push)" formatting element of "for-each-ref" and
 friends was broken when the same codepath started handling
 "%(push:<what>)", which has been corrected.

 Will merge to 'next'?


* lh/maintenance-leakfix (2021-05-12) 1 commit
 - maintenance: fix two memory leaks

 Will merge to 'next'.


* so/log-m-implies-p (2021-05-11) 7 commits
 - diff-merges: let -m imply -p
 - diff-merges: rename "combined_imply_patch" to "merges_imply_patch"
 - stash list: stop passing "-m" to "git list"
 - git-svn: stop passing "-m" to "git rev-list"
 - t4062: diff-index -S can take its string as a separate arg
 - diff-merges: move specific diff-index "-m" handling to diff-index
 - t4013: add test for "git diff-index -m"

 The "-m" option in "git log -m" that does not specify which format,
 if any, of diff is desired did not have any visible effect; it now
 implies some form of diff (by default "--patch") is produced.

 Expecting a reroll.
 cf. <871radwfl7.fsf@osv.gnss.ru>


* wc/packed-ref-removal-cleanup (2021-05-11) 1 commit
 - refs: cleanup directories when deleting packed ref

 When "git update-ref -d" removes a ref that is packed, it left
 empty directories under $GIT_DIR/refs/ for 

 Will merge to 'next'.


* ew/sha256-clone-remote-curl-fix (2021-05-12) 1 commit
 - remote-curl: fix clone on sha256 repos

 "git clone" from SHA256 repository by Git built with SHA-1 as the
 default hash algorithm over the dumb HTTP protocol did not
 correctly set up the resulting repository, which has been corrected.

 Will merge to 'next'.


* bc/doc-asciidoctor-to-man-wo-xmlto (2021-05-12) 2 commits
 - doc: remove GNU_ROFF option
 - doc: add an option to have Asciidoctor build man pages directly

 An option to render the manual pages via AsciiDoctor bypassing
 xmlto has been introduced.

 Will merge to 'next'?

--------------------------------------------------
[Stalled]

* ag/merge-strategies-in-c (2021-03-17) 15 commits
 - sequencer: use the "octopus" merge strategy without forking
 - sequencer: use the "resolve" strategy without forking
 - merge: use the "octopus" strategy without forking
 - merge: use the "resolve" strategy without forking
 - merge-octopus: rewrite in C
 - merge-recursive: move better_branch_name() to merge.c
 - merge-resolve: rewrite in C
 - merge-one-file: rewrite in C
 - update-index: move add_cacheinfo() to read-cache.c
 - merge-index: add a new way to invoke `git-merge-one-file'
 - merge-index: drop the index
 - merge-index: libify merge_one_path() and merge_all()
 - t6060: add tests for removed files
 - t6060: modify multiple files to expose a possible issue with merge-index
 - t6407: modernise tests

 The resolve and octopus merge strategy backends have been rewritten
 in C.

 Expecting a (hopefully final) reroll.
 cf. <nycvar.QRO.7.76.6.2103241142220.50@tvgsbejvaqbjf.bet>


* tv/p4-fallback-encoding (2021-04-30) 1 commit
 - git-p4: git-p4.fallbackEncoding to specify non UTF-8 charset

 "git p4" learns the fallbackEncoding configuration variable to
 safely accept changeset descriptions that aren't written in UTF-8.


* ds/status-with-sparse-index (2021-04-28) 10 commits
 - fsmonitor: test with sparse index
 - status: use sparse-index throughout
 - status: skip sparse-checkout percentage with sparse-index
 - dir.c: accept a directory as part of cone-mode patterns
 - unpack-trees: stop recursing into sparse directories
 - unpack-trees: compare sparse directories correctly
 - unpack-trees: preserve cache_bottom
 - t1092: add tests for status/add and sparse files
 - Merge branch 'mt/add-rm-in-sparse-checkout' into ds/status-with-sparse-index
 - Merge branch 'ds/sparse-index-protections' into ds/status-with-sparse-index

 "git status" codepath learned to work with sparsely populated index
 without hydrating it fully.

 What's the status of this thing?


* jh/rfc-builtin-fsmonitor (2021-05-04) 24 commits
 - fsmonitor: only enable it in non-bare repositories
 - t7527: test status with untracked-cache and fsmonitor--daemon
 - p7519: add fsmonitor--daemon
 - t7527: create test for fsmonitor--daemon
 - fsmonitor: force update index when fsmonitor token advances
 - fsmonitor--daemon: use a cookie file to sync with file system
 - fsmonitor--daemon:: introduce client delay for testing
 - fsmonitor--daemon: periodically truncate list of modified files
 - fsmonitor--daemon: implement handle_client callback
 - fsmonitor-fs-listen-macos: implement FSEvent listener on MacOS
 - fsmonitor-fs-listen-macos: add macos header files for FSEvent
 - fsmonitor-fs-listen-win32: implement FSMonitor backend on Windows
 - fsmonitor--daemon: create token-based changed path cache
 - fsmonitor--daemon: define token-ids
 - fsmonitor--daemon: add pathname classification
 - fsmonitor--daemon: implement daemon command options
 - fsmonitor-fs-listen-macos: stub in backend for MacOS
 - fsmonitor-fs-listen-win32: stub in backend for Windows
 - fsmonitor--daemon: implement client command options
 - fsmonitor--daemon: add a built-in fsmonitor daemon
 - fsmonitor: introduce `core.useBuiltinFSMonitor` to call the daemon via IPC
 - config: FSMonitor is repository-specific
 - fsmonitor-ipc: create client routines for git-fsmonitor--daemon
 - Merge branch 'jh/simple-ipc' into jh/rfc-builtin-fsmonitor

 An attempt to write and ship with a watchman equivalent tailored
 for our use.


* ab/describe-tests-fix (2021-05-11) 5 commits
 - describe tests: support -C in "check_describe"
 - describe tests: fix nested "test_expect_success" call
 - describe tests: don't rely on err.actual from "check_describe"
 - describe tests: refactor away from glob matching
 - describe tests: improve test for --work-tree & --dirty
 (this branch uses ab/test-lib-updates.)

 Various updates to tests around "git describe"

 Waiting for the base topic to solidify.


* ab/pickaxe-pcre2 (2021-05-11) 22 commits
 - xdiff-interface: replace discard_hunk_line() with a flag
 - xdiff users: use designated initializers for out_line
 - pickaxe -G: don't special-case create/delete
 - pickaxe -G: terminate early on matching lines
 - xdiff-interface: allow early return from xdiff_emit_line_fn
 - xdiff-interface: prepare for allowing early return
 - pickaxe -S: slightly optimize contains()
 - pickaxe: rename variables in has_changes() for brevity
 - pickaxe -S: support content with NULs under --pickaxe-regex
 - pickaxe: assert that we must have a needle under -G or -S
 - pickaxe: refactor function selection in diffcore-pickaxe()
 - perf: add performance test for pickaxe
 - pickaxe/style: consolidate declarations and assignments
 - diff.h: move pickaxe fields together again
 - pickaxe: die when --find-object and --pickaxe-all are combined
 - pickaxe: die when -G and --pickaxe-regex are combined
 - pickaxe tests: add missing test for --no-pickaxe-regex being an error
 - pickaxe tests: test for -G, -S and --find-object incompatibility
 - pickaxe tests: add test for "log -S" not being a regex
 - pickaxe tests: add test for diffgrep_consume() internals
 - pickaxe tests: refactor to use test_commit --append --printf
 - grep/pcre2 tests: reword comments referring to kwset
 (this branch uses ab/test-lib-updates.)

 Rewrite the backend for "diff -G/-S" to use pcre2 engine when
 available.

 Waiting for the base topic to solidify.


* es/config-hooks (2021-03-10) 36 commits
 . run-command: stop thinking about hooks
 . git-send-email: use 'git hook run' for 'sendemail-validate'
 . bugreport: use hook_exists instead of find_hook
 . receive-pack: convert receive hooks to hook.h
 . post-update: use hook.h library
 . proc-receive: acquire hook list from hook.h
 . receive-pack: convert 'update' hook to hook.h
 . reference-transaction: look for hooks in config
 . transport: convert pre-push hook to use config
 . hook: convert 'post-rewrite' hook to config
 . hooks: convert 'post-checkout' hook to hook library
 . git-p4: use 'git hook' to run hooks
 . receive-pack: convert push-to-checkout hook to hook.h
 . read-cache: convert post-index-change hook to use config
 . rebase: teach pre-rebase to use hook.h
 . gc: use hook library for pre-auto-gc hook
 . merge: use config-based hooks for post-merge hook
 . am: convert applypatch hooks to use config
 . commit: use config-based hooks
 . hooks: allow callers to capture output
 . run-command: allow capturing of collated output
 . hook: provide stdin by string_list or callback
 . run-command: add stdin callback for parallelization
 . hook: allow specifying working directory for hooks
 . hook: allow parallel hook execution
 . run-command: allow stdin for run_processes_parallel
 . hook: support passing stdin to hooks
 . hook: introduce hook_exists()
 . hook: add 'run' subcommand
 . parse-options: parse into strvec
 . hook: implement hookcmd.<name>.skip
 . hook: teach hook.runHookDir
 . hook: include hookdir hook in list
 . hook: add list command
 . hook: scaffolding for git-hook subcommand
 . doc: propose hooks managed by the config

 The "hooks defined in config" topic.

--------------------------------------------------
[Cooking]

* ab/trace2-squelch-gcc-warning (2021-05-11) 1 commit
 - trace2: refactor to avoid gcc warning under -O3

 Workaround compiler warnings.

 cf. <YJrIMbr6VkYGQMfs@coredump.intra.peff.net>


* hn/refs-errno-cleanup (2021-04-30) 8 commits
 - refs: explicitly propagate errno from refs_read_raw_ref
 - refs: stop setting EINVAL and ELOOP in symref resolution
 - refs: clear errno return in refs_resolve_ref_unsafe()
 - refs: add failure_errno to refs_read_raw_ref() signature
 - refs: make errno output explicit for refs_resolve_ref_unsafe
 - refs: make errno output explicit for read_raw_ref_fn
 - refs/files-backend: stop setting errno from lock_ref_oid_basic
 - refs: remove EINVAL specification from the errno sideband in read_raw_ref_fn

 Futz with the way 'errno' is relied on in the refs API to carry the
 failure modes up the callchain.

 Waiting for reviews.


* en/ort-perf-batch-11 (2021-05-04) 13 commits
 - merge-ort, diffcore-rename: employ cached renames when possible
 - merge-ort: handle interactions of caching and rename/rename(1to1) cases
 - merge-ort: add helper functions for using cached renames
 - merge-ort: preserve cached renames for the appropriate side
 - merge-ort: avoid accidental API mis-use
 - merge-ort: add code to check for whether cached renames can be reused
 - merge-ort: populate caches of rename detection results
 - merge-ort: add data structures for in-memory caching of rename detection
 - t6429: testcases for remembering renames
 - fast-rebase: write conflict state to working tree, index, and HEAD
 - fast-rebase: change assert() to BUG()
 - Documentation/technical: describe remembering renames optimization
 - t6423: rename file within directory that other side renamed

 Optimize out repeated rename detection in a sequence of mergy
 operations.

 Waiting for reviews.


* dd/mailinfo-quoted-cr (2021-05-10) 6 commits
  (merged to 'next' on 2021-05-12 at a4bcfd18b9)
 + am: learn to process quoted lines that ends with CRLF
 + mailinfo: allow stripping quoted CR without warning
 + mailinfo: allow squelching quoted CRLF warning
 + mailinfo: warn if CRLF found in decoded base64/QP email
 + mailinfo: stop parsing options manually
 + mailinfo: load default metainfo_charset lazily

 "git mailinfo" (hence "git am") learned the "--quoted-cr" option to
 control how lines ending with CRLF wrapped in base64 or qp are
 handled.

 Will merge to 'master'.


* ab/perl-makefile-cleanup (2021-05-06) 4 commits
  (merged to 'next' on 2021-05-10 at 23b48398e6)
 + perl: use mock i18n functions under NO_GETTEXT=Y
 + Makefile: regenerate *.pm on NO_PERL_CPAN_FALLBACKS change
 + Makefile: regenerate perl/build/* if GIT-PERL-DEFINES changes
 + Makefile: don't re-define PERL_DEFINES

 Build procedure clean-up.

 Will merge to 'master'.


* ab/sparse-index-cleanup (2021-05-06) 1 commit
  (merged to 'next' on 2021-05-10 at bbb0239571)
 + sparse-index.c: remove set_index_sparse_config()

 Code clean-up.

 Will merge to 'master'.


* ab/streaming-simplify (2021-05-06) 5 commits
  (merged to 'next' on 2021-05-07 at 0992a78c75)
 + streaming.c: move {open,close,read} from vtable to "struct git_istream"
 + streaming.c: stop passing around "object_info *" to open()
 + streaming.c: remove {open,close,read}_method_decl() macros
 + streaming.c: remove enum/function/vtbl indirection
 + streaming.c: avoid forward declarations

 Code clean-up.

 Will merge to 'master'.


* jk/p4-locate-branch-point-optim (2021-05-06) 2 commits
  (merged to 'next' on 2021-05-07 at 0fa60c3af3)
 + git-p4: speed up search for branch parent
 + git-p4: ensure complex branches are cloned correctly

 "git p4" learned to find branch points more efficiently.

 Will merge to 'master'.


* ow/no-dryrun-in-add-i (2021-05-07) 1 commit
  (merged to 'next' on 2021-05-07 at e822750e3a)
 + add: die if both --dry-run and --interactive are given

 "git add -i --dry-run" does not dry-run, which was surprising.  The
 combination of options has taught to error out.

 Will merge to 'master'.


* pw/patience-diff-clean-up (2021-05-05) 2 commits
  (merged to 'next' on 2021-05-06 at 1ce651569c)
 + patience diff: remove unused variable
 + patience diff: remove unnecessary string comparisons

 Code clean-up.

 Will merge to 'master'.


* pw/word-diff-zero-width-matches (2021-05-05) 1 commit
  (merged to 'next' on 2021-05-06 at e5653da568)
 + word diff: handle zero length matches

 The word-diff mode has been taught to work better with a word
 regexp that can match an empty string.

 Will merge to 'master'.


* ls/fast-export-signed (2021-05-03) 5 commits
 - fast-export, fast-import: add support for signed-commits
 - fast-export: do not modify memory from get_commit_buffer
 - git-fast-export.txt: clarify why 'verbatim' may not be a good idea
 - fast-export: rename --signed-tags='warn' to 'warn-verbatim'
 - git-fast-import.txt: add missing LF in the BNF

 "git fast-export" offers a way to control how signed tags are
 handled; the mechanism has been extended to allow specifying how
 signed commits are handled as well.

 Expecting a reroll.
 cf. <xmqqa6pca0pv.fsf@gitster.g>, <xmqq1rao9zev.fsf@gitster.g>


* mt/parallel-checkout-part-3 (2021-05-05) 8 commits
  (merged to 'next' on 2021-05-07 at 0393d61c0c)
 + ci: run test round with parallel-checkout enabled
 + parallel-checkout: add tests related to .gitattributes
 + t0028: extract encoding helpers to lib-encoding.sh
 + parallel-checkout: add tests related to path collisions
 + parallel-checkout: add tests for basic operations
 + checkout-index: add parallel checkout support
 + builtin/checkout.c: complete parallel checkout support
 + make_transient_cache_entry(): optionally alloc from mem_pool

 The final part of "parallel checkout".

 Will merge to 'master'.


* ba/object-info (2021-04-20) 1 commit
  (merged to 'next' on 2021-05-07 at e2cb0e4ef1)
 + object-info: support for retrieving object info

 Over-the-wire protocol learns a new request type to ask for object
 sizes given a list of object names.

 Will merge to 'master'.


* hn/prep-tests-for-reftable (2021-04-28) 21 commits
 - t1415: set REFFILES for test specific to storage format
 - t4202: mark bogus head hash test with REFFILES
 - t7003: check reflog existence only for REFFILES
 - t7900: mark pack-refs tests as REFFILES
 - t1404: mark tests that muck with .git directly as REFFILES.
 - t2017: mark --orphan/logAllRefUpdates=false test as REFFILES
 - t1414: mark corruption test with REFFILES
 - t1407: require REFFILES for for_each_reflog test
 - test-lib: provide test prereq REFFILES
 - t5304: use "reflog expire --all" to clear the reflog
 - t5304: restyle: trim empty lines, drop ':' before >
 - t7003: use rev-parse rather than FS inspection
 - t5000: inspect HEAD using git-rev-parse
 - t5000: reformat indentation to the latest fashion
 - t1301: fix typo in error message
 - t1413: use tar to save and restore entire .git directory
 - t1401-symbolic-ref: avoid direct filesystem access
 - t5601: read HEAD using rev-parse
 - t9300: check ref existence using test-helper rather than a file system check
 - t/helper/ref-store: initialize oid in resolve-ref
 - t4202: split testcase for invalid HEAD symref and HEAD hash

 Preliminary clean-up of tests before the main reftable changes
 hits the codebase.

 Waiting for reviews.


* jt/push-negotiation (2021-05-05) 6 commits
  (merged to 'next' on 2021-05-06 at 644a1bc4ee)
 + send-pack: support push negotiation
 + fetch: teach independent negotiation (no packfile)
 + fetch-pack: refactor command and capability write
 + fetch-pack: refactor add_haves()
 + fetch-pack: refactor process_acks()
 + Merge branch 'jt/fetch-pack-request-fix' into jt/push-negotiation

 "git push" learns to discover common ancestor with the receiving
 end over protocol v2.

 Will merge to 'master'.


* tb/multi-pack-bitmaps (2021-04-10) 23 commits
 - p5326: perf tests for MIDX bitmaps
 - p5310: extract full and partial bitmap tests
 - midx: respect 'GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP'
 - t7700: update to work with MIDX bitmap test knob
 - t5319: don't write MIDX bitmaps in t5319
 - t5310: disable GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP
 - t5326: test multi-pack bitmap behavior
 - t/helper/test-read-midx.c: add --checksum mode
 - t5310: move some tests to lib-bitmap.sh
 - pack-bitmap: write multi-pack bitmaps
 - pack-bitmap: read multi-pack bitmaps
 - pack-bitmap.c: introduce 'bitmap_is_preferred_refname()'
 - pack-bitmap.c: introduce 'nth_bitmap_object_oid()'
 - pack-bitmap.c: introduce 'bitmap_num_objects()'
 - midx: respect 'core.multiPackIndex' when writing
 - midx: clear auxiliary .rev after replacing the MIDX
 - midx: make a number of functions non-static
 - Documentation: describe MIDX-based bitmaps
 - Documentation: build 'technical/bitmap-format' by default
 - pack-bitmap-write.c: free existing bitmaps
 - pack-bitmap-write.c: gracefully fail to write non-closed bitmaps
 - pack-bitmap.c: harden 'test_bitmap_walk()' to check type bitmaps
 - Merge branch 'tb/pack-preferred-tips-to-give-bitmap' into tb/multi-pack-bitmaps

 The reachability bitmap file used to be generated only for a single
 pack, but now we've learned to generate bitmaps for history that
 span across multiple packfiles.

 Waiting for reviews.
 cf. <cover.1617991824.git.me@ttaylorr.com>


* ab/test-lib-updates (2021-05-11) 11 commits
 - test-lib: split up and deprecate test_create_repo()
 - test-lib: do not show advice about init.defaultBranch under --verbose
 - test-lib: reformat argument list in test_create_repo()
 - submodule tests: use symbolic-ref --short to discover branch name
 - test-lib functions: add --printf option to test_commit
 - describe tests: convert setup to use test_commit
 - test-lib functions: add an --annotated option to "test_commit"
 - test-lib-functions: document test_commit --no-tag
 - test-lib-functions: reword "test_commit --append" docs
 - test-lib tests: remove dead GIT_TEST_FRAMEWORK_SELFTEST variable
 - test-lib: bring $remove_trash out of retirement
 (this branch is used by ab/describe-tests-fix and ab/pickaxe-pcre2.)

 Test clean-up.


* ao/p4-avoid-decoding (2021-04-12) 2 commits
 - git-p4: do not decode data from perforce by default
 - git-p4: avoid decoding more data from perforce

 "git p4" in Python-2 days used to accept a lot more kinds of data
 from Perforce server as uninterrupted byte sequence, but after
 switching to Python-3, too many things are expected to be in UTF-8,
 which broke traditional use cases.

 Waiting for reviews.


* ma/t0091-bugreport-fix (2021-04-12) 1 commit
 - t0091-bugreport.sh: actually verify some content of report

 Test fix.

 Expecting a reroll.
 cf. <YHYZTLl90rkWWVOr@google.com>, <87a6q22dei.fsf@evledraar.gmail.com>


* mr/bisect-in-c-4 (2021-04-11) 4 commits
 - bisect--helper: retire `--bisect-next-check` subcommand
 - bisect--helper: reimplement `bisect_run` shell function in C
 - bisect--helper: reimplement `bisect_visualize()`shell function in C
 - run-command: make `exists_in_PATH()` non-static

 The codepaths involved in running "git bisect visualize" and "git
 bisect run" has been rewritten in C.

 Expecting a reroll.
 cf. <xmqq35vwh8qk.fsf@gitster.g>, <xmqqy2doftrj.fsf@gitster.g>,
 <CAP8UFD3X24F3qgefHpi00PM-KUk+vcqxwy2Dbngbyj7ciavCVQ@mail.gmail.com>
 May want to boost the test coverage.


* hn/reftable (2021-04-20) 28 commits
 - t1404: annotate test cases with REFFILES
 - t1401,t2011: parameterize HEAD.lock for REFTABLE
 - t1301: document what needs to be done for REFTABLE
 - Add "test-tool dump-reftable" command.
 - git-prompt: prepare for reftable refs backend
 - Reftable support for git-core
 - reftable: add dump utility
 - reftable: implement stack, a mutable database of reftable files.
 - reftable: implement refname validation
 - reftable: add merged table view
 - reftable: add a heap-based priority queue for reftable records
 - reftable: reftable file level tests
 - reftable: read reftable files
 - reftable: generic interface to tables
 - reftable: write reftable files
 - reftable: a generic binary tree implementation
 - reftable: reading/writing blocks
 - Provide zlib's uncompress2 from compat/zlib-compat.c
 - reftable: (de)serialization for the polymorphic record type.
 - reftable: add blocksource, an abstraction for random access reads
 - reftable: utility functions
 - reftable: add error related functionality
 - reftable: add LICENSE
 - init-db: set the_repository->hash_algo early on
 - hash.h: provide constants for the hash IDs
 - refs/debug: trace into reflog expiry too
 - refs: document reflog_expire_fn's flag argument
 - refs: ref_iterator_peel returns boolean, rather than peel_status

 The "reftable" backend for the refs API.

 Waiting for reviews.

--------------------------------------------------
[Discarded]

* ab/fsck-unexpected-type (2021-04-13) 6 commits
 . fsck: report invalid object type-path combinations
 . fsck: report invalid types recorded in objects
 . object-store.h: move read_loose_object() below 'struct object_info'
 . fsck: don't hard die on invalid object types
 . fsck tests: refactor one test to use a sub-repo
 . cache.h: move object functions to object-store.h

 "git fsck" has been taught to report mismatch between expected and
 actual types of an object better.

 Retracted for now.
 cf. <cover-0.5-00000000000-20210505T122816Z-avarab@gmail.com>
