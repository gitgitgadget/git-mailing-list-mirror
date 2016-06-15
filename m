From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Sep 2012, #07; Fri, 21)
Date: Fri, 21 Sep 2012 12:47:10 -0700
Message-ID: <7vy5k340qp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 21 21:47:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TF9CF-000856-Qn
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 21:47:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757742Ab2IUTrW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 15:47:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55935 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932551Ab2IUTrO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 15:47:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C44919F23;
	Fri, 21 Sep 2012 15:47:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=P
	ywi3LXmYjMIjjgDeB/FDDntM+c=; b=CPcNJo8kNmTaDgpj21tb9C2NAuJI+6Dx0
	YcX66YE2NX0lvCAnNsp0G7qhpfMcuP+fs4Sj1Mkgg9Knoyr3V7VN7SOBXu0WWHoG
	q6JDd9FNvrswbtyPFK/enagbp8Nk4JKlJLvw2MnP5SdrPdClkrLXPOyvusLXwlxa
	0syxO+NbQM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=miN
	5TajCiXvvw+Tjz3iQ3kIMQDZPeXvCLjK7eTBXXPCkgw0B66qg4WF7qrs/wJMI4FG
	9AEZC6gE7J3mhQJoMBctA4mkoxVPFRXRfaoFQ3AfX+7ge2TYtdUz0az135rmN2ry
	Vk5qrVP3meMHoyMutgU2vdzfOs8Ry1ww5fQMWQE8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B131F9F22;
	Fri, 21 Sep 2012 15:47:13 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7476C9F18; Fri, 21 Sep 2012
 15:47:12 -0400 (EDT)
X-master-at: 16eed7c9938a65022010c3d95ada911b2fd46d25
X-next-at: 68bd821eac8800bddb2213d2b7e4065e3e082059
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 232AD8C2-0425-11E2-A7CA-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206154>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

Today's tip of 'pu' has breakage in t0007 for people whose shell is
not bash; a topic queued there needs to be fixed before moving
forward.

I'm planning to keep this cycle reasonably short and aim for tagging
the result as 1.8.0 at the end of 9th week, on October 21st, after
which I'd disappear for a few weeks.  http://tinyurl.com/gitCal is
where you can always find my rough tagging schedule at.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* er/doc-fast-import-done (2012-08-22) 1 commit
  (merged to 'next' on 2012-09-17 at bb8709a)
 + fast-import: document the --done option

 I got tired of waiting for ESR to respond with S-o-b for a trivial
 documentation updates, so I'll be moving this forward.


* jc/maint-log-grep-all-match (2012-09-15) 10 commits
  (merged to 'next' on 2012-09-17 at 3c10a18)
 + t7810-grep: test --all-match with multiple --grep and --author options
 + t7810-grep: test interaction of multiple --grep and --author options
 + t7810-grep: test multiple --author with --all-match
 + t7810-grep: test multiple --grep with and without --all-match
 + t7810-grep: bring log --grep tests in common form
  (merged to 'next' on 2012-09-15 at 73fad40)
 + grep.c: mark private file-scope symbols as static
  (merged to 'next' on 2012-09-14 at 86b848c)
 + log: document use of multiple commit limiting options
 + log --grep/--author: honor --all-match honored for multiple --grep patterns
 + grep: show --debug output only once
 + grep: teach --debug option to dump the parse tree

 Fix a long-standing bug in "git log --grep" when multiple "--grep"
 are used together with "--all-match" and "--author" or "--committer".


* jc/maint-log-grep-all-match-1 (2012-09-20) 1 commit
  (merged to 'next' on 2012-09-20 at 6bf192f)
 + grep.c: make two symbols really file-scope static this time

 A finishing touch to the "log --all-match --grep" topic.


* jc/make-static (2012-09-15) 14 commits
  (merged to 'next' on 2012-09-17 at 3a7d87a)
 + sequencer.c: mark a private file-scope symbol as static
 + ident.c: mark private file-scope symbols as static
 + trace.c: mark a private file-scope symbol as static
 + wt-status.c: mark a private file-scope symbol as static
 + read-cache.c: mark a private file-scope symbol as static
 + strbuf.c: mark a private file-scope symbol as static
 + sha1-array.c: mark a private file-scope symbol as static
 + symlinks.c: mark private file-scope symbols as static
 + notes.c: mark a private file-scope symbol as static
 + rerere.c: mark private file-scope symbols as static
 + graph.c: mark private file-scope symbols as static
 + diff.c: mark a private file-scope symbol as static
 + commit.c: mark a file-scope private symbol as static
 + builtin/notes.c: mark file-scope private symbols as static

 Turn many file-scope private symbols to static to reduce the
 global namespace contamination.


* mh/fetch-filter-refs (2012-09-18) 1 commit
  (merged to 'next' on 2012-09-18 at 5dd77d8)
 + string_list API: document what "sorted" means


* mv/cherry-pick-s (2012-09-14) 1 commit
  (merged to 'next' on 2012-09-14 at 2d143e1)
 + cherry-pick: don't forget -s on failure

 After "git cherry-pick -s" gave control back to the user asking
 help to resolve conflicts, concluding "git commit" needs to be run
 with "-s" if the user wants to sign it off, but people often forgot
 to do so.


* nd/fetch-status-alignment (2012-09-14) 1 commit
  (merged to 'next' on 2012-09-14 at 34237db)
 + fetch: align per-ref summary report in UTF-8 locales

 The status report from "git fetch", when messages like 'up-to-date'
 are translated, did not align the branch names well.


* pw/p4-submit-conflicts (2012-09-16) 12 commits
  (merged to 'next' on 2012-09-17 at 7e57551)
 + git-p4: add submit --conflict option and config varaiable
 + git p4: add submit --prepare-p4-only option
 + git p4: add submit --dry-run option
 + git p4: accept -v for --verbose
 + git p4: revert deleted files after submit cancel
 + git p4: rearrange submit template construction
 + git p4: test clean-up after failed submit, fix added files
 + git p4: standardize submit cancel due to unchanged template
 + git p4: move conflict prompt into run, add [q]uit input
 + git p4: remove submit failure options [a]pply and [w]rite
 + git p4: gracefully fail if some commits could not be applied
 + git p4 test: remove bash-ism of combined export/assignment

--------------------------------------------------
[New Topics]

* js/rebase-exec-command-not-found (2012-09-18) 1 commit
 - rebase -i: fix misleading error message after 'exec no-such' instruction

 Will merge to 'next'.


* rr/test-make-sure-we-have-git (2012-09-18) 1 commit
 - t/test-lib: make sure Git has already been built

 Will merge to 'next'.


* as/test-tweaks (2012-09-20) 7 commits
 - tests: paint unexpectedly fixed known breakages in bold red
 - tests: test the test framework more thoroughly
 - [SQUASH] t/t0000-basic.sh: quoting of TEST_DIRECTORY is screwed up
 - tests: refactor mechanics of testing in a sub test-lib
 - tests: paint skipped tests in bold blue
 - tests: test number comes first in 'not ok $count - $message'
 - tests: paint known breakages in bold yellow

 Various minor tweaks to the test framework to paint its output
 lines in colors that match what they mean better.

 Has the "is this really blue?" issue Peff raised resolved???


* db/doc-custom-xmlto (2012-09-19) 1 commit
 - Documentation/Makefile: Allow custom XMLTO binary

 Will merge to 'next'.


* js/hp-nonstop (2012-09-19) 1 commit
 - Port to HP NonStop
 (this branch uses js/poll-emu.)

 Will merge to 'next'.


* po/maint-docs (2012-09-19) 5 commits
 - Doc branch: show -vv option and alternative
 - Doc clean: add See Also link
 - Doc add: link gitignore
 - Doc: separate gitignore pattern sources
 - Doc: shallow clone deepens _to_ new depth

 Various documentation fixups.

 Will merge to 'next'.


* sp/maint-http-info-refs-no-retry (2012-09-20) 1 commit
 - Revert "retry request without query when info/refs?query fails"
 (this branch is used by jk/smart-http-switch.)

 Kills an old workaround for a unlikely server misconfiguration that
 hurts debuggability.

 Will merge to 'next'.


* jk/smart-http-switch (2012-09-21) 2 commits
 - remote-curl: let users turn off smart http
 - remote-curl: rename is_http variable
 (this branch uses sp/maint-http-info-refs-no-retry.)

 Will merge to 'next'.


* sp/maint-http-enable-gzip (2012-09-20) 1 commit
 - Enable info/refs gzip decompression in HTTP client

 Allows a more common 'gzip' Accept-Encoding to be used.

 Will merge to 'next'.


* nd/pretty-placeholder-with-color-option (2012-09-20) 4 commits
 - [SQUASH] do not use real-sb without initializing
 - pretty: support right alignment
 - pretty: support placeholders %C+ and %C-
 - pretty: share code between format_decoration and show_decorations

 The feature might be great, but the interface is iffy.


* jk/receive-pack-unpack-error-to-pusher (2012-09-21) 3 commits
 - receive-pack: drop "n/a" on unpacker errors
 - receive-pack: send pack-processing stderr over sideband
 - receive-pack: redirect unpack-objects stdout to /dev/null

 Send errors from "unpack-objects" and "index-pack" back to the "git
 push" over the git and smart-http protocols, just like it is done
 for a push over the ssh protocol.

 Will merge to 'next'.


* jc/blame-follows-renames (2012-09-21) 1 commit
 - git blame: document that it always follows origin across whole-file renames

--------------------------------------------------
[Stalled]

* fa/remote-svn (2012-09-19) 16 commits
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
 - Add git-remote-testsvn to Makefile
 - Implement a remote helper for svn in C
 (this branch is used by fa/vcs-svn.)

 A GSoC project.  Looked promising.
 Waiting for comments from mentors and stakeholders.


* fa/vcs-svn (2012-09-19) 4 commits
 - vcs-svn: remove repo_tree
 - vcs-svn/svndump: rewrite handle_node(), begin|end_revision()
 - vcs-svn/svndump: restructure node_ctx, rev_ctx handling
 - svndump: move struct definitions to .h
 (this branch uses fa/remote-svn.)

 A GSoC project.  Looked promising.
 Waiting for comments from mentors and stakeholders.


* ph/credential-refactor (2012-09-02) 5 commits
 - wincred: port to generic credential helper
 - Merge branch 'ef/win32-cred-helper' into ph/credential-refactor
 - osxkeychain: port to generic credential helper implementation
 - gnome-keyring: port to generic helper implementation
 - contrib: add generic credential helper

 Attempts to refactor to share code among OSX keychain, Gnome keyring
 and Win32 credential helpers.


* ms/contrib-thunderbird-updates (2012-08-31) 2 commits
 - [SQUASH] minimum fixup
 - Thunderbird: fix appp.sh format problems

 Update helper to send out format-patch output using Thunderbird.
 Seems to have design regression for silent users.


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

 Not ready.


* jc/add-delete-default (2012-08-13) 1 commit
 - git add: notice removal of tracked paths by default

 "git add dir/" updated modified files and added new files, but does
 not notice removed files, which may be "Huh?" to some users.  They
 can of course use "git add -A dir/", but why should they?

 Resurrected from graveyard, as I thought it was a worthwhile thing
 to do in the longer term.

 Waiting for comments.


* tx/relative-in-the-future (2012-08-16) 2 commits
 - date: show relative dates in the future
 - date: refactor the relative date logic from presentation

 Not my itch; rewritten an earlier submission by Tom Xue into
 somewhat more maintainable form, though it breaks existing i18n.

 Waiting for a voluteer to fix it up.
 Otherwise may discard.


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

* as/check-ignore (2012-09-21) 15 commits
 - [REROLL NEEDED] minimum compilation fix
 - Add git-check-ignore sub-command
 - dir.c: provide free_directory() for reclaiming dir_struct memory
 - pathspec.c: move reusable code from builtin/add.c
 - dir.c: refactor treat_gitlinks()
 - dir.c: keep track of where patterns came from
 - dir.c: refactor is_path_excluded()
 - dir.c: refactor is_excluded()
 - dir.c: refactor is_excluded_from_list()
 - dir.c: rename excluded() to is_excluded()
 - dir.c: rename excluded_from_list() to is_excluded_from_list()
 - dir.c: rename path_excluded() to is_path_excluded()
 - dir.c: rename cryptic 'which' variable to more consistent name
 - Improve documentation and comments regarding directory traversal API
 - Update directory listing API doc to match code

 Rerolled.
 Expecting a further reroll to follow-up review comments.


* rt/maint-clone-single (2012-09-20) 1 commit
 - clone --single: limit the fetch refspec to fetched branch

 Running "git fetch" in a repository made with "git clone --single"
 slurps all the branches, defeating the point of "--single".

 Will merge to 'next'.


* ep/malloc-check-perturb (2012-09-17) 2 commits
 - MALLOC_CHECK: various clean-ups
 - Add MALLOC_CHECK_ and MALLOC_PERTURB_ libc env to the test suite for detecting heap corruption

 Run our test scripts with MALLOC_CHECK_ and MALLOC_PERTURB_, the
 built-in memory access checking facility GNU libc has.

 Will merge to 'next'.


* aj/xfuncname-ada (2012-09-16) 1 commit
 - Add userdiff patterns for Ada

 Will merge to 'next'.


* aw/rebase-i-edit-todo (2012-09-19) 5 commits
 - rebase -i: suggest using --edit-todo to fix an unknown instruction
 - rebase -i: Add tests for "--edit-todo"
 - rebase -i: Teach "--edit-todo" action
 - rebase -i: Refactor help messages for todo file
 - rebase usage: subcommands can not be combined with -i

 Will merge to 'next'.


* jc/maint-mailinfo-mime-attr (2012-09-17) 1 commit
 - mailinfo: do not concatenate charset= attribute values from mime headers

 Will merge to 'next'.


* js/poll-emu (2012-09-17) 4 commits
 - make poll() work on platforms that can't recv() on a non-socket
 - poll() exits too early with EFAULT if 1st arg is NULL
 - fix some win32 specific dependencies in poll.c
 - make poll available for other platforms lacking it
 (this branch is used by js/hp-nonstop.)

 Will merge to 'next'.


* nd/wildmatch (2012-09-17) 5 commits
 - Support "**" in .gitignore and .gitattributes patterns using wildmatch()
 - Integrate wildmatch to git
 - compat/wildmatch: fix case-insensitive matching
 - compat/wildmatch: remove static variable force_lower_case
 - Import wildmatch from rsync

 Allows pathname patterns in .gitignore and .gitattributes files
 with double-asterisks "foo/**/bar" to match any number of directory
 hiearchies.

 It was pointed out that some symbols that do not have to be global
 are left global.
 Will wait for a reroll.


* jc/maint-name-rev (2012-09-17) 7 commits
 - describe --contains: use "name-rev --algorithm=weight"
 - name-rev --algorithm=weight: tests and documentation
 - name-rev --algorithm=weight: cache the computed weight in notes
 - name-rev --algorithm=weight: trivial optimization
 - name-rev: --algorithm option
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


* jc/xprm-generation (2012-09-14) 1 commit
 - test-generation: compute generation numbers and clock skews

 A toy to analyze how bad the clock skews are in histories of real
 world projects.


* rs/archive-zip-utf8 (2012-09-18) 4 commits
  (merged to 'next' on 2012-09-18 at 8535c83)
 + archive-zip: declare creator to be Unix for UTF-8 paths
 + archive-zip: support UTF-8 paths
 + Revert "archive-zip: support UTF-8 paths"
  (merged to 'next' on 2012-09-11 at 3b1f071)
 + archive-zip: support UTF-8 paths

 Will merge to 'master'.


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


* jk/no-more-pre-exec-callback (2012-06-05) 1 commit
 - pager: drop "wait for output to run less" hack

 (Originally merged to 'next' on 2012-07-23)

 Will defer until the end of the 2012.
 while waiting for older "less" to go extinct.
