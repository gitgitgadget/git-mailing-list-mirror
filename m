From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (topics)
Date: Mon, 17 Dec 2007 00:40:54 -0800
Message-ID: <7vwsrdaf3d.fsf@gitster.siamese.dyndns.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 17 09:41:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4BXX-0007fb-Gw
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 09:41:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754471AbXLQIlI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 03:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753717AbXLQIlH
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 03:41:07 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60572 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752351AbXLQIlG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 03:41:06 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id DA8FE182F;
	Mon, 17 Dec 2007 03:41:02 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id F3542182E;
	Mon, 17 Dec 2007 03:41:00 -0500 (EST)
In-Reply-To: <7vabof5mze.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 12 Dec 2007 18:48:05 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68519>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  Others commits may be stashed in 'offcuts'.

The topics list the commits in reverse chronological order.

----------------------------------------------------------------
[New Topics]

* ph/parseopt (Sun Dec 16 22:45:00 2007 -0800) 4 commits
 - builtin-tag: fix fallouts from recent parsopt restriction.
 - (squashme) gitcli documentation fixups
 - parseopt: Add a gitcli(5) man page.
 - parseopt: Enforce the use of the sticked form for optional
   arguments.

This series is needed by 1.5.4-rc1 for fixing regression relative to
1.5.3 series in the option parser: "git describe --abbrev HEAD" does not
work.  The current approach is taken by this series (discussed on the
list) to work it around by forbidding "git describe --abbrev 10 HEAD"
and requiring it be written as "git describe --abbrev=10 HEAD", but
taking that limitation literally will introduce serious usability
regressions.  We need careful auditing of all the commands that adopted
parse_options() API.

* ab/pserver (Fri Dec 14 04:08:51 2007 +0000) 1 commit
 - Authentication support for pserver

This came somewhat late; I think cvsserver is in its own little corner
and the change seems to be quite isolated, so with enough user requests
and Ack from primary people who have been involved with cvsserver I do
not think we mind to make an exception and make it a part of 1.5.4-rc1.


----------------------------------------------------------------
[Graduated to 'master']

* mh/http (Tue Dec 11 00:08:25 2007 +0100)

Big thanks to Daniel who helped reviewing this series which is about
clean-ups and fixes in http transport.

----------------------------------------------------------------
[Will cook further in 'next' and then merge to 'master' soon]

Again, we are post -rc0 and there is nothing interesting to see here.

----------------------------------------------------------------
[Actively cooking]

Again, we are post -rc0 and there is nothing interesting to see here.

----------------------------------------------------------------
[On hold]

* jc/api-doc (Sat Nov 24 23:48:04 2007 -0800) 1 commit

The primary reason of this series is because I think we made the system
a lot less approachable by losing hackability.  Although we still have
sample scripts in contrib/example for use of plumbing in scripts, they
will not help aspiring git-hacker-wannabees when our primary attention
has already shifted to moving things to C.

This currently consists of mostly stubs, although I wrote about a few
topics as examples.  Nice to have in v1.5.4, but we need more writers.

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
 - Make git-remote a builtin
 - Test "git remote show" and "git remote prune"
 - parseopt: add flag to stop on first non option
 - path-list: add functions to work with unsorted lists

This and Kristian's "git-clone in C" are on hold and post 1.5.4.

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
