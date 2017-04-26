Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58596207E4
	for <e@80x24.org>; Wed, 26 Apr 2017 05:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1434929AbdDZFTH (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 01:19:07 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33599 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1434922AbdDZFS5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 01:18:57 -0400
Received: by mail-pf0-f196.google.com with SMTP id c198so14078334pfc.0
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 22:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:user-agent:mime-version;
        bh=l5uUj48DZXZdZinDp6cV+W4RT3erzAZiOmT7gpR5HVU=;
        b=uKKZ64N0dJDmzsGGKJ1gWe+DzyIeubIb1ayLRceSocUiQsSsvXb631VQqIUAlnzuYY
         /VnW3m/qfmZFzbOTterlmONFXb+BycD808TXyDZlvgbMKXsJwoQY7ytSEr90YgLpVxde
         EDvQKOF5vTQ9H7agvXH4dtyrJfzj8zdNLahxTNAcyEzFK9ZSUMbiPbIJbY/BUx5h2z/n
         1KJmTr9rqzy+YqWWGzBqkp2weBDPN0lsdx79gGScJ/6FKvK0dn3zC9y1t2+zBBkmznu3
         3RSdnFAbNgvX5tKW0mx89nfcIaMLqTP0cSDdchyqS+vklewpi9BGwLQKuHWChrST5Vy8
         lEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :user-agent:mime-version;
        bh=l5uUj48DZXZdZinDp6cV+W4RT3erzAZiOmT7gpR5HVU=;
        b=XzpN7cNtOAOIo0fj6/3v8IiBlyx2VdNpGP7wvSqkhgnRyu/wCNeL2h9PUieUSFsW7I
         flXnSdYiNxtyYKHGluhu9Y9bCUewtRnvAW0kIhuOtYDVazzssrqe59C3F9+zxv6WEdQS
         2c3iFwSxmOYTEEECzhX/r/O+OCjBKCBgwJgcD/vgfu1s06n7pdMvkijN0yLvby00k6n7
         hjzF7kicAChUQpOGwYF8qOKdkpUSxWIY1xT9Naf4R+v9ay5KetKKaERvF5O51EzxgFCT
         /r/fT9lhw6lFrTo1X3LmMWeraGo13AnxkVt7Q9ysMCo1304rXJeJDbrCxbUvJEkaFXBh
         YQDA==
X-Gm-Message-State: AN3rC/6WB2UgRZSI1xSnVxHGHOpXVpX1NoWQy5+L903+LnfO+vSSbgXg
        NTN8IfAATmfwKQ==
X-Received: by 10.98.0.7 with SMTP id 7mr27164884pfa.127.1493183934525;
        Tue, 25 Apr 2017 22:18:54 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3179:d004:20b:b383])
        by smtp.gmail.com with ESMTPSA id v13sm35370635pgo.44.2017.04.25.22.18.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 25 Apr 2017 22:18:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Apr 2017, #05; Tue, 25)
X-master-at: e2cb6ab84c94f147f1259260961513b40c36108a
X-next-at: 87b477812d19226f71786936237a1aa4e7df378e
Date:   Tue, 25 Apr 2017 22:18:51 -0700
Message-ID: <xmqqzif3rbk4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
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
[Graduated to "master"]

* jh/verify-index-checksum-only-in-fsck (2017-04-15) 1 commit
  (merged to 'next' on 2017-04-19 at a089b97d34)
 + read-cache: force_verify_index_checksum

 The index file has a trailing SHA-1 checksum to detect file
 corruption, and historically we checked it every time the index
 file is used.  Omit the validation during normal use, and instead
 verify only in "git fsck".

 There is an update to the test script as a follow-up.


* bw/submodule-with-bs-path (2017-04-16) 1 commit
  (merged to 'next' on 2017-04-19 at 692775477b)
 + submodule: prevent backslash expantion in submodule names

 "git submodule" script does not work well with strange pathnames.
 Protect it from a path with slashes in them, at least.


* dt/http-postbuffer-can-be-large (2017-04-13) 1 commit
  (merged to 'next' on 2017-04-19 at dc9de26fc9)
 + http.postbuffer: allow full range of ssize_t values

 Allow the http.postbuffer configuration variable to be set to a
 size that can be expressed in size_t, which can be larger than
 ulong on some platforms.


* dt/xgethostname-nul-termination (2017-04-18) 2 commits
  (merged to 'next' on 2017-04-19 at 4035f442cc)
 + xgethostname: handle long hostnames
 + use HOST_NAME_MAX to size buffers for gethostname(2)

 gethostname(2) may not NUL terminate the buffer if hostname does
 not fit; unfortunately there is no easy way to see if our buffer
 was too small, but at least this will make sure we will not end up
 using garbage past the end of the buffer.


* jh/string-list-micro-optim (2017-04-15) 1 commit
  (merged to 'next' on 2017-04-19 at 2a5e339df9)
 + string-list: use ALLOC_GROW macro when reallocing string_list

 The string-list API used a custom reallocation strategy that was
 very inefficient, instead of using the usual ALLOC_GROW() macro,
 which has been fixed.


* jh/unpack-trees-micro-optim (2017-04-15) 1 commit
  (merged to 'next' on 2017-04-19 at 970c47a2f9)
 + unpack-trees: avoid duplicate ODB lookups during checkout

 In a 2- and 3-way merge of trees, more than one source trees often
 end up sharing an identical subtree; optimize by not reading the
 same tree multiple times in such a case.


* jk/loose-object-fsck (2017-04-16) 1 commit
  (merged to 'next' on 2017-04-19 at 0cc7810018)
 + sha1_file: remove an used fd variable

 Code cleanup.


* jk/ls-files-recurse-submodules-fix (2017-04-18) 2 commits
  (merged to 'next' on 2017-04-19 at d4682ceaae)
 + ls-files: fix path used when recursing into submodules
 + ls-files: fix recurse-submodules with nested submodules

 "ls-files --recurse-submodules" did not quite work well in a
 project with nested submodules.


* jk/quarantine-received-objects (2017-04-16) 3 commits
  (merged to 'next' on 2017-04-19 at 2c6fcf1d6d)
 + refs: reject ref updates while GIT_QUARANTINE_PATH is set
 + receive-pack: document user-visible quarantine effects
 + receive-pack: drop tmp_objdir_env from run_update_hook

 Add finishing touches to a recent topic.


* jk/snprintf-cleanups (2017-04-17) 1 commit
  (merged to 'next' on 2017-04-19 at 4a18ea9971)
 + replace: plug a memory leak

 Hotfix for a topic that is already in 'master'.


* jt/fetch-pack-error-reporting (2017-04-17) 1 commit
  (merged to 'next' on 2017-04-19 at 6da61f7236)
 + fetch-pack: show clearer error message upon ERR

 "git fetch-pack" was not prepared to accept ERR packet that the
 upload-pack can send with a human-readable error message.  It
 showed the packet contents with ERR prefix, so there was no data
 loss, but it was redundant to say "ERR" in an error message.


* km/t1400-modernization (2017-04-16) 1 commit
  (merged to 'next' on 2017-04-19 at 7490be39bf)
 + t1400: use consistent style for test_expect_success calls

 Code cleanup.


* nd/conditional-config-include (2017-04-14) 2 commits
  (merged to 'next' on 2017-04-19 at 2e94c40b46)
 + config: resolve symlinks in conditional include's patterns
 + path.c: and an option to call real_path() in expand_user_path()

 $GIT_DIR may in some cases be normalized with all symlinks resolved
 while "gitdir" path expansion in the pattern does not receive the
 same treatment, leading to incorrect mismatch.  This has been fixed.


* rs/misc-cppcheck-fixes (2017-04-17) 3 commits
  (merged to 'next' on 2017-04-19 at e8fca7f593)
 + server-info: avoid calling fclose(3) twice in update_info_file()
 + files_for_each_reflog_ent_reverse(): close stream and free strbuf on error
 + am: close stream on error, but not stdin

 Various small fixes.


* sb/checkout-recurse-submodules (2017-04-17) 1 commit
  (merged to 'next' on 2017-04-19 at 414e18fd9b)
 + submodule: remove a superfluous second check for the "new" variable

 Code cleanup.


* sr/http-proxy-configuration-fix (2017-04-13) 2 commits
  (merged to 'next' on 2017-04-19 at d8f507e951)
 + http: fix the silent ignoring of proxy misconfiguraion
 + http: honor empty http.proxy option to bypass proxy

 "http.proxy" set to an empty string is used to disable the usage of
 proxy.  We broke this early last year.


* tb/doc-eol-normalization (2017-04-13) 1 commit
  (merged to 'next' on 2017-04-19 at fe15d04d0a)
 + gitattributes.txt: document how to normalize the line endings

 Doc update.


* xy/format-patch-base (2017-04-17) 1 commit
  (merged to 'next' on 2017-04-19 at c10723d486)
 + doc: trivial typo in git-format-patch.txt

 Doc cleanup.

--------------------------------------------------
[New Topics]

* jh/verify-index-checksum-only-in-fsck (2017-04-25) 1 commit
 - t1450: avoid use of "sed" on the index, which is a binary file

 Update an unportable constructin a new test.

 Will merge to 'next' and then to 'master'.


* dt/gc-ignore-old-gc-logs (2017-04-24) 3 commits
 - test-lib: retire $remove_trash variable
 - test-lib.sh: do not barf under --debug at the end of the test
 - test-lib: abort when can't remove trash directory

 An attempt to allow us notice "fishy" situation where we fail to
 remove the temporary directory used during the test.

 Will merge to 'next'.


* jk/war-on-git-path (2017-04-20) 6 commits
  (merged to 'next' on 2017-04-23 at 212e0a58ff)
 + am: drop "dir" parameter from am_state_init
 + replace strbuf_addstr(git_path()) with git_path_buf()
 + replace xstrdup(git_path(...)) with git_pathdup(...)
 + use git_path_* helper functions
 + branch: add edit_description() helper
 + bisect: add git_path_bisect_terms helper

 While handy, "git_path()" is a dangerous function to use as a
 callsite that uses it safely one day can be broken by changes
 to other code that calls it.  Reduction of its use continues.

 Will merge to 'master'.


* nd/fopen-errors (2017-04-23) 17 commits
 - warn_failure_to_open_read_optional_path(): a new helper
 - t1308: add a test case on open a config directory
 - config.c: handle error on failing to fopen()
 - xdiff-interface.c: report errno on failure to stat() or fopen()
 - wt-status.c: report error on failure to fopen()
 - server-info: report error on failure to fopen()
 - sequencer.c: report error on failure to fopen()
 - rerere.c: report correct errno
 - rerere.c: report error on failure to fopen()
 - remote.c: report error on failure to fopen()
 - commit.c: report error on failure to fopen() the graft file
 - log: report errno on failure to fopen() a file
 - clone: use xfopen() instead of fopen()
 - blame: report error on open if graft_file is a directory
 - bisect: report on fopen() error
 - config.mak.uname: set FREAD_READS_DIRECTORIES for Linux and FreeBSD
 - git_fopen: fix a sparse 'not declared' warning

 We often try to open a file for reading whose existence is
 optional, and silently ignore errors from open/fopen; report such
 errors if they are not due to missing files.

 Expecting a reroll that would be much simplified thanks to a higher
 level helper.

 cf. <xmqqk26e5swj.fsf@gitster.mtv.corp.google.com>
 cf. <CACsJy8D1LuH6qVp15MSkCM_oQphVUUK0r9SeKC5AzX+9Xi2dcw@mail.gmail.com>


* dt/raise-core-packed-git-limit (2017-04-20) 1 commit
 - Increase core.packedGitLimit

 Raise the default packed-git limit value on larger platforms to
 avoid "git fetch" from a (recoverable) failure while "gc" is
 running in parallel.

 Will merge to 'next'.


* jk/complete-checkout-sans-dwim-remote (2017-04-23) 1 commit
 - completion: optionally disable checkout DWIM

 Completion for "git checkout <branch>" that auto-creates the branch
 out of a remote tracking branch can now be disabled, as this
 completion often gets in the way when completing to checkout an
 existing local branch that happens to share the same prefix with
 bunch of remote tracking branches.

 Will merge to 'next'.


* jk/update-links-in-docs (2017-04-20) 6 commits
  (merged to 'next' on 2017-04-23 at f64249bbdf)
 + docs/bisect-lk2009: update java code conventions link
 + docs/bisect-lk2009: update nist report link
 + docs/archimport: quote sourcecontrol.net reference
 + gitcore-tutorial: update broken link
 + doc: replace or.cz gitwiki link with git.wiki.kernel.org
 + doc: use https links to avoid http redirect

 Many stale HTTP(s) links have been updated in our documentation.

 Will merge to 'next'.


* js/larger-timestamps (2017-04-24) 8 commits
 - use uintmax_t for timestamps
 - date.c: abort if the system time cannot handle one of our timestamps
 - timestamp_t: introduce a new data type for timestamps
 - PRItime: introduce a new "printf format" for timestamps
 - parse_timestamp(): specify explicitly where we parse timestamps
 - t0006 & t5000: skip "far in the future" test when time_t is too limited
 - t0006 & t5000: prepare for 64-bit timestamps
 - ref-filter: avoid using `unsigned long` for catch-all data type

 Some platforms have ulong that is smaller than time_t, and our
 historical use of ulong for timestamp would mean they cannot
 represent some timestamp that the platform allows.  Invent a
 separate and dedicated timestamp_t (so that we can distingiuish
 timestamps and a vanilla ulongs, which along is already a good
 move), and then declare uintmax_t is the type to be used as the
 timestamp_t

 At v5.
 cf. <cover.1493042239.git.johannes.schindelin@gmx.de>


* sf/putty-w-args (2017-04-20) 1 commit
  (merged to 'next' on 2017-04-23 at fdafbe6b73)
 + connect.c: fix leak in handle_ssh_variant

 Plug a memleak.

 Will merge to 'next'.


* ab/align-perf-descriptions (2017-04-23) 1 commit
 - t/perf: correctly align non-ASCII descriptions in output

 Output from perf tests have been updated to align their titles.

 Will merge to 'next'.


* ab/grep-pcre-v2 (2017-04-25) 19 commits
 - Makefile & configure: make PCRE v2 the default PCRE implementation
 - grep: remove support for concurrent use of both PCRE v1 & v2
 - grep: add support for PCRE v2
 - grep: add support for the PCRE v1 JIT API
 - perf: add a performance comparison test of grep -E and -P
 - grep: change the internal PCRE code & header names to be PCRE1
 - grep: change the internal PCRE macro names to be PCRE1
 - test-lib: rename the LIBPCRE prerequisite to PCRE
 - grep: make grep.patternType=[pcre|pcre1] a synonym for "perl"
 - grep & rev-list doc: stop promising libpcre for --perl-regexp
 - log: add -P as a synonym for --perl-regexp
 - log: add exhaustive tests for pattern style options & config
 - grep: add a test for backreferences in PCRE patterns
 - Makefile & configure: reword outdated comment about PCRE
 - grep: remove redundant `regflags &= ~REG_EXTENDED` assignments
 - grep: remove redundant regflags assignment under PCRE
 - grep: submodule-related case statements should die if new fields are added
 - grep: add tests for grep pattern types being passed to submodules
 - grep: amend submodule recursion test in preparation for rx engine testing

 PCRE2, which has an API different from and incompatible with PCRE,
 can now be chosen to support "grep -P -e '<pattern>'" and friends.


* bc/object-id (2017-04-23) 53 commits
 - object: convert parse_object* to take struct object_id
 - tree: convert parse_tree_indirect to struct object_id
 - sequencer: convert do_recursive_merge to struct object_id
 - diff-lib: convert do_diff_cache to struct object_id
 - builtin/ls-tree: convert to struct object_id
 - merge: convert checkout_fast_forward to struct object_id
 - sequencer: convert fast_forward_to to struct object_id
 - builtin/ls-files: convert overlay_tree_on_cache to object_id
 - builtin/read-tree: convert to struct object_id
 - sha1_name: convert internals of peel_onion to object_id
 - upload-pack: convert remaining parse_object callers to object_id
 - revision: convert remaining parse_object callers to object_id
 - revision: rename add_pending_sha1 to add_pending_oid
 - http-push: convert process_ls_object and descendants to object_id
 - refs/files-backend: convert many internals to struct object_id
 - refs: convert struct ref_update to use struct object_id
 - ref-filter: convert some static functions to struct object_id
 - Convert struct ref_array_item to struct object_id
 - Convert the verify_pack callback to struct object_id
 - Convert lookup_tag to struct object_id
 - log-tree: convert to struct object_id
 - Convert lookup_tree to struct object_id
 - builtin/reflog: convert tree_is_complete to take struct object_id
 - tree: convert read_tree_1 to use struct object_id internally
 - Convert lookup_blob to struct object_id
 - Convert remaining callers of lookup_blob to object_id
 - builtin/unpack-objects: convert to struct object_id
 - pack: convert struct pack_idx_entry to struct object_id
 - Convert lookup_commit* to struct object_id
 - Convert remaining callers of lookup_commit_reference* to object_id
 - builtin/tag: convert to struct object_id
 - sequencer: convert some functions to struct object_id
 - shallow: convert shallow registration functions to object_id
 - revision: convert prepare_show_merge to struct object_id
 - notes-utils: convert internals to struct object_id
 - http-push: convert some static functions to struct object_id
 - tag: convert parse_tag_buffer to struct object_id
 - builtin/verify-commit: convert to struct object_id
 - reflog_expire: convert to struct object_id
 - parse-options-cb: convert to struct object_id
 - notes-cache: convert to struct object_id
 - submodule: convert merge_submodule to use struct object_id
 - fast-import: convert to struct object_id
 - fast-import: convert internal structs to struct object_id
 - builtin/rev-parse: convert to struct object_id
 - builtin/blame: convert static function to struct object_id
 - branch: convert to struct object_id
 - bundle: convert to struct object_id
 - builtin/prune: convert to struct object_id
 - builtin/name-rev: convert to struct object_id
 - Convert struct cache_tree to use struct object_id
 - Clean up outstanding object_id transforms.
 - fetch-pack: convert to struct object_id

 Conversion from uchar[20] to struct object_id continues.


* jk/no-null-sha1-in-cache-tree (2017-04-23) 1 commit
 - cache-tree: reject entries with null sha1

 Tighten code to update cache-tree so that we won't accidentally
 write out any 0{40} entry in the tree object.


* rg/a-the-typo (2017-04-23) 1 commit
 - NEEDSSIGNOFF: fix minor typing mistakes

 Typofix.

 Needs sign-off.


* jk/prio-queue-avoid-swap-with-self (2017-04-24) 1 commit
 - prio_queue_reverse: don't swap elements with themselves

 Code clean-up.

 Will merge to 'next'.


* jk/submodule-init-segv-fix (2017-04-24) 1 commit
 - submodule_init: die cleanly on submodules without url defined

 Fix a segv in 'submodule init' when url is not given for a submodule.

 Will merge to 'next'.


* rs/large-zip (2017-04-24) 5 commits
 - archive-zip: support files bigger than 4GB
 - archive-zip: support archives bigger than 4GB
 - archive-zip: write ZIP dir entry directly to strbuf
 - archive-zip: use strbuf for ZIP directory
 - archive-zip: add tests for big ZIP archives

 "git archive --format=zip" learned to use zip64 extension when
 necessary to go beyond the 4GB limit.

 Will merge to 'next'.


* jc/checkout-working-tree-only (2017-04-25) 1 commit
 - checkout: add --working-tree-only option

 "git checkout <tree-ish> <pathspec>" learned a variant that does
 not update the index when doing its thing.


* js/rebase-i-final (2017-04-25) 9 commits
 - rebase -i: rearrange fixup/squash lines using the rebase--helper
 - t3415: test fixup with wrapped oneline
 - rebase -i: skip unnecessary picks using the rebase--helper
 - rebase -i: check for missing commits in the rebase--helper
 - t3404: relax rebase.missingCommitsCheck tests
 - rebase -i: also expand/collapse the SHA-1s via the rebase--helper
 - rebase -i: do not invent onelines when expanding/collapsing SHA-1s
 - rebase -i: remove useless indentation
 - rebase -i: generate the script via rebase--helper

 The final batch to "git rebase -i" updates to move more code from
 the shell script to C.


* jt/use-trailer-api-in-commands (2017-04-25) 2 commits
 - SQUASH??? suggested by jrnieder
 - sequencer: require trailing NL in footers

 "git cherry-pick" and other uses of the sequencer machinery
 mishandled a trailer block whose last line is an incomplete line.
 This has been fixed so that an additional sign-off etc. are added
 after completing the existing incomplete line.
 

--------------------------------------------------
[Stalled]

* sg/clone-refspec-from-command-line-config (2017-02-27) 1 commit
 - clone: respect configured fetch respecs during initial fetch

 Expecting a reroll.
 cf. <20170227211217.73gydlxb2qu2sp3m@sigill.intra.peff.net>
 cf. <CAM0VKj=rsAfKvVccOMOoo5==Q1yW1U0zJBbUV=faKppWFm-u+g@mail.gmail.com>
 Some nits but looks ok.


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


* ls/filter-process-delayed (2017-03-06) 1 commit
 - convert: add "status=delayed" to filter process protocol

 What's the status of this one???
 cf. <xmqq60jmnmef.fsf@junio-linux.mtv.corp.google.com>


* pb/bisect (2017-02-18) 28 commits
 . fixup! bisect--helper: `bisect_next_check` & bisect_voc shell function in C
 . bisect--helper: remove the dequote in bisect_start()
 . bisect--helper: retire `--bisect-auto-next` subcommand
 . bisect--helper: retire `--bisect-autostart` subcommand
 . bisect--helper: retire `--bisect-write` subcommand
 . bisect--helper: `bisect_replay` shell function in C
 . bisect--helper: `bisect_log` shell function in C
 . bisect--helper: retire `--write-terms` subcommand
 . bisect--helper: retire `--check-expected-revs` subcommand
 . bisect--helper: `bisect_state` & `bisect_head` shell function in C
 . bisect--helper: `bisect_autostart` shell function in C
 . bisect--helper: retire `--next-all` subcommand
 . bisect--helper: retire `--bisect-clean-state` subcommand
 . bisect--helper: `bisect_next` and `bisect_auto_next` shell function in C
 . t6030: no cleanup with bad merge base
 . bisect--helper: `bisect_start` shell function partially in C
 . bisect--helper: `get_terms` & `bisect_terms` shell function in C
 . bisect--helper: `bisect_next_check` & bisect_voc shell function in C
 . bisect--helper: `check_and_set_terms` shell function in C
 . bisect--helper: `bisect_write` shell function in C
 . bisect--helper: `is_expected_rev` & `check_expected_revs` shell function in C
 . bisect--helper: `bisect_reset` shell function in C
 . wrapper: move is_empty_file() and rename it as is_empty_or_missing_file()
 . t6030: explicitly test for bisection cleanup
 . bisect--helper: `bisect_clean_state` shell function in C
 . bisect--helper: `write_terms` shell function in C
 . bisect: rewrite `check_term_format` shell function in C
 . bisect--helper: use OPT_CMDMODE instead of OPT_BOOL

 Move more parts of "git bisect" to C.

 Ejected from 'pu', as it overlaps and gets in the way of bc/object-id topic.
 Expecting a reroll.
 cf. <CAFZEwPPXPPHi8KiEGS9ggzNHDCGhuqMgH9Z8-Pf9GLshg8+LPA@mail.gmail.com>
 cf. <CAFZEwPM9RSTGN54dzaw9gO9iZmsYjJ_d1SjUD4EzSDDbmh-XuA@mail.gmail.com>
 cf. <CAFZEwPNUXcNY9Qdz=_B7q2kQuaecPzJtTMGdv8YMUPEz2vnp8A@mail.gmail.com>


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

* nd/worktree-move (2017-04-20) 6 commits
 - worktree remove: new command
 - worktree move: refuse to move worktrees with submodules
 - worktree move: accept destination as directory
 - worktree move: new command
 - worktree.c: add update_worktree_location()
 - worktree.c: add validate_worktree()

 "git worktree" learned move and remove subcommands.

 cf. <20170420101024.7593-1-pclouds@gmail.com>
 cf. <20170421145916.mknekgqzhxffu7di@sigill.intra.peff.net>
 cf. <d0e81b1e-5869-299e-f462-4d43dc997bd1@ramsayjones.plus.com>


* ab/push-cas-doc-n-test (2017-04-19) 1 commit
  (merged to 'next' on 2017-04-23 at 0ef31ab624)
 + push: document & test --force-with-lease with multiple remotes

 Doc update.

 Will merge to 'master'.


* jk/parse-options-no-no-no (2017-04-19) 2 commits
 - SQUASH???
 - parse-options: disallow double-negations of options starting with no-

 Command line options that begin with "--no-" (e.g. "--no-checkout"
 option of "git clone") can be negated by removing "--no-"; we
 historically also allowed prefixing an extra "no" to the option
 (e.g. "--no-no-checkout"), which made the command line look ugly
 and unusual.  This proposes to forbid it.

 While I agree there is no need to support "--no-no-checkout", this
 looks more like "if it looks ugly and unusual, you do not have to
 use it".  Perhaps we can drop it?


* ss/gitmodules-ignore-doc (2017-04-19) 1 commit
  (merged to 'next' on 2017-04-23 at 3963ab5013)
 + gitmodules: clarify the ignore option values

 Doc update.

 Will merge to 'master'.


* ss/submodule-shallow-doc (2017-04-19) 1 commit
  (merged to 'next' on 2017-04-23 at 56a80f913d)
 + gitmodules: clarify what history depth a shallow clone has

 Doc update.

 Will merge to 'master'.


* df/dir-iter-remove-subtree (2017-04-19) 5 commits
 - remove_subtree(): reimplement using iterators
 - dir_iterator: rewrite state machine model
 - dir_iterator: refactor dir_iterator_advance
 - remove_subtree(): test removing nested directories
 - dir_iterator: add tests for dir_iterator API

 Update the dir-iterator API and use it to reimplement
 remove_subtree().

 Almost there except for a minor nit.
 GSoC microproject.


* nd/conditional-config-in-early-config (2017-04-19) 3 commits
  (merged to 'next' on 2017-04-23 at 1803ee72a9)
 + config: correct file reading order in read_early_config()
 + config: handle conditional include when $GIT_DIR is not set up
 + config: prepare to pass more info in git_config_with_options()

 The recently introduced conditional inclusion of configuration did
 not work well when early-config mechanism was involved.

 Will merge to 'master'.


* ab/clone-no-tags (2017-04-19) 1 commit
  (merged to 'next' on 2017-04-23 at c6329b0f7c)
 + clone: add a --no-tags option to clone without tags

 "git clone" learned the "--no-tags" option not to fetch all tags
 initially, and also set up the tagopt not to follow any tags in
 subsequent fetches.

 Will merge to 'master'.


* ab/completion-push-delete-ref (2017-04-23) 1 commit
  (merged to 'next' on 2017-04-23 at e227df80bf)
 + completion: expand "push --delete <remote> <ref>" for refs on that <remote>

 The completion script (in contrib/) learned to complete "git push
 --delete b<TAB>" to complete branch name to be deleted.

 Will merge to 'master'.


* bw/forking-and-threading (2017-04-25) 13 commits
 - run-command: restrict PATH search to executable files
 - run-command: expose is_executable function
  (merged to 'next' on 2017-04-23 at 7754b5ebc3)
 + run-command: block signals between fork and execve
 + run-command: add note about forking and threading
 + run-command: handle dup2 and close errors in child
 + run-command: eliminate calls to error handling functions in child
 + run-command: don't die in child when duping /dev/null
 + run-command: prepare child environment before forking
 + string-list: add string_list_remove function
 + run-command: use the async-signal-safe execv instead of execvp
 + run-command: prepare command before forking
 + t0061: run_command executes scripts without a #! line
 + t5550: use write_script to generate post-update hook

 The "run-command" APIimplementation has been made more robust
 against dead-locking in a threaded environment.

 Will merge to 'next'.


* sb/reset-recurse-submodules (2017-04-23) 4 commits
 - builtin/reset: add --recurse-submodules switch
 - submodule.c: submodule_move_head works with broken submodules
 - submodule.c: uninitialized submodules are ignored in recursive commands
 - entry.c: submodule recursing: respect force flag correctly

 "git reset" learned "--recurse-submodules" option.


* ls/travis-doc-asciidoctor (2017-04-16) 3 commits
  (merged to 'next' on 2017-04-19 at 359c32953b)
 + travis-ci: unset compiler for jobs that do not need one
 + travis-ci: parallelize documentation build
 + travis-ci: build documentation with AsciiDoc and Asciidoctor

 Have Travis CI format the documentation with both AsciiDoc and
 AsciiDoctor.

 Will hold in 'next' waiting for a small update.
 cf. <25191991-F4EA-4D91-B291-854F46A34DC2@gmail.com>


* mg/status-in-progress-info (2017-04-14) 1 commit
 - status: show in-progress info for short status

 "git status" learns an option to report various operations
 (e.g. "merging") that the user is in the middle of.

 Waiting for final confirmation.
 cf. <xmqqwpajikd2.fsf@gitster.mtv.corp.google.com>


* nd/worktree-add-lock (2017-04-20) 1 commit
  (merged to 'next' on 2017-04-23 at 160b955fbb)
 + worktree add: add --lock option

 Allow to lock a worktree immediately after it's created. This helps
 prevent a race between "git worktree add; git worktree lock" and
 "git worktree prune".

 Will merge to 'master'.


* ps/pathspec-empty-prefix-origin (2017-04-14) 1 commit
  (merged to 'next' on 2017-04-23 at b91098d1f7)
 + pathspec: honor `PATHSPEC_PREFIX_ORIGIN` with empty prefix

 A recent update broke "git add -p ../foo" from a subdirectory.

 Will merge to 'master'.


* gb/rebase-signoff (2017-04-18) 3 commits
  (merged to 'next' on 2017-04-19 at c3c04e6a71)
 + rebase: pass --[no-]signoff option to git am
 + builtin/am: fold am_signoff() into am_append_signoff()
 + builtin/am: honor --signoff also when --rebasing

 "git rebase" learns "--signoff" option.

 Will merge to 'master'.


* jh/add-index-entry-optim (2017-04-19) 5 commits
  (merged to 'next' on 2017-04-23 at 295d4066a8)
 + read-cache: speed up has_dir_name (part 2)
 + read-cache: speed up has_dir_name (part 1)
 + read-cache: speed up add_index_entry during checkout
 + p0006-read-tree-checkout: perf test to time read-tree
 + read-cache: add strcmp_offset function

 "git checkout" that handles a lot of paths has been optimized by
 reducing the number of unnecessary checks of paths in the
 has_dir_name() function.

 Will merge to 'master'.


* ab/grep-threading-cleanup (2017-04-16) 8 commits
 - grep: given --threads with NO_PTHREADS=YesPlease, warn
 - pack-objects: fix buggy warning about threads under NO_PTHREADS=YesPlease
 - pack-object & index-pack: add test for --threads warning under NO_PTHREADS
 - tests: add a PTHREADS prerequisite
 - grep: skip pthreads overhead when using one thread
 - grep: don't redundantly compile throwaway patterns under threading
 - grep: add tests for --threads=N and grep.threads
 - grep: assert that threading is enabled when calling grep_{lock,unlock}


* ls/travis-coccicheck (2017-04-16) 1 commit
  (merged to 'next' on 2017-04-23 at fa42ffe6b2)
 + travis-ci: add static analysis build job to run coccicheck

 Travis CI learns to run coccicheck.

 Will merge to 'master'.


* pc/t2027-git-to-pipe-cleanup (2017-04-14) 1 commit
  (merged to 'next' on 2017-04-23 at b5c28345a9)
 + t2027: avoid using pipes

 Having a git command on the upstream side of a pipe in a test
 script will hide the exit status from the command, which may cause
 us to fail to notice a breakage; rewrite tests in a script to avoid
 this issue.

 Will merge to 'master'.


* bp/sub-process-convert-filter (2017-04-23) 8 commits
 - convert: update subprocess_read_status() to not die on EOF
 - sub-process: move sub-process functions into separate files
 - convert: rename reusable sub-process functions
 - convert: update generic functions to only use generic data structures
 - convert: separate generic structures and variables from the filter specific ones
 - convert: split start_multi_file_filter into two separate functions
 - convert: move packet_write_list() into pkt-line as packet_writel()
 - pkt-line: add packet_read_line_gently()

 Code from "conversion using external process" codepath has been
 extracted to a separate sub-process.[ch] module.

 Reroll exists but needs more work.
 cf. <20170407120354.17736-1-benpeart@microsoft.com>


* cc/split-index-config (2017-04-20) 1 commit
  (merged to 'next' on 2017-04-23 at 5996ddc3f2)
 + read-cache: avoid using git_path() in freshen_shared_index()

 The split-index code configuration code used an unsafe git_path()
 function without copying its result out.

 Will merge to 'master'.


* mg/name-rev-debug (2017-03-31) 4 commits
 - describe: pass --debug down to name-rev
 - name-rev: provide debug output
 - name-rev: favor describing with tags and use committer date to tiebreak
 - name-rev: refactor logic to see if a new candidate is a better name

 "git describe --debug --contains" did not add any meaningful
 information, even though without "--contains" it did.

 Expecting a reroll of the tip two.
 cf. <xmqqshltxnwt.fsf@gitster.mtv.corp.google.com>


* mh/separate-ref-cache (2017-04-16) 20 commits
  (merged to 'next' on 2017-04-23 at bd74983456)
 + do_for_each_entry_in_dir(): delete function
 + files_pack_refs(): use reference iteration
 + commit_packed_refs(): use reference iteration
 + cache_ref_iterator_begin(): make function smarter
 + get_loose_ref_cache(): new function
 + get_loose_ref_dir(): function renamed from get_loose_refs()
 + do_for_each_entry_in_dir(): eliminate `offset` argument
 + refs: handle "refs/bisect/" in `loose_fill_ref_dir()`
 + ref-cache: use a callback function to fill the cache
 + refs: record the ref_store in ref_cache, not ref_dir
 + ref-cache: introduce a new type, ref_cache
 + refs: split `ref_cache` code into separate files
 + ref-cache: rename `remove_entry()` to `remove_entry_from_dir()`
 + ref-cache: rename `find_ref()` to `find_ref_entry()`
 + ref-cache: rename `add_ref()` to `add_ref_entry()`
 + refs_verify_refname_available(): use function in more places
 + refs_verify_refname_available(): implement once for all backends
 + refs_ref_iterator_begin(): new function
 + refs_read_raw_ref(): new function
 + get_ref_dir(): don't call read_loose_refs() for "refs/bisect"

 The internals of the refs API around the cached refs has been
 streamlined.

 Will merge to 'master'.


* ja/doc-l10n (2017-03-20) 3 commits
 - SQUASH???
 - l10n: add git-add.txt to localized man pages
 - l10n: introduce framework for localizing man pages

 A proposal to use po4a to localize our manual pages.


* nd/prune-in-worktree (2017-04-24) 12 commits
 - rev-list: expose and document --single-worktree
 - revision.c: --reflog add HEAD reflog from all worktrees
 - files-backend: make reflog iterator go through per-worktree reflog
 - revision.c: --all adds HEAD from all worktrees
 - refs: remove dead for_each_*_submodule()
 - revision.c: use refs_for_each*() instead of for_each_*_submodule()
 - refs: add refs_head_ref()
 - refs: move submodule slash stripping code to get_submodule_ref_store
 - refs.c: refactor get_submodule_ref_store(), share common free block
 - revision.c: --indexed-objects add objects from all worktrees
 - revision.c: refactor add_index_objects_to_pending()
 - revision.h: new flag in struct rev_info wrt. worktree-related refs
 (this branch uses nd/worktree-kill-parse-ref.)

 "git gc" and friends when multiple worktrees are used off of a
 single repository did not consider the index and per-worktree refs
 of other worktrees as the root for reachability traversal, making
 objects that are in use only in other worktrees to be subject to
 garbage collection.

 Expecting a reroll.
 Waiting for nd/worktree-kill-parse-ref to settle.
 cf. <CACsJy8ADCVBiLoPg_Tz0L6CMdh_eFmK4RYzfQ-PmUgBK7w9e=A@mail.gmail.com>


* nd/worktree-kill-parse-ref (2017-04-24) 6 commits
 - refs: kill set_worktree_head_symref()
 - worktree.c: kill parse_ref() in favor of refs_resolve_ref_unsafe()
 - refs: introduce get_worktree_ref_store()
 - refs: add REFS_STORE_ALL_CAPS
 - refs.c: make submodule ref store hashmap generic
 - environment.c: fix potential segfault by get_git_common_dir()
 (this branch is used by nd/prune-in-worktree.)

 "git gc" did not interact well with "git worktree"-managed
 per-worktree refs.

 Will merge to 'next'.


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
