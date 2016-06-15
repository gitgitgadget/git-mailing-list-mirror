From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Mar 2014, #03; Fri, 14)
Date: Fri, 14 Mar 2014 15:09:57 -0700
Message-ID: <xmqqlhwcfn4a.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 14 23:10:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOaIw-0008RF-4i
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 23:10:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755608AbaCNWKG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Mar 2014 18:10:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55477 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754419AbaCNWKB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Mar 2014 18:10:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 95EB171845;
	Fri, 14 Mar 2014 18:10:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=c85ouFI9hOaeojq6f5MrUpXuh
	Jg=; b=fi8Ng433dZgOODgPpwsQ099TUtGzWT+IiFy5efFE6Lj2lSt0kL7s5jH+e
	9aICwcXqh06Ib4A3CzMnJpWmaSSs3e+bCF+1jZiLj9Ahli/MxMEyV0PP8tTfYwOl
	ftR4e2SI4T+molHKlOSToE/3A56RpYMHK0X1feULXFgxPX29EQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=ixrDPP/7S63cLdJE794
	99lcxYZhgAyNmZtjkKEJOkeReGMnMqsctSfEVElehSmFrGjgdlvA5g1pgtLfCxRQ
	9xv8FhgzyDS0QaAcd4lpyf9etGqfQMIK4UYURzTxX3JXCV0/oZBt7wewUvbvuORo
	huop0stOi77W81EIxddyOgvM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F5E171843;
	Fri, 14 Mar 2014 18:10:00 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1A8997183E;
	Fri, 14 Mar 2014 18:09:59 -0400 (EDT)
X-master-at: 00eda23228acb68c85a76f977f4e59f82189ce3f
X-next-at: 169382a66e8adc06d7eb542d356ad22244051e6d
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 61EE8650-ABC5-11E3-AA7C-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244120>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

More topics merged to 'master', some of which have been cooking
before the v1.9.0 final release.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* ak/gitweb-fit-image (2014-02-20) 1 commit
  (merged to 'next' on 2014-03-06 at ba8cb50)
 + gitweb: Avoid overflowing page body frame with large images

 Instead of allowing an <img> to be shown in whatever size, force
 scaling it to fit on the page with max-height/max-width css style
 attributes.


* da/difftool-git-files (2014-03-05) 2 commits
  (merged to 'next' on 2014-03-06 at a563ec1)
 + t7800: add a difftool test for .git-files
 + difftool: support repositories with .git-files

 "git difftool" misbehaved when the repository is bound to the
 working tree with the ".git file" mechanism, where a textual
 file ".git" tells us where it is.


* jc/check-attr-honor-working-tree (2014-02-06) 2 commits
  (merged to 'next' on 2014-03-06 at 960d679)
 + check-attr: move to the top of working tree when in non-bare reposit=
ory
 + t0003: do not chdir the whole test process

 "git check-attr" when (trying to) work on a repository with a
 working tree did not work well when the working tree was specified
 via --work-tree (and obviously with --git-dir).

 The command also works in a bare repository but it reads from the
 (possibly stale, irrelevant and/or nonexistent) index, which may
 need to be fixed to read from HEAD, but that is a completely
 separate issue.  As a related tangent to this separate issue, we
 may want to also fix "check-ignore", which refuses to work in a
 bare repository, to also operate in a bare one.


* jh/note-trees-record-blobs (2014-02-20) 1 commit
  (merged to 'next' on 2014-03-06 at f46852d)
 + notes: disallow reusing non-blob as a note object

 "git notes -C <blob>" should not take an object that is not a blob.


* jk/commit-dates-parsing-fix (2014-03-07) 6 commits
  (merged to 'next' on 2014-03-07 at 01e9d92)
 + show_ident_date: fix tz range check
  (merged to 'next' on 2014-03-06 at dd641e2)
 + log: do not segfault on gmtime errors
 + log: handle integer overflow in timestamps
 + date: check date overflow against time_t
 + fsck: report integer overflow in author timestamps
 + t4212: test bogus timestamps with git-log

 Codepaths that parse timestamps in commit objects have been
 tightened.


* jk/doc-coding-guideline (2014-02-28) 1 commit
  (merged to 'next' on 2014-03-06 at c33101d)
 + CodingGuidelines: mention C whitespace rules

 Elaborate on a style niggle that has been part of "mimic existing
 code".


* jk/http-no-curl-easy (2014-02-18) 1 commit
  (merged to 'next' on 2014-03-06 at 56d3f6f)
 + http: never use curl_easy_perform

 Uses of curl's "multi" interface and "easy" interface do not mix
 well when we attempt to reuse outgoing connections.  Teach the RPC
 over http code, used in the smart HTTP transport, not to use the
 "easy" interface.


* jk/janitorial-fixes (2014-02-18) 5 commits
  (merged to 'next' on 2014-03-06 at dac2de6)
 + open_istream(): do not dereference NULL in the error case
 + builtin/mv: don't use memory after free
 + utf8: use correct type for values in interval table
 + utf8: fix iconv error detection
 + notes-utils: handle boolean notes.rewritemode correctly


* jk/remote-pushremote-config-reading (2014-02-24) 1 commit
  (merged to 'next' on 2014-03-06 at 9e71ecb)
 + remote: handle pushremote config in any order

 "git push" did not pay attention to branch.*.pushremote if it is
 defined earlier than remote.pushdefault; the order of these two
 variables in the configuration file should not matter, but it did
 by mistake.


* jl/doc-submodule-update-checkout (2014-02-28) 1 commit
  (merged to 'next' on 2014-03-06 at 8cdf5cb)
 + submodule update: consistently document the '--checkout' option

 Add missing documentation for "submodule update --checkout".


* jm/stash-doc-k-for-keep (2014-02-24) 1 commit
  (merged to 'next' on 2014-03-06 at ddd8e48)
 + stash doc: mention short form -k in save description


* jn/am-doc-hooks (2014-02-24) 1 commit
  (merged to 'next' on 2014-03-06 at 5c1c372)
 + am doc: add a pointer to relevant hooks


* jn/bisect-coding-style (2014-03-03) 1 commit
  (merged to 'next' on 2014-03-06 at e1de2a5)
 + git-bisect.sh: fix a few style issues


* ks/config-file-stdin (2014-02-18) 4 commits
  (merged to 'next' on 2014-03-06 at 3e77313)
 + config: teach "git config --file -" to read from the standard input
 + config: change git_config_with_options() interface
 + builtin/config.c: rename check_blob_write() -> check_write()
 + config: disallow relative include paths from blobs

 "git config" learned to read from the standard input when "-" is
 given as the value to its "--file" parameter (attempting an
 operation to update the configuration in the standard input of
 course is rejected).


* lb/contrib-contacts-looser-diff-parsing (2014-02-18) 1 commit
  (merged to 'next' on 2014-03-06 at 1cc4ffe)
 + git-contacts: do not fail parsing of good diffs


* mh/object-code-cleanup (2014-02-24) 4 commits
  (merged to 'next' on 2014-03-06 at d6b3867)
 + sha1_file.c: document a bunch of functions defined in the file
 + sha1_file_name(): declare to return a const string
 + find_pack_entry(): document last_found_pack
 + replace_object: use struct members instead of an array


* mh/replace-refs-variable-rename (2014-02-28) 3 commits
  (merged to 'next' on 2014-03-06 at 70bf89b)
 + Document some functions defined in object.c
 + Add docstrings for lookup_replace_object() and do_lookup_replace_obj=
ect()
 + rename read_replace_refs to check_replace_refs


* nd/gitignore-trailing-whitespace (2014-03-11) 3 commits
  (merged to 'next' on 2014-03-11 at ccdba51)
 + t0008: skip trailing space test on Windows
  (merged to 'next' on 2014-03-06 at f649a34)
 + dir: ignore trailing spaces in exclude patterns
 + dir: warn about trailing spaces in exclude patterns

 Trailing whitespaces in .gitignore files, unless they are quoted
 for fnmatch(3), e.g. "path\ ", are warned and ignored.  Strictly
 speaking, this is a backward incompatible change, but very unlikely
 to bite any sane user and adjusting should be obvious and easy.


* nd/i18n-progress (2014-02-24) 1 commit
  (merged to 'next' on 2014-03-06 at 600fd3e)
 + i18n: mark all progress lines for translation

 The progress indicators from various time-consuming commands have
 been marked for i18n/l10n.


* nd/no-more-fnmatch (2014-02-20) 4 commits
  (merged to 'next' on 2014-03-06 at f0b8f12)
 + actually remove compat fnmatch source code
 + stop using fnmatch (either native or compat)
 + Revert "test-wildmatch: add "perf" command to compare wildmatch and =
fnmatch"
 + use wildmatch() directly without fnmatch() wrapper

 We started using wildmatch() in place of fnmatch(3); complete the
 process and stop using fnmatch(3).


* nd/reset-setup-worktree (2014-02-18) 1 commit
  (merged to 'next' on 2014-03-06 at d93f20a)
 + reset: optionally setup worktree and refresh index on --mixed

 "git reset" needs to refresh the index when working in a working
 tree (it can also be used to match the index to the HEAD in an
 otherwise bare repository), but it failed to set up the working
 tree properly, causing GIT_WORK_TREE to be ignored.


* nd/strbuf-inline-styles (2014-03-03) 1 commit
  (merged to 'next' on 2014-03-06 at 70b5e56)
 + strbuf: style fix -- top opening bracket on a separate line


* rt/help-pretty-prints-cmd-names (2014-02-28) 1 commit
  (merged to 'next' on 2014-03-06 at fc607dc)
 + help.c: rename function "pretty_print_string_list"


* rt/links-for-asciidoctor (2014-02-20) 1 commit
  (merged to 'next' on 2014-03-06 at 547f13d)
 + Documentation: fix documentation AsciiDoc links for external urls


* sg/archive-restrict-remote (2014-02-28) 2 commits
  (merged to 'next' on 2014-03-06 at 5fe8998)
 + add uploadarchive.allowUnreachable option
 + docs: clarify remote restrictions for git-upload-archive

 Allow loosening remote "git archive" invocation security check that
 refuses to serve tree-ish not at the tip of any ref.


* sh/write-pack-file-warning-message-fix (2014-03-03) 1 commit
  (merged to 'next' on 2014-03-06 at 1470b0a)
 + write_pack_file: use correct variable in diagnostic
 (this branch is used by sh/finish-tmp-packfile.)

 A warning from "git pack-objects" were generated by referring to an
 incorrect variable when forming the filename that we had trouble
 with.


* sr/add--interactive-term-readkey (2014-03-03) 2 commits
  (merged to 'next' on 2014-03-06 at 9ca7af8)
 + git-add--interactive: warn if module for interactive.singlekey is mi=
ssing
 + git-config: document interactive.singlekey requires Term::ReadKey


* ss/completion-rec-sub-fetch-push (2014-02-11) 1 commit
  (merged to 'next' on 2014-03-06 at b5bf463)
 + completion: teach --recurse-submodules to fetch, pull and push


* ta/parse-commit-with-skip-prefix (2014-03-04) 1 commit
  (merged to 'next' on 2014-03-06 at 0244988)
 + commit.c: use skip_prefix() instead of starts_with()


* tg/index-v4-format (2014-02-24) 3 commits
  (merged to 'next' on 2014-03-06 at d4ca5a8)
 + read-cache: add index.version config variable
 + test-lib: allow setting the index format version
 + introduce GIT_INDEX_VERSION environment variable


* tr/diff-submodule-no-reuse-worktree (2014-02-18) 1 commit
  (merged to 'next' on 2014-03-06 at ac8008f)
 + diff: do not reuse_worktree_file for submodules

 "git diff --external-diff" incorrectly fed the submodule directory
 in the working tree to the external diff driver when it knew it is
 the same as one of the versions being compared.

--------------------------------------------------
[New Topics]

* jn/wt-status (2014-03-12) 4 commits
  (merged to 'next' on 2014-03-14 at 8ac862c)
 + wt-status: lift the artificual "at least 20 columns" floor
 + wt-status: i18n of section labels
 + wt-status: extract the code to compute width for labels
 + wt-status: make full label string to be subject to l10n

 Unify the codepaths that format new/modified/changed sections and
 conflicted paths in the "git status" output and make it possible to
 properly internationalize their output.

 Will merge to 'master'.


* es/sh-i18n-envsubst (2014-03-12) 1 commit
  (merged to 'next' on 2014-03-14 at e4d5603)
 + sh-i18n--envsubst: retire unused string_list_member()

 Will merge to 'master'.


* mh/remove-subtree-long-pathname-fix (2014-03-13) 2 commits
 - entry.c: fix possible buffer overflow in remove_subtree()
 - checkout_entry(): use the strbuf throughout the function

 Will merge to 'next'.


* nd/indent-fix-connect-c (2014-03-13) 1 commit
 - connect.c: SP after "}", not TAB

 Will merge to 'next'.


* pw/branch-config-message (2014-03-13) 1 commit
 - install_branch_config(): simplify verbose messages logic

 Among the many attempts to microproject #8, this seemed to be the
 most "done" among the table based ones; I however tend to think
 that the original with minimum refactoring would be easier to read.


* ys/fsck-commit-parsing (2014-03-13) 2 commits
 - fsck.c:fsck_commit(): use skip_prefix() to verify and skip constant
 - fsck.c:fsck_ident(): ident points at a const string


* jk/warn-on-object-refname-ambiguity (2014-03-13) 4 commits
 - rev-list: disable object/refname ambiguity check with --stdin
 - cat-file: restore warn_on_object_refname_ambiguity flag
 - cat-file: fix a minor memory leak in batch_objects
 - cat-file: refactor error handling of batch_objects

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* bc/blame-crlf-test (2014-02-18) 1 commit
 - blame: add a failing test for a CRLF issue.

 I have a feeling that a fix for this should be fairly isolated and
 trivial (it should be just the matter of paying attention to the
 crlf settings when synthesizing the fake commit)---perhaps somebody
 can squash in a fix to this?


* ap/remote-hg-skip-null-bookmarks (2014-01-02) 1 commit
 - remote-hg: do not fail on invalid bookmarks

 Reported to break tests ($gmane/240005)
 Expecting a reroll.


* jk/makefile (2014-02-05) 16 commits
 - FIXUP
 - move LESS/LV pager environment to Makefile
 - Makefile: teach scripts to include make variables
 - FIXUP
 - Makefile: auto-build C strings from make variables
 - Makefile: drop *_SQ variables
 - FIXUP
 - Makefile: add c-quote helper function
 - Makefile: introduce sq function for shell-quoting
 - Makefile: always create files via make-var
 - Makefile: store GIT-* sentinel files in MAKE/
 - Makefile: prefer printf to echo for GIT-*
 - Makefile: use tempfile/mv strategy for GIT-*
 - Makefile: introduce make-var helper function
 - Makefile: fix git-instaweb dependency on gitweb
 - Makefile: drop USE_GETTEXT_SCHEME from GIT-CFLAGS

 Simplify the Makefile rules and macros that exist primarily for
 quoting purposes, and make it easier to robustly express the
 dependency rules.

 Expecting a reroll.


* kb/fast-hashmap-pack-struct (2014-02-24) 1 commit
 - hashmap.h: make sure map entries are tightly packed

 I am inclined to drop this; an alternative is to replace it with
 the "more portable" one that uses #pragma, which I am willing to
 try doing so on 'pu', though.


* po/everyday-doc (2014-01-27) 1 commit
 - Make 'git help everyday' work

 This may make the said command to emit something, but the source is
 not meant to be formatted into a manual pages to begin with, and
 also its contents are a bit stale.  It may be a good first step in
 the right direction, but needs more work to at least get the
 mark-up right before public consumption.

 Will hold.


* jk/branch-at-publish-rebased (2014-01-17) 5 commits
 - t1507 (rev-parse-upstream): fix typo in test title
 - implement @{publish} shorthand
 - branch_get: provide per-branch pushremote pointers
 - branch_get: return early on error
 - sha1_name: refactor upstream_mark

 Give an easier access to the tracking branches from "other" side in
 a triangular workflow by introducing B@{publish} that works in a
 similar way to how B@{upstream} does.

 Meant to be used as a basis for whatever Ram wants to build on.

 Will hold.


* rb/merge-prepare-commit-msg-hook (2014-01-10) 4 commits
 - merge: drop unused arg from abort_commit method signature
 - merge: make prepare_to_commit responsible for write_merge_state
 - t7505: ensure cleanup after hook blocks merge
 - t7505: add missing &&

 Expose more merge states (e.g. $GIT_DIR/MERGE_MODE) to hooks that
 run during "git merge".  The log message stresses too much on one
 hook, prepare-commit-msg, but it would equally apply to other hooks
 like post-merge, I think.

 Waiting for a reroll.


* jl/submodule-recursive-checkout (2013-12-26) 5 commits
 - Teach checkout to recursively checkout submodules
 - submodule: teach unpack_trees() to update submodules
 - submodule: teach unpack_trees() to repopulate submodules
 - submodule: teach unpack_trees() to remove submodule contents
 - submodule: prepare for recursive checkout of submodules

 Expecting a reroll.


* jc/graph-post-root-gap (2013-12-30) 3 commits
 - WIP: document what we want at the end
 - graph: remove unused code a bit
 - graph: stuff the current commit into graph->columns[]

 This was primarily a RFH ($gmane/239580).


* fc/completion (2013-12-09) 1 commit
 - completion: fix completion of certain aliases

 SZEDER G=C3=A1bor noticed that this breaks "git -c var=3Dval alias" an=
d
 also suggested a better description of the change.

 Has been stalled for a while without much comments from anybody
 interested.

 Will discard.


* mo/subtree-split-updates (2013-12-10) 3 commits
 - subtree: add --edit option
 - subtree: allow --squash and --message with push
 - subtree: support split --rejoin --squash

 Has been stalled for a while without much comments from anybody
 interested.

 Will discard.


* hv/submodule-ignore-fix (2013-12-06) 4 commits
 - disable complete ignorance of submodules for index <-> HEAD diff
 - always show committed submodules in summary after commit
 - teach add -f option for ignored submodules
 - fix 'git add' to skip submodules configured as ignored

 Teach "git add" to be consistent with "git status" when changes to
 submodules are set to be ignored, to avoid surprises after checking
 with "git status" to see there isn't any change to be further added
 and then see that "git add ." adds changes to them.

 I think a reroll is coming, so this may need to be replaced, but I
 needed some practice with heavy conflict resolution.  It conflicts
 with two changes to "git add" that have been scheduled for Git 2.0
 quite badly, and I think I got the resolution right this time.

 Waiting for a reroll.


* jc/create-directories-microopt (2013-11-11) 1 commit
 - checkout: most of the time we have good leading directories

 Of unknown value until tested on non-Linux platforms (especially
 Windows).

 Will discard.


* jt/commit-fixes-footer (2013-10-30) 1 commit
 - commit: Add -f, --fixes <commit> option to add Fixes: line

 There is an ongoing discussion around this topic; in general I am
 fairly negative on a new feature that is too narrow and prefer a
 more generic solution that can be tailored for specific needs, as
 many people stated in the thread.

 cc/interpret-trailers could be such a generic solution (although
 there don't seem to be much concensus yet).

 Will discard.


* np/pack-v4 (2013-09-18) 90 commits
 . packv4-parse.c: add tree offset caching
 . t1050: replace one instance of show-index with verify-pack
 . index-pack, pack-objects: allow creating .idx v2 with .pack v4
 . unpack-objects: decode v4 trees
 . unpack-objects: allow to save processed bytes to a buffer
 - ...

 Nico and Duy advancing the eternal vaporware pack-v4.  This is here
 primarily for wider distribution of the preview edition.

 Temporarily ejected from 'pu', to try out jk/pack-bitmap, which
 this topic conflicts with.


* mf/graph-show-root (2013-10-25) 1 commit
 . graph.c: mark root commit differently

 In a repository with multiple-roots, "log --graph", especially with
 "--oneline", does not give the reader enough visual cue to see
 where one line of history ended and a separate history began.

 This is the version that marks the roots 'x' when they would have
 been marked as '*'; Keshav Kini suggested an alternative of giving
 an extra blank line after every root, which I tend to think is a
 better approach to the problem.

 Will discard.


* tg/perf-lib-test-perf-cleanup (2013-09-19) 2 commits
 - perf-lib: add test_perf_cleanup target
 - perf-lib: split starting the test from the execution

 Add test_perf_cleanup shell function to the perf suite, that allows
 the script writers to define a test with a clean-up action.

 Will hold.


* yt/shortened-rename (2013-10-18) 2 commits
 - SQUASH??? style fixes and s/omit/shorten/ where appropriate
 - diff.c: keep arrow(=3D>) on show_stats()'s shortened filename part t=
o make rename visible

 Attempts to give more weight on the fact that a filepair represents
 a rename than showing substring of the actual path when diffstat
 lines are not wide enough.

 I am not sure if that is solving a right problem, though.

 Will discard.


* rv/send-email-cache-generated-mid (2013-08-21) 2 commits
 - git-send-email: Cache generated message-ids, use them when prompting
 - git-send-email: add optional 'choices' parameter to the ask sub

 Will discard.


* rj/read-default-config-in-show-ref-pack-refs (2013-06-17) 3 commits
 - ### DONTMERGE: needs better explanation on what config they need
 - pack-refs.c: Add missing call to git_config()
 - show-ref.c: Add missing call to git_config()

 The changes themselves are probably good, but it is unclear what
 basic setting needs to be read for which exact operation.

 Will discard, tired of waiting for clarification.
 $gmane/228294


* jc/format-patch (2013-04-22) 2 commits
 - format-patch: --inline-single
 - format-patch: rename "no_inline" field

 A new option to send a single patch to the standard output to be
 appended at the bottom of a message.  I personally have no need for
 this, but it was easy enough to cobble together.  Tests, docs and
 stripping out more MIMEy stuff are left as exercises to interested
 parties.


* jk/gitweb-utf8 (2013-04-08) 4 commits
 - gitweb: Fix broken blob action parameters on blob/commitdiff pages
 - gitweb: Don't append ';js=3D(0|1)' to external links
 - gitweb: Make feed title valid utf8
 - gitweb: Fix utf8 encoding for blob_plain, blobdiff_plain, commitdiff=
_plain, and patch

 Various fixes to gitweb.

 Drew Northup volunteered to take a look into this ($gmane/226216)
 but nothing seems to have happened since then.

 Will discard.


* jc/show-branch (2013-06-07) 5 commits
 - show-branch: use commit slab to represent bitflags of arbitrary widt=
h
 - show-branch.c: remove "all_mask"
 - show-branch.c: abstract out "flags" operation
 - show-branch.c: lift all_mask/all_revs to a global static
 - show-branch.c: update comment style

 Waiting for the final step to lift the hard-limit before sending it ou=
t.

--------------------------------------------------
[Cooking]

* jk/detect-push-typo-early (2014-03-05) 3 commits
  (merged to 'next' on 2014-03-12 at da522e7)
 + push: detect local refspec errors early
 + match_explicit_lhs: allow a "verify only" mode
 + match_explicit: hoist refspec lhs checks into their own function

 Catch "git push $there no-such-branch" early.

 Will merge to 'master'.


* jk/diff-funcname-cpp-regex (2014-03-05) 1 commit
 - diff: simplify cpp funcname regex

 Has the discussion settled on this?


* jk/doc-deprecate-grafts (2014-03-05) 1 commit
  (merged to 'next' on 2014-03-12 at 8d34916)
 + docs: mark info/grafts as outdated

 Will merge to 'master'.


* rm/strchrnul-not-strlen (2014-03-10) 1 commit
  (merged to 'next' on 2014-03-12 at fad8f12)
 + use strchrnul() in place of strchr() and strlen()

 Will merge to 'master'.


* sh/use-hashcpy (2014-03-06) 1 commit
  (merged to 'next' on 2014-03-12 at cf2735a)
 + Use hashcpy() when copying object names

 Will merge to 'master'.


* jc/no-need-for-env-in-sh-scripts (2014-03-06) 1 commit
  (merged to 'next' on 2014-03-12 at dfd3234)
 + *.sh: drop useless use of "env"

 Will merge to 'master'.


* jc/tag-contains-with (2014-03-07) 1 commit
  (merged to 'next' on 2014-03-12 at e120644)
 + tag: grok "--with" as synonym to "--contains"

 Will merge to 'master'.


* bp/commit-p-editor (2014-03-11) 8 commits
 - run-command: mark run_hook_with_custom_index as deprecated
 - merge hook tests: fix and update tests
 - merge: fix GIT_EDITOR override for commit hook
 - commit: fix patch hunk editing with "commit -p -m"
 - SQUASH???
 - test patch hunk editing with "commit -p -m"
 - merge hook tests: use 'test_must_fail' instead of '!'
 - merge hook tests: fix missing '&&' in test


* cp/am-patch-format-doc (2014-03-11) 1 commit
  (merged to 'next' on 2014-03-12 at 17c3ada)
 + Documentation/git-am: Document supported --patch-format options

 Will merge to 'master'.


* dm/configure-iconv-locale-charset (2014-03-11) 1 commit
 - configure.ac: link with -liconv for locale_charset()


* jk/clean-d-pathspec (2014-03-11) 2 commits
  (merged to 'next' on 2014-03-12 at aaae6ee)
 + clean: simplify dir/not-dir logic
 + clean: respect pathspecs with "-d"

 "git clean -d pathspec" did not use the given pathspec correctly
 and ended up cleaning too much.

 Will merge to 'master' and then later to 'maint'.


* jk/mv-submodules-fix (2014-03-11) 2 commits
 - mv: prevent mismatched data when ignoring errors.
 - builtin/mv: fix out of bounds write

 Needs tests.


* nd/upload-pack-shallow (2014-03-11) 1 commit
  (merged to 'next' on 2014-03-14 at d40b8c3)
 + upload-pack: send shallow info over stdin to pack-objects

 Will merge to 'master'.


* rs/grep-h-c (2014-03-11) 2 commits
  (merged to 'next' on 2014-03-12 at 0341bd8)
 + grep: support -h (no header) with --count
 + t7810: add missing variables to tests in loop

 "git grep" learns to handle combination of "-h (no header)" and "-c
 (counts)".

 Will merge to 'master'.


* jc/stash-pop-not-popped (2014-02-26) 1 commit
  (merged to 'next' on 2014-03-14 at 9ba1de8)
 + stash pop: mention we did not drop the stash upon failing to apply

 "stash pop", upon failing to apply the stash, refrains from
 discarding the stash to avoid information loss.  Be more explicit
 in the error message.

 The wording may want to get a bit more bikeshedding.

 Will merge to 'master'.


* bg/install-branch-config-skip-prefix (2014-03-06) 2 commits
  (merged to 'next' on 2014-03-12 at 9d04564)
 + branch: use skip_prefix() in install_branch_config()
 + t3200-branch: test setting branch as own upstream

 Will merge to 'master'.


* cn/fetch-prune-overlapping-destination (2014-02-28) 2 commits
 - fetch: handle overlaping refspecs on --prune
 - fetch: add a failing test for prunning with overlapping refspecs

 Protect refs in a hierarchy that can come from more than one remote
 hierarcies from incorrect removal by "git fetch --prune".

 Comments?


* dd/find-graft-with-sha1-pos (2014-02-27) 1 commit
  (merged to 'next' on 2014-03-12 at 0383d59)
 + commit.c: use the generic "sha1_pos" function for lookup

 Replace a hand-rolled binary search with a call to our generic
 binary search helper function.

 Will merge to 'master'.


* dd/use-alloc-grow (2014-03-03) 14 commits
  (merged to 'next' on 2014-03-12 at ed82259)
 + sha1_file.c: use ALLOC_GROW() in pretend_sha1_file()
 + read-cache.c: use ALLOC_GROW() in add_index_entry()
 + builtin/mktree.c: use ALLOC_GROW() in append_to_tree()
 + attr.c: use ALLOC_GROW() in handle_attr_line()
 + dir.c: use ALLOC_GROW() in create_simplify()
 + reflog-walk.c: use ALLOC_GROW()
 + replace_object.c: use ALLOC_GROW() in register_replace_object()
 + patch-ids.c: use ALLOC_GROW() in add_commit()
 + diffcore-rename.c: use ALLOC_GROW()
 + diff.c: use ALLOC_GROW()
 + commit.c: use ALLOC_GROW() in register_commit_graft()
 + cache-tree.c: use ALLOC_GROW() in find_subtree()
 + bundle.c: use ALLOC_GROW() in add_to_ref_list()
 + builtin/pack-objects.c: use ALLOC_GROW() in check_pbase_path()

 Replace open-coded reallocation with ALLOC_GROW() macro.

 Will merge to 'master'.


* dk/skip-prefix-scan-only-once (2014-03-03) 1 commit
  (merged to 'next' on 2014-03-14 at ff375fc)
 + skip_prefix(): scan prefix only once

 Update implementation of skip_prefix() to scan only once; given
 that most "prefix" arguments to the inline function are constant
 strings whose strlen() can be determined at the compile time, this
 might actually make things worse with a compiler with sufficient
 intelligence.

 Will merge to 'master'.


* jk/shallow-update-fix (2014-02-27) 2 commits
  (merged to 'next' on 2014-03-12 at ce5abbf)
 + shallow: automatically clean up shallow tempfiles
 + shallow: use stat_validity to check for up-to-date file

 Serving objects from a shallow repository needs to write a
 temporary file to be used, but the serving upload-pack may not have
 write access to the repository which is meant to be read-only.

 Will merge to 'master'.


* jn/branch-lift-unnecessary-name-length-limit (2014-03-05) 1 commit
  (merged to 'next' on 2014-03-12 at bd0fb0e)
 + branch.c: delete size check of newly tracked branch names

 Will merge to 'master'.


* mh/simplify-cache-tree-find (2014-03-05) 6 commits
  (merged to 'next' on 2014-03-12 at c29aa24)
 + cache_tree_find(): use path variable when passing over slashes
 + cache_tree_find(): remove early return
 + cache_tree_find(): remove redundant check
 + cache_tree_find(): fix comment formatting
 + cache_tree_find(): find the end of path component using strchrnul()
 + cache_tree_find(): remove redundant checks

 Will merge to 'master'.


* nd/tag-version-sort (2014-02-27) 1 commit
  (merged to 'next' on 2014-03-14 at 4e7f714)
 + tag: support --sort=3D<spec>

 Allow v1.9.0 sorted before v1.10.0 in "git tag --list" output.

 Will merge to 'master'.


* sh/finish-tmp-packfile (2014-03-03) 2 commits
  (merged to 'next' on 2014-03-12 at 410d45d)
 + finish_tmp_packfile():use strbuf for pathname construction
 + Merge branch 'sh/write-pack-file-warning-message-fix' into sh/finish=
-tmp-packfile

 Will merge to 'master'.


* jk/diff-filespec-cleanup (2014-02-24) 1 commit
  (merged to 'next' on 2014-03-12 at 184c2aa)
 + diffcore.h: be explicit about the signedness of is_binary

 Portability fix to a topic already in v1.9

 Will merge to 'master' and then later to 'maint'.


* jk/repack-pack-keep-objects (2014-03-03) 1 commit
  (merged to 'next' on 2014-03-12 at 3fd2335)
 + repack: add `repack.packKeptObjects` config var

 Will merge to 'master'.


* nd/sha1-file-delta-stack-leakage-fix (2014-02-24) 1 commit
  (merged to 'next' on 2014-03-12 at 9d1a621)
 + sha1_file: fix delta_stack memory leak in unpack_entry

 Fix a small leak in the delta stack used when resolving a long
 delta chain at runtime.

 Will merge to 'master' and then later to 'maint'.


* tc/commit-dry-run-exit-status-tests (2014-02-24) 1 commit
  (merged to 'next' on 2014-03-12 at b839886)
 + demonstrate git-commit --dry-run exit code behaviour


* fc/transport-helper-fixes (2014-02-24) 7 commits
  (merged to 'next' on 2014-03-12 at 5d7c69a)
 + remote-bzr: support the new 'force' option
 + test-hg.sh: tests are now expected to pass
 + transport-helper.c: do not overwrite forced bit
 + transport-helper: check for 'forced update' message
 + transport-helper: add 'force' to 'export' helpers
 + transport-helper: don't update refs in dry-run
 + transport-helper: mismerge fix

 Updates transport-helper, fast-import and fast-export to allow the
 ref mapping and ref deletion in a way similar to the natively
 supported transports.

 Will merge to 'master'.


* nd/commit-editor-cleanup (2014-02-25) 3 commits
 - commit: add --cleanup=3Dscissors
 - wt-status.c: move cut-line print code out to wt_status_add_cut_line
 - wt-status.c: make cut_line[] const to shrink .data section a bit

 "git commit --cleanup=3D<mode>" learned a new mode, scissors.

 Will merge to 'next'.


* po/git-help-user-manual (2014-02-18) 1 commit
 - Provide a 'git help user-manual' route to the docbook

 I am not sure if this is even needed.

 Will discard.


* nd/multiple-work-trees (2014-03-06) 28 commits
 - FIXUP: minimum compilation fix
 - count-objects: report unused files in $GIT_DIR/repos/...
 - gc: support prune --repos
 - gc: style change -- no SP before closing bracket
 - prune: strategies for linked checkouts
 - checkout: detach if the branch is already checked out elsewhere
 - checkout: clean up half-prepared directories in --to mode
 - checkout: support checking out into a new working directory
 - use new wrapper write_file() for simple file writing
 - wrapper.c: wrapper to open a file, fprintf then close
 - setup.c: support multi-checkout repo setup
 - setup.c: detect $GIT_COMMON_DIR check_repository_format_gently()
 - setup.c: convert check_repository_format_gently to use strbuf
 - setup.c: detect $GIT_COMMON_DIR in is_git_directory()
 - setup.c: convert is_git_directory() to use strbuf
 - git-stash: avoid hardcoding $GIT_DIR/logs/....
 - *.sh: avoid hardcoding $GIT_DIR/hooks/...
 - git-sh-setup.sh: use rev-parse --git-path to get $GIT_DIR/objects
 - Add new environment variable $GIT_COMMON_DIR
 - commit: use SEQ_DIR instead of hardcoding "sequencer"
 - fast-import: use git_path() for accessing .git dir instead of get_gi=
t_dir()
 - reflog: avoid constructing .lock path with git_path
 - *.sh: respect $GIT_INDEX_FILE
 - Make git_path() aware of file relocation in $GIT_DIR
 - path.c: group git_path(), git_pathdup() and strbuf_git_path() togeth=
er
 - path.c: rename vsnpath() to do_git_path()
 - Convert git_snpath() to strbuf_git_path()
 - path.c: make get_pathname() return strbuf instead of static buffer

 The series needs a serious review.


* ks/tree-diff-nway (2014-03-04) 19 commits
 - combine-diff: speed it up, by using multiparent diff tree-walker dir=
ectly
 - tree-diff: rework diff_tree() to generate diffs for multiparent case=
s as well
 - Portable alloca for Git
 - tree-diff: reuse base str(buf) memory on sub-tree recursion
 - tree-diff: no need to call "full" diff_tree_sha1 from show_path()
 - tree-diff: rework diff_tree interface to be sha1 based
 - tree-diff: diff_tree() should now be static
 - tree-diff: remove special-case diff-emitting code for empty-tree cas=
es
 - tree-diff: simplify tree_entry_pathcmp
 - tree-diff: show_path prototype is not needed anymore
 - tree-diff: rename compare_tree_entry -> tree_entry_pathcmp
 - tree-diff: move all action-taking code out of compare_tree_entry()
 - tree-diff: don't assume compare_tree_entry() returns -1,0,1
 - tree-diff: consolidate code for emitting diffs and recursion in one =
place
 - tree-diff: show_tree() is not needed
 - tree-diff: no need to pass match to skip_uninteresting()
 - tree-diff: no need to manually verify that there is no mode change f=
or a path
 - combine-diff: move changed-paths scanning logic into its own functio=
n
 - combine-diff: move show_log_first logic/action out of paths scanning

 Instead of running N pair-wise diff-trees when inspecting a
 N-parent merge, find the set of paths that were touched by walking
 N+1 trees in parallel.  These set of paths can then be turned into
 N pair-wise diff-tree results to be processed through rename
 detections and such.  And N=3D2 case nicely degenerates to the usual
 2-way diff-tree, which is very nice.


* nd/log-show-linear-break (2014-02-10) 1 commit
 - log: add --show-linear-break to help see non-linear history

 Attempts to show where a single-strand-of-pearls break in "git log"
 output.

 Will hold.


* tr/remerge-diff (2014-02-26) 5 commits
 . log --remerge-diff: show what the conflict resolution changed
 . name-hash: allow dir hashing even when !ignore_case
 . merge-recursive: allow storing conflict hunks in index
 . revision: fold all merge diff variants into an enum merge_diff_mode
 . combine-diff: do not pass revs->dense_combined_merges redundantly
 (this branch uses tr/merge-recursive-index-only.)

 "log -p" output learns a new way to let users inspect a merge
 commit by showing the differences between the automerged result
 with conflicts the person who recorded the merge would have seen
 and the final conflict resolution that was recorded in the merge.

 RFC.  This latest round clashes with the kb/fast-hashmap topic in
 'master'.


* lt/request-pull (2014-03-13) 6 commits
 - request-pull: documentation updates
 - request-pull: resurrect "pretty refname" feature
 - request-pull: test updates
 - request-pull: pick up tag message as before
 - request-pull: allow "local:remote" to specify names on both ends
 - request-pull: more strictly match local/remote branches

 Will merge to 'next'.


* cc/interpret-trailers (2014-03-07) 11 commits
 - Documentation: add documentation for 'git interpret-trailers'
 - trailer: add tests for commands in config file
 - trailer: execute command from 'trailer.<name>.command'
 - trailer: add tests for "git interpret-trailers"
 - trailer: add interpret-trailers command
 - trailer: put all the processing together and print
 - trailer: parse trailers from stdin
 - trailer: process command line trailer arguments
 - trailer: read and process config information
 - trailer: process trailers from stdin and arguments
 - trailers: add data structures and basic functions

 A new filter to programatically edit the tail end of the commit log
 messages.


* bl/blame-full-history (2014-01-14) 1 commit
 - blame: new option --prefer-first to better handle merged cherry-pick=
s

 By disabling the tree-same optimization (which is consistent with
 the default behaviour of "git log"-family of commands), make "git
 blame" sometimes produce different result from the original code.

 Because the "git blame" output can give result for each line from
 only one lineage of the history, however, this can be only useful
 when you are lucky---unlike "--full-history" of "git log"-family,
 where we can show commits from both lineages of histories with an
 equal weight.  See $gmane/240392 for more detailed discussion.

 Will discard.


* tr/merge-recursive-index-only (2014-02-05) 3 commits
 - merge-recursive: -Xindex-only to leave worktree unchanged
 - merge-recursive: internal flag to avoid touching the worktree
 - merge-recursive: remove dead conditional in update_stages()
 (this branch is used by tr/remerge-diff.)

 Will hold.

--------------------------------------------------
[Discarded]

* tb/repack-fix-renames (2014-02-05) 1 commit
 . repack.c: rename a few variables

 Perhaps unneeded, as the longer-term plan is to drop the codeblock
 this change touches.


* ks/diff-c-with-diff-order (2014-02-03) 5 commits
 . combine-diff: simplify intersect_paths() further
 . combine-diff: combine_diff_path.len is not needed anymore
 . combine-diff: optimize combine_diff_path sets intersection
 . diff test: add tests for combine-diff with orderfile
 . diffcore-order: export generic ordering interface

 Now part of ks/combine-diff topic.


* ks/tree-diff-more (2014-02-24) 15 commits
 - tree-diff: reuse base str(buf) memory on sub-tree recursion
 - tree-diff: no need to call "full" diff_tree_sha1 from show_path()
 - tree-diff: rework diff_tree interface to be sha1 based
 - tree-diff: remove special-case diff-emitting code for empty-tree cas=
es
 - tree-diff: simplify tree_entry_pathcmp
 - tree-diff: show_path prototype is not needed anymore
 - tree-diff: rename compare_tree_entry -> tree_entry_pathcmp
 - tree-diff: move all action-taking code out of compare_tree_entry()
 - tree-diff: don't assume compare_tree_entry() returns -1,0,1
 - tree-diff: consolidate code for emitting diffs and recursion in one =
place
 - tree-diff: show_tree() is not needed
 - tree-diff: no need to pass match to skip_uninteresting()
 - tree-diff: no need to manually verify that there is no mode change f=
or a path
 - combine-diff: move changed-paths scanning logic into its own functio=
n
 - combine-diff: move show_log_first logic/action out of paths scanning
 (this branch is used by ks/tree-diff-nway; uses ks/combine-diff.)

 Code refactoring.

 Now part of ks/tree-diff-nway.
