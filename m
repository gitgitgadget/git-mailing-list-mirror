Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A16312022A
	for <e@80x24.org>; Wed, 26 Oct 2016 22:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935692AbcJZWa7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 18:30:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50179 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S941073AbcJZW32 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2016 18:29:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B599D4987B;
        Wed, 26 Oct 2016 18:29:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=A
        iYCBipDK1jKk11BkotzkYZfJoU=; b=T+mPp63dT1HrVHL1ofKbM6j9+fimccCrq
        B8UOnD3XkH1ArQS30kT0ZR1+7xQ2aDXpJMKJXuKe/KQXk0sP+dxDlQiMYm7pkrVp
        fLUlpRFCJ4jspQSIEOyBYaczyJ8tIMWafNXBeHR0YifZeD4DTLOiBYwDRLTsbH/J
        yKaH0Tg6D8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=BRd
        ShFiXlW/zurXcR2mxU8QAAVxhhxqoZBL1xAP25RdmNbSCHxV/qTpF3yw94njLQHg
        N19WmAV3PS3PezPWlMRuuIfVIUHlUNAK+Wyjhd7EDB5Sz9+j1F8wZEf2yRfX6Cjp
        B3o+n2AvvSGWwS6OhU5wU2Vf/M6I6wIAFPOoMFGw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AC47749879;
        Wed, 26 Oct 2016 18:29:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DC96C49878;
        Wed, 26 Oct 2016 18:29:24 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Oct 2016, #07; Wed, 26)
X-master-at: 2cc2e70264e0fcba04f9ef791d144bbc8b501206
X-next-at: d2da68a14ada34b7842a51c88751ffe4aaf8a1af
Date:   Wed, 26 Oct 2016 15:29:22 -0700
Message-ID: <xmqq4m3ybv7h.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A620B3AE-9BCB-11E6-91B6-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
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

* ab/gitweb-abbrev-links (2016-10-14) 3 commits
  (merged to 'next' on 2016-10-17 at 4868def05e)
 + gitweb: link to "git describe"'d commits in log messages
 + gitweb: link to 7-char+ SHA-1s, not only 8-char+
 + gitweb: fix a typo in a comment

 In addition to purely abbreviated commit object names, "gitweb"
 learned to turn "git describe" output (e.g. v2.9.3-599-g2376d31787)
 into clickable links in its output.


* bw/ls-files-recurse-submodules (2016-10-10) 4 commits
  (merged to 'next' on 2016-10-17 at f0e398946a)
 + ls-files: add pathspec matching for submodules
 + ls-files: pass through safe options for --recurse-submodules
 + ls-files: optionally recurse into submodules
 + git: make super-prefix option

 "git ls-files" learned "--recurse-submodules" option that can be
 used to get a listing of tracked files across submodules (i.e. this
 only works with "--cached" option, not for listing untracked or
 ignored files).  This would be a useful tool to sit on the upstream
 side of a pipe that is read with xargs to work on all working tree
 files from the top-level superproject.


* bw/submodule-branch-dot-doc (2016-10-19) 1 commit
  (merged to 'next' on 2016-10-21 at 18aad25ba8)
 + submodules doc: update documentation for "." used for submodule branches

 Recent git allows submodule.<name>.branch to use a special token
 "." instead of the branch name; the documentation has been updated
 to describe it.


* dk/worktree-dup-checkout-with-bare-is-ok (2016-10-14) 1 commit
  (merged to 'next' on 2016-10-17 at 24594d3e56)
 + worktree: allow the main brach of a bare repository to be checked out

 In a worktree connected to a repository elsewhere, created via "git
 worktree", "git checkout" attempts to protect users from confusion
 by refusing to check out a branch that is already checked out in
 another worktree.  However, this also prevented checking out a
 branch, which is designated as the primary branch of a bare
 reopsitory, in a worktree that is connected to the bare
 repository.  The check has been corrected to allow it.


* ex/deprecate-empty-pathspec-as-match-all (2016-06-22) 1 commit
  (merged to 'next' on 2016-09-21 at e19148ea63)
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


* jc/cocci-xstrdup-or-null (2016-10-12) 1 commit
  (merged to 'next' on 2016-10-17 at 55ceaa465a)
 + cocci: refactor common patterns to use xstrdup_or_null()

 Code cleanup.


* jc/diff-unique-abbrev-comments (2016-09-30) 1 commit
  (merged to 'next' on 2016-10-17 at c7fb286102)
 + diff_unique_abbrev(): document its assumption and limitation
 (this branch is used by jk/no-looking-at-dotgit-outside-repo.)

 A bit more comments in a tricky code.


* jc/ws-error-highlight (2016-10-04) 4 commits
  (merged to 'next' on 2016-10-17 at ecbdc57d77)
 + diff: introduce diff.wsErrorHighlight option
 + diff.c: move ws-error-highlight parsing helpers up
 + diff.c: refactor parse_ws_error_highlight()
 + t4015: split out the "setup" part of ws-error-highlight test

 "git diff/log --ws-error-highlight=<kind>" lacked the corresponding
 configuration variable to set it by default.


* jk/ambiguous-short-object-names (2016-10-12) 1 commit
  (merged to 'next' on 2016-10-19 at e7c55a9da5)
 + t1512: become resilient to GETTEXT_POISON build

 A test fixup to recently graduated topic.


* jk/diff-submodule-diff-inline (2016-10-20) 1 commit
  (merged to 'next' on 2016-10-21 at 13f300805e)
 + rev-list: use hdr_termination instead of a always using a newline

 A recently graduated topic regressed "git rev-list --header"
 output, breaking "gitweb".  This has been fixed.


* jk/fetch-quick-tag-following (2016-10-14) 1 commit
  (merged to 'next' on 2016-10-19 at d7718dcdf5)
 + fetch: use "quick" has_sha1_file for tag following

 When fetching from a remote that has many tags that are irrelevant
 to branches we are following, we used to waste way too many cycles
 when checking if the object pointed at by a tag (that we are not
 going to fetch!) exists in our repository too carefully.


* jk/merge-base-fork-point-without-reflog (2016-10-12) 1 commit
  (merged to 'next' on 2016-10-19 at 00a6797f62)
 + merge-base: handle --fork-point without reflog

 "git rebase" immediately after "git clone" failed to find the fork
 point from the upstream.


* jk/tap-verbose-fix (2016-10-24) 4 commits
  (merged to 'next' on 2016-10-24 at 5073a4de2d)
 + test-lib: bail out when "-v" used under "prove"
  (merged to 'next' on 2016-10-21 at 592679411c)
 + travis: use --verbose-log test option
 + test-lib: add --verbose-log option
 + test-lib: handle TEST_OUTPUT_DIRECTORY with spaces

 The Travis CI configuration we ship ran the tests with --verbose
 option but this risks non-TAP output that happens to be "ok" to be
 misinterpreted as TAP signalling a test that passed.  This resulted
 in unnecessary failure.  This has been corrected by introducing a
 new mode to run our tests in the test harness to send the verbose
 output separately to the log file.


* jk/tighten-alloc (2016-10-17) 2 commits
  (merged to 'next' on 2016-10-19 at 548522a520)
 + inline xalloc_flex() into FLEXPTR_ALLOC_MEM
 + avoid pointer arithmetic involving NULL in FLEX_ALLOC_MEM

 Protect our code from over-eager compilers.


* jk/upload-pack-use-prio-queue (2016-10-11) 1 commit
  (merged to 'next' on 2016-10-19 at 1d6efb07ac)
 + upload-pack: use priority queue in reachable() check

 "git upload-pack" had its code cleaned-up and performance improved
 by reducing use of timestamp-ordered commit-list, which was
 replaced with a priority queue.


* js/libify-require-clean-work-tree (2016-10-07) 6 commits
  (merged to 'next' on 2016-10-17 at f5c20df38b)
 + wt-status: begin error messages with lower-case
 + wt-status: teach has_{unstaged,uncommitted}_changes() about submodules
 + wt-status: export also the has_un{staged,committed}_changes() functions
 + wt-status: make the require_clean_work_tree() function reusable
 + pull: make code more similar to the shell script again
 + pull: drop confusing prefix parameter of die_on_unclean_work_tree()

 The require_clean_work_tree() helper was recreated in C when "git
 pull" was rewritten from shell; the helper is now made available to
 other callers in preparation for upcoming "rebase -i" work.


* mg/gpg-richer-status (2016-10-12) 1 commit
  (merged to 'next' on 2016-10-17 at 8843a6a8be)
 + gpg-interface: use more status letters

 The GPG verification status shown in "%G?" pretty format specifier
 was not rich enough to differentiate a signature made by an expired
 key, a signature made by a revoked key, etc.  New output letters
 have been assigned to express them.


* mm/credential-libsecret (2016-10-11) 1 commit
  (merged to 'next' on 2016-10-17 at 1b4af03ba4)
 + contrib: add credential helper for libsecret

 A new credential helper that talks via "libsecret" with
 implementations of XDG Secret Service API has been added to
 contrib/credential/.


* mm/send-email-cc-cruft-after-address (2016-10-21) 3 commits
  (merged to 'next' on 2016-10-21 at c7ec2b5025)
 + Git.pm: add comment pointing to t9000
 + t9000-addresses: update expected results after fix
  (merged to 'next' on 2016-10-19 at 41e3f876cd)
 + parse_mailboxes: accept extra text after <...> address

 "git send-email" attempts to pick up valid e-mails from the
 trailers, but people in real world write non-addresses there, like
 "Cc: Stable <add@re.ss> # 4.8+", which broke the output depending
 on the availability and vintage of Mail::Address perl module.


* pb/test-parse-options-expect (2016-10-17) 1 commit
  (merged to 'next' on 2016-10-19 at d3517d592f)
 + t0040: convert all possible tests to use `test-parse-options --expect`

 Test clean-up.


* po/fix-doc-merge-base-illustration (2016-10-24) 2 commits
  (merged to 'next' on 2016-10-24 at 6539e97fcf)
 + doc: fix the 'revert a faulty merge' ASCII art tab spacing
  (merged to 'next' on 2016-10-21 at ac6f04a6c5)
 + doc: fix merge-base ASCII art tab spacing

 Some AsciiDoc formatter mishandles a displayed illustration with
 tabs in it.  Adjust a few of them in merge-base documentation to
 work around them.


* pt/gitgui-updates (2016-10-20) 35 commits
  (merged to 'next' on 2016-10-21 at 4c8214095a)
 + Merge tag 'gitgui-0.21.0' of git://repo.or.cz/git-gui
 + git-gui: set version 0.21
 + Merge branch 'as/bulgarian' into pu
 + git-gui: Mark 'All' in remote.tcl for translation
 + git-gui i18n: Updated Bulgarian translation (565,0f,0u)
 + Merge branch 'os/preserve-author' into pu
 + git-gui: avoid persisting modified author identity
 + git-gui: Do not reset author details on amend
 + Merge branch 'kb/unicode' into pu
 + git-gui: handle the encoding of Git's output correctly
 + git-gui: unicode file name support on windows
 + Merge branch 'dr/ru' into pu
 + git-gui: Update Russian translation
 + git-gui: maintain backwards compatibility for merge syntax
 + Merge branch 'va/i18n_2' into pu
 + git-gui i18n: mark string in lib/error.tcl for translation
 + git-gui: fix incorrect use of Tcl append command
 + git-gui i18n: mark "usage:" strings for translation
 + git-gui i18n: internationalize use of colon punctuation
 + Merge branch 'pt/non-mouse-usage' into pu
 + Amend tab ordering and text widget border and highlighting.
 + Allow keyboard control to work in the staging widgets.
 + Merge branch 'pt/git4win-mods' into pu
 + git-gui (Windows): use git-gui.exe in `Create Desktop Shortcut`
 + git-gui: fix detection of Cygwin
 + Merge branch 'patches' into pu
 + git-gui: ensure the file in the diff pane is in the list of selected files
 + git-gui: support for $FILENAMES in tool definitions
 + git-gui: fix initial git gui message encoding
 + git-gui/po/glossary/txt-to-pot.sh: use the $( ... ) construct for command substitution
 + Merge branch 'va/i18n' into pu
 + Merge branch 'rs/use-modern-git-merge-syntax' into pu
 + Merge branch 'js/commit-gpgsign' into pu
 + Merge branch 'sy/i18n' into pu
 + git-gui: sort entries in tclIndex

 A new version of git-gui, now at its 0.21.0 tag.


* tg/add-chmod+x-fix (2016-10-20) 1 commit
  (merged to 'next' on 2016-10-21 at 1585ac7139)
 + t3700: fix broken test under !SANITY

 A hot-fix for a test added by a recent topic that went to both
 'master' and 'maint' already.


* va/i18n (2016-10-17) 7 commits
  (merged to 'next' on 2016-10-19 at b7d733698b)
 + i18n: diff: mark warnings for translation
 + i18n: credential-cache--daemon: mark advice for translation
 + i18n: convert mark error messages for translation
 + i18n: apply: mark error message for translation
 + i18n: apply: mark error messages for translation
 + i18n: apply: mark info messages for translation
 + i18n: apply: mark plural string for translation

 More i18n.


* yk/git-tag-remove-mention-of-old-layout-in-doc (2016-10-20) 1 commit
  (merged to 'next' on 2016-10-21 at 8d9e23b023)
 + doc: remove reference to the traditional layout in git-tag.txt

 Shorten description of auto-following in "git tag" by removing a
 mention of historical remotes layout which is not relevant to the
 main topic.

--------------------------------------------------
[New Topics]

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
 (this branch uses jk/no-looking-at-dotgit-outside-repo.)

 This is the endgame of the topic to avoid blindly falling back to
 ".git" when the setup sequence said we are _not_ in Git repository.
 A corner case that happens to work right now may be broken by a
 call to die("BUG").

 Will cook in 'next'.


* ew/svn-wt (2016-10-14) 2 commits
 - git-svn: "git worktree" awareness
 - git-svn: reduce scope of input record separator change

 Will replace with a direct pulling from Eric to 'master'.

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

 Will merge to 'master'.


* jc/reset-unmerge (2016-10-24) 1 commit
 - reset: --unmerge

 After "git add" is run prematurely during a conflict resolution,
 "git diff" can no longer be used as a way to sanity check by
 looking at the combined diff.  "git reset" learned a new
 "--unmerge" option to recover from this situation.


* jk/daemon-path-ok-check-truncation (2016-10-24) 1 commit
  (merged to 'next' on 2016-10-26 at 70c08241f6)
 + daemon: detect and reject too-long paths

 "git daemon" used fixed-length buffers to turn URL to the
 repository the client asked for into the server side directory
 path, using snprintf() to avoid overflowing these buffers, but
 allowed possibly truncated paths to the directory.  This has been
 tightened to reject such a request that causes overlong path to be
 required to serve.

 Will merge to 'master'.


* ls/git-open-cloexec (2016-10-25) 3 commits
  (merged to 'next' on 2016-10-26 at f7259cbddb)
 + read-cache: make sure file handles are not inherited by child processes
 + sha1_file: open window into packfiles with O_CLOEXEC
 + sha1_file: rename git_open_noatime() to git_open()

 Git generally does not explicitly close file descriptors that were
 open in the parent process when spawning a child process, but most
 of the time the child does not want to access them. As Windows does
 not allow removing or renaming a file that has a file descriptor
 open, a slow-to-exit child can even break the parent process by
 holding onto them.  Use O_CLOEXEC flag to open files in various
 codepaths.

 Will merge to 'master'.


* rs/ring-buffer-wraparound (2016-10-26) 1 commit
  (merged to 'next' on 2016-10-26 at d2da68a14a)
 + hex: make wraparound of the index into ring-buffer explicit

 The code that we have used for the past 10+ years to cycle
 4-element ring buffers turns out to be not quite portable in
 theoretical world.

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

 Will merge to 'master'.


* tb/convert-stream-check (2016-10-12) 2 commits
 - convert.c: stream and fast search for binary
 - read-cache: factor out get_sha1_from_index() helper

 End-of-line conversion sometimes needs to see if the current blob
 in the index has NULs and CRs to base its decision.  We used to
 always get a full statistics over the blob, but in many cases we
 can return early when we have seen "enough" (e.g. if we see a
 single NUL, the blob will be handled as binary).  The codepaths
 have been optimized by using streaming interface.

 Waiting for review.


* jt/trailer-with-cruft (2016-10-21) 8 commits
 - trailer: support values folded to multiple lines
 - trailer: forbid leading whitespace in trailers
 - trailer: allow non-trailers in trailer block
 - trailer: clarify failure modes in parse_trailer
 - trailer: make args have their own struct
 - trailer: streamline trailer item create and add
 - trailer: use list.h for doubly-linked list
 - trailer: improve const correctness

 Update "interpret-trailers" machinery and teaches it that people in
 real world write all sorts of crufts in the "trailer" that was
 originally designed to have the neat-o "Mail-Header: like thing"
 and nothing else.

 Waiting for review.


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

 Will merge to 'master'.


* sb/submodule-ignore-trailing-slash (2016-10-25) 3 commits
  (merged to 'next' on 2016-10-26 at e56a8ebb38)
 + t0060: sidestep surprising path mangling results on Windows
  (merged to 'next' on 2016-10-11 at e37425ed17)
 + submodule: ignore trailing slash in relative url
 + submodule: ignore trailing slash on superproject URL

 A minor regression fix for "git submodule".

 Will merge to 'master'.
 Queued with a test breakage workaround on Windows from j6t.


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

 Waiting for review.
 cf. <20161007210721.20437-1-santiago@nyu.edu>


* sb/attr (2016-10-24) 36 commits
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


* jk/abbrev-auto (2016-10-03) 1 commit
  (merged to 'next' on 2016-10-21 at 8aa3d760d8)
 + find_unique_abbrev: move logic out of get_short_sha1()
 (this branch is used by jc/abbrev-auto; uses lt/abbrev-auto.)

 Updates the way approximate count of total objects is computed
 while attempting to come up with a unique abbreviated object name,
 which in turn needs to estimate how many hexdigits are necessary to
 ensure uniqueness.

 Will merge to 'master'.


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

 Will merge to 'master'.


* lt/abbrev-auto (2016-10-03) 3 commits
  (merged to 'next' on 2016-10-03 at bb188d00f7)
 + abbrev: auto size the default abbreviation
 + abbrev: prepare for new world order
 + abbrev: add FALLBACK_DEFAULT_ABBREV to prepare for auto sizing
 (this branch is used by jc/abbrev-auto and jk/abbrev-auto.)

 Allow the default abbreviation length, which has historically been
 7, to scale as the repository grows.  The logic suggests to use 12
 hexdigits for the Linux kernel, and 9 to 10 for Git itself.

 Will hold to see if people scream.


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
