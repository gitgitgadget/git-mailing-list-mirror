From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (topics)
Date: Sun, 23 Dec 2007 01:20:53 -0800
Message-ID: <7vhci9u5qi.fsf@gitster.siamese.dyndns.org>
References: <20071022063222.GS14735@spearce.org>
	<7vzly84qwf.fsf@gitster.siamese.dyndns.org>
	<7vmytycykt.fsf@gitster.siamese.dyndns.org>
	<7vr6j6ve90.fsf@gitster.siamese.dyndns.org>
	<7vir4d40sw.fsf@gitster.siamese.dyndns.org>
	<7vwsso3poo.fsf@gitster.siamese.dyndns.org>
	<7vfxz89x9q.fsf@gitster.siamese.dyndns.org>
	<7vabpctx3b.fsf@gitster.siamese.dyndns.org>
	<7vsl30eyuk.fsf@gitster.siamese.dyndns.org>
	<7vve7tuz3a.fsf@gitster.siamese.dyndns.org>
	<7v4pfakr4j.fsf@gitster.siamese.dyndns.org>
	<7vzlwv6sxr.fsf@gitster.siamese.dyndns.org>
	<7vy7ca6ea9.fsf@gitster.siamese.dyndns.org>
	<7vzlwps8zf.fsf@gitster.siamese.dyndns.org>
	<7vejdy4yuw.fsf@gitster.siamese.dyndns.org>
	<7v7ijorwnc.fsf@gitster.siamese.dyndns.org>
	<7vabof5mze.fsf@gitster.siamese.dyndns.org>
	<7vwsrdaf3d.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 23 10:21:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J6N1d-00030W-VI
	for gcvg-git-2@gmane.org; Sun, 23 Dec 2007 10:21:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbXLWJVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Dec 2007 04:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbXLWJVL
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Dec 2007 04:21:11 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62542 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696AbXLWJVI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Dec 2007 04:21:08 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 184C110AD;
	Sun, 23 Dec 2007 04:21:04 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 03CB210AC;
	Sun, 23 Dec 2007 04:20:59 -0500 (EST)
In-Reply-To: <7vwsrdaf3d.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 17 Dec 2007 00:40:54 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69172>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  Others commits may be stashed in 'offcuts'.

The topics list the commits in reverse chronological order.

----------------------------------------------------------------
[New Topics]

* ab/pserver (Fri Dec 14 04:08:51 2007 +0000) 1 commit
 - Authentication support for pserver

This needs careful security audit and a fix to its password
database format.  Plaintext in .git/config is not acceptable.

* rs/pretty-safety (Thu Dec 20 13:20:15 2007 +0100) 1 commit
 - Serious bug with pretty format strings & empty bodies?

I do not think what this addresses is any "serious" problem in
real life.  But on the other hand I do not think it hurts.  Will
take a look at it again and will merge.

* ar/commit-cleanup (Sat Dec 22 19:46:24 2007 +0100) 4 commits
 + Allow selection of different cleanup modes for commit messages
 + builtin-commit: avoid double-negation in the code.
 + builtin-commit: fix amending of the initial commit
 + t7005: do not exit inside test.

This is cleaned up since the last version Alex posted, and the
first three are fixes and clean-ups, so they will be merged.
The primary purpose of this series by Alex is to allow commits
to be made verbatim without stripping lines that begin with '#'
in the commit log messages, which would be a worthy goal, so I
do not mind merging it in 1.5.4.

* ph/describe-match (Fri Dec 21 22:49:54 2007 +0100) 1 commit
 + git-describe: Add a --match option to limit considered tags.

Even though this is a new feature, the impact to the main
codepath is minimum and I think it is Ok to merge it in 1.5.4,
but still seems to have a funny interaction with --contains.  So
it will be on hold.

* jc/sys-select (Tue Dec 18 01:52:07 2007 -0800) 1 commit
 - Do not include <sys/select.h> on pre- POSIX.1-2001 systems

This was done to help HP-UX port, but it appears that HP-UX
headers do not like to cooperate with usual _POSIX_VERSION rule,
so we probably need to scrap it and instead use manual
configuration instead.

----------------------------------------------------------------
[Graduated to 'master']

* jc/api-doc (Sat Nov 24 23:48:04 2007 -0800) 1 commit

The primary reason of this series is because I think we made the system
a lot less approachable by losing hackability.  Although we still have
sample scripts in contrib/example for use of plumbing in scripts, they
will not help aspiring git-hacker-wannabees when our primary attention
has already shifted to moving things to C.

This currently consists of mostly stubs, although I wrote about a few
topics as examples.  Nice to have in v1.5.4, but we need more writers.

----------------------------------------------------------------
[Will cook further in 'next' and then merge to 'master' soon]

Nothing to see.  We are in -rc.  Please test 'master'.

----------------------------------------------------------------
[Actively cooking]

Nothing to see.  We are in -rc.  Please test 'master'.

----------------------------------------------------------------
[On hold]

* nd/dashless (Wed Nov 28 23:21:57 2007 +0700) 1 commit
 - Move all dashed-form commands to libexecdir

I think this is a sane thing to do in the longer term.  Will be in
'next' after v1.5.4.  I think "leave porcelain on PATH" might be also a
good thing as a transition measure.

Incidentally, if we do not install dashed form of built-ins anywhere
(which is not this series is about --- this is just moving them out of
user's PATH), "git help -a" will stop showing them.  I am not enthused
about removing the hardlinks to built-ins to begin with, but people who
want such a change need to first modify help.c:list_commands() to pick
up builtins without having git-foo hardlinks in gitexecdir.  This may
need to happen anyway as mingw fallouts.

* js/remote (Wed Dec 5 19:02:15 2007 +0000) 4 commits
 . Make git-remote a builtin
 . Test "git remote show" and "git remote prune"
 . parseopt: add flag to stop on first non option
 . path-list: add functions to work with unsorted lists

This and Kristian's "git-clone in C" are on hold and will need
to be rebased, post 1.5.4.

----------------------------------------------------------------
[Stalled]

* ns/checkout-push-pop (Wed Dec 5 07:04:06 2007 +0900) 1 commit
 - git-checkout --push/--pop

A reasonably cleanly written cute hack, and I do not see this breaking
the normal codepath.  But I tend to agree with people that 'push' is
too late for forgetful mortals, and just a single "previous" would be
easier to use.

* jc/git-symref (Tue Dec 11 16:42:46 2007 -0800) 1 commit
 - PARK: show-symref protocol extension.

This is a demonstration of a possible component in the future direction
for HEAD discovery done by git-clone.

* js/reflog-delete (Wed Oct 17 02:50:45 2007 +0100) 1 commit
 + Teach "git reflog" a subcommand to delete single entries

* jk/builtin-alias (Fri Nov 30 11:22:58 2007 -0500) 1 commit
 + Support builtin aliases

Even the original author has slight NAK on this and I tend to agree.
May want to eventurally revert from 'next' but we are not in a hurry
even to do that.

* jc/diff-pathspec (Sun Nov 25 10:03:48 2007 -0800) 1 commit
 - Making ce_path_match() more useful by accepting globs

This was to allow "git diff-files -- '*.h'" (currently diff family
knows only the leading directory match and not fileglobs), but was shot
down by Alex.  I tend to agree with him.

* jc/dashless (Sat Dec 1 22:09:22 2007 -0800) 2 commits
 - Prepare execv_git_cmd() for removal of builtins from the
   filesystem
 - git-shell: accept "git foo" form

We do not plan to remove git-foo form completely from the filesystem at
this point, so these are not strictly necessary.

* jc/diff-relative (Thu Dec 6 09:48:32 2007 -0800) 1 commit
 . Make "diff" Porcelain output paths as relative to subdirectory.

* jc/pathspec (Thu Sep 13 13:38:19 2007 -0700) 3 commits
 . pathspec_can_match(): move it from builtin-ls-tree.c to tree.c
 . ls-tree.c: refactor show_recursive() and rename it.
 . tree-diff.c: split out a function to match a single pattern.

* jc/cherry-pick (Sun Dec 16 21:00:03 2007 -0800) 2 commits
 . beginning of use of replay merge in revert
 . revert/cherry-pick: start refactoring call to merge_recursive

* jc/nu (Sun Oct 14 22:07:34 2007 -0700) 3 commits
 . merge-nu: a new merge backend without using unpack_trees()
 . read_tree: take an explicit index structure
 . gcc 4.2.1 -Werror -Wall -ansi -pedantic -std=c99: minimum fix
