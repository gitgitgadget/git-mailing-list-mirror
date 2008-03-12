From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (topics)
Date: Wed, 12 Mar 2008 00:50:24 -0700
Message-ID: <7vwso85qkf.fsf@gitster.siamese.dyndns.org>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 12 08:51:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZLk6-0007E7-7F
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 08:51:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbYCLHuj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 03:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbYCLHuj
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 03:50:39 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35627 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142AbYCLHui (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 03:50:38 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1D0EF18A7;
	Wed, 12 Mar 2008 03:50:37 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id D214C18A6; Wed, 12 Mar 2008 03:50:32 -0400 (EDT)
In-Reply-To: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 09 Mar 2008 03:46:24 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76936>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.

The topics list the commits in reverse chronological order.

----------------------------------------------------------------
[New Topics]

* cc/help (Tue Mar 11 08:51:12 2008 +0100) 3 commits
 + help: implement multi-valued "man.viewer" config option
 + Documentation: help: describe 'man.viewer' config variable
 + help: add "man.viewer" config var to use "woman" or "konqueror"

* ph/maint-quiltimport (Sat Mar 8 19:27:09 2008 +0100) 1 commit
 + git-quiltimport: better parser to grok "enhanced" series files.

* mr/autoconf-fread (Tue Mar 11 09:48:34 2008 +0100) 1 commit
 + autoconf: Test FREAD_READS_DIRECTORIES

* db/diff-to-fp (Mon Mar 10 13:58:26 2008 -0400) 2 commits
 - wt-status.c: no need for dup() dance anymore
 - Write diff output to a file in struct diff_options

All of these can be in 1.5.5 (they may or may not need fix-ups); let's
close the 1.5.5 merge window now with these.

----------------------------------------------------------------
[Graduated to 'master']

* lt/unpack-trees (Fri Mar 7 13:48:40 2008 -0800) 10 commits
 + unpack_trees(): minor memory leak fix in unused destination index
 + Make 'unpack_trees()' have a separate source and destination index
 + Make 'unpack_trees()' take the index to work on as an argument
 + Add 'const' where appropriate to index handling functions
 + Fix tree-walking compare_entry() in the presense of --prefix
 + Move 'unpack_trees()' over to 'traverse_trees()' interface
 + Make 'traverse_trees()' traverse conflicting DF entries in
   parallel
 + Add return value to 'traverse_tree()' callback
 + Make 'traverse_tree()' use linked structure rather than 'const
   char *base'
 + Add 'df_name_compare()' helper function

* js/remote (Sat Mar 8 23:40:42 2008 +0100) 9 commits
 + "remote update": print remote name being fetched from
 + builtin remote rm: remove symbolic refs, too
 + remote: fix "update [group...]"
 + remote show: Clean up connection correctly if object fetch wasn't
   done
 + builtin-remote: prune remotes correctly that were added with --
   mirror
 + Make git-remote a builtin
 + Test "git remote show" and "git remote prune"
 + parseopt: add flag to stop on first non option
 + path-list: add functions to work with unsorted lists

----------------------------------------------------------------
[Actively Cooking]

* py/submodule (Tue Mar 11 21:52:19 2008 +0800) 5 commits
 + git-submodule summary: test
 + git-submodule summary: documentation
 + git-submodule summary: limit summary size
 + git-submodule summary: show commit summary
 + git-submodule summary: code framework

I didn't see anybody very supportive for this series, but I do not think
this regresses existing other subcommands to "git submodule", so let's
merge this to 'master' before 1.5.5 and see how useful submodule users
find this.

----------------------------------------------------------------
[On Hold]

* nd/worktree (Sun Mar 2 17:35:43 2008 +0700) 10 commits
 - Additional tests to capture worktree special cases
 - Documentation: update api-builtin and api-setup
 - Make setup_git_directory() auto-setup worktree if found
 - builtin-archive: mark unused prefix "unused_prefix"
 - Completely move out worktree setup from
   setup_git_directory_gently()
 - http-push: Avoid calling setup_git_directory() twice
 - Make setup_work_tree() return new prefix
 - Make get_git_dir() and 'git rev-parse --git-dir' absolute path
 - Make sure setup_git_directory is called before accessing
   repository
 - "git read-tree -m" and the like require worktree

Every time we touch work-tree stuff we seem to unstabilize; this round
seems more solid but I am still treading cautiously.  Not sure if we want
this for 1.5.5.

* jc/unpack-careful (Fri Mar 7 08:39:53 2008 +0100) 5 commits
 + t5300: add test for "index-pack --strict"
 + receive-pack: allow using --strict mode for unpacking objects
 + unpack-objects: fix --strict handling
 + t5300: add test for "unpack-objects --strict"
 + unpack-objects: prevent writing of inconsistent objects

This would re-instate the "unpack-objects --strict" but we probably should
not do this before 1.5.5.

* jc/test (Thu Feb 21 21:17:54 2008 -0800) 2 commits
 - tests: convert "cmp" and "cmp -s" to test_cmp
 - tests: test_cmp helper function

* jc/rename (Fri Mar 7 14:03:19 2008 -0800) 2 commits
 - diffcore-rename: make file_table available outside exact rename
   detection
 + Optimize rename detection for a huge diff

* jc/dirstat (Tue Feb 12 17:06:58 2008 -0800) 1 commit
 - diff: make --dirstat binary-file safe

* lh/git-file (Wed Feb 20 23:13:16 2008 +0100) 4 commits
 - Teach GIT-VERSION-GEN about the .git file
 - Teach git-submodule.sh about the .git file
 - Teach resolve_gitlink_ref() about the .git file
 - Add platform-independent .git "symlink"

The idea and the implementation seem Ok, but this leaves
distinct feeling that it is a solution still waiting for a user
(e.g. "git submodule" enhancements to take advantage of this
facility to preserve the subrepository while switching between a
revision with a submodule and another before the submodule was
bound to the superproject).

* nd/dashless (Wed Nov 28 23:21:57 2007 +0700) 1 commit
 - Move all dashed-form commands to libexecdir

Scheduled for 1.6.0.  I am not sure if we should merge this to
'next' before 1.5.5.  Most active people will be on 'next' and
if we have this there, the resulting 1.5.5 release might end up
having issues that come from differences this one introduces.

* jc/dashless (Sat Dec 1 22:09:22 2007 -0800) 2 commits
 - Prepare execv_git_cmd() for removal of builtins from the
   filesystem
 - git-shell: accept "git foo" form

We do not plan to remove git-foo form completely from the filesystem at
this point, but git-shell may need to be updated.

* jc/sha1-lookup (Sun Dec 30 03:13:27 2007 -0800) 2 commits
 - sha1-lookup: make selection of 'middle' less aggressive
 - sha1-lookup: more memory efficient search in sorted list of SHA-1

Micro-optimization whose real world benefit is not proven.

* jc/cherry-pick (Wed Feb 20 23:17:06 2008 -0800) 3 commits
 - WIP: rethink replay merge
 - Start using replay-tree merge in cherry-pick
 - revert/cherry-pick: start refactoring call to merge_recursive

This is meant to improve cherry-pick's behaviour by not using
merge-recursive, but unfortunately has stalled for some time now.

* jc/stripspace (Sun Mar 9 00:30:35 2008 -0800) 6 commits
 - git-am --forge: add Signed-off-by: line for the author
 - git-am: clean-up Signed-off-by: lines
 - stripspace: add --log-clean option to clean up signed-off-by:
   lines
 - stripspace: use parse_options()
 - Add "git am -s" test
 - git-am: refactor code to add signed-off-by line for the committer

Just my toy at this moment.
