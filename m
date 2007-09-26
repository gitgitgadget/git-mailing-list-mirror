From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (topics)
Date: Wed, 26 Sep 2007 13:05:59 -0700
Message-ID: <7vfy11yyxk.fsf@gitster.siamese.dyndns.org>
References: <7v1wdcch06.fsf@gitster.siamese.dyndns.org>
	<7v1wd1d0le.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 26 22:06:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iad9F-0007qm-29
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 22:06:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753480AbXIZUGH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2007 16:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751644AbXIZUGG
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Sep 2007 16:06:06 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:46032 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753376AbXIZUGE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2007 16:06:04 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 9EFFC13C842;
	Wed, 26 Sep 2007 16:06:22 -0400 (EDT)
X-master-at: 5166810b1e16b22e342f2181a3535e70c6e7a119
X-next-at: 2d916d785de82bda25666788c01747331dfb280f
In-Reply-To: <7v1wd1d0le.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 14 Sep 2007 03:04:45 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59244>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The topics list the commits in reverse chronological
order.

* jk/diff-rename (Tue Sep 25 15:29:42 2007 -0400) 1 commit
 + diffcore-rename: cache file deltas

Parked in 'next' for now but is 'master' material.

* mv/unknown (Tue Sep 25 16:38:46 2007 +0200) 1 commit
 + Don't use "<unknown>" for placeholders and suppress printing of
   empty user formats.

Parked in 'next'; I was already burned by it not passing one of
the test cases, and I am not absolutely certain what else this
subtly breaks.  Hopefully minor.

* jb/remote-rm (Sun Sep 23 22:29:12 2007 -0700) 3 commits
 + git-remote rm: add tests and minor fix-ups
 + remote: document the 'rm' subcommand
 + remote: add 'rm' subcommand

Should be Ok to push out to 'master'.

* ml/submodule (Sun Sep 23 22:19:42 2007 -0400) 1 commit
 + git-submodule - allow a relative path as the subproject url

Should be Ok to push out to 'master'.

* lh/merge (Mon Sep 24 00:51:45 2007 +0200) 6 commits
 + git-merge: add --ff and --no-ff options
 + git-merge: add support for --commit and --no-squash
 + git-merge: add support for branch.<name>.mergeoptions
 + git-merge: refactor option parsing
 + git-merge: fix faulty SQUASH_MSG
 + Add test-script for git-merge porcelain

Comments?  I personally never felt need for --no-ff but the
series is reasonably clean so I do not see strong objection
against this series either.

* sv/svn (Fri Sep 21 15:27:01 2007 +1200) 3 commits
 + git-svn: handle changed svn command-line syntax
 + git-svn: fix test for trunk svn (transaction out of date)
 + git-svn: fix test for trunk svn (commit message not needed)

Will merge to 'master' this weekend.

* js/rebase-i (Tue Sep 25 16:43:15 2007 +0100) 1 commit
 + rebase -i: work on a detached HEAD

Waiting for autogc change as this textually interacts with it,
and the additional convenience can wait.

* jc/autogc (Mon Sep 17 00:55:13 2007 -0700) 10 commits
 + git-gc --auto: run "repack -A -d -l" as necessary.
 + git-gc --auto: restructure the way "repack" command line is built.
 + git-gc --auto: protect ourselves from accumulated cruft
 + git-gc --auto: add documentation.
 + git-gc --auto: move threshold check to need_to_gc() function.
 + repack -A -d: use --keep-unreachable when repacking
 + pack-objects --keep-unreachable
 + Export matches_pack_name() and fix its return value
 + Invoke "git gc --auto" from commit, merge, am and rebase.
 + Implement git gc --auto

I think the only remaining thing left with this thing is to
prevent more than one instances of it from running at the same
time.  Any takers?

* ph/strbuf (Tue Sep 25 10:22:44 2007 +0200) 37 commits
 + Small cache_tree_write refactor.
 + Make builtin-rerere use of strbuf nicer and more efficient.
 + Add strbuf_cmp.
 + strbuf_setlen(): do not barf on setting length of an empty buffer
   to 0
 + sq_quote_argv and add_to_string rework with strbuf's.
 + Full rework of quote_c_style and write_name_quoted.
 + ...

I had to make a small fix-up to strbuf_setlen() last night to
this series; this should be ready for 'master'.

And it is better to push this out early, as the series touches
everywhere and conflicts with peoples' patches.

* db/fetch-pack (Tue Sep 25 00:13:25 2007 -0400) 45 commits
 + Prevent send-pack from segfaulting when a branch doesn't match
 + Cleanup unnecessary break in remote.c
 + Cleanup style nit of 'x == NULL' in remote.c
 + Fix memory leaks when disconnecting transport instances
 + Ensure builtin-fetch honors {fetch,transfer}.unpackLimit
 + ...

Two issues known to me are:

 - "rsync" transport is not supported yet;

 - regresses "git pull <name>" using .git/remotes/<name>; does
   not merge the first refspec when branch.<name>.merge is not
   set.

There may be others but some people apparently use this in
production (including me) and I do not expect major breakages in
the really essential part.

* ss/svnimport (Mon Sep 24 12:57:40 2007 +0200) 1 commit
 + Fix pool handling in git-svnimport to avoid memory leaks.

This is meant to eventually go to 'maint' as well but with
diminishing user base of svnimport it is getting harder to get
good "tested successfully, seen improvements" reports.

* jc/stash-create (Mon Jul 9 00:51:23 2007 -0700) 2 commits
 + rebase: allow starting from a dirty tree.
 + stash: implement "stash create"

I think "stash create" is going in a good direction, but I do
not think rebase should unstash unconditionally on the resulting
work tree.  A good compromise might be not to unstash if the
user asked to switch branches first and to unstash if he didn't.

* kh/commit (Mon Sep 17 20:06:48 2007 -0400) 7 commits
 - Implement git commit as a builtin command.
 - Export rerere() and launch_editor().
 - Add strbuf_read_file().
 - Clean up stripspace a bit, use strbuf even more.
 - Introduce entry point for launching add--interactive.
 - Enable wt-status to run against non-standard index file.
 - Enable wt-status output to a given FILE pointer.

There were a few updates/replacements to the list I missed;

* gr/smtp (Tue Sep 25 17:27:54 2007 -0700) 2 commits
 - [TO BE SQUASHED] Fix-up after review
 - Add ability to specify SMTP server port when using git-send-email.

Will be in 'next'.
