Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFF5A20986
	for <e@80x24.org>; Tue, 27 Sep 2016 23:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755633AbcI0XXQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 19:23:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51924 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754630AbcI0XXN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 19:23:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B49113D2BF;
        Tue, 27 Sep 2016 19:23:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=r
        7lunlb1/5T77b4RizQYqc/Ljfk=; b=SwXxpNIY5oNI/q0JvRkm9HIZtL+4a0F6F
        GnWqib3eCIiiGCRmKu+Fc0XN/N3HqCs5FnkEiAsYBaLTn7LlphaZP1uKRPpE3NFB
        gX29EH3fbF5PpP8csbTVEsnvCwu6UKzZm1NmSDpBrVZx+Ak0Y7p5L6RBUrHPS6mU
        Yt4473bBEI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=esM
        RS3m4SROCRvUBz7aMVqQueBkoElj3J65NG/rw+bZ5SWGXRMuz1mkpyrd0jeZlsoW
        l5t7/r/gfy4CZpEJ/2gIeJvCRImHTdKgxQq3KPySTTINoy3LzC6SMGO3TraUtERq
        Gq8mbWfPm+lB/tzy9QdDzCWuUeoZO2LJZsW+nlzQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AB5813D2BE;
        Tue, 27 Sep 2016 19:23:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E7FAB3D2BD;
        Tue, 27 Sep 2016 19:23:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Sep 2016, #08; Tue, 27)
X-master-at: 21f862b498925194f8f1ebe8203b7a7df756555b
X-next-at: 59e95dbc0e21ff4f326eb160a9f4c21e1a059f56
Date:   Tue, 27 Sep 2016 16:23:08 -0700
Message-ID: <xmqq8tudkjvn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5B056276-8509-11E6-B4DE-C26412518317-77302942!pb-smtp1.pobox.com
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

* mh/diff-indent-heuristic (2016-09-19) 8 commits
  (merged to 'next' on 2016-09-22 at e71d742)
 + blame: honor the diff heuristic options and config
 + parse-options: add parse_opt_unknown_cb()
 + diff: improve positioning of add/delete blocks in diffs
 + xdl_change_compact(): introduce the concept of a change group
 + recs_match(): take two xrecord_t pointers as arguments
 + is_blank_line(): take a single xrecord_t as argument
 + xdl_change_compact(): only use heuristic if group can't be matched
 + xdl_change_compact(): fix compaction heuristic to adjust ixo

 Output from "git diff" can be made easier to read by selecting
 which lines are common and which lines are added/deleted
 intelligently when the lines before and after the changed section
 are the same.  A command line option is added to help with the
 experiment to find a good heuristics.
 * mh/diff-indent-heuristic (2016-09-27) 1 commit
 - xdiff: rename "struct group" to "struct xdlgroup"

 Clean-up for a recently graduated topic.


* rs/cocci (2016-09-15) 3 commits
  (merged to 'next' on 2016-09-22 at aa54fa4)
 + use strbuf_addstr() for adding constant strings to a strbuf, part 2
 + add coccicheck make target
 + contrib/coccinelle: fix semantic patch for oid_to_hex_r()

 Code cleanup.


* ep/doc-check-ref-format-example (2016-09-21) 1 commit
  (merged to 'next' on 2016-09-22 at 6d0d79e)
 + git-check-ref-format.txt: fixup documentation

 A shell script example in check-ref-format documentation has been
 fixed.


* jk/clone-recursive-progress (2016-09-22) 1 commit
  (merged to 'next' on 2016-09-22 at 8310c42)
 + clone: pass --progress decision to recursive submodules

 "git clone --recurse-submodules" lost the progress eye-candy in
 recent update, which has been corrected.


* jk/doc-cvs-update (2016-09-22) 3 commits
  (merged to 'next' on 2016-09-22 at c0f949f)
 + docs/cvs-migration: mention cvsimport caveats
 + docs/cvs-migration: update link to cvsps homepage
 + docs/cvsimport: prefer cvs-fast-export to parsecvs

 Documentation around tools to import from CVS was fairly outdated.


* js/regexec-buf (2016-09-21) 3 commits
  (merged to 'next' on 2016-09-22 at 2ee2477)
 + regex: use regexec_buf()
 + regex: add regexec_buf() that can work on a non NUL-terminated string
 + regex: -G<pattern> feeds a non NUL-terminated string to regexec() and fails

 Some codepaths in "git diff" used regexec(3) on a buffer that was
 mmap(2)ed, which may not have a terminating NUL, leading to a read
 beyond the end of the mapped region.  This was fixed by introducing
 a regexec_buf() helper that takes a <ptr,len> pair with REG_STARTEND
 extension.


* jt/format-patch-rfc (2016-09-21) 1 commit
  (merged to 'next' on 2016-09-22 at 3b39442)
 + format-patch: add "--rfc" for the common case of [RFC PATCH]

 In some projects, it is common to use "[RFC PATCH]" as the subject
 prefix for a patch meant for discussion rather than application.  A
 new option "--rfc" was a short-hand for "--subject-prefix=RFC PATCH"
 to help the participants of such projects.


* ls/travis-homebrew-path-fix (2016-09-22) 1 commit
  (merged to 'next' on 2016-09-22 at 310e620)
 + travis-ci: ask homebrew for its path instead of hardcoding it

 The procedure to build Git on Mac OS X for Travis CI hardcoded the
 internal directory structure we assumed HomeBrew uses, which was a
 no-no.  The procedure has been updated to ask HomeBrew things we
 need to know to fix this.


* mm/config-color-ui-default-to-auto (2016-09-16) 1 commit
  (merged to 'next' on 2016-09-22 at 4eac0cb)
 + Documentation/config: default for color.* is color.ui

 Documentation for individual configuration variables to control use
 of color (like `color.grep`) said that their default value is
 'false', instead of saying their default is taken from `color.ui`.
 When we updated the default value for color.ui from 'false' to
 'auto' quite a while ago, all of them broke.  This has been
 corrected.


* nd/checkout-disambiguation (2016-09-21) 3 commits
  (merged to 'next' on 2016-09-22 at ebfa365)
 + checkout: fix ambiguity check in subdir
 + checkout.txt: document a common case that ignores ambiguation rules
 + checkout: add some spaces between code and comment

 "git checkout <word>" does not follow the usual disambiguation
 rules when the <word> can be both a rev and a path, to allow
 checking out a branch 'foo' in a project that happens to have a
 file 'foo' in the working tree without having to disambiguate.
 This was poorly documented and the check was incorrect when the
 command was run from a subdirectory.


* rs/c-auto-resets-attributes (2016-09-19) 1 commit
  (merged to 'next' on 2016-09-22 at 68f2e4a)
 + pretty: let %C(auto) reset all attributes

 The pretty-format specifier "%C(auto)" used by the "log" family of
 commands to enable coloring of the output is taught to also issue a
 color-reset sequence to the output.


* rs/checkout-init-macro (2016-09-22) 1 commit
  (merged to 'next' on 2016-09-22 at 6513755)
 + introduce CHECKOUT_INIT

 Code cleanup.


* rt/rebase-i-broken-insn-advise (2016-09-07) 1 commit
  (merged to 'next' on 2016-09-23 at 0d12484)
 + rebase -i: improve advice on bad instruction lines

 When "git rebase -i" is given a broken instruction, it told the
 user to fix it with "--edit-todo", but didn't say what the step
 after that was (i.e. "--continue").


* tg/add-chmod+x-fix (2016-09-21) 6 commits
  (merged to 'next' on 2016-09-22 at 6afdd21)
 + t3700-add: do not check working tree file mode without POSIXPERM
 + t3700-add: create subdirectory gently
 + add: modify already added files when --chmod is given
 + read-cache: introduce chmod_index_entry
 + update-index: add test for chmod flags
 + Merge branch 'ib/t3700-add-chmod-x-updates' into tg/add-chmod+x-fix

 "git add --chmod=+x <pathspec>" added recently only toggled the
 executable bit for paths that are either new or modified. This has
 been corrected to flip the executable bit for all paths that match
 the given pathspec.


* va/i18n-more (2016-09-21) 6 commits
  (merged to 'next' on 2016-09-22 at bea26e8)
 + i18n: stash: mark messages for translation
 + i18n: notes-merge: mark die messages for translation
 + i18n: ident: mark hint for translation
 + i18n: i18n: diff: mark die messages for translation
 + i18n: connect: mark die messages for translation
 + i18n: commit: mark message for translation

 Even more i18n.

--------------------------------------------------
[New Topics]

* mh/diff-indent-heuristic (2016-09-27) 1 commit
  (merged to 'next' on 2016-09-27 at 3d6fb66)
 + xdiff: rename "struct group" to "struct xdlgroup"

 Clean-up for a recently graduated topic.

 Will merge to 'master'.


* rs/cocci (2016-09-27) 3 commits
 - use strbuf_add_unique_abbrev() for adding short hashes, part 2
 - use strbuf_addstr() instead of strbuf_addf() with "%s", part 2
 - gitignore: ignore output files of coccicheck make target

 Code clean-up with help from coccinelle tool continues.

 Will merge to 'next'.


* jc/verify-loose-object-header (2016-09-26) 2 commits
  (merged to 'next' on 2016-09-27 at 2947f95)
 + unpack_sha1_header(): detect malformed object header
 + streaming: make sure to notice corrupt object

 Codepaths that read from an on-disk loose object were too loose in
 validating what they are reading is a proper object file and
 sometimes read past the data they read from the disk, which has
 been corrected.  H/t to Gustavo Grieco for reporting.

 Will merge to 'master'.


* jk/ambiguous-short-object-names (2016-09-27) 11 commits
 - get_short_sha1: make default disambiguation configurable
 - get_short_sha1: list ambiguous objects on error
 - for_each_abbrev: drop duplicate objects
 - sha1_array: let callbacks interrupt iteration
 - get_short_sha1: mark ambiguity error for translation
 - get_short_sha1: NUL-terminate hex prefix
 - get_short_sha1: refactor init of disambiguation code
 - get_short_sha1: parse tags when looking for treeish
 - get_sha1: propagate flags to child functions
 - get_sha1: avoid repeating ourselves via ONLY_TO_DIE
 - get_sha1: detect buggy calls with multiple disambiguators

 When given an abbreviated object name that is not (or more
 realistically, "no longer") unique, we gave a fatal error
 "ambiguous argument".  This error is now accompanied by hints that
 lists the objects that begins with the given prefix.  During the
 course of development of this new feature, numerous minor bugs were
 uncovered and corrected, the most notable one of which is that we
 gave "short SHA1 xxxx is ambiguous." twice without good reason.

 Will merge to 'next'.


* rs/copy-array (2016-09-25) 2 commits
  (merged to 'next' on 2016-09-27 at c92e020)
 + use COPY_ARRAY
 + add COPY_ARRAY

 Code cleanup.

 Will merge to 'master'.


* rs/git-gui-use-modern-git-merge-syntax (2016-09-26) 2 commits
  (merged to 'next' on 2016-09-27 at f55850d)
 + Merge branch 'rs/use-modern-git-merge-syntax' of git-gui into rs/git-gui-use-modern-git-merge-syntax
 + git-gui: stop using deprecated merge syntax

 The original command line syntax for "git merge", which was "git
 merge <msg> HEAD <parent>...", has been deprecated for quite some
 time, and "git gui" was the last in-tree user of the syntax.  This
 is finally fixed, so that we can move forward with the deprecation.

 Will merge to 'master'.


* va/git-gui-i18n (2016-09-26) 3 commits
  (merged to 'next' on 2016-09-27 at ab0f66f)
 + Merge branch 'va/i18n' of ../git-gui into va/git-gui-i18n
 + git-gui: l10n: add Portuguese translation
 + git-gui i18n: mark strings for translation

 "git gui" l10n to Portuguese.

 Will merge to 'master'.


* va/i18n-perl-scripts (2016-09-25) 11 commits
 - i18n: difftool: mark warnings for translation
 - i18n: send-email: mark string with interpolation for translation
 - i18n: send-email: mark warnings and errors for translation
 - i18n: send-email: mark strings for translation
 - i18n: add--interactive: mark edit_hunk_manually message for translation
 - i18n: add--interactive: i18n of help_patch_cmd
 - i18n: add--interactive: mark message for translation
 - i18n: add--interactive: mark plural strings
 - i18n: add--interactive: mark strings with interpolation for translation
 - i18n: add--interactive: mark simple here documents for translation
 - i18n: add--interactive: mark strings for translation

 Porcelain scripts written in Perl are getting internationalized.

 Waiting for a reroll.
 cf. <1474913721.1035.9.camel@sapo.pt>


* vn/revision-shorthand-for-side-branch-log (2016-09-27) 1 commit
 - revision: new rev^-n shorthand for rev^n..rev

 "git log rev^..rev" is an often-used revision range specification
 to show what was done on a side branch merged at rev, which has
 gained a short-hand "rev^-1".  In general "rev^-$n" is the same as
 "^rev^$n rev", i.e. what was done while the history leading to nth
 parent was looking the other way.

 Will merge to 'next'.


* dt/mailinfo (2016-09-26) 1 commit
  (merged to 'next' on 2016-09-27 at 59e95db)
 + add David Turner's Two Sigma address

 Will merge to 'master'.


* dt/tree-fsck (2016-09-27) 2 commits
 - fsck: handle bad trees like other errors
 - tree-walk: be more specific about corrupt tree errors

 The codepath in "git fsck" to detect malformed tree objects has
 been updated not to die but keep going after detecting them.

 Will merge to 'next'.


* jc/latin-1 (2016-09-26) 2 commits
 - utf8: accept "latin-1" as ISO-8859-1
 - utf8: refactor code to decide fallback encoding

 Some platforms no longer understand "latin-1" that is still seen in
 the wild in e-mail headers; replace them with "iso-8859-1" that is
 more widely known when conversion fails from/to it.

 Will merge to 'next'.


* jc/worktree-config (2016-09-27) 1 commit
 - worktree: honor configuration variables

 "git worktree", even though it used the default_abbrev setting that
 ought to be affected by core.abbrev configuration variable, ignored
 the variable setting.  The command has been taught to read the
 default set of configuration variables to correct this.

 Will merge to 'next'.


* mg/gpg-richer-status (2016-09-27) 1 commit
 - gpg-interface: use more status letters

 The GPG verification status shown in "%G?" pretty format specifier
 was not rich enough to differentiate a signature made by an expired
 key, a signature made by a revoked key, etc.  New output letters
 have been assigned to express them.

 Will merge to 'next'.


* pb/rev-list-reverse-with-count (2016-09-27) 1 commit
 - rev-list-options: clarify the usage of --reverse

 Doc update.

 Will merge to 'next'.

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

* jk/verify-packfile-gently (2016-09-22) 1 commit
  (merged to 'next' on 2016-09-26 at f5abba5)
 + verify_packfile: check pack validity before accessing data

 A low-level function verify_packfile() was meant to show errors
 that were detected without dying itself, but under some conditions
 it didn't and died instead, which has been fixed.

 Will merge to 'master'.


* jt/fetch-pack-in-vain-count-with-stateless (2016-09-23) 1 commit
  (merged to 'next' on 2016-09-26 at 9645629)
 + fetch-pack: do not reset in_vain on non-novel acks

 When "git fetch" tries to find where the history of the repository
 it runs inhas diverged from what the other side has, it has a
 mechanism to avoid digging too deep into irrelevant side branches.
 This however did not work well over the "smart-http" transport due
 to a design bug, which has been fixed.

 Will merge to 'master'.


* ik/gitweb-force-highlight (2016-09-25) 2 commits
  (merged to 'next' on 2016-09-27 at cbb8391)
 + gitweb: use highlight's shebang detection
 + gitweb: remove unused guess_file_syntax() parameter

 "gitweb" can spawn "highlight" to show blob contents with
 (programming) language-specific syntax highlighting, but only
 when the language is known.  "highlight" can however be told
 to make the guess itself by giving it "--force" option, which
 has been enabled.

 Will merge to 'master'.


* jk/ident-ai-canonname-could-be-null (2016-09-23) 1 commit
  (merged to 'next' on 2016-09-26 at 0eefb29)
 + ident: handle NULL ai_canonname

 In the codepath that comes up with the hostname to be used in an
 e-mail when the user didn't tell us, we looked at ai_canonname
 field in struct addrinfo without making sure it is not NULL first.

 Will merge to 'master'.


* jc/blame-reverse (2016-06-14) 2 commits
  (merged to 'next' on 2016-09-22 at d1a8e9c)
 + blame: dwim "blame --reverse OLD" as "blame --reverse OLD.."
 + blame: improve diagnosis for "--reverse NEW"

 It is a common mistake to say "git blame --reverse OLD path",
 expecting that the command line is dwimmed as if asking how lines
 in path in an old revision OLD have survived up to the current
 commit.

 Will hold to see if it is broken.


* nd/init-core-worktree-in-multi-worktree-world (2016-09-25) 5 commits
  (merged to 'next' on 2016-09-27 at 619f7f3)
 + init: kill git_link variable
 + init: do not set unnecessary core.worktree
 + init: kill set_git_dir_init()
 + init: call set_git_dir_init() from within init_db()
 + init: correct re-initialization from a linked worktree

 "git init" tried to record core.worktree in the repository's
 'config' file when GIT_WORK_TREE environment variable was set and
 it was different from where GIT_DIR appears as ".git" at its top,
 but the logic was faulty when .git is a "gitdir:" file that points
 at the real place, causing trouble in working trees that are
 managed by "git worktree".  This has been corrected.

 Will merge to 'master'.


* jt/mailinfo-fold-in-body-headers (2016-09-21) 3 commits
  (merged to 'next' on 2016-09-26 at 4235eb6)
 + mailinfo: handle in-body header continuations
 + mailinfo: make is_scissors_line take plain char *
 + mailinfo: separate in-body header processing

 When "git format-patch --stdout" output is placed as an in-body
 header and it uses the RFC2822 header folding, "git am" failed to
 put the header line back into a single logical line.  The
 underlying "git mailinfo" was taught to handle this properly.

 Will merge to 'master'.


* kd/mailinfo-quoted-string (2016-09-26) 3 commits
 - mailinfo: unescape quoted-pair in header fields
 - SQUASH???
 - t5100-mailinfo: replace common path prefix with variable

 An e-mail author named that spelled a backslash-quoted double quote
 in the human readable part "My \"double quoted\" name" was not
 unquoted correctly.

 Waiting for a reroll.
 cf. <20160926194455.GB19089@ikke.info>


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


* ls/filter-process (2016-09-23) 11 commits
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


* hv/submodule-not-yet-pushed-fix (2016-09-14) 2 commits
 - serialize collection of refs that contain submodule changes
 - serialize collection of changed submodules

 The code in "git push" to compute if any commit being pushed in the
 superproject binds a commit in a submodule that hasn't been pushed
 out was overly inefficient, making it unusable even for a small
 project that does not have any submodule but have a reasonable
 number of refs.

 The last two in the original series seem to break a few tests when
 queued to 'pu', and dropped for now.

 Waiting for a reroll.


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
  (merged to 'next' on 2016-09-22 at abd1585)
 + completion: support excluding refs

 The command-line completion script (in contrib/) learned to
 complete "git cmd ^mas<HT>" to complete the negative end of
 reference to "git cmd ^master".

 Will hold to see if it is broken.


* sb/push-make-submodule-check-the-default (2016-08-24) 1 commit
 - push: change submodule default to check

 Turn the default of "push.recurseSubmodules" to "check".

 Will hold to wait for hv/submodule-not-yet-pushed-fix

 This reveals that the "check" mode is too inefficient to use in
 real projects, even in ones as small as git itself.
 cf. <xmqqh9aaot49.fsf@gitster.mtv.corp.google.com>


* ak/curl-imap-send-explicit-scheme (2016-08-17) 1 commit
  (merged to 'next' on 2016-09-22 at 4449584)
 + imap-send: Tell cURL to use imap:// or imaps://

 When we started cURL to talk to imap server when a new enough
 version of cURL library is available, we forgot to explicitly add
 imap(s):// before the destination.  To some folks, that didn't work
 and the library tried to make HTTP(s) requests instead.

 Will hold to see if it is broken.


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
  (merged to 'next' on 2016-09-22 at 9c5aeec)
 + ./configure.ac: detect SSL in libcurl using curl-config

 The ./configure script generated from configure.ac was taught how
 to detect support of SSL by libcurl better.

 Will hold to see if it is broken.


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
  (merged to 'next' on 2016-09-22 at f0cf3e3)
 + fetch, upload-pack: --deepen=N extends shallow boundary by N commits
 + upload-pack: add get_reachable_list()
 + upload-pack: split check_unreachable() in two, prep for get_reachable_list()
 + t5500, t5539: tests for shallow depth excluding a ref
 + clone: define shallow clone boundary with --shallow-exclude
 + fetch: define shallow boundary with --shallow-exclude
 + upload-pack: support define shallow boundary by excluding revisions
 + refs: add expand_ref()
 + t5500, t5539: tests for shallow depth since a specific date
 + clone: define shallow clone boundary based on time with --shallow-since
 + fetch: define shallow boundary with --shallow-since
 + upload-pack: add deepen-since to cut shallow repos based on time
 + shallow.c: implement a generic shallow boundary finder based on rev-list
 + fetch-pack: use a separate flag for fetch in deepening mode
 + fetch-pack.c: mark strings for translating
 + fetch-pack: use a common function for verbose printing
 + fetch-pack: use skip_prefix() instead of starts_with()
 + upload-pack: move rev-list code out of check_non_tip()
 + upload-pack: make check_non_tip() clean things up on error
 + upload-pack: tighten number parsing at "deepen" lines
 + upload-pack: use skip_prefix() instead of starts_with()
 + upload-pack: move "unshallow" sending code out of deepen()
 + upload-pack: remove unused variable "backup"
 + upload-pack: move "shallow" sending code out of deepen()
 + upload-pack: move shallow deepen code out of receive_needs()
 + transport-helper.c: refactor set_helper_option()
 + remote-curl.c: convert fetch_git() to use argv_array

 The existing "git fetch --depth=<n>" option was hard to use
 correctly when making the history of an existing shallow clone
 deeper.  A new option, "--deepen=<n>", has been added to make this
 easier to use.  "git clone" also learned "--shallow-since=<date>"
 and "--shallow-exclude=<tag>" options to make it easier to specify
 "I am interested only in the recent N months worth of history" and
 "Give me only the history since that version".

 Will hold to see if it is broken.


* jc/merge-drop-old-syntax (2015-04-29) 1 commit
 - merge: drop 'git merge <message> HEAD <commit>' syntax

 Stop supporting "git merge <message> HEAD <commit>" syntax that has
 been deprecated since October 2007, and issues a deprecation
 warning message since v2.5.0.

 It has been reported that git-gui still uses the deprecated syntax,
 which needs to be fixed before this final step can proceed.
 cf. <5671DB28.8020901@kdbg.org>

 Will hold to wait for rs/git-gui-use-modern-git-merge-syntax

--------------------------------------------------
[Discarded]

* jn/fix-connect-unexpected-hangup-diag (2016-09-08) 1 commit
 . connect: tighten check for unexpected early hang up

 Now part of jt/accept-capability-advertisement-when-fetching-from-void
 topic.
