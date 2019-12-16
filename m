Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9F7C43603
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 02:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBD982467B
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 02:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6sBj37j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfLPC0j (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Dec 2019 21:26:39 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33028 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfLPC0i (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Dec 2019 21:26:38 -0500
Received: by mail-ed1-f68.google.com with SMTP id r21so3785221edq.0
        for <git@vger.kernel.org>; Sun, 15 Dec 2019 18:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ExYzAAo7WWMFQ4F/h/7LbySH8PvrLKelM+mpWgKrhnM=;
        b=m6sBj37jljTD8xdRx5aC9ry7afa7CsJHmrXyammg6fNqOLMbrNxbeGJ2WNNwzZNUl0
         mvDh5TKi+OhJsi/MtEwnQf7MbczSooQXWU7Uu+5Cmx/hiqKzzwCHm0GZQciq+7NBpnu6
         qi1dhHwdyoctARFJ7qgpoCyeaxuPB7H2VWVFUKDjgjQZ6RRdYsYoFHa0omTChOrU37HK
         braZpznbbywurQ1tE7QUfSY3hXpdZBs1HwpbrUJHzDI0Nx3mF+ZbB8nlpKOPunK93AVA
         DsuQRdMcoKocmmOgzOtsOwSL83Etdr0bv+3X6P06wVvQR0Mw01uZCSQDwLE15iUat4rr
         V9QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ExYzAAo7WWMFQ4F/h/7LbySH8PvrLKelM+mpWgKrhnM=;
        b=PNuih8rTIkOPnUzUmWg0T2xuI8qaEy9TbYcub6T49fepQMFBp+zlmg4L0ebXfdbOo0
         UleyYf5GPHcRX8iWkAalto9W2haI6WLCwSy8ULa1OhSirUF3cK1SxvoJ0OQrutkwcqTL
         m4h6KhVbYrhWQ2oxfDoCk8bwr3JZ4JrydR2DIiHiKNFVrBB+wQiBKKByde8Xt9ebN+Hz
         nlGwT/qizuzdj1i+feRgry+9v1+ifWsTSiFAwQjYhJUhpSQW6QExqr9/rOJGPqOr8cqX
         nBJThU1gylH3xhATqy5bLMj4qXkSpeqir/kiSRgkBByS+fqUXbvcBgHyTLN6HTo24luY
         JwrA==
X-Gm-Message-State: APjAAAUBYeNEbpISQMRo+rg8QwP/B3Lj8Abff92NiIVTR5jukIsTUGRZ
        XnVtZt0H1YO1nzkncVeFwUPQjvUKzLvM8B++X4k=
X-Google-Smtp-Source: APXvYqwc3IGpMbmWkkiAXEs5PUvmpxaAxUJeID63n+7JLricXBpH1AVlIycfvaSXz+PiJ2Wr6c5g6ECu5yzeKKxmf8Q=
X-Received: by 2002:a05:6402:542:: with SMTP id i2mr4571081edx.190.1576463193810;
 Sun, 15 Dec 2019 18:26:33 -0800 (PST)
MIME-Version: 1.0
References: <xmqqpnh6yfrl.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqpnh6yfrl.fsf@gitster-ct.c.googlers.com>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Mon, 16 Dec 2019 15:26:21 +1300
Message-ID: <CACg5j26+ECnmKZQYsspSPF1C=CAHTBo4F=T8QgnAeQnjQ7Eb1g@mail.gmail.com>
Subject: Re: What's cooking in git.git (Dec 2019, #01; Mon, 2)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 3, 2019 at 3:17 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.  The ones marked with '.' do not appear in any of
> the integration branches, but I am still holding onto them.
>
> The second batch of topics are now in 'master'; this was a rather
> large update, so there might be some fallout.  Many topics are still
> in 'next' to be merged to 'master' soonish, and many others are
> waiting to be in 'next'.
>
> You can find the changes described here in the integration branches
> of the repositories listed at
>
>     http://git-blame.blogspot.com/p/git-public-repositories.html
>
> --------------------------------------------------
> [Graduated to "master"]
>
> * ar/install-doc-update-cmds-needing-the-shell (2019-11-15) 1 commit
>   (merged to 'next' on 2019-11-19 at 216468eb98)
>  + INSTALL: use existing shell scripts as example
>
>  Doc update.
>
>
> * cb/curl-use-xmalloc (2019-11-07) 1 commit
>   (merged to 'next' on 2019-11-19 at 1c587d0775)
>  + remote-curl: unbreak http.extraHeader with custom allocators
>
>  HTTP transport had possible allocator/deallocator mismatch, which
>  has been corrected.
>
>
> * dd/sequencer-utf8 (2019-11-11) 8 commits
>   (merged to 'next' on 2019-11-19 at 9432ddc32c)
>  + sequencer: reencode commit message for am/rebase --show-current-patch
>  + sequencer: reencode old merge-commit message
>  + sequencer: reencode squashing commit's message
>  + sequencer: reencode revert/cherry-pick's todo list
>  + sequencer: reencode to utf-8 before arrange rebase's todo list
>  + t3900: demonstrate git-rebase problem with multi encoding
>  + configure.ac: define ICONV_OMITS_BOM if necessary
>  + t0028: eliminate non-standard usage of printf
>
>  Handling of commit objects that use non UTF-8 encoding during
>  "rebase -i" has been improved.
>
>
> * dj/typofix-merge-strat (2019-11-11) 1 commit
>   (merged to 'next' on 2019-11-19 at 5b6c0cf125)
>  + merge-strategies: fix typo "reflected to" to "reflected in"
>
>  Typofix.
>
>
> * dl/complete-rebase-onto (2019-11-12) 1 commit
>   (merged to 'next' on 2019-11-19 at ba53946a3b)
>  + completion: learn to complete `git rebase --onto=`
>
>  The completion script (in contrib/) learned that the "--onto"
>  option of "git rebase" can take its argument as the value of the
>  option.
>
>
> * dl/doc-diff-no-index-implies-exit-code (2019-11-02) 1 commit
>   (merged to 'next' on 2019-11-19 at e2b2181e28)
>  + git-diff.txt: document return code of `--no-index`
>
>  Doc update.
>
>
> * ds/test-read-graph (2019-11-13) 1 commit
>   (merged to 'next' on 2019-11-19 at 80152fc082)
>  + test-tool: use 'read-graph' helper
>
>  Dev support for commit-graph feature.
>
>
> * en/doc-typofix (2019-11-10) 10 commits
>   (merged to 'next' on 2019-11-19 at e7bfe50de5)
>  + Fix spelling errors in no-longer-updated-from-upstream modules
>  + multimail: fix a few simple spelling errors
>  + sha1dc: fix trivial comment spelling error
>  + Fix spelling errors in test commands
>  + Fix spelling errors in messages shown to users
>  + Fix spelling errors in names of tests
>  + Fix spelling errors in comments of testcases
>  + Fix spelling errors in code comments
>  + Fix spelling errors in documentation outside of Documentation/
>  + Documentation: fix a bunch of typos, both old and new
>
>  Docfix.
>
>
> * en/misc-doc-fixes (2019-11-07) 3 commits
>   (merged to 'next' on 2019-11-19 at 7222cf3720)
>  + name-hash.c: remove duplicate word in comment
>  + hashmap: fix documentation misuses of -> versus .
>  + git-filter-branch.txt: correct argument name typo
>
>  Misc doc fixes.
>
>
> * en/t6024-style (2019-11-07) 1 commit
>   (merged to 'next' on 2019-11-19 at b41c2ed21b)
>  + t6024: modernize style
>
>  Test updates.
>
>
> * es/myfirstcontrib-updates (2019-11-02) 3 commits
>   (merged to 'next' on 2019-11-19 at 41d70e1db4)
>  + myfirstcontrib: hint to find gitgitgadget allower
>  + myfirstcontrib: add dependency installation step
>  + myfirstcontrib: add 'psuh' to command-list.txt
>
>  Doc updates.
>
>
> * hw/config-doc-in-header (2019-10-24) 1 commit
>   (merged to 'next' on 2019-11-19 at 7f314c649e)
>  + config: move documentation to config.h
>
>  Follow recent push to move API docs from Documentation/ to header
>  files and update config.h
>
>
> * jc/fsmonitor-sanity-fix (2019-11-13) 1 commit
>   (merged to 'next' on 2019-11-19 at 1fceb9b55b)
>  + fsmonitor: do not compare bitmap size with size of split index
>  (this branch is used by us/unpack-trees-fsmonitor.)
>
>  Remove an incorrect BUG() that should not trigger.
>
>
> * jc/log-graph-simplify (2019-11-13) 14 commits
>   (merged to 'next' on 2019-11-19 at de6360c648)
>  + t4215: use helper function to check output
>   (merged to 'next' on 2019-11-10 at 79d2b8ff98)
>  + graph: fix coloring of octopus dashes
>  + graph: flatten edges that fuse with their right neighbor
>  + graph: smooth appearance of collapsing edges on commit lines
>  + graph: rename `new_mapping` to `old_mapping`
>  + graph: commit and post-merge lines for left-skewed merges
>  + graph: tidy up display of left-skewed merges
>  + graph: example of graph output that can be simplified
>  + graph: extract logic for moving to GRAPH_PRE_COMMIT state
>  + graph: remove `mapping_idx` and `graph_update_width()`
>  + graph: reduce duplication in `graph_insert_into_new_columns()`
>  + graph: reuse `find_new_column_by_commit()`
>  + graph: handle line padding in `graph_next_line()`
>  + graph: automatically track display width of graph lines
>
>  The implementation of "git log --graph" got refactored and then its
>  output got simplified.
>
>
> * jk/cleanup-object-parsing-and-fsck (2019-10-28) 23 commits
>   (merged to 'next' on 2019-11-10 at 50b2267a2a)
>  + fsck: accept an oid instead of a "struct tree" for fsck_tree()
>  + fsck: accept an oid instead of a "struct commit" for fsck_commit()
>  + fsck: accept an oid instead of a "struct tag" for fsck_tag()
>  + fsck: rename vague "oid" local variables
>  + fsck: don't require an object struct in verify_headers()
>  + fsck: don't require an object struct for fsck_ident()
>  + fsck: drop blob struct from fsck_finish()
>  + fsck: accept an oid instead of a "struct blob" for fsck_blob()
>  + fsck: don't require an object struct for report()
>  + fsck: only require an oid for skiplist functions
>  + fsck: only provide oid/type in fsck_error callback
>  + fsck: don't require object structs for display functions
>  + fsck: use oids rather than objects for object_name API
>  + fsck_describe_object(): build on our get_object_name() primitive
>  + fsck: unify object-name code
>  + fsck: require an actual buffer for non-blobs
>  + fsck: stop checking tag->tagged
>  + fsck: stop checking commit->parent counts
>  + fsck: stop checking commit->tree value
>  + commit, tag: don't set parsed bit for parse failures
>  + parse_tag_buffer(): treat NULL tag pointer as parse error
>  + parse_commit_buffer(): treat lookup_tree() failure as parse error
>  + parse_commit_buffer(): treat lookup_commit() failure as parse error
>
>  Originally merged to 'next' on 2019-10-30
>
>  Crufty code and logic accumulated over time around the object
>  parsing and low-level object access used in "git fsck" have been
>  cleaned up.
>
>
> * jk/gitweb-anti-xss (2019-11-18) 4 commits
>   (merged to 'next' on 2019-11-19 at 69ef04c013)
>  + gitweb: escape URLs generated by href()
>  + t/gitweb-lib.sh: set $REQUEST_URI
>  + t/gitweb-lib.sh: drop confusing quotes
>  + t9502: pass along all arguments in xss helper
>
>  Some codepaths in "gitweb" that forgot to escape URLs generated
>  based on end-user input have been corrected.
>
>
> * jk/optim-in-pack-idx-conversion (2019-11-12) 1 commit
>   (merged to 'next' on 2019-11-19 at a81ebc7b8d)
>  + pack-objects: avoid pointless oe_map_new_pack() calls
>
>  Code clean-up.
>
>
> * jk/remove-sha1-to-hex (2019-11-13) 2 commits
>   (merged to 'next' on 2019-11-19 at fb68824870)
>  + hex: drop sha1_to_hex()
>  + hex: drop sha1_to_hex_r()
>
>  Code clean-up.
>
>
> * jk/send-pack-remote-failure (2019-11-13) 1 commit
>   (merged to 'next' on 2019-11-19 at d02c0107ee)
>  + send-pack: check remote ref status on pack-objects failure
>
>  Error handling after "git push" finishes sending the packdata and
>  waits for the response to the remote side has been improved.
>
>
> * js/complete-svn-recursive (2019-11-13) 1 commit
>   (merged to 'next' on 2019-11-19 at fa2a97911c)
>  + completion: tab-complete "git svn --recursive"
>
>  The completion script (in contrib/) has been taught that "git svn"
>  supports the "--recursive" option.
>
>
> * js/fetch-multi-lockfix (2019-11-06) 2 commits
>   (merged to 'next' on 2019-11-19 at b9683b7ec9)
>  + fetch: avoid locking issues between fetch.jobs/fetch.writeCommitGraph
>  + fetch: add the command-line option `--write-commit-graph`
>
>  Fetching from multiple remotes into the same repository in parallel
>  had a bad interaction with the recent change to (optionally) update
>  the commit-graph after a fetch job finishes, as these parallel
>  fetches compete with each other.  Which has been corrected.
>
>
> * js/git-path-head-dot-lock-fix (2019-10-29) 2 commits
>   (merged to 'next' on 2019-11-19 at b406944979)
>  + git_path(): handle `.lock` files correctly
>  + t1400: wrap setup code in test case
>
>  "git rev-parse --git-path HEAD.lock" did not give the right path
>  when run in a secondary worktree.
>
>
> * js/vreportf-wo-buffering (2019-11-02) 1 commit
>   (merged to 'next' on 2019-11-19 at cae61b9899)
>  + vreportf(): avoid relying on stdio buffering
>
>  Messages from die() etc. can be mixed up from multiple processes
>  without even line buffering on Windows, which has been worked
>  around.
>
>
> * jt/fetch-remove-lazy-fetch-plugging (2019-11-13) 3 commits
>   (merged to 'next' on 2019-11-19 at 1b26c28dcd)
>  + promisor-remote: remove fetch_if_missing=0
>  + clone: remove fetch_if_missing=0
>  + fetch: remove fetch_if_missing=0
>
>  "git fetch" codepath had a big "do not lazily fetch missing objects
>  when I ask if something exists" switch.  This has been corrected by
>  marking the "does this thing exist?" calls with "if not please do not
>  lazily fetch it" flag.
>
>
> * kw/fsmonitor-watchman-fix (2019-11-06) 1 commit
>   (merged to 'next' on 2019-11-19 at ee786a5c39)
>  + fsmonitor: fix watchman integration
>
>  The watchman integration for fsmonitor was racy, which has been
>  corrected to be more conservative.
>
>
> * ln/userdiff-elixir (2019-11-10) 1 commit
>   (merged to 'next' on 2019-11-19 at 6318918ba8)
>  + userdiff: add Elixir to supported userdiff languages
>
>  The patterns to detect function boundary for Elixir language has
>  been added.
>
>
> * ma/bisect-doc-sample-update (2019-10-29) 1 commit
>   (merged to 'next' on 2019-11-19 at bde6adce1b)
>  + Documentation/git-bisect.txt: add --no-ff to merge command
>
>  "git merge --no-commit" needs "--no-ff" if you do not want to move
>  HEAD, which has been corrected in the manual page for "git bisect".
>
>
> * ma/t7004 (2019-11-14) 1 commit
>   (merged to 'next' on 2019-11-19 at 789a0a0f05)
>  + t7004: check existence of correct tag
>
>  Test fix.
>
>
> * mr/clone-dir-exists-to-path-exists (2019-10-29) 1 commit
>   (merged to 'next' on 2019-11-19 at 07b6ab25de)
>  + clone: rename static function `dir_exists()`.
>
>  Code cleanup.
>
>
> * nn/doc-rebase-merges (2019-11-12) 1 commit
>   (merged to 'next' on 2019-11-19 at db74ff488c)
>  + doc: improve readability of --rebase-merges in git-rebase
>
>  Doc update.
>
>
> * ns/test-desc-typofix (2019-11-07) 1 commit
>   (merged to 'next' on 2019-11-19 at 804861f385)
>  + t: fix typo in test descriptions
>
>  Typofix.
>
>
> * pb/help-list-gitsubmodules-among-guides (2019-10-29) 1 commit
>   (merged to 'next' on 2019-11-19 at 3c6f5c1901)
>  + help: add gitsubmodules to the list of guides
>
>  Help update.
>
>
> * pb/no-recursive-reset-hard-in-worktree-add (2019-10-30) 1 commit
>   (merged to 'next' on 2019-11-19 at cdfb0643e9)
>  + worktree: teach "add" to ignore submodule.recurse config
>
>  "git worktree add" internally calls "reset --hard" that should not
>  descend into submodules, even when submodule.recurse configuration
>  is set, but it was affected.  This has been corrected.
>
>
> * py/shortlog-list-options-for-log (2019-11-10) 1 commit
>   (merged to 'next' on 2019-11-19 at 92a10e39f7)
>  + git-shortlog.txt: include commit limiting options
>
>  Documentation pages for "git shortlog" now lists commit limiting
>  options explicitly.
>
>
> * rj/bundle-ui-updates (2019-11-11) 3 commits
>   (merged to 'next' on 2019-11-19 at d88f626256)
>  + bundle-verify: add --quiet
>  + bundle-create: progress output control
>  + bundle: framework for options before bundle file
>
>  "git bundle" has been taught to use the parse options API.  "git
>  bundle verify" learned "--quiet" and "git bundle create" learned
>  options to control the progress output.
>
>
> * rs/parse-options-dup-null-fix (2019-11-13) 1 commit
>   (merged to 'next' on 2019-11-19 at 73040e1605)
>  + parse-options: avoid arithmetic on pointer that's potentially NULL
>
>  Code cleanup.
>
>
> * rs/skip-iprefix (2019-11-10) 2 commits
>   (merged to 'next' on 2019-11-19 at c87ae31b14)
>  + convert: use skip_iprefix() in validate_encoding()
>  + utf8: use skip_iprefix() in same_utf_encoding()
>
>  Code simplification.
>
>
> * rs/trace2-dots (2019-11-06) 1 commit
>   (merged to 'next' on 2019-11-19 at a045233ad0)
>  + trace2: add dots directly to strbuf in perf_fmt_prepare()
>
>  Code cleanup.
>
>
> * rs/use-copy-array-in-mingw-shell-command-preparation (2019-11-13) 1 commit
>   (merged to 'next' on 2019-11-19 at 52ee6a8887)
>  + mingw: use COPY_ARRAY for copying array
>
>  Code cleanup.
>
>
> * rt/fetch-message-fix (2019-11-02) 1 commit
>   (merged to 'next' on 2019-11-19 at 69eb337cd8)
>  + fetch.c: fix typo in a warning message
>
>  A small message update.
>
>
> * sg/blame-indent-heuristics-is-now-the-default (2019-10-29) 1 commit
>   (merged to 'next' on 2019-11-19 at 68e60f08cc)
>  + builtin/blame.c: remove '--indent-heuristic' from usage string
>
>  Message update.
>
>
> * sg/skip-skipped-prereq (2019-11-13) 1 commit
>   (merged to 'next' on 2019-11-19 at 10d344fed7)
>  + test-lib: don't check prereqs of test cases that won't be run anyway
>
>  Test update to avoid wasted cycles.
>
>
> * tg/stash-refresh-index (2019-11-14) 1 commit
>   (merged to 'next' on 2019-11-19 at 4d67af8d3f)
>  + stash: make sure we have a valid index before writing it
>
>  Recent update to "git stash pop" made the command empty the index
>  when run with the "--quiet" option, which has been corrected.
>
> --------------------------------------------------
> [New Topics]
>
> * ds/commit-graph-delay-gen-progress (2019-11-27) 2 commits
>  - commit-graph: use start_delayed_progress()
>  - progress: create GIT_PROGRESS_DELAY
>
>  One kind of progress messages were always given during commit-graph
>  generation, instead of following the "if it takes more than two
>  seconds, show progress" pattern, which has been corrected.
>
>  Will merge to 'next'.
>
>
> * ds/sparse-cone (2019-11-22) 19 commits
>  - sparse-checkout: check for dirty status
>  - sparse-checkout: update working directory in-process for 'init'
>  - sparse-checkout: cone mode should not interact with .gitignore
>  - sparse-checkout: write using lockfile
>  - sparse-checkout: use in-process update for disable subcommand
>  - sparse-checkout: update working directory in-process
>  - sparse-checkout: sanitize for nested folders
>  - unpack-trees: add progress to clear_ce_flags()
>  - unpack-trees: hash less in cone mode
>  - sparse-checkout: init and set in cone mode
>  - sparse-checkout: use hashmaps for cone patterns
>  - sparse-checkout: add 'cone' mode
>  - trace2: add region in clear_ce_flags
>  - sparse-checkout: create 'disable' subcommand
>  - sparse-checkout: add '--stdin' option to set subcommand
>  - sparse-checkout: 'set' subcommand
>  - clone: add --sparse mode
>  - sparse-checkout: create 'init' subcommand
>  - sparse-checkout: create builtin with 'list' subcommand
>
>  Management of sparsely checked-out working tree has gained a
>  dedicated "sparse-checkout" command.
>
>  How well is this topic done at this point?
>
>
> * dl/range-diff-with-notes (2019-11-21) 10 commits
>   (merged to 'next' on 2019-11-25 at dd6dad97c1)
>  + format-patch: pass notes configuration to range-diff
>  + range-diff: pass through --notes to `git log`
>  + range-diff: output `## Notes ##` header
>  + t3206: range-diff compares logs with commit notes
>  + t3206: s/expected/expect/
>  + t3206: disable parameter substitution in heredoc
>  + t3206: remove spaces after redirect operators
>  + pretty-options.txt: --notes accepts a ref instead of treeish
>  + rev-list-options.txt: remove reference to --show-notes
>  + argv-array: add space after `while`
>
>  "git range-diff" learned to take the "--notes=<ref>" and the
>  "--no-notes" options to control the commit notes included in the
>  log message that gets compared.
>
>  Will merge to 'master'.
>
>
> * jc/azure-ci-osx-fix-fix (2019-11-20) 1 commit
>   (merged to 'next' on 2019-11-25 at 7de6356e67)
>  + ci(osx): update homebrew-cask repository with less noise
>
>  CI jobs for macOS has been made less chatty when updating perforce
>  package used during testing.
>
>  Will merge to 'master'.
>
>
> * jk/fail-show-toplevel-outside-working-tree (2019-11-20) 1 commit
>   (merged to 'next' on 2019-11-25 at cd97ae38bc)
>  + rev-parse: make --show-toplevel without a worktree an error
>
>  "git rev-parse --show-toplevel" run outside of any working tree did
>  not error out, which has been corrected.
>
>  Will merge to 'master'.
>
>
> * pb/submodule-update-fetches (2019-11-24) 1 commit
>   (merged to 'next' on 2019-11-25 at 7736f98351)
>  + doc: mention that 'git submodule update' fetches missing commits
>
>  Doc update.
>
>  Will merge to 'master'.
>
>
> * sg/unpack-progress-throughput (2019-11-20) 1 commit
>   (merged to 'next' on 2019-11-25 at 0418db6a27)
>  + builtin/unpack-objects.c: show throughput progress
>
>  "git unpack-objects" used to show progress based only on the number
>  of received and unpacked objects, which stalled when it has to
>  handle an unusually large object.  It now shows the throughput as
>  well.
>
>  Will merge to 'master'.
>
>
> * dl/test-cleanup (2019-11-29) 26 commits
>  - t7700: stop losing return codes of git commands
>  - t7700: make references to SHA-1 generic
>  - t7700: replace egrep with grep
>  - t7700: consolidate code into test_has_duplicate_object()
>  - t7700: consolidate code into test_no_missing_in_packs()
>  - t7700: s/test -f/test_path_is_file/
>  - t7700: move keywords onto their own line
>  - t7700: remove spaces after redirect operators
>  - t7700: drop redirections to /dev/null
>  - t7501: stop losing return codes of git commands
>  - t7501: remove spaces after redirect operators
>  - t5703: stop losing return codes of git commands
>  - t5703: simplify one-time-sed generation logic
>  - t5317: use ! grep to check for no matching lines
>  - t5317: stop losing return codes of git commands
>  - t4138: stop losing return codes of git commands
>  - t4015: use test_write_lines()
>  - t4015: stop losing return codes of git commands
>  - t3600: comment on inducing SIGPIPE in `git rm`
>  - t3600: stop losing return codes of git commands
>  - t3600: use test_line_count() where possible
>  - t3301: stop losing return codes of git commands
>  - t0090: stop losing return codes of git commands
>  - t0014: remove git command upstream of pipe
>  - apply-one-time-sed.sh: modernize style
>  - lib-bash.sh: move `then` onto its own line
>
>  Test cleanup.
>
>  Will merge to 'next'.
>
>
> * tg/perf-remove-stale-result (2019-11-27) 1 commit
>  - perf-lib: use a single filename for all measurement types
>
>  PerfTest fix to avoid stale result mixed up with the latest round
>  of test results.
>
>  Will merge to 'next'.
>
>
> * us/unpack-trees-fsmonitor (2019-11-21) 1 commit
>   (merged to 'next' on 2019-11-27 at 4c06f74957)
>  + unpack-trees: skip stat on fsmonitor-valid files
>
>  Users of oneway_merge() (like "reset --hard") learned to take
>  advantage of fsmonitor to avoid unnecessary lstat(2) calls.
>
>  Will merge to 'master'.
>
>
> * ds/fsmonitor-testing (2019-11-22) 11 commits
>  - test-lib: clear watchman watches at test completion
>  - t7519: disable external GIT_TEST_FSMONITOR variable
>  - t7063: disable fsmonitor with status cache
>  - tests: disable fsmonitor in submodule tests
>  - t3600-rm.sh: disable fsmonitor when deleting populated submodule
>  - t3030-merge-recursive.sh: disable fsmonitor when tweaking GIT_WORK_TREE
>  - fsmonitor: disable fsmonitor with worktrees
>  - t1510-repo-setup.sh: disable fsmonitor if no .git dir
>  - t1301-shared-repo.sh: disable FSMONITOR
>  - fsmonitor: do not output to stderr for tests
>  - fsmonitor: disable in a bare repo
>
>  Updates around testing fsmoitor integration.
>
>  Will merge to 'next'.
>
>
> * hi/gpg-optional-pkfp-fix (2019-11-23) 2 commits
>   (merged to 'next' on 2019-11-25 at b0d668176f)
>  + gpg-interface: limit search for primary key fingerprint
>  + gpg-interface: refactor the free-and-xmemdupz pattern
>  (this branch is used by hi/gpg-use-check-signature.)
>
>  The code to parse GPG output used to assume incorrectly that the
>  finterprint for the primary key would always be present for a valid
>  signature, which has been corrected.
>
>  Will merge to 'master'.
>
>
> * hv/assume-priumax-is-available-anywhere (2019-11-25) 1 commit
>   (merged to 'next' on 2019-11-27 at caac4f633d)
>  + git-compat-util.h: drop the `PRIuMAX` and other fallback definitions
>
>  We have had compatibility fallback macro definitions for "PRIuMAX",
>  "PRIu32", etc. but did not for "PRIdMAX", while the code used the
>  last one apparently without any hiccup reported recently.  The
>  fallback macro definitions for these <inttypes.h> macros that must
>  appear in C99 systems have been removed.
>
>  Will merge to 'master'.
>
>
> * js/git-svn-use-rebase-merges (2019-11-23) 1 commit
>   (merged to 'next' on 2019-11-25 at 9585fe30f8)
>  + git svn: stop using `rebase --preserve-merges`
>
>  Prepare further for "rebase --preserve-merges" deprecation.
>
>  Will merge to 'master'.
>
>
> * js/mingw-inherit-only-std-handles (2019-12-02) 6 commits
>  - mingw: translate ERROR_SUCCESS to errno = 0
>   (merged to 'next' on 2019-12-02 at 798a952eca)
>  + mingw: do set `errno` correctly when trying to restrict handle inheritance
>   (merged to 'next' on 2019-11-27 at 4736894af6)
>  + mingw: restrict file handle inheritance only on Windows 7 and later
>  + mingw: spawned processes need to inherit only standard handles
>  + mingw: work around incorrect standard handles
>  + mingw: demonstrate that all file handles are inherited by child processes
>
>  Work around a issue where a FD that is left open when spawning a
>  child process and is kept open in the child can interfere with the
>  operation in the parent process on Windows.
>
>  Will wait for a bit before merging to 'next'.
>
>
> * mg/doc-submodule-status-cached (2019-11-24) 1 commit
>   (merged to 'next' on 2019-11-25 at fa833392a3)
>  + doc: document 'git submodule status --cached'
>
>  "git submodule status" and "git submodule status --cached" show
>  different things, but the documentation did not cover them
>  correctly, which has been corrected.
>
>  Will merge to 'master'.
>
>
> * mg/submodule-status-from-a-subdirectory (2019-11-25) 1 commit
>   (merged to 'next' on 2019-11-27 at 24cb2d79ff)
>  + submodule: fix 'submodule status' when called from a subdirectory
>
>  "git submodule status" that is run from a subdirectory of the
>  superproject did not work well, which has been corrected.
>
>  Will merge to 'master'.
>
>
> * mh/clear-topo-walk-upon-reset (2019-11-25) 2 commits
>   (merged to 'next' on 2019-11-27 at 15871c1c2a)
>  + revision: free topo_walk_info before creating a new one in init_topo_walk
>  + revision: clear the topo-walk flags in reset_revision_walk
>
>  The revision walking machinery uses resources like per-object flag
>  bits that need to be reset before a new iteration of walking
>  begins, but the resources related to topological walk were not
>  cleared correctly, which has been corrected.
>
>  Will merge to 'master'.
>
>
> * nl/reset-patch-takes-a-tree (2019-11-25) 1 commit
>   (merged to 'next' on 2019-11-25 at 34dc348eaf)
>  + reset: parse rev as tree-ish in patch mode
>
>  "git reset --patch $object" without any pathspec should allow a
>  tree object to be given, but incorrectly required a committish,
>  which has been corrected.
>
>  Will merge to 'master'.
>
>
> * pw/sequencer-compare-with-right-parent-to-check-empty-commits (2019-11-23) 1 commit
>   (merged to 'next' on 2019-11-25 at a4e4f06286)
>  + sequencer: fix empty commit check when amending
>
>  The sequencer machinery compared the HEAD and the state it is
>  attempting to commit to decide if the result would be a no-op
>  commit, even when amending a commit, which was incorrect, and
>  has been corrected.
>
>  Will merge to 'master'.
>
>
> * sg/assume-no-todo-update-in-cherry-pick (2019-11-24) 1 commit
>   (merged to 'next' on 2019-11-27 at 6908186f85)
>  + sequencer: don't re-read todo for revert and cherry-pick
>
>  While running "revert" or "cherry-pick --edit" for multiple
>  commits, a recent regression incorrectly detected "nothing to
>  commit, working tree clean", instead of replaying the commits,
>  which has been corrected.
>
>  Will merge to 'master'.
>
>
> * sg/test-bool-env (2019-11-23) 2 commits
>   (merged to 'next' on 2019-11-27 at e1874e422f)
>  + t5608-clone-2gb.sh: turn GIT_TEST_CLONE_2GB into a bool
>  + tests: add 'test_bool_env' to catch non-bool GIT_TEST_* values
>
>  Recently we have declared that GIT_TEST_* variables take the
>  usual boolean values (it used to be that some used "non-empty
>  means true" and taking GIT_TEST_VAR=YesPlease as true); make
>  sure we notice and fail when non-bool strings are given to
>  these variables.
>
>  Will merge to 'master'.
>
>
> * as/t7812-missing-redirects-fix (2019-12-01) 2 commits
>  - t7812: expect failure for grep -i with invalid UTF-8 data
>  - t7812: add missing redirects
>
>  Test fix.
>
>  Will merge to 'next'.
>
>
> * jk/perf-wo-git-dot-pm (2019-11-27) 1 commit
>  - t/perf: don't depend on Git.pm
>
>  Test cleanup.
>
>  Will merge to 'next'.
>
>
> * jt/clone-recursesub-ref-advise (2019-11-27) 2 commits
>  - submodule--helper: advise on fatal alternate error
>  - Documentation: explain submodule.alternateErrorStrategy
>
>  The interaction between "git clone --recurse-submodules" and
>  alternate object store was ill-designed.  The documentation and
>  code have been taught to make more clear recommendations when the
>  users see failures.
>
>  Will merge to 'next'.
>
>
> * ra/t5150-depends-on-perl (2019-11-27) 1 commit
>  . t5150: skip request-pull test if Perl is disabled
>
>  Some Porcelain commands are written in Perl, and tests on them are
>  expected not to work when the platform lacks a working perl.
>
>  Redo.
>
>
> * rs/simplify-prepare-cmd (2019-11-27) 1 commit
>  - run-command: use prepare_git_cmd() in prepare_cmd()
>
>  Code cleanup.
>
>  Will merge to 'next'.
>
>
> * rs/test-cleanup (2019-11-30) 7 commits
>  - t7811: don't create unused file
>  - t9300: don't create unused file
>  - test: use test_must_be_empty F instead of test_cmp empty F
>  - test: use test_must_be_empty F instead of test -z $(cat F)
>  - t1400: use test_must_be_empty
>  - t1410: use test_line_count
>  - t1512: use test_line_count
>
>  Test cleanup.
>
>  Will merge to 'next'.
>
>
> * rs/use-skip-prefix-more (2019-11-27) 5 commits
>  - name-rev: use skip_prefix() instead of starts_with()
>  - push: use skip_prefix() instead of starts_with()
>  - shell: use skip_prefix() instead of starts_with()
>  - fmt-merge-msg: use skip_prefix() instead of starts_with()
>  - fetch: use skip_prefix() instead of starts_with()
>
>  Code cleanup.
>
>  Will merge to 'next'.
>
>
> * sg/test-squelch-noise-in-commit-bulk (2019-11-27) 1 commit
>  - test-lib-functions: suppress a 'git rev-parse' error in 'test_commit_bulk'
>
>  Code cleanup.
>
>  Will merge to 'next'.
>
>
> * ag/sequencer-continue-leakfix (2019-11-30) 1 commit
>  - sequencer: fix a memory leak in sequencer_continue()
>
>  Leakfix.
>
>  Will merge to 'next'.
>
>
> * bc/t9001-zsh-in-posix-emulation-mode (2019-11-30) 1 commit
>  - t9001: avoid including non-trailing NUL bytes in variables
>
>  Test portability fix.
>
>  Will merge to 'next'.
>
>
> * cs/store-packfiles-in-hashmap (2019-12-01) 1 commit
>  - packfile.c: speed up loading lots of packfiles
>
>  In a repository with many packfiles, the cost of the procedure that
>  avoids registering the same packfile twice was unnecessarily high
>  by using an inefficient search algorithm, which has been corrected.
>
>  Will merge to 'next'.
>
>
> * dd/time-reentrancy (2019-12-01) 3 commits
>  - mingw: use {gm,local}time_s as backend for {gm,local}time_r
>  - archive-zip.c: switch to reentrant localtime_r
>  - date.c: switch to reentrant {gm,local}time_r
>
>  Avoid gmtime() and localtime() and prefer their reentrant
>  counterparts.
>
>  Will merge to 'next'.
>
>
> * em/test-skip-regex-illseq (2019-11-30) 1 commit
>  - t4210: skip i18n tests that don't work on FreeBSD
>
>  Test portability fix.
>
>  Will merge to 'next'.
>
>
> * hi/gpg-use-check-signature (2019-11-30) 1 commit
>  - gpg-interface: prefer check_signature() for GPG verification
>  (this branch uses hi/gpg-optional-pkfp-fix.)
>
>  Hide lower-level verify_signed-buffer() API as a pure helper to
>  implement the public check_signature() function, in order to
>  encourage new callers to use the correct and more strict
>  validation.
>
>  Will merge to 'next'.
>
>
> * hi/grep-do-not-return-void (2019-11-30) 1 commit
>  - grep: don't return an expression from pcre2_free()
>
>  Code cleanup.
>
>  Will merge to 'next'.
>
>
> * jk/lore-is-the-archive (2019-11-30) 2 commits
>  - doc: replace public-inbox links with lore.kernel.org
>  - doc: recommend lore.kernel.org over public-inbox.org
>
>  Doc update for the mailing list archiving and nntp service.
>
>  Will merge to 'next'.
>
>
> * jk/send-pack-check-negative-with-quick (2019-11-30) 1 commit
>  - send-pack: use OBJECT_INFO_QUICK to check negative objects
>
>  Performance tweak on "git push" into a repository with many refs
>  that point at objects we have never heard of.
>
>  Will merge to 'next'.
>
>
> * sg/osx-force-gcc-9 (2019-11-29) 1 commit
>  - ci: build Git with GCC 9 in the 'osx-gcc' build job
>
>  TravisCI update.
>
>  Will merge to 'next'.
>
> --------------------------------------------------
> [Stalled]
>
> * po/bundle-doc-clonable (2019-10-21) 1 commit
>  - Doc: Bundle file usage
>
>  Doc update.
>
>  Expecting a reroll.
>
>
> * js/advise-rebase-skip (2019-10-23) 3 commits
>  - commit: give correct advice for empty commit during a rebase
>  - sequencer: export the function to get the path of `.git/rebase-merge/`
>  - cherry-pick: add test for `--skip` advice in `git commit`
>
>  The logic used in "git commit" to give hints and errors depending
>  on what operation was in progress learned to distinguish rebase and
>  cherry-pick better.
>
>  Kicked back to 'pu'.
>  cf. <nycvar.QRO.7.76.6.1911081508560.46@tvgsbejvaqbjf.bet>
>
>
> * vn/reset-deleted-ita (2019-07-26) 1 commit
>  - reset: unstage empty deleted ita files
>
>  "git reset HEAD [<pathspec>]" did not reset an empty file that was
>  added with the intent-to-add bit.
>
>  Expecting a reroll.
>
>
> * jn/unknown-index-extensions (2018-11-21) 2 commits
>  - index: offer advice for unknown index extensions
>  - index: do not warn about unrecognized extensions
>
>  A bit too alarming warning given when unknown index extensions
>  exist is getting revamped.
>
>  Expecting a reroll.
>
>
> * jc/format-patch-delay-message-id (2019-04-05) 1 commit
>  - format-patch: move message-id and related headers to the end
>
>  The location "git format-patch --thread" adds the Message-Id:
>  header in the series of header fields has been moved down, which
>  may help working around a suspected bug in GMail MSA, reported at
>  <CAHk-=whP1stFZNAaJiMi5eZ9rj0MRt20Y_yHVczZPH+O01d+sA@mail.gmail.com>
>
>  Waiting for feedback to see if it truly helps.
>  Needs tests.
>
>
> * js/protocol-advertise-multi (2018-12-28) 1 commit
>  - protocol: advertise multiple supported versions
>
>  The transport layer has been updated so that the protocol version
>  used can be negotiated between the parties, by the initiator
>  listing the protocol versions it is willing to talk, and the other
>  side choosing from one of them.
>
>  Expecting a reroll.
>  cf. <CANq=j3u-zdb_FvNJGPCmygNMScseav63GhVvBX3NcVS4f7TejA@mail.gmail.com>
>
>
> * mk/use-size-t-in-zlib (2018-10-15) 1 commit
>  - zlib.c: use size_t for size
>
>  The wrapper to call into zlib followed our long tradition to use
>  "unsigned long" for sizes of regions in memory, which have been
>  updated to use "size_t".
>
> --------------------------------------------------
> [Cooking]
>
> * jh/userdiff-python-async (2019-11-20) 1 commit
>   (merged to 'next' on 2019-11-25 at 74e4a4ed9f)
>  + userdiff: support Python async functions
>
>  The userdiff machinery has been taught that "async def" is another
>  way to begin a "function" in Python.
>
>  Will merge to 'master'.
>
>
> * dl/pretty-reference (2019-11-20) 11 commits
>  - SubmittingPatches: use `--pretty=reference`
>  - pretty: implement 'reference' format
>  - pretty: add struct cmt_fmt_map::default_date_mode_type
>  - pretty: provide short date format
>  - t4205: cover `git log --reflog -z` blindspot
>  - pretty.c: inline initalize format_context
>  - revision: make get_revision_mark() return const pointer
>  - completion: complete `tformat:` pretty format
>  - SubmittingPatches: remove dq from commit reference
>  - pretty-formats.txt: use generic terms for hash
>  - SubmittingPatches: use generic terms for hash
>
>  "git log" family learned "--pretty=ref" that gives the name of a
>  commit in the format that is often used to refer to it in log
>  messages.
>
>  Will merge to 'next'.
>
>
> * hw/doc-in-header (2019-11-18) 20 commits
>  - trace2: move doc to trace2.h
>  - submodule-config: move doc to submodule-config.h
>  - tree-walk: move doc to tree-walk.h
>  - trace: move doc to trace.h
>  - run-command: move doc to run-command.h
>  - parse-options: add link to doc file in parse-options.h
>  - credential: move doc to credential.h
>  - argv-array: move doc to argv-array.h
>  - cache: move doc to cache.h
>  - sigchain: move doc to sigchain.h
>  - pathspec: move doc to pathspec.h
>  - revision: move doc to revision.h
>  - attr: move doc to attr.h
>  - refs: move doc to refs.h
>  - remote: move doc to remote.h and refspec.h
>  - sha1-array: move doc to sha1-array.h
>  - merge: move doc to ll-merge.h
>  - graph: move doc to graph.h and graph.c
>  - dir: move doc to dir.h
>  - diff: move doc to diff.h and diffcore.h
>

Please note that this patch was 21 commits, (api-index: remove api doc
index files) is missing.

>
> * js/builtin-add-i-cmds (2019-12-01) 9 commits
>  - built-in add -i: offer the `quit` command
>  - built-in add -i: re-implement the `diff` command
>  - built-in add -i: implement the `patch` command
>  - built-in add -i: re-implement `add-untracked` in C
>  - built-in add -i: re-implement `revert` in C
>  - built-in add -i: implement the `update` command
>  - built-in add -i: prepare for multi-selection commands
>  - built-in add -i: allow filtering the modified files list
>  - add-interactive: make sure to release `rev.prune_data`
>  (this branch uses js/builtin-add-i.)
>
>  "git add -i" that is getting rewritten in C has been extended to
>  cover subcommands other than the "patch".
>
>  Will merge to 'next'.
>
>
> * js/rebase-r-safer-label (2019-11-18) 2 commits
>   (merged to 'next' on 2019-11-21 at 791d51b0d7)
>  + rebase -r: let `label` generate safer labels
>  + rebase-merges: move labels' whitespace mangling into `label_oid()`
>  (this branch is used by dd/rebase-merge-reserves-onto-label.)
>
>  A label used in the todo list that are generated by "git rebase
>  --rebase-merges" is used as a part of a refname; the logic to come
>  up with the label has been tightened to avoid names that cannot be
>  used as such.
>
>  Will merge to 'master'.
>
>
> * dd/rebase-merge-reserves-onto-label (2019-11-20) 1 commit
>   (merged to 'next' on 2019-11-21 at a6e4e5af0a)
>  + sequencer: handle rebase-merges for "onto" message
>  (this branch uses js/rebase-r-safer-label.)
>
>  The logic to avoid duplicate label names generated by "git rebase
>  --rebase-merges" forgot that the machinery itself uses "onto" as a
>  label name, which must be avoided by auto-generated labels, which
>  has been corrected.
>
>  Will merge to 'master'.
>
>
> * ma/config-bool-valex (2019-11-14) 8 commits
>  - builtin/config: die if "value_regex" doesn't canonicalize as boolean
>  - builtin/config: warn if "value_regex" doesn't canonicalize as boolean
>  - builtin/config: canonicalize "value_regex" with `--type=bool-or-int`
>  - builtin/config: canonicalize "value_regex" with `--type=bool`
>  - builtin/config: collect "value_regexp" data in a struct
>  - builtin/config: extract `handle_value_regex()` from `get_value()`
>  - t1300: modernize part of script
>  - config: make `git_parse_maybe_bool_text()` public
>
>  "git config" can be told to affect the existing entries that
>  "match" the given value via its value_regex argument.  It learned
>  to normalize the value set in the configuration and the value given
>  from the command line before computing they "match", e.g. "true" in
>  the configuration file can now match with "yes" given from the
>  command line.
>
>  Needs a bit more work?
>  cf. <CAN0heSrtwi9V607vBX9PMSfNLQ8iGcno6_iGuR4Fs8ndGxqh8A@mail.gmail.com>
>
>
> * sg/name-rev-wo-recursion (2019-11-13) 13 commits
>  - name-rev: cleanup name_ref()
>  - name-rev: eliminate recursion in name_rev()
>  - name-rev: drop name_rev()'s 'generation' and 'distance' parameters
>  - name-rev: restructure creating/updating 'struct rev_name' instances
>  - name-rev: restructure parsing commits and applying date cutoff
>  - name-rev: pull out deref handling from the recursion
>  - name-rev: extract creating/updating a 'struct name_rev' into a helper
>  - t6120: add a test to cover inner conditions in 'git name-rev's name_rev()
>  - name-rev: use sizeof(*ptr) instead of sizeof(type) in allocation
>  - name-rev: avoid unnecessary cast in name_ref()
>  - name-rev: use strbuf_strip_suffix() in get_rev_name()
>  - t6120-describe: modernize the 'check_describe' helper
>  - t6120-describe: correct test repo history graph in comment
>
>  Redo "git name-rev" to avoid recursive calls.
>
>  Looks more-or-less ready for 'next'?
>  cf. <20191127181322.171734-1-jonathantanmy@google.com>
>  cf. <20191127180210.168901-1-jonathantanmy@google.com>
>  cf. <20191112103821.30265-1-szeder.dev@gmail.com>
>
>
> * am/pathspec-from-file (2019-11-20) 6 commits
>   (merged to 'next' on 2019-11-27 at ee131b80fb)
>  + commit: support the --pathspec-from-file option
>  + doc: commit: synchronize <pathspec> description
>  + reset: support the `--pathspec-from-file` option
>  + doc: reset: synchronize <pathspec> description
>  + pathspec: add new function to parse file
>  + parse-options.h: add new options `--pathspec-from-file`, `--pathspec-file-nul`
>
>  A few commands learned to take the pathspec from the
>  standard input or a named file, instead of taking it as the command
>  line arguments.
>
>  Will merge to 'master'.
>
>
> * ec/fetch-mark-common-refs-trace2 (2019-11-20) 1 commit
>   (merged to 'next' on 2019-11-25 at c2b8e1546c)
>  + fetch: add trace2 instrumentation
>
>  Trace2 annotation.
>
>  Will merge to 'master'.
>
>
> * ep/guard-kset-tar-headers (2019-11-07) 1 commit
>   (merged to 'next' on 2019-11-21 at 6c9574b01d)
>  + kset.h, tar.h: add missing header guard to prevent multiple inclusion
>
>  Code clean-up.
>
>  Will merge to 'master'.
>
>
> * dl/t5520-cleanup (2019-11-21) 15 commits
>   (merged to 'next' on 2019-11-27 at 523d920acf)
>  + t5520: replace `! git` with `test_must_fail git`
>  + t5520: remove redundant lines in test cases
>  + t5520: replace $(cat ...) comparison with test_cmp
>  + t5520: don't put git in upstream of pipe
>  + t5520: test single-line files by git with test_cmp
>  + t5520: use test_cmp_rev where possible
>  + t5520: replace test -{n,z} with test-lib functions
>  + t5520: use test_line_count where possible
>  + t5520: remove spaces after redirect operator
>  + t5520: replace test -f with test-lib functions
>  + t5520: let sed open its own input
>  + t5520: use sq for test case names
>  + t5520: improve test style
>  + t: teach test_cmp_rev to accept ! for not-equals
>  + t0000: test multiple local assignment
>
>  Test cleanup.
>
>  Will merge to 'master'.
>
>
> * js/builtin-add-i (2019-11-18) 9 commits
>   (merged to 'next' on 2019-11-21 at caefa55b89)
>  + built-in add -i: implement the `help` command
>  + built-in add -i: use color in the main loop
>  + built-in add -i: support `?` (prompt help)
>  + built-in add -i: show unique prefixes of the commands
>  + built-in add -i: implement the main loop
>  + built-in add -i: color the header in the `status` command
>  + built-in add -i: implement the `status` command
>  + diff: export diffstat interface
>  + Start to implement a built-in version of `git add --interactive`
>  (this branch is used by js/builtin-add-i-cmds.)
>
>  The beginning of rewriting "git add -i" in C.
>
>  Will merge to 'master'.
>
>
> * ra/rebase-i-more-options (2019-11-25) 7 commits
>   (merged to 'next' on 2019-11-27 at e8a6d1e281)
>  + rebase -i: finishing touches to --reset-author-date
>  + rebase: add --reset-author-date
>  + rebase -i: support --ignore-date
>  + sequencer: rename amend_author to author_to_rename
>  + rebase -i: support --committer-date-is-author-date
>  + sequencer: allow callers of read_author_script() to ignore fields
>  + rebase -i: add --ignore-whitespace flag
>
>  "git rebase -i" learned a few options that are known by "git
>  rebase" proper.
>
>  Will merge to 'master'.
>
>
> * dl/submodule-set-url (2019-10-30) 1 commit
>  - submodule: teach set-url subcommand
>
>  "git submodule" learned a subcommand "set-url".
>
>  Will merge to 'next'.
>
>
> * ag/sequencer-todo-updates (2019-11-25) 5 commits
>   (merged to 'next' on 2019-11-27 at 3258d51dfc)
>  + sequencer: directly call pick_commits() from complete_action()
>  + rebase: fill `squash_onto' in get_replay_opts()
>  + sequencer: move the code writing total_nr on the disk to a new function
>  + sequencer: update `done_nr' when skipping commands in a todo list
>  + sequencer: update `total_nr' when adding an item to a todo list
>
>  Reduce unnecessary reading of state variables back from the disk
>  during sequencer operation.
>
>  Will merge to 'master'.
>
>
> * mt/threaded-grep-in-object-store (2019-10-02) 11 commits
>  - grep: move driver pre-load out of critical section
>  - grep: re-enable threads in non-worktree case
>  - grep: protect packed_git [re-]initialization
>  - grep: allow submodule functions to run in parallel
>  - submodule-config: add skip_if_read option to repo_read_gitmodules()
>  - grep: replace grep_read_mutex by internal obj read lock
>  - object-store: allow threaded access to object reading
>  - replace-object: make replace operations thread-safe
>  - grep: fix racy calls in grep_objects()
>  - grep: fix race conditions at grep_submodule()
>  - grep: fix race conditions on userdiff calls
>
>  Traditionally, we avoided threaded grep while searching in objects
>  (as opposed to files in the working tree) as accesses to the object
>  layer is not thread-safe.  This limitation is getting lifted.
>
>  Expecting a reroll.
>  cf. <CAHd-oW7UPSSExyLtfLMCObWogKrBOctYabrFrOdf9-4Q2PZmMg@mail.gmail.com>
>
>
> * jk/packfile-reuse-cleanup (2019-10-23) 9 commits
>   (merged to 'next' on 2019-11-19 at 9683853939)
>  + pack-objects: improve partial packfile reuse
>  + builtin/pack-objects: introduce obj_is_packed()
>  + pack-objects: introduce pack.allowPackReuse
>  + csum-file: introduce hashfile_total()
>  + pack-bitmap: introduce bitmap_walk_contains()
>  + pack-bitmap: don't rely on bitmap_git->reuse_objects
>  + ewah/bitmap: introduce bitmap_word_alloc()
>  + packfile: expose get_delta_base()
>  + builtin/pack-objects: report reused packfile objects
>
>  The way "git pack-objects" reuses objects stored in existing pack
>  to generate its result has been improved.
>
>  Hold.  There is an update to these patches that currently are on 'next'.
>  cf. <20191115180319.113991-1-jonathantanmy@google.com>
