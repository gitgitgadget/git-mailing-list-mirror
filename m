From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Sep 2012, #04; Tue, 11)
Date: Tue, 11 Sep 2012 13:25:26 -0700
Message-ID: <7v4nn4gvd5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 11 22:25:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBX1h-0007Pz-NU
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 22:25:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753581Ab2IKUZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Sep 2012 16:25:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45175 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751329Ab2IKUZa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Sep 2012 16:25:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2AFD795CE;
	Tue, 11 Sep 2012 16:25:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=D
	QygwOGz4luVDbQAONA5g0AtlQY=; b=ZAZxNhUMjqq6ek/IJYs+5u1E3QwSknmQp
	yVl0SxrJVsoTlblv1oW+iiyDG+OyWHvNpalxQ3d0BUtHM2KoqSwuf3IVw16ZE7F6
	LCMrkDMBg41SfDLmDHj3jmmQM18aIZgTzlbFmEMvySQejlwZP9dqpd9E/RAR2PXv
	uTyxlQ7f1E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=HUS
	NdRL+xXt3lKQ7aUvrJL50qqJ+Uqe6mRkAn6sNfgI2xGF3msvr/uO6IT8ewxHyEP0
	JRWuvnB8kpcbIaD+JLyRrCEx/sfm8ln6nGG8BqeOwh6BWiIlhyd9vCKVrso5iZ/E
	FIoomsfCoU2d8KkJ05EbHl6ngobf89eETRxbIwkg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 10FC395CC;
	Tue, 11 Sep 2012 16:25:29 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D056195CA; Tue, 11 Sep 2012
 16:25:27 -0400 (EDT)
X-master-at: 53284de77712b2234c739afa3aa5f024fc89fc83
X-next-at: 3d3ef136b706abc4576b503995d88da2409d0bcf
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D32FE25A-FC4E-11E1-940D-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205265>

[administrivia]

Yeah, I know it is a bit too early, and I usually try to keep these
twice a week at most, but because I've tagged a maintenance release
today, so...

What's cooking in git.git (Sep 2012, #04; Tue, 11)
--------------------------------------------------

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' (proposed updates) while commits prefixed with '+' are in 'next'.

The fifth batch of topics have graduated to 'master'.  Many fixes
that are already in 'master' have been merged to v1.7.11.6.  'maint'
has acquired more such fixes and will be tagged as v1.7.12.1
hopefully in a few days.

I'm planning to keep this cycle reasonably short and aim for tagging
the result as 1.8.0 at the end of 9th week, on October 21st, after
which I'd disappear for a few weeks.  http://tinyurl.com/gitCal is
where you can always find my rough tagging schedule at.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* dg/run-command-child-cleanup (2012-09-11) 1 commit
 - run-command.c: fix broken list iteration in clear_child_for_cleanup

Will merge to 'next' after obtaining a Sign-off.

* jc/maint-blame-no-such-path (2012-09-10) 1 commit
 - blame $path: avoid getting fooled by case insensitive filesystems

"git blame MAKEFILE" run in a history that has "Makefile" but not
"MAKEFILE" should say "No such file MAKEFILE in HEAD", but got
confused on a case insensitive filesystem.

* sl/autoconf (2012-09-11) 2 commits
 - build: don't duplicate substitution of make variables
 - build: improve GIT_CONF_SUBST signature

* cn/branch-set-upstream-to (2012-09-11) 2 commits
 - completion: complete branch name for "branch --set-upstream-to="
 - completion: add --set-upstream-to and --unset-upstream

Will merge to 'next'.

--------------------------------------------------
[Graduated to "master"]

* jc/maint-ident-missing-human-name (2012-08-31) 1 commit
  (merged to 'next' on 2012-09-07 at 0e99b20)
 + split_ident_line(): make best effort when parsing author/committer line

"git show --format='%ci'" did not give timestamp correctly for
commits created without human readable name on "committer" line.

* jc/merge-bases (2012-08-31) 9 commits
  (merged to 'next' on 2012-09-07 at ab0974d)
 + reduce_heads(): reimplement on top of remove_redundant()
 + merge-base: "--is-ancestor A B"
 + get_merge_bases_many(): walk from many tips in parallel
 + in_merge_bases(): use paint_down_to_common()
 + merge_bases_many(): split out the logic to paint history
 + in_merge_bases(): omit unnecessary redundant common ancestor reduction
 + http-push: use in_merge_bases() for fast-forward check
 + receive-pack: use in_merge_bases() for fast-forward check
 + in_merge_bases(): support only one "other" commit

Optimise the "merge-base" computation a bit, and also update its
users that do not need the full merge-base information to call a
cheaper subset.

* jk/argv-array (2012-09-02) 4 commits
  (merged to 'next' on 2012-09-07 at 98dbd14)
 + submodule: use argv_array instead of hand-building arrays
 + fetch: use argv_array instead of hand-building arrays
 + argv-array: fix bogus cast when freeing array
 + argv-array: add pop function
 (this branch is used by dj/fetch-all-tags.)

Use argv-array API in "git fetch" implementation.

* nd/i18n-index-pack (2012-08-31) 1 commit
  (merged to 'next' on 2012-09-07 at bbcece1)
 + i18n: mark more index-pack strings for translation

* rj/test-regex (2012-09-02) 1 commit
  (merged to 'next' on 2012-09-07 at e7e3527)
 + test-regex: Add a test to check for a bug in the regex routines

Git ships with a fall-back regexp implementation for platforms with
buggy regexp library; give people a tool to see if they should be
using it on their platform.

--------------------------------------------------
[Stalled]

* ph/credential-refactor (2012-09-02) 5 commits
 - wincred: port to generic credential helper
 - Merge branch 'ef/win32-cred-helper' into ph/credential-refactor
 - osxkeychain: port to generic credential helper implementation
 - gnome-keyring: port to generic helper implementation
 - contrib: add generic credential helper

Attempts to refactor to share code among OSX keychain, Gnome keyring
and Win32 credential helpers.

* jc/maint-name-rev (2012-09-04) 7 commits
 - describe --contains: use "name-rev --weight"
 - name-rev --weight: tests and documentation
 - name-rev --weight: cache the computed weight in notes
 - name-rev --weight: trivial optimization
 - name-rev: --weight option
 - name_rev: clarify the logic to assign a new tip-name to a commit
 - name-rev: lose unnecessary typedef

"git name-rev" names the given revision based on a ref that can be
reached in the smallest number of steps from the rev, but that is
not useful when the caller wants to know which tag is the oldest one
that contains the rev.  This teaches a new mode to the command that
uses the oldest ref among those which contain the rev.

I am not sure if this is worth it; for one thing, even with the help
from notes-cache, it seems to make the "describe --contains" even
slower. Also the command will be unusably slow for a user who does
not have a write access (hence unable to create or update the
notes-cache).

Needs another round to at least find a better name for the option,
and possibly a cheaper but still better than the current "close to
the tip" heuristics.

* ms/contrib-thunderbird-updates (2012-08-31) 2 commits
 - [SQUASH] minimum fixup
 - Thunderbird: fix appp.sh format problems

Update helper to send out format-patch output using Thunderbird.
Seems to have design regression for silent users.

* as/check-ignore (2012-09-02) 10 commits
 . fixup: decl-after-stmt etc.
 . Add git-check-ignore
 . Provide free_directory() for reclaiming dir_struct memory
 . Extract some useful pathspec handling code from builtin/add.c into a library
 . For each exclude pattern, store information about where it came from
 . dir.c: refactor excluded() and path_excluded()
 . dir.c: refactor excluded_from_list()
 . dir.c: rename cryptic 'which' variable to more consistent name
 . Improve documentation and comments regarding directory traversal API
 . Update directory listing API doc to match code

Will be rerolled.

* jx/test-real-path (2012-08-27) 1 commit
 - test: set the realpath of CWD as TRASH_DIRECTORY

Running tests with the "trash" directory elsewhere with the "--root"
option did not work well if the directory was specified by a symbolic
link pointing at it.

Seems broken as it makes $(pwd) and TRASH_DIRECTORY inconsistent.
Needs rerolling.

* jc/maint-push-refs-all (2012-08-27) 2 commits
 - get_fetch_map(): tighten checks on dest refs
 - [BROKEN] fetch/push: allow refs/*:refs/*

Allows pushing and fetching everything including refs/stash.
This is broken (see the log message there).

* er/doc-fast-import-done (2012-08-22) 1 commit
 - fast-import: document the --done option

Parked in 'pu' in case ESR responds with "Sorry, forgot to sign-off".

* jc/add-delete-default (2012-08-13) 1 commit
 - git add: notice removal of tracked paths by default

"git add dir/" updated modified files and added new files, but does
not notice removed files, which may be "Huh?" to some users.  They
can of course use "git add -A dir/", but why should they?

Resurrected from graveyard, as I thought it was a worthwhile thing
to do in the longer term; waiting for comments.

* tx/relative-in-the-future (2012-08-16) 2 commits
 - date: show relative dates in the future
 - date: refactor the relative date logic from presentation

Not my itch; rewritten an earlier submission by Tom Xue into
somewhat more maintainable form, though it breaks existing i18n.

Anybody interested in fixing it up?  Otherwise may discard.

* tg/index-v5 (2012-08-17) 13 commits
 . p0002-index.sh: add perf test for the index formats
 . update-index.c: rewrite index when index-version is given
 . Write resolve-undo data for index-v5
 . Write index-v5 cache-tree data
 . Write index-v5
 . Read cache-tree in index-v5
 . Read resolve-undo data
 . Read index-v5
 . Make in-memory format aware of stat_crc
 . Add documentation of the index-v5 file format
 . t2104: Don't fail for index versions other than [23]
 . read-cache.c: Re-read index if index file changed
 . Move index v2 specific functions to their own file

A GSoC project.  Was waiting for comments from mentors and
stakeholders, but nothing seems to be happening, other than breakage
fixes on Cygwin.  May discard.

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

* jc/ll-merge-binary-ours (2012-09-08) 2 commits
 - attr: "binary" attribute should choose built-in "binary" merge driver
 - merge: teach -Xours/-Xtheirs to binary ll-merge driver

"git merge -Xtheirs" did not help content-level merge of binary
files; it should just take their version.  Also "*.jpg binary" in
the attributes did not imply they should use the binary ll-merge
driver.

Will merge to 'next'.

* jc/mailinfo-RE (2012-09-09) 1 commit
 - mailinfo: strip "RE: " prefix

We strip the prefix from "Re: subject" and also from a less common
"re: subject", but left even less common "RE: subject" intact.

Will merge to 'next'.

* js/compat-mkdir (2012-09-08) 1 commit
  (merged to 'next' on 2012-09-11 at 376b3d5)
 + Document MKDIR_WO_TRAILING_SLASH in Makefile

Finishing touches to recently added wrapper for mkdir() that do not
want to see trailing slashes.

Will merge to 'master' as part of the sixth batch.

* mh/string-list (2012-09-10) 6 commits
 - api-string-list.txt: initialize the string_list the easy way
 - string_list: add a function string_list_longest_prefix()
 - string_list: add a new function, string_list_remove_duplicates()
 - string_list: add a new function, filter_string_list()
 - string_list: add two new functions for splitting strings
 - string_list: add function string_list_append_nodup()
 (this branch is used by mh/fetch-filter-refs.)

Looked sensible.
Will merge to 'next'.

* pw/p4-submit-conflicts (2012-09-10) 12 commits
 - git-p4: add submit --conflict option and config varaiable
 - git p4: add submit --prepare-p4-only option
 - git p4: add submit --dry-run option
 - git p4: accept -v for --verbose
 - git p4: revert deleted files after submit cancel
 - git p4: rearrange submit template construction
 - git p4: test clean-up after failed submit, fix added files
 - git p4: standardize submit cancel due to unchanged template
 - git p4: move conflict prompt into run, add [q]uit input
 - git p4: remove submit failure options [a]pply and [w]rite
 - git p4: gracefully fail if some commits could not be applied
 - git p4 test: remove bash-ism of combined export/assignment

Rerolled.
Waiting for comments.

* kd/cvsimport-avoid-invalid-tag (2012-09-06) 1 commit
  (merged to 'next' on 2012-09-11 at 6a8f834)
 + cvsimport: strip all inappropriate tag strings

"cvsimport" tried to create a tag taken from CVS without
sufficiently sanitizing it, causing the import to fail when an
invalid character in the tagname made underlying "git tag" to fail.

Will merge to 'master' as part of the sixth batch.

* mh/abspath (2012-09-10) 9 commits
  (merged to 'next' on 2012-09-11 at 5e29b53)
 + t0060: split absolute path test in two to exercise some of it on Windows
 + t0060: verify that real_path() removes extra slashes
 + real_path(): properly handle nonexistent top-level paths
 + t0060: verify that real_path() works correctly with absolute paths
 + real_path(): reject the empty string
 + t0060: verify that real_path() fails if passed the empty string
 + absolute_path(): reject the empty string
 + t0060: verify that absolute_path() fails if passed the empty string
 + t0060: move tests of real_path() from t0000 to here

Will merge to 'master' as part of the sixth batch.

* nd/i18n-status (2012-09-06) 1 commit
  (merged to 'next' on 2012-09-11 at 7cfa224)
 + status: remove i18n legos

Will merge to 'master' as part of the sixth batch.

* nd/log-n-doc (2012-09-06) 1 commit
  (merged to 'next' on 2012-09-11 at 7fba349)
 + doc: move rev-list option -<n> from git-log.txt to rev-list-options.txt

Will merge to 'master' as part of the sixth batch.

* nd/maint-remote-remove (2012-09-06) 1 commit
  (merged to 'next' on 2012-09-11 at b1564c3)
 + remote: prefer subcommand name 'remove' to 'rm'

Will merge to 'master' as part of the sixth batch.

* sb/send-email-reconfirm-fix (2012-09-06) 1 commit
  (merged to 'next' on 2012-09-11 at f868e60)
 + send-email: initial_to and initial_reply_to are both optional

Will merge to 'master' as part of the sixth batch.

* sn/ls-remote-get-url-doc (2012-09-07) 1 commit
  (merged to 'next' on 2012-09-11 at 9d09780)
 + ls-remote: document the '--get-url' option

Will merge to 'master' as part of the sixth batch.

* dj/fetch-all-tags (2012-09-07) 1 commit
  (merged to 'next' on 2012-09-11 at 083a029)
 + fetch --all: pass --tags/--no-tags through to each remote

"git fetch --all", when passed "--no-tags", did not honor the
"--no-tags" option while fetching from individual remotes (the same
issue existed with "--tags", but combination "--all --tags" makes
much less sense than "--all --no-tags").

Will merge to 'master' as part of the sixth batch.

* rj/tap-fix (2012-09-02) 6 commits
  (merged to 'next' on 2012-09-11 at 4104358)
 + test-lib.sh: Suppress the "passed all ..." message if no tests run
 + test-lib.sh: Add check for invalid use of 'skip_all' facility
 + test-lib.sh: Fix some shell coding style violations
 + t4016-*.sh: Skip all tests rather than each test
 + t3902-*.sh: Skip all tests rather than each test
 + t3300-*.sh: Fix a TAP parse error

Will merge to 'master' as part of the sixth batch.

* jc/maint-checkout-fileglob-doc (2012-09-10) 3 commits
  (merged to 'next' on 2012-09-11 at 929948d)
 + gitcli: contrast wildcard given to shell and to git
 + gitcli: formatting fix
 + Document file-glob for "git checkout -- '*.c'"

Updated with help from Peff.

Will merge to 'master' as part of the sixth batch.

* jc/xprm-generation (2012-09-04) 1 commit
 - test-generation: compute generation numbers and clock skews

* rj/path-cleanup (2012-09-04) 5 commits
  (merged to 'next' on 2012-09-11 at 9e8da84)
 + Call mkpathdup() rather than xstrdup(mkpath(...))
 + Call git_pathdup() rather than xstrdup(git_path("..."))
 + path.c: Use vsnpath() in the implementation of git_path()
 + path.c: Don't discard the return value of vsnpath()
 + path.c: Remove the 'git_' prefix from a file scope function

Will merge to 'master' as part of the sixth batch.

* rs/archive-zip-utf8 (2012-09-04) 1 commit
  (merged to 'next' on 2012-09-11 at 3b1f071)
 + archive-zip: support UTF-8 paths

Need help from people on platforms on which Zip matters to see
compatiblity with other people's zip implementations.

Will merge to 'master' as part of the sixth batch.

* nd/checkout-option-parsing-fix (2012-09-11) 3 commits
  (merged to 'next' on 2012-09-11 at 3d3ef13)
 + checkout: reorder option handling
 + checkout: move more parameters to struct checkout_opts
 + checkout: pass "struct checkout_opts *" as const pointer

The option parsing of "git checkout" had error checking, dwim and
defaulting missing options, all mixed in the code, and issuing an
appropriate error message with useful context was getting harder.
Reorganize the code and allow giving a proper diagnosis when the
user says "git checkout -b -t foo bar" (e.g. "-t" is not a good name
for a branch).

Will merge to 'master' as part of the sixth batch.

* js/compat-itimer (2012-09-08) 1 commit
  (merged to 'next' on 2012-09-11 at 1f6c3a9)
 + Add a no-op setitimer() wrapper

Pieces to support compilation on __TANDEM.

Will merge to 'master' as part of the sixth batch.

* mh/fetch-filter-refs (2012-09-10) 14 commits
 - fetch-pack: eliminate spurious error messages
 - cmd_fetch_pack(): simplify computation of return value
 - fetch-pack: report missing refs even if no existing refs were received
 - cmd_fetch_pack(): return early if finish_connect() fails
 - filter_refs(): simplify logic
 - filter_refs(): build refs list as we go
 - filter_refs(): delete matched refs from sought list
 - fetch_pack(): update sought->nr to reflect number of unique entries
 - filter_refs(): do not check the same sought_pos twice
 - Change fetch_pack() and friends to take string_list arguments
 - fetch_pack(): reindent function decl and defn
 - Rename static function fetch_pack() to http_fetch_pack()
 - t5500: add tests of fetch-pack --all --depth=N $URL $REF
 - t5500: add tests of error output for missing refs
 (this branch uses mh/string-list.)

Code simplification and clarification.

Will merge to 'next'.

* jl/submodule-rm (2012-08-27) 1 commit
 - Teach rm to remove submodules unless they contain a git directory

"git rm submodule" cannot blindly remove a submodule directory as
its working tree may have local changes, and worse yet, it may even
have its repository embedded in it.  Teach it some special cases
where it is safe to remove a submodule, specifically, when there is
no local changes in the submodule working tree, and its repository
is not embedded in its working tree but is elsewhere and uses the
gitfile mechanism to point at it.

Replacement sent but was still iffy around conflicted merge cases.

* fa/remote-svn (2012-08-28) 16 commits
 - Add a test script for remote-svn
 - remote-svn: add marks-file regeneration
 - Add a svnrdump-simulator replaying a dump file for testing
 - remote-svn: add incremental import
 - remote-svn: Activate import/export-marks for fast-import
 - Create a note for every imported commit containing svn metadata
 - vcs-svn: add fast_export_note to create notes
 - Allow reading svn dumps from files via file:// urls
 - remote-svn, vcs-svn: Enable fetching to private refs
 - When debug==1, start fast-import with "--stats" instead of "--quiet"
 - Add documentation for the 'bidi-import' capability of remote-helpers
 - Connect fast-import to the remote-helper via pipe, adding 'bidi-import' capability
 - Add argv_array_detach and argv_array_free_detached
 - Add svndump_init_fd to allow reading dumps from arbitrary FDs
 - Add git-remote-testsvn to Makefile and .gitignore
 - Implement a remote helper for svn in C
 (this branch is used by fa/vcs-svn.)

A GSoC project.  Looked promising.
Waiting for comments from mentors and stakeholders.

* fa/vcs-svn (2012-08-28) 4 commits
 - vcs-svn: remove repo_tree
 - vcs-svn/svndump: rewrite handle_node(), begin|end_revision()
 - vcs-svn/svndump: restructure node_ctx, rev_ctx handling
 - svndump: move struct definitions to .h
 (this branch uses fa/remote-svn.)

A GSoC project.  Looked promising.
Waiting for comments from mentors and stakeholders.

* jk/no-more-pre-exec-callback (2012-06-05) 1 commit
 - pager: drop "wait for output to run less" hack

(Originally merged to 'next' on 2012-07-23)

Will defer until the end of the 2012.
while waiting for older "less" to go extinct.
