From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Oct 2012, #03; Sun, 7)
Date: Sun, 07 Oct 2012 16:53:30 -0700
Message-ID: <7vbogdon45.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 08 01:53:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TL0fJ-0003hj-Ax
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 01:53:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752752Ab2JGXxf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2012 19:53:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52911 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751334Ab2JGXxd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2012 19:53:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5DF9881E4;
	Sun,  7 Oct 2012 19:53:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=Z
	YjwaiVfkCsO++NjAU5sjonsl6M=; b=ro+BNbLQv1R9ncafc/WIJEYi6H9cVImZx
	LLmCsoV67hQ8m3GwDJr8haRvAiofMvLtySjedqY58uTcc757Vj+UJ3AGdMK6mhnc
	jqDGT00QeKNJmDydzXgATjv9ET2txKuZAc4/cwA6H3iUrEkwG11h9zx7gLQtMEfv
	8DGeHEOIpI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=I80
	tYJ9CKdnxS8v1g5ozy8QdIXLqkTHGpPNFAVj2CqkzCO3AWf/yXYDSSk7Hng9zEad
	U3rL1xKgBOHS5tXMaqzCOHuSDjQm4bTWqwIno/Lfzu+DrMxvyXkh4HtWZzyWX6st
	GrsyP+kxWSi4h4Tvu+VEoI7olzxqTr7CywLyV88E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B93C81E3;
	Sun,  7 Oct 2012 19:53:33 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 153F481E2; Sun,  7 Oct 2012
 19:53:31 -0400 (EDT)
X-master-at: dc01f880a53e56d4a5c6f30cb2d7b9412e17bfe7
X-next-at: 9fa34dc2edd1285517772f315bf1d7edbcfbfee6
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 331C49C0-10DA-11E2-A051-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207219>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

I'll merge the regression fix jc/merge-bases-paint-fix to 'master'
and will tag 1.8.0-rc1 tomorrow.  It would be nice if we can have
pull requests for subsystem updates before then.

I'm planning to keep this cycle reasonably short and aim for tagging
the result as 1.8.0 at the end of 9th week, on October 21st, after
which I'd disappear for a few weeks.  http://tinyurl.com/gitCal is
where you can always find my rough tagging schedule at.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* jc/doc-default-format (2012-10-07) 2 commits
 - [SQAUSH] allow "cd Doc* && make DEFAULT_DOC_TARGET=..."
 - Allow generating a non-default set of documentation

 Will merge to 'next', but it is a bit too late for 1.8.0.


* jk/lua-hackery (2012-10-07) 6 commits
 - pretty: fix up one-off format_commit_message calls
 - Minimum compilation fixup
 - Makefile: make "lua" a bit more configurable
 - add a "lua" pretty format
 - add basic lua infrastructure
 - pretty: make some commit-parsing helpers more public

 Interesting exercise. When we do this for real, we probably would want
 to wrap a commit to make it more like an "object" with methods like
 "parents", etc.


* nd/attr-match-optim (2012-10-05) 2 commits
 - attr: avoid searching for basename on every match
 - attr: avoid strlen() on every match
 (this branch is used by nd/attr-match-optim-more.)

 Will merge to 'next', but it is a bit too late for 1.8.0.


* nd/attr-match-optim-more (2012-10-05) 3 commits
 - attr: more matching optimizations from .gitignore
 - gitignore: make pattern parsing code a separate function
 - Merge commit 'f9f6e2c' into nd/attr-match-optim-more
 (this branch uses nd/attr-match-optim.)

 Start laying the foundation to build the "wildmatch" after we can
 agree on its desired semantics.


* nd/doc-ignore (2012-10-07) 1 commit
 - gitignore.txt: suggestions how to get literal # or ! at the beginning

 Will merge to 'next', but it may be a bit too late for 1.8.0.


--------------------------------------------------
[Stalled]

* rc/maint-complete-git-p4 (2012-09-24) 1 commit
  (merged to 'next' on 2012-09-25 at 116e58f)
 + Teach git-completion about git p4

 Comment from Pete will need to be addressed in a follow-up patch.


* as/check-ignore (2012-09-27) 17 commits
 - [SQUASH-FIX] 283d072 (Add git-check-ignore sub-command, 2012-09-20)
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

 Waiting for a reroll.


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


* fa/vcs-svn (2012-10-07) 4 commits
 - vcs-svn: remove repo_tree
 - vcs-svn/svndump: rewrite handle_node(), begin|end_revision()
 - vcs-svn/svndump: restructure node_ctx, rev_ctx handling
 - svndump: move struct definitions to .h
 (this branch uses fa/remote-svn.)

 A follow-up to a GSoC project, but seems not quite ready.
 Will discard.


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

 Stalled mostly due to lack of responses.


* jc/xprm-generation (2012-09-14) 1 commit
 - test-generation: compute generation numbers and clock skews

 A toy to analyze how bad the clock skews are in histories of real
 world projects.

 Stalled mostly due to lack of responses.


* jc/blame-no-follow (2012-09-21) 2 commits
 - blame: pay attention to --no-follow
 - diff: accept --no-follow option

 Teaches "--no-follow" option to "git blame" to disable its
 whole-file rename detection.

 Stalled mostly due to lack of responses.


* mk/maint-graph-infinity-loop (2012-09-25) 1 commit
 - graph.c: infinite loop in git whatchanged --graph -m

 The --graph code fell into infinite loop when asked to do what the
 code did not expect ;-)

 Anybody who worked on "--graph" wants to comment?
 Stalled mostly due to lack of responses.


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
 Will discard.


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

* jc/doc-long-options (2012-10-04) 1 commit
 - gitcli: parse-options lets you omit tail of long options

 The end-user facing documentation claimed to be an "exhaustive"
 list of features of parse-options command line parser, but it
 didn't mention anything about abbreviating long option names to
 their unique prefixes. Mention it, warn against relying too much on
 it (as uniqueness may disappear in future versions of Git), and
 drop the claim to be exhaustive.

 Will merge to 'next', but it is a bit too late for 1.8.0.


* jc/grep-pcre-loose-ends (2012-10-04) 6 commits
 . log --grep: honor grep.patterntype etc. configuration variables
 . log: pass rev_info to git_log_config()
 - log --grep: accept --basic-regexp and --perl-regexp
 - log --grep: use the same helper to set -E/-F options as "git grep"
 - grep: move pattern-type bits support to top-level grep.[ch]
 - grep: move configuration support to top-level grep.[ch]

 "git log -F -E --grep='<ere>'" failed to use the given <ere>
 pattern as extended regular expression, and instead looked for the
 string literally.  The early part of this series is a fix for it.

 The last two are very wrong and need to be redone by refactoring
 the configuration handling of "grep.*" part.


* jc/merge-bases-paint-fix (2012-10-04) 1 commit
  (merged to 'next' on 2012-10-07 at 9fa34dc)
 + paint_down_to_common(): parse commit before relying on its timestamp

 "git fmt-merge-msg" (actually an internal helper reduce_heads() it
 uses) had a severe performance regression; an empty "git pull" took
 forever to finish as the result.

 Need to be merged before 1.8.0 final.


* jk/peel-ref (2012-10-04) 4 commits
 - upload-pack: use peel_ref for ref advertisements
 - peel_ref: check object type before loading
 - peel_ref: do not return a null sha1
 - peel_ref: use faster deref_tag_noverify

 Speeds up "git upload-pack" (what is invoked by "git fetch" on the
 other side of the connection) by reducing the cost to advertise the
 branches and tags that are available in the repository.

 Will merge to 'next', but it is a bit too late for 1.8.0.


* fa/remote-svn (2012-10-07) 16 commits
  (merged to 'next' on 2012-10-07 at 7b90cf4)
 + Add a test script for remote-svn
 + remote-svn: add marks-file regeneration
 + Add a svnrdump-simulator replaying a dump file for testing
 + remote-svn: add incremental import
 + remote-svn: Activate import/export-marks for fast-import
 + Create a note for every imported commit containing svn metadata
 + vcs-svn: add fast_export_note to create notes
 + Allow reading svn dumps from files via file:// urls
 + remote-svn, vcs-svn: Enable fetching to private refs
 + When debug==1, start fast-import with "--stats" instead of "--quiet"
 + Add documentation for the 'bidi-import' capability of remote-helpers
 + Connect fast-import to the remote-helper via pipe, adding 'bidi-import' capability
 + Add argv_array_detach and argv_array_free_detached
 + Add svndump_init_fd to allow reading dumps from arbitrary FDs
 + Add git-remote-testsvn to Makefile
 + Implement a remote helper for svn in C
 (this branch is used by fa/vcs-svn.)

 A GSoC project.


* bw/config-lift-variable-name-length-limit (2012-10-01) 1 commit
 - Remove the hard coded length limit on variable names in config files

 The configuration parser had an unnecessary hardcoded limit on
 variable names that was not checked consistently. Lift the limit.

 Will merge to 'next'.


* jc/maint-t1450-fsck-order-fix (2012-10-02) 1 commit
  (merged to 'next' on 2012-10-02 at cc1a62e)
 + t1450: the order the objects are checked is undefined

 The fsck test assumed too much on what kind of error it will
 detect. The only important thing is the inconsistency is detected
 as an error.

 Will merge to 'next'.


* jl/submodule-add-by-name (2012-09-30) 2 commits
 - submodule add: Fail when .git/modules/<name> already exists unless forced
 - Teach "git submodule add" the --name option

 If you remove a submodule, in order to keep the repository so that
 "git checkout" to an older commit in the superproject history can
 resurrect the submodule, the real repository will stay in $GIT_DIR
 of the superproject.  A later "git submodule add $path" to add a
 different submodule at the same path will fail.  Diagnose this case
 a bit better, and if the user really wants to add an unrelated
 submodule at the same path, give the "--name" option to give it a
 place in $GIT_DIR of the superproject that does not conflict with
 the original submodule.

 Will merge to 'next'.


* jm/diff-context-config (2012-10-02) 2 commits
  (merged to 'next' on 2012-10-02 at e57700a)
 + t4055: avoid use of sed 'a' command
  (merged to 'next' on 2012-10-01 at 509a558)
 + diff: diff.context configuration gives default to -U

 Teaches a new configuration variable to "git diff" Porcelain and
 its friends.

 Will defer to the next cycle.


* mh/ceiling (2012-09-29) 9 commits
 - t1504: stop resolving symlinks in GIT_CEILING_DIRECTORIES
 - longest_ancestor_length(): resolve symlinks before comparing paths
 - longest_ancestor_length(): use string_list_longest_prefix()
 - longest_ancestor_length(): always add a slash to the end of prefixes
 - longest_ancestor_length(): explicitly filter list before loop
 - longest_ancestor_length(): use string_list_split()
 - Introduce new function real_path_if_valid()
 - real_path_internal(): add comment explaining use of cwd
 - Introduce new static function real_path_internal()

 Elements of GIT_CEILING_DIRECTORIES list may not match the real
 pathname we obtain from getcwd(), leading the GIT_DIR discovery
 logic to escape the ceilings the user thought to have specified.

 The solution felt a bit unnecessarily convoluted to me.
 Expecting a reroll.


* jl/submodule-rm (2012-09-29) 1 commit
  (merged to 'next' on 2012-10-01 at 4e5c4fc)
 + submodule: teach rm to remove submodules unless they contain a git directory

 "git rm submodule" cannot blindly remove a submodule directory as
 its working tree may have local changes, and worse yet, it may even
 have its repository embedded in it.  Teach it some special cases
 where it is safe to remove a submodule, specifically, when there is
 no local changes in the submodule working tree, and its repository
 is not embedded in its working tree but is elsewhere and uses the
 gitfile mechanism to point at it.

 Will defer to the next cycle.


* nd/pretty-placeholder-with-color-option (2012-09-30) 9 commits
 - pretty: support %>> that steal trailing spaces
 - pretty: support truncating in %>, %< and %><
 - pretty: support padding placeholders, %< %> and %><
 - pretty: two phase conversion for non utf-8 commits
 - utf8.c: add utf8_strnwidth() with the ability to skip ansi sequences
 - utf8.c: move display_mode_esc_sequence_len() for use by other functions
 - pretty: support %C(auto[,N]) to turn on coloring on next placeholder(s)
 - pretty: split parsing %C into a separate function
 - pretty: share code between format_decoration and show_decorations


* jk/no-more-pre-exec-callback (2012-06-05) 1 commit
 - pager: drop "wait for output to run less" hack

 (Originally merged to 'next' on 2012-07-23)

 Will defer to the next cycle.

--------------------------------------------------
[Discarded]

* nd/wildmatch (2012-09-27) 5 commits
 . Support "**" in .gitignore and .gitattributes patterns using wildmatch()
 . Integrate wildmatch to git
 . compat/wildmatch: fix case-insensitive matching
 . compat/wildmatch: remove static variable force_lower_case
 . Import wildmatch from rsync

 Allows pathname patterns in .gitignore and .gitattributes files
 with double-asterisks "foo/**/bar" to match any number of directory
 hiearchies.

 It was pointed out that some symbols that do not have to be global
 are left global. I think this reroll fixed most of them.
