From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (topics)
Date: Wed, 14 May 2008 15:30:46 -0700
Message-ID: <7vmymsjz6x.fsf@gitster.siamese.dyndns.org>
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
 <7vmyn4hr8f.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 00:32:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwPWS-0003MF-7m
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 00:32:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753541AbYENWbE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 18:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752364AbYENWbB
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 18:31:01 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53725 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753541AbYENWa6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 18:30:58 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 766BD4DC1;
	Wed, 14 May 2008 18:30:57 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id A2D114DC0; Wed, 14 May 2008 18:30:53 -0400 (EDT)
In-Reply-To: <7vmyn4hr8f.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 05 May 2008 23:38:24 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6C18D25C-2205-11DD-8DCE-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82155>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.

The topics list the commits in reverse chronological order.

It's been a while since the last issue of this series.  I've been
swamped, and haven't had a chance to spend enough time on reviewing and
accepting patches.

A rough timeline from now on.

 * Will merge the remaining topics already on 'next', and perhaps accept a
   handful minor topics that are not yet in.

 * Fixes of 'master' continues; 1.5.6-rc0 gets tagged (2008-05-21).

 * 1.5.6 Final (2008-06-08).

----------------------------------------------------------------
[New Topics]

* bc/tag (Fri May 9 00:03:35 2008 -0500) 3 commits
 - ident.c: New function valid_ident for checking ident string
   formatting
 - Make mktag a builtin
 - mktag.c: adjust verify_tag parameters

I stopped looking at this after hitting an unappliable patch --- will need
to take a look at it again.

* js/config-cb (Wed May 14 18:46:53 2008 +0100) 1 commit
 - Provide git_config with a callback-data parameter

This needs to wait until most of the other things graduate for 1.5.6;
luckily, unlike the other "path-list" changes, misconversions is much
easier to catch for this change and I am not worried about it.

* ds/branch-auto-rebase (Sat May 10 15:36:29 2008 -0700) 1 commit
 + Allow tracking branches to set up rebase by default.

For 1.5.6.

* bc/repack (Wed May 14 01:33:53 2008 -0400) 5 commits
 + let pack-objects do the writing of unreachable objects as loose
   objects
 + add a force_object_loose() function
 + builtin-gc.c: deprecate --prune, it now really has no effect
 + git-gc: always use -A when manually repacking
 + repack: modify behavior of -A option to leave unreferenced objects
   unpacked

For 1.5.6.

* sp/ignorecase (Sun May 11 18:16:42 2008 +0200) 4 commits
 - t0050: Add test for case insensitive add
 - t0050: Set core.ignorecase case to activate case insensitivity
 - t0050: Test autodetect core.ignorecase
 - git-init: autodetect core.ignorecase

This unfortunately seems to break on natively case sensitive filesystems.

* ar/add-unreadable (Mon May 12 19:59:23 2008 +0200) 5 commits
 + Add a config option to ignore errors for git-add
 + Add a test for git-add --ignore-errors
 + Add --ignore-errors to git-add to allow it to skip files with read
   errors
 + Extend interface of add_files_to_cache to allow ignore indexing
   errors
 + Make the exit code of add_file_to_index actually useful

* jc/diff-words (Sun May 11 12:33:48 2008 -0700) 2 commits
 - diff --color-words: a bit of tweak
 - diff --color-words reimplementation


----------------------------------------------------------------
[Graduated to "master"]

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

* db/learn-HEAD (Sat Apr 26 15:53:12 2008 -0400) 2 commits
 + Make ls-remote http://... list HEAD, like for git://...
 + Make walker.fetch_ref() take a struct ref.

* cc/help (Fri Apr 25 08:25:41 2008 +0200) 5 commits
 + documentation: web--browse: add a note about konqueror
 + documentation: help: add info about "man.<tool>.cmd" config var
 + help: use "man.<tool>.cmd" as custom man viewer command
 + documentation: help: add "man.<tool>.path" config variable
 + help: use man viewer path from "man.<tool>.path" config var

* dm/cherry-pick-s (Sat Apr 26 15:14:28 2008 -0500) 1 commit
 + Allow cherry-pick (and revert) to add signoff line

* lt/dirmatch-optim (Sat Apr 19 14:22:38 2008 -0700) 1 commit
 + Optimize match_pathspec() to avoid fnmatch()

* jn/webfeed (Sun Apr 20 22:09:48 2008 +0200) 1 commit
 + gitweb: Use feed link according to current view

* gp/bisect-fix (Mon May 5 07:43:00 2008 +0000) 1 commit
 + git-bisect.sh: don't accidentally override existing branch
   "bisect"

* jk/renamelimit (Sat May 3 13:58:42 2008 -0700) 3 commits
 + diff: make "too many files" rename warning optional
 + bump rename limit defaults
 + add merge.renamelimit config option

* py/diff-submodule (Sat May 3 17:24:28 2008 -0700) 5 commits
 + is_racy_timestamp(): do not check timestamp for gitlinks
 + diff-lib.c: rename check_work_tree_entity()
 + diff: a submodule not checked out is not modified
 + Add t7506 to test submodule related functions for git-status
 + t4027: test diff for submodule with empty directory

A submodule that is not checked out is not modified, but was mistaken as
being removed.  Thanks Ping for tests and fixes.

* cc/hooks-doc (Fri May 2 05:30:47 2008 +0200) 1 commit
 + Documentation: rename "hooks.txt" to "githooks.txt" and make it a
   man page

* mv/format-cc (Tue Apr 29 12:56:47 2008 +0200) 3 commits
 + Add tests for sendemail.cc configuration variable
 + git-send-email: add a new sendemail.cc configuration variable
 + git-format-patch: add a new format.cc configuration variable

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

* sb/committer (Sun May 4 18:04:51 2008 +0200) 3 commits
 + commit: Show committer if automatic
 + commit: Show author if different from committer
 + Preparation to call determine_author_info from prepare_to_commit

----------------------------------------------------------------
[Will merge to "master" soonish]

* as/graph (Mon May 5 00:57:03 2008 -0700) 4 commits
 + graph API: eliminate unnecessary indentation
 + log and rev-list: add --graph option
 + Add history graph API
 + revision API: split parent rewriting and parent printing options

Draw "tig 'g'" graph without tig ;-)

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

* db/clone-in-c (Sun Apr 27 13:39:30 2008 -0400) 8 commits
 + Build in clone
 + Provide API access to init_db()
 + Add a function to set a non-default work tree
 + Allow for having for_each_ref() list extra refs
 + Have a constant extern refspec for "--tags"
 + Add a library function to add an alternate to the alternates file
 + Add a lockfile function to append to a file
 + Mark the list of refs to fetch as const

For 1.5.6; please give it a good beating.

----------------------------------------------------------------
[Actively Cooking]

* jc/send-pack-tell-me-more (Thu Mar 20 00:44:11 2008 -0700) 1 commit
 + "git push": tellme-more protocol extension

Allows common ancestor negotiation for git-push to help people with shared
repository workflow in certain minority situations.  The lack of protocol
support has been bugging me for quite some time, and that was the reason I
did this.

This needs debugging.

* ap/svn (Mon May 12 17:09:49 2008 -0700) 4 commits
 + git-svn: add test for --add-author-from and --use-log-author
 + git-svn: add documentation for --add-author-from option.
 + git-svn: Add --add-author-from option.
 + git-svn: add documentation for --use-log-author option.

Some tweak for output might be needed, I dunno.

* sv/first-parent (Mon May 12 17:12:36 2008 +0200) 2 commits
 + revision.c: really honor --first-parent
 + Simplify and fix --first-parent implementation

----------------------------------------------------------------
[Stalled]

* jc/blame (Wed Apr 2 22:17:53 2008 -0700) 5 commits
 + git-blame --reverse
 + builtin-blame.c: allow more than 16 parents
 + builtin-blame.c: move prepare_final() into a separate function.
 + rev-list --children
 + revision traversal: --children option

The blame that finds where each line in the original lines moved to.  This
may help a GSoC project that wants to gather statistical overview of the
history.  The final presentation may need tweaking (see the log message of
the tip commit on the series).

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

----------------------------------------------------------------
[On Hold]

* jk/renamelimit (Sat May 3 13:58:42 2008 -0700) 1 commit
 - diff: enable "too large a rename" warning when -M/-C is explicitly
   asked for

This would be the right thing to do for command line use, but gitk will be
hit due to tcl/tk's limitation, so I am holding this back for now.

* sg/merge-options (Sun Apr 6 03:23:47 2008 +0200) 1 commit
 - merge: remove deprecated summary and diffstat options and config
   variables

This needs to be held back, as it actually removes the support for
features that the main part of the series deprecates, until 1.6.0 or
later.

* pb/push (Mon Apr 28 11:32:12 2008 -0400) 1 commit
 + add special "matching refs" refspec

This first patch is a good enhancement without hurting any existing users.
We need a staged introduction of the second and later patches, and many
people including me did not agree the later ones in the series are
desirable.

* nd/dashless (Wed Nov 28 23:21:57 2007 +0700) 1 commit
 - Move all dashed-form commands to libexecdir

Scheduled for 1.6.0.

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

This is meant to improve cherry-pick's behaviour when renames are
involved, by not using merge-recursive (whose d/f conflict resolution is
quite broken), but unfortunately has stalled for some time now.

* jc/stripspace (Sun Mar 9 00:30:35 2008 -0800) 6 commits
 - git-am --forge: add Signed-off-by: line for the author
 - git-am: clean-up Signed-off-by: lines
 - stripspace: add --log-clean option to clean up signed-off-by:
   lines
 - stripspace: use parse_options()
 - Add "git am -s" test
 - git-am: refactor code to add signed-off-by line for the committer

Just my toy at this moment.
