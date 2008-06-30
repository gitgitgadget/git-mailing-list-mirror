From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: [RFC/PATCH] Documentation: be consistent about "git-" versus "git
 "
Date: Mon, 30 Jun 2008 02:30:12 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0806300223030.5848@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 30 09:31:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDDqy-0006fe-FC
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 09:31:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751553AbYF3HaQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 03:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752029AbYF3HaP
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 03:30:15 -0400
Received: from smtp00.uchicago.edu ([128.135.12.76]:46546 "EHLO
	smtp00.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229AbYF3HaO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 03:30:14 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp00.uchicago.edu (8.13.8/8.13.8) with ESMTP id m5U7UJxL008075
	for <git@vger.kernel.org>; Mon, 30 Jun 2008 02:30:19 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m5U7UCjK006354
	for <git@vger.kernel.org>; Mon, 30 Jun 2008 02:30:12 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86887>

I guess this patch is too long (168 KB). You can find it at
<http://home.uchicago.edu/~jrnieder/20080630-git-documentation-patch.txt>.

In a world where git-* are not in $(bindir), using "git-command
<parameters>" in examples in the documentation is not a good
idea. On the other hand, it is convenient for commands to be
named with one word, not two, the manpages are still called
"git-command (1)", and the user is not going to be able to escape
seeing "git-command" in the "wild" from time to time anyway. What
to do?

This patch keeps the dash when naming an operation, command,
program, process, or action but tries to be dashless in all
complete command lines ready to be entered at a shell (i.e.,
without options omitted).

The changes consist mostly of adding and removing dashes
accordingly. Other changes:

 * "git clone" has been replaced with "git clone <repo>" (rather
   than "git-clone") in the example at the beginning of
   user-manual.txt in an attempt to make the switching between
   dashed and dashless commands a little less confusing.
 * git-merge-one-file has been replaced with $(git
   --exec-path)/git-merge-one-file in two places
 * /usr/bin/git has been replaced with /usr/bin/git-daemon in the
   sample inetd.conf lines in git-daemon(1).  The analogous
   changes in git-cvsserver(1) have *not* been made.
 * Some whitespace changes (spaces changing into dashes
   disallowed some line breaks; some sequences of spaces have been
   changed into tabs in the same line as other changes)

Signed-off-by: Jonathan Nieder <jrnieder@uchicago.edu>
---
	I just realized that most of the rest of the man pages
	(aside from git-{sh-setup,parse-remote} (1)) are not ready
	for the Git tools to move, either. Here's a start towards
	less confusing documentation for that situation.

	Sorry for the enormous patch. Hope it gives someone some
	amusement. It is only an RFC because

	1) I am not sure whether the criterion for dashworthiness
	   I used is the right one. I tried to follow the lead of
	   good existing documentation, but there is no one
	   convention used throughout.
	2) I also want to make the formatting a bit more consistent
	   (always 'git-command' or always `git-command`) in
	   another patch if that is appropriate, while I am at it.
	   So I don't want this commited yet.
	3) I would be much more comfortable if I could run some
	   commands to quickly check that this patch only does
	   what I have claimed it does.

	Thoughts? Suggestions?

 Documentation/git-add.txt                |    2 +-
 Documentation/git-am.txt                 |    4 +-
 Documentation/git-annotate.txt           |    2 +-
 Documentation/git-apply.txt              |    2 +-
 Documentation/git-archimport.txt         |    2 +-
 Documentation/git-archive.txt            |    2 +-
 Documentation/git-blame.txt              |    2 +-
 Documentation/git-branch.txt             |    8 +-
 Documentation/git-bundle.txt             |   14 ++--
 Documentation/git-cat-file.txt           |    4 +-
 Documentation/git-check-attr.txt         |    2 +-
 Documentation/git-check-ref-format.txt   |    4 +-
 Documentation/git-checkout-index.txt     |   20 +++---
 Documentation/git-checkout.txt           |    8 +-
 Documentation/git-cherry-pick.txt        |    2 +-
 Documentation/git-clean.txt              |    2 +-
 Documentation/git-clone.txt              |    2 +-
 Documentation/git-commit-tree.txt        |    2 +-
 Documentation/git-commit.txt             |    4 +-
 Documentation/git-config.txt             |   26 ++++----
 Documentation/git-count-objects.txt      |    4 +-
 Documentation/git-cvsexportcommit.txt    |    9 ++-
 Documentation/git-cvsimport.txt          |    4 +-
 Documentation/git-cvsserver.txt          |    2 +-
 Documentation/git-daemon.txt             |   10 ++--
 Documentation/git-describe.txt           |   10 ++--
 Documentation/git-diff-files.txt         |    2 +-
 Documentation/git-diff-index.txt         |   12 ++--
 Documentation/git-diff-tree.txt          |    8 +-
 Documentation/git-diff.txt               |   18 +++---
 Documentation/git-fast-import.txt        |    8 +-
 Documentation/git-fetch-pack.txt         |    2 +-
 Documentation/git-fetch.txt              |    4 +-
 Documentation/git-filter-branch.txt      |    4 +-
 Documentation/git-fmt-merge-msg.txt      |    4 +-
 Documentation/git-for-each-ref.txt       |    8 +-
 Documentation/git-format-patch.txt       |    2 +-
 Documentation/git-fsck-objects.txt       |    2 +-
 Documentation/git-fsck.txt               |    4 +-
 Documentation/git-gc.txt                 |    4 +-
 Documentation/git-get-tar-commit-id.txt  |    2 +-
 Documentation/git-grep.txt               |    2 +-
 Documentation/git-hash-object.txt        |    2 +-
 Documentation/git-http-fetch.txt         |    2 +-
 Documentation/git-http-push.txt          |    2 +-
 Documentation/git-imap-send.txt          |    4 +-
 Documentation/git-index-pack.txt         |    4 +-
 Documentation/git-init-db.txt            |    2 +-
 Documentation/git-init.txt               |    6 +-
 Documentation/git-instaweb.txt           |    4 +-
 Documentation/git-lost-found.txt         |    2 +-
 Documentation/git-ls-files.txt           |    2 +-
 Documentation/git-ls-remote.txt          |    2 +-
 Documentation/git-ls-tree.txt            |    2 +-
 Documentation/git-mailinfo.txt           |    6 +-
 Documentation/git-mailsplit.txt          |    2 +-
 Documentation/git-merge-base.txt         |    4 +-
 Documentation/git-merge-file.txt         |    4 +-
 Documentation/git-merge-index.txt        |    6 +-
 Documentation/git-merge-tree.txt         |    2 +-
 Documentation/git-merge.txt              |    8 +-
 Documentation/git-mergetool.txt          |   16 +++---
 Documentation/git-mktag.txt              |    2 +-
 Documentation/git-mv.txt                 |    6 +-
 Documentation/git-name-rev.txt           |    2 +-
 Documentation/git-pack-objects.txt       |    2 +-
 Documentation/git-pack-redundant.txt     |    4 +-
 Documentation/git-pack-refs.txt          |    8 +-
 Documentation/git-patch-id.txt           |    2 +-
 Documentation/git-peek-remote.txt        |    2 +-
 Documentation/git-prune-packed.txt       |    2 +-
 Documentation/git-prune.txt              |    2 +-
 Documentation/git-pull.txt               |    2 +-
 Documentation/git-push.txt               |    2 +-
 Documentation/git-quiltimport.txt        |    2 +-
 Documentation/git-read-tree.txt          |   32 +++++-----
 Documentation/git-rebase.txt             |   18 +++---
 Documentation/git-receive-pack.txt       |    6 +-
 Documentation/git-relink.txt             |    2 +-
 Documentation/git-remote.txt             |   12 ++--
 Documentation/git-repack.txt             |   10 ++--
 Documentation/git-repo-config.txt        |    2 +-
 Documentation/git-request-pull.txt       |    2 +-
 Documentation/git-rerere.txt             |    4 +-
 Documentation/git-rev-list.txt           |   10 ++--
 Documentation/git-rev-parse.txt          |    6 +-
 Documentation/git-revert.txt             |    2 +-
 Documentation/git-rm.txt                 |    6 +-
 Documentation/git-send-email.txt         |    2 +-
 Documentation/git-send-pack.txt          |    2 +-
 Documentation/git-shortlog.txt           |    6 +-
 Documentation/git-show-branch.txt        |    4 +-
 Documentation/git-show-index.txt         |    2 +-
 Documentation/git-show-ref.txt           |    6 +-
 Documentation/git-show.txt               |    2 +-
 Documentation/git-stash.txt              |   14 ++--
 Documentation/git-status.txt             |    6 +-
 Documentation/git-stripspace.txt         |    2 +-
 Documentation/git-submodule.txt          |   10 ++--
 Documentation/git-svn.txt                |   34 +++++-----
 Documentation/git-symbolic-ref.txt       |    2 +-
 Documentation/git-tag.txt                |   16 +++---
 Documentation/git-tar-tree.txt           |    2 +-
 Documentation/git-unpack-file.txt        |    2 +-
 Documentation/git-unpack-objects.txt     |    2 +-
 Documentation/git-update-index.txt       |   12 ++--
 Documentation/git-update-ref.txt         |   10 ++--
 Documentation/git-update-server-info.txt |    2 +-
 Documentation/git-upload-archive.txt     |    2 +-
 Documentation/git-upload-pack.txt        |    2 +-
 Documentation/git-var.txt                |    4 +-
 Documentation/git-verify-pack.txt        |    2 +-
 Documentation/git-verify-tag.txt         |    2 +-
 Documentation/git-web--browse.txt        |    2 +-
 Documentation/git-whatchanged.txt        |    6 +-
 Documentation/git-write-tree.txt         |    2 +-
 Documentation/gitattributes.txt          |   14 ++--
 Documentation/gitcore-tutorial.txt       |   94 +++++++++++++++---------------
 Documentation/gitcvs-migration.txt       |    8 +-
 Documentation/gitdiffcore.txt            |    2 +-
 Documentation/githooks.txt               |   10 ++--
 Documentation/gitignore.txt              |    4 +-
 Documentation/gitrepository-layout.txt   |   20 +++---
 Documentation/gittutorial-2.txt          |   18 +++---
 Documentation/gittutorial.txt            |   34 +++++-----
 Documentation/user-manual.txt            |   76 ++++++++++++------------
 126 files changed, 456 insertions(+), 455 deletions(-)

Patch at
<http://home.uchicago.edu/~jrnieder/20080630-git-documentation-patch.txt>.
