From: Jonathan Nieder <jrnieder@gmail.com>
Subject: What's cooking in git.git (Oct 2013, #02; Mon, 14)
Date: Mon, 14 Oct 2013 17:12:31 -0700
Message-ID: <20131015001231.GA9464@google.com>
References: <20131014184524.GW9464@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 15 02:14:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVsHb-0000JE-H7
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 02:14:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474Ab3JOAOj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 20:14:39 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:59878 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756865Ab3JOAMe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 20:12:34 -0400
Received: by mail-pd0-f173.google.com with SMTP id p10so8066748pdj.4
        for <git@vger.kernel.org>; Mon, 14 Oct 2013 17:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=q50K92BQ3gbY41uV0DkdQ7zYIb1YiUU01gFbb9Z+OL4=;
        b=vpGu9W5BBB8Zh2Ugf6z8PxjCwuchPPS13gJSKgxmYyRJNqINf5+reXL1phPk3c3yHm
         FJ6IVnFbbbcDIfh5Hd5LxB7Q/LgSPmxKXiv6maMSfNzwExm2phqK08vi7FG+lLtNvulg
         AHMV/fRADfdsvBLalSgrTOf6HBgAVOY3+8GSlyZEKFvshkVyMz/UpLUyJaJrAIaNisQV
         SBfKfN/+tVSpBSOlnztiqfVn7RTzYl5+b6W7kyq1R7HqiIEul5guuaoHgefvbdoM6jWi
         GZlNH+bnvR24gyx+EJuGl7QN18UXxlUg7PrWSbvEw4sc4GiFRlJ31FJEaZ3ir8h7yZcU
         OwEg==
X-Received: by 10.68.117.49 with SMTP id kb17mr38609990pbb.112.1381795953914;
        Mon, 14 Oct 2013 17:12:33 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id dk3sm80510321pbc.32.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 14 Oct 2013 17:12:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20131014184524.GW9464@google.com>
X-master-at: 2b7ca916fcffafe9cfd967cce87436a9372ae969
X-next-at: de5dd42fdd555936f677232024b1b20893279fac
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236156>

What's cooking in git.git (Oct 2013, #02; Mon, 14)
--------------------------------------------------

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

Tying up loose ends before the hand-off.

The changes described here are in the integration branches at

    https://googlers.googlesource.com/jrn/git
    git://repo.or.cz/git/jrn.git
    git://gitorious.org/git/jrn.git
    https://github.com/jrn/git

--------------------------------------------------
[Stalled]

* tr/merge-recursive-index-only (2013-07-07) 3 commits
 - merge-recursive: -Xindex-only to leave worktree unchanged
 - merge-recursive: untangle double meaning of o->call_depth
 - merge-recursive: remove dead conditional in update_stages()

 Holding until there is a caller to learn from.


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
  (merged to 'next' on 2013-10-14 at 8a12490)
 + grep: honor --textconv for the case rev:path
 + grep: allow to use textconv filters
 + t7008: demonstrate behavior of grep with textconv
 + cat-file: do not die on --textconv without textconv filters
 + show: honor --textconv for blobs
 + diff_opt: track whether flags have been set explicitly
 + t4030: demonstrate behavior of show with textconv

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

* ak/submodule-foreach-quoting (2013-09-27) 1 commit
  (merged to 'next' on 2013-10-14 at d77c5f1)
 + submodule foreach: skip eval for more than one argument

 A behavior change, but a worthwhile one: "git submodule foreach"
 was treating its arguments as part of a single command to be
 concatenated and passed to a shell, making writing buggy
 scripts too easy.

 This patch preserves the old "just pass it to the shell" behavior
 when a single argument is passed to 'git submodule foreach' and
 moves to a new "skip the shell and use the arguments passed
 unmolested" behavior when more than one argument is passed.

 The old behavior (always concatenating and passing to the shell)
 was similar to the 'ssh' command, while the new behavior (switching
 on the number of arguments) is what 'xterm -e' does.

 May need more thought to make sure this change is advertised well
 so that scripts that used multiple arguments but added their own
 extra layer of quoting are not broken.


* ew/keepalive (2013-10-14) 1 commit
  (merged to 'next' on 2013-10-14 at 24d786f)
 + http: enable keepalive on TCP sockets

 $gmane/236154 has a follow-up to do more magic with recent curl.


* hu/cherry-pick-previous-branch (2013-10-10) 1 commit
  (merged to 'next' on 2013-10-14 at 090934f)
 + cherry-pick: handle "-" after parsing options

 "git cherry-pick" without further options would segfault.

 Could use a follow-up to handle '-' after argv[1] better.


* jc/pack-objects (2013-02-04) 1 commit
  (merged to 'next' on 2013-10-14 at 8e8feb6)
 + pack-objects: shrink struct object_entry


* jc/prompt-upstream (2013-10-14) 1 commit
  (merged to 'next' on 2013-10-14 at 270ef7b)
 + git-prompt.sh: optionally show upstream branch name

 An enhancement to the GIT_PS1_SHOWUPSTREAM facility.


* jk/http-auth-redirects (2013-10-14) 9 commits
 - remote-curl: rewrite base url from info/refs redirects
 - remote-curl: store url as a strbuf
 - remote-curl: make refs_url a strbuf
 - http: update base URLs when we see redirects
 - http: provide effective url to callers
 - http: hoist credential request out of handle_curl_result
  (merged to 'next' on 2013-10-14 at a0642be)
 + http: refactor options to http_get_*
 + http_request: factor out curlinfo_strbuf
 + http_get_file: style fixes


* jl/submodule-mv (2013-10-13) 1 commit
 - mv: Fix spurious warning when moving a file in presence of submodules

 Moving a regular file in a repository with a .gitmodules file was
 producing a warning 'Could not find section in .gitmodules where
 path=<filename>'.

 The test can use a little cleanup.  Otherwise looks good.


* yt/shortened-rename (2013-10-13) 1 commit
 - diff.c: keep arrow(=>) on show_stats()'s shortened filename part to make rename visible.

 Expecting a reroll.


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


* jx/relative-path-regression-fix (2013-10-14) 3 commits
 - Use simpler relative_path when set_git_dir
  (merged to 'next' on 2013-10-14 at 704b9ee)
 + relative_path should honor dos-drive-prefix
 + test: use unambigous leading path (/foo) for MSYS

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
