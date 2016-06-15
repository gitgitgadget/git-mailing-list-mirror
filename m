From: Jonathan Nieder <jrnieder@gmail.com>
Subject: What's cooking in git.git (Sep 2013, #08; Wed, 25)
Date: Wed, 25 Sep 2013 16:41:21 -0700
Message-ID: <20130925234121.GD9464@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 26 01:41:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOyi4-0007Gf-ON
	for gcvg-git-2@plane.gmane.org; Thu, 26 Sep 2013 01:41:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755176Ab3IYXl2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Sep 2013 19:41:28 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:34030 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754846Ab3IYXl0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Sep 2013 19:41:26 -0400
Received: by mail-pd0-f176.google.com with SMTP id q10so332778pdj.35
        for <git@vger.kernel.org>; Wed, 25 Sep 2013 16:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=grdofA+GKIeEcSh28pdzAEFawTOZpIoBRmFQF1wYZ3E=;
        b=EB48dJiDG5H048EXJCgjAuyuNOlyRt669mK5XZbdHPuJbFsdueiyijG3ZMopflhYit
         yEnnsJtWNPjOX7NDYbCWYnPDKwMwVae55EPiOnheoysilIvtrNtVjUS+NJHzCX7zV6jJ
         Ll8xrCx98EcP2QQcBrJn57HUJLDKwPMbPbLjEhgQIxg4e0tU0dSXy4HElL/mpyprl2U6
         xAdZde9ixwpTiy6dKU8tWensDXMBuzvN2QUfgrl6JxBb3jJv+CDwIXZNFLdmuVUox5Xh
         RbnF9/wIvPFBnHfvMzL8pImeknfYlG3nLRXDlTGio3NfXOm9vGqmcbhBQXwEllKpSNfW
         r4VQ==
X-Received: by 10.66.157.165 with SMTP id wn5mr1764840pab.169.1380152485784;
        Wed, 25 Sep 2013 16:41:25 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id im2sm50201034pbd.31.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 25 Sep 2013 16:41:24 -0700 (PDT)
Content-Disposition: inline
X-master-at: 5636a20070c80dec23cc6d6180cb1dd958e23bca
X-next-at: 4eb0c1432dc51cbf104157b7b61914bbe4a0191d
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235381>

What's cooking in git.git (Sep 2013, #08; Wed, 25)
--------------------------------------------------

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

The fifth batch of topics are in 'master'.

You can find the changes described here in the integration branches at

    git://repo.or.cz/git/jrn.git
    http://repo.or.cz/r/git/jrn.git

Or view the web interface:

    http://repo.or.cz/w/git/jrn.git

I'll probably be releasing 1.8.4.1 tomorrow.  If you have time to
experiment with "maint" or "master" to find any remaining problems
until then, that will be very welcome.

--------------------------------------------------
[Graduated to "master"]

* bc/submodule-status-ignored (2013-09-11) 3 commits
  (merged to 'next' on 2013-09-11 at 9f66712)
 + Improve documentation concerning the status.submodulesummary setting
  (merged to 'next' on 2013-09-10 at a417960)
 + submodule: don't print status output with ignore=all
 + submodule: fix confusing variable name


* bp/mediawiki-infinite-loop-fix (2013-09-23) 1 commit
 - git-remote-mediawiki: bugfix for pages w/ >500 revisions

 The mediawiki:: remote helper would hang while handling results from
 queries with more than 500 results against version 1.21 or newer of
 the Mediawiki server.


* cc/replace-with-the-same-type (2013-09-09) 8 commits
  (merged to 'next' on 2013-09-17 at 34b5bb7)
 + Doc: 'replace' merge and non-merge commits
 + t6050-replace: use some long option names
 + replace: allow long option names
 + Documentation/replace: add Creating Replacement Objects section
 + t6050-replace: add test to clean up all the replace refs
 + t6050-replace: test that objects are of the same type
 + Documentation/replace: state that objects must be of the same type
 + replace: forbid replacing an object with one of a different type

 Using the replace mechanism to swap an object with another object
 of a different type can introduce inconsistency (e.g. a tree
 expects an object name to refer to a blob, but the blob object can
 be mistakenly or maliciously replaced with an object with a
 different type). Attempt to forbid such.


* es/contacts-in-subdir (2013-09-17) 1 commit
  (merged to 'next' on 2013-09-20 at d67164f)
 + contacts: fix to work in subdirectories

 Allows the contacts (in contrib/) script to run from inside a
 subdirectory.


* jc/push-cas (2013-09-20) 1 commit
  (merged to 'next' on 2013-09-20 at 5e1e7cc)
 + t5541: mark passing c-a-s test as success

 A touch-up to finish off a recently added feature.


* jc/strcasecmp-pure-inline (2013-09-12) 1 commit
  (merged to 'next' on 2013-09-20 at 7142d08)
 + mailmap: work around implementations with pure inline strcasecmp

 Work around MinGW <string.h> header that does not declare strcasecmp
 whose address cannot be taken.


* jk/shortlog-tolerate-broken-commit (2013-09-18) 1 commit
  (merged to 'next' on 2013-09-20 at 9c85c02)
 + shortlog: ignore commits with missing authors


* kb/msvc-compile (2013-09-11) 5 commits
  (merged to 'next' on 2013-09-17 at a9bcbb5)
 + Windows: do not redefine _WIN32_WINNT
 + MinGW: Fix stat definitions to work with MinGW runtime version 4.0
 + MSVC: fix stat definition hell
 + MSVC: fix compile errors due to macro redefinitions
 + MSVC: fix compile errors due to missing libintl.h

 Build updates for Windows port.


* nd/fetch-pack-error-reporting-fix (2013-09-18) 1 commit
  (merged to 'next' on 2013-09-20 at fefa04f)
 + fetch-pack.c: show correct command name that fails

 When "fetch-pack" detected an error from spawned "index-pack" or
 "unpack-objects", it did not report the failed program name
 correctly when a shallow repository is involved.


* nd/unpack-entry-optim-in-pack-objects (2013-09-13) 1 commit
  (merged to 'next' on 2013-09-17 at 00f7335)
 + pack-objects: no crc check when the cached version is used

 The codepath to use data from packfiles that is only exercised in
 pack-objects unnecessarily checked crc checksum of the pack data,
 even when it ends up using in-core copy that it got by reading from
 the pack (at which point the checksum was validated).


* sg/complete-untracked-filter (2013-09-19) 1 commit
  (merged to 'next' on 2013-09-20 at 798d0b9)
 + completion: improve untracked directory filtering for filename completion

--------------------------------------------------
[New Topics]

* bc/gnome-keyring (2013-09-23) 15 commits
 - contrib/git-credential-gnome-keyring.c: support really ancient gnome-keyring
 - contrib/git-credential-gnome-keyring.c: support ancient gnome-keyring
 - contrib/git-credential-gnome-keyring.c: report failure to store password
 - contrib/git-credential-gnome-keyring.c: use glib messaging functions
 - contrib/git-credential-gnome-keyring.c: use glib memory allocation functions
 - contrib/git-credential-gnome-keyring.c: use secure memory for reading passwords
 - contrib/git-credential-gnome-keyring.c: use secure memory functions for passwds
 - contrib/git-credential-gnome-keyring.c: use gnome helpers in keyring_object()
 - contrib/git-credential-gnome-keyring.c: ensure buffer is non-empty before accessing
 - contrib/git-credential-gnome-keyring.c: strlen() returns size_t, not ssize_t
 - contrib/git-credential-gnome-keyring.c: set Gnome application name
 - contrib/git-credential-gnome-keyring.c: exit non-zero when called incorrectly
 - contrib/git-credential-gnome-keyring.c: add static where applicable
 - contrib/git-credential-gnome-keyring.c: remove unused die() function
 - contrib/git-credential-gnome-keyring.c: remove unnecessary pre-declarations

 Cleanups and tweaks for credential handling to work with ancient versions
 of the gnome-keyring library that are still in use.

 This is version 1 of the series, to give it more exposure.  Waiting for
 the series to stabilize before including in 'next'.


* kb/fast-hashmap (2013-09-25) 6 commits
 - fixup! diffcore-rename.c: simplify finding exact renames
 - diffcore-rename.c: use new hash map implementation
 - diffcore-rename.c: simplify finding exact renames
 - diffcore-rename.c: move code around to prepare for the next patch
 - buitin/describe.c: use new hash map implementation
 - add a hashtable implementation that supports O(1) removal

 Improvements to our hash table to get it to meet the needs of the
 msysgit fscache project, with some nice performance improvements.
 
 Looks promising.  Needs style review and a sanity-check on the
 design before including in 'next'.  Expecting a reroll once review
 settles down.

--------------------------------------------------
[Stalled]

* tr/merge-recursive-index-only (2013-07-07) 3 commits
 - merge-recursive: -Xindex-only to leave worktree unchanged
 - merge-recursive: untangle double meaning of o->call_depth
 - merge-recursive: remove dead conditional in update_stages()

 Will hold until there is a caller to learn from.


* jc/ref-excludes (2013-09-03) 2 commits
 - document --exclude option
 - revision: introduce --exclude=<glob> to tame wildcards

 People often wished a way to tell "git log --branches" (and "git
 log --remotes --not --branches") to exclude some local branches
 from the expansion of "--branches" (similarly for "--tags", "--all"
 and "--glob=<pattern>").  Now they have one.

 Needs a matching change to rev-parse.


* rv/send-email-cache-generated-mid (2013-08-21) 2 commits
 - git-send-email: Cache generated message-ids, use them when prompting
 - git-send-email: add optional 'choices' parameter to the ask sub


* rj/read-default-config-in-show-ref-pack-refs (2013-06-17) 3 commits
 - ### DONTMERGE: needs better explanation on what config they need
 - pack-refs.c: Add missing call to git_config()
 - show-ref.c: Add missing call to git_config()

 The changes themselves are probably good, but it is unclear what
 basic setting needs to be read for which exact operation.

 Waiting for clarification.
 $gmane/228294


* jh/shorten-refname (2013-05-07) 4 commits
 - t1514: refname shortening is done after dereferencing symbolic refs
 - shorten_unambiguous_ref(): Fix shortening refs/remotes/origin/HEAD to origin
 - t1514: Demonstrate failure to correctly shorten "refs/remotes/origin/HEAD"
 - t1514: Add tests of shortening refnames in strict/loose mode

 When remotes/origin/HEAD is not a symbolic ref, "rev-parse
 --abbrev-ref remotes/origin/HEAD" ought to show "origin", not
 "origin/HEAD", which is fixed with this series (if it is a symbolic
 ref that points at remotes/origin/something, then it should show
 "origin/something" and it already does).

 Expecting a reroll, as an early part of a larger series.
 $gmane/225137


* mg/more-textconv (2013-05-10) 7 commits
 - grep: honor --textconv for the case rev:path
 - grep: allow to use textconv filters
 - t7008: demonstrate behavior of grep with textconv
 - cat-file: do not die on --textconv without textconv filters
 - show: honor --textconv for blobs
 - diff_opt: track whether flags have been set explicitly
 - t4030: demonstrate behavior of show with textconv

 Make "git grep" and "git show" pay attention to --textconv when
 dealing with blob objects.

 There was a question about how defaulting to 'git show --textconv'
 would interact with the "git show HEAD:file.c >file.c" habit.
 $gmane/221833


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
 - gitweb: Don't append ';js=(0|1)' to external links
 - gitweb: Make feed title valid utf8
 - gitweb: Fix utf8 encoding for blob_plain, blobdiff_plain, commitdiff_plain, and patch

 Various fixes to gitweb.

 Drew Northup volunteered to take a look into this.
 $gmane/226216


* jc/show-branch (2013-06-07) 5 commits
 - show-branch: use commit slab to represent bitflags of arbitrary width
 - show-branch.c: remove "all_mask"
 - show-branch.c: abstract out "flags" operation
 - show-branch.c: lift all_mask/all_revs to a global static
 - show-branch.c: update comment style

 Waiting for the final step to lift the hard-limit before sending it out.

--------------------------------------------------
[Cooking]

* jc/revision-range-unpeel (2013-09-20) 2 commits
 - (possible fixup) jc/revision-range-unpeel - peel only when necessary
 - revision: do not peel tags used in range notation

 "git rev-list --objects ^v1.0^ v1.0" gave v1.0 tag itself in the
 output, but "git rev-list --objects v1.0^..v1.0" did not.

 Need to decide either squashing the top fixup in, or dropping it
 and then merge to 'next'.


* tg/perf-lib-test-perf-cleanup (2013-09-19) 2 commits
 - perf-lib: add test_perf_cleanup target
 - perf-lib: split starting the test from the execution

 Add test_perf_cleanup shell function to the perf suite, that allows
 the script writers to define a test with a clean-up action.

 Holding until needed.


* jk/format-patch-from (2013-09-20) 1 commit
  (merged to 'next' on 2013-09-20 at 0506530)
 + format-patch: print in-body "From" only when needed

 "format-patch --from=<whom>" forgot to omit unnecessary in-body
 from line, i.e. when <whom> is the same as the real author.

 Will merge to 'master'.


* es/name-hash-no-trailing-slash-in-dirs (2013-09-17) 4 commits
  (merged to 'next' on 2013-09-20 at 9633d9a)
 + dir: revert work-around for retired dangerous behavior
 + name-hash: stop storing trailing '/' on paths in index_state.dir_hash
 + employ new explicit "exists in index?" API
 + name-hash: refactor polymorphic index_name_exists()

 Clean up the internal of the name-hash mechanism used to work
 around case insensitivity on some filesystems to cleanly fix a
 long-standing API glitch where the caller of cache_name_exists()
 that ask about a directory with a counted string was required to
 have '/' at one location past the end of the string.

 Will merge to 'master'.


* po/dot-url (2013-09-13) 2 commits
  (merged to 'next' on 2013-09-20 at 6a12786)
 + config doc: update dot-repository notes
 + doc: command line interface (cli) dot-repository dwimmery

 Explain how '.' can be used to refer to the "current repository"
 in the documentation.

 Will merge to 'master'.


* jc/upload-pack-send-symref (2013-09-17) 7 commits
 - clone: test the new HEAD detection logic
 - connect: annotate refs with their symref information in get_remote_head()
 - connect.c: make parse_feature_value() static
 - upload-pack: send non-HEAD symbolic refs
 - upload-pack: send symbolic ref information as capability
 - upload-pack.c: do not pass confusing cb_data to mark_our_ref()
 - t5505: fix "set-head --auto with ambiguous HEAD" test

 One long-standing flaw in the pack transfer protocol used by "git
 clone" was that there was no way to tell the other end which branch
 "HEAD" points at, and the receiving end needed to guess.  A new
 capability has been defined in the pack protocol to convey this
 information so that cloning from a repository with more than one
 branches pointing at the same commit where the HEAD is at now
 reliably sets the initial branch in the resulting repository.

 Will merge to 'next'.


* jk/clone-progress-to-stderr (2013-09-18) 3 commits
  (merged to 'next' on 2013-09-25 at 137af9e)
 + clone: always set transport options
 + clone: treat "checking connectivity" like other progress
 + clone: send diagnostic messages to stderr

 Some progress and diagnostic messages from "git clone" were
 incorrectly sent to the standard output stream, not to the standard
 error stream.

 Will merge to 'master'.


* jx/relative-path-regression-fix (2013-09-20) 3 commits
 - Use simpler relative_path when set_git_dir
 - relative_path should honor dos-driver-prefix
 - test: use unambigous leading path (/foo) for mingw

 Waiting for the review to settle.


* jc/checkout-detach-doc (2013-09-11) 1 commit
  (merged to 'next' on 2013-09-17 at 438cf13)
 + checkout: update synopsys and documentation on detaching HEAD

 "git checkout [--detach] <commit>" was listed poorly in the
 synopsis section of its documentation.

 Will merge to 'master'.


* jk/trailing-slash-in-pathspec (2013-09-13) 2 commits
  (merged to 'next' on 2013-09-17 at 18fe277)
 + reset: handle submodule with trailing slash
 + rm: re-use parse_pathspec's trailing-slash removal

 Code refactoring.

 Will merge to 'master'.


* lc/filter-branch-too-many-refs (2013-09-12) 1 commit
  (merged to 'next' on 2013-09-17 at 31cd01a)
 + Allow git-filter-branch to process large repositories with lots of branches.

 "git filter-branch" in a repository with many refs blew limit of
 command line length.

 Will merge to 'master'.


* np/pack-v4 (2013-09-18) 90 commits
 - packv4-parse.c: add tree offset caching
 - t1050: replace one instance of show-index with verify-pack
 - index-pack, pack-objects: allow creating .idx v2 with .pack v4
 - unpack-objects: decode v4 trees
 - unpack-objects: allow to save processed bytes to a buffer
 - ...

 Nico and Duy advancing the eternal vaporware pack-v4.  This is here
 primarily for wider distribution of the preview edition.


* sb/repack-in-c (2013-09-17) 3 commits
  (merged to 'next' on 2013-09-25 at 7c47036)
 + repack: improve warnings about failure of renaming and removing files
 + repack: retain the return value of pack-objects
 + repack: rewrite the shell script in C

 Rerolled, and I think it is in a reasonably good shape.

 Will merge to 'master'.


* jc/reflog-doc (2013-06-19) 1 commit
  (merged to 'next' on 2013-09-25 at 4eb0c14)
 + setup_reflog_action: document the rules for using GIT_REFLOG_ACTION

 Document rules to use GIT_REFLOG_ACTION variable in the scripted
 Porcelain.  git-rebase--interactive locally violates them, but it
 is a leaf user that does not call out to or dot-source other
 scripts, so it does not urgently need to be fixed.

 Will merge to 'master'.


* jn/add-2.0-u-A-sans-pathspec (2013-04-26) 1 commit
 - git add: -u/-A now affects the entire working tree

 Will cook in 'next' until Git 2.0.


* jc/core-checkstat-2.0 (2013-05-06) 1 commit
 - core.statinfo: remove as promised in Git 2.0

 Will cook in 'next' until Git 2.0.


* jc/push-2.0-default-to-simple (2013-06-18) 1 commit
 - push: switch default from "matching" to "simple"

 Will cook in 'next' until Git 2.0.


* jc/add-2.0-ignore-removal (2013-04-22) 1 commit
 - git add <pathspec>... defaults to "-A"

 Updated endgame for "git add <pathspec>" that defaults to "--all"
 aka "--no-ignore-removal".

 Will cook in 'next' until Git 2.0.


* jc/hold-diff-remove-q-synonym-for-no-deletion (2013-07-19) 1 commit
 - diff: remove "diff-files -q" in a version of Git in a distant future

 Will cook in 'next' until a distant future.

--------------------------------------------------
[Discarded]

* jc/pull-training-wheel (2013-07-19) 1 commit
  (merged to 'next' on 2013-08-28 at c39bd15)
 + pull: require choice between rebase/merge on non-fast-forward pull

 Make "git pull" (without arguments that say what branch to
 integrate from where) refuse with "it does not fast forward; choose
 between 'pull --merge' and 'pull --rebase'".

 This topic has been reverted from 'next'.  Will wait for the
 conclusion of the discussion to seek a more user-friendly
 alternative; it is likely that it will be based on the simpler
 approach Felipe posted earlier.
