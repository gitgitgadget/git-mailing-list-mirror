From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Sep 2012, #08; Mon, 24)
Date: Mon, 24 Sep 2012 14:30:02 -0700
Message-ID: <7vhaqnxg6d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 24 23:30:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGGEQ-0007dM-F6
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 23:30:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946Ab2IXVaL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 17:30:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59768 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750824Ab2IXVaI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 17:30:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4702192CE;
	Mon, 24 Sep 2012 17:30:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=1
	tUgJLOeFwAOoH5I9SrmHlY3Uu0=; b=WK3RvWEFRSB0P2bUOteTuUc1zJLo7GZqV
	zkrOuRrD3Qy0q8TgNSt8VhhPinbwNpaMOObDiXExGfRtmZYIh2Q1ng2TxH3vw1Q5
	YL711Q2oq3VvO7+DrRZlw88S7rsJdnCfSTZbFKiw1GTPvyBeu5wzr9sxQC201P/z
	f1uFAo7ZzM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=XPF
	jhZwWodpxy9m4qM4N95tl8dSfB/BUyQRn6OtMjY/uulixMWWLHgi3yN0tTsR6JME
	iEYNNkD7DDV7ArAF9sn5gKESd9d2ZdB31JoRyJ4p2TUdKAKJU24cc7dVfj99Bli7
	FEYggIidmwssn6pyQbNdtCaweJZDRi47EHGvaE8Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1DF1892CD;
	Mon, 24 Sep 2012 17:30:07 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9FD2992CA; Mon, 24 Sep 2012
 17:30:04 -0400 (EDT)
X-master-at: b5d156c3622fa522966034c78fd6ed9a15504d46
X-next-at: 95625d7562adfba98aa40d9772312bb3c2d92b7f
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 01542638-068F-11E2-85E3-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206330>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

Feedback from contributors and reviewers involved in topics in the
"stalled" category is sorely needed to help them get unstuck (I
added some of them to Bcc).

I'm planning to keep this cycle reasonably short and aim for tagging
the result as 1.8.0 at the end of 9th week, on October 21st, after
which I'd disappear for a few weeks.  http://tinyurl.com/gitCal is
where you can always find my rough tagging schedule at.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* jc/blame-no-follow (2012-09-21) 2 commits
 - blame: pay attention to --no-follow
 - diff: accept --no-follow option
 (this branch uses jc/blame-follows-renames.)

 Teaches "--no-follow" option to "git blame" to disable its
 whole-file rename detection.

 Any comments?


* os/commit-submodule-ignore (2012-09-24) 1 commit
 - commit: pay attention to submodule.$name.ignore in .gitmodules

 "git status" honored the ignore=dirty settings in .gitmodules but
 "git commit" didn't.


* rc/maint-complete-git-p4 (2012-09-24) 1 commit
 - Teach git-completion about git p4

 Will merge to 'next'.


* rr/maint-submodule-unknown-cmd (2012-09-24) 2 commits
 - [SQUASH] adjust test and doc to "git submodule no-such-subcommand"
 - submodule: if $command was not matched, don't parse other args

 Will merge to 'next' after squashing the tip.

--------------------------------------------------
[Stalled]

* as/check-ignore (2012-09-24) 16 commits
 - [SQUASH-FIX] 283d072 (Add git-check-ignore sub-command, 2012-09-20)
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

 A GSoC project.
 Waiting for comments from mentors and stakeholders.


* fa/vcs-svn (2012-09-19) 4 commits
 - vcs-svn: remove repo_tree
 - vcs-svn/svndump: rewrite handle_node(), begin|end_revision()
 - vcs-svn/svndump: restructure node_ctx, rev_ctx handling
 - svndump: move struct definitions to .h
 (this branch uses fa/remote-svn.)

 A GSoC project.
 Waiting for comments from mentors and stakeholders.


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

* js/rebase-exec-command-not-found (2012-09-18) 1 commit
  (merged to 'next' on 2012-09-24 at ed5b048)
 + rebase -i: fix misleading error message after 'exec no-such' instruction

 Will merge to 'master'.


* rr/test-make-sure-we-have-git (2012-09-18) 1 commit
  (merged to 'next' on 2012-09-24 at 9e8d28d)
 + t/test-lib: make sure Git has already been built

 Only the first test t0000 in the test suite made sure we have built
 Git to be tested; move the check to test-lib so that it applies to
 all tests equally.

 Will merge to 'master'.


* db/doc-custom-xmlto (2012-09-19) 1 commit
  (merged to 'next' on 2012-09-24 at efcfec1)
 + Documentation/Makefile: Allow custom XMLTO binary

 Will merge to 'master'.


* js/hp-nonstop (2012-09-19) 1 commit
  (merged to 'next' on 2012-09-24 at 283ac87)
 + Port to HP NonStop
 (this branch uses js/poll-emu.)

 Port to HP NonStop aka Tandem.

 Will merge to 'master'.


* po/maint-docs (2012-09-19) 5 commits
  (merged to 'next' on 2012-09-24 at 9df3935)
 + Doc branch: show -vv option and alternative
 + Doc clean: add See Also link
 + Doc add: link gitignore
 + Doc: separate gitignore pattern sources
 + Doc: shallow clone deepens _to_ new depth

 Various documentation fixups.

 Will merge to 'master'.


* sp/maint-http-info-refs-no-retry (2012-09-20) 1 commit
  (merged to 'next' on 2012-09-24 at ebcce8e)
 + Revert "retry request without query when info/refs?query fails"
 (this branch is used by jk/smart-http-switch.)

 Kills an old workaround for a unlikely server misconfiguration that
 hurts debuggability.

 Will merge to 'master'.


* jk/smart-http-switch (2012-09-21) 2 commits
  (merged to 'next' on 2012-09-24 at b2a2777)
 + remote-curl: let users turn off smart http
 + remote-curl: rename is_http variable
 (this branch uses sp/maint-http-info-refs-no-retry.)

 Allows users to turn off smart-http when talking to dumb-only
 servers.

 Will merge to 'master'.


* sp/maint-http-enable-gzip (2012-09-20) 1 commit
  (merged to 'next' on 2012-09-24 at 1d05142)
 + Enable info/refs gzip decompression in HTTP client

 Allows a more common 'gzip' Accept-Encoding to be used.

 Will merge to 'master'.


* nd/pretty-placeholder-with-color-option (2012-09-20) 4 commits
 - [SQUASH] do not use real-sb without initializing
 - pretty: support right alignment
 - pretty: support placeholders %C+ and %C-
 - pretty: share code between format_decoration and show_decorations

 Rerolled, but haven't picked it up yet.


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
 (this branch is used by jc/blame-no-follow.)

 Clarify the "blame" documentation to tell the users that there is
 no need to ask for "--follow".


* rt/maint-clone-single (2012-09-20) 1 commit
 - clone --single: limit the fetch refspec to fetched branch

 Running "git fetch" in a repository made with "git clone --single"
 slurps all the branches, defeating the point of "--single".

 Will merge to 'next'.


* ep/malloc-check-perturb (2012-09-17) 2 commits
  (merged to 'next' on 2012-09-24 at c490ea5)
 + MALLOC_CHECK: various clean-ups
 + Add MALLOC_CHECK_ and MALLOC_PERTURB_ libc env to the test suite for detecting heap corruption

 Run our test scripts with MALLOC_CHECK_ and MALLOC_PERTURB_, the
 built-in memory access checking facility GNU libc has.

 Will merge to 'master'.


* aj/xfuncname-ada (2012-09-16) 1 commit
  (merged to 'next' on 2012-09-24 at 99fcbb3)
 + Add userdiff patterns for Ada

 Will merge to 'master'.


* aw/rebase-i-edit-todo (2012-09-19) 5 commits
  (merged to 'next' on 2012-09-24 at 95625d7)
 + rebase -i: suggest using --edit-todo to fix an unknown instruction
 + rebase -i: Add tests for "--edit-todo"
 + rebase -i: Teach "--edit-todo" action
 + rebase -i: Refactor help messages for todo file
 + rebase usage: subcommands can not be combined with -i

 Will merge to 'master'.


* jc/maint-mailinfo-mime-attr (2012-09-17) 1 commit
  (merged to 'next' on 2012-09-24 at c551c9f)
 + mailinfo: do not concatenate charset= attribute values from mime headers

 When "git am" is fed an input that has multiple "Content-type: ..."
 header, it did not grok charset= attribute correctly.

 Will merge to 'master'.


* js/poll-emu (2012-09-17) 4 commits
  (merged to 'next' on 2012-09-24 at 32e1601)
 + make poll() work on platforms that can't recv() on a non-socket
 + poll() exits too early with EFAULT if 1st arg is NULL
 + fix some win32 specific dependencies in poll.c
 + make poll available for other platforms lacking it
 (this branch is used by js/hp-nonstop.)

 Will merge to 'master'.


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


* rs/archive-zip-utf8 (2012-09-24) 4 commits
  (merged to 'next' on 2012-09-24 at 9b42b1c)
 + archive-zip: write extended timestamp
 + archive-zip: support UTF-8 paths
 + Revert "archive-zip: support UTF-8 paths"
  (merged to 'next' on 2012-09-11 at 3b1f071)
 + archive-zip: support UTF-8 paths

 With another reroll, it looks like the series is as polished as it
 could be.

 Will merge to 'master'.


* jk/no-more-pre-exec-callback (2012-06-05) 1 commit
 - pager: drop "wait for output to run less" hack

 (Originally merged to 'next' on 2012-07-23)

 Will defer until the end of the 2012.
 while waiting for older "less" to go extinct.

--------------------------------------------------
[Discarded]

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
 fixes on Cygwin.

 Discarded without prejudice.


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

 Discarded without prejudice.
