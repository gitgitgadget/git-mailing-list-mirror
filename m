Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11566201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 19:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751304AbdBXTaI (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 14:30:08 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35407 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751377AbdBXT35 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 14:29:57 -0500
Received: by mail-pg0-f68.google.com with SMTP id 1so4080465pgz.2
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 11:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=ytRWy6ltYnX0smM7rwA0KiUx6MdJS69FBBqWe04+q9o=;
        b=MJllK2Ao7ggeGLv6V01vecTsYp1lQfw7dZArw3RSkDLh28r8HAfLDn5ZrxqN5DibGo
         lcfVhJokmhIdyGCJj5Snf2za/v+tU1UU4bMWhHL59ySKs6C1I7TbTuHLgeNlrzQ/ZCpp
         XmbKqAQ++iwCIJ7tmjTozDOMbT9DQn31oRrC8pDrVogzFS71NUa6jy8W+qvTiTe8Y/KY
         2sO/Mgvn295sRlEVA+tCmhD+MIrMnhieItIZyVhKry8MniAWwKYZO797tHVB4VWyUVeA
         BjVMTqe+pVEeWgWPO9XUceSH83FosHsAxYByFG2GlZtK3RF8Ddw1nmDvnSsYD6FMh52Q
         iHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=ytRWy6ltYnX0smM7rwA0KiUx6MdJS69FBBqWe04+q9o=;
        b=UP28nB+uwT46kMsTfd9Ff8Dd2R5L3BTmeOjyOExMI10JlSxQSwq1aGdAIJbp8QuLHl
         iKGzDS9poNBKf7mZd7s/iPmeKW6GfNJFAlt8HJOOaKyQ7FpaPIW5EJhQJIvAHHIebg1Q
         m04dDWc4c6Th2AGLSId17WiOiFR6mQ/0NiO8UnAfapDn2iBdFBogfkkYqnlJI/NQOAch
         C8REZSxtSjaFh4XEzYHcwmwjD8uObblQFCIjvmVb5hl7cH5h1QLGbhQgJgDwi7WE6GZ+
         rfCaAjA1xyLC/X+oLZ1TcJP5J4+/iLpEf1TEaY3ousLVbrVFFs9f9DDULtU2XzB9nLWF
         H65Q==
X-Gm-Message-State: AMke39ko+JxO6CslOtL9eelXd4o8QYbBDBcNIucLOth5EU62YMA1yOixHCWIEqUJOFu+mw==
X-Received: by 10.99.150.10 with SMTP id c10mr5489366pge.160.1487964556498;
        Fri, 24 Feb 2017 11:29:16 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:f06c:2e0c:850d:31b4])
        by smtp.gmail.com with ESMTPSA id a62sm16532088pgc.60.2017.02.24.11.29.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 24 Feb 2017 11:29:15 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Feb 2017, #08; Fri, 24)
X-master-at: e7e07d5a4fcc2a203d9873968ad3e6bd4d7419d7
X-next-at: 67fe103aa68d54c3706f4a9cdf52c50f21979829
Date:   Fri, 24 Feb 2017 11:29:14 -0800
Message-ID: <xmqqy3wv1j79.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What's cooking in git.git (Feb 2017, #08; Fri, 24)
--------------------------------------------------

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

v2.12 has been tagged.  Special thanks go to Dscho, who (among other
things) laid the groundwork for speeding up "rebase -i" (which I am
hoping to be finalized in the upcoming cycle) and rewrote "difftool"
in C and to Peff who was all over the place cleaning the code up,
fixing surfaced and unsurfaced bugs.  Thanks for everybody else,
too, who worked hard on the release.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* bc/blame-doc-fix (2017-02-22) 1 commit
  (merged to 'next' on 2017-02-22 at 81c0ff2283)
 + Documentation: use brackets for optional arguments

 Doc update.


* bc/worktree-doc-fix-detached (2017-02-22) 1 commit
  (merged to 'next' on 2017-02-22 at 8257025363)
 + Documentation: correctly spell git worktree --detach

 Doc update.


* dr/doc-check-ref-format-normalize (2017-02-21) 1 commit
  (merged to 'next' on 2017-02-21 at 5e88b7a93d)
 + git-check-ref-format: clarify documentation for --normalize

 Doc update.


* gp/document-dotfiles-in-templates-are-not-copied (2017-02-17) 1 commit
  (merged to 'next' on 2017-02-21 at bbfa2bb7d4)
 + init: document dotfiles exclusion on template copy

 Doc update.


* ps/doc-gc-aggressive-depth-update (2017-02-24) 1 commit
  (merged to 'next' on 2017-02-24 at f023322bbb)
 + docs/git-gc: fix default value for `--aggressiveDepth`

 Doc update.


* rt/align-add-i-help-text (2017-02-22) 1 commit
  (merged to 'next' on 2017-02-22 at a8573afb9a)
 + git add -i: replace \t with blanks in the help message

 Doc update.

--------------------------------------------------
[New Topics]

* dp/filter-branch-prune-empty (2017-02-23) 4 commits
 - p7000: add test for filter-branch with --prune-empty
 - filter-branch: fix --prune-empty on parentless commits
 - t7003: ensure --prune-empty removes entire branch when applicable
 - t7003: ensure --prune-empty can prune root commit

 "git filter-branch --prune-empty" drops a single-parent commit that
 becomes a no-op, but did not drop a root commit whose tree is empty.

 Needs review.


* jc/config-case-cmdline-take-2 (2017-02-23) 2 commits
 - config: use git_config_parse_key() in git_config_parse_parameter()
 - config: move a few helper functions up

 The code to parse "git -c VAR=VAL cmd" and set configuration
 variable for the duration of cmd had two small bugs, which have
 been fixed.

 Will merge to and then cook in 'next'.
 This supersedes jc/config-case-cmdline topic.

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


* cc/split-index-config (2016-12-26) 21 commits
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
 - config: mark an error message up for translation

 The experimental "split index" feature has gained a few
 configuration variables to make it easier to use.

 Expecting a reroll.
 cf. <20161226102222.17150-1-chriscool@tuxfamily.org>
 cf. <a1a44640-ff6c-2294-72ac-46322eff8505@ramsayjones.plus.com>
 cf. <CAP8UFD3_1EN=0EsD12Cew1MuW8yhtPAZw0M_g3wmvKFk-uGXxw@mail.gmail.com>
 cf. <CAP8UFD1wmbR_rHyqn0q=0hw6-hHYFTzr=3yxS2XS9qTdY1kWFA@mail.gmail.com>
 cf. <xmqqbmunq6mg.fsf@gitster.mtv.corp.google.com>
 cf. <CAP8UFD0bgxVrc=RGHs1GrZ_5PF4cdfhqXLMiCSJTNw9axrr=_w@mail.gmail.com>


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

* js/curl-empty-auth-set-by-default (2017-02-22) 1 commit
 - http(s): automatically try NTLM authentication first

 Flip "http.emptyAuth" on by default to help OOB experience for
 users of HTTP Negotiate authentication scheme.

 Under discussion.
 cf. <20170222233419.q3fxqmrscosumbjm@genre.crustytoothpaste.net>


* jh/send-email-one-cc (2017-02-23) 1 commit
 - send-email: only allow one address per body tag

 "Cc:" on the trailer part does not have to conform to RFC strictly,
 unlike in the e-mail header.  "git send-email" has been updated to
 ignore anything after '>' when picking addresses, to allow non-address
 cruft like " # stable 4.4" after the address.

 Will merge to and then cook in 'next'.


* jk/http-auth (2017-02-23) 1 commit
 - http: restrict auth methods to what the server advertises

 Reduce authentication round-trip over HTTP when the server supports
 just a single authentication method.

 Will merge to and then cook in 'next'.
 There is a follow-up that would supersede js/curl-empty-auth-set-by-default
 topic; as it expected to be refined further, it is not queued here yet.


* jk/ident-empty (2017-02-23) 4 commits
 - ident: do not ignore empty config name/email
 - ident: reject all-crud ident name
 - ident: handle NULL email when complaining of empty name
 - ident: mark error messages for translation

 user.email that consists of only cruft chars should have
 consistently errored out, but didn't.

 Will merge to and then cook in 'next'.


* jt/upload-pack-error-report (2017-02-23) 1 commit
 - upload-pack: report "not our ref" to client

 "git upload-pack", which is a counter-part of "git fetch", did not
 report a request for a ref that was not advertised as invalid.
 This is generally not a problem (because "git fetch" will stop
 before making such a request), but is the right thing to do.

 Will merge to and then cook in 'next'.


* jk/tempfile-ferror-fclose-confusion (2017-02-17) 1 commit
  (merged to 'next' on 2017-02-21 at 479ba0131f)
 + tempfile: set errno to a known value before calling ferror()

 A caller of tempfile API that uses stdio interface to write to
 files may ignore errors while writing, which is detected when
 tempfile is closed (with a call to ferror()).  By that time, the
 original errno that may have told us what went wrong is likely to
 be long gone and was overwritten by an irrelevant value.
 close_tempfile() now resets errno to EIO to make errno at least
 predictable.

 Will cook in 'next'.


* ah/doc-ls-files-quotepath (2017-02-22) 1 commit
 - Documentation: clarify core.quotePath and update git-ls-files doc

 Documentation for "git ls-files" did not refer to core.quotePath

 Looked good, but another reroll is still incoming?
 cf. <3c801e54-28c7-52d0-6915-ee7aaf1d89c9@gmail.com>


* jc/config-case-cmdline (2017-02-21) 3 commits
  (merged to 'next' on 2017-02-21 at 63d3652c77)
 + config: squelch stupid compiler
  (merged to 'next' on 2017-02-21 at 354f023a3a)
 + config: reject invalid VAR in 'git -c VAR=VAL command'
 + config: preserve <subsection> case for one-shot config on the command line

 The code to parse "git -c VAR=VAL cmd" and set configuration
 variable for the duration of cmd had two small bugs, which have
 been fixed.

 Will discard.


* jh/memihash-opt (2017-02-17) 5 commits
 - name-hash: remember previous dir_entry during lazy_init_name_hash
 - name-hash: specify initial size for istate.dir_hash table
 - name-hash: precompute hash values during preload-index
 - hashmap: allow memihash computation to be continued
 - name-hash: eliminate duplicate memihash call

 Expecting an update for perf?


* km/delete-ref-reflog-message (2017-02-20) 4 commits
  (merged to 'next' on 2017-02-21 at 4ee4ce3f64)
 + branch: record creation of renamed branch in HEAD's log
 + rename_ref: replace empty message in HEAD's log
 + update-ref: pass reflog message to delete_ref()
 + delete_ref: accept a reflog message argument

 "git update-ref -d" and other operations to delete references did
 not leave any entry in HEAD's reflog when the reference being
 deleted was the current branch.  This is not a problem in practice
 because you do not want to delete the branch you are currently on,
 but caused renaming of the current branch to something else not to
 be logged in a useful way.

 Will cook in 'next'.


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
 (this branch uses mh/ref-remove-empty-directory, mh/submodule-hash and nd/worktree-kill-parse-ref; is tangled with nd/files-backend-git-dir.)

 "git gc" and friends when multiple worktrees are used off of a
 single repository did not consider the index and per-worktree refs
 of other worktrees as the root for reachability traversal, making
 objects that are in use only in other worktrees to be subject to
 garbage collection.


* mm/fetch-show-error-message-on-unadvertised-object (2017-02-22) 4 commits
 - fetch-pack: add specific error for fetching an unadvertised object
 - fetch_refs_via_pack: call report_unmatched_refs
 - squash??? remove unfinished sentence
 - fetch-pack: move code to report unmatched refs to a function

 "git fetch" that requests a commit by object name, when the other
 side does not allow such an request, failed without much
 explanation.


* rl/remote-allow-missing-branch-name-merge (2017-02-21) 1 commit
  (merged to 'next' on 2017-02-22 at cbe923c8da)
 + remote: ignore failure to remove missing branch.<name>.merge

 "git remote rm X", when a branch has remote X configured as the
 value of its branch.*.remote, tried to remove branch.*.remote and
 branch.*.merge and failed if either is unset.

 Will cook in 'next'.


* vn/xdiff-func-context (2017-01-15) 1 commit
  (merged to 'next' on 2017-02-21 at 838eab8d93)
 + xdiff -W: relax end-of-file function detection

 "git diff -W" has been taught to handle the case where a new
 function is added at the end of the file better.

 Will cook in 'next'.


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
 (this branch is used by nd/prune-in-worktree; uses mh/ref-remove-empty-directory and mh/submodule-hash; is tangled with nd/files-backend-git-dir.)

 (hopefully) a beginning of safer "git worktree" that is resistant
 to "gc".

 Needs review.


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
 (this branch uses mh/ref-remove-empty-directory and mh/submodule-hash; is tangled with nd/prune-in-worktree and nd/worktree-kill-parse-ref.)

 The "submodule" specific field in the ref_store structure is
 replaced with a more generic "gitdir" that can later be used also
 when dealing with ref_store that represents the set of refs visible
 from the other worktrees.

 Needs review.


* nd/clean-preserve-errno-in-warning (2017-02-16) 1 commit
  (merged to 'next' on 2017-02-16 at c0802f7627)
 + clean: use warning_errno() when appropriate

 Some warning() messages from "git clean" were updated to show the
 errno from failed system calls.

 Will cook in 'next'.


* mm/two-more-xstrfmt (2017-02-16) 2 commits
  (merged to 'next' on 2017-02-17 at 2454ee9847)
 + bisect_next_all: convert xsnprintf to xstrfmt
 + stop_progress_msg: convert xsnprintf to xstrfmt

 Code clean-up and a string truncation fix.

 Will cook in 'next'.


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

 Needs review.


* jh/preload-index-skip-skip (2017-02-10) 1 commit
  (merged to 'next' on 2017-02-16 at 39077062f9)
 + preload-index: avoid lstat for skip-worktree items

 The preload-index code has been taught not to bother with the index
 entries that are paths that are not checked out by "sparse checkout".

 Will cook in 'next'.


* tg/stash-push (2017-02-19) 6 commits
 - stash: allow pathspecs in the no verb form
 - stash: use stash_push for no verb form
 - stash: teach 'push' (and 'create_stash') to honor pathspec
 - stash: refactor stash_create
 - stash: add test for the create command line arguments
 - stash: introduce push verb

 Allow "git stash" to take pathspec so that the local changes can be
 stashed away only partially.

 Needs review.
 cf. <xmqqmvdfh4az.fsf@gitster.mtv.corp.google.com>


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

 Now at v5; looked alright.
 cf. <20170221234737.894681-1-sandals@crustytoothpaste.net>


* jk/grep-no-index-fix (2017-02-14) 7 commits
  (merged to 'next' on 2017-02-16 at c84c927fa8)
 + grep: treat revs the same for --untracked as for --no-index
 + grep: do not diagnose misspelt revs with --no-index
 + grep: avoid resolving revision names in --no-index case
 + grep: fix "--" rev/pathspec disambiguation
 + grep: re-order rev-parsing loop
 + grep: do not unnecessarily query repo for "--"
 + grep: move thread initialization a little lower

 The code to parse the command line "git grep <patterns>... <rev>
 [[--] <pathspec>...]" has been cleaned up, and a handful of bugs
 have been fixed (e.g. we used to check "--" if it is a rev).

 Will cook in 'next'.


* jk/show-branch-lift-name-len-limit (2017-02-15) 3 commits
  (merged to 'next' on 2017-02-16 at 40d22f5f34)
 + show-branch: use skip_prefix to drop magic numbers
 + show-branch: store resolved head in heap buffer
 + show-branch: drop head_len variable

 "git show-branch" expected there were only very short branch names
 in the repository and used a fixed-length buffer to hold them
 without checking for overflow.

 Will cook in 'next'.


* lt/oneline-decoration-at-end (2017-02-21) 2 commits
  (merged to 'next' on 2017-02-21 at 35c7731ee3)
 + log: fix regression to "--source" when "--decorate" was updated
  (merged to 'next' on 2017-02-16 at 5854e58811)
 + show decorations at the end of the line

 The output from "git log --oneline --decorate" has been updated to
 show the extra information at the end of the line, not near the
 front.

 Will cook in 'next'.
 Perhaps this is not such a cool idea?
 cf. <CA+55aFwT2HUBzZO8Gpt9tHoJtdRxv9oe3TDoSH5jcEOixRNBXg@mail.gmail.com>


* jn/remote-helpers-with-git-dir (2017-02-14) 2 commits
  (merged to 'next' on 2017-02-16 at c093c543c4)
 + remote helpers: avoid blind fall-back to ".git" when setting GIT_DIR
 + remote: avoid reading $GIT_DIR config in non-repo

 "git ls-remote" and "git archive --remote" are designed to work
 without being in a directory under Git's control.  However, recent
 updates revealed that we randomly look into a directory called
 .git/ without actually doing necessary set-up when working in a
 repository.  Stop doing so.

 Will cook in 'next'.


* jk/alternate-ref-optim (2017-02-08) 11 commits
  (merged to 'next' on 2017-02-10 at f26f32cff6)
 + receive-pack: avoid duplicates between our refs and alternates
 + receive-pack: treat namespace .have lines like alternates
 + receive-pack: fix misleading namespace/.have comment
 + receive-pack: use oidset to de-duplicate .have lines
 + add oidset API
 + fetch-pack: cache results of for_each_alternate_ref
 + for_each_alternate_ref: replace transport code with for-each-ref
 + for_each_alternate_ref: pass name/oid instead of ref struct
 + for_each_alternate_ref: use strbuf for path allocation
 + for_each_alternate_ref: stop trimming trailing slashes
 + for_each_alternate_ref: handle failure from real_pathdup()

 Optimizes resource usage while enumerating refs from alternate
 object store, to help receiving end of "push" that hosts a
 repository with many "forks".

 Will cook in 'next'.


* lt/pathspec-negative (2017-02-10) 2 commits
  (merged to 'next' on 2017-02-10 at 8ea7874076)
 + pathspec: don't error out on all-exclusionary pathspec patterns
 + pathspec magic: add '^' as alias for '!'

 The "negative" pathspec feature was somewhat more cumbersome to use
 than necessary in that its short-hand used "!" which needed to be
 escaped from shells, and it required "exclude from what?" specified.

 Will cook in 'next'.


* js/rebase-helper (2017-02-09) 2 commits
  (merged to 'next' on 2017-02-14 at ae2474048e)
 + rebase -i: use the rebase--helper builtin
 + rebase--helper: add a builtin helper for interactive rebases

 "git rebase -i" starts using the recently updated "sequencer" code.

 Will cook in 'next'.
 The change itself is small, but what it enables is rather a large
 body of new code.  We are getting there ;-)


* mh/submodule-hash (2017-02-13) 9 commits
  (merged to 'next' on 2017-02-14 at 43f2dcbe29)
 + read_loose_refs(): read refs using resolve_ref_recursively()
 + files_ref_store::submodule: use NULL for the main repository
 + base_ref_store_init(): remove submodule argument
 + refs: push the submodule attribute down
 + refs: store submodule ref stores in a hashmap
 + register_ref_store(): new function
 + refs: remove some unnecessary handling of submodule == ""
 + refs: make some ref_store lookup functions private
 + refs: reorder some function definitions
 (this branch is used by nd/files-backend-git-dir, nd/prune-in-worktree and nd/worktree-kill-parse-ref.)

 Code and design clean-up for the refs API.

 Will cook in 'next'.
 The tip one is newer than the one posted to the list but was sent
 privately by the author via his GitHub repository.


* jh/mingw-openssl-sha1 (2017-02-09) 1 commit
  (merged to 'next' on 2017-02-10 at 084b3d8503)
 + mingw: use OpenSSL's SHA-1 routines

 Windows port wants to use OpenSSL's implementation of SHA-1
 routines, so let them.

 Will cook in 'next'.
 cf. <31bb0b9f-d498-24b3-57d5-9f34cb8e3914@kdbg.org>


* dt/gc-ignore-old-gc-logs (2017-02-13) 1 commit
  (merged to 'next' on 2017-02-16 at 8f48e1b405)
 + gc: ignore old gc.log files

 A "gc.log" file left by a backgrounded "gc --auto" disables further
 automatic gc; it has been taught to run at least once a day (by
 default) by ignoring a stale "gc.log" file that is too old.

 Will cook in 'next'.
 This is v6 posted on Feb 10th.


* js/git-path-in-subdir (2017-02-17) 2 commits
  (merged to 'next' on 2017-02-17 at b3c3b2dce6)
 + rev-parse: fix several options when running in a subdirectory
 + rev-parse tests: add tests executed from a subdirectory

 The "--git-path", "--git-common-dir", and "--shared-index-path"
 options of "git rev-parse" did not produce usable output.  They are
 now updated to show the path to the correct file, relative to where
 the caller is.

 Will cook in 'next'.


* mh/ref-remove-empty-directory (2017-01-07) 23 commits
  (merged to 'next' on 2017-02-10 at bcfd359e95)
 + files_transaction_commit(): clean up empty directories
 + try_remove_empty_parents(): teach to remove parents of reflogs, too
 + try_remove_empty_parents(): don't trash argument contents
 + try_remove_empty_parents(): rename parameter "name" -> "refname"
 + delete_ref_loose(): inline function
 + delete_ref_loose(): derive loose reference path from lock
 + log_ref_write_1(): inline function
 + log_ref_setup(): manage the name of the reflog file internally
 + log_ref_write_1(): don't depend on logfile argument
 + log_ref_setup(): pass the open file descriptor back to the caller
 + log_ref_setup(): improve robustness against races
 + log_ref_setup(): separate code for create vs non-create
 + log_ref_write(): inline function
 + rename_tmp_log(): improve error reporting
 + rename_tmp_log(): use raceproof_create_file()
 + lock_ref_sha1_basic(): use raceproof_create_file()
 + lock_ref_sha1_basic(): inline constant
 + raceproof_create_file(): new function
 + safe_create_leading_directories(): set errno on SCLD_EXISTS
 + safe_create_leading_directories_const(): preserve errno
 + t5505: use "for-each-ref" to test for the non-existence of references
 + refname_is_safe(): correct docstring
 + files_rename_ref(): tidy up whitespace
 (this branch is used by nd/files-backend-git-dir, nd/prune-in-worktree and nd/worktree-kill-parse-ref.)

 Deletion of a branch "foo/bar" could remove .git/refs/heads/foo
 once there no longer is any other branch whose name begins with
 "foo/", but we didn't do so so far.  Now we do.

 Will cook in 'next'.


* cw/tag-reflog-message (2017-02-08) 1 commit
  (merged to 'next' on 2017-02-10 at 3968b3a58b)
 + tag: generate useful reflog message

 "git tag", because refs/tags/* doesn't keep reflog by default, did
 not leave useful message when adding a new entry to reflog.

 Will cook in 'next'.


* sg/completion (2017-02-13) 22 commits
  (merged to 'next' on 2017-02-13 at 118c192874)
 + completion: restore removed line continuating backslash
  (merged to 'next' on 2017-02-10 at 55b2785d89)
 + completion: cache the path to the repository
 + completion: extract repository discovery from __gitdir()
 + completion: don't guard git executions with __gitdir()
 + completion: consolidate silencing errors from git commands
 + completion: don't use __gitdir() for git commands
 + completion: respect 'git -C <path>'
 + rev-parse: add '--absolute-git-dir' option
 + completion: fix completion after 'git -C <path>'
 + completion: don't offer commands when 'git --opt' needs an argument
 + completion: list short refs from a remote given as a URL
 + completion: don't list 'HEAD' when trying refs completion outside of a repo
 + completion: list refs from remote when remote's name matches a directory
 + completion: respect 'git --git-dir=<path>' when listing remote refs
 + completion: fix most spots not respecting 'git --git-dir=<path>'
 + completion: ensure that the repository path given on the command line exists
 + completion tests: add tests for the __git_refs() helper function
 + completion tests: check __gitdir()'s output in the error cases
 + completion tests: consolidate getting path of current working directory
 + completion tests: make the $cur variable local to the test helper functions
 + completion tests: don't add test cruft to the test repository
 + completion: improve __git_refs()'s in-code documentation
 (this branch is used by sg/completion-refs-speedup.)

 Clean-up and updates to command line completion (in contrib/).

 Will cook in 'next'.


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
 (this branch uses sg/completion.)

 The refs completion for large number of refs has been sped up,
 partly by giving up disambiguating ambiguous refs and partly by
 eliminating most of the shell processing between 'git for-each-ref'
 and 'ls-remote' and Bash's completion facility.

 Will hold.


* sk/parse-remote-cleanup (2017-02-21) 2 commits
  (merged to 'next' on 2017-02-21 at 302250072e)
 + Revert "parse-remote: remove reference to unused op_prep"
  (merged to 'next' on 2017-02-06 at 6ec89f72d5)
 + parse-remote: remove reference to unused op_prep

 Code clean-up.

 Will discard.
 There may be third-party scripts that are dot-sourcing this one.


* jk/delta-chain-limit (2017-01-27) 2 commits
  (merged to 'next' on 2017-02-06 at 9ff36ae9b2)
 + pack-objects: convert recursion to iteration in break_delta_chain()
 + pack-objects: enforce --depth limit in reused deltas

 "git repack --depth=<n>" for a long time busted the specified depth
 when reusing delta from existing packs.  This has been corrected.

 Will cook in 'next'.


* mm/merge-rename-delete-message (2017-01-30) 1 commit
  (merged to 'next' on 2017-02-10 at 8bf8146029)
 + merge-recursive: make "CONFLICT (rename/delete)" message show both paths

 When "git merge" detects a path that is renamed in one history
 while the other history deleted (or modified) it, it now reports
 both paths to help the user understand what is going on in the two
 histories being merged.

 Will cook in 'next'.


* ps/urlmatch-wildcard (2017-02-01) 5 commits
  (merged to 'next' on 2017-02-10 at 2ed9ea48ee)
 + urlmatch: allow globbing for the URL host part
 + urlmatch: include host in urlmatch ranking
 + urlmatch: split host and port fields in `struct url_info`
 + urlmatch: enable normalization of URLs with globs
 + mailmap: add Patrick Steinhardt's work address

 The <url> part in "http.<url>.<variable>" configuration variable
 can now be spelled with '*' that serves as wildcard.
 E.g. "http.https://*.example.com.proxy" can be used to specify the
 proxy used for https://a.example.com, https://b.example.com, etc.,
 i.e. any host in the example.com domain.

 Will cook in 'next'.


* sf/putty-w-args (2017-02-10) 5 commits
  (merged to 'next' on 2017-02-14 at 7f157e7020)
 + connect.c: stop conflating ssh command names and overrides
 + connect: Add the envvar GIT_SSH_VARIANT and ssh.variant config
 + git_connect(): factor out SSH variant handling
 + connect: rename tortoiseplink and putty variables
 + connect: handle putty/plink also in GIT_SSH_COMMAND

 The command line options for ssh invocation needs to be tweaked for
 some implementations of SSH (e.g. PuTTY plink wants "-P <port>"
 while OpenSSH wants "-p <port>" to specify port to connect to), and
 the variant was guessed when GIT_SSH environment variable is used
 to specify it.  The logic to guess now applies to the command
 specified by the newer GIT_SSH_COMMAND and also core.sshcommand
 configuration variable, and comes with an escape hatch for users to
 deal with misdetected cases.

 Will cook in 'next'.


* jk/describe-omit-some-refs (2017-01-23) 5 commits
  (merged to 'next' on 2017-01-23 at f8a14b4996)
 + describe: teach describe negative pattern matches
 + describe: teach --match to accept multiple patterns
 + name-rev: add support to exclude refs by pattern match
 + name-rev: extend --refs to accept multiple patterns
 + doc: add documentation for OPT_STRING_LIST

 "git describe" and "git name-rev" have been taught to take more
 than one refname patterns to restrict the set of refs to base their
 naming output on, and also learned to take negative patterns to
 name refs not to be used for naming via their "--exclude" option.

 Will cook in 'next'.


* bw/attr (2017-02-01) 27 commits
  (merged to 'next' on 2017-02-14 at d35c1d7e4a)
 + attr: reformat git_attr_set_direction() function
 + attr: push the bare repo check into read_attr()
 + attr: store attribute stack in attr_check structure
 + attr: tighten const correctness with git_attr and match_attr
 + attr: remove maybe-real, maybe-macro from git_attr
 + attr: eliminate global check_all_attr array
 + attr: use hashmap for attribute dictionary
 + attr: change validity check for attribute names to use positive logic
 + attr: pass struct attr_check to collect_some_attrs
 + attr: retire git_check_attrs() API
 + attr: convert git_check_attrs() callers to use the new API
 + attr: convert git_all_attrs() to use "struct attr_check"
 + attr: (re)introduce git_check_attr() and struct attr_check
 + attr: rename function and struct related to checking attributes
 + attr.c: outline the future plans by heavily commenting
 + Documentation: fix a typo
 + attr.c: add push_stack() helper
 + attr: support quoting pathname patterns in C style
 + attr.c: plug small leak in parse_attr_line()
 + attr.c: tighten constness around "git_attr" structure
 + attr.c: simplify macroexpand_one()
 + attr.c: mark where #if DEBUG ends more clearly
 + attr.c: complete a sentence in a comment
 + attr.c: explain the lack of attr-name syntax check in parse_attr()
 + attr.c: update a stale comment on "struct match_attr"
 + attr.c: use strchrnul() to scan for one line
 + commit.c: use strchrnul() to scan for one line

 The gitattributes machinery is being taught to work better in a
 multi-threaded environment.

 Will cook in 'next'.


* kn/ref-filter-branch-list (2017-02-07) 21 commits
  (merged to 'next' on 2017-02-10 at 794bb8284d)
 + ref-filter: resurrect "strip" as a synonym to "lstrip"
  (merged to 'next' on 2017-01-31 at e7592a5461)
 + branch: implement '--format' option
 + branch: use ref-filter printing APIs
 + branch, tag: use porcelain output
 + ref-filter: allow porcelain to translate messages in the output
 + ref-filter: add an 'rstrip=<N>' option to atoms which deal with refnames
 + ref-filter: modify the 'lstrip=<N>' option to work with negative '<N>'
 + ref-filter: Do not abruptly die when using the 'lstrip=<N>' option
 + ref-filter: rename the 'strip' option to 'lstrip'
 + ref-filter: make remote_ref_atom_parser() use refname_atom_parser_internal()
 + ref-filter: introduce refname_atom_parser()
 + ref-filter: introduce refname_atom_parser_internal()
 + ref-filter: make "%(symref)" atom work with the ':short' modifier
 + ref-filter: add support for %(upstream:track,nobracket)
 + ref-filter: make %(upstream:track) prints "[gone]" for invalid upstreams
 + ref-filter: introduce format_ref_array_item()
 + ref-filter: move get_head_description() from branch.c
 + ref-filter: modify "%(objectname:short)" to take length
 + ref-filter: implement %(if:equals=<string>) and %(if:notequals=<string>)
 + ref-filter: include reference to 'used_atom' within 'atom_value'
 + ref-filter: implement %(if), %(then), and %(else) atoms

 The code to list branches in "git branch" has been consolidated
 with the more generic ref-filter API.

 Will cook in 'next'.


* jk/no-looking-at-dotgit-outside-repo-final (2016-10-26) 1 commit
  (merged to 'next' on 2016-12-05 at 0c77e39cd5)
 + setup_git_env: avoid blind fall-back to ".git"

 Originally merged to 'next' on 2016-10-26

 This is the endgame of the topic to avoid blindly falling back to
 ".git" when the setup sequence said we are _not_ in Git repository.
 A corner case that happens to work right now may be broken by a
 call to die("BUG").

 Will cook in 'next'.


* jc/merge-drop-old-syntax (2015-04-29) 1 commit
  (merged to 'next' on 2016-12-05 at 041946dae0)
 + merge: drop 'git merge <message> HEAD <commit>' syntax

 Originally merged to 'next' on 2016-10-11

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

* sb/push-make-submodule-check-the-default (2017-01-26) 2 commits
  (merged to 'next' on 2017-01-26 at 5f4715cea6)
 + Revert "push: change submodule default to check when submodules exist"
  (merged to 'next' on 2016-12-12 at 1863e05af5)
 + push: change submodule default to check when submodules exist

 Turn the default of "push.recurseSubmodules" to "check" when
 submodules seem to be in use.

 Retracted.


* ls/submodule-config-ucase (2017-02-15) 2 commits
 . submodule config does not apply to upper case submodules?
 . t7400: cleanup "submodule add clone shallow submodule" test

 Demonstrate a breakage in handling submodule.UPPERCASENAME.update
 configuration variables.

 Superseded by jc/config-case-cmdline.
