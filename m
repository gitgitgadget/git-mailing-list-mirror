Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A060F1FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 23:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753629AbcLFXwG (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 18:52:06 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64353 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751590AbcLFXvt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 18:51:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B85A155067;
        Tue,  6 Dec 2016 18:46:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=q
        PYt0cBAuKoY8OzryfkZufw7S64=; b=we503SarYGuCi1r3amMxpk1vhUmGRNqQa
        /nNcO4OrhTBvw6Jz4+yYNvKJ+YPnOftOra88rlxdhF0wKSk2A+PR8LGwdohaaTBy
        oWSbIlmSplMQGhWqPSKX6b4oYvUx/DF9xDartRCoRVs87HBIzdM0VUeNTBpbRXSf
        sJ1AHbigfA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=t9k
        mr/aWWB3HYlnTjpgsH6fMzqrsOFvTXu9GHvi3niYVtAVz+h02i/G8OXVZNfZvLsG
        KNuj1stI8aJOa4J8gu/q/lcws4pQZb/Mvep+HC+4kW7RGYmeRwj8TC1OrTKjGoLf
        X/R+sVKbuZjbREcMYcKldpzO8lhlcMxinTT/BxfU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AC9205505E;
        Tue,  6 Dec 2016 18:46:35 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CF3DF5505D;
        Tue,  6 Dec 2016 18:46:34 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Dec 2016, #01; Tue, 6)
X-master-at: 8d7a455ed52e2a96debc080dfc011b6bb00db5d2
X-next-at: fb549caa12ec67f9448f8f6b29b102ee5ec54c82
Date:   Tue, 06 Dec 2016 15:46:33 -0800
Message-ID: <xmqqpol4y61y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 38B9FF2E-BC0E-11E6-9D3C-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

The 'next' branch has been rewound, 'maint' now is for maintenance
fixes post v2.11 release.

The description of many new topics in this issue of the report is
probably sketchier than it should be.  Refinements are very much
appreciated.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* jk/common-main (2016-11-29) 1 commit
  (merged to 'next' on 2016-11-29 at 2985e7efba)
 + common-main: stop munging argv[0] path

 Fix for a small regression in a topic already in 'master'.

--------------------------------------------------
[New Topics]

* ak/lazy-prereq-mktemp (2016-11-29) 1 commit
 - t7610: clean up foo.XXXXXX tmpdir

 Test code clean-up.

 Will merge to 'next'.


* da/mergetool-trust-exit-code (2016-11-29) 2 commits
 - mergetools/vimdiff: trust Vim's exit code
 - mergetool: honor mergetool.$tool.trustExitCode for built-in tools

 mergetool.<tool>.trustExitCode configuration variable did not apply
 to built-in tools, but now it does.

 Will merge to 'next'.


* jb/diff-no-index-no-abbrev (2016-11-29) 1 commit
 - diff: handle --no-abbrev outside of repository

 "git diff --no-index" did not take "--no-abbrev" option.

 Will merge to 'next'.


* vk/p4-submit-shelve (2016-11-29) 1 commit
 - git-p4: allow submit to create shelved changelists.
 (this branch is used by ld/p4-update-shelve.)

 Will merge to 'next'.


* jk/http-walker-limit-redirect-2.9 (2016-12-06) 5 commits
 - http: treat http-alternates like redirects
 - http: make redirects more obvious
 - remote-curl: rename shadowed options variable
 - http: always update the base URL for redirects
 - http: simplify update_url_from_redirect
 (this branch is used by jk/http-walker-limit-redirect.)

 Transport with dumb http can be fooled into following foreign URLs
 that the end user does not intend to, especially with the server
 side redirects and http-alternates mechanism, which can lead to
 security issues.  Tighten the redirection and make it more obvious
 to the end user when it happens.

 Will merge to 'next'.


* jk/http-walker-limit-redirect (2016-12-06) 2 commits
 - http-walker: complain about non-404 loose object errors
 - Merge branch 'ew/http-walker' into jk/http-walker-limit-redirect
 (this branch uses jk/http-walker-limit-redirect-2.9.)

 Update the error messages from the dumb-http client when it fails
 to obtain loose objects; we used to give sensible error message
 only upon 404 but we now forbid unexpected redirects that needs to
 be reported with something sensible.

 Will merge to 'next'.


* ah/grammos (2016-12-05) 3 commits
 - clone,fetch: explain the shallow-clone option a little more clearly
 - receive-pack: improve English grammar of denyCurrentBranch message
 - bisect: improve English grammar of not-ancestors message

 A few messages have been fixed for their grammatical errors.

 Will merge to 'next'.


* ak/commit-only-allow-empty (2016-12-05) 1 commit
 - commit: make --only --allow-empty work without paths

 "git commit --allow-empty --only" (no pathspec) with dirty index
 ought to be an acceptable way to create a new commit that does not
 change any paths, but it was forbidden (perhaps because nobody
 needed it).

 Will merge to 'next'.


* bb/unicode-9.0 (2016-12-05) 3 commits
 - unicode_width.h: update the tables to Unicode 9.0
 - update_unicode.sh: strip the plane offsets from the double_width[] table
 - update_unicode.sh: automatically download newer definition files

 The character width table has been updated to match Unicode 9.0

 Will merge to 'next'.


* ld/p4-update-shelve (2016-12-05) 1 commit
 - git-p4: support updating an existing shelved changelist
 (this branch uses vk/p4-submit-shelve.)

 Will merge to 'next'.


* ld/p4-worktree (2016-12-05) 1 commit
 - git-p4: support secondary working trees managed by "git worktree"

 Iffy.
 cf. <20161202224319.5385-2-luke@diamand.org>


* ls/p4-empty-file-on-lfs (2016-12-05) 1 commit
 - git-p4: fix empty file processing for large file system backend GitLFS

 "git p4" LFS support was broken when LFS stores an empty blob.

 Will merge to 'next'.


* ls/p4-retry-thrice (2016-12-05) 1 commit
 - git-p4: add config to retry p4 commands; retry 3 times by default

 Will merge to 'next'.


* ls/t0021-fixup (2016-12-05) 1 commit
 - t0021: minor filter process test cleanup

 Will merge to 'next'.


* ls/travis-update-p4-and-lfs (2016-12-05) 1 commit
 - travis-ci: update P4 to 16.2 and GitLFS to 1.5.2 in Linux build

 The default Travis-CI configuration specifies newer P4 and GitLFS.

 Will merge to 'next'.


* sb/t3600-cleanup (2016-12-05) 1 commit
 - t3600: remove useless redirect

 Code cleanup.

 Will merge to 'next'.


* sb/unpack-trees-grammofix (2016-12-05) 1 commit
 - unpack-trees: fix grammar for untracked files in directories

 Will merge to 'next'.


* da/difftool-dir-diff-fix (2016-12-06) 1 commit
 - difftool: fix dir-diff index creation when in a subdirectory

 "git difftool --dir-diff" had a minor regression when started from
 a subdirectory, which has been fixed.

 Will merge to 'next'.


* jc/lockfile-silent-on-error (2016-12-06) 1 commit
 - lockfile: LOCK_SILENT_ON_ERROR

 Recent change to use "hold_lock*()" without die-on-error in the
 merge machinery made an error from "git merge" harder to spot.
 Introduce an opt-in "be silent because it has been verified that
 this particular caller produces a sensible error message itself"
 flag, and make everybody else show the error message when it
 returns to the caller with -1 without dying.


* jk/stash-disable-renames-internally (2016-12-06) 1 commit
 - stash: prefer plumbing over git-diff

 When diff.renames configuration is on (and with Git 2.9 and later,
 it is enabled by default, which made it worse), "git stash"
 misbehaved if a file is removed and another file with a very
 similar content is added.

 Will merge to 'next'.


* jk/xdiff-drop-xdl-fast-hash (2016-12-06) 1 commit
 - xdiff: drop XDL_FAST_HASH

 Retire the "fast hash" that had disastrous performance issues in
 some corner cases.

 Will cook in 'next'.


* ls/filter-process (2016-12-06) 1 commit
 - docs: warn about possible '=' in clean/smudge filter process values

 Doc update.

 Will merge to 'next'.


* nd/for-each-ref-ignore-case (2016-12-05) 1 commit
 - tag, branch, for-each-ref: add --ignore-case for sorting and filtering

 "git branch --list" and friends learned "--ignore-case" option to
 optionally sort branches and tags case insensitively.

 Will merge to 'next'.


* rj/git-version-gen-do-not-force-abbrev (2016-12-06) 1 commit
 - GIT-VERSION-GEN: do not force abbreviation length used by 'describe'

 A minor build update.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* jc/retire-compaction-heuristics (2016-11-02) 3 commits
 - SQUASH???
 - SQUASH???
 - diff: retire the original experimental "compaction" heuristics

 Waiting for a reroll.


* jc/abbrev-autoscale-config (2016-11-01) 1 commit
 - config.abbrev: document the new default that auto-scales

 Waiting for a reroll.


* jk/nofollow-attr-ignore (2016-11-02) 5 commits
 - exclude: do not respect symlinks for in-tree .gitignore
 - attr: do not respect symlinks for in-tree .gitattributes
 - exclude: convert "check_index" into a flags field
 - attr: convert "macro_ok" into a flags field
 - add open_nofollow() helper

 As we do not follow symbolic links when reading control files like
 .gitignore and .gitattributes from the index, match the behaviour
 and not follow symbolic links when reading them from the working
 tree.  This also tightens security a bit by not leaking contents of
 an unrelated file in the error messages when it is pointed at by
 one of these files that is a symbolic link.

 Perhaps we want to cover .gitmodules too with the same mechanism?


* nd/worktree-move (2016-11-28) 11 commits
 . worktree remove: new command
 . worktree move: refuse to move worktrees with submodules
 . worktree move: accept destination as directory
 . worktree move: new command
 . worktree.c: add update_worktree_location()
 . worktree.c: add validate_worktree()
 . copy.c: convert copy_file() to copy_dir_recursively()
 . copy.c: style fix
 . copy.c: convert bb_(p)error_msg to error(_errno)
 . copy.c: delete unused code in copy_file()
 . copy.c: import copy_file() from busybox
 (this branch uses nd/worktree-list-fixup; is tangled with sb/submodule-embed-gitdir.)

 "git worktree" learned move and remove subcommands.

 Reported to break builds on Windows.


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

* jc/renormalize-merge-kill-safer-crlf (2016-12-01) 4 commits
 - convert: git cherry-pick -Xrenormalize did not work
 - Merge branch 'tb/t0027-raciness-fix' into jc/renormalize-merge-kill-safer-crlf
 - merge-recursive: handle NULL in add_cacheinfo() correctly
 - cherry-pick: demonstrate a segmentation fault

 Fix a corner case in merge-recursive regression that crept in
 during 2.10 development cycle.

 Will merge to 'next'.


* js/difftool-builtin (2016-11-28) 2 commits
 - difftool: implement the functionality in the builtin
 - difftool: add a skeleton for the upcoming builtin

 Rewrite a scripted porcelain "git difftool" in C.

 Under discussion.


* nd/qsort-in-merge-recursive (2016-11-28) 1 commit
 - merge-recursive.c: use string_list_sort instead of qsort

 Code simplification.

 Will merge to 'next'.


* bw/push-dry-run (2016-11-23) 2 commits
 - push: fix --dry-run to not push submodules
 - push: --dry-run updates submodules when --recurse-submodules=on-demand
 (this branch uses hv/submodule-not-yet-pushed-fix; is tangled with sb/push-make-submodule-check-the-default.)

 "git push --dry-run --recurse-submodule=on-demand" wasn't
 "--dry-run" in the submodules.

 Will merge to 'next'.


* sb/push-make-submodule-check-the-default (2016-11-29) 2 commits
 - push: change submodule default to check when submodules exist
 - submodule add: extend force flag to add existing repos
 (this branch uses hv/submodule-not-yet-pushed-fix; is tangled with bw/push-dry-run.)

 Turn the default of "push.recurseSubmodules" to "check" when
 submodules seem to be in use.

 Will merge to 'next'.


* jk/rev-parse-symbolic-parents-fix (2016-11-16) 1 commit
 - rev-parse: fix parent shorthands with --symbolic

 "git rev-parse --symbolic" failed with a more recent notation like
 "HEAD^-1" and "HEAD^!".

 Will merge to 'next'.


* nd/worktree-list-fixup (2016-11-28) 5 commits
 - worktree list: keep the list sorted
 - worktree.c: get_worktrees() takes a new flag argument
 - get_worktrees() must return main worktree as first item even on error
 - worktree: reorder an if statement
 - worktree.c: zero new 'struct worktree' on allocation
 (this branch is used by nd/worktree-move and sb/submodule-embed-gitdir.)

 The output from "git worktree list" was made in readdir() order,
 and was unstable.

 Will merge to 'next'.


* jk/trailers-placeholder-in-pretty (2016-11-21) 2 commits
 - ref-filter: add support to display trailers as part of contents
 - pretty: add %(trailers) format for displaying trailers of a commit message

 In addition to %(subject), %(body), "log --pretty=format:..."
 learned a new placeholder %(trailers).

 Will merge to 'next'.


* sb/submodule-embed-gitdir (2016-12-05) 5 commits
 - submodule: add embed-git-dir function
 - worktree: get worktrees from submodules
 - test-lib-functions.sh: teach test_commit -C <dir>
 - submodule helper: support super prefix
 - submodule: use absolute path for computing relative path connecting
 (this branch uses nd/worktree-list-fixup; is tangled with nd/worktree-move.)

 A new submodule helper "git submodule embedgitdirs" to make it
 easier to move embedded .git/ directory for submodules in a
 superproject to .git/modules/ (and point the latter with the former
 that is turned into a "gitdir:" file) has been added.

 Waiting for review.


* dt/empty-submodule-in-merge (2016-11-17) 1 commit
 - submodules: allow empty working-tree dirs in merge/cherry-pick

 An empty directory in a working tree that can simply be nuked used
 to interfere while merging or cherry-picking a change to create a
 submodule directory there, which has been fixed..

 Will merge to 'next'.


* bw/grep-recurse-submodules (2016-11-22) 6 commits
 - grep: search history of moved submodules
 - grep: enable recurse-submodules to work on <tree> objects
 - grep: optionally recurse into submodules
 - grep: add submodules as a grep source type
 - submodules: load gitmodules file from commit sha1
 - submodules: add helper functions to determine presence of submodules

 "git grep" learns to optionally recurse into submodules

 Has anybody else seen t7814 being flakey with this series?


* dt/smart-http-detect-server-going-away (2016-11-18) 2 commits
  (merged to 'next' on 2016-12-05 at 3ea70d01af)
 + upload-pack: optionally allow fetching any sha1
 + remote-curl: don't hang when a server dies before any output

 Originally merged to 'next' on 2016-11-21

 When the http server gives an incomplete response to a smart-http
 rpc call, it could lead to client waiting for a full response that
 will never come.  Teach the client side to notice this condition
 and abort the transfer.

 An improvement counterproposal has failed.
 cf. <20161114194049.mktpsvgdhex2f4zv@sigill.intra.peff.net>

 Will cook in 'next'.


* mm/push-social-engineering-attack-doc (2016-11-14) 1 commit
  (merged to 'next' on 2016-12-05 at 9a2b5bd1a9)
 + doc: mention transfer data leaks in more places

 Originally merged to 'next' on 2016-11-16

 Doc update on fetching and pushing.

 Will cook in 'next'.


* jc/compression-config (2016-11-15) 1 commit
  (merged to 'next' on 2016-12-05 at 323769ca07)
 + compression: unify pack.compression configuration parsing

 Originally merged to 'next' on 2016-11-23

 Compression setting for producing packfiles were spread across
 three codepaths, one of which did not honor any configuration.
 Unify these so that all of them honor core.compression and
 pack.compression variables the same way.

 Will cook in 'next'.


* mm/gc-safety-doc (2016-11-16) 1 commit
  (merged to 'next' on 2016-12-05 at 031ecc1886)
 + git-gc.txt: expand discussion of races with other processes

 Originally merged to 'next' on 2016-11-17

 Doc update.

 Will cook in 'next'.


* hv/submodule-not-yet-pushed-fix (2016-11-16) 4 commits
  (merged to 'next' on 2016-12-05 at c9d729fca2)
 + submodule_needs_pushing(): explain the behaviour when we cannot answer
 + batch check whether submodule needs pushing into one call
 + serialize collection of refs that contain submodule changes
 + serialize collection of changed submodules
 (this branch is used by bw/push-dry-run and sb/push-make-submodule-check-the-default.)

 Originally merged to 'next' on 2016-11-21

 The code in "git push" to compute if any commit being pushed in the
 superproject binds a commit in a submodule that hasn't been pushed
 out was overly inefficient, making it unusable even for a small
 project that does not have any submodule but have a reasonable
 number of refs.

 Will cook in 'next'.


* kn/ref-filter-branch-list (2016-11-15) 18 commits
 - for-each-ref: do not segv with %(HEAD) on an unborn branch
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

 Rerolled, reviewed, looking good.
 Expecting a reroll.
 cf. <20161108201211.25213-1-Karthik.188@gmail.com>
 cf. <CAOLa=ZQqe3vEj_428d41vd_4kfjzsm87Wam6Zm2dhXWkPdJ8Rw@mail.gmail.com>
 cf. <xmqq7f84tqa7.fsf_-_@gitster.mtv.corp.google.com>


* bw/transport-protocol-policy (2016-12-05) 5 commits
 - transport: add from_user parameter to is_transport_allowed
 - http: create function to get curl allowed protocols
 - http: always warn if libcurl version is too old
 - transport: add protocol policy config option
 - lib-proto-disable: variable name fix

 Finer-grained control of what protocols are allowed for transports
 during clone/fetch/push have been enabled via a new configuration
 mechanism.


* jt/fetch-no-redundant-tag-fetch-map (2016-11-11) 1 commit
  (merged to 'next' on 2016-12-05 at 432f9469a7)
 + fetch: do not redundantly calculate tag refmap

 Originally merged to 'next' on 2016-11-16

 Code cleanup to avoid using redundant refspecs while fetching with
 the --tags option.

 Will cook in 'next'.


* sb/submodule-config-cleanup (2016-11-22) 3 commits
  (merged to 'next' on 2016-12-05 at 658b8764bf)
 + submodule-config: clarify parsing of null_sha1 element
 + submodule-config: rename commit_sha1 to treeish_name
 + submodule config: inline config_from_{name, path}

 Originally merged to 'next' on 2016-11-23

 Minor code clean-up.

 Will cook in 'next'.


* jc/push-default-explicit (2016-10-31) 2 commits
  (merged to 'next' on 2016-12-05 at d63f3777af)
 + push: test pushing ambiguously named branches
 + push: do not use potentially ambiguous default refspec

 Originally merged to 'next' on 2016-11-01

 A lazy "git push" without refspec did not internally use a fully
 specified refspec to perform 'current', 'simple', or 'upstream'
 push, causing unnecessary "ambiguous ref" errors.

 Will cook in 'next'.


* jt/use-trailer-api-in-commands (2016-11-29) 5 commits
 - sequencer: use trailer's trailer layout
 - trailer: have function to describe trailer layout
 - trailer: avoid unnecessary splitting on lines
 - commit: make ignore_non_trailer take buf/len
 - trailer: be stricter in parsing separators

 Commands that operate on a log message and add lines to the trailer
 blocks, such as "format-patch -s", "cherry-pick (-x|-s)", and
 "commit -s", have been taught to use the logic of and share the
 code with "git interpret-trailer".

 Will merge to 'next'.


* nd/rebase-forget (2016-11-28) 1 commit
 - rebase: add --forget to cleanup rebase, leave everything else untouched

 "git rebase" learned "--forget" option, which allows a user to
 remove the metadata left by an earlier "git rebase" that was
 manually aborted without using "git rebase --abort".

 Will merge to 'next'.


* jc/git-open-cloexec (2016-11-02) 3 commits
 - sha1_file: stop opening files with O_NOATIME
 - git_open_cloexec(): use fcntl(2) w/ FD_CLOEXEC fallback
 - git_open(): untangle possible NOATIME and CLOEXEC interactions

 The codeflow of setting NOATIME and CLOEXEC on file descriptors Git
 opens has been simplified.

 We may want to drop the tip one.


* jk/no-looking-at-dotgit-outside-repo-final (2016-10-26) 1 commit
  (merged to 'next' on 2016-12-05 at 0c77e39cd5)
 + setup_git_env: avoid blind fall-back to ".git"

 Originally merged to 'next' on 2016-10-26

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

 Will discard.
 This may not be needed, given that update-index has a similar
 option.


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

 Will discard.
 The whole premise feels wrong.


* tb/convert-stream-check (2016-10-27) 2 commits
 - convert.c: stream and fast search for binary
 - read-cache: factor out get_sha1_from_index() helper

 End-of-line conversion sometimes needs to see if the current blob
 in the index has NULs and CRs to base its decision.  We used to
 always get a full statistics over the blob, but in many cases we
 can return early when we have seen "enough" (e.g. if we see a
 single NUL, the blob will be handled as binary).  The codepaths
 have been optimized by using streaming interface.

 Will discard.
 Retracted.
 cf. <20161102071646.GA5094@tb-raspi>


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


* sb/attr (2016-11-11) 35 commits
 - completion: clone can initialize specific submodules
 - clone: add --init-submodule=<pathspec> switch
 - submodule update: add `--init-default-path` switch
 - pathspec: allow escaped query values
 - pathspec: allow querying for attributes
 - pathspec: move prefix check out of the inner loop
 - pathspec: move long magic parsing out of prefix_pathspec
 - Documentation: fix a typo
 - attr: keep attr stack for each check
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


* va/i18n-perl-scripts (2016-11-11) 16 commits
 - i18n: difftool: mark warnings for translation
 - i18n: send-email: mark composing message for translation
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
 - Git.pm: add subroutines for commenting lines

 Porcelain scripts written in Perl are getting internationalized.

 Waiting for review.


* jc/latin-1 (2016-09-26) 2 commits
  (merged to 'next' on 2016-12-05 at fb549caa12)
 + utf8: accept "latin-1" as ISO-8859-1
 + utf8: refactor code to decide fallback encoding

 Originally merged to 'next' on 2016-09-28

 Some platforms no longer understand "latin-1" that is still seen in
 the wild in e-mail headers; replace them with "iso-8859-1" that is
 more widely known when conversion fails from/to it.

 Will cook in 'next'.


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


* jc/pull-rebase-ff (2016-11-29) 1 commit
 - pull: fast-forward "pull --rebase=true"

 "git pull --rebase", when there is no new commits on our side since
 we forked from the upstream, should be able to fast-forward without
 invoking "git rebase", but it didn't.


* jc/merge-drop-old-syntax (2015-04-29) 1 commit
  (merged to 'next' on 2016-12-05 at 041946dae0)
 + merge: drop 'git merge <message> HEAD <commit>' syntax

 Originally merged to 'next' on 2016-10-11

 Stop supporting "git merge <message> HEAD <commit>" syntax that has
 been deprecated since October 2007, and issues a deprecation
 warning message since v2.5.0.

 Will cook in 'next'.
