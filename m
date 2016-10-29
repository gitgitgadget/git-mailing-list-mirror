Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CE082021E
	for <e@80x24.org>; Sat, 29 Oct 2016 06:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752291AbcJ2GYi (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Oct 2016 02:24:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60065 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750964AbcJ2GYg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2016 02:24:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1CED048DED;
        Sat, 29 Oct 2016 02:24:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=b
        81VUpCkA1RklejFJ5Ggq5bg/+c=; b=Usv731uLEX47VG+KgImV8oE0kmte4YX2+
        Vx+a0LN///4Qb0fqEJDYCqOPZd+DMxuUMcrCmfPOzYCBESW+4Nz4bVf2N49HF8Ja
        0pM5OJjRiPqk7zA3xFKc2TxWAssIzpWdcD6wDqQBMgZObE87pZN8+H7gTQaC5zti
        214mLM16dk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=gOm
        ZhFEbLjkm/InPGuZUxt++4m+/EAfZnybghqbNOejwjrrdyYgpx+MXIHNTDuUavlY
        6s060T0sbOB1sNyKBTlyC08wRA3c0uOy8PKqbLQfW8HfP9R0cPXUXy1zE9I0+7Od
        elNfYDaX2RWYvCvHETG0hY7Gk6cQTVwxnY0kQo8s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1367148DEC;
        Sat, 29 Oct 2016 02:24:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5AC8E48DEA;
        Sat, 29 Oct 2016 02:24:31 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Oct 2016, #08; Fri, 28)
X-master-at: 7805bda2ac68c659b0042f45473723d9fdcece74
X-next-at: 86d95836a33d12ccd9eed86457166d0222f77f17
Date:   Fri, 28 Oct 2016 23:24:29 -0700
Message-ID: <xmqqbmy3wu3m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5A22715A-9DA0-11E6-9DE6-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

Git v2.10.2, the second maintenance release for 2.10.x track, has
been tagged.  On the master front, things are getting close for
v2.11.0-rc0, the preview snapshot for the upcoming 2.11.0 release.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* jc/abbrev-auto (2016-10-22) 4 commits
  (merged to 'next' on 2016-10-26 at 92fdb66807)
 + transport: compute summary-width dynamically
 + transport: allow summary-width to be computed dynamically
 + fetch: pass summary_width down the callchain
 + transport: pass summary_width down the callchain
 (this branch uses jk/abbrev-auto and lt/abbrev-auto.)

 "git push" and "git fetch" reports from what old object to what new
 object each ref was updated, using abbreviated refnames, and they
 attempt to align the columns for this and other pieces of
 information.  The way these codepaths compute how many display
 columns to allocate for the object names portion of this output has
 been updated to match the recent "auto scale the default
 abbreviation length" change.


* jk/abbrev-auto (2016-10-03) 1 commit
  (merged to 'next' on 2016-10-21 at 8aa3d760d8)
 + find_unique_abbrev: move logic out of get_short_sha1()
 (this branch is used by jc/abbrev-auto; uses lt/abbrev-auto.)

 Updates the way approximate count of total objects is computed
 while attempting to come up with a unique abbreviated object name,
 which in turn needs to estimate how many hexdigits are necessary to
 ensure uniqueness.


* jk/daemon-path-ok-check-truncation (2016-10-24) 1 commit
  (merged to 'next' on 2016-10-26 at 70c08241f6)
 + daemon: detect and reject too-long paths

 "git daemon" used fixed-length buffers to turn URL to the
 repository the client asked for into the server side directory
 path, using snprintf() to avoid overflowing these buffers, but
 allowed possibly truncated paths to the directory.  This has been
 tightened to reject such a request that causes overlong path to be
 required to serve.


* jk/no-looking-at-dotgit-outside-repo (2016-10-26) 6 commits
  (merged to 'next' on 2016-10-26 at 4aa877b578)
 + diff: handle sha1 abbreviations outside of repository
 + diff_aligned_abbrev: use "struct oid"
 + diff_unique_abbrev: rename to diff_aligned_abbrev
 + find_unique_abbrev: use 4-buffer ring
 + test-*-cache-tree: setup git dir
 + read info/{attributes,exclude} only when in repository
 (this branch is used by jk/no-looking-at-dotgit-outside-repo-final.)

 Update "git diff --no-index" codepath not to try to peek into .git/
 directory that happens to be under the current directory, when we
 know we are operating outside any repository.


* js/prepare-sequencer (2016-10-21) 27 commits
  (merged to 'next' on 2016-10-26 at 12be8ebe90)
 + sequencer: mark all error messages for translation
 + sequencer: start error messages consistently with lower case
 + sequencer: quote filenames in error messages
 + sequencer: mark action_name() for translation
 + sequencer: remove overzealous assumption in rebase -i mode
 + sequencer: teach write_message() to append an optional LF
 + sequencer: refactor write_message() to take a pointer/length
 + sequencer: roll back lock file if write_message() failed
 + sequencer: stop releasing the strbuf in write_message()
 + sequencer: left-trim lines read from the script
 + sequencer: support cleaning up commit messages
 + sequencer: support amending commits
 + sequencer: allow editing the commit message on a case-by-case basis
 + sequencer: introduce a helper to read files written by scripts
 + sequencer: prepare for rebase -i's commit functionality
 + sequencer: remember the onelines when parsing the todo file
 + sequencer: get rid of the subcommand field
 + sequencer: avoid completely different messages for different actions
 + sequencer: strip CR from the todo script
 + sequencer: completely revamp the "todo" script parsing
 + sequencer: refactor the code to obtain a short commit name
 + sequencer: future-proof read_populate_todo()
 + sequencer: plug memory leaks for the option values
 + sequencer: future-proof remove_sequencer_state()
 + sequencer: avoid unnecessary indirection
 + sequencer: use memoized sequencer directory path
 + sequencer: use static initializers for replay_opts

 Update of the sequencer codebase to make it reusable to reimplement
 "rebase -i" continues.


* lt/abbrev-auto (2016-10-03) 3 commits
  (merged to 'next' on 2016-10-03 at bb188d00f7)
 + abbrev: auto size the default abbreviation
 + abbrev: prepare for new world order
 + abbrev: add FALLBACK_DEFAULT_ABBREV to prepare for auto sizing
 (this branch is used by jc/abbrev-auto and jk/abbrev-auto.)

 Allow the default abbreviation length, which has historically been
 7, to scale as the repository grows.  The logic suggests to use 12
 hexdigits for the Linux kernel, and 9 to 10 for Git itself.


* nd/ita-empty-commit (2016-10-24) 4 commits
  (merged to 'next' on 2016-10-26 at fb007cdae1)
 + commit: don't be fooled by ita entries when creating initial commit
 + commit: fix empty commit creation when there's no changes but ita entries
 + diff: add --ita-[in]visible-in-index
 + diff-lib: allow ita entries treated as "not yet exist in index"

 When new paths were added by "git add -N" to the index, it was
 enough to circumvent the check by "git commit" to refrain from
 making an empty commit without "--allow-empty".  The same logic
 prevented "git status" to show such a path as "new file" in the
 "Changes not staged for commit" section.


* rs/ring-buffer-wraparound (2016-10-26) 1 commit
  (merged to 'next' on 2016-10-26 at d2da68a14a)
 + hex: make wraparound of the index into ring-buffer explicit

 The code that we have used for the past 10+ years to cycle
 4-element ring buffers turns out to be not quite portable in
 theoretical world.


* sb/submodule-ignore-trailing-slash (2016-10-25) 3 commits
  (merged to 'next' on 2016-10-26 at e56a8ebb38)
 + t0060: sidestep surprising path mangling results on Windows
  (merged to 'next' on 2016-10-11 at e37425ed17)
 + submodule: ignore trailing slash in relative url
 + submodule: ignore trailing slash on superproject URL

 A minor regression fix for "git submodule".

--------------------------------------------------
[New Topics]

* jk/common-main (2016-10-27) 1 commit
  (merged to 'next' on 2016-10-28 at fcdd4f8a26)
 + git-compat-util: move content inside ifdef/endif guards

 A trivial clean-up to a recently graduated topic.

 Will merge to 'master'.


* ak/pre-receive-hook-template-modefix (2016-10-28) 1 commit
  (merged to 'next' on 2016-10-28 at 86d95836a3)
 + pre-receive.sample: mark it executable

 A trivial clean-up to a recently graduated topic.

 Will merge to 'master'.


* nd/rebase-forget (2016-10-28) 1 commit
 - rebase: add --forget to cleanup rebase, leave HEAD untouched

 "git rebase" learned "--forget" option, which allows a user to
 remove the metadata left by an earlier "git rebase" that was
 manually aborted without using "git rebase --abort".


* jc/git-open-cloexec (2016-10-28) 2 commits
 - sha1_file: stop opening files with O_NOATIME
 - git_open(): untangle possible NOATIME and CLOEXEC interactions
 (this branch uses ls/git-open-cloexec.)

 The codeflow of setting NOATIME and CLOEXEC on file descriptors Git
 opens has been simplified.

 We probably want to drop the tip one.

--------------------------------------------------
[Stalled]

* hv/submodule-not-yet-pushed-fix (2016-10-10) 3 commits
 - batch check whether submodule needs pushing into one call
 - serialize collection of refs that contain submodule changes
 - serialize collection of changed submodules

 The code in "git push" to compute if any commit being pushed in the
 superproject binds a commit in a submodule that hasn't been pushed
 out was overly inefficient, making it unusable even for a small
 project that does not have any submodule but have a reasonable
 number of refs.

 Waiting for review.
 cf. <cover.1475851621.git.hvoigt@hvoigt.net>


* sb/push-make-submodule-check-the-default (2016-10-10) 2 commits
 - push: change submodule default to check when submodules exist
 - submodule add: extend force flag to add existing repos

 Turn the default of "push.recurseSubmodules" to "check" when
 submodules seem to be in use.

 Will hold to wait for hv/submodule-not-yet-pushed-fix


* jc/bundle (2016-03-03) 6 commits
 - index-pack: --clone-bundle option
 - Merge branch 'jc/index-pack' into jc/bundle
 - bundle v3: the beginning
 - bundle: keep a copy of bundle file name in the in-core bundle header
 - bundle: plug resource leak
 - bundle doc: 'verify' is not about verifying the bundle

 The beginning of "split bundle", which could be one of the
 ingredients to allow "git clone" traffic off of the core server
 network to CDN.

 While I think it would make it easier for people to experiment and
 build on if the topic is merged to 'next', I am at the same time a
 bit reluctant to merge an unproven new topic that introduces a new
 file format, which we may end up having to support til the end of
 time.  It is likely that to support a "prime clone from CDN", it
 would need a lot more than just "these are the heads and the pack
 data is over there", so this may not be sufficient.

 Will discard.


* mh/connect (2016-06-06) 10 commits
 - connect: [host:port] is legacy for ssh
 - connect: move ssh command line preparation to a separate function
 - connect: actively reject git:// urls with a user part
 - connect: change the --diag-url output to separate user and host
 - connect: make parse_connect_url() return the user part of the url as a separate value
 - connect: group CONNECT_DIAG_URL handling code
 - connect: make parse_connect_url() return separated host and port
 - connect: re-derive a host:port string from the separate host and port variables
 - connect: call get_host_and_port() earlier
 - connect: document why we sometimes call get_port after get_host_and_port

 Rewrite Git-URL parsing routine (hopefully) without changing any
 behaviour.

 It has been two months without any support.  We may want to discard
 this.


* kn/ref-filter-branch-list (2016-05-17) 17 commits
 - branch: implement '--format' option
 - branch: use ref-filter printing APIs
 - branch, tag: use porcelain output
 - ref-filter: allow porcelain to translate messages in the output
 - ref-filter: add `:dir` and `:base` options for ref printing atoms
 - ref-filter: make remote_ref_atom_parser() use refname_atom_parser_internal()
 - ref-filter: introduce symref_atom_parser() and refname_atom_parser()
 - ref-filter: introduce refname_atom_parser_internal()
 - ref-filter: make "%(symref)" atom work with the ':short' modifier
 - ref-filter: add support for %(upstream:track,nobracket)
 - ref-filter: make %(upstream:track) prints "[gone]" for invalid upstreams
 - ref-filter: introduce format_ref_array_item()
 - ref-filter: move get_head_description() from branch.c
 - ref-filter: modify "%(objectname:short)" to take length
 - ref-filter: implement %(if:equals=<string>) and %(if:notequals=<string>)
 - ref-filter: include reference to 'used_atom' within 'atom_value'
 - ref-filter: implement %(if), %(then), and %(else) atoms

 The code to list branches in "git branch" has been consolidated
 with the more generic ref-filter API.

 Rerolled.
 Needs review.


* ec/annotate-deleted (2015-11-20) 1 commit
 - annotate: skip checking working tree if a revision is provided

 Usability fix for annotate-specific "<file> <rev>" syntax with deleted
 files.

 Has been waiting for a review for too long without seeing anything.

 Will discard.


* dk/gc-more-wo-pack (2016-01-13) 4 commits
 - gc: clean garbage .bitmap files from pack dir
 - t5304: ensure non-garbage files are not deleted
 - t5304: test .bitmap garbage files
 - prepare_packed_git(): find more garbage

 Follow-on to dk/gc-idx-wo-pack topic, to clean up stale
 .bitmap and .keep files.

 Has been waiting for a reroll for too long.
 cf. <xmqq60ypbeng.fsf@gitster.mtv.corp.google.com>

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

 Will discard.

--------------------------------------------------
[Cooking]

* aw/numbered-stash (2016-10-26) 1 commit
  (merged to 'next' on 2016-10-26 at 8d9325fa3a)
 + stash: allow stashes to be referenced by index only

 The user always has to say "stash@{$N}" when naming a single
 element in the default location of the stash, i.e. reflogs in
 refs/stash.  The "git stash" command learned to accept "git stash
 apply 4" as a short-hand for "git stash apply stash@{4}".

 Will merge to 'master'.


* jk/no-looking-at-dotgit-outside-repo-final (2016-10-26) 1 commit
  (merged to 'next' on 2016-10-26 at 220e160451)
 + setup_git_env: avoid blind fall-back to ".git"

 This is the endgame of the topic to avoid blindly falling back to
 ".git" when the setup sequence said we are _not_ in Git repository.
 A corner case that happens to work right now may be broken by a
 call to die("BUG").

 Will cook in 'next'.


* jc/reset-unmerge (2016-10-24) 1 commit
 - reset: --unmerge

 After "git add" is run prematurely during a conflict resolution,
 "git diff" can no longer be used as a way to sanity check by
 looking at the combined diff.  "git reset" learned a new
 "--unmerge" option to recover from this situation.


* ls/git-open-cloexec (2016-10-25) 3 commits
  (merged to 'next' on 2016-10-26 at f7259cbddb)
 + read-cache: make sure file handles are not inherited by child processes
 + sha1_file: open window into packfiles with O_CLOEXEC
 + sha1_file: rename git_open_noatime() to git_open()
 (this branch is used by jc/git-open-cloexec.)

 Git generally does not explicitly close file descriptors that were
 open in the parent process when spawning a child process, but most
 of the time the child does not want to access them. As Windows does
 not allow removing or renaming a file that has a file descriptor
 open, a slow-to-exit child can even break the parent process by
 holding onto them.  Use O_CLOEXEC flag to open files in various
 codepaths.

 Will merge to 'master'.


* jc/merge-base-fp-only (2016-10-19) 8 commits
 . merge-base: fp experiment
 - merge: allow to use only the fp-only merge bases
 - merge-base: limit the output to bases that are on first-parent chain
 - merge-base: mark bases that are on first-parent chain
 - merge-base: expose get_merge_bases_many_0() a bit more
 - merge-base: stop moving commits around in remove_redundant()
 - sha1_name: remove ONELINE_SEEN bit
 - commit: simplify fastpath of merge-base

 An experiment of merge-base that ignores common ancestors that are
 not on the first parent chain.


* tb/convert-stream-check (2016-10-27) 2 commits
 - convert.c: stream and fast search for binary
 - read-cache: factor out get_sha1_from_index() helper

 End-of-line conversion sometimes needs to see if the current blob
 in the index has NULs and CRs to base its decision.  We used to
 always get a full statistics over the blob, but in many cases we
 can return early when we have seen "enough" (e.g. if we see a
 single NUL, the blob will be handled as binary).  The codepaths
 have been optimized by using streaming interface.

 Waiting for review.
 The tip seems to do too much in a single commit and may be better split.
 cf. <20161012134724.28287-1-tboegi@web.de>
 cf. <xmqqd1il5w4e.fsf@gitster.mtv.corp.google.com>


* jt/trailer-with-cruft (2016-10-21) 8 commits
  (merged to 'next' on 2016-10-27 at b5d1a21811)
 + trailer: support values folded to multiple lines
 + trailer: forbid leading whitespace in trailers
 + trailer: allow non-trailers in trailer block
 + trailer: clarify failure modes in parse_trailer
 + trailer: make args have their own struct
 + trailer: streamline trailer item create and add
 + trailer: use list.h for doubly-linked list
 + trailer: improve const correctness

 Update "interpret-trailers" machinery and teaches it that people in
 real world write all sorts of crufts in the "trailer" that was
 originally designed to have the neat-o "Mail-Header: like thing"
 and nothing else.

 Will merge to 'master'.


* pb/bisect (2016-10-18) 27 commits
 - bisect--helper: remove the dequote in bisect_start()
 - bisect--helper: retire `--bisect-auto-next` subcommand
 - bisect--helper: retire `--bisect-autostart` subcommand
 - bisect--helper: retire `--bisect-write` subcommand
 - bisect--helper: `bisect_replay` shell function in C
 - bisect--helper: `bisect_log` shell function in C
 - bisect--helper: retire `--write-terms` subcommand
 - bisect--helper: retire `--check-expected-revs` subcommand
 - bisect--helper: `bisect_state` & `bisect_head` shell function in C
 - bisect--helper: `bisect_autostart` shell function in C
 - bisect--helper: retire `--next-all` subcommand
 - bisect--helper: retire `--bisect-clean-state` subcommand
 - bisect--helper: `bisect_next` and `bisect_auto_next` shell function in C
 - t6030: no cleanup with bad merge base
 - bisect--helper: `bisect_start` shell function partially in C
 - bisect--helper: `get_terms` & `bisect_terms` shell function in C
 - bisect--helper: `bisect_next_check` & bisect_voc shell function in C
 - bisect--helper: `check_and_set_terms` shell function in C
 - bisect--helper: `bisect_write` shell function in C
 - bisect--helper: `is_expected_rev` & `check_expected_revs` shell function in C
 - bisect--helper: `bisect_reset` shell function in C
 - wrapper: move is_empty_file() and rename it as is_empty_or_missing_file()
 - t6030: explicitly test for bisection cleanup
 - bisect--helper: `bisect_clean_state` shell function in C
 - bisect--helper: `write_terms` shell function in C
 - bisect: rewrite `check_term_format` shell function in C
 - bisect--helper: use OPT_CMDMODE instead of OPT_BOOL

 Move more parts of "git bisect" to C.

 Waiting for review.


* st/verify-tag (2016-10-10) 7 commits
 - t/t7004-tag: Add --format specifier tests
 - t/t7030-verify-tag: Add --format specifier tests
 - builtin/tag: add --format argument for tag -v
 - builtin/verify-tag: add --format to verify-tag
 - tag: add format specifier to gpg_verify_tag
 - ref-filter: add function to print single ref_array_item
 - gpg-interface, tag: add GPG_VERIFY_QUIET flag

 "git tag" and "git verify-tag" learned to put GPG verification
 status in their "--format=<placeholders>" output format.

 Waiting for a reroll.
 cf. <20161007210721.20437-1-santiago@nyu.edu>


* sb/attr (2016-10-28) 37 commits
 - completion: clone can initialize specific submodules
 - clone: add --init-submodule=<pathspec> switch
 - submodule update: add `--init-default-path` switch
 - pathspec: allow escaped query values
 - pathspec: allow querying for attributes
 - pathspec: move prefix check out of the inner loop
 - pathspec: move long magic parsing out of prefix_pathspec
 - Documentation: fix a typo
 - attr: keep attr stack for each check
 - SQUASH???
 - attr: convert to new threadsafe API
 - attr: make git_check_attr_counted static
 - attr.c: outline the future plans by heavily commenting
 - attr.c: always pass check[] to collect_some_attrs()
 - attr.c: introduce empty_attr_check_elems()
 - attr.c: correct ugly hack for git_all_attrs()
 - attr.c: rename a local variable check
 - attr.c: pass struct git_attr_check down the callchain
 - attr.c: add push_stack() helper
 - attr: support quoting pathname patterns in C style
 - attr: expose validity check for attribute names
 - attr: add counted string version of git_attr()
 - attr: add counted string version of git_check_attr()
 - attr: retire git_check_attrs() API
 - attr: convert git_check_attrs() callers to use the new API
 - attr: convert git_all_attrs() to use "struct git_attr_check"
 - attr: (re)introduce git_check_attr() and struct git_attr_check
 - attr: rename function and struct related to checking attributes
 - attr.c: plug small leak in parse_attr_line()
 - attr.c: tighten constness around "git_attr" structure
 - attr.c: simplify macroexpand_one()
 - attr.c: mark where #if DEBUG ends more clearly
 - attr.c: complete a sentence in a comment
 - attr.c: explain the lack of attr-name syntax check in parse_attr()
 - attr.c: update a stale comment on "struct match_attr"
 - attr.c: use strchrnul() to scan for one line
 - commit.c: use strchrnul() to scan for one line

 The attributes API has been updated so that it can later be
 optimized using the knowledge of which attributes are queried.
 Building on top of the updated API, the pathspec machinery learned
 to select only paths with given attributes set.

 Waiting for review.


* va/i18n-perl-scripts (2016-10-20) 14 commits
 - i18n: difftool: mark warnings for translation
 - i18n: send-email: mark string with interpolation for translation
 - i18n: send-email: mark warnings and errors for translation
 - i18n: send-email: mark strings for translation
 - i18n: add--interactive: mark status words for translation
 - i18n: add--interactive: remove %patch_modes entries
 - i18n: add--interactive: mark edit_hunk_manually message for translation
 - i18n: add--interactive: i18n of help_patch_cmd
 - i18n: add--interactive: mark patch prompt for translation
 - i18n: add--interactive: mark plural strings
 - i18n: clean.c: match string with git-add--interactive.perl
 - i18n: add--interactive: mark strings with interpolation for translation
 - i18n: add--interactive: mark simple here-documents for translation
 - i18n: add--interactive: mark strings for translation

 Porcelain scripts written in Perl are getting internationalized.

 Waiting for review.
 cf. <20161010125449.7929-1-vascomalmeida@sapo.pt>


* jc/latin-1 (2016-09-26) 2 commits
  (merged to 'next' on 2016-09-28 at c8673e03c2)
 + utf8: accept "latin-1" as ISO-8859-1
 + utf8: refactor code to decide fallback encoding

 Some platforms no longer understand "latin-1" that is still seen in
 the wild in e-mail headers; replace them with "iso-8859-1" that is
 more widely known when conversion fails from/to it.

 Will hold to see if people scream.


* ls/filter-process (2016-10-17) 14 commits
  (merged to 'next' on 2016-10-19 at ffd0de042c)
 + contrib/long-running-filter: add long running filter example
 + convert: add filter.<driver>.process option
 + convert: prepare filter.<driver>.process option
 + convert: make apply_filter() adhere to standard Git error handling
 + pkt-line: add functions to read/write flush terminated packet streams
 + pkt-line: add packet_write_gently()
 + pkt-line: add packet_flush_gently()
 + pkt-line: add packet_write_fmt_gently()
 + pkt-line: extract set_packet_header()
 + pkt-line: rename packet_write() to packet_write_fmt()
 + run-command: add clean_on_exit_handler
 + run-command: move check_pipe() from write_or_die to run_command
 + convert: modernize tests
 + convert: quote filter names in error messages

 The smudge/clean filter API expect an external process is spawned
 to filter the contents for each path that has a filter defined.  A
 new type of "process" filter API has been added to allow the first
 request to run the filter for a path to spawn a single process, and
 all filtering need is served by this single process for multiple
 paths, reducing the process creation overhead.

 Will merge to 'master'.


* sg/fix-versioncmp-with-common-suffix (2016-09-08) 5 commits
 - versioncmp: cope with common leading parts in versionsort.prereleaseSuffix
 - versioncmp: pass full tagnames to swap_prereleases()
 - t7004-tag: add version sort tests to show prerelease reordering issues
 - t7004-tag: use test_config helper
 - t7004-tag: delete unnecessary tags with test_when_finished

 The prereleaseSuffix feature of version comparison that is used in
 "git tag -l" did not correctly when two or more prereleases for the
 same release were present (e.g. when 2.0, 2.0-beta1, and 2.0-beta2
 are there and the code needs to compare 2.0-beta1 and 2.0-beta2).

 Waiting for a reroll.
 cf. <20160908223727.Horde.jVOOJ278ssZ3qkyjkmyqZD-@webmail.informatik.kit.edu>


* jc/pull-rebase-ff (2016-07-28) 1 commit
 - pull: fast-forward "pull --rebase=true"

 "git pull --rebase", when there is no new commits on our side since
 we forked from the upstream, should be able to fast-forward without
 invoking "git rebase", but it didn't.

 Needs a real log message and a few tests.


* jc/merge-drop-old-syntax (2015-04-29) 1 commit
  (merged to 'next' on 2016-10-11 at 8928c8b9b3)
 + merge: drop 'git merge <message> HEAD <commit>' syntax

 Stop supporting "git merge <message> HEAD <commit>" syntax that has
 been deprecated since October 2007, and issues a deprecation
 warning message since v2.5.0.

 It has been reported that git-gui still uses the deprecated syntax,
 which needs to be fixed before this final step can proceed.
 cf. <5671DB28.8020901@kdbg.org>

 Will cook in 'next'.
