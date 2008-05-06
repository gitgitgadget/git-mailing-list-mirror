From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (topics)
Date: Mon, 05 May 2008 23:38:24 -0700
Message-ID: <7vmyn4hr8f.fsf@gitster.siamese.dyndns.org>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
 <7vwso85qkf.fsf@gitster.siamese.dyndns.org>
 <7vwso5r87q.fsf@gitster.siamese.dyndns.org>
 <7v8x0992hy.fsf@gitster.siamese.dyndns.org>
 <7vd4pf7h9y.fsf@gitster.siamese.dyndns.org>
 <7vwsnjl21c.fsf@gitster.siamese.dyndns.org>
 <7vhcehzdeg.fsf@gitster.siamese.dyndns.org>
 <7vbq4j748l.fsf@gitster.siamese.dyndns.org>
 <7vr6d8apjx.fsf@gitster.siamese.dyndns.org>
 <7vhcdyfe9u.fsf@gitster.siamese.dyndns.org>
 <7vabjm1a0q.fsf@gitster.siamese.dyndns.org>
 <7vr6crj0jk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 06 08:40:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtGqM-0003QS-U9
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 08:40:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752615AbYEFGjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 02:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752666AbYEFGjQ
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 02:39:16 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63932 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478AbYEFGjO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2008 02:39:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DF1383556;
	Tue,  6 May 2008 02:38:38 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 247033553; Tue,  6 May 2008 02:38:34 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0F8CB1F4-1B37-11DD-85EE-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81336>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.

The topics list the commits in reverse chronological order.

It's been a while since the last issue of this series.  I've been
swamped, and haven't had a chance to spend enough time on reviewing and
accepting patches.

A good news is that the tip of 'pu' tonight passes all the test --- it has
been broken for some time.

A rough timeline from now on.

 * Discussion and review on new feature and enhancement patch series
   begins.  Please resubmit things that you were cooking in your head
   during 1.5.5-rc period after cleaning up and retesting.

 * 1.5.6 merge window closes (2008-05-14).

 * Fixes of 'master' continues; 1.5.6-rc0 gets tagged (2008-05-21).

 * 1.5.6 Final (2008-06-08).

----------------------------------------------------------------
[New Topics]

* bd/tests (Sun May 4 01:38:00 2008 -0400) 10 commits
 + Rename the test trash directory to contain spaces.
 + Fix tests breaking when checkout path contains shell
   metacharacters
 + Don't use the 'export NAME=value' in the test scripts.
 + lib-git-svn.sh: Fix quoting issues with paths containing shell
   metacharacters
 + test-lib.sh: Fix some missing path quoting
 + Use test_set_editor in t9001-send-email.sh
 + test-lib.sh: Add a test_set_editor function to safely set $VISUAL
 + git-send-email.perl: Handle shell metacharacters in $EDITOR
   properly
 + config.c: Escape backslashes in section names properly
 + git-rebase.sh: Fix --merge --abort failures when path contains
   whitespace

Making sure the tools quote paths correctly and work inside a directory
whose pathname contains whitespace.  Thanks Bryan, and thanks J6t for
reviewing and testing.

* np/pack (Fri May 2 15:11:51 2008 -0400) 7 commits
 + pack-objects: fix early eviction for max depth delta objects
 + pack-objects: allow for early delta deflating
 + pack-objects: move compression code in a separate function
 + pack-objects: clean up write_object() a bit
 + pack-objects: simplify the condition associated with --all-
   progress
 + pack-objects: remove some double negative logic
 + pack-objects: small cleanup

Every time Nico tweaks pack generation, something good comes out ;-).

* py/diff-submodule (Sat May 3 17:24:28 2008 -0700) 5 commits
 + is_racy_timestamp(): do not check timestamp for gitlinks
 + diff-lib.c: rename check_work_tree_entity()
 + diff: a submodule not checked out is not modified
 + Add t7506 to test submodule related functions for git-status
 + t4027: test diff for submodule with empty directory

A submodule that is not checked out is not modified, but was mistaken as
being removed.  Thanks Ping for tests and fixes.

* cc/hooks-doc (Fri May 2 05:30:47 2008 +0200) 1 commit
 - Documentation: rename "hooks.txt" to "githooks.txt" and make it a
   man page

I've looked at but not applied most of the patches in the series that
built on top of this.  I think it probably is a good goal to make
everything _accessible_ as manual pages, but at the same time I do not
exactly like the HTML rendered results of material that are not really
manual pages.  E.g. "Everyday" looks much worse to me.

At least, the categorization of sections 1/5/7 should be straightened
out.  diffcore is not about "file format" at all and do not belong to
section 5, for example.

* pb/push (Mon Apr 28 11:32:12 2008 -0400) 1 commit
 - add special "matching refs" refspec

This first patch is a good enhancement without hurting any existing users.
We need a staged introduction of the second and later patches, and many
people including me did not agree the later ones in the series are
desirable.

* mv/format-cc (Tue Apr 29 12:56:47 2008 +0200) 3 commits
 + Add tests for sendemail.cc configuration variable
 + git-send-email: add a new sendemail.cc configuration variable
 + git-format-patch: add a new format.cc configuration variable

* as/graph (Mon May 5 00:57:03 2008 -0700) 4 commits
 - graph API: eliminate unnecessary indentation
 - log and rev-list: add --graph option
 - Add history graph API
 - revision API: split parent rewriting and parent printing options

Draw "tig 'g'" graph without tig ;-)

* jk/renamelimit (Sat May 3 13:58:42 2008 -0700) 4 commits
 - diff: enable "too large a rename" warning when -M/-C is explicitly
   asked for
 + diff: make "too many files" rename warning optional
 + bump rename limit defaults
 + add merge.renamelimit config option

The documentation part of this series partly depends on another series,
but I am expecting both to graduate smoothly to 'master' reasonably soon.

* sv/first-parent (Sun Apr 27 19:32:46 2008 +0200) 1 commit
 + Simplify and fix --first-parent implementation

* gp/bisect-fix (Mon May 5 07:43:00 2008 +0000) 1 commit
 + git-bisect.sh: don't accidentally override existing branch
   "bisect"

----------------------------------------------------------------
[Graduated to "master"]

* pb/remote-mirror-config (Thu Apr 17 13:17:20 2008 +0200) 1 commit
 + Add a remote.*.mirror configuration option

* lh/branch-merged (Fri Apr 18 18:30:15 2008 +0200) 3 commits
 + Add tests for `branch --[no-]merged`
 + git-branch.txt: compare --contains, --merged and --no-merged
 + git-branch: add support for --merged and --no-merged

* jk/fetch-status (Wed Apr 9 20:11:52 2008 -0400) 1 commit
 + git-fetch: always show status of non-tracking-ref fetches

This changes reporting behaviour of one-shot "git pull $url $branch",
which would affect long-time users in integrator role (that's you, Linus
;-).  Let's see if we hear anybody screaming.

* lh/git-file (Wed Feb 20 23:13:16 2008 +0100) 4 commits
 + Teach GIT-VERSION-GEN about the .git file
 + Teach git-submodule.sh about the .git file
 + Teach resolve_gitlink_ref() about the .git file
 + Add platform-independent .git "symlink"

There was a GSoC project idea to enhance "git submodule" to take advantage
of this facility to preserve the subrepository while switching between a
revision with a submodule and another before the submodule was bound to
the superproject, but it appears nobody took it.

* bc/filter-branch (Wed Mar 26 10:47:09 2008 -0500) 1 commit
 + filter-branch.sh: support nearly proper tag name filtering

Instead of discarding annotated and/or signed tags, this keeps them and
demotes the signed ones to simply annotated.  It issues warning when it
does this demotion.  I think the behaviour is sensible.

* jc/lstat (Sun Mar 30 12:39:25 2008 -0700) 2 commits
 + diff-files: mark an index entry we know is up-to-date as such
 + write_index(): optimize ce_smudge_racily_clean_entry() calls with
   CE_UPTODATE

Further reduce redundant lstat(2) calls during "git status" and other
common operations.

----------------------------------------------------------------
[Will merge to "master" soonish]

* lt/dirmatch-optim (Sat Apr 19 14:22:38 2008 -0700) 1 commit
 + Optimize match_pathspec() to avoid fnmatch()

* dm/cherry-pick-s (Sat Apr 26 15:14:28 2008 -0500) 1 commit
 + Allow cherry-pick (and revert) to add signoff line

* cc/help (Fri Apr 25 08:25:41 2008 +0200) 5 commits
 + documentation: web--browse: add a note about konqueror
 + documentation: help: add info about "man.<tool>.cmd" config var
 + help: use "man.<tool>.cmd" as custom man viewer command
 + documentation: help: add "man.<tool>.path" config variable
 + help: use man viewer path from "man.<tool>.path" config var

* jn/webfeed (Sun Apr 20 22:09:48 2008 +0200) 1 commit
 + gitweb: Use feed link according to current view

----------------------------------------------------------------
[Actively Cooking]

* js/rebase-i-sequencer (Sun Apr 27 02:55:50 2008 -0400) 17 commits
 + Use perl instead of tac
 + Fix t3404 assumption that `wc -l` does not use whitespace.
 + rebase -i: Use : in expr command instead of match.
 + rebase -i: update the implementation of 'mark' command
 + Add option --preserve-tags
 + Teach rebase interactive the tag command
 + Add option --first-parent
 + Do rebase with preserve merges with advanced TODO list
 + Select all lines with fake-editor
 + Unify the length of $SHORT* and the commits in the TODO list
 + Teach rebase interactive the merge command
 + Move redo merge code in a function
 + Teach rebase interactive the reset command
 + Teach rebase interactive the mark command
 + Move cleanup code into it's own function
 + Don't append default merge message to -m message
 + fake-editor: output TODO list if unchanged

This may complement the proposed "sequencer" GSoC project.  Dscho seems to
have quite a strong objection to the 'mark' syntax and mechanism being
unnecessarily complex.  Let's wait and see if a less complex but equally
expressive alternative materializes...

* db/learn-HEAD (Sat Apr 26 15:53:12 2008 -0400) 2 commits
 + Make ls-remote http://... list HEAD, like for git://...
 + Make walker.fetch_ref() take a struct ref.

* sg/merge-options (Sun Apr 6 03:23:47 2008 +0200) 6 commits
 - merge: remove deprecated summary and diffstat options and config
   variables
 + merge, pull: add '--(no-)log' command line option
 + fmt-merge-msg: add '--(no-)log' options and 'merge.log' config
   variable
 + add 'merge.stat' config variable
 + merge, pull: introduce '--(no-)stat' option
 + doc: moved merge.* config variables into separate merge-config.txt

The last one needs to be held back, as it actually removes the support for
features that the main part of the series deprecates, until 1.6.0 or
later.

* jc/blame (Wed Apr 2 22:17:53 2008 -0700) 5 commits
 + git-blame --reverse
 + builtin-blame.c: allow more than 16 parents
 + builtin-blame.c: move prepare_final() into a separate function.
 + rev-list --children
 + revision traversal: --children option

The blame that finds where each line in the original lines moved to.
This may help a GSoC project that wants to gather statistical overview of
the history.

* jc/send-pack-tell-me-more (Thu Mar 20 00:44:11 2008 -0700) 1 commit
 + "git push": tellme-more protocol extension

Allows common ancestor negotiation for git-push to help people with shared
repository workflow in certain minority situations.  The lack of protocol
support has been bugging me for quite some time, and that was the reason I
did this.  There recently was a problem report that had a scent of this
issue which turned out to be a false alarm (it was about http-push which
does not do the native pack protocol optimization and the reporter was
pushing into an empty repository which needs full transfer anyway).

* lt/case-insensitive (Sat Mar 22 14:22:44 2008 -0700) 9 commits
 + Make git-add behave more sensibly in a case-insensitive
   environment
 + When adding files to the index, add support for case-independent
   matches
 + Make unpack-tree update removed files before any updated files
 + Make branch merging aware of underlying case-insensitive
   filsystems
 + Add 'core.ignorecase' option
 + Make hash_name_lookup able to do case-independent lookups
 + Make "index_name_exists()" return the cache_entry it found
 + Move name hashing functions into a file of its own
 + Make unpack_trees_options bit flags actual bitfields

The beginning of case insensitive filesystem support, currently
ASCII-only.

----------------------------------------------------------------
[Dropped]

* ap/svn (Tue Apr 15 21:04:18 2008 -0400) 3 commits
 . git-svn: add documentation for --add-author-from option.
 . git-svn: Add --add-author-from option.
 . git-svn: add documentation for --use-log-author option.

Eric requested a new set of tests for this series which never came.  I am
still holding onto the tip of the topic in case we can resurrect it, but
it is not merged to 'pu'.

----------------------------------------------------------------
[On Hold]

* nd/dashless (Wed Nov 28 23:21:57 2007 +0700) 1 commit
 - Move all dashed-form commands to libexecdir

Scheduled for 1.6.0.

* db/clone-in-c (Sun Apr 27 13:39:30 2008 -0400) 8 commits
 - Build in clone
 - Provide API access to init_db()
 - Add a function to set a non-default work tree
 - Allow for having for_each_ref() list extra refs
 - Have a constant extern refspec for "--tags"
 - Add a library function to add an alternate to the alternates file
 - Add a lockfile function to append to a file
 - Mark the list of refs to fetch as const

I'd really want this in 1.5.6; will merge to 'next' after giving a final
pass sometime this week.

* ar/batch-cat (Wed Apr 23 15:17:47 2008 -0400) 5 commits
 - git-cat-file: Add --batch option
 - git-cat-file: Add --batch-check option
 - git-cat-file: Make option parsing a little more flexible
 - git-cat-file: Small refactor of cmd_cat_file
 - Add tests for git cat-file

I fixed up the problematic shell script in the first patch in the series
but later one introduced the same problematic constructs in another file,
at which point I gave up and discarded the rest.  At least it now passes
its own testsuite without breaking others.

* jc/test (Thu Feb 21 21:17:54 2008 -0800) 2 commits
 - tests: convert "cmp" and "cmp -s" to test_cmp
 - tests: test_cmp helper function

This one may be more elaborate, but Jeff's patch is much simpler.

* jc/dashless (Sat Dec 1 22:09:22 2007 -0800) 2 commits
 - Prepare execv_git_cmd() for removal of builtins from the
   filesystem
 - git-shell: accept "git foo" form

We do not plan to remove git-foo form completely from the filesystem at
this point, but git-shell may need to be updated.

* jc/cherry-pick (Wed Feb 20 23:17:06 2008 -0800) 3 commits
 - WIP: rethink replay merge
 - Start using replay-tree merge in cherry-pick
 - revert/cherry-pick: start refactoring call to merge_recursive

This is meant to improve cherry-pick's behaviour by not using
merge-recursive, but unfortunately has stalled for some time now.

* jc/lstat-debug (Thu Mar 27 16:56:53 2008 -0700) 1 commit
 - lstat: introduce a wrapper xlstat

* jc/stripspace (Sun Mar 9 00:30:35 2008 -0800) 6 commits
 - git-am --forge: add Signed-off-by: line for the author
 - git-am: clean-up Signed-off-by: lines
 - stripspace: add --log-clean option to clean up signed-off-by:
   lines
 - stripspace: use parse_options()
 - Add "git am -s" test
 - git-am: refactor code to add signed-off-by line for the committer

Just my toy at this moment.
