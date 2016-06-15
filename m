From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Sep 2013, #03; Wed, 11)
Date: Wed, 11 Sep 2013 16:32:23 -0700
Message-ID: <xmqqzjrjq6ig.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 12 01:32:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJttg-0004qR-Sj
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 01:32:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754620Ab3IKXc3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 19:32:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52732 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752523Ab3IKXc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 19:32:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3783841337;
	Wed, 11 Sep 2013 23:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=W
	KyK0UhmnOPb2sN7LblmYawsmBE=; b=ieNMaQIpUQUSXb+ixsQ7Uuz2jvbocHYBl
	IH72Iqa2dZzVYEcaA/WklizKNFHZHgTIciseTuI8eCesVfhLL3AVFBsOwk+ij8wG
	ZVJ/Ju+SlkTU8WRzDmbX6BATqNlrrb7mXpYxTlS/wUttDlQIE3V0WaRhjex0YhSn
	EesK3HeRcA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=YPa
	UABflOa/U7S1FFoVr8eX3q9RbjyeU8e02QsYLCKIMMCmxlAP6aRvu/+z/QoABy7T
	x2MDUsZJHULC8PL8+PW63A7Gmsf6sOwwROwPEBpOc7VvRMoPvWzA7x52LEi4hPKU
	jPtOEpvA2rbvawxm55xXC72oG2zZnoEmimr1c7O0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 288F441336;
	Wed, 11 Sep 2013 23:32:26 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CF73141329;
	Wed, 11 Sep 2013 23:32:24 +0000 (UTC)
X-master-at: a194eaddca201163aa756faccd519f056bd3c35e
X-next-at: 424cb083fbc33c0ccd89e8d591920f438eab564d
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 69D09BC2-1B3A-11E3-BE8A-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234613>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

The second batch of topics are now in 'master'.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* es/rebase-i-no-abbrev (2013-08-25) 3 commits
  (merged to 'next' on 2013-09-04 at 6027805)
 + rebase -i: fix short SHA-1 collision
 + t3404: rebase -i: demonstrate short SHA-1 collision
 + t3404: make tests more self-contained

 Originally merged to 'next' on 2013-08-26

 The commit object names in the insn sheet that was prepared at the
 beginning of "rebase -i" session can become ambiguous as the
 rebasing progresses and the repository gains more commits. Make
 sure the internal record is kept with full 40-hex object names.


* es/rebase-i-respect-core-commentchar (2013-08-18) 1 commit
  (merged to 'next' on 2013-09-04 at 8c1ce68)
 + rebase -i: fix cases ignoring core.commentchar

 Originally merged to 'next' on 2013-08-20

 "rebase -i" forgot that the comment character can be configurable
 while reading its insn sheet.


* jc/ls-files-killed-optim (2013-08-23) 4 commits
  (merged to 'next' on 2013-09-04 at 20c2304)
 + dir.c::test_one_path(): work around directory_exists_in_index_icase() breakage
 + t3010: update to demonstrate "ls-files -k" optimization pitfalls
 + ls-files -k: a directory only can be killed if the index has a non-directory
 + dir.c: use the cache_* macro to access the current index

 Originally merged to 'next' on 2013-08-27

 "git ls-files -k" needs to crawl only the part of the working tree
 that may overlap the paths in the index to find killed files, but
 shared code with the logic to find all the untracked files, which
 made it unnecessarily inefficient.


* jn/post-receive-utf8 (2013-08-05) 3 commits
  (merged to 'next' on 2013-09-04 at 3a3f480)
 + hooks/post-receive-email: set declared encoding to utf-8
 + hooks/post-receive-email: force log messages in UTF-8
 + hooks/post-receive-email: use plumbing instead of git log/show

 Originally merged to 'next' on 2013-08-20

 Update post-receive-email script to make sure the message contents
 and pathnames are encoded consistently in UTF-8.


* js/xread-in-full (2013-08-20) 1 commit
  (merged to 'next' on 2013-09-04 at 5bfb049)
 + stream_to_pack: xread does not guarantee to read all requested bytes

 Originally merged to 'next' on 2013-08-20

 A call to xread() was used without a loop around to cope with short
 read in the codepath to stream new contents to a pack.


* nd/push-no-thin (2013-08-13) 1 commit
  (merged to 'next' on 2013-09-04 at faa8c02)
 + push: respect --no-thin

 Originally merged to 'next' on 2013-08-14

 "git push --no-thin" was a no-op by mistake.


* rt/rebase-p-no-merge-summary (2013-08-21) 1 commit
  (merged to 'next' on 2013-09-04 at d8d89ee)
 + rebase --preserve-merges: ignore "merge.log" config

 Originally merged to 'next' on 2013-08-22

 "git rebase -p" internally used the merge machinery, but when
 rebasing, there should not be a need for merge summary.


* sb/mailmap-freeing-NULL-is-ok (2013-08-20) 1 commit
  (merged to 'next' on 2013-09-04 at c831015)
 + mailmap: remove redundant check for freeing memory

 Originally merged to 'next' on 2013-08-20


* sh/pull-rebase-preserve (2013-09-04) 1 commit
  (merged to 'next' on 2013-09-04 at 32a93bb)
 + pull: allow pull to preserve merges when rebasing

 Originally merged to 'next' on 2013-08-14

 "git pull --rebase" always flattened the history; pull.rebase can
 now be set to "preserve" to invoke "rebase --preserve-merges".


* tf/gitweb-ss-tweak (2013-08-20) 4 commits
  (merged to 'next' on 2013-09-04 at 774bfbe)
 + gitweb: make search help link less ugly
 + gitweb: omit the repository owner when it is unset
 + gitweb: vertically centre contents of page footer
 + gitweb: ensure OPML text fits inside its box

 Originally merged to 'next' on 2013-08-22

 Tweak Gitweb CSS to layout some elements better.

--------------------------------------------------
[New Topics]

* bc/send-email-ssl-die-message-fix (2013-09-10) 1 commit
 - send-email: don't call methods on undefined values

 When send-email comes up with an error message to die with upon
 failure to start an SSL session, it tried to read the error string
 from a wrong place.

 Will merge to 'next'.


* jc/checkout-detach-doc (2013-09-11) 1 commit
 - checkout: update synopsys and documentation on detaching HEAD

 "git checkout [--detach] <commit>" was listed poorly in the
 synopsis section of its documentation.


* jc/cvsserver-perm-bit-fix (2013-09-11) 1 commit
 - cvsserver: pick up the right mode bits

 "git cvsserver" computed the permission mode bits incorrectly for
 executable files.

 Will merge to 'next'.


* jk/trailing-slash-in-pathspec (2013-09-10) 2 commits
 - rm: re-use parse_pathspec's trailing-slash removal
 - reset: handle submodule with trailing slash

 Needs a reroll?


* kb/msvc-compile (2013-09-11) 5 commits
 - Windows: do not redefine _WIN32_WINNT
 - MinGW: Fix stat definitions to work with MinGW runtime version 4.0
 - MSVC: fix stat definition hell
 - MSVC: fix compile errors due to macro redefinitions
 - MSVC: fix compile errors due to missing libintl.h

 Build updates for Windows port.


* lc/filter-branch-too-many-refs (2013-09-11) 2 commits
 - ### DONOTMERGE - missing sign-off
 - Allow git-filter-branch to process large repositories with lots of branches.

 "git filter-branch" in a repository with many refs blew limit of
 command line length.

 Needs a sign-off.


* mm/commit-template-squelch-advice-messages (2013-09-11) 2 commits
 - commit: disable status hints when writing to COMMIT_EDITMSG
 - wt-status: turn advice_status_hints into a field of wt_status

 From the commit log template, remove irrelevant "advice" messages
 that are shared with "git status" output.

 Will merge to 'next'.


* np/lookup-object-hashing (2013-09-11) 1 commit
 - lookup_object: remove hashtable_index() and optimize hash_obj()

 Micro optimize hash function used in the object hash table.

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

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

 I thought this was pretty well designed and executed, but it seems
 there are some doubts on the list; kicked back to 'pu'.


* jc/format-patch (2013-04-22) 2 commits
 - format-patch: --inline-single
 - format-patch: rename "no_inline" field

 A new option to send a single patch to the standard output to be
 appended at the bottom of a message.  I personally have no need for
 this, but it was easy enough to cobble together.  Tests, docs and
 stripping out more MIMEy stuff are left as exercises to interested
 parties.

 Not ready for inclusion.

 Will discard unless we hear from anybody who is interested in
 tying its loose ends.


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

* js/add-i-mingw (2013-09-04) 1 commit
  (merged to 'next' on 2013-09-10 at 50ab841)
 + add--interactive: fix external command invocation on Windows

 The implementation of "add -i" has a crippling code to work around
 ActiveState Perl limitation but it by mistake also triggered on Git
 for Windows where MSYS perl is used.

 Will merge to 'master' in the third batch.


* rh/ishes-doc (2013-09-04) 7 commits
  (merged to 'next' on 2013-09-10 at 3611e8a)
 + glossary: fix and clarify the definition of 'ref'
 + revisions.txt: fix and clarify <rev>^{<type>}
 + glossary: more precise definition of tree-ish (a.k.a. treeish)
 + use 'commit-ish' instead of 'committish'
 + use 'tree-ish' instead of 'treeish'
 + glossary: define commit-ish (a.k.a. committish)
 + glossary: mention 'treeish' as an alternative to 'tree-ish'

 We liberally use "committish" and "commit-ish" (and "treeish" and
 "tree-ish"); as these are non-words, let's unify these terms to
 their dashed form.  More importantly, clarify the documentation on
 object peeling using these terms.

 Will merge to 'master' in the third batch.


* jc/commit-is-spelled-with-two-ems (2013-09-05) 2 commits
  (merged to 'next' on 2013-09-05 at 982aef2)
 + typofix: cherry is spelled with two ars
 + typofix: commit is spelled with two ems

 Will merge to 'master' in the third batch.


* bc/http-backend-allow-405 (2013-09-09) 1 commit
 - http-backend: provide Allow header for 405

 When the webserver responds with "405 Method Not Allowed", it
 should tell the client what methods are allowed with the "Allow"
 header.

 Will merge to 'next'.


* dw/check-ignore-sans-index (2013-09-05) 2 commits
 - SQUASH??? do not let --no-index squat on short-and-sweet -i for now
 - check-ignore: Add option to ignore index contents

 "git check-ignore" follows the same rule as "git add" and "git
 status" in that the ignore/exclude mechanism does not take effect
 on paths that are already tracked.  With "--no-index" option, it
 can be used to diagnose which paths that should have been ignored
 have been mistakenly added to the index.

 Will squash the tip in and merge to 'next'.


* hu/cherry-pick-previous-branch (2013-09-09) 1 commit
 - cherry-pick: allow "-" as abbreviation of '@{-1}'

 Just like "git checkout -" knows to check out and "git merge -"
 knows to merge the branch you were previously on, teach "git
 cherry-pick" to understand "-" as the previous branch.

 Will merge to 'next'.


* jh/checkout-auto-tracking (2013-09-09) 5 commits
 - branch.c: Relax unnecessary requirement on upstream's remote ref name
 - t3200: Add test demonstrating minor regression in 41c21f2
 - Refer to branch.<name>.remote/merge when documenting --track
 - t3200: Minor fix when preparing for tracking failure
 - t2024: Fix &&-chaining and a couple of typos

 Fix a minor regression in v1.8.3.2 and later that made it
 impossible to base your local work on anything but a local branch
 of the upstream repository you are tracking from.

 Will merge to 'next'.


* jk/remove-remote-helpers-in-python (2013-09-09) 1 commit
  (merged to 'next' on 2013-09-10 at 49c7a74)
 + git_remote_helpers: remove little used Python library

 Remove now disused remote-helpers framework for helpers written in
 Python.

 Will merge to 'master' in the third batch.


* jk/upload-pack-keepalive (2013-09-09) 2 commits
 - upload-pack: bump keepalive default to 5 seconds
 - upload-pack: send keepalive packets during pack computation

 When running "fetch -q", a long silence while the sender side
 computes the set of objects to send can be mistaken by proxies as
 dropped connection.

 Will merge to 'next'.


* mm/rebase-continue-freebsd-WB (2013-09-09) 1 commit
 - rebase: fix run_specific_rebase's use of "return" on FreeBSD

 Work around a bug in FreeBSD shell that caused a regression to "git
 rebase" in v1.8.4.  It would be lovely to hear from FreeBSD folks a
 success report to make sure we didn't miss any other use of a bare
 "return" from dot-sourced script.

 Will merge to 'next'.


* ss/doclinks (2013-09-06) 1 commit
  (merged to 'next' on 2013-09-10 at 2d029a9)
 + Documentation: make AsciiDoc links always point to HTML files

 When we converted many documents that were traditionally text-only
 to be formatted to AsciiDoc, we did not update links that point at
 them to refer to the formatted HTML files.

 Will merge to 'master' in the third batch.


* uh/git-svn-serf-fix (2013-09-06) 1 commit
 - git-svn: fix termination issues for remote svn connections

 "git-svn" used with SVN 1.8.0 when talking over https:// connection
 dumped core due to a bug in the serf library that SVN uses.  Work
 it around on our side, even though the SVN side is being fixed.


* fc/contrib-bzr-hg-fixes (2013-09-03) 10 commits
 - contrib/remote-helpers: quote variable references in redirection targets
 - contrib/remote-helpers: style updates for test scripts
 - remote-hg: use notes to keep track of Hg revisions
 - remote-helpers: cleanup more global variables
 - remote-helpers: trivial style fixes
 - remote-hg: improve basic test
 - remote-hg: add missing &&s in the test
 - remote-hg: fix test
 - remote-bzr: make bzr branches configurable per-repo
 - remote-bzr: fix export of utf-8 authors

 Will merge to 'next'.


* jc/pager-configuration-doc (2013-08-29) 1 commit
  (merged to 'next' on 2013-09-05 at 3169083)
 + config: rewrite core.pager documentation

 It was unclear in the documentation how various configurations and
 environment variables determine which pager is eventually used.

 Will merge to 'master' in the third batch.


* np/pack-v4 (2013-09-11) 88 commits
 - t1050: replace one instance of show-index with verify-pack
 - index-pack, pack-objects: allow creating .idx v2 with .pack v4
 - unpack-objects: decode v4 trees
 - unpack-objects: allow to save processed bytes to a buffer
 - unpack-objects: decode v4 commits
 - ...

 Nico and Duy advancing the eternal vaporware pack-v4.  This is here
 primarily for wider distribution of the preview edition.


* jk/free-tree-buffer (2013-06-06) 1 commit
  (merged to 'next' on 2013-09-09 at 3576189)
 + clear parsed flag when we free tree buffers

 Will merge to 'master' in the third batch.


* jk/has-sha1-file-retry-packed (2013-08-30) 1 commit
  (merged to 'next' on 2013-09-09 at fc42e9b)
 + has_sha1_file: re-check pack directory before giving up

 When an object is not found after checking the packfiles and then
 loose object directory, read_sha1_file() re-checks the packfiles to
 prevent racing with a concurrent repacker; teach the same logic to
 has_sha1_file().

 Will merge to 'master' in the third batch.


* ab/gitweb-author-initials (2013-08-30) 1 commit
  (merged to 'next' on 2013-09-09 at ecb924d)
 + gitweb: Fix the author initials in blame for non-ASCII names

 Will merge to 'master' in the fourth batch.


* bk/refs-multi-update (2013-09-11) 8 commits
 - update-ref: add test cases covering --stdin signature
 - update-ref: support multiple simultaneous updates
 - refs: add update_refs for multiple simultaneous updates
 - refs: add function to repack without multiple refs
 - refs: factor delete_ref loose ref step into a helper
 - refs: factor update_ref steps into helpers
 - refs: report ref type from lock_any_ref_for_update
 - reset: rename update_refs to reset_refs

 Give "update-refs" a "--stdin" option to read multiple update
 requests and perform them in an all-or-none fashion.

 Looking good.

 Will merge to 'next'.


* fc/at-head (2013-09-09) 3 commits
 - SQUASH??? fixup
 - Add new @ shortcut for HEAD
 - sha1-name: pass len argument to interpret_branch_name()

 Attempt to resurrect "Type @ for HEAD"; the bottom one seems to be
 a genuine code improvement, but identifying cases where "@" means
 HEAD were harder than it should have been.  I think the result of
 squashing the tip one in covers all the necessary cases.

 Will squash the tip in and merge to 'next'.


* fc/fast-export (2013-09-03) 2 commits
  (merged to 'next' on 2013-09-09 at 8d5d396)
 + fast-export: refactor get_tags_and_duplicates()
 + fast-export: make extra_refs global

 Code simpification.

 Will merge to 'master' in the third batch.


* fc/rev-parse-test-updates (2013-09-03) 4 commits
  (merged to 'next' on 2013-09-09 at 92c51ef)
 + rev-parse test: use standard test functions for setup
 + rev-parse test: use test_cmp instead of "test" builtin
 + rev-parse test: use test_must_fail, not "if <command>; then false; fi"
 + rev-parse test: modernize quoting and whitespace

 Modernize tests.

 Will merge to 'master' in the third batch.


* fc/t3200-fixes (2013-09-03) 3 commits
  (merged to 'next' on 2013-09-09 at 3626363)
 + t: branch: fix broken && chains
 + t: branch: fix typo
 + t: branch: trivial style fix

 Will merge to 'master' in the third batch.


* fc/trivial (2013-09-08) 5 commits
  (merged to 'next' on 2013-09-09 at a8ad2e1)
 + pull: use $curr_branch_short more
 + add: trivial style cleanup
 + reset: trivial style cleanup
 + branch: trivial style fix
 + reset: trivial refactoring

 Will merge to 'master' in the third batch.


* jc/ref-excludes (2013-09-03) 2 commits
 - document --exclude option
 - revision: introduce --exclude=<glob> to tame wildcards

 People often wished a way to tell "git log --branches" (and "git
 log --remotes --not --branches") to exclude some local branches
 from the expansion of "--branches" (similarly for "--tags", "--all"
 and "--glob=<pattern>").  Now they have one.

 Will merge to 'next'.


* jk/pager-bypass-cat-for-default-pager (2013-09-03) 1 commit
  (merged to 'next' on 2013-09-09 at c9cfbaa)
 + pager: turn on "cat" optimization for DEFAULT_PAGER

 If a build-time fallback is set to "cat" instead of "less", we
 should apply the same "no subprocess or pipe" optimization as we
 apply to user-supplied GIT_PAGER=cat.

 Will merge to 'master' in the fourth batch.


* nd/git-dir-pointing-at-gitfile (2013-09-03) 1 commit
  (merged to 'next' on 2013-09-09 at 5b0a4bf)
 + Make setup_git_env() resolve .git file when $GIT_DIR is not specified

 We made sure that we notice the user-supplied GIT_DIR is actually a
 gitfile, but failed to do so when the default ".git" is a gitfile.

 Will merge to 'master' in the fourth batch.


* nr/git-cd-to-a-directory (2013-09-09) 1 commit
 - git: run in a directory given with -C option

 Just like "make -C <directory>", make "git -C <directory> ..." to
 go there before doing anything else.

 Will merge to 'next'.


* rh/peeling-tag-to-tag (2013-09-03) 2 commits
 - peel_onion: do not assume length of x_type globals
 - peel_onion(): add support for <rev>^{tag}

 Make "foo^{tag}" to peel a tag to itself, i.e. no-op., and fail if
 "foo" is not a tag.

 Will merge to 'next'.


* cc/replace-with-the-same-type (2013-09-09) 8 commits
 - Doc: 'replace' merge and non-merge commits
 - t6050-replace: use some long option names
 - replace: allow long option names
 - Documentation/replace: add Creating Replacement Objects section
 - t6050-replace: add test to clean up all the replace refs
 - t6050-replace: test that objects are of the same type
 - Documentation/replace: state that objects must be of the same type
 - replace: forbid replacing an object with one of a different type

 Using the replace mechanism to swap an object with another object
 of a different type can introduce inconsistency (e.g. a tree
 expects an object name to refer to a blob, but the blob object can
 be mistakenly or maliciously replaced with an object with a
 different type). Attempt to forbid such.

 Will merge to 'next'.


* jx/clean-interactive (2013-08-28) 1 commit
  (merged to 'next' on 2013-09-09 at 477fec6)
 + documentation: clarify notes for clean.requireForce

 Finishing touches to update the document to adjust to a new option
 "git clean" learned recently.

 Will merge to 'master' in the fourth batch.


* mm/status-without-comment-char (2013-09-06) 6 commits
 - status: add missing blank line after list of "other" files
 - tests: don't set status.displayCommentPrefix file-wide
 - status: disable display of '#' comment prefix by default
 - submodule summary: ignore --for-status option
 - wt-status: use argv_array API
 - builtin/stripspace.c: fix broken indentation

 Allow "git status" to omit the prefix to make its output a comment
 in a commit log editor, which is not necessary for human
 consumption.

 We may want to tighten the output to omit unnecessary trailing
 blank lines, but that does not have to be in the scope of this
 series.

 Will merge to 'next'.


* bc/submodule-status-ignored (2013-09-11) 3 commits
  (merged to 'next' on 2013-09-11 at 9f66712)
 + Improve documentation concerning the status.submodulesummary setting
  (merged to 'next' on 2013-09-10 at a417960)
 + submodule: don't print status output with ignore=all
 + submodule: fix confusing variable name

 Originally merged to 'next' on 2013-08-22

 Will cook in 'next' a bit.


* jk/config-int-range-check (2013-09-09) 5 commits
  (merged to 'next' on 2013-09-09 at 9ab779d)
 + git-config: always treat --int as 64-bit internally
 + config: make numeric parsing errors more clear
 + config: set errno in numeric git_parse_* functions
 + config: properly range-check integer values
 + config: factor out integer parsing from range checks

 Originally merged to 'next' on 2013-08-22

 "git config --int section.var 3g" should somehow diagnose that the
 number does not fit in "int" (on 32-bit platforms anyway) but it
 did not.

 Will merge to 'master' in the third batch.


* jk/duplicate-objects-in-packs (2013-09-04) 5 commits
  (merged to 'next' on 2013-09-09 at 72f2c3d)
 + t5308: check that index-pack --strict detects duplicate objects
 + test index-pack on packs with recoverable delta cycles
 + add tests for indexing packs with delta cycles
 + sha1-lookup: handle duplicate keys with GIT_USE_LOOKUP
 + test-sha1: add a binary output mode

 A packfile that stores the same object more than once is broken and
 will be rejected.

 Will merge to 'master' in the fourth batch.


* mm/mediawiki-dumb-push-fix (2013-09-03) 4 commits
  (merged to 'next' on 2013-09-05 at f8313f4)
 + git-remote-mediawiki: no need to update private ref in non-dumb push
 + git-remote-mediawiki: use no-private-update capability on dumb push
 + transport-helper: add no-private-update capability
 + git-remote-mediawiki: add test and check Makefile targets

 Will merge to 'master' in the third batch.


* dw/diff-no-index-doc (2013-08-28) 2 commits
  (merged to 'next' on 2013-09-10 at 423c8f6)
 + diff --no-index: describe in a separate paragraph
 + diff --no-index: clarify operation when not inside a repository

 When the user types "git diff" outside a working tree, thinking he
 is inside one, the current error message that is a single-liner
 "usage: git diff --no-index <path> <path>" may not be sufficient to
 make him realize the mistake. Add "Not a git repository" to the
 error message when we fell into the "--no-index" mode without an
 explicit command line option to instruct us to do so.

 Will merge to 'master' in the third batch.


* sb/repack-in-c (2013-08-30) 2 commits
 - repack: retain the return value of pack-objects
 - repack: rewrite the shell script in C

 Any further reviews?


* ap/commit-author-mailmap (2013-08-24) 1 commit
  (merged to 'next' on 2013-09-09 at 79d5a20)
 + commit: search author pattern against mailmap

 "git commit --author=$name", when $name is not in the canonical
 "A. U. Thor <au.thor@example.xz>" format, looks for a matching name
 from existing history, but did not consult mailmap to grab the
 preferred author name.

 Will merge to 'master' in the fourth batch.


* jk/write-broken-index-with-nul-sha1 (2013-08-28) 1 commit
  (merged to 'next' on 2013-09-09 at 6953f27)
 + write_index: optionally allow broken null sha1s

 Earlier we started rejecting an attempt to add 0{40} object name to
 the index and to tree objects, but it sometimes is necessary to
 allow so to be able to use tools like filter-branch to correct such
 broken tree objects.

 Will merge to 'master' in the fourth batch.


* kk/tests-with-no-perl (2013-08-24) 4 commits
  (merged to 'next' on 2013-09-09 at 67510b1)
 + reset test: modernize style
 + t/t7106-reset-unborn-branch.sh: Add PERL prerequisite
 + add -i test: use skip_all instead of repeated PERL prerequisite
 + Make test "using invalid commit with -C" more strict

 Some tests were not skipped under NO_PERL build.

 Will merge to 'master' in the third batch.


* mm/fast-import-feature-doc (2013-08-25) 1 commit
  (merged to 'next' on 2013-09-05 at 83802e2)
 + Documentation/fast-import: clarify summary for `feature` command

 Will merge to 'master' in the third batch.


* mm/remote-helpers-doc (2013-08-26) 1 commit
  (merged to 'next' on 2013-09-05 at c181b35)
 + Documentation/remote-helpers: document common use-case for private ref

 Will merge to 'master' in the third batch.


* mn/doc-pack-heu-remove-dead-pastebin (2013-08-23) 1 commit
  (merged to 'next' on 2013-09-05 at 5caecec)
 + remove dead pastebin link from pack-heuristics document

 Will merge to 'master' in the third batch.


* ta/user-manual (2013-08-27) 11 commits
  (merged to 'next' on 2013-09-10 at 1361be1)
 + "git prune" is safe
 + Remove irrelevant reference from "Tying it all together"
 + Remove unnecessary historical note from "Object storage format"
 + Improve section "Merging multiple trees"
 + Improve section "Manipulating branches"
 + Simplify "How to make a commit"
 + Fix some typos and improve wording
 + Use "git merge" instead of "git pull ."
 + Use current output for "git repack"
 + Use current "detached HEAD" message
 + Call it "Git User Manual" and remove reference to very old Git version

 Update the user's manual to more recent versions of Git.

 Will merge to 'master' in the third batch.


* tb/precompose-autodetect-fix (2013-08-27) 1 commit
  (merged to 'next' on 2013-09-09 at 9bfdac1)
 + Set core.precomposeunicode to true on e.g. HFS+

 On MacOS X, we detected if the filesystem needs the "pre-composed
 unicode strings" workaround, but did not automatically enable it.
 Now we do.

 Will merge to 'master' in the third batch.


* jx/branch-vv-always-compare-with-upstream (2013-08-26) 2 commits
 - status: always show tracking branch even no change
 - branch: report invalid tracking branch as gone

 "git branch -v -v" (and "git status") did not distinguish among a
 branch that does not build on any other branch, a branch that is in
 sync with the branch it builds on, and a branch that is configured
 to build on some other branch that no longer exists.

 Will merge to 'next'.


* nd/fetch-into-shallow (2013-08-28) 7 commits
  (merged to 'next' on 2013-09-09 at 87a3b99)
 + Add testcase for needless objects during a shallow fetch
 + list-objects: mark more commits as edges in mark_edges_uninteresting
 + list-objects: reduce one argument in mark_edges_uninteresting
 + upload-pack: delegate rev walking in shallow fetch to pack-objects
 + shallow: add setup_temporary_shallow()
 + shallow: only add shallow graft points to new shallow file
 + move setup_alternate_shallow and write_shallow_commits to shallow.c

 When there is no sufficient overlap between old and new history
 during a fetch into a shallow repository, we unnecessarily sent
 objects the sending side knows the receiving end has.

 Will merge to 'master' in the fourth batch.


* ks/p4-view-spec (2013-09-03) 2 commits
  (merged to 'next' on 2013-09-10 at 8ceb2ec)
 + git p4: implement view spec wildcards with "p4 where"
 + git p4 test: sanitize P4CHARSET

 Replaced with a reroll that was whitespace damaged.

 Will merge to 'master' in the third batch.


* tr/merge-recursive-index-only (2013-07-07) 3 commits
 - merge-recursive: -Xindex-only to leave worktree unchanged
 - merge-recursive: untangle double meaning of o->call_depth
 - merge-recursive: remove dead conditional in update_stages()

 Will hold, until we get any user.


* jc/reflog-doc (2013-06-19) 1 commit
 - setup_reflog_action: document the rules for using GIT_REFLOG_ACTION

 Document rules to use GIT_REFLOG_ACTION variable in the scripted
 Porcelain.  git-rebase--interactive locally violates this, but it
 is a leaf user that does not call out to or dot-sources other
 scripts, so fixing it is not all that urgent.


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

 Originally merged to 'next' on 2013-07-22

 Make "git pull" (without arguments that say what branch to
 integrate from where) refuse with "it does not fast forward; choose
 between 'pull --merge' and 'pull --rebase'".

 This topic has been reverted from 'next'.  Will wait for the
 conclusion of the discussion to seek a more user-friendly
 alternative; it is likely that it will be based on the simpler
 approach Felipe posted earlier.
