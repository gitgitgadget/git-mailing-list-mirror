From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (topics)
Date: Mon, 02 Jun 2008 00:58:03 -0700
Message-ID: <7vod6k6zg4.fsf@gitster.siamese.dyndns.org>
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
 <7vmymsjz6x.fsf@gitster.siamese.dyndns.org>
 <7vabijxhk4.fsf@gitster.siamese.dyndns.org>
 <7vwslhg8qe.fsf@gitster.siamese.dyndns.org>
 <7vhccfiksy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 02 09:59:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K34wi-0004Gt-M1
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 09:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531AbYFBH6T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 03:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbYFBH6T
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 03:58:19 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34139 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094AbYFBH6S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 03:58:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 45D363DF2;
	Mon,  2 Jun 2008 03:58:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id DE9893DF1; Mon,  2 Jun 2008 03:58:11 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A83D0654-3079-11DD-A1DF-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83499>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.

The topics list the commits in reverse chronological order.

It's been a while since the last issue of this series.  I've been
swamped, and haven't had a chance to spend enough time on reviewing and
accepting patches.

A rough timeline from now on.

 * Fixes of 'master' continues, with newer -rcX tagged every once in a
   while.  I'd like to tag -rc1 in a few days.

 * 1.5.6 Final (2008-06-08 -- likely to slip by a week or so, though).

----------------------------------------------------------------
[New Topics]

* lw/gitweb (Sat May 31 16:19:24 2008 +0200) 2 commits
 - gitweb: use Git.pm, and use its parse_rev method for
   git_get_head_hash
 - perl/Git.pm: add parse_rev method

I do not necessarily think it is an improvement to name the operation
called as "rev-parse" at the plumbing layer with a different name
"get_hash" as the later round of this series does.

As I mentioned on the list, I think the "PERL5LIB fix" I squashed in was a
misguided workaround to a wrong problem; if we are making gitweb.perl to
use Git.pm, I think we should do the same GITPERLLIB trick we do to other
perl scripts for consistency.

I've looked at the Git.pm testsuite that uses Test::More briefly but
hadn't really reviewed it.  Is Test::More commonly used, considered solid
and widely available?

----------------------------------------------------------------
[Graduated to "master"]

* lw/test-fix (Sat May 31 23:11:21 2008 +0200) 1 commit
 + t/test-lib.sh: resolve symlinks in working directory, for pathname
   comparisons

* sb/am-tests (Sun Jun 1 00:11:43 2008 +0200) 2 commits
 + Merge t4150-am-subdir.sh and t4151-am.sh into t4150-am.sh
 + Add test cases for git-am

* lt/pack-sync (Fri May 30 08:54:46 2008 -0700) 2 commits
 + Remove now unnecessary 'sync()' calls
 + Make pack creation always fsync() the result

* sp/remote (Sun Jun 1 00:28:04 2008 -0400) 3 commits
 + Make "git-remote rm" delete refs acccording to fetch specs
 + Make "git-remote prune" delete refs according to fetch specs
 + Remove unused remote_prefix member in builtin-remote

"git-remote" had an unwarranted assumption that everybody uses
refs/remotes/$it namespace to track remote repository called $it.  This
series is a reasonable fix to it.

* np/pack-check (Thu May 29 17:34:50 2008 -0400) 1 commit
 + make verify-pack a bit more useful with bad packs

* lr/init-bare (Wed May 28 19:53:57 2008 +0100) 1 commit
 + git-init: accept --bare option

This makes both "git --bare init" and "git init --bare" work, which would
reduce confusion.

* jc/checkout (Wed May 28 16:11:16 2008 -0700) 4 commits
 + checkout: "best effort" checkout
 + unpack_trees(): allow callers to differentiate worktree errors
   from merge errors
 + checkout: consolidate reset_{to_new,clean_to_new|()
 + checkout: make reset_clean_to_new() not die by itself

This "fix" seems to help real-world users.

* jb/reset-q (Sat May 31 18:10:58 2008 -0700) 1 commit
 + git-reset: honor -q and do not show progress message

----------------------------------------------------------------
[Stalled]

* jc/send-pack-tell-me-more (Thu Mar 20 00:44:11 2008 -0700) 1 commit
 + "git push": tellme-more protocol extension

Allows common ancestor negotiation for git-push to help people with shared
repository workflow in certain minority situations.  The lack of protocol
support has been bugging me for quite some time, and that was the reason I
did this.

This needs debugging.

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

* sj/merge (Sat May 3 16:55:47 2008 -0700) 6 commits
 - Introduce fast forward option only
 - Head reduction before selecting merge strategy
 - Restructure git-merge.sh
 - Introduce -ff=<fast forward option>
 - New merge tests
 - Documentation for joining more than two histories

This will interfere with Miklos's rewrite of merge to C but it appears
neither will happen by 1.5.6 anyway.

* dr/ceiling (Mon May 19 23:49:34 2008 -0700) 4 commits
 - Eliminate an unnecessary chdir("..")
 - Add support for GIT_CEILING_DIRECTORIES
 - Fold test-absolute-path into test-path-utils
 - Implement normalize_absolute_path

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
