Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5C771F462
	for <e@80x24.org>; Thu, 20 Jun 2019 04:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfFTEfO (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 00:35:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56767 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfFTEfN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 00:35:13 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E26A6168E9A;
        Thu, 20 Jun 2019 00:35:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=a
        num/+SHk9pjA0eRqTNHRYdaquU=; b=qgaq5HFqySVIsP00oVF/b/fnD/gccFiiE
        VDR1ZJ07ie3NvdldouQafhTVJGCWcGUDdnaBbkaUnTmzpsNwHY0WLKZMKW0d+I99
        jwPj3n4/nTQ/tsyTUcAfzMo1xQ2YtEnLO4bWO1lu+SZbF+SPdUhjCPbDsp9bB1Qs
        sj8Lskg4/g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=b3i
        URNSWsHBxrGajp6K6oia99uLluICz0mtYpb6npZPAIcpwBFJtehdNux7teHk3aNN
        y5bom/jDGbwdsDosujmkUKBIBzXD1WJ2rwaKm5pTSGLeK7c6fDtvPLTZ/atMtzVm
        uDyQYrU404WicEJqDDrhTMpT2a5NpAKxIHQ+8ZUI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D9788168E98;
        Thu, 20 Jun 2019 00:35:05 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 17702168E96;
        Thu, 20 Jun 2019 00:35:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Jun 2019, #05; Wed, 19)
X-master-at: a6a95cd1b46e48e5fe06bdbb0839a67ebeef4682
X-next-at: 172b71a6c5b95846749746f7d63238d5f702bb00
Date:   Wed, 19 Jun 2019 21:35:03 -0700
Message-ID: <xmqqef3oq3go.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C68AE0A4-9314-11E9-BC74-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

The second batch of topics post 2.22 are now in 'master'.  Let's
thin down the topics still in 'next' before taking anything new, and
try to keep this cycle short.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ba/clone-remote-submodules (2019-05-28) 1 commit
  (merged to 'next' on 2019-05-29 at 71972f94c2)
 + clone: add `--remote-submodules` flag

 "git clone --recurse-submodules" learned to set up the submodules
 to ignore commit object names recorded in the superproject gitlink
 and instead use the commits that happen to be at the tip of the
 remote-tracking branches from the get-go, by passing the new
 "--remote-submodules" option.


* bb/unicode-12.1-reiwa (2019-05-29) 1 commit
  (merged to 'next' on 2019-05-30 at 016465335c)
 + unicode: update the width tables to Unicode 12.1

 Update to Unicode 12.1 width table.


* bl/userdiff-octave (2019-05-29) 2 commits
  (merged to 'next' on 2019-05-29 at 6ed07afc89)
 + userdiff: fix grammar and style issues
  (merged to 'next' on 2019-05-19 at 9ea1180d6c)
 + userdiff: add Octave

 The pattern "git diff/grep" use to extract funcname and words
 boundary for Matlab has been extend to cover Octave, which is more
 or less equivalent.


* ds/object-info-for-prefetch-fix (2019-05-28) 1 commit
  (merged to 'next' on 2019-05-29 at ee0055b276)
 + sha1-file: split OBJECT_INFO_FOR_PREFETCH

 Code cleanup and futureproof.


* ds/topo-traversal-using-commit-graph (2019-05-28) 2 commits
  (merged to 'next' on 2019-05-30 at 590527995e)
 + revision: keep topo-walk free of unintersting commits
 + revision: use generation for A..B --topo-order queries

 Prepare use of reachability index in topological walker that works
 on a range (A..B).


* es/first-contrib-tutorial (2019-05-29) 3 commits
  (merged to 'next' on 2019-05-30 at 96317960ab)
 + doc: add some nit fixes to MyFirstContribution
  (merged to 'next' on 2019-05-19 at 9ddfae82bf)
 + documentation: add anchors to MyFirstContribution
 + documentation: add tutorial for first contribution

 A new tutorial targetting specifically aspiring git-core
 developers.


* es/git-debugger-doc (2019-05-28) 1 commit
  (merged to 'next' on 2019-05-29 at 449ba4ae6c)
 + doc: hint about GIT_DEBUGGER in CodingGuidelines

 Doc update.


* es/grep-require-name-when-needed (2019-05-28) 1 commit
  (merged to 'next' on 2019-05-29 at e1ec57894a)
 + grep: fail if call could output and name is null

 More parameter validation.


* ew/server-info-remove-crufts (2019-05-28) 1 commit
  (merged to 'next' on 2019-05-29 at 655ba18f30)
 + server-info: do not list unlinked packs

 "git update-server-info" used to leave stale packfiles in its
 output, which has been corrected.


* jk/HEAD-symref-in-xfer-namespaces (2019-05-28) 1 commit
  (merged to 'next' on 2019-05-29 at c2cfe38955)
 + upload-pack: strip namespace from symref data

 The server side support for "git fetch" used to show incorrect
 value for the HEAD symbolic ref when the namespace feature is in
 use, which has been corrected.


* jk/am-i-resolved-fix (2019-05-28) 4 commits
  (merged to 'next' on 2019-05-29 at e711103b1a)
 + am: fix --interactive HEAD tree resolution
 + am: drop tty requirement for --interactive
 + am: read interactive input from stdin
 + am: simplify prompt response handling

 "git am -i --resolved" segfaulted after trying to see a commit as
 if it were a tree, which has been corrected.


* js/bisect-helper-check-get-oid-return-value (2019-05-28) 1 commit
  (merged to 'next' on 2019-05-29 at 24125b3bc0)
 + bisect--helper: verify HEAD could be parsed before continuing

 Code cleanup.


* js/bundle-verify-require-object-store (2019-05-28) 1 commit
  (merged to 'next' on 2019-05-29 at 747fbbaf11)
 + bundle verify: error out if called without an object database

 "git bundle verify" needs to see if prerequisite objects exist in
 the receiving repository, but the command did not check if we are
 in a repository upfront, which has been corrected.


* js/fsmonitor-unflake (2019-05-28) 2 commits
  (merged to 'next' on 2019-05-30 at 1aa850bc59)
 + mark_fsmonitor_valid(): mark the index as changed if needed
 + fill_stat_cache_info(): prepare for an fsmonitor fix

 The data collected by fsmonitor was not properly written back to
 the on-disk index file, breaking t7519 tests occasionally, which
 has been corrected.


* mm/p4-unshelve-windows-fix (2019-05-28) 1 commit
  (merged to 'next' on 2019-05-31 at d45167d723)
 + p4 unshelve: fix "Not a valid object name HEAD0" on Windows

 The command line to invoke a "git cat-file" command from inside
 "git p4" was not properly quoted to protect a caret and running a
 broken command on Windows, which has been corrected.


* pb/request-pull-verify-remote-ref (2019-05-28) 2 commits
  (merged to 'next' on 2019-05-31 at 0f73300dfa)
 + request-pull: warn if the remote object is not the same as the local one
 + request-pull: quote regex metacharacters in local ref

 "git request-pull" learned to warn when the ref we ask them to pull
 from in the local repository and in the published repository are
 different.


* po/git-help-on-git-itself (2019-05-16) 2 commits
  (merged to 'next' on 2019-05-31 at 455541d73a)
 + Doc: git.txt: remove backticks from link and add git-scm.com/docs
 + git.c: show usage for accessing the git(1) help page

 "git help git" was hard to discover (well, at least for some
 people).


* sw/git-p4-unshelve-branched-files (2019-05-28) 1 commit
  (merged to 'next' on 2019-05-30 at e1985f61fc)
 + git-p4: allow unshelving of branched files

 "git p4" update.


* vv/merge-squash-with-explicit-commit (2019-05-28) 1 commit
  (merged to 'next' on 2019-05-29 at 209baa3e55)
 + merge: refuse --commit with --squash

 "git merge --squash" is designed to update the working tree and the
 index without creating the commit, and this cannot be countermanded
 by adding the "--commit" option; the command now refuses to work
 when both options are given.


* xl/record-partial-clone-origin (2019-05-29) 1 commit
  (merged to 'next' on 2019-05-31 at dc291fa199)
 + clone: respect user supplied origin name when setting up partial clone

 When creating a partial clone, the object filtering criteria is
 recorded for the origin of the clone, but this incorrectly used a
 hardcoded name "origin" to name that remote; it has been corrected
 to honor the "--origin <name>" option.

--------------------------------------------------
[New Topics]

* cb/fsmonitor-intfix (2019-06-17) 1 commit
 - fsmonitor: avoid signed integer overflow / infinite loop

 Variable type fix.

 Will merge to 'next' and then to 'master'.


* es/rev-list-no-object-names (2019-06-19) 1 commit
 - rev-list: teach --no-object-names to enable piping

 "git rev-list --objects" learned with "--no-object-names" option to
 squelch the path to the object that is used as a grouping hint for
 pack-objects.

 Will merge to 'next'.


* md/list-objects-filter-combo (2019-06-17) 10 commits
 - list-objects-filter-options: make parser void
 - list-objects-filter-options: clean up use of ALLOC_GROW
 - list-objects-filter-options: allow mult. --filter
 - strbuf: give URL-encoding API a char predicate fn
 - list-objects-filter-options: make filter_spec a string_list
 - list-objects-filter-options: move error check up
 - list-objects-filter: implement composite filters
 - list-objects-filter-options: always supply *errbuf
 - list-objects-filter: put omits set in filter struct
 - list-objects-filter: make API easier to use

 The list-objects-filter API (used to create a sparse/lazy clone)
 learned to take a combined filter specification.


* pw/doc-synopsis-markup-opmode-options (2019-06-17) 1 commit
 - show --continue/skip etc. consistently in synopsis

 Docfix.

 Will merge to 'next' and then to 'master'.


* rs/copy-array (2019-06-17) 2 commits
 - use COPY_ARRAY for copying arrays
 - coccinelle: use COPY_ARRAY for copying arrays

 Code clean-up.

 Will merge to 'next' and then to 'master'.


* cb/mkstemps-uint-type-fix (2019-06-19) 1 commit
 - wrapper: avoid undefined behaviour in macOS

 Variable type fix.

 Will merge to 'next' and then to 'master'.


* cb/xdiff-no-system-includes-in-dot-c (2019-06-19) 1 commit
 - xdiff: avoid accidental redefinition of LFS feature in OpenIndiana

 Compilation fix.

 Will be rerolled together with patches from the
 jk/no-system-includes-in-dot-c topic.


* jk/no-system-includes-in-dot-c (2019-06-19) 2 commits
 - wt-status.h: drop stdio.h include
 - verify-tag: drop signal.h include

 Compilation fix.

 Will be rerolled with the above.


* jk/trailers-use-config (2019-06-19) 1 commit
 - interpret-trailers: load default config

 "git interpret-trailers" always treated '#' as the comment
 character, regardless of core.commentChar setting, which has been
 corrected.

 Will merge to 'next' and then to 'master'.


* nd/fetch-multi-gc-once (2019-06-19) 1 commit
 - fetch: only run 'gc' once when fetching multiple remotes

 "git fetch" that grabs from a group of remotes learned to run the
 auto-gc only once at the very end.

 Will merge to 'next'.


* ra/cherry-pick-revert-skip (2019-06-19) 5 commits
 - cherry-pick/revert: advise using --skip
 - cherry-pick/revert: add --skip option
 - sequencer: use argv_array in reset_merge
 - sequencer: rename reset_for_rollback to reset_merge
 - sequencer: add advice for revert

 "git cherry-pick/revert" learned a new "--skip" action.


* tg/stash-ref-by-index-fix (2019-06-19) 1 commit
 - stash: fix show referencing stash index

 "git stash show 23" used to work, but no more after getting
 rewritten in C; this regression has been corrected.

 Will merge to 'next' and then to 'master'.

--------------------------------------------------
[Stalled]

* jn/unknown-index-extensions (2018-11-21) 2 commits
 - index: offer advice for unknown index extensions
 - index: do not warn about unrecognized extensions

 A bit too alarming warning given when unknown index extensions
 exist is getting revamped.

 Expecting a reroll.


* jc/format-patch-delay-message-id (2019-04-05) 1 commit
 - format-patch: move message-id and related headers to the end

 The location "git format-patch --thread" adds the Message-Id:
 header in the series of header fields has been moved down, which
 may help working around a suspected bug in GMail MSA, reported at
 <CAHk-=whP1stFZNAaJiMi5eZ9rj0MRt20Y_yHVczZPH+O01d+sA@mail.gmail.com>

 Waiting for feedback to see if it truly helps.
 Needs tests.


* jt/fetch-cdn-offload (2019-03-12) 9 commits
 - SQUASH???
 - upload-pack: send part of packfile response as uri
 - fetch-pack: support more than one pack lockfile
 - upload-pack: refactor reading of pack-objects out
 - Documentation: add Packfile URIs design doc
 - Documentation: order protocol v2 sections
 - http-fetch: support fetching packfiles by URL
 - http: improve documentation of http_pack_request
 - http: use --stdin when getting dumb HTTP pack

 WIP for allowing a response to "git fetch" to instruct the bulk of
 the pack contents to be instead taken from elsewhere (aka CDN).

 Stalled


* js/protocol-advertise-multi (2018-12-28) 1 commit
 - protocol: advertise multiple supported versions

 The transport layer has been updated so that the protocol version
 used can be negotiated between the parties, by the initiator
 listing the protocol versions it is willing to talk, and the other
 side choosing from one of them.

 Expecting a reroll.
 cf. <CANq=j3u-zdb_FvNJGPCmygNMScseav63GhVvBX3NcVS4f7TejA@mail.gmail.com>


* mk/use-size-t-in-zlib (2018-10-15) 1 commit
 - zlib.c: use size_t for size

 The wrapper to call into zlib followed our long tradition to use
 "unsigned long" for sizes of regions in memory, which have been
 updated to use "size_t".


* dl/remote-save-to-push (2018-12-11) 1 commit
 - remote: add --save-to-push option to git remote set-url

 "git remote set-url" learned a new option that moves existing value
 of the URL field to pushURL field of the remote before replacing
 the URL field with a new value.

 Anybody who wants to champion this topic?
 I am personally not yet quite convinced if this is worth pursuing.

--------------------------------------------------
[Cooking]

* js/gcc-8-and-9 (2019-06-13) 4 commits
 - config: avoid calling `labs()` on too-large data type
 - winansi: simplify loading the GetCurrentConsoleFontEx() function
 - kwset: allow building with GCC 8
 - poll (mingw): allow compiling with GCC 8 and DEVELOPER=1

 Code clean-up for new compilers.

 The 'kwset' one may get a wholesale replacement, either with new
 version of kwset from upstream or removal of its users, but in the
 meantime, it is probably OK to merge it down.


* pw/add-p-recount (2019-06-13) 1 commit
 - add -p: fix checkout -p with pathological context

 "git checkout -p" needs to selectively apply a patch in reverse,
 which did not work well.

 Will merge to 'next' and then to 'master'.


* rs/avoid-overflow-in-midpoint-computation (2019-06-13) 1 commit
 - cleanup: fix possible overflow errors in binary search, part 2

 Code clean-up to avoid signed integer overlaps during binary search.

 Will merge to 'next' and then to 'master'.


* js/t3404-typofix (2019-06-14) 1 commit
 - t3404: fix a typo

 Typofix.

 Will merge to 'next' and then to 'master'.


* mo/hpux-dynpath (2019-06-07) 1 commit
 - configure: Detect linking style for HP aCC on HP-UX

 Auto-detect how to tell HP-UX aCC where to use dynamicallly linked
 libraries from at runtime.

 Will merge to 'next' and then to 'master'.


* js/mergetool-optim (2019-06-12) 4 commits
 - mergetool: use shell variable magic instead of `awk`
 - mergetool: dissect strings with shell variable magic instead of `expr`
 - t7610-mergetool: use test_cmp instead of test $(cat file) = $txt
 - t7610-mergetool: do not place pipelines headed by `yes` in subshells

 "git mergetool" and its tests now spawn fewer subprocesses.

 Will merge to 'next' and then to 'master'.


* cc/test-oidmap (2019-06-17) 4 commits
 - test-hashmap: remove 'hash' command
 - oidmap: use sha1hash() instead of static hash() function
 - t: add t0016-oidmap.sh
 - t/helper: add test-oidmap.c

 Extend the test coverage a bit.

 Will merge to 'next'.


* ds/midx-expire-repack (2019-06-11) 11 commits
 - t5319-multi-pack-index.sh: test batch size zero
 - midx: add test that 'expire' respects .keep files
 - multi-pack-index: test expire while adding packs
 - midx: implement midx_repack()
 - multi-pack-index: prepare 'repack' subcommand
 - multi-pack-index: implement 'expire' subcommand
 - midx: refactor permutation logic and pack sorting
 - midx: simplify computation of pack name lengths
 - multi-pack-index: prepare for 'expire' subcommand
 - Docs: rearrange subcommands for multi-pack-index
 - repack: refactor pack deletion for future use

 "git multi-pack-index" learned expire and repack subcommands.

 Will merge to 'next'.


* md/sort-detached-head-first (2019-06-19) 1 commit
 - ref-filter: sort detached HEAD lines firstly

 "git branch --list" learned to always output the detached HEAD as
 the first item (when the HEAD is detached, of course), regardless
 of the locale.

 Will merge to 'next'.


* nd/completion-no-cache-failure (2019-06-12) 1 commit
 - completion: do not cache if --git-completion-helper fails

 An incorrect list of options was cached after command line
 completion failed (e.g. trying to complete a command that requires
 a repository outside one), which has been corrected.

 Will merge to 'next' and then to 'master'.


* sg/rebase-progress (2019-06-11) 4 commits
 - progress: use term_clear_line()
 - rebase: fix garbled progress display with '-x'
 - pager: add a helper function to clear the last line in the terminal
 - t3404-rebase-interactive: use the 'q_to_cr' helper

 Use "Erase in Line" CSI sequence that is already used in the editor
 support to clear cruft in the progress output.

 Its test may have to be updated to work around glitch in test setup
 on Windows.


* sg/trace2-rename (2019-06-12) 1 commit
 - Revert "test-lib: whitelist GIT_TR2_* in the environment"

 Dev support update to help tracing out tests.

 Will merge to 'next' and then to 'master'.


* fc/fetch-with-import-fix (2019-06-04) 5 commits
 - fetch: fix regression with transport helpers
 - fetch: make the code more understandable
 - fetch: trivial cleanup
 - t5801 (remote-helpers): add test to fetch tags
 - t5801 (remote-helpers): cleanup refspec stuff

 Code restructuring during 2.20 period broke fetching tags via
 "import" based transports.

 Will merge to 'next' and then to 'master'.


* jl/status-reduce-vertical-blank (2019-06-04) 1 commit
 - status: remove the empty line after hints
 (this branch uses nd/switch-and-restore.)

 Extra blank lines in "git status" output have been reduced.

 Needs to wait on nd/switch-and-restore to stabilize.


* md/url-parse-harden (2019-06-04) 2 commits
  (merged to 'next' on 2019-06-06 at b187c3dbfe)
 + url: do not allow %00 to represent NUL in URLs
 + url: do not read past end of buffer

 The URL decoding code has been updated to avoid going past the end
 of the string while parsing %-<hex>-<hex> sequence.

 Will merge to 'master'.


* mo/clang-format-for-each-update (2019-06-04) 1 commit
  (merged to 'next' on 2019-06-06 at ee3066bb65)
 + clang-format: use git grep to generate the ForEachMacros list

 The list of for-each like macros used by clang-format has been
 updated.

 Will merge to 'master'.


* dl/config-alias-doc (2019-06-06) 2 commits
 - config/alias.txt: document alias accepting non-command first word
 - config/alias.txt: change " and ' to `

 Doc update.

 Will merge to 'next' and then to 'master'.


* dl/includeif-onbranch (2019-06-05) 1 commit
 - config: learn the "onbranch:" includeIf condition

 The conditional inclusion mechanism learned to base the choice on
 the branch the HEAD currently is on.

 Will merge to 'next'.


* ds/commit-graph-incremental (2019-06-19) 18 commits
 - commit-graph: test verify across alternates
 - commit-graph: normalize commit-graph filenames
 - commit-graph: test --split across alternate without --split
 - commit-graph: test octopus merges with --split
 - commit-graph: clean up chains after flattened write
 - commit-graph: verify chains with --shallow mode
 - commit-graph: create options for split files
 - commit-graph: expire commit-graph files
 - commit-graph: allow cross-alternate chains
 - commit-graph: merge commit-graph chains
 - commit-graph: add --split option to builtin
 - commit-graph: write commit-graph chains
 - commit-graph: rearrange chunk count logic
 - commit-graph: add base graphs chunk
 - commit-graph: load commit-graph chains
 - commit-graph: rename commit_compare to oid_compare
 - commit-graph: prepare for commit-graph chains
 - commit-graph: document commit-graph chains
 (this branch uses ds/close-object-store and ds/commit-graph-write-refactor.)

 The commits in a repository can be described by multiple
 commit-graph files now, which allows the commit-graph files to be
 updated incrementally.

 Will merge to 'next'.


* tm/tag-gpgsign-config (2019-06-05) 1 commit
 - tag: add tag.gpgSign config option to force all tags be GPG-signed

 A new tag.gpgSign configuration variable turns "git tag -a" into
 "git tag -s".

 Will merge to 'next' and then to 'master'.


* md/list-objects-filter-memfix (2019-05-31) 1 commit
  (merged to 'next' on 2019-06-06 at 80f0187cef)
 + list-objects-filter: correct usage of ALLOC_GROW

 The filter_data used in the list-objects-filter (which manages a
 lazily sparse clone repository) did not use the dynamic array API
 correctly---'nr' is supposed to point at one past the last element
 of the array in use.  This has been corrected.

 Will merge to 'master'.


* md/list-objects-filter-parse-msgfix (2019-05-31) 1 commit
  (merged to 'next' on 2019-06-06 at 736f3c175b)
 + list-objects-filter-options: error is localizeable

 Make an end-user facing message localizable.

 Will merge to 'master'.


* cm/send-email-document-req-modules (2019-05-31) 1 commit
  (merged to 'next' on 2019-06-06 at acf1c2fc96)
 + send-email: update documentation of required Perl modules

 A doc update.

 Will merge to 'master'.


* po/doc-branch (2019-05-29) 1 commit
 - doc branch: provide examples for listing remote tracking branches

 Doc update.

 Will merge to 'next' and then to 'master'.


* ab/hash-object-doc (2019-05-28) 1 commit
  (merged to 'next' on 2019-06-06 at 8e4d85b906)
 + hash-object doc: stop mentioning git-cvsimport

 Doc update.

 Will merge to 'master'.


* jt/partial-clone-missing-ref-delta-base (2019-06-11) 4 commits
  (merged to 'next' on 2019-06-12 at 95628af9bb)
 + t5616: cover case of client having delta base
 + t5616: use correct flag to check object is missing
  (merged to 'next' on 2019-05-29 at 5d7573a151)
 + index-pack: prefetch missing REF_DELTA bases
 + t5616: refactor packfile replacement

 "git fetch" into a lazy clone forgot to fetch base objects that are
 necessary to complete delta in a thin packfile, which has been
 corrected.

 Will merge to 'master'.


* ds/close-object-store (2019-06-12) 3 commits
 - packfile: rename close_all_packs to close_object_store
 - packfile: close commit-graph in close_all_packs
 - commit-graph: use raw_object_store when closing
 (this branch is used by ds/commit-graph-incremental; uses ds/commit-graph-write-refactor.)

 The commit-graph file is now part of the "files that the runtime
 may keep open file descriptors on, all of which would need to be
 closed when done with the object store", and the file descriptor to
 an existing commit-graph file now is closed before "gc" finalizes a
 new instance to replace it.

 Will merge to 'next' and then to 'master'.


* ml/userdiff-rust (2019-05-30) 2 commits
  (merged to 'next' on 2019-06-12 at 33b88fa9e5)
 + userdiff: two simplifications of patterns for rust
  (merged to 'next' on 2019-05-19 at 1266fddce5)
 + userdiff: add built-in pattern for rust

 The pattern "git diff/grep" use to extract funcname and words
 boundary for Rust has been added.

 Will merge to 'master'.


* an/ignore-doc-update (2019-06-04) 1 commit
  (merged to 'next' on 2019-06-06 at 8579d82c0d)
 + gitignore.txt: make slash-rules more readable

 The description about slashes in gitignore patterns (used to
 indicate things like "anchored to this level only" and "only
 matches directories") has been revamped.

 Will merge to 'master'.


* pw/rebase-abort-clean-rewritten (2019-05-15) 4 commits
 - rebase --abort/--quit: cleanup refs/rewritten
 - sequencer: return errors from sequencer_remove_state()
 - rebase: warn if state directory cannot be removed
 - rebase: fix a memory leak

 "git rebase --abort" used to leave refs/rewritten/ when concluding
 "git rebase -r", which has been corrected.

 Will merge to 'next'.
 cf. <2a37d4c2-6eec-548d-0bd0-12bbd49c8071@gmail.com>


* nb/branch-show-other-worktrees-head (2019-05-07) 3 commits
 - branch: add worktree info on verbose output
 - branch: update output to include worktree info
 - ref-filter: add worktreepath atom

 "git branch --list" learned to show branches that are checked out
 in other worktrees connected to the same repository prefixed with
 '+', similar to the way the currently checked out branch is shown
 with '*' in front.

 Will merge to 'next' and then to 'master'.


* cc/multi-promisor (2019-04-15) 17 commits
 - Move core_partial_clone_filter_default to promisor-remote.c
 - Move repository_format_partial_clone to promisor-remote.c
 - Remove fetch-object.{c,h} in favor of promisor-remote.{c,h}
 - remote: add promisor and partial clone config to the doc
 - partial-clone: add multiple remotes in the doc
 - t0410: test fetching from many promisor remotes
 - builtin/fetch: remove unique promisor remote limitation
 - promisor-remote: parse remote.*.partialclonefilter
 - diff: use promisor-remote.h instead of fetch-object.h
 - Use promisor_remote_get_direct() and has_promisor_remote()
 - promisor-remote: use repository_format_partial_clone
 - promisor-remote: add promisor_remote_reinit()
 - promisor-remote: implement promisor_remote_get_direct()
 - Add initial support for many promisor remotes
 - fetch-object: make functions return an error code
 - t0410: remove pipes after git commands
 - Merge branch 'jt/batch-fetch-blobs-in-diff' into cc/multi-promisor

 Teach the lazy clone machinery that there can be more than one
 promisor remote and consult them in order when downloading missing
 objects on demand.


* nd/switch-and-restore (2019-05-07) 43 commits
 - Declare both git-switch and git-restore experimental
 - help: move git-diff and git-reset to different groups
 - doc: promote "git restore"
 - user-manual.txt: prefer 'merge --abort' over 'reset --hard'
 - completion: support restore
 - t: add tests for restore
 - restore: support --patch
 - restore: replace --force with --ignore-unmerged
 - restore: default to --source=HEAD when only --staged is specified
 - restore: reject invalid combinations with --staged
 - restore: add --worktree and --staged
 - checkout: factor out worktree checkout code
 - restore: disable overlay mode by default
 - restore: make pathspec mandatory
 - restore: take tree-ish from --source option instead
 - checkout: split part of it to new command 'restore'
 - doc: promote "git switch"
 - completion: support switch
 - t: add tests for switch
 - switch: make --orphan switch to an empty tree
 - switch: reject if some operation is in progress
 - switch: no worktree status unless real branch switch happens
 - switch: implicit dwim, use --no-guess to disable it
 - switch: add short option for --detach
 - switch: only allow explicit detached HEAD
 - switch: reject "do nothing" case
 - switch: stop accepting pathspec
 - switch: remove -l
 - switch: add --discard-changes
 - switch: better names for -b and -B
 - checkout: split part of it to new command 'switch'
 - checkout: split options[] array in three pieces
 - checkout: move 'confict_style' and 'dwim_..' to checkout_opts
 - checkout: make "opts" in cmd_checkout() a pointer
 - checkout: factor out some code in parse_branchname_arg()
 - checkout: keep most #include sorted
 - checkout: inform the user when removing branch state
 - checkout: advice how to get out of detached HEAD mode
 - t: rename t2014-switch.sh to t2014-checkout-switch.sh
 - git-checkout.txt: fix monospace typeset
 - doc: document --overwrite-ignore
 - git-checkout.txt: fix one syntax line
 - git-checkout.txt: spell out --no-option
 (this branch is used by jl/status-reduce-vertical-blank.)

 Two new commands "git switch" and "git restore" are introduced to
 split "checking out a branch to work on advancing its history" and
 "checking out paths out of the index and/or a tree-ish to work on
 advancing the current history" out of the single "git checkout"
 command.

 Will merge to 'next'.
 cf. <20190329103919.15642-1-pclouds@gmail.com> (switch v6)
 cf. <20190425094600.15673-1-pclouds@gmail.com> (restore v3)


* jc/format-patch-noclobber (2019-02-22) 1 commit
 - format-patch: --no-clobber refrains from overwriting output files

 "git format-patch" used to overwrite an existing patch/cover-letter
 file.  A new "--no-clobber" option stops it.

 Undecided but inclined to discard.


* am/p4-branches-excludes (2019-04-02) 8 commits
 - git-p4: respect excluded paths when detecting branches
 - git-p4: add failing test for "git-p4: respect excluded paths when detecting branches"
 - git-p4: don't exclude other files with same prefix
 - git-p4: add failing test for "don't exclude other files with same prefix"
 - git-p4: don't groom exclude path list on every commit
 - git-p4: match branches case insensitively if configured
 - git-p4: add failing test for "git-p4: match branches case insensitively if configured"
 - git-p4: detect/prevent infinite loop in gitCommitByP4Change()

 "git p4" update.

 Is this ready for 'next'?


* dl/rebase-i-keep-base (2019-04-25) 6 commits
 - rebase: teach rebase --keep-base
 - rebase: fast-forward --fork-point in more cases
 - rebase: fast-forward --onto in more cases
 - rebase: refactor can_fast_forward into goto tower
 - t3432: test rebase fast-forward behavior
 - t3431: add rebase --fork-point tests

 "git rebase --keep-base <upstream>" tries to find the original base
 of the topic being rebased and rebase on top of that same base,
 which is useful when running the "git rebase -i" (and its limited
 variant "git rebase -x").

 The command also has learned to fast-forward in more cases where it
 can instead of replaying to recreate identical commits.

 On hold.
 cf. <20190508001252.15752-1-avarab@gmail.com>
 cf. <xmqqa7fxionx.fsf@gitster-ct.c.googlers.com>


* ds/commit-graph-write-refactor (2019-06-12) 11 commits
 - commit-graph: extract write_commit_graph_file()
 - commit-graph: extract copy_oids_to_commits()
 - commit-graph: extract count_distinct_commits()
 - commit-graph: extract fill_oids_from_all_packs()
 - commit-graph: extract fill_oids_from_commit_hex()
 - commit-graph: extract fill_oids_from_packs()
 - commit-graph: create write_commit_graph_context
 - commit-graph: remove Future Work section
 - commit-graph: collapse parameters into flags
 - commit-graph: return with errors during write
 - commit-graph: fix the_repository reference
 (this branch is used by ds/close-object-store and ds/commit-graph-incremental.)

 Renamed from commit-graph-format-v2 and changed scope.

 Will merge to 'next' and then to 'master'.


* br/blame-ignore (2019-06-10) 9 commits
 - blame: add a test to cover blame_coalesce()
 - blame: use the fingerprint heuristic to match ignored lines
 - blame: add a fingerprint heuristic to match ignored lines
 - blame: optionally track line fingerprints during fill_blame_origin()
 - blame: add config options for the output of ignored or unblamable lines
 - blame: add the ability to ignore commits and their changes
 - blame: use a helper function in blame_chunk()
 - Move oidset_parse_file() to oidset.c
 - fsck: rename and touch up init_skiplist()

 "git blame" learned to "ignore" commits in the history, whose
 effects (as well as their presence) get ignored.

 Except for a minor nit in its tests, this seems to be more or less
 ready for 'next'.
 cf. <20190610153014.42055-1-brho@google.com> (v8)

--------------------------------------------------
[Discarded]

* js/add-i-coalesce-after-editing-hunk (2018-08-28) 1 commit
 . add -p: coalesce hunks before testing applicability

 Applicability check after a patch is edited in a "git add -i/p"
 session has been improved.
