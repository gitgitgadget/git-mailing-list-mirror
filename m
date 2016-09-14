Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED78C1FCA9
	for <e@80x24.org>; Wed, 14 Sep 2016 23:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758731AbcINXBP (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Sep 2016 19:01:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64688 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750815AbcINXBL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2016 19:01:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CDE883A82B;
        Wed, 14 Sep 2016 19:01:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=M
        zlxIETfj6IMyP6ZZpbmRKzcUqo=; b=oVP7oJKZBVhyUCsYQhRM8qaiefo0thUyu
        SQc1p5lWC1fzFMRUe5hqJZJM0te5e53pW0WXSpOU26u9Wt0yPFxGaTD9SJXjFMQU
        J0RuAHh+KPWE6OmJ1y84UZUWUA1ykM0Yjcro+5/XwamAM2g6RctpRdZtNGIpuRFU
        q8IXXgi2mc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=FOJ
        tRZQD6QMhdd/mS2MUYpJruGaQLxJK5XXYdajEjZ1nNGd5GnBFnWk4RVJQ72gZQ9L
        fV/WgKI/7nG8MI/MOHOmRXfLIdkElZuQyAZ1mx/jgjr1ohNl3yeDiC7G+KrsnMXJ
        qAfeOrHXbOaB86RIid2rCvcsAN0h9kPSmk0AlsCc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C426E3A82A;
        Wed, 14 Sep 2016 19:01:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E9ED23A829;
        Wed, 14 Sep 2016 19:01:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Sep 2016, #04; Wed, 14)
X-master-at: 35f6318d44379452d8d33e880d8df0267b4a0cd0
X-next-at: 15890ea0079e968c44f020c9f65b29f823b3f4cd
Date:   Wed, 14 Sep 2016 16:01:06 -0700
Message-ID: <xmqqintyozm5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1FAE4150-7ACF-11E6-9F4D-F7BB12518317-77302942!pb-smtp1.pobox.com
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

* ep/use-git-trace-curl-in-tests (2016-09-07) 4 commits
  (merged to 'next' on 2016-09-08 at 04372de)
 + t5551-http-fetch-smart.sh: use the GIT_TRACE_CURL environment var
 + t5550-http-fetch-dumb.sh: use the GIT_TRACE_CURL environment var
 + test-lib.sh: preserve GIT_TRACE_CURL from the environment
 + t5541-http-push-smart.sh: use the GIT_TRACE_CURL environment var

 Update a few tests that used to use GIT_CURL_VERBOSE to use the
 newer GIT_TRACE_CURL.


* jc/am-read-author-file (2016-08-30) 1 commit
  (merged to 'next' on 2016-09-08 at d2db42f)
 + am: refactor read_author_script()

 Extract a small helper out of the function that reads the authors
 script file "git am" internally uses.
 This by itself is not useful until a second caller appears in the
 future for "rebase -i" helper.


* jc/forbid-symbolic-ref-d-HEAD (2016-09-02) 1 commit
  (merged to 'next' on 2016-09-08 at cd8c1b3)
 + symbolic-ref -d: do not allow removal of HEAD

 "git symbolic-ref -d HEAD" happily removes the symbolic ref, but
 the resulting repository becomes an invalid one.  Teach the command
 to forbid removal of HEAD.


* jc/submodule-anchor-git-dir (2016-09-01) 1 commit
  (merged to 'next' on 2016-09-08 at b6f20cf)
 + submodule: avoid auto-discovery in prepare_submodule_repo_env()

 Having a submodule whose ".git" repository is somehow corrupt
 caused a few commands that recurse into submodules loop forever.


* jk/diff-submodule-diff-inline (2016-08-31) 8 commits
  (merged to 'next' on 2016-09-02 at 734e42c)
 + diff: teach diff to display submodule difference with an inline diff
 + submodule: refactor show_submodule_summary with helper function
 + submodule: convert show_submodule_summary to use struct object_id *
 + allow do_submodule_path to work even if submodule isn't checked out
 + diff: prepare for additional submodule formats
 + graph: add support for --line-prefix on all graph-aware output
 + diff.c: remove output_prefix_length field
 + cache: add empty_tree_oid object and helper function

 The "git diff --submodule={short,log}" mechanism has been enhanced
 to allow "--submodule=diff" to show the patch between the submodule
 commits bound to the superproject.


* jk/squelch-false-warning-from-gcc-o3 (2016-08-31) 2 commits
  (merged to 'next' on 2016-09-08 at c9a2af6)
 + color_parse_mem: initialize "struct color" temporary
 + error_errno: use constant return similar to error()

 Compilation fix.


* jk/test-lib-drop-pid-from-results (2016-08-30) 1 commit
  (merged to 'next' on 2016-09-08 at 0967b0b)
 + test-lib: drop PID from test-results/*.count

 The test framework left the number of tests and success/failure
 count in the t/test-results directory, keyed by the name of the
 test script plus the process ID.  The latter however turned out not
 to serve any useful purpose.  The process ID part of the filename
 has been removed.


* js/t6026-clean-up (2016-09-07) 1 commit
  (merged to 'next' on 2016-09-08 at 5ad2fc1)
 + t6026-merge-attr: clean up background process at end of test case

 A test spawned a short-lived background process, which sometimes
 prevented the test directory from getting removed at the end of the
 script on some platforms.


* js/t9903-chaining (2016-09-07) 1 commit
  (merged to 'next' on 2016-09-08 at 162a3c9)
 + t9903: fix broken && chain

 Test fix.


* rs/compat-strdup (2016-09-07) 1 commit
  (merged to 'next' on 2016-09-08 at 46acfdf)
 + compat: move strdup(3) replacement to its own file

 Code cleanup.


* rs/hex2chr (2016-09-07) 1 commit
  (merged to 'next' on 2016-09-08 at 7266d5b)
 + introduce hex2chr() for converting two hexadecimal digits to a character

 Code cleanup.


* sb/transport-report-missing-submodule-on-stderr (2016-09-08) 1 commit
  (merged to 'next' on 2016-09-08 at 3550831)
 + transport: report missing submodule pushes consistently on stderr

 Message cleanup.


* sb/xdiff-remove-unused-static-decl (2016-09-07) 1 commit
  (merged to 'next' on 2016-09-08 at 39e41dd)
 + xdiff: remove unneeded declarations

 Code cleanup.

--------------------------------------------------
[New Topics]

* et/add-chmod-x (2016-09-12) 1 commit
 - add: document the chmod option
 (this branch is used by tg/add-chmod+x-fix.)

 "git add --chmod=+x" added recently lacked documentation, which has
 been corrected.

 Will merge to 'next'.


* js/libify-require-clean-work-tree (2016-09-12) 5 commits
 - wt-status: teach has_{unstaged,uncommitted}_changes() about submodules
 - Export also the has_un{staged,committed}_changed() functions
 - Make the require_clean_work_tree() function truly reusable
 - pull: make code more similar to the shell script again
 - pull: drop confusing prefix parameter of die_on_unclean_work_tree()

 The require_clean_work_tree() helper was recreated in C when "git
 pull" was rewritten from shell; the helper is now made available to
 other callers in preparation for upcoming "rebase -i" work.

 Waiting for comments.
 Modulo a few minor nits, this looked almost ready.
 cf. <xmqqtwdl2bhm.fsf@gitster.mtv.corp.google.com>
 cf. <xmqqpoo92bdr.fsf@gitster.mtv.corp.google.com>


* ks/perf-build-with-autoconf (2016-09-13) 1 commit
 - t/perf/run: Don't forget to copy config.mak.autogen & friends

 Performance tests done via "t/perf" did not use the same set of
 build configuration if the user relied on autoconf generated
 configuration.

 Will merge to 'next'.


* tg/add-chmod+x-fix (2016-09-14) 5 commits
 - SQUASH???
 - add: modify already added files when --chmod is given
 - read-cache: introduce chmod_index_entry
 - update-index: add test for chmod flags
 - Merge branch 'ib/t3700-add-chmod-x-updates' into tg/add-chmod+x-fix
 (this branch uses et/add-chmod-x.)

 "git add --chmod=+x <pathspec>" added recently only toggled the
 executable bit for paths that are either new or modified. This has
 been corrected to flip the executable bit for all paths that match
 the given pathspec.

 Waiting for an ack for SQUASH???


* bw/ls-files-recurse-submodules (2016-09-13) 3 commits
 - SQUASH???  Undecided
 - SQUASH???
 - ls-files: adding support for submodules

 "git ls-files" learned "--recurse-submodules" option that can be
 used to get a listing of tracked files across submodules (i.e. this
 only works with "--cached" option, not for listing untracked or
 ignored files).  This would be a useful tool to sit on the upstream
 side of a pipe that is read with xargs to work on all working tree
 files from the top-level superproject.

 Waiting for the discussion to conclude.


* bw/pathspec-remove-unused-extern-decl (2016-09-13) 1 commit
 - pathspec: remove unnecessary function prototypes

 Code cleanup.

 Will merge to 'next'.


* ew/http-do-not-forget-to-call-curl-multi-remove-handle (2016-09-13) 3 commits
 - http: always remove curl easy from curlm session on release
 - http: consolidate #ifdefs for curl_multi_remove_handle
 - http: warn on curl_multi_add_handle failures

 The http transport (with curl-multi option, which is the default
 these days) failed to remove curl-easy handle from a curlm session,
 which led to unnecessary API failures.

 Will merge to 'next'.


* jk/delta-base-cache (2016-09-12) 1 commit
 - add_delta_base_cache: use list_for_each_safe

 Recently we updated the code to manage the in-core cache that holds
 objects that have recently been used to reconstitute other objects
 that are stored as deltas against them, but the update used an
 incorrect API function to manage the list of these objects.  This
 has been fixed.

 Will merge to 'next'.
 This is a last-minute fix to a topic that graduated to 'master'
 post 2.10 release.


* jk/setup-sequence-update (2016-09-13) 16 commits
 - t1007: factor out repeated setup
 - init: reset cached config when entering new repo
 - init: expand comments explaining config trickery
 - config: only read .git/config from configured repos
 - test-config: setup git directory
 - t1302: use "git -C"
 - pager: handle early config
 - pager: use callbacks instead of configset
 - pager: make pager_program a file-local static
 - pager: stop loading git_default_config()
 - pager: remove obsolete comment
 - diff: always try to set up the repository
 - diff: handle --no-index prefixes consistently
 - diff: skip implicit no-index check when given --no-index
 - patch-id: use RUN_SETUP_GENTLY
 - hash-object: always try to set up the git repository

 There were numerous corner cases in which the configuration files
 are read and used or not read at all depending on the directory a
 Git command was run, leading to inconsistent behaviour.  The code
 to set-up repository access at the beginning of a Git process has
 been updated to fix them.

 Will merge to 'next'.


* ls/filter-process (2016-09-13) 10 commits
 - convert: add filter.<driver>.process option
 - convert: make apply_filter() adhere to standard Git error handling
 - convert: modernize tests
 - convert: quote filter names in error messages
 - pkt-line: add functions to read/write flush terminated packet streams
 - pkt-line: add packet_write_gently()
 - pkt-line: add packet_flush_gently()
 - pkt-line: add packet_write_fmt_gently()
 - pkt-line: extract set_packet_header()
 - pkt-line: rename packet_write() to packet_write_fmt()

 The smudge/clean filter API expect an external process is spawned
 to filter the contents for each path that has a filter defined.  A
 new type of "process" filter API has been added to allow the first
 request to run the filter for a path to spawn a single process, and
 all filtering need is served by this single process for multiple
 paths, reducing the process creation overhead.

 Waiting for the discussion to conclude.
 cf. <20160910062919.GB11001@tb-raspi> etc.


* rs/checkout-some-states-are-const (2016-09-13) 1 commit
 - checkout: constify parameters of checkout_stage() and checkout_merged()

 Code cleanup.

 Will merge to 'next'.


* rs/pack-sort-with-llist-mergesort (2016-09-13) 1 commit
 - sha1_file: use llist_mergesort() for sorting packs

 Code cleanup.

 Will merge to 'next'.


* rs/strbuf-remove-fix (2016-09-13) 1 commit
 - strbuf: use valid pointer in strbuf_remove()

 Code cleanup.

 Will merge to 'next'.


* rs/unpack-trees-reduce-file-scope-global (2016-09-13) 1 commit
 - unpack-trees: pass checkout state explicitly to check_updates()

 Code cleanup.

 Will merge to 'next'.


* mr/vcs-svn-printf-ulong (2016-09-14) 1 commit
 - vcs-svn/fast_export: fix timestamp fmt specifiers

 Code cleanup.

 Will merge to 'next'.


* hv/submodule-not-yet-pushed-fix (2016-09-14) 2 commits
 - serialize collection of refs that contain submodule changes
 - serialize collection of changed submodules

--------------------------------------------------
[Stalled]

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


* jc/blame-reverse (2016-06-14) 2 commits
 - blame: dwim "blame --reverse OLD" as "blame --reverse OLD.."
 - blame: improve diagnosis for "--reverse NEW"

 It is a common mistake to say "git blame --reverse OLD path",
 expecting that the command line is dwimmed as if asking how lines
 in path in an old revision OLD have survived up to the current
 commit.

 Has been waiting for positive responses without seeing any.

 Will discard.


* jc/attr (2016-05-25) 18 commits
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
 (this branch is used by jc/attr-more, sb/pathspec-label and sb/submodule-default-paths.)

 The attributes API has been updated so that it can later be
 optimized using the knowledge of which attributes are queried.

 I wanted to polish this topic further to make the attribute
 subsystem thread-ready, but because other topics depend on this
 topic and they do not (yet) need it to be thread-ready.

 As the authors of topics that depend on this seem not in a hurry,
 let's discard this and dependent topics and restart them some other
 day.

 Will discard.


* jc/attr-more (2016-06-09) 8 commits
 - attr.c: outline the future plans by heavily commenting
 - attr.c: always pass check[] to collect_some_attrs()
 - attr.c: introduce empty_attr_check_elems()
 - attr.c: correct ugly hack for git_all_attrs()
 - attr.c: rename a local variable check
 - fixup! d5ad6c13
 - attr.c: pass struct git_attr_check down the callchain
 - attr.c: add push_stack() helper
 (this branch uses jc/attr; is tangled with sb/pathspec-label and sb/submodule-default-paths.)

 The beginning of long and tortuous journey to clean-up attribute
 subsystem implementation.

 Needs to be redone.
 Will discard.


* sb/submodule-default-paths (2016-06-20) 5 commits
 - completion: clone can recurse into submodules
 - clone: add --init-submodule=<pathspec> switch
 - submodule update: add `--init-default-path` switch
 - Merge branch 'sb/pathspec-label' into sb/submodule-default-paths
 - Merge branch 'jc/attr' into sb/submodule-default-paths
 (this branch uses jc/attr and sb/pathspec-label; is tangled with jc/attr-more.)

 Allow specifying the set of submodules the user is interested in on
 the command line of "git clone" that clones the superproject.

 Will discard.


* sb/pathspec-label (2016-06-03) 6 commits
 - pathspec: disable preload-index when attribute pathspec magic is in use
 - pathspec: allow escaped query values
 - pathspec: allow querying for attributes
 - pathspec: move prefix check out of the inner loop
 - pathspec: move long magic parsing out of prefix_pathspec
 - Documentation: fix a typo
 (this branch is used by sb/submodule-default-paths; uses jc/attr; is tangled with jc/attr-more.)

 The pathspec mechanism learned ":(attr:X)$pattern" pathspec magic
 to limit paths that match $pattern further by attribute settings.
 The preload-index mechanism is disabled when the new pathspec magic
 is in use (at least for now), because the attribute subsystem is
 not thread-ready.

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


* sb/bisect (2016-04-15) 22 commits
 . SQUASH???
 . bisect: get back halfway shortcut
 . bisect: compute best bisection in compute_relevant_weights()
 . bisect: use a bottom-up traversal to find relevant weights
 . bisect: prepare for different algorithms based on find_all
 . bisect: rename count_distance() to compute_weight()
 . bisect: make total number of commits global
 . bisect: introduce distance_direction()
 . bisect: extract get_distance() function from code duplication
 . bisect: use commit instead of commit list as arguments when appropriate
 . bisect: replace clear_distance() by unique markers
 . bisect: use struct node_data array instead of int array
 . bisect: get rid of recursion in count_distance()
 . bisect: make algorithm behavior independent of DEBUG_BISECT
 . bisect: make bisect compile if DEBUG_BISECT is set
 . bisect: plug the biggest memory leak
 . bisect: add test for the bisect algorithm
 . t6030: generalize test to not rely on current implementation
 . t: use test_cmp_rev() where appropriate
 . t/test-lib-functions.sh: generalize test_cmp_rev
 . bisect: allow 'bisect run' if no good commit is known
 . bisect: write about `bisect next` in documentation

 The internal algorithm used in "git bisect" to find the next commit
 to check has been optimized greatly.

 Was expecting a reroll, but now pb/bisect topic starts removinging
 more and more parts from git-bisect.sh, this needs to see a fresh
 reroll.

 Will discard.
 cf. <1460294354-7031-1-git-send-email-s-beyer@gmx.net>


* sg/completion-updates (2016-02-28) 21 commits
 . completion: cache the path to the repository
 . completion: extract repository discovery from __gitdir()
 . completion: don't guard git executions with __gitdir()
 . completion: consolidate silencing errors from git commands
 . completion: don't use __gitdir() for git commands
 . completion: respect 'git -C <path>'
 . completion: fix completion after 'git -C <path>'
 . completion: don't offer commands when 'git --opt' needs an argument
 . rev-parse: add '--absolute-git-dir' option
 . completion: list short refs from a remote given as a URL
 . completion: don't list 'HEAD' when trying refs completion outside of a repo
 . completion: list refs from remote when remote's name matches a directory
 . completion: respect 'git --git-dir=<path>' when listing remote refs
 . completion: fix most spots not respecting 'git --git-dir=<path>'
 . completion: ensure that the repository path given on the command line exists
 . completion tests: add tests for the __git_refs() helper function
 . completion tests: check __gitdir()'s output in the error cases
 . completion tests: consolidate getting path of current working directory
 . completion tests: make the $cur variable local to the test helper functions
 . completion tests: don't add test cruft to the test repository
 . completion: improve __git_refs()'s in-code documentation

 Has been waiting for a reroll for too long.
 cf. <1456754714-25237-1-git-send-email-szeder@ira.uka.de>

 Will discard.


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

* jk/patch-ids-no-merges (2016-09-12) 2 commits
 - patch-ids: refuse to compute patch-id for merge commit
 - patch-ids: turn off rename detection

 "git log --cherry-pick" used to include merge commits as candidates
 to be matched up with other commits, resulting a lot of wasted time.
 The patch-id generation logic has been updated to ignore merges to
 avoid the wastage.

 Will merge to 'next'.


* js/git-gui-commit-gpgsign (2016-09-11) 2 commits
  (merged to 'next' on 2016-09-12 at 05350ab)
 + Merge branch 'js/commit-gpgsign' of ../git-gui into js/git-gui-commit-gpgsign
 + git-gui: respect commit.gpgsign again

 "git commit-tree" stopped reading commit.gpgsign configuration
 variable that was meant for Porcelain "git commit" in Git 2.9; we
 forgot to update "git gui" to look at the configuration to match
 this change.

 Will merge to 'master'.


* bc/object-id (2016-09-07) 20 commits
 - builtin/reset: convert to use struct object_id
 - builtin/commit-tree: convert to struct object_id
 - builtin/am: convert to struct object_id
 - refs: add an update_ref_oid function.
 - sha1_name: convert get_sha1_mb to struct object_id
 - builtin/update-index: convert file to struct object_id
 - notes: convert init_notes to use struct object_id
 - builtin/rm: convert to use struct object_id
 - builtin/blame: convert file to use struct object_id
 - Convert read_mmblob to take struct object_id.
 - notes-merge: convert struct notes_merge_pair to struct object_id
 - builtin/checkout: convert some static functions to struct object_id
 - streaming: make stream_blob_to_fd take struct object_id
 - builtin: convert textconv_object to use struct object_id
 - builtin/cat-file: convert some static functions to struct object_id
 - builtin/cat-file: convert struct expand_data to use struct object_id
 - builtin/log: convert some static functions to use struct object_id
 - builtin/blame: convert struct origin to use struct object_id
 - builtin/apply: convert static functions to struct object_id
 - cache: convert struct cache_entry to use struct object_id

 The "unsigned char sha1[20]" to "struct object_id" conversion
 continues.  Notable changes in this round includes that ce->sha1,
 i.e. the object name recorded in the cache_entry, turns into an
 object_id.

 It had merge conflicts with a few topics in flight (Christian's
 "apply.c split", Dscho's "cat-file --filters" and Jeff Hostetler's
 "status --porcelain-v2").  Extra sets of eyes double-checking for
 mismerges are highly appreciated.

 Will merge to 'next'.


* jk/pack-tag-of-tag (2016-09-07) 5 commits
  (merged to 'next' on 2016-09-12 at 62c62c0)
 + pack-objects: walk tag chains for --include-tag
 + t5305: simplify packname handling
 + t5305: use "git -C"
 + t5305: drop "dry-run" of unpack-objects
 + t5305: move cleanup into test block

 "git pack-objects --include-tag" was taught that when we know that
 we are sending an object C, we want a tag B that directly points at
 C but also a tag A that points at the tag B.  We used to miss the
 intermediate tag B in some cases.

 Will merge to 'master'.


* jt/accept-capability-advertisement-when-fetching-from-void (2016-09-09) 3 commits
 - connect: advertized capability is not a ref
 - connect: tighten check for unexpected early hang up
 - tests: move test_lazy_prereq JGIT to test-lib.sh

 JGit can show a fake ref "capabilities^{}" to "git fetch" when it
 does not advertise any refs, but "git fetch" was not prepared to
 see such an advertisement.  When the other side disconnects without
 giving any ref advertisement, we used to say "there may not be a
 repository at that URL", but we may have seen other advertisement
 like "shallow" and ".have" in which case we definitely know that a
 repository is there.  The code to detect this case has also been
 updated.

 Will merge to 'next'.


* rt/rebase-i-broken-insn-advise (2016-09-07) 1 commit
 - rebase -i: improve advice on bad instruction lines

 When "git rebase -i" is given a broken instruction, it told the
 user to fix it with "--edit-todo", but didn't say what the step
 after that was (i.e. "--continue").

 Will hold.
 Dscho's "rebase -i" hopefully will become available in 'pu', by
 which time an equivalent of this fix would be ported to C.  This is
 queued merely as a reminder.


* sy/git-gui-i18n-ja (2016-09-07) 7 commits
  (merged to 'next' on 2016-09-12 at 4a701c2)
 + Merge branch 'sy/i18n' of git-gui
 + git-gui: update Japanese information
 + git-gui: update Japanese translation
 + git-gui: add Japanese language code
 + git-gui: apply po template to Japanese translation
 + git-gui: consistently use the same word for "blame" in Japanese
 + git-gui: consistently use the same word for "remote" in Japanese

 Update Japanese translation for "git-gui".

 Will merge to 'master'.


* ah/misc-message-fixes (2016-09-08) 5 commits
  (merged to 'next' on 2016-09-12 at a113aea)
 + unpack-trees: do not capitalize "working"
 + git-merge-octopus: do not capitalize "octopus"
 + git-rebase--interactive: fix English grammar
 + cat-file: put spaces around pipes in usage string
 + am: put spaces around pipe in usage string

 Message cleanup.

 Will merge to 'master'.


* jk/fix-remote-curl-url-wo-proto (2016-09-08) 1 commit
  (merged to 'next' on 2016-09-12 at 7845867)
 + remote-curl: handle URLs without protocol

 "git fetch http::/site/path" did not die correctly and segfaulted
 instead.

 Will merge to 'master'.


* jt/format-patch-base-info-above-sig (2016-09-14) 2 commits
 - SQUASH???
 - format-patch: show base info before email signature

 "git format-patch --base=..." feature that was recently added
 showed the base commit information after "-- " e-mail signature
 line, which turned out to be inconvenient.  The base information
 has been moved above the signature line.

 Waiting for an ack for SQUASH???


* nd/checkout-disambiguation (2016-09-09) 4 commits
 - fixup! checkout.txt: document a common case that ignores ambiguation rules
 - checkout: fix ambiguity check in subdir
 - checkout.txt: document a common case that ignores ambiguation rules
 - checkout: add some spaces between code and comment

 "git checkout <word>" does not follow the usual disambiguation
 rules when the <word> can be both a rev and a path, to allow
 checking out a branch 'foo' in a project that happens to have a
 file 'foo' in the working tree without having to disambiguate.
 This was poorly documented and the check was incorrect when the
 command was run from a subdirectory.

 Waiting for an Ack for fixup!


* sb/diff-cleanup (2016-09-08) 3 commits
  (merged to 'next' on 2016-09-12 at 5d16b28)
 + diff: remove dead code
 + diff: omit found pointer from emit_callback
 + diff.c: use diff_options directly

 Code cleanup.

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


* va/i18n (2016-09-11) 11 commits
 - i18n: update-index: mark warning for translation
 - i18n: show-branch: mark error messages for translation
 - i18n: receive-pack: mark messages for translation
 - notes: downcase the first word of error messages
 - i18n: notes: mark error messages for translation
 - i18n: merge-recursive: mark verbose message for translation
 - i18n: merge-recursive: mark error messages for translation
 - i18n: config: mark error message for translation
 - i18n: branch: mark option description for translation
 - SQUASH???
 - i18n: blame: mark error messages for translation

 More i18n.

 Waiting for a reroll.
 Some of them need to use Q_(); even when they always show numbers
 that are greater than 1, some languages have different plural forms.
 cf. <17140652.xHVhzLXte8@cayenne> etc.


* js/sequencer-wo-die (2016-09-09) 17 commits
  (merged to 'next' on 2016-09-12 at d2154ea)
 + sequencer: ensure to release the lock when we could not read the index
 + sequencer: lib'ify checkout_fast_forward()
 + sequencer: lib'ify fast_forward_to()
 + sequencer: lib'ify save_opts()
 + sequencer: lib'ify save_todo()
 + sequencer: lib'ify save_head()
 + sequencer: lib'ify create_seq_dir()
 + sequencer: lib'ify read_populate_opts()
 + sequencer: lib'ify read_populate_todo()
 + sequencer: lib'ify read_and_refresh_cache()
 + sequencer: lib'ify prepare_revs()
 + sequencer: lib'ify walk_revs_populate_todo()
 + sequencer: lib'ify do_pick_commit()
 + sequencer: lib'ify do_recursive_merge()
 + sequencer: lib'ify write_message()
 + sequencer: do not die() in do_pick_commit()
 + sequencer: lib'ify sequencer_pick_revisions()

 Lifts calls to exit(2) and die() higher in the callchain in
 sequencer.c files so that more helper functions in it can be used
 by callers that want to handle error conditions themselves.

 Will merge to 'master'.


* cp/completion-negative-refs (2016-08-24) 1 commit
 - completion: support excluding refs

 The command-line completion script (in contrib/) learned to
 complete "git cmd ^mas<HT>" to complete the negative end of
 reference to "git cmd ^master".

 Needs review.


* js/cat-file-filters (2016-09-11) 4 commits
 - cat-file: support --textconv/--filters in batch mode
 - cat-file --textconv/--filters: allow specifying the path separately
 - cat-file: introduce the --filters option
 - cat-file: fix a grammo in the man page

 Even though "git hash-objects", which is a tool to take an
 on-filesystem data stream and put it into the Git object store,
 allowed to perform the "outside-world-to-Git" conversions (e.g.
 end-of-line conversions and application of the clean-filter), and
 it had the feature on by default from very early days, its reverse
 operation "git cat-file", which takes an object from the Git object
 store and externalize for the consumption by the outside world,
 lacked an equivalent mechanism to run the "Git-to-outside-world"
 conversion.  The command learned the "--filters" option to do so.

 Will merge to 'next'.


* sb/push-make-submodule-check-the-default (2016-08-24) 1 commit
 - push: change submodule default to check

 Turn the default of "push.recurseSubmodules" to "check".

 Alas, this reveals that the "check" mode is too inefficient to use
 in real projects, even in ones as small as git itself.
 cf. <xmqqh9aaot49.fsf@gitster.mtv.corp.google.com>


* ak/curl-imap-send-explicit-scheme (2016-08-17) 1 commit
 - imap-send: Tell cURL to use imap:// or imaps://

 When we started cURL to talk to imap server when a new enough
 version of cURL library is available, we forgot to explicitly add
 imap(s):// before the destination.  To some folks, that didn't work
 and the library tried to make HTTP(s) requests instead.

 Needs review and testing.


* jk/reduce-gc-aggressive-depth (2016-08-11) 1 commit
  (merged to 'next' on 2016-08-11 at 6810c6f)
 + gc: default aggressive depth to 50

 "git gc --aggressive" used to limit the delta-chain length to 250,
 which is way too deep for gaining additional space savings and is
 detrimental for runtime performance.  The limit has been reduced to
 50.

 Will hold to see if people scream.


* ks/pack-objects-bitmap (2016-09-12) 2 commits
 - pack-objects: use reachability bitmap index when generating non-stdout pack
 - pack-objects: respect --local/--honor-pack-keep/--incremental when bitmap is in use

 Some codepaths in "git pack-objects" were not ready to use an
 existing pack bitmap; now they are and as the result they have
 become faster.

 Will merge to 'next'.


* mh/diff-indent-heuristic (2016-09-07) 9 commits
 - SQAUSH???
 - blame: honor the diff heuristic options and config
 - parse-options: add parse_opt_unknown_cb()
 - diff: improve positioning of add/delete blocks in diffs
 - xdl_change_compact(): introduce the concept of a change group
 - recs_match(): take two xrecord_t pointers as arguments
 - is_blank_line(): take a single xrecord_t as argument
 - xdl_change_compact(): only use heuristic if group can't be matched
 - xdl_change_compact(): fix compaction heuristic to adjust ixo

 Output from "git diff" can be made easier to read by selecting
 which lines are common and which lines are added/deleted
 intelligently when the lines before and after the changed section
 are the same.  A command line option is added to help with the
 experiment to find a good heuristics.

 Waiting for an ack to SQUASH???  Otherwise looked OK.


* cc/apply-am (2016-09-07) 41 commits
  (merged to 'next' on 2016-09-12 at 854edde)
 + builtin/am: use apply API in run_apply()
 + apply: learn to use a different index file
 + apply: pass apply state to build_fake_ancestor()
 + apply: refactor `git apply` option parsing
 + apply: change error_routine when silent
 + usage: add get_error_routine() and get_warn_routine()
 + usage: add set_warn_routine()
 + apply: don't print on stdout in verbosity_silent mode
 + apply: make it possible to silently apply
 + apply: use error_errno() where possible
 + apply: make some parsing functions static again
 + apply: move libified code from builtin/apply.c to apply.{c,h}
 + apply: rename and move opt constants to apply.h
 + builtin/apply: rename option parsing functions
 + builtin/apply: make create_one_file() return -1 on error
 + builtin/apply: make try_create_file() return -1 on error
 + builtin/apply: make write_out_results() return -1 on error
 + builtin/apply: make write_out_one_result() return -1 on error
 + builtin/apply: make create_file() return -1 on error
 + builtin/apply: make add_index_file() return -1 on error
 + builtin/apply: make add_conflicted_stages_file() return -1 on error
 + builtin/apply: make remove_file() return -1 on error
 + builtin/apply: make build_fake_ancestor() return -1 on error
 + builtin/apply: change die_on_unsafe_path() to check_unsafe_path()
 + builtin/apply: make gitdiff_*() return -1 on error
 + builtin/apply: make gitdiff_*() return 1 at end of header
 + builtin/apply: make parse_traditional_patch() return -1 on error
 + builtin/apply: make apply_all_patches() return 128 or 1 on error
 + builtin/apply: move check_apply_state() to apply.c
 + builtin/apply: make check_apply_state() return -1 instead of die()ing
 + apply: make init_apply_state() return -1 instead of exit()ing
 + builtin/apply: move init_apply_state() to apply.c
 + builtin/apply: make parse_ignorewhitespace_option() return -1 instead of die()ing
 + builtin/apply: make parse_whitespace_option() return -1 instead of die()ing
 + builtin/apply: make parse_single_patch() return -1 on error
 + builtin/apply: make parse_chunk() return a negative integer on error
 + builtin/apply: make find_header() return -128 instead of die()ing
 + builtin/apply: read_patch_file() return -1 instead of die()ing
 + builtin/apply: make apply_patch() return -1 or -128 instead of die()ing
 + apply: move 'struct apply_state' to apply.h
 + apply: make some names more specific

 "git am" has been taught to make an internal call to "git apply"'s
 innards without spawning the latter as a separate process.

 Will merge to 'master'.


* jk/pack-objects-optim-mru (2016-08-11) 4 commits
  (merged to 'next' on 2016-08-11 at c0a7dae)
 + pack-objects: use mru list when iterating over packs
 + pack-objects: break delta cycles before delta-search phase
 + sha1_file: make packed_object_info public
 + provide an initializer for "struct object_info"

 "git pack-objects" in a repository with many packfiles used to
 spend a lot of time looking for/at objects in them; the accesses to
 the packfiles are now optimized by checking the most-recently-used
 packfile first.

 Will hold to see if people scream.


* jk/rebase-i-drop-ident-check (2016-07-29) 1 commit
  (merged to 'next' on 2016-08-14 at 6891bcd)
 + rebase-interactive: drop early check for valid ident

 Even when "git pull --rebase=preserve" (and the underlying "git
 rebase --preserve") can complete without creating any new commit
 (i.e. fast-forwards), it still insisted on having a usable ident
 information (read: user.email is set correctly), which was less
 than nice.  As the underlying commands used inside "git rebase"
 would fail with a more meaningful error message and advice text
 when the bogus ident matters, this extra check was removed.

 Will hold to see if people scream.
 cf. <20160729224944.GA23242@sigill.intra.peff.net>


* dp/autoconf-curl-ssl (2016-06-28) 1 commit
 - ./configure.ac: detect SSL in libcurl using curl-config

 The ./configure script generated from configure.ac was taught how
 to detect support of SSL by libcurl better.

 Needs review.


* jc/pull-rebase-ff (2016-07-28) 1 commit
 - pull: fast-forward "pull --rebase=true"

 "git pull --rebase", when there is no new commits on our side since
 we forked from the upstream, should be able to fast-forward without
 invoking "git rebase", but it didn't.

 Needs a real log message and a few tests.


* ex/deprecate-empty-pathspec-as-match-all (2016-06-22) 1 commit
  (merged to 'next' on 2016-07-13 at d9ca7fb)
 + pathspec: warn on empty strings as pathspec

 An empty string used as a pathspec element has always meant
 'everything matches', but it is too easy to write a script that
 finds a path to remove in $path and run 'git rm "$paht"', which
 ends up removing everything.  Start warning about this use of an
 empty string used for 'everything matches' and ask users to use a
 more explicit '.' for that instead.

 The hope is that existing users will not mind this change, and
 eventually the warning can be turned into a hard error, upgrading
 the deprecation into removal of this (mis)feature.

 Will hold to see if people scream.


* mh/ref-store (2016-09-09) 38 commits
  (merged to 'next' on 2016-09-12 at 1b0bd3c)
 + refs: implement iteration over only per-worktree refs
 + refs: make lock generic
 + refs: add method to rename refs
 + refs: add methods to init refs db
 + refs: make delete_refs() virtual
 + refs: add method for initial ref transaction commit
 + refs: add methods for reflog
 + refs: add method iterator_begin
 + files_ref_iterator_begin(): take a ref_store argument
 + split_symref_update(): add a files_ref_store argument
 + lock_ref_sha1_basic(): add a files_ref_store argument
 + lock_ref_for_update(): add a files_ref_store argument
 + commit_ref_update(): add a files_ref_store argument
 + lock_raw_ref(): add a files_ref_store argument
 + repack_without_refs(): add a files_ref_store argument
 + refs: make peel_ref() virtual
 + refs: make create_symref() virtual
 + refs: make pack_refs() virtual
 + refs: make verify_refname_available() virtual
 + refs: make read_raw_ref() virtual
 + resolve_gitlink_ref(): rename path parameter to submodule
 + resolve_gitlink_ref(): avoid memory allocation in many cases
 + resolve_gitlink_ref(): implement using resolve_ref_recursively()
 + resolve_ref_recursively(): new function
 + read_raw_ref(): take a (struct ref_store *) argument
 + resolve_gitlink_packed_ref(): remove function
 + resolve_packed_ref(): rename function from resolve_missing_loose_ref()
 + refs: reorder definitions
 + refs: add a transaction_commit() method
 + {lock,commit,rollback}_packed_refs(): add files_ref_store arguments
 + resolve_missing_loose_ref(): add a files_ref_store argument
 + get_packed_ref(): add a files_ref_store argument
 + add_packed_ref(): add a files_ref_store argument
 + refs: create a base class "ref_store" for files_ref_store
 + refs: add a backend method structure
 + refs: rename struct ref_cache to files_ref_store
 + rename_ref_available(): add docstring
 + resolve_gitlink_ref(): eliminate temporary variable

 The ref-store abstraction was introduced to the refs API so that we
 can plug in different backends to store references.

 Will merge to 'master'.


* nd/shallow-deepen (2016-06-13) 27 commits
 - fetch, upload-pack: --deepen=N extends shallow boundary by N commits
 - upload-pack: add get_reachable_list()
 - upload-pack: split check_unreachable() in two, prep for get_reachable_list()
 - t5500, t5539: tests for shallow depth excluding a ref
 - clone: define shallow clone boundary with --shallow-exclude
 - fetch: define shallow boundary with --shallow-exclude
 - upload-pack: support define shallow boundary by excluding revisions
 - refs: add expand_ref()
 - t5500, t5539: tests for shallow depth since a specific date
 - clone: define shallow clone boundary based on time with --shallow-since
 - fetch: define shallow boundary with --shallow-since
 - upload-pack: add deepen-since to cut shallow repos based on time
 - shallow.c: implement a generic shallow boundary finder based on rev-list
 - fetch-pack: use a separate flag for fetch in deepening mode
 - fetch-pack.c: mark strings for translating
 - fetch-pack: use a common function for verbose printing
 - fetch-pack: use skip_prefix() instead of starts_with()
 - upload-pack: move rev-list code out of check_non_tip()
 - upload-pack: make check_non_tip() clean things up on error
 - upload-pack: tighten number parsing at "deepen" lines
 - upload-pack: use skip_prefix() instead of starts_with()
 - upload-pack: move "unshallow" sending code out of deepen()
 - upload-pack: remove unused variable "backup"
 - upload-pack: move "shallow" sending code out of deepen()
 - upload-pack: move shallow deepen code out of receive_needs()
 - transport-helper.c: refactor set_helper_option()
 - remote-curl.c: convert fetch_git() to use argv_array

 The existing "git fetch --depth=<n>" option was hard to use
 correctly when making the history of an existing shallow clone
 deeper.  A new option, "--deepen=<n>", has been added to make this
 easier to use.  "git clone" also learned "--shallow-since=<date>"
 and "--shallow-exclude=<tag>" options to make it easier to specify
 "I am interested only in the recent N months worth of history" and
 "Give me only the history since that version".

 Needs review.

 Rerolled.  What this topic attempts to achieve is worthwhile, I
 would think.


* pb/bisect (2016-08-23) 27 commits
 . bisect--helper: remove the dequote in bisect_start()
 . bisect--helper: retire `--bisect-auto-next` subcommand
 . bisect--helper: retire `--bisect-autostart` subcommand
 . bisect--helper: retire `--check-and-set-terms` subcommand
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

 GSoC "bisect" topic.

 I'd prefer to see early part solidified so that reviews can focus
 on the later part that is still in flux.  We are almost there but
 not quite yet.


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


* jc/merge-drop-old-syntax (2015-04-29) 1 commit
 - merge: drop 'git merge <message> HEAD <commit>' syntax

 Stop supporting "git merge <message> HEAD <commit>" syntax that has
 been deprecated since October 2007, and issues a deprecation
 warning message since v2.5.0.

 It has been reported that git-gui still uses the deprecated syntax,
 which needs to be fixed before this final step can proceed.
 cf. <5671DB28.8020901@kdbg.org>

--------------------------------------------------
[Discarded]

* jn/fix-connect-unexpected-hangup-diag (2016-09-08) 1 commit
 . connect: tighten check for unexpected early hang up

 Now part of jt/accept-capability-advertisement-when-fetching-from-void
 topic.
