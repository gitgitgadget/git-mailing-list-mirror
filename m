From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Mar 2009, #06; Sat, 21)
Date: Sat, 21 Mar 2009 00:58:33 -0700
Message-ID: <7vk56jfgt2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 21 09:01:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lkw8t-0005Iq-AR
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 09:01:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790AbZCUH6o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 03:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbZCUH6o
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 03:58:44 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58186 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338AbZCUH6m (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 03:58:42 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C8CD9A227C;
	Sat, 21 Mar 2009 03:58:38 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id BF8E4A227B; Sat,
 21 Mar 2009 03:58:35 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1649427A-15EE-11DE-A73E-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114030>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the branches, but I am still
holding onto them.

The topics list the commits in reverse chronological order.  The topics
meant to be merged to the maintenance series have "maint-" in their names.

----------------------------------------------------------------
[New Topics]

* jk/reflog-date (Fri Mar 20 02:00:43 2009 -0400) 1 commit
 - make oneline reflog dates more consistent with multiline format

* js/maint-1.6.0-exec-path-env (Wed Mar 18 08:42:53 2009 +0100) 1 commit
 - export GIT_EXEC_PATH when git is run with --exec-path

* da/difftool (Thu Mar 19 01:25:25 2009 -0700) 1 commit
 - difftool: move 'git-difftool' out of contrib

* jc/maint-1.6.0-keep-pack (Thu Mar 19 22:47:54 2009 -0500) 4 commits
 - Remove --kept-pack-only option and associated infrastructure
 - pack-objects: only repack or loosen objects residing in "local"
   packs
 - git-repack.sh: don't use --kept-pack-only option to pack-objects
 - t7700-repack: add two new tests demonstrating repacking flaws

Brandon Casey fixed the regression previous patches introduced; thanks.

* jc/maint-1.6.0-blame-s (Wed Mar 18 00:13:03 2009 -0700) 1 commit
 - blame: read custom grafts given by -S before calling
   setup_revisions()

The above are all ready for 'next'.

* hv/cvsps-tests (Wed Mar 18 18:33:41 2009 +0100) 7 commits
 - cvsimport: extend testcase about patchset order to contain
   branches
 - cvsimport: add test illustrating a bug in cvsps
 - Add a test of "git cvsimport"'s handling of tags and branches
 - Add some tests of git-cvsimport's handling of vendor branches
 - Test contents of entire cvsimported "master" tree contents
 - Use CVS's -f option if available (ignore user's ~/.cvsrc file)
 - Start a library for cvsimport-related tests

Two cvsimport test topics were rewound from 'next' and merged into this
one.  I'll keep this in 'pu' so that people can polish their cvsps skilz
to resolve issues these tests identify.

----------------------------------------------------------------
[Graduated to "master"]

* fc/parseopt-config (Tue Mar 17 10:46:37 2009 +0100) 10 commits
 + config: test for --replace-all with one argument and fix
   documentation.
 + config: set help text for --bool-or-int
 + git config: don't allow --get-color* and variable type
 + git config: don't allow extra arguments for -e or -l.
 + git config: don't allow multiple variable types
 + git config: don't allow multiple config file locations
 + git config: reorganize to use parseopt
 + git config: reorganize get_color*
 + git config: trivial rename in preparation for parseopt
 + git_config(): not having a per-repo config file is not an error

* js/rebase-i-opt (Tue Mar 3 10:55:31 2009 +0100) 1 commit
 + rebase -i: avoid 'git reset' when possible

* jc/clone-branch-rebase (Tue Mar 10 01:20:42 2009 -0700) 2 commits
 + Improve "git branch --tracking" output
 + Make git-clone respect branch.autosetuprebase

This is a rewrite of a patch from Pat Notz.

* xx/db-refspec-vs-js-remote (Sun Mar 8 00:12:33 2009 -0800) 1 commit
 + Adjust js/remote-improvements and db/refspec-wildcard-in-the-
   middle

* db/refspec-wildcard-in-the-middle (Sat Mar 7 01:11:39 2009 -0500) 5 commits
 + Support '*' in the middle of a refspec
 + Keep '*' in pattern refspecs
 + Use the matching function to generate the match results
 + Use a single function to match names against patterns
 + Make clone parse the default refspec with the normal code

* bw/autoconf (Thu Mar 12 15:20:12 2009 -0400) 7 commits
 + configure: rework pthread handling to allow for user defined flags
 + configure: make iconv tests aware of user arguments
 + configure: asciidoc version test cleanup
 + configure: wrap some library tests with GIT_STASH_FLAGS
 + configure: add macros to stash FLAG variables
 + configure: reorganize flow of argument checks
 + configure: ensure settings from user are also usable in the script

* mv/parseopt-ls-files (Sat Mar 7 20:27:22 2009 -0500) 4 commits
 + ls-files: fix broken --no-empty-directory
 + t3000: use test_cmp instead of diff
 + parse-opt: migrate builtin-ls-files.
 + Turn the flags in struct dir_struct into a single variable

The tip one was a subject for further discussion, but nothing is queued
yet.

----------------------------------------------------------------
[Will merge to 'master' soon]

* dm/maint-docco (Thu Mar 19 20:35:34 2009 -0700) 6 commits
 + Documentation: reword example text in git-bisect.txt.
 + Documentation: reworded the "Description" section of git-
   bisect.txt.
 + Documentation: minor grammatical fixes in git-branch.txt.
 + Documentation: minor grammatical fixes in git-blame.txt.
 + Documentation: reword the "Description" section of git-bisect.txt.
 + Documentation: minor grammatical fixes in git-archive.txt.

* mg/test-installed (Mon Mar 16 18:03:12 2009 +0100) 2 commits
 + test-lib.sh: Allow running the test suite against installed git
 + test-lib.sh: Test for presence of git-init in the right path.

----------------------------------------------------------------
[Discarded]

* hv/cvsimport-tests (Mon Mar 2 18:59:36 2009 +0100) 1 commit
 ? cvsimport: add test illustrating a bug in cvsps

* mh/cvsimport-tests (Mon Feb 23 06:08:14 2009 +0100) 5 commits
 ? Add a test of "git cvsimport"'s handling of tags and branches
 ? Add some tests of git-cvsimport's handling of vendor branches
 ? Test contents of entire cvsimported "master" tree contents
 ? Use CVS's -f option if available (ignore user's ~/.cvsrc file)
 ? Start a library for cvsimport-related tests

----------------------------------------------------------------
[Stalled and may need help and prodding to go forward]

* ps/blame (Thu Mar 12 21:30:03 2009 +1100) 1 commit
 - blame.c: start libifying the blame infrastructure

A few minor point remains in this initial one.

* jc/log-tz (Tue Mar 3 00:45:37 2009 -0800) 1 commit
 - Allow --date=local --date=other-format to work as expected

The one I posted had a few corner-case bugs that was caught with the test
suite; this one has them fixed.  People did not like the UI so it is kept
out of 'next'

* lh/submodule-tree-traversal (Sun Jan 25 01:52:06 2009 +0100) 1 commit
 - archive.c: add support for --submodules[=(all|checkedout)]

Discussion stalled on the submodule selection criteria.
Probably I should discard it and wait for a reroll if needed.

* jc/merge-convert (Mon Jan 26 16:45:01 2009 -0800) 1 commit
 - git-merge-file: allow converting the results for the work tree

This is a feature waiting for a user.

We did not give scripted Porcelains a way to say "this temporary file I am
using for merging is for this path, so use the core.autocrlf and attributes
rules for that final path".  Instead, merge-file simply wrote out the
data in the canonical repository representation.

rerere has the same issue, but it is a lot worse.  It reads the three
files (preimage, postimage and thisimage) from the work tree in the work
tree representation, merges them without converting them to the canonical
representation first but inserts the conflict markers with the canonical
representation and writes the resulting mess out.  It needs to be fixed to
read with convert_to_git(), merge them while they are still in the
canonical representation and possibly add conflict markers, and then write
the results out after convert_to_working_tree().  It also needs to write
in binary mode as well.

* db/foreign-scm (Sun Jan 11 15:12:10 2009 -0500) 3 commits
 - Support fetching from foreign VCSes
 - Add specification of git-vcs helpers
 - Add "vcs" config option in remotes

Daniel seems to have a plan for going forward with this series.

* cc/replace (Mon Feb 2 06:13:06 2009 +0100) 11 commits
 - builtin-replace: use "usage_msg_opt" to give better error messages
 - parse-options: add new function "usage_msg_opt"
 - builtin-replace: teach "git replace" to actually replace
 - Add new "git replace" command
 - environment: add global variable to disable replacement
 - mktag: call "check_sha1_signature" with the replacement sha1
 - replace_object: add a test case
 - object: call "check_sha1_signature" with the replacement sha1
 - sha1_file: add a "read_sha1_file_repl" function
 - replace_object: add mechanism to replace objects found in
   "refs/replace/"
 - refs: add a "for_each_replace_ref" function

I know, I really have to drop everything else and re-read these, but I
haven't managed to.

* js/notes (Wed Feb 18 11:17:27 2009 -0800) 14 commits
 - tests: fix "export var=val"
 - notes: refuse to edit notes outside refs/notes/
 - t3301: use test_must_fail instead of !
 - t3301: fix confusing quoting in test for valid notes ref
 - notes: use GIT_EDITOR and core.editor over VISUAL/EDITOR
 - notes: only clean up message file when editing
 - handle empty notes gracefully
 - git notes show: test empty notes
 - git-notes: fix printing of multi-line notes
 - notes: fix core.notesRef documentation
 - Add an expensive test for git-notes
 - Speed up git notes lookup
 - Add a script to edit/inspect notes
 - Introduce commit notes

----------------------------------------------------------------
[Actively cooking]

* jc/attributes-checkout (Fri Mar 20 10:32:09 2009 +0100) 2 commits
 - Add a test for checking whether gitattributes is honored by
   checkout.
 - Read attributes from the index that is being checked out

Original issue identified, and test provided by Kristian Amlie.

* fg/push-default (Mon Mar 16 16:42:52 2009 +0100) 2 commits
 - Display warning for default git push with no push.default config
 + New config push.default to decide default behavior for push

Replaced the old series with the first step to allow a smooth transition.
Some might argue that this should not give any warning but just give users
this new configuration to play with first, and after we know we are going
to switch default some day, start the warning.

* mg/http-auth (Wed Mar 18 18:46:41 2009 -0500) 6 commits
 + http-push.c: use a faux remote to pass to http_init
 + Do not name "repo" struct "remote" in push_http.c
 + http.c: CURLOPT_NETRC_OPTIONAL is not available in ancient
   versions of cURL
 + http authentication via prompts
 + http_init(): Fix config file parsing
 + http.c: style cleanups

Amos King added push side support on top of my fetch side support.

We may want to also pass --remote parameter from git-push to this backend
as Daniel did as an interim solution for the fetch side, so that we can
handle the configuration better.

* db/push-cleanup (Sun Mar 8 21:06:07 2009 -0400) 2 commits
 + Move push matching and reporting logic into transport.c
 + Use a common function to get the pretty name of refs

* kb/tracking-count-no-merges (Wed Mar 4 18:47:39 2009 +0100) 1 commit
 + stat_tracking_info(): only count real commits

This gives the merge commits zero weight when talking about how many
commits you have ahead (or behind) of the branch you are tracking.  Even
though I agree that they should carry much less weight than the "real"
commits, because your repeated merge from the other branch does not really
add any real value to the end result, giving them absolute zero weight
somehow feels wrong. At least it shows that your have been _active_ on the
branch.  But I do not feel very strongly about it.

----------------------------------------------------------------
[On Hold]

* jc/deny-delete-current-1.7.0 (Mon Feb 9 00:19:46 2009 -0800) 1 commit
 - receive-pack: default receive.denyDeleteCurrent to refuse

* jc/refuse-push-to-current-1.7.0 (Wed Feb 11 02:28:03 2009 -0800) 1 commit
 - Refuse updating the current branch in a non-bare repository via
   push

These are for 1.7.0, but the messages when they trigger together may need
to be rethought.
