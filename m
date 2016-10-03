Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C74E0207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 22:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752965AbcJCWbL (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 18:31:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60514 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751821AbcJCWbG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 18:31:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 464FB42514;
        Mon,  3 Oct 2016 18:31:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=e
        sOtdI6gMLhTxYpmiIrYd4nP57o=; b=Z4vuhKrZEOdymfXfwAnTvfA7GhPXrpxAB
        kcQPtQn4PLE+QndbB/w2LssmFlti5D3zETnwfVfeeSy3lDIjmZlClg0CgXxLtD8T
        TXsNHnl1kruPK8iPeR9XQFuVwe6tmTSqzd5oZ4Kfo6M/4wCpa5w00FDDBbFMP3OV
        WPd+oHgvIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=ZB/
        7mw/3jcLgnvBKup8xeNsIX4HsPrDarzl7JEhJ1pAGnXPXyw22GpdgUEegL+7KADI
        fwoIRp92M8jbVDulheAch+geU+h8wdYDtTaEPcDlOPzL0GQ7yVToJNYl1UbhUmNw
        LXTZABFtsBQd+h1N7Utob8s2Bd+PC78UwVqAWCCM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3D8E542513;
        Mon,  3 Oct 2016 18:31:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 700A842510;
        Mon,  3 Oct 2016 18:31:04 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Oct 2016, #01; Mon, 3)
X-master-at: 0cf36115dce7438a0eafad54a81cc57175e8fb54
X-next-at: 9af6bb63e9b9efbcd0064516a7811092873d1ddf
Date:   Mon, 03 Oct 2016 15:31:02 -0700
Message-ID: <xmqqtwct3w0p.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 11F6E64A-89B9-11E6-B418-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.  The ones marked with '.' do not appear in any of
the integration branches, but I am still holding onto them.

With fixes since 2.10 accumulated on the 'master' front, the first
maintenance release 2.10.1 has been tagged.  The auto-abbreviation
by Linus and Peff is now in 'next'.  The tip of 'master' has quite a
many topics merged since the last report.  Pat is back and hopefully
be more active as the git-gui maintainer.  Life is good ;-)

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* dt/mailinfo (2016-09-26) 1 commit
  (merged to 'next' on 2016-09-27 at 59e95dbc0e)
 + add David Turner's Two Sigma address


* dt/tree-fsck (2016-09-27) 2 commits
  (merged to 'next' on 2016-09-28 at afdfdbbf37)
 + fsck: handle bad trees like other errors
 + tree-walk: be more specific about corrupt tree errors

 The codepath in "git fsck" to detect malformed tree objects has
 been updated not to die but keep going after detecting them.


* ik/gitweb-force-highlight (2016-09-25) 2 commits
  (merged to 'next' on 2016-09-27 at cbb8391a76)
 + gitweb: use highlight's shebang detection
 + gitweb: remove unused guess_file_syntax() parameter

 "gitweb" can spawn "highlight" to show blob contents with
 (programming) language-specific syntax highlighting, but only
 when the language is known.  "highlight" can however be told
 to make the guess itself by giving it "--force" option, which
 has been enabled.


* jc/verify-loose-object-header (2016-09-26) 2 commits
  (merged to 'next' on 2016-09-27 at 2947f95f14)
 + unpack_sha1_header(): detect malformed object header
 + streaming: make sure to notice corrupt object

 Codepaths that read from an on-disk loose object were too loose in
 validating what they are reading is a proper object file and
 sometimes read past the data they read from the disk, which has
 been corrected.  H/t to Gustavo Grieco for reporting.


* jc/worktree-config (2016-09-27) 1 commit
  (merged to 'next' on 2016-09-28 at 0c262f6)
 + worktree: honor configuration variables

 "git worktree", even though it used the default_abbrev setting that
 ought to be affected by core.abbrev configuration variable, ignored
 the variable setting.  The command has been taught to read the
 default set of configuration variables to correct this.


* jk/ident-ai-canonname-could-be-null (2016-09-23) 1 commit
  (merged to 'next' on 2016-09-26 at 0eefb29)
 + ident: handle NULL ai_canonname

 In the codepath that comes up with the hostname to be used in an
 e-mail when the user didn't tell us, we looked at ai_canonname
 field in struct addrinfo without making sure it is not NULL first.


* jk/verify-packfile-gently (2016-09-22) 1 commit
  (merged to 'next' on 2016-09-26 at f5abba5)
 + verify_packfile: check pack validity before accessing data

 A low-level function verify_packfile() was meant to show errors
 that were detected without dying itself, but under some conditions
 it didn't and died instead, which has been fixed.


* jt/fetch-pack-in-vain-count-with-stateless (2016-09-23) 1 commit
  (merged to 'next' on 2016-09-26 at 9645629)
 + fetch-pack: do not reset in_vain on non-novel acks

 When "git fetch" tries to find where the history of the repository
 it runs in has diverged from what the other side has, it has a
 mechanism to avoid digging too deep into irrelevant side branches.
 This however did not work well over the "smart-http" transport due
 to a design bug, which has been fixed.


* jt/mailinfo-fold-in-body-headers (2016-09-21) 3 commits
  (merged to 'next' on 2016-09-26 at 4235eb6)
 + mailinfo: handle in-body header continuations
 + mailinfo: make is_scissors_line take plain char *
 + mailinfo: separate in-body header processing

 When "git format-patch --stdout" output is placed as an in-body
 header and it uses the RFC2822 header folding, "git am" failed to
 put the header line back into a single logical line.  The
 underlying "git mailinfo" was taught to handle this properly.


* kd/mailinfo-quoted-string (2016-09-28) 2 commits
  (merged to 'next' on 2016-09-28 at 2aaeb57804)
 + mailinfo: unescape quoted-pair in header fields
 + t5100-mailinfo: replace common path prefix with variable

 An author name, that spelled a backslash-quoted double quote in the
 human readable part "My \"double quoted\" name", was not unquoted
 correctly while applying a patch from a piece of e-mail.


* mh/diff-indent-heuristic (2016-09-27) 1 commit
  (merged to 'next' on 2016-09-27 at 3d6fb6605a)
 + xdiff: rename "struct group" to "struct xdlgroup"

 Clean-up for a recently graduated topic.


* nd/init-core-worktree-in-multi-worktree-world (2016-09-25) 5 commits
  (merged to 'next' on 2016-09-27 at 619f7f3a3b)
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


* pb/rev-list-reverse-with-count (2016-09-27) 1 commit
  (merged to 'next' on 2016-09-28 at 2905d0adbc)
 + rev-list-options: clarify the usage of --reverse

 Doc update to clarify what "log -3 --reverse" does.


* rs/copy-array (2016-09-25) 2 commits
  (merged to 'next' on 2016-09-27 at c92e020669)
 + use COPY_ARRAY
 + add COPY_ARRAY

 Code cleanup.


* rs/git-gui-use-modern-git-merge-syntax (2016-09-26) 2 commits
  (merged to 'next' on 2016-09-27 at f55850df7d)
 + Merge branch 'rs/use-modern-git-merge-syntax' of git-gui into rs/git-gui-use-modern-git-merge-syntax
 + git-gui: stop using deprecated merge syntax

 The original command line syntax for "git merge", which was "git
 merge <msg> HEAD <parent>...", has been deprecated for quite some
 time, and "git gui" was the last in-tree user of the syntax.  This
 is finally fixed, so that we can move forward with the deprecation.


* va/git-gui-i18n (2016-09-26) 3 commits
  (merged to 'next' on 2016-09-27 at ab0f66ff8a)
 + Merge branch 'va/i18n' of ../git-gui into va/git-gui-i18n
 + git-gui: l10n: add Portuguese translation
 + git-gui i18n: mark strings for translation

 "git gui" l10n to Portuguese.

--------------------------------------------------
[New Topics]

* rs/cocci (2016-10-03) 4 commits
  (merged to 'next' on 2016-10-03 at 758cc6de9c)
 + coccicheck: make transformation for strbuf_addf(sb, "...") more precise
  (merged to 'next' on 2016-09-28 at 26462645f9)
 + use strbuf_add_unique_abbrev() for adding short hashes, part 2
 + use strbuf_addstr() instead of strbuf_addf() with "%s", part 2
 + gitignore: ignore output files of coccicheck make target

 Code clean-up with help from coccinelle tool continues.

 Will merge to 'master'.


* nd/ita-empty-commit (2016-09-28) 3 commits
 - commit: don't be fooled by ita entries when creating initial commit
 - diff-lib.c: enable --shift-ita in index_differs_from()
 - Resurrect "diff-lib.c: adjust position of i-t-a entries in diff"

 When new paths were added by "git add -N" to the index, it was
 enough to circumvent the check by "git commit" to refrain from
 making an empty commit without "--allow-empty".  The same logic
 prevented "git status" to show such a path as "new file" in the
 "Changes not staged for commit" section.

 Expecting a reroll.
 cf. <xmqqzimrj03j.fsf@gitster.mtv.corp.google.com>
 cf. <xmqq8tubkgg5.fsf@gitster.mtv.corp.google.com>


* jc/blame-abbrev (2016-09-28) 1 commit
  (merged to 'next' on 2016-10-03 at 8ec86ff1e1)
 + blame: use DEFAULT_ABBREV macro

 Almost everybody uses DEFAULT_ABBREV to refer to the default
 setting for the abbreviation, but "git blame" peeked into
 underlying variable bypassing the macro for no good reason.

 Will merge to 'master'.


* lt/abbrev-auto (2016-10-03) 3 commits
  (merged to 'next' on 2016-10-03 at bb188d00f7)
 + abbrev: auto size the default abbreviation
 + abbrev: prepare for new world order
 + abbrev: add FALLBACK_DEFAULT_ABBREV to prepare for auto sizing
 (this branch uses jk/ambiguous-short-object-names.)

 Allow the default abbreviation length, which has historically been
 7, to scale as the repository grows.  The logic suggests to use 12
 hexdigits for the Linux kernel, and 9 to 10 for Git itself.

 Will merge to 'master'.


* dt/http-empty-auth (2016-10-03) 1 commit
 - http: http.emptyauth should allow empty (not just NULL) usernames

 http.emptyauth configuration is a way to allow an empty username to
 pass when attempting to authenticate using mechanisms like
 Kerberos.  We took an unspecified (NULL) username and sent ":"
 (i.e. no username, no password) to CURLOPT_USERPWD, but did not do
 the same when the username is explicitly set to an empty string.

 cf. <20161003210100.t5nqknwfotag3lmj@sigill.intra.peff.net>


* jc/diff-unique-abbrev-comments (2016-09-30) 1 commit
 - diff_unique_abbrev(): document its assumption and limitation


* jk/graph-padding-fix (2016-09-29) 1 commit
  (merged to 'next' on 2016-10-03 at 3f526e0f38)
 + graph: fix extra spaces in graph_padding_line

 The "graph" API used in "git log --graph" miscounted the number of
 output columns consumed so far when drawing a padding line, which
 has been fixed; this did not affect any existing code as nobody
 tried to write anything after the padding on such a line, though.

 Will merge to 'master'.


* jk/quarantine-received-objects (2016-10-03) 5 commits
 - tmp-objdir: do not migrate files starting with '.'
 - tmp-objdir: put quarantine information in the environment
 - receive-pack: quarantine objects until pre-receive accepts
 - tmp-objdir: introduce API for temporary object directories
 - check_connected: accept an env argument
 (this branch uses jk/alt-odb-cleanup.)

 In order for the receiving end of "git push" to inspect the
 received history and decide to reject the push, the objects sent
 from the sending end need to be made available to the hook and
 the mechanism for the connectivity check, and this was done
 traditionally by storing the objects in the receiving repository
 and letting "git gc" to expire it.  Instead, store the newly
 received objects in a temporary area, and make them available by
 reusing the alternate object store mechanism to them only while we
 decide if we accept the check, and once we decide, either migrate
 them to the repository or purge them immediately.


* ps/http-gssapi-cred-delegation (2016-09-29) 1 commit
  (merged to 'next' on 2016-10-03 at 310fbe8f24)
 + http: control GSSAPI credential delegation

 In recent versions of cURL, GSSAPI credential delegation is
 disabled by default due to CVE-2011-2192; introduce a configuration
 to selectively allow enabling this.

 Will merge to 'master'.


* rs/c-auto-resets-attributes (2016-09-29) 1 commit
  (merged to 'next' on 2016-10-03 at 6a0b946a79)
 + pretty: avoid adding reset for %C(auto) if output is empty

 When "%C(auto)" appears at the very beginning of the pretty format
 string, it did not need to issue the reset sequence, but it did.

 Will merge to 'master'.
 This is a small optimization to already graduated topic.


* rs/qsort (2016-10-03) 6 commits
 - show-branch: use QSORT
 - use QSORT, part 2
 - coccicheck: use --all-includes by default
 - remove unnecessary check before QSORT
 - use QSORT
 - add QSORT

 We call "qsort(array, nelem, sizeof(array[0]), fn)", and most of
 the time third parameter is redundant.  A new QSORT() macro lets us
 omit it.

 Will merge to 'next'.


* sg/ref-filter-parse-optim (2016-10-03) 1 commit
  (merged to 'next' on 2016-10-03 at 9af6bb63e9)
 + ref-filter: strip format option after a field name only once while parsing

 The code that parses the format parameter of for-each-ref command
 has seen a micro-optimization.

 Will merge to 'master'.


* jk/alt-odb-cleanup (2016-10-03) 18 commits
 - alternates: use fspathcmp to detect duplicates
 - sha1_file: always allow relative paths to alternates
 - count-objects: report alternates via verbose mode
 - fill_sha1_file: write into a strbuf
 - alternates: store scratch buffer as strbuf
 - fill_sha1_file: write "boring" characters
 - alternates: use a separate scratch space
 - alternates: encapsulate alt->base munging
 - alternates: provide helper for allocating alternate
 - alternates: provide helper for adding to alternates list
 - link_alt_odb_entry: refactor string handling
 - link_alt_odb_entry: handle normalize_path errors
 - t5613: clarify "too deep" recursion tests
 - t5613: do not chdir in main process
 - t5613: whitespace/style cleanups
 - t5613: use test_must_fail
 - t5613: drop test_valid_repo function
 - t5613: drop reachable_via function
 (this branch is used by jk/quarantine-received-objects.)

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

* jk/ambiguous-short-object-names (2016-09-27) 11 commits
  (merged to 'next' on 2016-09-28 at 1b85295323)
 + get_short_sha1: make default disambiguation configurable
 + get_short_sha1: list ambiguous objects on error
 + for_each_abbrev: drop duplicate objects
 + sha1_array: let callbacks interrupt iteration
 + get_short_sha1: mark ambiguity error for translation
 + get_short_sha1: NUL-terminate hex prefix
 + get_short_sha1: refactor init of disambiguation code
 + get_short_sha1: parse tags when looking for treeish
 + get_sha1: propagate flags to child functions
 + get_sha1: avoid repeating ourselves via ONLY_TO_DIE
 + get_sha1: detect buggy calls with multiple disambiguators
 (this branch is used by lt/abbrev-auto.)

 When given an abbreviated object name that is not (or more
 realistically, "no longer") unique, we gave a fatal error
 "ambiguous argument".  This error is now accompanied by hints that
 lists the objects that begins with the given prefix.  During the
 course of development of this new feature, numerous minor bugs were
 uncovered and corrected, the most notable one of which is that we
 gave "short SHA1 xxxx is ambiguous." twice without good reason.

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
  (merged to 'next' on 2016-09-28 at c1237b24f6)
 + revision: new rev^-n shorthand for rev^n..rev

 "git log rev^..rev" is an often-used revision range specification
 to show what was done on a side branch merged at rev.  This has
 gained a short-hand "rev^-1".  In general "rev^-$n" is the same as
 "^rev^$n rev", i.e. what has happened on other branches while the
 history leading to nth parent was looking the other way.

 Will merge to 'master'.


* jc/latin-1 (2016-09-26) 2 commits
  (merged to 'next' on 2016-09-28 at c8673e03c2)
 + utf8: accept "latin-1" as ISO-8859-1
 + utf8: refactor code to decide fallback encoding

 Some platforms no longer understand "latin-1" that is still seen in
 the wild in e-mail headers; replace them with "iso-8859-1" that is
 more widely known when conversion fails from/to it.

 Will hold to see if people scream.


* mg/gpg-richer-status (2016-09-28) 1 commit
 - gpg-interface: use more status letters

 The GPG verification status shown in "%G?" pretty format specifier
 was not rich enough to differentiate a signature made by an expired
 key, a signature made by a revoked key, etc.  New output letters
 have been assigned to express them.


* jc/blame-reverse (2016-06-14) 2 commits
  (merged to 'next' on 2016-09-22 at d1a8e9ce99)
 + blame: dwim "blame --reverse OLD" as "blame --reverse OLD.."
 + blame: improve diagnosis for "--reverse NEW"

 It is a common mistake to say "git blame --reverse OLD path",
 expecting that the command line is dwimmed as if asking how lines
 in path in an old revision OLD have survived up to the current
 commit.

 Will hold to see if it is broken.


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


* bw/ls-files-recurse-submodules (2016-10-03) 4 commits
 - ls-files: add pathspec matching for submodules
 - ls-files: pass through safe options for --recurse-submodules
 - ls-files: optionally recurse into submodules
 - git: make super-prefix option

 "git ls-files" learned "--recurse-submodules" option that can be
 used to get a listing of tracked files across submodules (i.e. this
 only works with "--cached" option, not for listing untracked or
 ignored files).  This would be a useful tool to sit on the upstream
 side of a pipe that is read with xargs to work on all working tree
 files from the top-level superproject.

 Looking good.  Is this ready for 'next'?


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

 Somehow I thought this was getting ready for 'next' but it seems
 at least another round of reroll is coming?


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
  (merged to 'next' on 2016-09-22 at abd1585aa6)
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
  (merged to 'next' on 2016-09-22 at 4449584c26)
 + imap-send: Tell cURL to use imap:// or imaps://

 When we started cURL to talk to imap server when a new enough
 version of cURL library is available, we forgot to explicitly add
 imap(s):// before the destination.  To some folks, that didn't work
 and the library tried to make HTTP(s) requests instead.

 Will hold to see if it is broken.


* jk/pack-objects-optim-mru (2016-08-11) 4 commits
  (merged to 'next' on 2016-09-21 at 97b919bdbd)
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
  (merged to 'next' on 2016-09-22 at 9c5aeeced9)
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

 Will hold to see if people scream.


* nd/shallow-deepen (2016-06-13) 27 commits
  (merged to 'next' on 2016-09-22 at f0cf3e3385)
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
