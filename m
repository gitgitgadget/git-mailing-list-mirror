From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Aug 2012, #04; Tue, 14)
Date: Tue, 14 Aug 2012 15:05:14 -0700
Message-ID: <7va9xx86zp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 15 00:05:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1PEr-0008Ci-9q
	for gcvg-git-2@plane.gmane.org; Wed, 15 Aug 2012 00:05:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927Ab2HNWFV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 18:05:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40023 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750911Ab2HNWFS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 18:05:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A48796D5;
	Tue, 14 Aug 2012 18:05:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=v
	639Mu1sWmC/qV6DSAC9CIAoM6Y=; b=L9Vz0K4hPeEa016KEdgq0JDxnkpRpjA0u
	Cmj/jN7oButktbwPhqm+MEPqkrAujSiCcfWB9vkFYc2ceQbCLIHo261bgWDz8Awp
	684CZcLyiHPne2sAE0QBbGnHZYMSw9IYrC6dCzt+8lj5r7QDuI3d+Y2Kq6u9lQ7T
	4cyUV2HOYE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=LlJ
	XMDj9qnbTBdcJDFnSj5TzaDNo16pwiQ8OW3YEC+TZPiXyYUAln/Cy7Q/XjQynpXy
	tTsZcOWyapUNX4DyMMrRLaaFQvoeGbomi1JXKKJXRzNqvj+/e/Il7mcmnjPwFrLl
	qsthlw0lkGRLuJQ4LhXYy9XvWmwz+OSlg/OCvaUs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 45F3C96D4;
	Tue, 14 Aug 2012 18:05:17 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D9E0596D3; Tue, 14 Aug 2012
 18:05:15 -0400 (EDT)
X-master-at: 61b472ed8b090a3e9240590c85041120a54dd268
X-next-at: 4accbf693d5564e36b727349eebdbcb0d4f70a02
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 20C53C1C-E65C-11E1-AA99-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203454>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' (proposed updates) while commits prefixed with '+' are in 'next'.

Hopefully tomorrow's 1.7.12-rc3 will be the final rc before the real
thing.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* hv/submodule-path-unmatch (2012-08-14) 1 commit
 - Let submodule command exit with error status if path does not exist

As the title says.

* jc/add-delete-default (2012-08-13) 1 commit
 - git add: notice removal of tracked paths by default

"git add dir/" updated modified files and added new files, but does
not notice removed files, which may be "Huh?" to some users.  They
can of course use "git add -A dir/", but why should they?

* jc/maint-rev-list-topo-doc (2012-08-13) 1 commit
 - rev-list docs: clarify --topo-order description

Further rewording suggestions by Martin and Thomas were good, but
haven't been incorporated into this patch.

--------------------------------------------------
[Stalled]

* mz/rebase-range (2012-07-18) 7 commits
 . rebase (without -p): correctly calculate patches to rebase
 . rebase -p: don't request --left-right only to ignore left side
 . rebase -p: use --cherry-mark for todo file
 . git-rebase--interactive.sh: look up subject in add_pick_line
 . git-rebase--interactive: group all $preserve_merges code
 . git-rebase--interactive.sh: extract function for adding "pick" line
 . git-rebase--am.sh: avoid special-casing --keep-empty

Expecting a reroll.

Performance concerns from Windows folks.  Also the series lacks
proper sign-offs.

* jl/submodule-rm (2012-07-05) 2 commits
 - rm: remove submodules from the index and the .gitmodules file
 - rm: don't fail when removing populated submodules

Expecting a reroll.

* ph/stash-rerere (2012-07-08) 2 commits
 - stash: invoke rerere in case of conflict
 - test: git-stash conflict sets up rerere

Will be rerolled but is going in the right direction.

* lt/commit-tree-guess-utf-8 (2012-06-28) 1 commit
 - commit/commit-tree: correct latin1 to utf-8

Teaches "git commit" and "git commit-tree" the "we are told to use
utf-8 in log message, but this does not look like utf-8---attempt to
pass it through convert-from-latin1-to-utf8 and see if it makes
sense" heuristics "git mailinfo" already uses.

A draft from Linus received privately without a log message.
Expecting a reroll.

* mb/remote-default-nn-origin (2012-07-11) 6 commits
 - Teach get_default_remote to respect remote.default.
 - Test that plain "git fetch" uses remote.default when on a detached HEAD.
 - Teach clone to set remote.default.
 - Teach "git remote" about remote.default.
 - Teach remote.c about the remote.default configuration setting.
 - Rename remote.c's default_remote_name static variables.

When the user does not specify what remote to interact with, we
often attempt to use 'origin'.  This can now be customized via a
configuration variable.

Expecting a reroll.
"The first remote becomes the default" bit is better done as a
separate step.

* jc/split-blob (2012-04-03) 6 commits
 - chunked-object: streaming checkout
 - chunked-object: fallback checkout codepaths
 - bulk-checkin: support chunked-object encoding
 - bulk-checkin: allow the same data to be multiply hashed
 - new representation types in the packstream
 - packfile: use varint functions

Not ready.

I finished the streaming checkout codepath, but as explained in
127b177 (bulk-checkin: support chunked-object encoding, 2011-11-30),
these are still early steps of a long and painful journey. At least
pack-objects and fsck need to learn the new encoding for the series
to be usable locally, and then index-pack/unpack-objects needs to
learn it to be used remotely.

Given that I heard a lot of noise that people want large files, and
that I was asked by somebody at GitTogether'11 privately for an
advice on how to pay developers (not me) to help adding necessary
support, I am somewhat dissapointed that the original patch series
that was sent long time ago still remains here without much comments
and updates from the developer community. I even made the interface
to the logic that decides where to split chunks easily replaceable,
and I deliberately made the logic in the original patch extremely
stupid to entice others, especially the "bup" fanbois, to come up
with a better logic, thinking that giving people an easy target to
shoot for, they may be encouraged to help out. The plan is not
working :-<.

--------------------------------------------------
[Cooking]

* bc/receive-pack-stdout-protection (2012-08-06) 2 commits
  (merged to 'next' on 2012-08-07 at d7aa316)
 + receive-pack: do not leak output from auto-gc to standard output
 + t/t5400: demonstrate breakage caused by informational message from prune

When "git push" triggered the automatic gc on the receiving end, a
message from "git prune" that said it was removing cruft leaked to
the standard output, breaking the communication protocol.

Not urgent (non regression).

* bc/prune-info (2012-08-07) 1 commit
 - prune.c: only print informational message in show_only or verbose mode

Teach "git prune" without "-v" to be silent about leftover temporary files.

Not urgent (non regression).

* jc/tag-doc (2012-08-06) 1 commit
 - Documentation: do not mention .git/refs/* directories

Our documentation used to assume having files in .git/refs/*
directories was the only to have branches and tags, but that is not
true for quite some time.

Not urgent (non regression).

* jk/docs-docbook-monospace-display (2012-08-07) 1 commit
 - docs: monospace listings in docbook output

The documentation in the TeXinfo format was using indented output
for materials meant to be examples that are better typeset in
monospace.

Not urgent (non regression).

* jc/maint-protect-sh-from-ifs (2012-08-08) 1 commit
 - sh-setup: protect from exported IFS

When the user exports a non-default IFS without HT, scripts that
rely on being able to parse "ls-files -s | while read a b c..."
start to fail.  Protect them from such a misconfiguration.

* jk/check-docs-update (2012-08-08) 8 commits
 - check-docs: get documented command list from Makefile
 - check-docs: drop git-help special-case
 - check-docs: list git-gui as a command
 - check-docs: factor out command-list
 - command-list: mention git-credential-* helpers
 - command-list: add git-sh-i18n
 - check-docs: update non-command documentation list
 - check-docs: mention gitweb specially

Simplify "make check-docs" implementation and update its coverage.

* js/gitweb-path-info-unquote (2012-08-09) 1 commit
 - gitweb: URL-decode $my_url/$my_uri when stripping PATH_INFO

Stripping of PATH_INFO in gitweb did not take url style quoting into
account, failing to notice directories with funny characters e.g. SP
in their paths.

* mg/rebase-i-onto-reflog-in-full (2012-08-10) 1 commit
 - rebase -i: use full onto sha1 in reflog

The reflog entries left by "git rebase" and "git rebase -i" were
inconsistent.

* mz/empty-rebase-test (2012-08-09) 1 commit
 - add tests for 'git rebase --keep-empty'

* jc/capabilities (2012-08-13) 3 commits
 - fetch-pack: mention server version with verbose output
 - parse_feature_request: make it easier to see feature values
 - fetch-pack: do not ask for unadvertised capabilities
 (this branch uses jk/version-string.)

Some capabilities were asked by fetch-pack even when upload-pack did
not advertise that they are available.  Fix fetch-pack not to do so.

* pw/p4-use-client-spec-branch-detection (2012-08-11) 5 commits
 - git p4: make branch detection work with --use-client-spec
 - git p4: do wildcard decoding in stripRepoPath
 - git p4: set self.branchPrefixes in initialization
 - git p4 test: add broken --use-client-spec --detect-branches tests
 - git p4 test: move client_view() function to library

* jc/maint-push-refs-all (2012-08-07) 2 commits
 - get_fetch_map(): tighten checks on dest refs
 - fetch/push: allow refs/*:refs/*

Allows pushing and fetching refs/stash.

* jk/version-string (2012-08-10) 3 commits
  (merged to 'next' on 2012-08-10 at d8dcb00)
 + do not send client agent unless server does first
 + send-pack: fix capability-sending logic
  (merged to 'next' on 2012-08-09 at 64dc91b)
 + include agent identifier in capability string
 (this branch is used by jc/capabilities.)

Leftover bits from the "git version" code restructuring, that give
us an ability to expose the Git version over the wire in the
protocol exchange. But we do so carefully only to the other end that
understands it.

Not urgent (non regression).

* js/grep-patterntype-config (2012-08-03) 1 commit
  (merged to 'next' on 2012-08-09 at 1a08d6c)
 + grep: add a grep.patternType configuration setting

"grep" learned to use a non-standard pattern type by default if a
configuration variable tells it to.

Not urgent (non regression).

* mm/die-with-dashdash-help (2012-08-03) 1 commit
  (merged to 'next' on 2012-08-09 at 1aae096)
 + setup: clarify error messages for file/revisions ambiguity

Reword error messages.
Not urgent (non regression).

* tr/merge-recursive-flush (2012-08-03) 1 commit
  (merged to 'next' on 2012-08-09 at da826ec)
 + merge-recursive: eliminate flush_buffer() in favor of write_in_full()

Remove unnecessary code.
Not urgent (non regression).

* tr/void-diff-setup-done (2012-08-03) 1 commit
  (merged to 'next' on 2012-08-09 at 668a46f)
 + diff_setup_done(): return void

Remove unnecessary code.
Not urgent (non regression).

* mk/test-seq (2012-08-04) 1 commit
  (merged to 'next' on 2012-08-06 at 3f6917c)
 + tests: Introduce test_seq
 (this branch is used by ab/diff-write-incomplete-line.)

Add a compatibility/utility function to the test framework. 

Not urgent (non regression).

* ab/diff-write-incomplete-line (2012-08-05) 1 commit
  (merged to 'next' on 2012-08-07 at dcf02ae)
 + Fix '\ No newline...' annotation in rewrite diffs
 (this branch uses mk/test-seq.)

The output from "git diff -B" for a file that ends with an
incomplete line did not put "\ No newline..." on a line of its own.

Not urgent (non regression).

* pg/maint-apply-remove-unused-variable (2012-08-05) 1 commit
  (merged to 'next' on 2012-08-05 at aa9f5e9)
 + apply: delete unused deflate_origlen from patch struct

Remove unused field.
Not urgent (non regression).

* tg/index-v5 (2012-08-09) 15 commits
 - fixup! Read index-v5
 - fixup! update-index.c: always rewrite the index when index-version is given
 - p0002-index.sh: add perf test for the index formats
 - update-index.c: always rewrite the index when index-version is given
 - Write resolve-undo data for index-v5
 - Write index-v5 cache-tree data
 - Write index-v5
 - Read cache-tree in index-v5
 - Read resolve-undo data
 - Read index-v5
 - Make in-memory format aware of stat_crc
 - Add documentation of the index-v5 file format
 - t3700: Avoid interfering with the racy code
 - t2104: Don't fail for index versions other than [23]
 - Move index v2 specific functions to their own file

A GSoC project, queued here primarily to give people an easier
access to the state of the last posted version, plus trivial
fixups.

* nd/index-errno (2012-08-06) 1 commit
  (merged to 'next' on 2012-08-06 at a9f2101)
 + read_index_from: remove bogus errno assignments

Assignments to errno before calling system functions that used to
matter in the old code were left behind after the code structure
changed sufficiently to make them useless.

Not urgent (non regression).

* jc/maint-sane-execvp-notdir (2012-07-31) 1 commit
  (merged to 'next' on 2012-08-09 at 5dd4240)
 + sane_execvp(): ignore non-directory on $PATH

"git foo" errored out with "Not a directory" when the user had a non
directory on $PATH, and worse yet it masked an alias "foo" to run.

Not urgent (non regression).

* jc/sanitize-nkd-lazy-iconv-open (2012-07-31) 1 commit
  (merged to 'next' on 2012-08-09 at 832c238)
 + macos: lazily initialize iconv

Teach the code that works around NKD/NKC gotcha on MacOS to call
iconv_open() only when it is necessary, in the hope of avoiding
set-up overhead.

Not urgent (non regression).

* tr/maint-send-email-2047 (2012-07-31) 1 commit
  (merged to 'next' on 2012-08-09 at 17dfe57)
 + send-email: improve RFC2047 quote parsing

"git send-email" did not unquote encoded words that appear on the
header correctly, and lost "_" from strings.

Not urgent (non regression).

* cw/cherry-pick-allow-empty-message (2012-08-06) 1 commit
  (merged to 'next' on 2012-08-09 at eab95f6)
 + cherry-pick: add --allow-empty-message option

"git cherry-pick" by default stops when it sees a commit without any
log message.  The "--allow-empty-message" option can be used to
silently proceed.

Not urgent (non regression).

* ms/git-svn-1.7 (2012-08-02) 20 commits
 - git-svn: remove ad-hoc canonicalizations
 - git-svn: canonicalize newly-minted URLs
 - git-svn: introduce add_path_to_url function
 - git-svn: canonicalize earlier
 - git-svn: replace URL escapes with canonicalization
 - git-svn: attempt to mimic SVN 1.7 URL canonicalization
 - t9107: fix typo
 - t9118: workaround inconsistency between SVN versions
 - Git::SVN{,::Ra}: canonicalize earlier
 - git-svn: path canonicalization uses SVN API
 - Git::SVN::Utils: remove irrelevant comment
 - git-svn: add join_paths() to safely concatenate paths
 - git-svn: factor out _collapse_dotdot function
 - git-svn: use SVN 1.7 to canonicalize when possible
 - git-svn: move canonicalization to Git::SVN::Utils
 - use Git::SVN{,::RA}->url accessor globally
 - use Git::SVN->path accessor globally
 - Git::SVN::Ra: use accessor for URLs
 - Git::SVN: use accessor for URLs internally
 - Git::SVN: use accessors internally for path

A series by Michael Schwern via Eric to update git-svn to revamp the
way URLs are internally passed around, to make it work with SVN 1.7.

* jc/maint-t7406-rev-parse-max-count-huh (2012-07-30) 1 commit
  (merged to 'next' on 2012-07-30 at 9b27acc)
 + t7406: fix misleading "rev-parse --max-count=1 HEAD"

Test clean-up, with no behaviour change.
Not urgent (non regression).

* jk/maint-diff-nul40-as-sentinel (2012-07-29) 1 commit
 + diff: do not use null sha1 as a sentinel value
 (this branch is used by jk/maint-null-in-trees.)

"git diff" had a confusion between taking data from a path in the
working tree and taking data from an object that happens to have
name 0{40} recorded in a tree.
Not urgent (non regression).

* mz/cherry-code-cleanup (2012-07-29) 3 commits
 - cherry: remove redundant check for merge commit
 - cherry: don't set ignored rev_info options
 - remove unnecessary parameter from get_patch_ids()

Minor code clean-up on the cherry-pick codepath.
Not urgent (non regression).

* jc/maint-config-exit-status (2012-07-30) 1 commit
  (merged to 'next' on 2012-07-30 at 8392da9)
 + config: "git config baa" should exit with status 1

The exit status code from "git config" was way overspecified while
being incorrect.  Update the implementation to give the documented
status for a case that was documented, and introduce a new code for
"all other errors".

Not urgent (non regression).

* jk/maint-null-in-trees (2012-07-29) 2 commits
  (merged to 'next' on 2012-07-30 at 771c497)
 + fsck: detect null sha1 in tree entries
 + do not write null sha1s to on-disk index
 (this branch uses jk/maint-diff-nul40-as-sentinel.)

We do not want a link to 0{40} object stored anywhere in our objects.

Not urgent (non regression).

* sz/submodule-force-update (2012-07-25) 1 commit
  (merged to 'next' on 2012-07-26 at 3bda2be)
 + Make 'git submodule update --force' always check out submodules.

We may want a documentation update and a few tests on top.

Not urgent (non regression).

* jc/test-prereq (2012-08-04) 8 commits
  (merged to 'next' on 2012-08-04 at 6dd9156)
 + fixup! t3910: use the UTF8_NFD_TO_NFC test prereq
  (merged to 'next' on 2012-07-30 at b7c6949)
 + t3910: use the UTF8_NFD_TO_NFC test prereq
  (merged to 'next' on 2012-07-27 at 448cbbc)
 + test-lib: provide UTF8 behaviour as a prerequisite
 + t0050: use the SYMLINKS test prereq
 + t0050: use the CASE_INSENSITIVE_FS test prereq
 + test-lib: provide case insensitivity as a prerequisite
 + test: allow prerequisite to be evaluated lazily
 + test: rename $satisfied to $satisfied_prereq

Teaches the test framework to probe rarely used prerequistes lazily,
and make use of it for detecting SYMLINKS, CASE_INSENSITIVE_FS and
NKD/NKC MacOS x gotcha.

Not urgent (non regression).

* da/difftool-updates (2012-08-10) 12 commits
  (merged to 'next' on 2012-08-10 at 4accbf6)
 + Add Code Compare v2.80.4 as a merge / diff tool for Windows
 + mergetool,difftool: Document --tool-help consistently
  (merged to 'next' on 2012-07-26 at 3263461)
 + difftool: Disable --symlinks on cygwin
 + difftool: Handle compare() returning -1
 + difftool: Wrap long lines for readability
 + difftool: Check all return codes from compare()
 + difftool: Handle finding mergetools/ in a path with spaces
  (merged to 'next' on 2012-07-23 at 96528a7)
 + difftool: Use symlinks when diffing against the worktree
 + difftool: Call the temp directory "git-difftool"
 + difftool: Move option values into a hash
 + difftool: Eliminate global variables
 + difftool: Simplify print_tool_help()

"git difftool --dir-diff" learned to use symbolic links to prepare
temporary copy of the working tree when available.

Not urgent (non regression).

* jk/no-more-pre-exec-callback (2012-06-05) 1 commit
  (merged to 'next' on 2012-07-23 at fe59cb6)
 + pager: drop "wait for output to run less" hack

Will defer for 6 months until ancient "less" goes extinct.

* mm/push-default-switch-warning (2012-06-24) 1 commit
  (merged to 'next' on 2012-06-26 at fea512a)
 + push: start warning upcoming default change for push.default

Will defer for another cycle.
