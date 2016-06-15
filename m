From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Mar 2009, #07; Mon, 30)
Date: Mon, 30 Mar 2009 15:48:18 -0700
Message-ID: <7vtz5aaaq5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 31 00:51:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoQK2-0007xq-9E
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 00:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758602AbZC3Ws0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 18:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756843AbZC3Ws0
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 18:48:26 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53472 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757366AbZC3WsY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 18:48:24 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C8037A66E0;
	Mon, 30 Mar 2009 18:48:22 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 93CFFA66DF; Mon,
 30 Mar 2009 18:48:20 -0400 (EDT)
X-master-at: 442dd42d6d4903640b0dc5561481a77c88dcea90
X-next-at: 233382b233530fc38969fd1f31dec27e342c2a9f
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DF584022-1D7C-11DE-98A8-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115198>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the branches, but I am still
holding onto them.

The topics list the commits in reverse chronological order.  The topics
meant to be merged to the maintenance series have "maint-" in their names.

----------------------------------------------------------------
[New Topics]

* cj/doc-format (Fri Mar 27 00:36:47 2009 -0700) 11 commits
 + Merge branch 'cj/doc-quiet' into cj/doc-format
 + Documentation: option to render literal text as bold for manpages
 + Documentation: asciidoc.conf: fix verse block with block titles
 + Documentation: asciidoc.conf: always use <literallayout> for
   [blocktext]
 + Documentation: move "spurious .sp" code into manpage-base.xsl
 + Documentation: move quieting params into manpage-base.xsl
 + Documentation: rename docbook-xsl-172 attribute to git-asciidoc-
   no-roff
 + Documentation: use parametrized manpage-base.xsl with manpage-
   {1.72,normal}.xsl
 + Documentation: move callouts.xsl to manpage-{base,normal}.xsl
 + Documentation/Makefile: break up texi pipeline
 + Documentation/Makefile: make most operations "quiet"

* cj/doc-quiet (Fri Mar 27 01:49:39 2009 -0500) 2 commits
 + Documentation/Makefile: break up texi pipeline
 + Documentation/Makefile: make most operations "quiet"

I think these are ready for 'master'.

* jc/name-branch-iffy (Sat Mar 21 14:30:21 2009 -0700) 3 commits
 - checkout -: make "-" to mean "previous branch" everywhere
 - Don't permit ref/branch names to end with ".lock"
 - check_ref_format(): tighten refname rules

After all the bottom two are probably not so iffy.

* jc/name-branch (Sat Mar 21 14:35:51 2009 -0700) 5 commits
 + strbuf_check_branch_ref(): a helper to check a refname for a
   branch
 + Fix branch -m @{-1} newname
 + check-ref-format --branch: give Porcelain a way to grok branch
   shorthand
 + strbuf_branchname(): a wrapper for branch name shorthands
 + Rename interpret/substitute nth_last_branch functions

* sb/format-patch-patchname (Fri Mar 27 01:13:01 2009 +0100) 7 commits
 + log-tree: fix patch filename computation in "git format-patch"
 + format-patch: --numbered-files and --stdout aren't mutually
   exclusive
 + format-patch: --attach/inline uses filename instead of SHA1
 + format-patch: move get_patch_filename() into log-tree
 + format-patch: pass a commit to reopen_stdout()
 + format-patch: construct patch filename in one function
 + pretty.c: add %f format specifier to format_commit_message()

* mg/tracked-local-branches (Thu Mar 26 21:53:25 2009 +0100) 2 commits
 - [Reroll requested] Make local branches behave like remote branches
   when --tracked
 - Test for local branches being followed with --track

* cc/bisect-filter (Mon Mar 30 06:59:59 2009 +0200) 15 commits
 - bisect--helper: string output variables together with "&&"
 - rev-list: pass "int flags" as last argument of "show_bisect_vars"
 - t6030: test bisecting with paths
 - bisect: use "bisect--helper" and remove "filter_skipped" function
 - bisect: implement "read_bisect_paths" to read paths in
   "$GIT_DIR/BISECT_NAMES"
 - bisect--helper: implement "git bisect--helper"
 - rev-list: call new "filter_skip" function
 + rev-list: pass "revs" to "show_bisect_vars"
 + rev-list: make "show_bisect_vars" non static
 + rev-list: move code to show bisect vars into its own function
 + rev-list: move bisect related code into its own file
 + rev-list: make "bisect_list" variable local to "cmd_rev_list"
 + refs: add "for_each_ref_in" function to refactor "for_each_*_ref"
   functions
 + quote: add "sq_dequote_to_argv" to put unwrapped args in an argv
   array
 + quote: implement "sq_dequote_many" to unwrap many args in one
   string

I've reordered them to make the early three patches independent to the
rest of the series.  Dscho had a suggestion on the search it internally
does, so we might see further reroll of some patches in the series.

* jc/shared-literally (Fri Mar 27 23:21:00 2009 -0700) 4 commits
 + set_shared_perm(): sometimes we know what the final mode bits
   should look like
 + move_temp_to_file(): do not forget to chmod() in "Coda hack"
   codepath
 + Move chmod(foo, 0444) into move_temp_to_file()
 + "core.sharedrepository = 0mode" should set, not loosen

* tr/maint-1.6.1-doc-format-patch--root (Thu Mar 26 18:29:25 2009 +0100) 1 commit
 + Documentation: format-patch --root clarifications

* mh/format-patch-add-header (Thu Mar 26 10:51:05 2009 -0600) 1 commit
 + format-patch: add arbitrary email headers

* ef/fast-export (Mon Mar 23 12:53:09 2009 +0000) 4 commits
 + builtin-fast-export.c: handle nested tags
 + builtin-fast-export.c: fix crash on tagged trees
 + builtin-fast-export.c: turn error into warning
 + test-suite: adding a test for fast-export with tag variants

----------------------------------------------------------------
[Graduated to "master"]

* jk/reflog-date (Fri Mar 20 02:00:43 2009 -0400) 1 commit
 + make oneline reflog dates more consistent with multiline format

* js/maint-1.6.0-exec-path-env (Wed Mar 18 08:42:53 2009 +0100) 1 commit
 + export GIT_EXEC_PATH when git is run with --exec-path

* jc/maint-1.6.0-blame-s (Wed Mar 18 00:13:03 2009 -0700) 1 commit
 + blame: read custom grafts given by -S before calling
   setup_revisions()

The above are all ready for 'next'.

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

* jc/attributes-checkout (Fri Mar 20 10:32:09 2009 +0100) 2 commits
 + Add a test for checking whether gitattributes is honored by
   checkout.
 + Read attributes from the index that is being checked out

Original issue identified, and test provided by Kristian Amlie.

* fg/push-default (Mon Mar 16 16:42:52 2009 +0100) 2 commits
 + Display warning for default git push with no push.default config
 + New config push.default to decide default behavior for push

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

----------------------------------------------------------------
[Will merge to 'master' soon]

* kb/tracking-count-no-merges (Wed Mar 4 18:47:39 2009 +0100) 1 commit
 + stat_tracking_info(): only count real commits

This gives the merge commits zero weight when talking about how many
commits you have ahead (or behind) of the branch you are tracking.  Even
though I agree that they should carry much less weight than the "real"
commits, because your repeated merge from the other branch does not really
add any real value to the end result, giving them absolute zero weight
somehow feels wrong. At least it shows that your have been _active_ on the
branch.  But I do not feel very strongly about it.

* jc/maint-1.6.0-keep-pack (Sat Mar 21 17:26:11 2009 -0500) 6 commits
 + pack-objects: don't loosen objects available in alternate or kept
   packs
 + t7700: demonstrate repack flaw which may loosen objects
   unnecessarily
 + Remove --kept-pack-only option and associated infrastructure
 + pack-objects: only repack or loosen objects residing in "local"
   packs
 + git-repack.sh: don't use --kept-pack-only option to pack-objects
 + t7700-repack: add two new tests demonstrating repacking flaws

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
[Actively cooking]

* da/difftool (Tue Mar 24 23:29:59 2009 -0700) 5 commits
 - difftool: add a -y shortcut for --no-prompt
 - difftool: use perl built-ins when testing for msys
 - difftool: add various git-difftool tests
 - difftool: add git-difftool to the list of commands
 + difftool: move 'git-difftool' out of contrib

David has further refactoring which was a bit too early for me to pick
up.

----------------------------------------------------------------
[On Hold]

* jc/deny-delete-current-1.7.0 (Mon Feb 9 00:19:46 2009 -0800) 1 commit
 - receive-pack: default receive.denyDeleteCurrent to refuse

* jc/refuse-push-to-current-1.7.0 (Wed Feb 11 02:28:03 2009 -0800) 1 commit
 - Refuse updating the current branch in a non-bare repository via
   push

These are for 1.7.0, but the messages when they trigger together may need
to be rethought.
