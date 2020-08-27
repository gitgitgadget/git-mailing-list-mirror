Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA7FC433E6
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 21:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 215752084C
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 21:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LSrT8b4t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgH0VnO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 17:43:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55842 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgH0VnN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 17:43:13 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 44B3C88926;
        Thu, 27 Aug 2020 17:43:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=d
        Jnms3M/mvK6VeLmiUHRWgoFUEg=; b=LSrT8b4tN5wpjepTafGTigj3HEeuSsbNI
        n4i7tdp+rtH+faS0wehYlP7/YU3EGxWZqqRspH/kcdCN6RrUNXErLfXy4SaDBGFf
        +dCfQGF7X7rS4HLY7Btg12YGrBvbiAodnuPXSfceJBcbAS0iLuiWOtLcFH1aoTgh
        3ggxeYvpR0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=Dxl
        JcQ+oSiZ2rrFtkS6bAnE2717a6aHMBbhI/UMg/USng6cHnzHPTRwcfNe2ZaNpu5n
        KPgX6tB4os1vseJ06S3s82T471isqwKz29570bj/Nrcg2IWMVvCBgmdN/BqdYSAM
        iykmKMuW/J2dfdhIjlrfrlsMxrjlqdw0I7u3ccYw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3B83E88925;
        Thu, 27 Aug 2020 17:43:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 65AC688924;
        Thu, 27 Aug 2020 17:43:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Aug 2020, #07; Thu, 27)
X-master-at: 20de7e7e4f4e9ae52e6cc7cfaa6469f186ddb0fa
X-next-at: e36021eeeff56bc9a7afbe027201c2c7f8603545
Date:   Thu, 27 Aug 2020 14:43:02 -0700
Message-ID: <xmqqh7snpxy1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4990AC32-E8AE-11EA-87AD-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'seen' (formerly 'pu'---proposed updates) while commits prefixed
with '+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to 'master']

* en/mem-pool (2020-08-18) 3 commits
  (merged to 'next' on 2020-08-19 at eff9ad46f0)
 + mem-pool: use consistent pool variable name
 + mem-pool: use more standard initialization and finalization
 + mem-pool: add convenience functions for strdup and strndup

 API update.


* hn/refs-fetch-head-is-special (2020-08-19) 4 commits
  (merged to 'next' on 2020-08-21 at def233ab43)
 + refs: read FETCH_HEAD and MERGE_HEAD generically
 + refs: move gitdir into base ref_store
 + refs: fix comment about submodule ref_stores
 + refs: split off reading loose ref data in separate function
 (this branch is used by hn/refs-pseudorefs.)

 The FETCH_HEAD is now always read from the filesystem regardless of
 the ref backend in use, as its format is much richer than the
 normal refs, and written directly by "git fetch" as a plain file..


* jk/leakfix (2020-08-17) 7 commits
  (merged to 'next' on 2020-08-21 at a8b25a2657)
 + submodule--helper: fix leak of core.worktree value
 + config: fix leak in git_config_get_expiry_in_days()
 + config: drop git_config_get_string_const()
 + config: fix leaks from git_config_get_string_const()
 + checkout: fix leak of non-existent branch names
 + submodule--helper: use strbuf_release() to free strbufs
 + clear_pattern_list(): clear embedded hashmaps

 Code clean-up.


* rz/complete-more-options (2020-08-19) 2 commits
  (merged to 'next' on 2020-08-21 at ba8f4c8cb1)
 + completion: add GIT_COMPLETION_SHOW_ALL env var
 + parse-options: add --git-completion-helper-all

 Command line completion (in contrib/) usually omits redundant,
 deprecated and/or dangerous options from its output; it learned to
 optionally include all of them.

--------------------------------------------------
[New Topics]

* jc/remove-pack-redundant (2020-08-25) 1 commit
 - pack-redundant: gauge the usage before proposing its removal

 The first step to remove "git pack-redundant" by soliciting
 objections.


* ps/ref-transaction-hook (2020-08-25) 1 commit
  (merged to 'next' on 2020-08-27 at 49b3fb8349)
 + refs: remove lookup cache for reference-transaction hook

 Code simplification by removing ineffective optimization.

 Will merge to 'master'.


* jc/undash-in-tree-git-callers (2020-08-27) 3 commits
  (merged to 'next' on 2020-08-27 at 671fa2f87e)
 + credential-cache: use child_process.args
 + cvsexportcommit: do not run git programs in dashed form
 + transport-helper: do not run git-remote-ext etc. in dashed form
 (this branch is used by jc/war-on-dashed-git.)

 A handful of places in in-tree code still relied on being able to
 execute the git subcommands, especially built-ins, in "git-foo"
 form, which have been corrected.

 Will merge to 'master'.


* jc/war-on-dashed-git (2020-08-27) 1 commit
 - git: catch an attempt to run "git-foo"
 (this branch uses jc/undash-in-tree-git-callers.)

 The first step to remove on-disk binaries for built-in subcommands
 by soliciting objections.

 On hold for now.


* jk/rev-input-given-fix (2020-08-26) 1 commit
  (merged to 'next' on 2020-08-27 at da291a327c)
 + revision: set rev_input_given in handle_revision_arg()

 Feeding "$ZERO_OID" to "git log --ignore-missing --stdin", and
 running "git log --ignore-missing $ZERO_OID" fell back to start
 digging from HEAD; it has been corrected to become a no-op, like
 "git log --tags=no-tag-matches-this-pattern" does.

 Will merge to 'master'.


* tb/repack-clearing-midx (2020-08-26) 1 commit
  (merged to 'next' on 2020-08-27 at a465875cbb)
 + builtin/repack.c: invalidate MIDX only when necessary

 When a packfile is removed by "git repack", multi-pack-index gets
 cleared; the code was taught to do so less aggressively by first
 checking if the midx actually refers to a pack that no longer
 exists.

 Will merge to 'master'.


* jc/run-command-use-embedded-args (2020-08-26) 1 commit
  (merged to 'next' on 2020-08-27 at c2b688e8e9)
 + run_command: teach API users to use embedded 'args' more

 Various callers of run_command API has been modernized.

 Will merge to 'master'.


* es/worktree-repair (2020-08-27) 5 commits
 - init: make --separate-git-dir work from within linked worktree
 - init: teach --separate-git-dir to repair linked worktrees
 - worktree: teach "repair" to fix outgoing links to worktrees
 - worktree: teach "repair" to fix worktree back-links to main worktree
 - worktree: add skeleton "repair" command

 "git worktree repair" command to correct on-disk pointers between
 the repository and its secondary working trees.

 Expecting a reroll.


* jk/worktree-check-clean-leakfix (2020-08-27) 1 commit
 - worktree: fix leak in check_clean_worktree()

 Leakfix.

 Will merge to 'next'.


* so/pretty-abbrev-doc (2020-08-27) 1 commit
 - pretty-options.txt: fix --no-abbrev-commit description

 Documentation update for "--no-abbrev-commit".

 Will merge to 'next'.


* ss/submodule-summary-in-c-fixes (2020-08-27) 3 commits
 - t7421: eliminate 'grep' check in t7421.4 for mingw compatibility
 - submodule: fix style in function definition
 - submodule: eliminate unused parameters from print_submodule_summary()
 (this branch uses ss/submodule-summary-in-c.)

 Fixups to a topic in 'next'.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* tb/bloom-improvements (2020-08-11) 14 commits
 - builtin/commit-graph.c: introduce '--max-new-filters=<n>'
 - commit-graph: rename 'split_commit_graph_opts'
 - commit-graph: add large-filters bitmap chunk
 - commit-graph.c: sort index into commits list
 - bloom/diff: properly short-circuit on max_changes
 - bloom: use provided 'struct bloom_filter_settings'
 - csum-file.h: introduce 'hashwrite_be64()'
 - bloom: split 'get_bloom_filter()' in two
 - commit-graph.c: store maximum changed paths
 - commit-graph: respect 'commitGraph.readChangedPaths'
 - t/helper/test-read-graph.c: prepare repo settings
 - commit-graph: pass a 'struct repository *' in more places
 - t4216: use an '&&'-chain
 - commit-graph: introduce 'get_bloom_filter_settings()'

 Misc Bloom filter improvements.

 Expecting a reroll.
 It seems that the review is getting closer to result in another update.
 cf. <20200811220503.GC66656@syl.lan>


* es/config-hooks (2020-07-30) 6 commits
 - hook: add 'run' subcommand
 - parse-options: parse into argv_array
 - hook: add --porcelain to list command
 - hook: add list command
 - hook: scaffolding for git-hook subcommand
 - doc: propose hooks managed by the config

 The "hooks defined in config" topic.

 Expecting a reroll.
 Now jk/strvec is in 'master', we may want to see the topic reworked
 on top of it.  Are there unresolved issues, or does the topic need
 a round of detailed review?
 cf. <xmqqmu3i9kvg.fsf@gitster.c.googlers.com>


* mt/grep-sparse-checkout (2020-06-12) 6 commits
 - config: add setting to ignore sparsity patterns in some cmds
 - grep: honor sparse checkout patterns
 - config: correctly read worktree configs in submodules
 - t/helper/test-config: facilitate addition of new cli options
 - t/helper/test-config: return exit codes consistently
 - doc: grep: unify info on configuration variables

 "git grep" has been tweaked to be limited to the sparse checkout
 paths.

 Review needed on 4/6; otherwise looking sane.
 cf. <CABPp-BGdEyEeajYZj_rdxp=MyEQdszuyjVTax=hhYj3fOtRQUQ@mail.gmail.com>


* ls/mergetool-meld-auto-merge (2020-07-12) 2 commits
 - SQUASH???
 - Support auto-merge for meld to follow the vim-diff behavior

 The 'meld' backend of the "git mergetool" learned to give the
 underlying 'meld' the '--auto-merge' option, which would help
 reduce the amount of text that requires manual merging.

 Expecting a reroll.


* mf/submodule-summary-with-correct-repository (2020-06-24) 2 commits
 - submodule: use submodule repository when preparing summary
 - revision: use repository from rev_info when parsing commits

 "git diff/show" on a change that involves a submodule used to read
 the information on commits in the submodule from a wrong repository
 and gave a wrong information when the commit-graph is involved.

 Needs tests.


* dr/push-remoteref-fix (2020-04-23) 1 commit
 - remote.c: fix handling of %(push:remoteref)

 The "%(push:remoteref)" placeholder in the "--format=" argument of
 "git format-patch" (and friends) only showed what got explicitly
 configured, not what ref at the receiving end would be updated when
 "git push" was used, as it ignored the default behaviour (e.g. update
 the same ref as the source).

 Expecting a reroll.
 cf. <20200416152145.wp2zeibxmuyas6y6@feanor>


* mr/bisect-in-c-2 (2020-07-17) 14 commits
 . SQUASH??? do not add new users of git_path_bisect_head()
 . bisect--helper: retire `--bisect-autostart` subcommand
 . bisect--helper: retire `--write-terms` subcommand
 . bisect--helper: retire `--check-expected-revs` subcommand
 . bisect--helper: reimplement `bisect_state` & `bisect_head` shell functions in C
 . bisect--helper: retire `--next-all` subcommand
 . bisect--helper: retire `--bisect-clean-state` subcommand
 . bisect--helper: finish porting `bisect_start()` to C
 . bisect--helper: reimplement `bisect_next` and `bisect_auto_next` shell functions in C
 . bisect: call 'clear_commit_marks_all()' in 'bisect_next_all()'
 . bisect--helper: reimplement `bisect_autostart` shell function in C
 . bisect--helper: introduce new `write_in_file()` function
 . bisect--helper: use '-res' in 'cmd_bisect__helper' return
 . bisect--helper: BUG() in cmd_*() on invalid subcommand

 Rewrite of the remainder of "git bisect" script in C continues.

 Needs more work.
 Ejected out of 'seen'; al/bisect-first-parent topic has a bit of
 textual conflict with this topic.


* mk/use-size-t-in-zlib (2018-10-15) 1 commit
 - zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".

--------------------------------------------------
[Cooking]

* jk/refspecs-cleanup (2020-08-17) 2 commits
  (merged to 'next' on 2020-08-24 at 807a080ebf)
 + refspec: make sure stack refspec_item variables are zeroed
 + refspec: fix documentation referring to refspec_item
 (this branch is used by jk/refspecs-negative.)

 Preliminary code clean-up before introducing "negative refspec".

 Will merge to 'master'.


* rs/checkout-no-overlay-pathspec-fix (2020-08-22) 1 commit
  (merged to 'next' on 2020-08-27 at 277e39346d)
 + checkout, restore: make pathspec recursive

 "git restore/checkout --no-overlay" with wildcarded pathspec
 mistakenly removed matching paths in subdirectories, which has been
 corrected.

 Will merge to 'master'.


* al/bisect-first-parent (2020-08-22) 1 commit
  (merged to 'next' on 2020-08-24 at f95fbf45a6)
 + bisect: add first-parent option to documentation

 Finishing touches.

 Will merge to 'master'.


* js/no-builtins-on-disk-option (2020-08-24) 3 commits
 - ci: stop linking built-ins to the dashed versions
 - install: optionally skip linking/copying the built-ins
 - msvc: copy the correct `.pdb` files in the Makefile target `install`

 The installation procedure learned to optionally omit "git-foo"
 executable files for each 'foo' built-in subcommand, which are only
 required by old timers that still rely on the age old promise that
 prepending "git --exec-path" output to PATH early in their script
 will keep the "git-foo" calls they wrote working.

 The old attempt to remove these executables from the disk failed in
 the 1.6 era; it may be worth attempting again, but I think it is
 worth to keep this topic separate from such a policy change to help
 it graduate early.

 cf. https://public-inbox.org/git/7vprnzt7d5.fsf@gitster.siamese.dyndns.org/


* jt/threaded-index-pack (2020-08-27) 9 commits
 - builtin/index-pack.c: fix some sparse warnings
 - fixup! index-pack: make quantum of work smaller
 - index-pack: make quantum of work smaller
 - index-pack: make resolve_delta() assume base data
 - index-pack: calculate {ref,ofs}_{first,last} early
 - index-pack: remove redundant child field
 - index-pack: unify threaded and unthreaded code
 - index-pack: remove redundant parameter
 - Documentation: deltaBaseCacheLimit is per-thread

 "git index-pack" learned to resolve deltified objects with greater
 parallelism.


* hn/refs-pseudorefs (2020-08-21) 4 commits
  (merged to 'next' on 2020-08-24 at 3579abe8ff)
 + sequencer: treat REVERT_HEAD as a pseudo ref
 + builtin/commit: suggest update-ref for pseudoref removal
 + sequencer: treat CHERRY_PICK_HEAD as a pseudo ref
 + refs: make refs_ref_exists public

 Accesses to two pseudorefs have been updated to properly use ref
 API.

 Will merge to 'master'.


* jt/promisor-pack-fix (2020-08-20) 1 commit
  (merged to 'next' on 2020-08-24 at cd26d30d8d)
 + fetch-pack: in partial clone, pass --promisor

 Updates into a lazy/partial clone with a submodule did not work
 well with transfer.fsckobjects set.

 Will merge to 'master'.


* hv/ref-filter-trailers-atom-parsing-fix (2020-08-21) 2 commits
  (merged to 'next' on 2020-08-24 at 79b27f3263)
 + ref-filter: 'contents:trailers' show error if `:` is missing
 + t6300: unify %(trailers) and %(contents:trailers) tests

 The parser for "git for-each-ref --format=..." was too loose when
 parsing the "%(trailers...)" atom, and forgot that "trailers" and
 "trailers:<modifers>" are the only two allowed forms, which has
 been corrected.

 Will merge to 'master'.


* jc/ident-whose-ident (2020-08-21) 1 commit
  (merged to 'next' on 2020-08-27 at caf5149c28)
 + ident: say whose identity is missing when giving user.name hint

 Error message update.

 Will merge to 'master'.


* jk/index-pack-w-more-threads (2020-08-21) 3 commits
  (merged to 'next' on 2020-08-24 at 18f18a5b66)
 + index-pack: adjust default threading cap
 + p5302: count up to online-cpus for thread tests
 + p5302: disable thread-count parameter tests by default

 Long ago, we decided to use 3 threads by default when running the
 index-pack task in parallel, which has been adjusted a bit upwards.

 Will merge to 'master'.


* rp/apply-cached-doc (2020-08-20) 1 commit
  (merged to 'next' on 2020-08-27 at 1d610f08ea)
 + git-apply.txt: update descriptions of --cached, --index

 The description of --cached/--index options in "git apply --help"
 has been updated.

 Will merge to 'master'.


* dd/diff-customize-index-line-abbrev (2020-08-21) 2 commits
  (merged to 'next' on 2020-08-24 at 74e842a2c8)
 + diff: index-line: respect --abbrev in object's name
 + t4013: improve diff-post-processor logic

 The output from the "diff" family of the commands had abbreviated
 object names of blobs involved in the patch, but its length was not
 affected by the --abbrev option.  Now it is.

 Will merge to 'master'.


* hv/ref-filter-misc (2020-08-17) 9 commits
  (merged to 'next' on 2020-08-27 at c015fa6b0f)
 + ref-filter: add `sanitize` option for 'subject' atom
 + format-support: move `format_sanitized_subject()` from pretty
 + pretty: refactor `format_sanitized_subject()`
 + ref-filter: add `short` modifier to 'parent' atom
 + ref-filter: add `short` modifier to 'tree' atom
 + ref-filter: rename `objectname` related functions and fields
 + ref-filter: modify error messages in `grab_objectname()`
 + ref-filter: refactor `grab_objectname()`
 + ref-filter: support different email formats

 The "--format=" option to the "for-each-ref" command and friends
 learned a few more tricks, e.g. the ":short" suffix that applies to
 "objectname" now also can be used for "parent", "tree", etc.

 Will merge to 'master'.


* jk/refspecs-negative (2020-08-21) 1 commit
 - refspec: add support for negative refspecs
 (this branch uses jk/refspecs-cleanup.)

 "negative refspecs"


* jt/fetch-pack-loosen-validation-with-packfile-uri (2020-08-24) 3 commits
  (merged to 'next' on 2020-08-27 at efd171f172)
 + fetch-pack: make packfile URIs work with transfer.fsckobjects
 + fetch-pack: document only_packfile in get_pack()
 + (various): document from_promisor parameter

 Bugfix for "git fetch" when the packfile URI capability is in use.

 Will merge to 'master'.


* mr/diff-hide-stat-wo-textual-change (2020-08-19) 1 commit
  (merged to 'next' on 2020-08-27 at b9e97254ae)
 + diff: teach --stat to ignore uninteresting modifications

 "git diff --stat -w" showed 0-line changes for paths whose changes
 were only whitespaces, which was not intuitive.  We now omit such
 paths from the stat output.

 Will merge to 'master'.


* pw/add-p-allowed-options-fix (2020-08-17) 2 commits
  (merged to 'next' on 2020-08-27 at 6cd62753f7)
 + add -p: fix checking of user input
 + add -p: use ALLOC_GROW_BY instead of ALLOW_GROW

 "git add -p" update.

 Will merge to 'master'.


* jt/lazy-fetch (2020-08-18) 7 commits
  (merged to 'next' on 2020-08-27 at 85f2319ba1)
 + fetch-pack: remove no_dependents code
 + promisor-remote: lazy-fetch objects in subprocess
 + fetch-pack: do not lazy-fetch during ref iteration
 + fetch: only populate existing_refs if needed
 + fetch: avoid reading submodule config until needed
 + fetch: allow refspecs specified through stdin
 + negotiator/noop: add noop fetch negotiator

 Updates to on-demand fetching code in lazily cloned repositories.

 Will merge to 'master'.


* jx/proc-receive-hook (2020-08-27) 10 commits
 - doc: add documentation for the proc-receive hook
 - transport: parse report options for tracking refs
 - t5411: test updates of remote-tracking branches
 - receive-pack: new config receive.procReceiveRefs
 - doc: add document for capability report-status-v2
 - New capability "report-status-v2" for git-push
 - receive-pack: feed report options to post-receive
 - receive-pack: add new proc-receive hook
 - t5411: add basic test cases for proc-receive hook
 - transport: not report a non-head push as a branch

 "git receive-pack" that accepts requests by "git push" learned to
 outsource most of the ref updates to the new "proc-receive" hook.

 Looking good.


* pw/rebase-i-more-options (2020-08-26) 6 commits
  (merged to 'next' on 2020-08-27 at c55cfeb247)
 + t3436: do not run git-merge-recursive in dashed form
  (merged to 'next' on 2020-08-21 at ade71fd49b)
 + rebase: add --reset-author-date
 + rebase -i: support --ignore-date
 + rebase -i: support --committer-date-is-author-date
 + am: stop exporting GIT_COMMITTER_DATE
 + rebase -i: add --ignore-whitespace flag

 "git rebase -i" learns a bit more options.

 Will merge to 'master'.


* jk/slimmed-down (2020-08-13) 5 commits
  (merged to 'next' on 2020-08-27 at bc8e9450c6)
 + drop vcs-svn experiment
 + make git-fast-import a builtin
 + make git-bugreport a builtin
 + make credential helpers builtins
 + Makefile: drop builtins from MSVC pdb list

 Trim an unused binary and turn a bunch of commands into built-in.

 Will merge to 'master'.


* ss/t7401-modernize (2020-08-21) 5 commits
  (merged to 'next' on 2020-08-27 at 516cba9c64)
 + t7401: add a NEEDSWORK
 + t7401: change indentation for enhanced readability
 + t7401: change syntax of test_i18ncmp calls for clarity
 + t7401: use 'short' instead of 'verify' and cut in rev-parse calls
 + t7401: modernize style

 Test clean-up.

 Will merge to 'master'.


* ds/maintenance-part-2 (2020-08-25) 8 commits
 - maintenance: add incremental-repack auto condition
 - maintenance: auto-size incremental-repack batch
 - maintenance: add incremental-repack task
 - midx: use start_delayed_progress()
 - midx: enable core.multiPackIndex by default
 - maintenance: create auto condition for loose-objects
 - maintenance: add loose-objects task
 - maintenance: add prefetch task
 (this branch uses ds/maintenance-part-1.)

 "git maintenance", an extended big brother of "git gc", continues
 to evolve.


* ss/submodule-summary-in-c (2020-08-12) 4 commits
  (merged to 'next' on 2020-08-17 at 9bc352cb70)
 + submodule: port submodule subcommand 'summary' from shell to C
 + t7421: introduce a test script for verifying 'summary' output
 + submodule: rename helper functions to avoid ambiguity
 + submodule: remove extra line feeds between callback struct and macro
 (this branch is used by ss/submodule-summary-in-c-fixes.)

 Yet another subcommand of "git submodule" is getting rewritten in C.

 Looking good.


* am/ci-wsfix (2020-08-21) 1 commit
  (merged to 'next' on 2020-08-24 at 8491e031f1)
 + ci: fix inconsistent indentation

 Aesthetic fix to a CI configuration file.

 Will merge to 'master'.


* ds/maintenance-part-1 (2020-08-25) 11 commits
 - maintenance: add trace2 regions for task execution
 - maintenance: add auto condition for commit-graph task
 - maintenance: use pointers to check --auto
 - maintenance: create maintenance.<task>.enabled config
 - maintenance: take a lock on the objects directory
 - maintenance: add --task option
 - maintenance: add commit-graph task
 - maintenance: initialize task array
 - maintenance: replace run_auto_gc()
 - maintenance: add --quiet option
 - maintenance: create basic maintenance runner
 (this branch is used by ds/maintenance-part-2.)

 A "git gc"'s big brother has been introduced to take care of more
 repository maintenance tasks, not limited to the object database
 cleaning.

 Comments?
