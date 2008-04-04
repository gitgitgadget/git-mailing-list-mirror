From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (topics)
Date: Fri, 04 Apr 2008 11:24:39 -0700
Message-ID: <7vhcehzdeg.fsf@gitster.siamese.dyndns.org>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
 <7vwso85qkf.fsf@gitster.siamese.dyndns.org>
 <7vwso5r87q.fsf@gitster.siamese.dyndns.org>
 <7v8x0992hy.fsf@gitster.siamese.dyndns.org>
 <7vd4pf7h9y.fsf@gitster.siamese.dyndns.org>
 <7vwsnjl21c.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 04 20:25:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jhqba-0006G0-Md
	for gcvg-git-2@gmane.org; Fri, 04 Apr 2008 20:25:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752463AbYDDSYz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Apr 2008 14:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752310AbYDDSYz
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Apr 2008 14:24:55 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63326 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027AbYDDSYx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Apr 2008 14:24:53 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8525A6F48;
	Fri,  4 Apr 2008 14:24:50 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 715E46F47; Fri,  4 Apr 2008 14:24:48 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78811>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.

The topics list the commits in reverse chronological order.

With a handful topics graduated to "master", we hopefully will have the
final 1.5.5 soon.

----------------------------------------------------------------
[New Topics]

* mv/defer-gc (Wed Apr 2 21:35:11 2008 +0200) 3 commits
 - contrib/hooks: add an example pre-auto-gc hook
 - Documentation/hooks: add pre-auto-gc hook
 - git-gc --auto: add pre-auto-gc hook

A new hook to stop "git gc --auto" from running.

* bc/filter-branch (Wed Mar 26 10:47:09 2008 -0500) 1 commit
 - filter-branch.sh: support nearly proper tag name filtering

New feature, will probably be part of the release after 1.5.5

----------------------------------------------------------------
[Graduated to "master"]

* bc/mktag (Thu Mar 27 11:16:04 2008 -0500) 1 commit
 + mktag.c: improve verification of tagger field and tests

* je/cvsserver (Thu Mar 27 14:02:14 2008 -0700) 1 commit
 + Allow git-cvsserver database table name prefix to be specified.

* dd/cvsserver (Thu Mar 27 23:18:35 2008 +0100) 7 commits
 + cvsserver: Use the user part of the email in log and annotate
   results
 + cvsserver: Add test for update -p
 + cvsserver: Implement update -p (print to stdout)
 + cvsserver: Add a few tests for 'status' command
 + cvsserver: Do not include status output for subdirectories if -l
   is passed
 + cvsserver: Only print the file part of the filename in status
   header
 + cvsserver: Respond to the 'editors' and 'watchers' commands

* pb/cvsserver (Sun Mar 16 20:00:21 2008 +0100) 1 commit
 + git-cvsserver: handle change type T

* js/filter-branch (Mon Mar 31 09:14:15 2008 +0200) 2 commits
 + filter-branch: Fix renaming a directory in the tree-filter
 + filter-branch: Test renaming directories in a tree-filter

----------------------------------------------------------------
[On Hold]

* jk/add-i-mode (Thu Mar 27 03:32:25 2008 -0400) 2 commits
 + add--interactive: allow user to choose mode update
 + add--interactive: ignore mode change in 'p'atch command

New feature, will probably be part of the release after 1.5.5

* gp/gitweb (Wed Mar 26 18:11:19 2008 +0000) 1 commit
 + gitweb: fallback to system-wide config file if default config does
   not exist

New feature, will probably be part of the release after 1.5.5

* gs/pretty-hexval (Fri Mar 21 10:05:06 2008 -0500) 1 commit
 + pretty.c: add %x00 format specifier.

Adds a generic "insert any byte value" to --pretty=format:<> specifier.
New feature, will probably be part of the release after 1.5.5

* jc/send-pack-tell-me-more (Thu Mar 20 00:44:11 2008 -0700) 1 commit
 - "git push": tellme-more protocol extension

Allows common ancestor negotiation for git-push to help people with shared
repository workflow in certain minority situations.  The lack of protocol
support has been bugging me for quite some time, and that was the reason I
did this, but because I have met no real user with shared repository
workflow who complained on this issue, I think this is not urgent.

* jc/test (Thu Feb 21 21:17:54 2008 -0800) 2 commits
 - tests: convert "cmp" and "cmp -s" to test_cmp
 - tests: test_cmp helper function

This one may be more elaborate, but Jeff's patch is much simpler.

* fl/send-email-outside (Fri Mar 14 18:29:30 2008 +0100) 4 commits
 + send-email: Don't require to be called in a repository
 + Git.pm: Don't require repository instance for ident
 + Git.pm: Don't require a repository instance for config
 + var: Don't require to be in a git repository.

People couldn't invoke "git send-email" from outside their repositories,
but this series allows them to.  I do not think it is urgent, though.
This does not look risky, even though it touches Git.pm that is shared
with other things.  This has been cooking in 'next' for some time and we
haven't heard about breakages caused by this.  Will probably be the first
thing to be merged in 'master' post 1.5.5.

* jc/rebase (Sat Mar 15 13:17:42 2008 -0700) 1 commit
 + rebase [--onto O] A B: omit needless checkout

We used to "git checkout B && git rebase A" internally to implement this,
which meant the work tree was smudged one time too many.  This is probably
a safe optimization, but it case after -rc0 and is not really a must-have
fix.  One of the first after post 1.5.5.

* lt/case-insensitive (Sat Mar 22 14:22:44 2008 -0700) 9 commits
 - Make git-add behave more sensibly in a case-insensitive
   environment
 - When adding files to the index, add support for case-independent
   matches
 - Make unpack-tree update removed files before any updated files
 - Make branch merging aware of underlying case-insensitive
   filsystems
 - Add 'core.ignorecase' option
 - Make hash_name_lookup able to do case-independent lookups
 - Make "index_name_exists()" return the cache_entry it found
 - Move name hashing functions into a file of its own
 - Make unpack_trees_options bit flags actual bitfields

The beginning of ASCII-only case insensitive filesystem support.

* jc/unpack-careful (Fri Mar 7 08:39:53 2008 +0100) 5 commits
 + t5300: add test for "index-pack --strict"
 + receive-pack: allow using --strict mode for unpacking objects
 + unpack-objects: fix --strict handling
 + t5300: add test for "unpack-objects --strict"
 + unpack-objects: prevent writing of inconsistent objects

This would re-instate the "unpack-objects --strict" but we probably should
not do this before 1.5.5.

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

Scheduled for 1.6.0.

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
