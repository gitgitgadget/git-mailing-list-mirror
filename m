Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2243F1F935
	for <e@80x24.org>; Wed, 21 Sep 2016 23:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756366AbcIUXbZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 19:31:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54567 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755947AbcIUXbV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 19:31:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0EAD540F95;
        Wed, 21 Sep 2016 19:31:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=r
        Yqutqh+ilDDDElB4m1KYJH9XzQ=; b=es8c2vnIuEcAVKpQ1zt1s/+lWSL0NWJSh
        9nOD/iG0uQAqnL6Em/IdXdvCHI9p4D7RHe0cZG7XCzMVMY9JuNn3loobDoqJwaen
        fT/AKttvOVjKN5tDfTMMhAujrxPH0J3xfR/0MgqTrR8eCZYpGxMs5he6JioMpVz2
        yq1P/gQQ1A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=eTc
        ZK8PykxnDAVSVDDoWRuf/xuf0ZjkCXeRR1efoMYsOrYzRy+rEQtn9+2zUTTLvay9
        0XU0fPsPfWyTRhZ/v0kGxqpxRFu+zdejlaDnBejqfZm6a454BCjulWUQlXnnP2rx
        hGUtsCUgpPAL0rMErxRdD9/h4x2k/QLS4tzF+7pE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0266340F94;
        Wed, 21 Sep 2016 19:31:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 14FC040F93;
        Wed, 21 Sep 2016 19:31:19 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Sep 2016, #06; Wed, 21)
X-master-at: 6fe1b1407ed91823daa5d487abe457ff37463349
X-next-at: 97b919bdbde768487edc76513548a747496e2579
Date:   Wed, 21 Sep 2016 16:31:16 -0700
Message-ID: <xmqqk2e46da3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7F7E83CC-8053-11E6-AD94-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

Quite a lot of topics have graduated to 'master'.  The tip of 'next'
has been rewound and rebuilt.  Accumulated fixes since v2.10.0 are
now almost ready to spawn the first maintenance update v2.10.1 but
not quite yet.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* bw/pathspec-remove-unused-extern-decl (2016-09-13) 1 commit
  (merged to 'next' on 2016-09-15 at c5b281b)
 + pathspec: remove unnecessary function prototypes

 Code cleanup.


* et/add-chmod-x (2016-09-12) 1 commit
  (merged to 'next' on 2016-09-15 at c81abae)
 + add: document the chmod option
 (this branch is used by tg/add-chmod+x-fix.)

 "git add --chmod=+x" added recently lacked documentation, which has
 been corrected.


* ew/http-do-not-forget-to-call-curl-multi-remove-handle (2016-09-13) 3 commits
  (merged to 'next' on 2016-09-15 at 696acb7)
 + http: always remove curl easy from curlm session on release
 + http: consolidate #ifdefs for curl_multi_remove_handle
 + http: warn on curl_multi_add_handle failures

 The http transport (with curl-multi option, which is the default
 these days) failed to remove curl-easy handle from a curlm session,
 which led to unnecessary API failures.


* jk/delta-base-cache (2016-09-12) 1 commit
  (merged to 'next' on 2016-09-15 at 1e35f8d)
 + add_delta_base_cache: use list_for_each_safe

 Recently we updated the code to manage the in-core cache that holds
 objects that have recently been used to reconstitute other objects
 that are stored as deltas against them, but the update used an
 incorrect API function to manage the list of these objects.  This
 has been fixed.
 This is a last-minute fix to a topic that graduated to 'master'
 post 2.10 release.


* jk/patch-ids-no-merges (2016-09-12) 2 commits
  (merged to 'next' on 2016-09-15 at 14bb3a0)
 + patch-ids: refuse to compute patch-id for merge commit
 + patch-ids: turn off rename detection

 "git log --cherry-pick" used to include merge commits as candidates
 to be matched up with other commits, resulting a lot of wasted time.
 The patch-id generation logic has been updated to ignore merges to
 avoid the wastage.


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


* jk/reduce-gc-aggressive-depth (2016-08-11) 1 commit
  (merged to 'next' on 2016-08-11 at 6810c6f)
 + gc: default aggressive depth to 50

 "git gc --aggressive" used to limit the delta-chain length to 250,
 which is way too deep for gaining additional space savings and is
 detrimental for runtime performance.  The limit has been reduced to
 50.


* jk/setup-sequence-update (2016-09-13) 16 commits
  (merged to 'next' on 2016-09-15 at 4df8399)
 + t1007: factor out repeated setup
 + init: reset cached config when entering new repo
 + init: expand comments explaining config trickery
 + config: only read .git/config from configured repos
 + test-config: setup git directory
 + t1302: use "git -C"
 + pager: handle early config
 + pager: use callbacks instead of configset
 + pager: make pager_program a file-local static
 + pager: stop loading git_default_config()
 + pager: remove obsolete comment
 + diff: always try to set up the repository
 + diff: handle --no-index prefixes consistently
 + diff: skip implicit no-index check when given --no-index
 + patch-id: use RUN_SETUP_GENTLY
 + hash-object: always try to set up the git repository
 (this branch is used by nd/init-core-worktree-in-multi-worktree-world.)

 There were numerous corner cases in which the configuration files
 are read and used or not read at all depending on the directory a
 Git command was run, leading to inconsistent behaviour.  The code
 to set-up repository access at the beginning of a Git process has
 been updated to fix them.


* js/cat-file-filters (2016-09-11) 4 commits
  (merged to 'next' on 2016-09-15 at a231380)
 + cat-file: support --textconv/--filters in batch mode
 + cat-file --textconv/--filters: allow specifying the path separately
 + cat-file: introduce the --filters option
 + cat-file: fix a grammo in the man page

 Even though "git hash-objects", which is a tool to take an
 on-filesystem data stream and put it into the Git object store,
 allowed to perform the "outside-world-to-Git" conversions (e.g.
 end-of-line conversions and application of the clean-filter), and
 it had the feature on by default from very early days, its reverse
 operation "git cat-file", which takes an object from the Git object
 store and externalize for the consumption by the outside world,
 lacked an equivalent mechanism to run the "Git-to-outside-world"
 conversion.  The command learned the "--filters" option to do so.


* jt/accept-capability-advertisement-when-fetching-from-void (2016-09-09) 3 commits
  (merged to 'next' on 2016-09-15 at 1cd9f9a)
 + connect: advertized capability is not a ref
 + connect: tighten check for unexpected early hang up
 + tests: move test_lazy_prereq JGIT to test-lib.sh

 JGit can show a fake ref "capabilities^{}" to "git fetch" when it
 does not advertise any refs, but "git fetch" was not prepared to
 see such an advertisement.  When the other side disconnects without
 giving any ref advertisement, we used to say "there may not be a
 repository at that URL", but we may have seen other advertisement
 like "shallow" and ".have" in which case we definitely know that a
 repository is there.  The code to detect this case has also been
 updated.


* jt/format-patch-base-info-above-sig (2016-09-15) 1 commit
  (merged to 'next' on 2016-09-15 at 3da5c68)
 + format-patch: show base info before email signature

 "git format-patch --base=..." feature that was recently added
 showed the base commit information after "-- " e-mail signature
 line, which turned out to be inconvenient.  The base information
 has been moved above the signature line.


* ks/pack-objects-bitmap (2016-09-12) 2 commits
  (merged to 'next' on 2016-09-15 at e0600bd)
 + pack-objects: use reachability bitmap index when generating non-stdout pack
 + pack-objects: respect --local/--honor-pack-keep/--incremental when bitmap is in use

 Some codepaths in "git pack-objects" were not ready to use an
 existing pack bitmap; now they are and as the result they have
 become faster.


* ks/perf-build-with-autoconf (2016-09-15) 1 commit
  (merged to 'next' on 2016-09-15 at 261878d)
 + t/perf/run: copy config.mak.autogen & friends to build area

 Performance tests done via "t/perf" did not use the same set of
 build configuration if the user relied on autoconf generated
 configuration.


* mr/vcs-svn-printf-ulong (2016-09-14) 1 commit
  (merged to 'next' on 2016-09-15 at cc8ef53)
 + vcs-svn/fast_export: fix timestamp fmt specifiers

 Code cleanup.


* rs/checkout-some-states-are-const (2016-09-13) 1 commit
  (merged to 'next' on 2016-09-15 at 19f219b)
 + checkout: constify parameters of checkout_stage() and checkout_merged()

 Code cleanup.


* rs/pack-sort-with-llist-mergesort (2016-09-13) 1 commit
  (merged to 'next' on 2016-09-15 at 45159f5)
 + sha1_file: use llist_mergesort() for sorting packs

 Code cleanup.


* rs/strbuf-remove-fix (2016-09-13) 1 commit
  (merged to 'next' on 2016-09-15 at 5f64556)
 + strbuf: use valid pointer in strbuf_remove()

 Code cleanup.


* rs/unpack-trees-reduce-file-scope-global (2016-09-13) 1 commit
  (merged to 'next' on 2016-09-15 at cd16435)
 + unpack-trees: pass checkout state explicitly to check_updates()

 Code cleanup.


* rs/xdiff-merge-overlapping-hunks-for-W-context (2016-09-14) 1 commit
  (merged to 'next' on 2016-09-15 at eaa85ab)
 + xdiff: fix merging of hunks with -W context and -u context

 "git diff -W" output needs to extend the context backward to
 include the header line of the current function and also forward to
 include the body of the entire current function up to the header
 line of the next one.  This process may have to merge to adjacent
 hunks, but the code forgot to do so in some cases.


* va/i18n (2016-09-15) 11 commits
  (merged to 'next' on 2016-09-15 at 2b3d368)
 + i18n: update-index: mark warnings for translation
 + i18n: show-branch: mark plural strings for translation
 + i18n: show-branch: mark error messages for translation
 + i18n: receive-pack: mark messages for translation
 + notes: spell first word of error messages in lowercase
 + i18n: notes: mark error messages for translation
 + i18n: merge-recursive: mark verbose message for translation
 + i18n: merge-recursive: mark error messages for translation
 + i18n: config: mark error message for translation
 + i18n: branch: mark option description for translation
 + i18n: blame: mark error messages for translation
 (this branch is used by va/i18n-more.)

 More i18n.

--------------------------------------------------
[New Topics]

* ep/doc-check-ref-format-example (2016-09-21) 1 commit
 - git-check-ref-format.txt: fixup documentation

 A shell script example in check-ref-format documentation has been
 fixed.

 Will merge to 'next'.


* js/regexec-buf (2016-09-21) 3 commits
 - regex: use regexec_buf()
 - regex: add regexec_buf() that can work on a non NUL-terminated string
 - regex: -G<pattern> feeds a non NUL-terminated string to regexec() and fails

 Some codepaths in "git diff" used regexec(3) on a buffer that was
 mmap(2)ed, which may not have a terminating NUL, leading to a read
 beyond the end of the mapped region.  This was fixed by introducing
 a regexec_buf() helper that takes a <ptr,len> pair with REG_STARTEND
 extension.

 Waiting for an Ack to minor tweaks.
 cf. <cover.1474482164.git.johannes.schindelin@gmx.de>


* jt/format-patch-rfc (2016-09-21) 1 commit
 - format-patch: add "--rfc" for the common case of [RFC PATCH]

 In some projects it is common to use "[RFC PATCH]" as the subject
 prefix for a patch meant for discussion rather than application.  A
 new option "--rfc" was a short-hand for "--subject-prefix=RFC PATCH"
 to help the participants of such projects.

 Will merge to 'next'.


* ls/travis-homebrew-path-fix (2016-09-21) 1 commit
 - travis-ci: ask homebrew for the its path instead of hardcoding it

 The procedure to build Git on Mac OS X for Travis CI hardcoded the
 internal directory structure we assumed HomeBrew uses, which was a
 no-no.  The procedure has been updated to ask HomeBrew things we
 need to know to fix this.

 Will merge to 'next'.


* nd/init-core-worktree-in-multi-worktree-world (2016-09-21) 3 commits
 - init: reuse original_git_dir in set_git_dir_init()
 - init: do not set core.worktree more often than necessary
 - init: correct re-initialization from a linked worktree

 "git init" tried to record core.worktree in the repository's
 'config' file when GIT_WORK_TREE environment variable was set and
 it was different from where GIT_DIR appears as ".git" at its top,
 but the logic was faulty when .git is a "gitdir:" file that points
 at the real place, causing trouble in working trees that are
 managed by "git worktree".  This has been corrected.

 The second one seems to need a bit more polishing.
 cf. <xmqqd1jx854z.fsf@gitster.mtv.corp.google.com>

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

* mm/config-color-ui-default-to-auto (2016-09-16) 1 commit
 - Documentation/config: default for color.* is color.ui

 Documentation for individual configuration variables to control use
 of color (like `color.grep`) said that their default value was
 'false', instead of saying their default is taken from `color.ui`.
 When we updated the default value for color.ui from 'false' to
 'auto' quite a while ago, all of them broke.  This has been
 corrected.

 Will merge to 'next'.


* rs/c-auto-resets-attributes (2016-09-19) 1 commit
 - pretty: let %C(auto) reset all attributes

 The pretty-format specifier used by the "log" family of commands
 have "%C(auto)" to turn coloring of the output is taught to also
 issue a color-reset sequence to the output.

 Will merge to 'next'.


* rs/cocci (2016-09-15) 3 commits
 - use strbuf_addstr() for adding constant strings to a strbuf, part 2
 - add coccicheck make target
 - contrib/coccinelle: fix semantic patch for oid_to_hex_r()

 Code cleanup.

 Will merge to 'next'.


* va/i18n-more (2016-09-21) 6 commits
 - i18n: stash: mark messages for translation
 - i18n: notes-merge: mark die messages for translation
 - i18n: ident: mark hint for translation
 - i18n: i18n: diff: mark die messages for translation
 - i18n: connect: mark die messages for translation
 - i18n: commit: mark message for translation

 Even more i18n.

 Will merge to 'next'.


* jt/mailinfo-fold-in-body-headers (2016-09-21) 3 commits
 - mailinfo: handle in-body header continuations
 - mailinfo: make is_scissors_line take plain char *
 - mailinfo: separate in-body header processing

 When "git format-patch --stdout" output is placed as an in-body
 header and it used the RFC2822 header folding, "git am" failed to
 notice and put the header line back into a single logical line.
 The underlying "git mailinfo" was taught to handle this properly.

 Will merge to 'next'.


* kd/mailinfo-quoted-string (2016-09-19) 2 commits
 - mailinfo: unescape quoted-pair in header fields
 - t5100-mailinfo: replace common path prefix with variable

 An e-mail author named that spelled a backslash-quoted double quote
 in the human readable part "My \"double quoted\" name" was not
 unquoted correctly.

 Waiting for the discussion to conclude.
 cf. <20160920035710.qw2byl3qeqwih7t5@sigill.intra.peff.net>


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


* tg/add-chmod+x-fix (2016-09-21) 6 commits
 - t3700-add: do not check working tree file mode without POSIXPERM
 - t3700-add: create subdirectory gently
 - add: modify already added files when --chmod is given
 - read-cache: introduce chmod_index_entry
 - update-index: add test for chmod flags
 - Merge branch 'ib/t3700-add-chmod-x-updates' into tg/add-chmod+x-fix

 "git add --chmod=+x <pathspec>" added recently only toggled the
 executable bit for paths that are either new or modified. This has
 been corrected to flip the executable bit for all paths that match
 the given pathspec.

 Waiting for the discussion to conclude.
 cf. <c3aefd9d-b794-21a1-619e-bce6a3c2cf47@kdbg.org>


* bw/ls-files-recurse-submodules (2016-09-21) 2 commits
 - ls-files: add pathspec matching for submodules
 - ls-files: optionally recurse into submodules

 "git ls-files" learned "--recurse-submodules" option that can be
 used to get a listing of tracked files across submodules (i.e. this
 only works with "--cached" option, not for listing untracked or
 ignored files).  This would be a useful tool to sit on the upstream
 side of a pipe that is read with xargs to work on all working tree
 files from the top-level superproject.

 Waiting for the discussion to conclude.


* ls/filter-process (2016-09-21) 11 commits
 - convert: add filter.<driver>.process option
 - convert: make apply_filter() adhere to standard Git error handling
 - convert: modernize tests
 - convert: quote filter names in error messages
 - pkt-line: add functions to read/write flush terminated packet streams
 - pkt-line: add packet_write_gently()
 - pkt-line: add packet_flush_gently()
 - pkt-line: add packet_write_fmt_gently()
 - run-command: move check_pipe() from write_or_die to run_command
 - pkt-line: extract set_packet_header()
 - pkt-line: rename packet_write() to packet_write_fmt()

 The smudge/clean filter API expect an external process is spawned
 to filter the contents for each path that has a filter defined.  A
 new type of "process" filter API has been added to allow the first
 request to run the filter for a path to spawn a single process, and
 all filtering need is served by this single process for multiple
 paths, reducing the process creation overhead.

 Is this ready?


* hv/submodule-not-yet-pushed-fix (2016-09-15) 5 commits
 . SQUASH??? -Wdecl-after-stmt
 . use actual start hashes for submodule push check instead of local refs
 . batch check whether submodule needs pushing into one call
 - serialize collection of refs that contain submodule changes
 - serialize collection of changed submodules

 The code in "git push" to compute if any commit being pushed in the
 superproject binds a commit in a submodule that hasn't been pushed
 out was overly inefficient, making it unusable even for a small
 project that does not have any submodule but have a reasonable
 number of refs.  This has been optimized.

 The last two in the original series seem to break a few tests when
 queued to 'pu'.


* rt/rebase-i-broken-insn-advise (2016-09-07) 1 commit
 - rebase -i: improve advice on bad instruction lines

 When "git rebase -i" is given a broken instruction, it told the
 user to fix it with "--edit-todo", but didn't say what the step
 after that was (i.e. "--continue").

 Will hold.
 Dscho's "rebase -i" hopefully will become available in 'pu', by
 which time an equivalent of this fix would be ported to C.  This is
 queued merely as a reminder.


* nd/checkout-disambiguation (2016-09-21) 3 commits
 - checkout: fix ambiguity check in subdir
 - checkout.txt: document a common case that ignores ambiguation rules
 - checkout: add some spaces between code and comment

 "git checkout <word>" does not follow the usual disambiguation
 rules when the <word> can be both a rev and a path, to allow
 checking out a branch 'foo' in a project that happens to have a
 file 'foo' in the working tree without having to disambiguate.
 This was poorly documented and the check was incorrect when the
 command was run from a subdirectory.

 Will merge to 'next'.


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


* cp/completion-negative-refs (2016-08-24) 1 commit
 - completion: support excluding refs

 The command-line completion script (in contrib/) learned to
 complete "git cmd ^mas<HT>" to complete the negative end of
 reference to "git cmd ^master".

 Needs review.


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


* mh/diff-indent-heuristic (2016-09-19) 8 commits
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

 Will merge to 'next'.


* jk/pack-objects-optim-mru (2016-08-11) 4 commits
  (merged to 'next' on 2016-09-21 at 97b919b)
 + pack-objects: use mru list when iterating over packs
 + pack-objects: break delta cycles before delta-search phase
 + sha1_file: make packed_object_info public
 + provide an initializer for "struct object_info"

 Originally merged to 'next' on 2016-08-11

 "git pack-objects" in a repository with many packfiles used to
 spend a lot of time looking for/at objects in them; the accesses to
 the packfiles are now optimized by checking the most-recently-used
 packfile first.

 Will hold to see if people scream.


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
  (merged to 'next' on 2016-09-21 at e19148e)
 + pathspec: warn on empty strings as pathspec

 Originally merged to 'next' on 2016-07-13

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
