From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Apr 2009, #01; Mon, 06)
Date: Mon, 06 Apr 2009 01:28:26 -0700
Message-ID: <7vskkm6v9x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 06 10:30:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqkDW-0001Mq-JM
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 10:30:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752805AbZDFI2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 04:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752787AbZDFI2d
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 04:28:33 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54351 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375AbZDFI2c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 04:28:32 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 071C6C26C;
	Mon,  6 Apr 2009 04:28:30 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id EB527C26B; Mon, 
 6 Apr 2009 04:28:27 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E88BCAE4-2284-11DE-B772-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115779>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the branches, but I am still
holding onto them.

The topics list the commits in reverse chronological order.  The topics
meant to be merged to the maintenance series have "maint-" in their names.

----------------------------------------------------------------
[New Topics]

* mh/html-path (Sun Apr 5 04:15:16 2009 +0200) 1 commit
 + add --html-path to get the location of installed HTML docs

* lt/reflog-expire (Mon Mar 30 21:34:14 2009 -0700) 2 commits
 + Speed up reflog pruning of unreachable commits
 + Clean up reflog unreachability pruning decision

* bs/maint-1.6.0-tree-walk-prefix (Wed Apr 1 19:34:03 2009 -0700) 2 commits
 + match_tree_entry(): a pathspec only matches at directory
   boundaries
 + tree_entry_interesting: a pathspec only matches at directory
   boundary

* ms/http-auth (Wed Apr 1 19:48:24 2009 +0300) 1 commit
 + Allow curl to rewind the read buffers

* js/maint-submodule-checkout (Thu Apr 2 15:30:25 2009 +0200) 1 commit
 + Fix 'git checkout <submodule>' to update the index

* cb/maint-merge-recursive-submodule-fix (Sun Apr 5 02:47:00 2009 +0200) 3 commits
 + simplify output of conflicting merge
 + update cache for conflicting submodule entries
 + add tests for merging with submodules

* fg/remote-prune (Fri Apr 3 11:03:44 2009 +0200) 2 commits
 + git remote update: New option --prune
 + builtin-remote.c: Split out prune_remote as a separate function.

These should go to 'master' soonish.

* cc/sha1-bsearch (Mon Apr 6 00:48:49 2009 -0700) 3 commits
 - sha1-lookup: fix up the assertion message
 - patch-ids: use the new generic "sha1_pos" function to lookup sha1
 - sha1-lookup: add new "sha1_pos" function to efficiently lookup
   sha1

I think this is Ok for 'next', but somebody might want to prove me wrong
by running some benchmarks.

----------------------------------------------------------------
[Will Discard]

* jc/name-branch-iffy (Sat Mar 21 14:30:21 2009 -0700) 1 commit
 - checkout -: make "-" to mean "previous branch" everywhere

----------------------------------------------------------------
[Graduated to "master"]

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
 + Make local branches behave like remote branches when --tracked
 + Test for local branches being followed with --track

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

* kb/tracking-count-no-merges (Wed Mar 4 18:47:39 2009 +0100) 1 commit
 + stat_tracking_info(): only count real commits

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

A few minor point remains in this initial one.  I hate to do these minor
fix-ups myself, but I may end up doing so...

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

* hv/cvsps-tests (Sun Apr 5 01:40:50 2009 -0700) 8 commits
 - t/t9600: remove exit after test_done
 - cvsimport: extend testcase about patchset order to contain
   branches
 - cvsimport: add test illustrating a bug in cvsps
 + Add a test of "git cvsimport"'s handling of tags and branches
 + Add some tests of git-cvsimport's handling of vendor branches
 + Test contents of entire cvsimported "master" tree contents
 + Use CVS's -f option if available (ignore user's ~/.cvsrc file)
 + Start a library for cvsimport-related tests

Two cvsimport test topics were rewound from 'next' and merged into this
one.  I'll keep this in 'pu' so that people can polish their cvsps skilz
to resolve issues these tests identify.

----------------------------------------------------------------
[Actively cooking]

* da/difftool (Sat Apr 4 21:00:24 2009 -0700) 25 commits
 - mergetool--lib: add new merge tool TortoiseMerge
 - mergetool--lib: make (g)vimdiff workable under Windows
 - mergetool--lib: consolidate the last redundant bits in
   {diff,merge}tool
 - mergetool-lib: specialize opendiff options when in diff mode
 - mergetool-lib: refactor run_mergetool and check_unchanged
 - bash completion: add git-difftool
 - {diff,merge}tool: rename helpers to remove them from tab-
   completion
 - mergetool-lib: add diffuse as merge and diff tool
 - mergetool-lib: specialize xxdiff options when in diff mode
 - mergetool-lib: specialize kdiff3 options when in diff mode
 - mergetool: use run_mergetool from git-mergetool-lib
 - difftool: use run_mergetool from git-mergetool-lib
 - mergetool-lib: introduce run_mergetool
 - difftool: use valid_tool from git-mergetool-lib
 - mergetool: use valid_tool from git-mergetool-lib
 - difftool: use get_mergetool_path from git-mergetool-lib
 - mergetool: use get_mergetool_path from git-mergetool-lib
 - Add a mergetool-lib scriptlet for holding common merge tool
   functions
 - mergetool: use $( ... ) instead of `backticks`
 - difftool: add support for a difftool.prompt config variable
 - difftool: add a -y shortcut for --no-prompt
 - difftool: use perl built-ins when testing for msys
 - difftool: add various git-difftool tests
 - difftool: add git-difftool to the list of commands
 + difftool: move 'git-difftool' out of contrib

* cc/bisect-filter (Mon Mar 30 06:59:59 2009 +0200) 19 commits
 - bisect--helper: string output variables together with "&&"
 - rev-list: pass "int flags" as last argument of "show_bisect_vars"
 - t6030: test bisecting with paths
 - bisect: use "bisect--helper" and remove "filter_skipped" function
 - bisect: implement "read_bisect_paths" to read paths in
   "$GIT_DIR/BISECT_NAMES"
 - bisect--helper: implement "git bisect--helper"
 - bisect: use the new generic "sha1_pos" function to lookup sha1
 - rev-list: call new "filter_skip" function
 - Merge branch 'cc/sha1-bsearch' into HEAD
 - patch-ids: use the new generic "sha1_pos" function to lookup sha1
 - sha1-lookup: add new "sha1_pos" function to efficiently lookup
   sha1
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

Re-rolled and made earlier parts ready for 'master'.  I think we should
move this to 'next' soonish and aim to have it in 1.6.3

* cc/replace (Mon Feb 2 06:13:06 2009 +0100) 13 commits
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
 - patch-ids: use the new generic "sha1_pos" function to lookup sha1
 - sha1-lookup: add new "sha1_pos" function to efficiently lookup
   sha1

Re-rolled based on the updated binary search API.

----------------------------------------------------------------
[On Hold]

* jc/deny-delete-current-1.7.0 (Mon Feb 9 00:19:46 2009 -0800) 1 commit
 - receive-pack: default receive.denyDeleteCurrent to refuse

* jc/refuse-push-to-current-1.7.0 (Wed Feb 11 02:28:03 2009 -0800) 1 commit
 - Refuse updating the current branch in a non-bare repository via
   push

These are for 1.7.0, but the messages when they trigger together may need
to be rethought.
