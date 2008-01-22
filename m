From: Junio C Hamano <gitster@pobox.com>
Subject: What will be cooking in git.git post 1.5.4 (topics)
Date: Tue, 22 Jan 2008 00:47:44 -0800
Message-ID: <7vwsq2s0un.fsf_-_@gitster.siamese.dyndns.org>
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
	<7vhci9u5qi.fsf@gitster.siamese.dyndns.org>
	<7vhchsa63t.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 22 09:48:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHEny-0003YJ-WD
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 09:48:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755529AbYAVIr4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 03:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755247AbYAVIr4
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 03:47:56 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62127 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755203AbYAVIrz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2008 03:47:55 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C54A22FBA;
	Tue, 22 Jan 2008 03:47:53 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A991F2FB9;
	Tue, 22 Jan 2008 03:47:51 -0500 (EST)
In-Reply-To: <7vhchsa63t.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sat, 05 Jan 2008 03:01:42 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71432>

Here are the topics that have been kept out of 'master'.
Commits prefixed with '-' are only in 'pu' while commits
prefixed with '+' are in 'next'.  Others commits may be stashed
in 'offcuts'.

The topics list the commits in reverse chronological order.

----------------------------------------------------------------
[New Topics]

* jc/sha1-lookup (Sun Dec 30 03:13:27 2007 -0800) 2 commits
 - sha1-lookup: make selection of 'middle' less aggressive
 - sha1-lookup: more memory efficient search in sorted list of SHA-1

Micro-optimization whose real world benefit is not proven.
Definitely post 1.5.4.

* lt/in-core-index (Sun Jan 20 15:19:56 2008 +0000) 5 commits
 + Also use unpack_trees() in do_diff_cache()
 + Make run_diff_index() use unpack_trees(), not read_tree()
 + Avoid running lstat(2) on the same cache entry.
 + index: be careful when handling long names
 + Make on-disk index representation separate from in-core one

This is about reducing number of lstat(2) calls during complex
operations.  Most likely this will be the first series to be
merged after 1.5.4 final.

----------------------------------------------------------------
[Graduated to 'master']

* jc/diff-hunk-header (Wed Jan 2 01:50:11 2008 -0800) 2 commits

This was to fix a real-world issues.

----------------------------------------------------------------
[Will cook further in 'next' and then merge to 'master' soon]

Nothing to see here.  We are still in rc freeze.

----------------------------------------------------------------
[Actively cooking]

Nothing to see here.  We are still in rc freeze.

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

* ph/describe-match (Mon Dec 24 12:18:22 2007 +0100) 2 commits
 + git-name-rev: add a --(no-)undefined option.
 + git-describe: Add a --match option to limit considered tags.

* js/reflog-delete (Fri Jan 4 19:11:37 2008 -0600) 2 commits
 + builtin-reflog.c: fix typo that accesses an unset variable
 + Teach "git reflog" a subcommand to delete single entries

I haven't queued Brandon's "git stash drop", as the command name
and the UI is undecided yet, but this series will serve as the
basis of such a feature.

* js/remote (Wed Dec 5 19:02:15 2007 +0000) 4 commits
 . Make git-remote a builtin
 . Test "git remote show" and "git remote prune"
 . parseopt: add flag to stop on first non option
 . path-list: add functions to work with unsorted lists

This and Kristian's "git-clone in C" are on hold and will need
to be rebased, post 1.5.4.

* db/send-email-omit-cc (Tue Dec 25 19:56:29 2007 -0800) 1 commit
 - git-send-email: Generalize auto-cc recipient mechanism.

New feature which seems to be nice, but has been postponed.

* bf/remote-head (Sun Dec 23 20:52:32 2007 -0500) 1 commit
 . git-remote: make add -f guess HEAD, as clone does

New feature which could be used in rewriting git-clone as a thin
wrapper around other commands, but there are conflicting
proposals from Kristian and Dscho, which are post 1.5.4 item.
We'll see how they pan out.

* jc/cr-at-eol (Tue Jan 15 00:59:05 2008 -0800) 1 commit
 - core.whitespace: cr-at-eol

People who have CRLF in repository are annoyed that they see ^M
at the end of the line marked as trailing whitespace errors.
This is to configure it away.

----------------------------------------------------------------
[Stalled]

* ab/pserver (Fri Dec 14 04:08:51 2007 +0000) 1 commit
 . Authentication support for pserver

This needs careful security audit and a fix to its password
database format.  Plaintext in .git/config is not acceptable.

* jc/sys-select (Tue Dec 18 01:52:07 2007 -0800) 1 commit
 - Do not include <sys/select.h> on pre- POSIX.1-2001 systems

This was done to help HP-UX port, but it appears that HP-UX
headers do not like to cooperate with usual _POSIX_VERSION rule,
so we probably need to scrap it and instead use manual
configuration instead.

* jc/git-symref (Tue Dec 11 16:42:46 2007 -0800) 1 commit
 - PARK: show-symref protocol extension.

This is a demonstration of a possible component in the future direction
for HEAD discovery done by git-clone.

* jk/builtin-alias (Fri Nov 30 11:22:58 2007 -0500) 1 commit
 + Support builtin aliases

Even the original author has slight NAK on this and I tend to agree.
May want to eventurally revert from 'next' but we are not in a hurry
even to do that.

* jc/diff-pathspec (Sun Nov 25 10:03:48 2007 -0800) 1 commit
 . Making ce_path_match() more useful by accepting globs

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

* jc/cherry-pick (Mon Dec 24 00:51:01 2007 -0800) 4 commits
 - PARK: Start using replay-tree merge in cherry-pick
 - revert/cherry-pick: start refactoring call to merge_recursive
 - expose a helper function peel_to_type().
 - merge-recursive: split low-level merge functions out.

Meant to avoid merge_recursive() during cherry-pick and revert,
so that D/F conflicts can be redone right, but I got busy and
this has unfortunately stalled.

* jc/apply-whitespace (Sat Jan 19 01:58:34 2008 -0800) 3 commits
 . builtin-apply.c: push match-beginning/end logic down
 . builtin-apply.c: restructure "offset" matching
 . builtin-apply.c: refactor small part that matches context

When you apply a series of patches with --whitespace=fix, a line
that is introduced in an earlier patch in the series can be
applied while getting its whitespace error fixed, and then it
can appear as a context line, but with its whitespace still
broken, in a later patch.  This series is meant to match such a
context line and propagate an earlier whitespace fix forward
without getting unnecessary conflicts, but I haven't made enough
real progress to show to the list yet.
