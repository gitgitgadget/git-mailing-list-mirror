From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (topics)
Date: Sat, 16 Feb 2008 19:59:57 -0800
Message-ID: <7vejbc44hu.fsf@gitster.siamese.dyndns.org>
References: <7v7ihmuwzi.fsf@gitster.siamese.dyndns.org>
 <7vodavd9qw.fsf@gitster.siamese.dyndns.org>
 <7vbq6tset4.fsf@gitster.siamese.dyndns.org>
 <7vmyq9gk94.fsf@gitster.siamese.dyndns.org>
 <7vk5la4oxq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 17 05:00:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQahn-0006ph-2U
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 05:00:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753013AbYBQEAI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 23:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753091AbYBQEAH
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 23:00:07 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45394 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753013AbYBQEAF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 23:00:05 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C1F263E4;
	Sat, 16 Feb 2008 23:00:03 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 ED9B863E1; Sat, 16 Feb 2008 22:59:59 -0500 (EST)
In-Reply-To: <7vk5la4oxq.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 11 Feb 2008 23:24:49 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74093>

Here are the topics that have been kept out of 'master'.
Commits prefixed with '-' are only in 'pu' while commits
prefixed with '+' are in 'next'.

The topics list the commits in reverse chronological order.

Many topics graduated to 'master'.  As announced, I'll rewind
and rebuild "next" with the surviving topics on top of "master",
sometime tomorrow.

----------------------------------------------------------------
[New Topics]

* lt/dirstat (Tue Feb 12 17:06:58 2008 -0800) 2 commits
 - diff: make --dirstat binary-file safe
 + Add "--dirstat" for some directory statistics

The first one already in 'next' is the latest toy Linus showed
off in his 2.6.25-rc2 announcement.  The other one on top is a
rework to make it work more sensibly with a tree with binary
contents.

* gp/hash-stdin (Thu Feb 14 20:13:55 2008 +0000) 1 commit
 - hash-object: cleanup handling of command line options

I've touched Gerrit's original up somewhat and am waiting for a
feedback.

* bc/fopen (Fri Feb 8 20:32:47 2008 -0600) 1 commit
 + Add compat/fopen.c which returns NULL on attempt to open directory

We would want fread(3) from fopen(3)'ed directory to fail but
some systems don't.  This adds a compatibility wrapper for
fopen(3) that fails on directories.

* js/maint-http-push (Thu Feb 14 23:26:12 2008 +0000) 3 commits
 + http-push: avoid a needless goto
 + http-push: do not get confused by submodules
 + http-push: avoid invalid memory accesses

This forks off of 'maint' in the hope of having a fixed
http-push in future 1.5.4.X.  Will wait for success stories.

* js/run-command (Sat Feb 16 18:36:39 2008 +0100) 2 commits
 - start_command(), if .in/.out > 0, closes file descriptors, not the
   callers
 - start_command(), .in/.out/.err = -1: Callers must close the file
   descriptor

* jc/bulk-allocate (Wed Feb 13 18:37:27 2008 -0800) 2 commits
 - Bulk allocate diff_filepair
 - patch freeable-bulk-alloc

* jk/empty-tree (Wed Feb 13 05:50:51 2008 -0500) 2 commits
 + add--interactive: handle initial commit better
 + hard-code the empty tree object

Jeff added code to deal with the initial commit case better in
"git-add -i".  Personally I wonder why we bother (if it is an
initial commit, the user _knows_ there is nothing to diff in the
HEAD as there is no HEAD yet, heavens), but the code is already
there so why not.

----------------------------------------------------------------
[Merged to 'master']

* jc/submittingpatches (Sun Feb 3 17:02:28 2008 -0800)

* jk/noetcconfig (Wed Feb 6 05:11:53 2008 -0500)

* pb/prepare-commit-msg (Tue Feb 5 08:04:18 2008 +0100)

* jc/gitignore-ends-with-slash (Thu Jan 31 20:23:25 2008 -0800)

* bd/qsort (Tue Feb 5 15:10:44 2008 -0600)

* cc/browser (Mon Feb 11 10:57:34 2008 -0500)

* sp/safecrlf (Wed Feb 6 12:25:58 2008 +0100)

----------------------------------------------------------------
[Actively Cooking]

* jc/setup (Sun Feb 3 23:59:17 2008 -0800) 4 commits
 + builtin-mv: minimum fix to avoid losing files
 + git-add: adjust to the get_pathspec() changes.
 + Make blame accept absolute paths
 + setup: sanitize absolute and funny paths in get_pathspec()

* lt/revision-walker (Sat Feb 9 14:02:07 2008 -0800) 1 commit
 + Add "--show-all" revision walker flag for debugging

* mc/prefix (Sat Feb 9 15:40:19 2008 +0100) 1 commit
 + Avoid a useless prefix lookup in strbuf_expand()

* db/checkout (Sat Feb 16 17:17:09 2008 -0800) 12 commits
 + checkout: notice when the switched branch is behind or forked
 + Build in checkout
 + Move code to clean up after a branch change to branch.c
 + Library function to check for unmerged index entries
 + Use diff -u instead of diff in t7201
 + Move create_branch into a library file
 + Build-in merge-recursive
 + Add "skip_unmerged" option to unpack_trees.
 + Discard "deleted" cache entries after using them to update the
   working tree
 + Send unpack-trees debugging output to stderr
 + Add flag to make unpack_trees() not print errors.
 + Allow callers of unpack_trees() to handle failure

Checkout rewritten in C.

* jc/apply-whitespace (Mon Feb 11 15:32:29 2008 -0800) 14 commits
 + apply: do not barf on patch with too large an offset
 + core.whitespace: cr-at-eol
 + git-apply --whitespace=fix: fix whitespace fuzz introduced by
   previous run
 + builtin-apply.c: pass ws_rule down to match_fragment()
 + builtin-apply.c: move copy_wsfix() function a bit higher.
 + builtin-apply.c: do not feed copy_wsfix() leading '+'
 + builtin-apply.c: simplify calling site to apply_line()
 + builtin-apply.c: clean-up apply_one_fragment()
 + builtin-apply.c: mark common context lines in lineinfo structure.
 + builtin-apply.c: optimize match_beginning/end processing a bit.
 + builtin-apply.c: make it more line oriented
 + builtin-apply.c: push match-beginning/end logic down
 + builtin-apply.c: restructure "offset" matching
 + builtin-apply.c: refactor small part that matches context

Further work on "apply --whitespace=fix".

* jc/diff-relative (Wed Feb 13 00:34:39 2008 -0800) 2 commits
 + diff --relative: help working in a bare repository
 + diff --relative: output paths as relative to the current
   subdirectory

* jc/rename (Tue Jan 29 20:54:56 2008 -0800) 1 commit
 + Optimize rename detection for a huge diff

----------------------------------------------------------------
[On Hold]

* br/gitweb (Fri Feb 8 14:38:04 2008 -0200) 1 commit
 + gitweb: Use the config file to set repository owner's name.

On hold per Jakub's reluctance.

* js/reflog-delete (Fri Jan 4 19:11:37 2008 -0600) 2 commits
 + builtin-reflog.c: fix typo that accesses an unset variable
 + Teach "git reflog" a subcommand to delete single entries

There was a patch that uses this to implement "git-stash drop",
which I didn't queue, as the command name and the UI was
undecided yet.  Dscho was in favor of "pop" without "drop".

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
