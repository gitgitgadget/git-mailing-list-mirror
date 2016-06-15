From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jan 2013, #11; Wed, 30)
Date: Wed, 30 Jan 2013 10:33:10 -0800
Message-ID: <7vd2wmldw9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 30 19:33:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0cTb-0006yd-2Q
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 19:33:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756128Ab3A3SdQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 13:33:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58897 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756098Ab3A3SdO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 13:33:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 83305BD85;
	Wed, 30 Jan 2013 13:33:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=8
	2E78nOA8yR7eCvFdurwH2NjdcY=; b=QiAkTtkwrZImfg5PB+1pOmRDy1FaBHeSX
	NDHqkBlHsqajvpI4EEihPuDQH8ycP6uEDQHHLnogslxItcMOMmYNsiML90ijNVAD
	b+tSehwh9Gi9RDw+YhK2Lfy1l5d2Ks7DnQyVA9S7nYyG3D2zCI3TPntMxIGq3P9O
	PIn44Jngn4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=CXp
	JFhPFyNMr9MXZWcM7GjWQ1II0dAZFI2PSRV7qcI9bwh6pnGS3E7HAScOub6D2hQi
	l42XFbD/71m5tdhmc+WJIhohueXDZnsTDtHVLNs43Jb3bONGt39stoXtqJM9MlKU
	xiRO7+qzR4SHya38g122zKzjoflJVFBTY1QZKgdM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 77BC6BD84;
	Wed, 30 Jan 2013 13:33:13 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 51952BD7D; Wed, 30 Jan 2013
 13:33:12 -0500 (EST)
X-master-at: 070c57df42ea4eadcc43d0456d114560124326c3
X-next-at: 7d3a2ef96c8474fb18c8a5ca045cdbeb6180ac4f
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 80BFFA10-6B0B-11E2-8F7D-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215044>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

As usual, this cycle is expected to last for 8 to 10 weeks, with a
preview -rc0 sometime in the middle of next month.

You can find the changes described here in the integration branches of the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* ab/gitweb-use-same-scheme (2013-01-28) 1 commit
 - gitweb: refer to picon/gravatar images over the same scheme

 Avoid mixed contents on a page coming via http and https when
 gitweb is hosted on a https server.

 Will merge to 'next'.


* jk/python-styles (2013-01-29) 1 commit
 - CodingGuidelines: add Python coding guidelines

 Expecting a reroll.
 $gmane/215007.


* mn/send-email-authinfo (2013-01-29) 1 commit
 - git-send-email: add ~/.authinfo parsing

 Expecting a reroll.
 $gmane/215004, $gmane/215024.


* nd/edit-branch-desc-while-detached (2013-01-30) 1 commit
  (merged to 'next' on 2013-01-30 at 69307d6)
 + branch: no detached HEAD check when editing another branch's description
 (this branch is used by nd/branch-error-cases.)

 Attempt to "branch --edit-description" an existing branch, while
 being on a detached HEAD, errored out.

 Will merge to 'master'.

--------------------------------------------------
[Graduated to "master"]

* bc/fix-array-syntax-for-3.0-in-completion-bash (2013-01-18) 1 commit
  (merged to 'next' on 2013-01-25 at d113c1a)
 + git-completion.bash: replace zsh notation that breaks bash 3.X

 Fix use of an array notation that older versions of bash do not
 understand.


* dl/am-hg-locale (2013-01-18) 1 commit
  (merged to 'next' on 2013-01-25 at 3419019)
 + am: invoke perl's strftime in C locale

 Datestamp recorded in "Hg" format patch was reformatted incorrectly
 to an e-mail looking date using locale dependant strftime, causing
 patch application to fail.


* jc/help (2013-01-18) 1 commit
  (merged to 'next' on 2013-01-25 at b2b087e)
 + help: include <common-cmds.h> only in one file

 A header file that has the definition of a static array was
 included in two places, wasting the space.


* nd/magic-pathspec-from-root (2013-01-21) 2 commits
  (merged to 'next' on 2013-01-25 at b056b57)
 + grep: avoid accepting ambiguous revision
 + Update :/abc ambiguity check

 When giving arguments without "--" disambiguation, object names
 that come  earlier on the command line must not be interpretable as
 pathspecs and pathspecs that come later on the command line must
 not be interpretable as object names.  Tweak the disambiguation
 rule so that ":/" (no other string before or after) is always
 interpreted as a pathspec, to avoid having to say "git cmd -- :/".


* rr/minimal-stat (2013-01-22) 1 commit
  (merged to 'next' on 2013-01-25 at 11c4453)
 + Enable minimal stat checking

 Some reimplementations of Git does not write all the stat info back
 to the index due to their implementation limitations (e.g. jgit
 running on Java).  A configuration option can tell Git to ignore
 changes to most of the stat fields and only pay attention to mtime
 and size, which these implementations can reliably update.  This
 avoids excessive revalidation of contents.


* tb/t0050-maint (2013-01-21) 3 commits
  (merged to 'next' on 2013-01-25 at 682b1e2)
 + t0050: Use TAB for indentation
 + t0050: honor CASE_INSENSITIVE_FS in add (with different case)
 + t0050: known breakage vanished in merge (case change)

 Update tests that were expecting to fail due to a bug that was
 fixed earlier.

--------------------------------------------------
[Stalled]

* dg/subtree-fixes (2013-01-08) 7 commits
 - contrib/subtree: mkdir the manual directory if needed
 - contrib/subtree: honor $(DESTDIR)
 - contrib/subtree: fix synopsis and command help
 - contrib/subtree: better error handling for "add"
 - contrib/subtree: add --unannotate option
 - contrib/subtree: use %B for split Subject/Body
 - t7900: remove test number comments

 contrib/subtree updates; there are a few more from T. Zheng that
 were posted separately, with an overlap.

 Expecting a reroll.


* mp/diff-algo-config (2013-01-16) 3 commits
 - diff: Introduce --diff-algorithm command line option
 - config: Introduce diff.algorithm variable
 - git-completion.bash: Autocomplete --minimal and --histogram for git-diff

 Add diff.algorithm configuration so that the user does not type
 "diff --histogram".

 Looking better; may want tests to protect it from future breakages,
 but otherwise it looks ready for 'next'.

 Expecting a follow-up to add tests.


* mb/gitweb-highlight-link-target (2012-12-20) 1 commit
 - Highlight the link target line in Gitweb using CSS

 Expecting a reroll.
 $gmane/211935


* jl/submodule-deinit (2012-12-04) 1 commit
 - submodule: add 'deinit' command

 There was no Porcelain way to say "I no longer am interested in
 this submodule", once you express your interest in a submodule with
 "submodule init".  "submodule deinit" is the way to do so.

 Expecting a reroll.
 $gmane/212884


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


* rc/maint-complete-git-p4 (2012-09-24) 1 commit
 - Teach git-completion about git p4

 Comment from Pete will need to be addressed ($gmane/206172).


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


* jc/add-delete-default (2012-08-13) 1 commit
 - git add: notice removal of tracked paths by default

 "git add dir/" updated modified files and added new files, but does
 not notice removed files, which may be "Huh?" to some users.  They
 can of course use "git add -A dir/", but why should they?

 Resurrected from graveyard, as I thought it was a worthwhile thing
 to do in the longer term.

 Stalled mostly due to lack of responses.


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
 $gmane/210151

 "The first remote becomes the default" bit is better done as a
 separate step.


* nd/parse-pathspec (2013-01-11) 20 commits
 . Convert more init_pathspec() to parse_pathspec()
 . Convert add_files_to_cache to take struct pathspec
 . Convert {read,fill}_directory to take struct pathspec
 . Convert refresh_index to take struct pathspec
 . Convert report_path_error to take struct pathspec
 . checkout: convert read_tree_some to take struct pathspec
 . Convert unmerge_cache to take struct pathspec
 . Convert read_cache_preload() to take struct pathspec
 . add: convert to use parse_pathspec
 . archive: convert to use parse_pathspec
 . ls-files: convert to use parse_pathspec
 . rm: convert to use parse_pathspec
 . checkout: convert to use parse_pathspec
 . rerere: convert to use parse_pathspec
 . status: convert to use parse_pathspec
 . commit: convert to use parse_pathspec
 . clean: convert to use parse_pathspec
 . Export parse_pathspec() and convert some get_pathspec() calls
 . Add parse_pathspec() that converts cmdline args to struct pathspec
 . pathspec: save the non-wildcard length part

 Uses the parsed pathspec structure in more places where we used to
 use the raw "array of strings" pathspec.

 Ejected from 'pu' for now; will take a look at the rerolled one
 later ($gmane/213340).

--------------------------------------------------
[Cooking]

* mp/complete-paths (2013-01-11) 1 commit
  (merged to 'next' on 2013-01-30 at 70e4f1a)
 + git-completion.bash: add support for path completion

 The completion script used to let the default completer to suggest
 pathnames, which gave too many irrelevant choices (e.g. "git add"
 would not want to add an unmodified path).  Teach it to use a more
 git-aware logic to enumerate only relevant ones.

 This is logically the right thing to do, and we would really love
 to see people who have been involved in completion code to review
 and comment on the implementation.

 Will cook in 'next' to see if anybody screams.


* bc/git-p4-for-python-2.4 (2013-01-26) 2 commits
  (merged to 'next' on 2013-01-30 at 5d81ed2)
 + git-p4.py: support Python 2.4
 + git-p4.py: support Python 2.5

 With small updates to remove dependency on newer features of
 Python, keep git-p4 usable with older Python.

 Will merge to 'master'.


* jk/gc-auto-after-fetch (2013-01-26) 1 commit
  (merged to 'next' on 2013-01-30 at 472d07b)
 + Merge branch 'jk/maint-gc-auto-after-fetch' into jk/gc-auto-after-fetch
 (this branch uses jk/maint-gc-auto-after-fetch.)

 This is to resolve merge conflicts early for the same topic to
 recent codebase.

 Will merge to 'master'.


* jk/maint-gc-auto-after-fetch (2013-01-26) 2 commits
 + fetch-pack: avoid repeatedly re-scanning pack directory
 + fetch: run gc --auto after fetching
 (this branch is used by jk/gc-auto-after-fetch.)

 Help "fetch only" repositories that do not trigger "gc --auto"
 often enough.

 Will merge to 'master' via jk/gc-auto-after-fetch and later merge to 'maint'.


* jk/read-commit-buffer-data-after-free (2013-01-26) 3 commits
  (merged to 'next' on 2013-01-30 at c6d7e16)
 + logmsg_reencode: lazily load missing commit buffers
 + logmsg_reencode: never return NULL
 + commit: drop useless xstrdup of commit message

 Clarify the ownership rule for commit->buffer field, which some
 callers incorrectly accessed without making sure it is populated.

 Will merge to 'master'.


* pw/git-p4-on-cygwin (2013-01-26) 21 commits
  (merged to 'next' on 2013-01-30 at 958ae3a)
 + git p4: introduce gitConfigBool
 + git p4: avoid shell when calling git config
 + git p4: avoid shell when invoking git config --get-all
 + git p4: avoid shell when invoking git rev-list
 + git p4: avoid shell when mapping users
 + git p4: disable read-only attribute before deleting
 + git p4 test: use test_chmod for cygwin
 + git p4: cygwin p4 client does not mark read-only
 + git p4 test: avoid wildcard * in windows
 + git p4 test: use LineEnd unix in windows tests too
 + git p4 test: newline handling
 + git p4: scrub crlf for utf16 files on windows
 + git p4: remove unreachable windows \r\n conversion code
 + git p4 test: translate windows paths for cygwin
 + git p4 test: start p4d inside its db dir
 + git p4 test: use client_view in t9806
 + git p4 test: avoid loop in client_view
 + git p4 test: use client_view to build the initial client
 + git p4: generate better error message for bad depot path
 + git p4: remove unused imports
 + git p4: temp branch name should use / even on windows

 Improve "git p4" on Cygwin.

 Will merge to 'master'.


* ss/mergetools-tortoise (2013-01-26) 2 commits
 - mergetools: allow passing pathnames with SP in them to TortoiseGitMerge
 - mergetools: support TortoiseGitMerge

 Update mergetools to work better with newer merge helper tortoise ships.

 Will merge to 'next'.


* da/mergetool-docs (2013-01-30) 4 commits
 - doc: generate a list of valid merge tools
 - mergetool--lib: add functions for finding available tools
 - mergetool--lib: improve the help text in guess_merge_tool()
 - mergetool--lib: simplify command expressions
 (this branch uses jk/mergetool.)

 Build on top of the clean-up done by jk/mergetool and automatically
 generate the list of mergetool and difftool backends the build
 supports to be included in the documentation.

 This is looking ready for 'next'.


* nd/branch-error-cases (2013-01-30) 4 commits
 - branch: mark more strings for translation
 - Merge branch 'nd/edit-branch-desc-while-detached' into HEAD
 - branch: give a more helpful message on redundant arguments
 - branch: reject -D/-d without branch name
 (this branch uses nd/edit-branch-desc-while-detached.)

 Fix various error messages and conditions in "git branch", e.g. we
 advertised "branch -d/-D" to remove one or more branches but actually
 implemented removal of zero or more branches---request to remove no
 branches was not rejected.

 Will merge to 'next'.


* jc/push-reject-reasons (2013-01-24) 4 commits
  (merged to 'next' on 2013-01-28 at b60be93)
 + push: finishing touches to explain REJECT_ALREADY_EXISTS better
 + push: introduce REJECT_FETCH_FIRST and REJECT_NEEDS_FORCE
 + push: further simplify the logic to assign rejection reason
 + push: further clean up fields of "struct ref"

 Improve error and advice messages given locally when "git push"
 refuses when it cannot compute fast-forwardness by separating these
 cases from the normal "not a fast-forward; merge first and push
 again" case.

 Will merge to 'master'.


* as/test-cleanup (2013-01-24) 1 commit
  (merged to 'next' on 2013-01-28 at cc1147d)
 + t7102 (reset): don't hardcode SHA-1 in expected outputs

 Will merge to 'master'.


* jc/do-not-let-random-file-interfere-with-completion-tests (2013-01-24) 1 commit
  (merged to 'next' on 2013-01-28 at df27f53)
 + t9902: protect test from stray build artifacts

 Scripts to test bash completion was inherently flaky as it was
 affected by whatever random things the user may have on $PATH.

 Will merge to 'master'.


* jk/cvsimport-does-not-work-with-cvsps3 (2013-01-24) 1 commit
  (merged to 'next' on 2013-01-28 at fef4eb2)
 + git-cvsimport.txt: cvsps-2 is deprecated

 Warn people that other tools are more recommendable over
 cvsimport+cvsps2 combo when doing a one-shot import, and cvsimport
 will not work with cvsps3.

 Will merge to 'master'.


* jk/mergetool (2013-01-28) 8 commits
 - mergetools: simplify how we handle "vim" and "defaults"
 - mergetool--lib: don't call "exit" in setup_tool
 - mergetool--lib: improve show_tool_help() output
 - mergetools/vim: remove redundant diff command
 - git-difftool: use git-mergetool--lib for "--tool-help"
 - git-mergetool: don't hardcode 'mergetool' in show_tool_help
 - git-mergetool: remove redundant assignment
 - git-mergetool: move show_tool_help to mergetool--lib
 (this branch is used by da/mergetool-docs.)

 Cleans up mergetool/difftool combo.

 This is looking ready for 'next'.


* jn/do-not-drop-username-when-reading-from-etc-mailname (2013-01-25) 1 commit
  (merged to 'next' on 2013-01-28 at e0a8222)
 + ident: do not drop username when reading from /etc/mailname

 We used to stuff "user@" and then append what we read from
 /etc/mailname to come up with a default e-mail ident, but a bug
 lost the "user@" part.  This is to fix it.

 Will merge to 'master'.


* mm/add-u-A-sans-pathspec (2013-01-28) 1 commit
  (merged to 'next' on 2013-01-28 at fe762a6)
 + add: warn when -u or -A is used without pathspec

 Forbid "git add -u" and "git add -A" without pathspec run from a
 subdirectory, to train people to type "." (or ":/") to make the
 choice of default does not matter.

 Will merge to 'master'.


* jc/hidden-refs (2013-01-30) 8 commits
 - WIP: receive.allowupdatestohidden
 - fetch: fetch objects by their exact SHA-1 object names
 - upload-pack: optionally allow fetching from the tips of hidden refs
 - fetch: use struct ref to represent refs to be fetched
 - parse_fetch_refspec(): clarify the codeflow a bit
 - upload/receive-pack: allow hiding ref hierarchies
 - upload-pack: simplify request validation
 - upload-pack: share more code

 Allow the server side to unclutter the refs/ namespace it shows to
 the client.  Optionally allow requests for histories leading to the
 tips of hidden refs by updated clients.


* ta/doc-no-small-caps (2013-01-22) 10 commits
 - fixup! Change 'git' to 'Git' whenever the whole system is referred to #4
 - Change 'git' to 'Git' whenever the whole system is referred to #4
 - fixup! Change 'git' to 'Git' whenever the whole system is referred to #3
 - Change 'git' to 'Git' whenever the whole system is referred to #3
 - fixup! Change 'git' to 'Git' whenever the whole system is referred to #2
 - Change 'git' to 'Git' whenever the whole system is referred to #2
 - fixup! fixup! Change 'git' to 'Git' whenever the whole system is referred to #1
 - fixup! Change 'git' to 'Git' whenever the whole system is referred to #1
 - Change 'git' to 'Git' whenever the whole system is referred to #1
 - Documentation: avoid poor-man's small caps

 Update documentation to change "GIT" which was a poor-man's small
 caps to "Git" which was the intended spelling.  Also change "git"
 spelled in all-lowercase to "Git" when it refers to the system as
 the whole or the concept it embodies, as opposed to the command the
 end users would type.

 Will wait for a week or so (say, til end of January) for Thomas to
 collect fix-ups, squash the result into two patches and then merge
 to 'next'.


* jc/remove-treesame-parent-in-simplify-merges (2013-01-17) 1 commit
  (merged to 'next' on 2013-01-30 at b639b47)
 + simplify-merges: drop merge from irrelevant side branch

 The --simplify-merges logic did not cull irrelevant parents from a
 merge that is otherwise not interesting with respect to the paths
 we are following.

 This touches a fairly core part of the revision traversal
 infrastructure; even though I think this change is correct, please
 report immediately if you find any unintended side effect.

 Will merge to 'next'.


* jk/remote-helpers-in-python-3 (2013-01-28) 9 commits
  (merged to 'next' on 2013-01-28 at d898471)
 + git-remote-testpy: fix path hashing on Python 3
  (merged to 'next' on 2013-01-25 at acf9419)
 + git-remote-testpy: call print as a function
 + git-remote-testpy: don't do unbuffered text I/O
 + git-remote-testpy: hash bytes explicitly
 + svn-fe: allow svnrdump_sim.py to run with Python 3
 + git_remote_helpers: use 2to3 if building with Python 3
 + git_remote_helpers: force rebuild if python version changes
 + git_remote_helpers: fix input when running under Python 3
 + git_remote_helpers: allow building with Python 3

 Prepare remote-helper test written in Python to be run with Python3.

 Will merge to 'master'.


* jk/config-parsing-cleanup (2013-01-23) 8 commits
  (merged to 'next' on 2013-01-28 at 9bc9411)
 + reflog: use parse_config_key in config callback
 + help: use parse_config_key for man config
 + submodule: simplify memory handling in config parsing
 + submodule: use parse_config_key when parsing config
 + userdiff: drop parse_driver function
 + convert some config callbacks to parse_config_key
 + archive-tar: use parse_config_key when parsing config
 + config: add helper function for parsing key names

 Configuration parsing for tar.* configuration variables were
 broken. Introduce a new config-keyname parser API to make the
 callers much less error prone.

 Will merge to 'master'.


* jc/custom-comment-char (2013-01-16) 1 commit
  (merged to 'next' on 2013-01-25 at 91d8a5d)
 + Allow custom "comment char"

 An illustration to show codepaths that need to be touched to change
 the hint lines in the edited text to begin with something other
 than '#'.

 This is half my work and half by Ralf Thielow.  There may still be
 leftover '#' lurking around, though.  My "git grep" says C code
 should be already fine, but git-rebase--interactive.sh could be
 converted (it should not matter, as the file is not really a
 free-form text).

 Will merge to 'master'.


* nd/fetch-depth-is-broken (2013-01-11) 3 commits
  (merged to 'next' on 2013-01-15 at 70a5ca7)
 + fetch: elaborate --depth action
 + upload-pack: fix off-by-one depth calculation in shallow clone
 + fetch: add --unshallow for turning shallow repo into complete one

 "git fetch --depth" was broken in at least three ways.  The
 resulting history was deeper than specified by one commit, it was
 unclear how to wipe the shallowness of the repository with the
 command, and documentation was misleading.

 Will merge to 'master'.


* jc/no-git-config-in-clone (2013-01-11) 1 commit
  (merged to 'next' on 2013-01-15 at feeffe1)
 + clone: do not export and unexport GIT_CONFIG

 We stopped paying attention to $GIT_CONFIG environment that points
 at a single configuration file from any command other than "git config"
 quite a while ago, but "git clone" internally set, exported, and
 then unexported the variable during its operation unnecessarily.

 Will merge to 'master'.


* jc/push-2.0-default-to-simple (2013-01-16) 14 commits
  (merged to 'next' on 2013-01-16 at 23f5df2)
 + t5570: do not assume the "matching" push is the default
 + t5551: do not assume the "matching" push is the default
 + t5550: do not assume the "matching" push is the default
  (merged to 'next' on 2013-01-09 at 74c3498)
 + doc: push.default is no longer "matching"
 + push: switch default from "matching" to "simple"
 + t9401: do not assume the "matching" push is the default
 + t9400: do not assume the "matching" push is the default
 + t7406: do not assume the "matching" push is the default
 + t5531: do not assume the "matching" push is the default
 + t5519: do not assume the "matching" push is the default
 + t5517: do not assume the "matching" push is the default
 + t5516: do not assume the "matching" push is the default
 + t5505: do not assume the "matching" push is the default
 + t5404: do not assume the "matching" push is the default

 Will cook in 'next' until Git 2.0 ;-).


* bc/append-signed-off-by (2013-01-27) 11 commits
 - Unify appending signoff in format-patch, commit and sequencer
 - format-patch: update append_signoff prototype
 - t4014: more tests about appending s-o-b lines
 - sequencer.c: teach append_signoff to avoid adding a duplicate newline
 - sequencer.c: teach append_signoff how to detect duplicate s-o-b
 - sequencer.c: always separate "(cherry picked from" from commit body
 - sequencer.c: recognize "(cherry picked from ..." as part of s-o-b footer
 - t/t3511: add some tests of 'cherry-pick -s' functionality
 - t/test-lib-functions.sh: allow to specify the tag name to test_commit
 - commit, cherry-pick -s: remove broken support for multiline rfc2822 fields
 - sequencer.c: rework search for start of footer to improve clarity

 Rerolled.  With help from Jonathan, I think this is getting closer.

--------------------------------------------------
[Discarded]

* jk/update-install-for-p4 (2013-01-20) 1 commit
 . INSTALL: git-p4 doesn't support Python 3

 Made obsolete by bc/git-p4-for-python-2.4 topic.
