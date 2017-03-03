Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCF0420133
	for <e@80x24.org>; Fri,  3 Mar 2017 23:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752199AbdCCX0S (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 18:26:18 -0500
Received: from pb-sasl-trial2.pobox.com ([64.147.108.86]:51096 "EHLO
        pb-sasl-trial2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752184AbdCCX0Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 18:26:16 -0500
Received: from pb-sasl-trial2.pobox.com (ro.sql.pobox.com [127.0.0.1])
        by pb-sasl-trial2.pobox.com (Postfix) with ESMTP id 0942318027;
        Fri,  3 Mar 2017 18:26:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=o
        FygQu5gTmsRHQzDb6kzUg1DgKs=; b=gYjSScB0ZiPxYxwePI4AywSRtU65eoRoO
        G3/2R7M704n84kvJlFxPUJ6KFg8Eq01LvOXiQZCTaL0wKAGBr6bgPAyufRICgYIB
        Y9Kthh7KdG2RClHkgHAqB+99c+MLrPeHo361oBYLupsc36NAFs8mVEsj8aKkTxID
        8YHrmEsNGw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=Wh6
        TtHOMCsMyyeCv3TBZ5myETDWoVZDBJKMny2/3owF2SgkuOx7emx29NlLQ+LBnb2Y
        eUtSf/GMmgXnucZnJSBrD1Zh1fBART0K3r0M3C2c2fsoPsv2TCqB6/x0xzdZ3bqk
        m1upeM4JFk5InnC5imeRAysX0D8fcVlxVI/7IdTU=
Received: from pb-smtp1.nyi.icgroup.com (pb-smtp1.pobox.com [10.90.30.53])
        by pb-sasl-trial2.pobox.com (Postfix) with ESMTP id D66FF18026;
        Fri,  3 Mar 2017 18:26:11 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D176B67B97;
        Fri,  3 Mar 2017 18:26:10 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Mar 2017, #02; Fri, 3)
X-master-at: 3bc53220cb2dcf709f7a027a3f526befd021d858
X-next-at: a2ecc84866b651ad965003275b748da92fd99ab4
Date:   Fri, 03 Mar 2017 15:26:09 -0800
Message-ID: <xmqqh93a6iy6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C924F3C2-0068-11E7-9133-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* ew/markdown-url-in-readme (2017-03-01) 1 commit
  (merged to 'next' on 2017-03-03 at 3d35e3a991)
 + README: create HTTP/HTTPS links from URLs in Markdown

 Doc update.

 Will merge to 'master'.


* jk/add-i-patch-do-prompt (2017-03-02) 1 commit
 - add--interactive: fix missing file prompt for patch mode with "-i"

 The patch subcommand of "git add -i" was meant to have paths
 selection prompt just like other subcommand, unlike "git add -p"
 directly jumps to hunk selection.  Recently, this was broken and
 "add -i" lost the paths selection dialog, but it now has been
 fixed.

 Will merge to 'next'.


* ax/line-log-range-merge-fix (2017-03-03) 1 commit
 - line-log.c: prevent crash during union of too many ranges

 The code to parse "git log -L..." command line was buggy when there
 are many ranges specified with -L; overrun of the allocated buffer
 has been fixed.

 Will merge to 'next'.


* js/early-config (2017-03-03) 11 commits
 - t1309: test read_early_config()
 - read_early_config(): really discover .git/
 - read_early_config(): avoid .git/config hack when unneeded
 - setup: make read_early_config() reusable
 - setup: export the discover_git_directory() function
 - SQUASH??? ERROR: trailing statements should be on next line
 - setup_git_directory_1(): avoid changing global state
 - setup: prepare setup_discovered_git_directory() the root directory
 - SQUASH??? ERROR: trailing statements should be on next line
 - setup_git_directory(): use is_dir_sep() helper
 - t7006: replace dubious test

 The start-up sequence of "git" needs to figure out some configured
 settings before it finds and set itself up in the location of the
 repository and was quite messy due to its "chicken-and-egg" nature.
 The code has been restructured.

 Will merge to 'next' after squashing niggle-fixes in.


* jt/perf-updates (2017-03-03) 3 commits
 - t/perf: add fallback for pre-bin-wrappers versions of git
 - t/perf: use $MODERN_GIT for all repo-copying steps
 - t/perf: export variable used in other blocks

 The t/perf performance test suite was not prepared to test not so
 old versions of Git, but now it covers versions of Git that are not
 so ancient.

 Will merge to 'next'.


* ss/remote-bzr-hg-placeholder-wo-python (2017-03-03) 1 commit
 - contrib: git-remote-{bzr,hg} placeholders don't need Python

 There is no need for Python only to give a few messages to the
 standard error stream, but we somehow did.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* nd/worktree-move (2017-01-27) 7 commits
 . fixup! worktree move: new command
 . worktree remove: new command
 . worktree move: refuse to move worktrees with submodules
 . worktree move: accept destination as directory
 . worktree move: new command
 . worktree.c: add update_worktree_location()
 . worktree.c: add validate_worktree()

 "git worktree" learned move and remove subcommands.

 Tentatively ejected as it seems to break 'pu' when merged.


* pb/bisect (2017-02-18) 28 commits
 - fixup! bisect--helper: `bisect_next_check` & bisect_voc shell function in C
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

 Expecting a reroll.
 cf. <CAFZEwPPXPPHi8KiEGS9ggzNHDCGhuqMgH9Z8-Pf9GLshg8+LPA@mail.gmail.com>
 cf. <CAFZEwPM9RSTGN54dzaw9gO9iZmsYjJ_d1SjUD4EzSDDbmh-XuA@mail.gmail.com>
 cf. <CAFZEwPNUXcNY9Qdz=_B7q2kQuaecPzJtTMGdv8YMUPEz2vnp8A@mail.gmail.com>


* ls/filter-process-delayed (2017-01-08) 1 commit
 . convert: add "status=delayed" to filter process protocol

 Ejected, as does not build when merged to 'pu'.


* sh/grep-tree-obj-tweak-output (2017-01-20) 2 commits
 - grep: use '/' delimiter for paths
 - grep: only add delimiter if there isn't one already

 "git grep", when fed a tree-ish as an input, shows each hit
 prefixed with "<tree-ish>:<path>:<lineno>:".  As <tree-ish> is
 almost always either a commit or a tag that points at a commit, the
 early part of the output "<tree-ish>:<path>" can be used as the
 name of the blob and given to "git show".  When <tree-ish> is a
 tree given in the extended SHA-1 syntax (e.g. "<commit>:", or
 "<commit>:<dir>"), however, this results in a string that does not
 name a blob (e.g. "<commit>::<path>" or "<commit>:<dir>:<path>").
 "git grep" has been taught to be a bit more intelligent about these
 cases and omit a colon (in the former case) or use slash (in the
 latter case) to produce "<commit>:<path>" and
 "<commit>:<dir>/<path>" that can be used as the name of a blob.

 Expecting a reroll?  Is this good enough with known limitations?


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

* jk/interpret-branch-name (2017-03-02) 9 commits
 - checkout: restrict @-expansions when finding branch
 - strbuf_check_ref_format(): expand only local branches
 - branch: restrict @-expansions when deleting
 - t3204: test git-branch @-expansion corner cases
 - interpret_branch_name: allow callers to restrict expansions
 - strbuf_branchname: add docstring
 - strbuf_branchname: drop return value
 - interpret_branch_name: move docstring to header file
 - interpret_branch_name(): handle auto-namelen for @{-1}

 "git branch @" created refs/heads/@ as a branch, and in general the
 code that handled @{-1} and @{upstream} was a bit too loose in
 disambiguating.

 Will merge to 'next'.


* jk/sha1dc (2017-03-01) 7 commits
 - Put sha1dc on a diet
 - sha1dc: avoid 'for' loop initial decl
 - sha1dc: resurrect LICENSE file
 - sha1dc: avoid c99 declaration-after-statement
 - Makefile: add USE_SHA1DC knob
 - sha1dc: adjust header includes for git
 - add collision-detecting sha1 implementation

 Borrow "detect attempt to create collisions" variant of SHA-1
 implementation by Marc Stevens (CWI) and Dan Shumow (Microsoft).

 Expecting a cleaned-up reroll after discussion settles.
 cf. <CA+55aFxTWqsTTiDKo4DBZT-8Z9t80bGMD3uijzKONa_bYEZABQ@mail.gmail.com>


* js/travis-32bit-linux (2017-03-03) 1 commit
 - Travis: also test on 32-bit Linux

 Add 32-bit Linux variant to the set of platforms to be tested with
 Travis CI.

 Will merge to 'next'.


* jt/http-base-url-update-upon-redirect (2017-02-28) 1 commit
  (merged to 'next' on 2017-03-03 at 5225bd3ef8)
 + http: attempt updating base URL only if no error

 When a redirected http transport gets an error during the
 redirected request, we ignored the error we got from the server,
 and ended up giving a not-so-useful error message.

 Will merge to 'master'.


* jt/mark-tree-uninteresting-for-uninteresting-commit (2017-02-28) 3 commits
 - upload-pack: compute blob reachability correctly
 - revision: exclude trees/blobs given commit
 - revision: unify {tree,blob}_objects in rev_info

 The revision/object traversal machinery did not mark all tree and
 blob objects that are contained in an uninteresting commit as
 uninteresting, because that is quite costly.  Instead, it only
 marked those that are contained in an uninteresting boundary commit
 as uninteresting.

 cf. <20170228215937.yd4juycjf7y3vish@sigill.intra.peff.net>


* ps/docs-diffcore (2017-02-28) 2 commits
  (merged to 'next' on 2017-03-03 at 9ca5691de2)
 + docs/diffcore: unquote "Complete Rewrites" in headers
 + docs/diffcore: fix grammar in diffcore-rename header

 Doc update.

 Will merge to 'master'.


* rj/remove-unused-mktemp (2017-02-28) 2 commits
  (merged to 'next' on 2017-03-03 at 4512f0c5ab)
 + wrapper.c: remove unused gitmkstemps() function
 + wrapper.c: remove unused git_mkstemp() function

 Code cleanup.

 Will merge to 'master'.


* sb/submodule-init-url-selection (2017-02-28) 1 commit
  (merged to 'next' on 2017-03-03 at 847d1f9a91)
 + submodule init: warn about falling back to a local path

 Give a warning when "git submodule init" decides that the submodule
 in the working tree is its upstream, as it is not a very common
 setup.

 Will merge to 'master'.


* jc/diff-populate-filespec-size-only-fix (2017-03-02) 1 commit
 - diff: do not short-cut CHECK_SIZE_ONLY check in diff_populate_filespec()

 "git diff --quiet" relies on the size field in diff_filespec to be
 correctly populated, but diff_populate_filespec() helper function
 made an incorrect short-cut when asked only to populate the size
 field for paths that need to go through convert_to_git() (e.g. CRLF
 conversion).

 Will merge to 'next'.


* nd/conditional-config-include (2017-03-03) 5 commits
 - SQUASH??? cond config include test
 - SQUASH???
 - config: add conditional include
 - config.txt: reflow the second include.path paragraph
 - config.txt: clarify multiple key values in include.path

 The configuration file learned a new "includeIf.<condition>.path"
 that includes the contents of the given path only when the
 condition holds.  This allows you to say "include this work-related
 bit only in the repositories under my ~/work/ directory".

 Will merge to 'next' after squashing niggle-fixes in.


* rs/log-email-subject (2017-03-01) 2 commits
  (merged to 'next' on 2017-03-03 at a2ecc84866)
 + pretty: use fmt_output_email_subject()
 + log-tree: factor out fmt_output_email_subject()

 Code clean-up.

 Will merge to 'master'.


* cc/split-index-config (2017-03-01) 22 commits
 - Documentation/git-update-index: explain splitIndex.*
 - Documentation/config: add splitIndex.sharedIndexExpire
 - read-cache: use freshen_shared_index() in read_index_from()
 - read-cache: refactor read_index_from()
 - t1700: test shared index file expiration
 - read-cache: unlink old sharedindex files
 - config: add git_config_get_expiry() from gc.c
 - read-cache: touch shared index files when used
 - sha1_file: make check_and_freshen_file() non static
 - Documentation/config: add splitIndex.maxPercentChange
 - t1700: add tests for splitIndex.maxPercentChange
 - read-cache: regenerate shared index if necessary
 - config: add git_config_get_max_percent_split_change()
 - Documentation/git-update-index: talk about core.splitIndex config var
 - Documentation/config: add information for core.splitIndex
 - t1700: add tests for core.splitIndex
 - update-index: warn in case of split-index incoherency
 - read-cache: add and then use tweak_split_index()
 - split-index: add {add,remove}_split_index() functions
 - config: add git_config_get_split_index()
 - t1700: change here document style
 - config: mark an error message up for translation

 The experimental "split index" feature has gained a few
 configuration variables to make it easier to use.

 I think this is almost ready for 'next'.


* dp/filter-branch-prune-empty (2017-03-03) 4 commits
 - p7000: add test for filter-branch with --prune-empty
 - filter-branch: fix --prune-empty on parentless commits
 - t7003: ensure --prune-empty removes entire branch when applicable
 - t7003: ensure --prune-empty can prune root commit

 "git filter-branch --prune-empty" drops a single-parent commit that
 becomes a no-op, but did not drop a root commit whose tree is empty.

 Will merge to 'next'.


* jc/config-case-cmdline-take-2 (2017-02-23) 2 commits
  (merged to 'next' on 2017-03-01 at 2e9920eeeb)
 + config: use git_config_parse_key() in git_config_parse_parameter()
 + config: move a few helper functions up

 The code to parse "git -c VAR=VAL cmd" and set configuration
 variable for the duration of cmd had two small bugs, which have
 been fixed.

 Will merge to 'master'.
 This supersedes jc/config-case-cmdline topic that has been discarded.


* ab/cond-skip-tests (2017-03-01) 3 commits
 - gitweb tests: skip tests when we don't have Time::HiRes
 - gitweb tests: change confusing "skip_all" phrasing
 - cvs tests: skip tests that call "cvs commit" when running as root

 A few tests were run conditionally under (rare) conditions where
 they cannot be run (like running cvs tests under 'root' account).

 Will merge to 'next'.


* jk/interop-test (2017-02-27) 2 commits
 - t/interop: add test of old clients against modern git-daemon
 - t: add an interoperability test harness

 Picking two versions of Git and running tests to make sure the
 older one and the newer one interoperate happily has now become
 possible.

 Needs review.


* jk/parse-config-key-cleanup (2017-02-24) 3 commits
  (merged to 'next' on 2017-03-01 at e531d8d3a9)
 + parse_hide_refs_config: tell parse_config_key we don't want a subsection
 + parse_config_key: allow matching single-level config
 + parse_config_key: use skip_prefix instead of starts_with
 (this branch uses sb/parse-hide-refs-config-cleanup.)

 The "parse_config_key()" API function has been cleaned up.

 Will merge to 'master'.


* jk/t6300-cleanup (2017-02-27) 1 commit
  (merged to 'next' on 2017-03-02 at 3087521bea)
 + t6300: avoid creating refs/heads/HEAD

 A test that creates a confusing branch whose name is HEAD has been
 corrected not to do so.

 Will merge to 'master'.


* rs/commit-parsing-optim (2017-02-27) 2 commits
  (merged to 'next' on 2017-03-02 at 22239f35df)
 + commit: don't check for space twice when looking for header
 + commit: be more precise when searching for headers

 The code that parses header fields in the commit object has been
 updated for (micro)performance and code hygiene.

 Will merge to 'master'.


* rs/sha1-file-plug-fallback-base-leak (2017-02-27) 1 commit
  (merged to 'next' on 2017-03-02 at 03344b1119)
 + sha1_file: release fallback base's memory in unpack_entry()

 A leak in a codepath to read from a packed object in (rare) cases
 has been plugged.

 Will merge to 'master'.


* rs/strbuf-add-real-path (2017-02-27) 2 commits
  (merged to 'next' on 2017-03-02 at 69191becd6)
 + strbuf: add strbuf_add_real_path()
 + cocci: use ALLOC_ARRAY

 An helper function to make it easier to append the result from
 real_path() to a strbuf has been added.

 Will merge to 'master'.


* sb/parse-hide-refs-config-cleanup (2017-02-24) 1 commit
  (merged to 'next' on 2017-03-01 at fd722ba039)
 + refs: parse_hide_refs_config to use parse_config_key
 (this branch is used by jk/parse-config-key-cleanup.)

 Code clean-up.

 Will merge to 'master'.


* sg/clone-refspec-from-command-line-config (2017-02-27) 1 commit
 - clone: respect configured fetch respecs during initial fetch

 Needs review.
 cf. <20170227211217.73gydlxb2qu2sp3m@sigill.intra.peff.net>


* sk/dash-is-previous (2017-03-01) 5 commits
 - revert.c: delegate handling of "-" shorthand to setup_revisions
 - sha1_name.c: teach get_sha1_1 "-" shorthand for "@{-1}"
 - revision.c: args starting with "-" might be a revision
 - revision.c: swap if/else blocks
 - revision.c: do not update argv with unknown option

 A dash "-" can be written to mean "the branch that was previously
 checked out" in more places.

 Needs review.
 cf. <1488007487-12965-1-git-send-email-kannan.siddharth12@gmail.com>


* jh/send-email-one-cc (2017-02-27) 1 commit
  (merged to 'next' on 2017-03-02 at 32c0e6ad88)
 + send-email: only allow one address per body tag

 "Cc:" on the trailer part does not have to conform to RFC strictly,
 unlike in the e-mail header.  "git send-email" has been updated to
 ignore anything after '>' when picking addresses, to allow non-address
 cruft like " # stable 4.4" after the address.

 Will merge to 'master'.


* jk/http-auth (2017-02-27) 2 commits
  (merged to 'next' on 2017-03-02 at 87f81b4395)
 + http: add an "auto" mode for http.emptyauth
 + http: restrict auth methods to what the server advertises

 Reduce authentication round-trip over HTTP when the server supports
 just a single authentication method.

 Will merge to 'master'.


* jk/ident-empty (2017-02-23) 4 commits
  (merged to 'next' on 2017-03-01 at ff80031ce6)
 + ident: do not ignore empty config name/email
 + ident: reject all-crud ident name
 + ident: handle NULL email when complaining of empty name
 + ident: mark error messages for translation

 user.email that consists of only cruft chars should consistently
 error out, but didn't.

 Will merge to 'master'.


* jt/upload-pack-error-report (2017-02-23) 1 commit
  (merged to 'next' on 2017-03-01 at aea583dbe5)
 + upload-pack: report "not our ref" to client

 "git upload-pack", which is a counter-part of "git fetch", did not
 report a request for a ref that was not advertised as invalid.
 This is generally not a problem (because "git fetch" will stop
 before making such a request), but is the right thing to do.

 Will merge to 'master'.


* ah/doc-ls-files-quotepath (2017-03-02) 1 commit
 - Documentation: improve description for core.quotePath

 Documentation for "git ls-files" did not refer to core.quotePath

 Will merge to 'next'.


* jh/memihash-opt (2017-02-17) 5 commits
 - name-hash: remember previous dir_entry during lazy_init_name_hash
 - name-hash: specify initial size for istate.dir_hash table
 - name-hash: precompute hash values during preload-index
 - hashmap: allow memihash computation to be continued
 - name-hash: eliminate duplicate memihash call

 Expecting an update for perf.
 cf. <MWHPR03MB29581B0EDDEDCA7D51EC396F8A280@MWHPR03MB2958.namprd03.prod.outlook.com>


* nd/prune-in-worktree (2017-02-19) 15 commits
 . rev-list: expose and document --single-worktree
 . revision.c: --reflog add HEAD reflog from all worktrees
 . files-backend: make reflog iterator go through per-worktree reflog
 . refs: add refs_for_each_reflog[_ent]()
 . revision.c: --all adds HEAD from all worktrees
 . refs: remove dead for_each_*_submodule()
 . revision.c: use refs_for_each*() instead of for_each_*_submodule()
 . refs: add a refs_for_each_in() and friends
 . refs: add refs_for_each_ref()
 . refs: add refs_head_ref()
 . refs: add refs_read_ref[_full]()
 . refs: move submodule slash stripping code to get_submodule_ref_store
 . revision.c: --indexed-objects add objects from all worktrees
 . revision.c: refactor add_index_objects_to_pending()
 . revision.h: new flag in struct rev_info wrt. worktree-related refs
 (this branch uses nd/worktree-kill-parse-ref; is tangled with nd/files-backend-git-dir.)

 "git gc" and friends when multiple worktrees are used off of a
 single repository did not consider the index and per-worktree refs
 of other worktrees as the root for reachability traversal, making
 objects that are in use only in other worktrees to be subject to
 garbage collection.


* mm/fetch-show-error-message-on-unadvertised-object (2017-03-02) 3 commits
 - fetch-pack: add specific error for fetching an unadvertised object
 - fetch_refs_via_pack: call report_unmatched_refs
 - fetch-pack: move code to report unmatched refs to a function

 "git fetch" that requests a commit by object name, when the other
 side does not allow such an request, failed without much
 explanation.

 Will merge to 'next'.


* nd/worktree-kill-parse-ref (2017-02-19) 22 commits
 . refs: kill set_worktree_head_symref()
 . refs: add refs_create_symref()
 . worktree.c: kill parse_ref() in favor of refs_resolve_ref_unsafe()
 . refs.c: add refs_resolve_ref_unsafe()
 . refs: introduce get_worktree_ref_store()
 . refs: rename get_ref_store() to get_submodule_ref_store() and make it public
 . files-backend: remove submodule_allowed from files_downcast()
 . refs: move submodule code out of files-backend.c
 . path.c: move some code out of strbuf_git_path_submodule()
 . refs.c: make get_main_ref_store() public and use it
 . refs.c: kill register_ref_store(), add register_submodule_ref_store()
 . refs.c: flatten get_ref_store() a bit
 . refs: rename lookup_ref_store() to lookup_submodule_ref_store()
 . refs.c: introduce get_main_ref_store()
 . files-backend: remove the use of git_path()
 . refs.c: share is_per_worktree_ref() to files-backend.c
 . files-backend: replace *git_path*() with files_path()
 . files-backend: add files_path()
 . files-backend: convert git_path() to strbuf_git_path()
 . refs-internal.c: make files_log_ref_write() static
 . Merge branch 'mh/ref-remove-empty-directory' into nd/files-backend-git-dir
 . Merge branch 'mh/submodule-hash' into nd/files-backend-git-dir
 (this branch is used by nd/prune-in-worktree; is tangled with nd/files-backend-git-dir.)

 (hopefully) a beginning of safer "git worktree" that is resistant
 to "gc".

 Waiting for nd/files-backend-git-dir to settle.


* nd/files-backend-git-dir (2017-02-22) 26 commits
 . t1406: new tests for submodule ref store
 . t1405: some basic tests on main ref store
 . t/helper: add test-ref-store to test ref-store functions
 . refs: delete pack_refs() in favor of refs_pack_refs()
 . files-backend: avoid ref api targetting main ref store
 . refs: new transaction related ref-store api
 . refs: add new ref-store api
 . refs: rename get_ref_store() to get_submodule_ref_store() and make it public
 . files-backend: replace submodule_allowed check in files_downcast()
 . refs: move submodule code out of files-backend.c
 . path.c: move some code out of strbuf_git_path_submodule()
 . refs.c: make get_main_ref_store() public and use it
 . refs.c: kill register_ref_store(), add register_submodule_ref_store()
 . refs.c: flatten get_ref_store() a bit
 . refs: rename lookup_ref_store() to lookup_submodule_ref_store()
 . refs.c: introduce get_main_ref_store()
 . files-backend: remove the use of git_path()
 . files-backend: add and use files_refname_path()
 . files-backend: add and use files_reflog_path()
 . files-backend: move "logs/" out of TMP_RENAMED_LOG
 . files-backend: convert git_path() to strbuf_git_path()
 . files-backend: add and use files_packed_refs_path()
 . files-backend: make files_log_ref_write() static
 . refs.h: add forward declaration for structs used in this file
 . Merge branch 'mh/ref-remove-empty-directory' into nd/files-backend-git-dir
 . Merge branch 'mh/submodule-hash' into nd/files-backend-git-dir
 (this branch is tangled with nd/prune-in-worktree and nd/worktree-kill-parse-ref.)

 The "submodule" specific field in the ref_store structure is
 replaced with a more generic "gitdir" that can later be used also
 when dealing with ref_store that represents the set of refs visible
 from the other worktrees.


* sb/checkout-recurse-submodules (2017-02-23) 15 commits
 - builtin/checkout: add --recurse-submodules switch
 - entry.c: update submodules when interesting
 - read-cache, remove_marked_cache_entries: wipe selected submodules.
 - unpack-trees: check if we can perform the operation for submodules
 - unpack-trees: pass old oid to verify_clean_submodule
 - update submodules: add submodule_move_head
 - update submodules: move up prepare_submodule_repo_env
 - submodules: introduce check to see whether to touch a submodule
 - update submodules: add a config option to determine if submodules are updated
 - update submodules: add submodule config parsing
 - connect_work_tree_and_git_dir: safely create leading directories
 - make is_submodule_populated gently
 - lib-submodule-update.sh: define tests for recursing into submodules
 - lib-submodule-update.sh: do not use ./. as submodule remote
 - lib-submodule-update.sh: reorder create_lib_submodule_repo

 "git checkout" is taught --recurse-submodules option.

 Reroll exists, but it appears it still needs minor work on top.
 cf. <20170302004759.27852-1-sbeller@google.com>


* tg/stash-push (2017-02-28) 6 commits
  (merged to 'next' on 2017-03-03 at b50fda0389)
 + stash: allow pathspecs in the no verb form
 + stash: use stash_push for no verb form
 + stash: teach 'push' (and 'create_stash') to honor pathspec
 + stash: refactor stash_create
 + stash: add test for the create command line arguments
 + stash: introduce push verb

 Allow "git stash" to take pathspec so that the local changes can be
 stashed away only partially.

 Will merge to 'master'.


* bc/object-id (2017-02-22) 19 commits
 - wt-status: convert to struct object_id
 - builtin/merge-base: convert to struct object_id
 - Convert object iteration callbacks to struct object_id
 - sha1_file: introduce an nth_packed_object_oid function
 - refs: simplify parsing of reflog entries
 - refs: convert each_reflog_ent_fn to struct object_id
 - reflog-walk: convert struct reflog_info to struct object_id
 - builtin/replace: convert to struct object_id
 - Convert remaining callers of resolve_refdup to object_id
 - builtin/merge: convert to struct object_id
 - builtin/clone: convert to struct object_id
 - builtin/branch: convert to struct object_id
 - builtin/grep: convert to struct object_id
 - builtin/fmt-merge-message: convert to struct object_id
 - builtin/fast-export: convert to struct object_id
 - builtin/describe: convert to struct object_id
 - builtin/diff-tree: convert to struct object_id
 - builtin/commit: convert to struct object_id
 - hex: introduce parse_oid_hex

 "uchar [40]" to "struct object_id" conversion continues.

 Now at v5.
 cf. <20170221234737.894681-1-sandals@crustytoothpaste.net>


* jh/mingw-openssl-sha1 (2017-02-09) 1 commit
 - mingw: use OpenSSL's SHA-1 routines

 Windows port wants to use OpenSSL's implementation of SHA-1
 routines, so let them.

 Will merge to 'next'.


* sg/completion-refs-speedup (2017-02-13) 13 commits
 - squash! completion: fill COMPREPLY directly when completing refs
 - completion: fill COMPREPLY directly when completing refs
 - completion: list only matching symbolic and pseudorefs when completing refs
 - completion: let 'for-each-ref' sort remote branches for 'checkout' DWIMery
 - completion: let 'for-each-ref' filter remote branches for 'checkout' DWIMery
 - completion: let 'for-each-ref' strip the remote name from remote branches
 - completion: let 'for-each-ref' and 'ls-remote' filter matching refs
 - completion: don't disambiguate short refs
 - completion: don't disambiguate tags and branches
 - completion: support excluding full refs
 - completion: support completing full refs after '--option=refs/<TAB>'
 - completion: wrap __git_refs() for better option parsing
 - completion: remove redundant __gitcomp_nl() options from _git_commit()

 The refs completion for large number of refs has been sped up,
 partly by giving up disambiguating ambiguous refs and partly by
 eliminating most of the shell processing between 'git for-each-ref'
 and 'ls-remote' and Bash's completion facility.

 What's the donness of this topic?


* jk/no-looking-at-dotgit-outside-repo-final (2016-10-26) 1 commit
  (merged to 'next' on 2017-02-27 at 7373a1b73d)
 + setup_git_env: avoid blind fall-back to ".git"

 This is the endgame of the topic to avoid blindly falling back to
 ".git" when the setup sequence said we are _not_ in Git repository.
 A corner case that happens to work right now may be broken by a
 call to die("BUG").

 Will cook in 'next'.


* jc/merge-drop-old-syntax (2015-04-29) 1 commit
  (merged to 'next' on 2017-02-27 at 2c0f5f73d8)
 + merge: drop 'git merge <message> HEAD <commit>' syntax

 Stop supporting "git merge <message> HEAD <commit>" syntax that has
 been deprecated since October 2007, and issues a deprecation
 warning message since v2.5.0.

 Will cook in 'next'.


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

--------------------------------------------------
[Discarded]

* jk/auto-namelen-in-interpret-branch-name (2017-02-27) 1 commit
 . interpret_branch_name(): handle auto-namelen for @{-1}

 A small bug in the code that parses @{...} has been fixed.

 This is now a part of jk/interpret-branch-name topic.
