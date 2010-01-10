From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 0/4] Documentation style fixes
Date: Sun, 10 Jan 2010 01:02:38 +0100
Message-ID: <cover.1263081032.git.trast@student.ethz.ch>
References: <7vaawp4wvz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 10 01:02:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTlGc-0004Kn-Sz
	for gcvg-git-2@lo.gmane.org; Sun, 10 Jan 2010 01:02:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752651Ab0AJACq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jan 2010 19:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752602Ab0AJACq
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jan 2010 19:02:46 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:57572 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752371Ab0AJACp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jan 2010 19:02:45 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.213.0; Sun, 10 Jan
 2010 01:02:42 +0100
Received: from localhost.localdomain (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.213.0; Sun, 10 Jan
 2010 01:02:42 +0100
X-Mailer: git-send-email 1.6.6.218.g502b0
In-Reply-To: <7vaawp4wvz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136541>

I'm violating the midnight rule, so there's probably something wrong
with this series.

Junio C Hamano wrote:
> I am tempted to suggest describing the command in terms of more common use
> pattern, describing the flexible and more general form as "an aside" for
> more advanced users, perhaps like this.
> 
>         <branch>...:
>                 Other branch to merge into the current branch...trying an
>                 Octopus merge.
>         +
>         Strictly speaking, these can name arbitrary commits, not necessarily
>         at the tip of branches.  e.g. "git merge topic{tilde}4" lets you merge
>         the topic except for the last 4 commits.
> 
> I don't know if such an arrangement really makes the document more
> approachable to new people, or it is making the description longer and
> more complicated without helping new people, though (that is why this is
> just "I am tempted to").

Not sure.  I have a bit of an aversion against "lying" in the
synopsis, even though the common use-case really is a branch.

> Thomas Rast <trast@student.ethz.ch> writes:
> > * More importantly, while `code` style seems to be an improvement in
> >   HTML output (because it gives typewriter font), my local 'man'
> >   renders 'emphasis' as underlines -- which actually makes the code
> >   snippets much more visible than `literal` quotes which are not
> >   rendered specially at all.
> >
> > So which way should it be changed?
> 
> I'd prefer to see us mark code as `code`.

I tried to make it so, including a few other places that grep found.

Regarding 'git-cmd' vs. 'git cmd', I found that we're in the somewhat
unsatisfactory situation where the git-svn manpage uses dashless since
647ac70 (git-svn.txt: stop using dash-form of commands., 2009-07-07).
Most of the rest uses dashed, but there sometimes even were
inconsistent uses very close to each other.  Dashless seems to be a
bit more common in newer patches, and does have the advantage that it
does not need an exception for 'git submodule update' and friends.

So I tried to sed it towards the dashless form, with a few exceptions.
The churn, of course, is rather daunting.  The other alternative,
returning to dashed forms, would mean reverting 647ac70 and then more
applications of sed to fix the stray dashless uses, being careful to
preserve the SYNOPSIS sections.


Thomas Rast (4):
  Documentation/git-merge: reword references to "remote" and "pull"
  Documentation: warn prominently against merging with dirty trees
  Documentation: format full commands in typewriter font
  Documentation: spell 'git cmd' without dash throughout

 Documentation/config.txt                |   70 +++++++-------
 Documentation/fetch-options.txt         |   10 +-
 Documentation/git-add.txt               |    2 +-
 Documentation/git-am.txt                |   10 +-
 Documentation/git-apply.txt             |   10 +-
 Documentation/git-archimport.txt        |   12 ++--
 Documentation/git-archive.txt           |    2 +-
 Documentation/git-bisect.txt            |    2 +-
 Documentation/git-blame.txt             |    8 +-
 Documentation/git-branch.txt            |    6 +-
 Documentation/git-bundle.txt            |   26 +++---
 Documentation/git-check-ref-format.txt  |    2 +-
 Documentation/git-checkout-index.txt    |    8 +-
 Documentation/git-cherry-pick.txt       |    2 +-
 Documentation/git-cherry.txt            |    6 +-
 Documentation/git-citool.txt            |    4 +-
 Documentation/git-clean.txt             |    4 +-
 Documentation/git-commit-tree.txt       |    2 +-
 Documentation/git-commit.txt            |   18 ++--
 Documentation/git-config.txt            |   14 ++--
 Documentation/git-cvsexportcommit.txt   |    2 +-
 Documentation/git-cvsimport.txt         |   18 ++--
 Documentation/git-cvsserver.txt         |    6 +-
 Documentation/git-daemon.txt            |   40 ++++----
 Documentation/git-describe.txt          |    6 +-
 Documentation/git-diff-files.txt        |    2 +-
 Documentation/git-diff-index.txt        |   16 ++--
 Documentation/git-diff-tree.txt         |    4 +-
 Documentation/git-difftool.txt          |   16 ++--
 Documentation/git-fast-export.txt       |   12 ++--
 Documentation/git-fast-import.txt       |   20 ++--
 Documentation/git-fetch-pack.txt        |    6 +-
 Documentation/git-fetch.txt             |    2 +-
 Documentation/git-filter-branch.txt     |   24 +++---
 Documentation/git-fmt-merge-msg.txt     |    2 +-
 Documentation/git-format-patch.txt      |    4 +-
 Documentation/git-fsck.txt              |    4 +-
 Documentation/git-gc.txt                |   18 ++--
 Documentation/git-get-tar-commit-id.txt |    4 +-
 Documentation/git-grep.txt              |    2 +-
 Documentation/git-gui.txt               |   20 ++--
 Documentation/git-hash-object.txt       |    2 +-
 Documentation/git-help.txt              |    6 +-
 Documentation/git-http-backend.txt      |   22 +++---
 Documentation/git-http-fetch.txt        |    2 +-
 Documentation/git-imap-send.txt         |    2 +-
 Documentation/git-index-pack.txt        |    8 +-
 Documentation/git-init.txt              |    6 +-
 Documentation/git-log.txt               |    2 +-
 Documentation/git-ls-files.txt          |    4 +-
 Documentation/git-ls-tree.txt           |    4 +-
 Documentation/git-mailinfo.txt          |    2 +-
 Documentation/git-merge-file.txt        |   10 +-
 Documentation/git-merge-index.txt       |    6 +-
 Documentation/git-merge-one-file.txt    |    2 +-
 Documentation/git-merge.txt             |   54 ++++++-----
 Documentation/git-mergetool.txt         |   16 ++--
 Documentation/git-name-rev.txt          |    4 +-
 Documentation/git-notes.txt             |    2 +-
 Documentation/git-pack-objects.txt      |    6 +-
 Documentation/git-pack-redundant.txt    |    2 +-
 Documentation/git-patch-id.txt          |    2 +-
 Documentation/git-peek-remote.txt       |    2 +-
 Documentation/git-prune.txt             |   14 ++--
 Documentation/git-pull.txt              |   14 ++-
 Documentation/git-push.txt              |    6 +-
 Documentation/git-read-tree.txt         |   40 ++++----
 Documentation/git-rebase.txt            |   38 ++++----
 Documentation/git-receive-pack.txt      |    6 +-
 Documentation/git-reflog.txt            |    2 +-
 Documentation/git-remote.txt            |    2 +-
 Documentation/git-repack.txt            |   10 +-
 Documentation/git-replace.txt           |    2 +-
 Documentation/git-rerere.txt            |   26 +++---
 Documentation/git-reset.txt             |    2 +-
 Documentation/git-rev-list.txt          |    6 +-
 Documentation/git-rev-parse.txt         |   30 +++---
 Documentation/git-revert.txt            |    8 +-
 Documentation/git-send-pack.txt         |    4 +-
 Documentation/git-sh-setup.txt          |    2 +-
 Documentation/git-shortlog.txt          |    4 +-
 Documentation/git-show-index.txt        |    2 +-
 Documentation/git-show-ref.txt          |    4 +-
 Documentation/git-show.txt              |    4 +-
 Documentation/git-stash.txt             |    8 +-
 Documentation/git-status.txt            |    2 +-
 Documentation/git-submodule.txt         |    8 +-
 Documentation/git-symbolic-ref.txt      |    2 +-
 Documentation/git-tag.txt               |    6 +-
 Documentation/git-tar-tree.txt          |    4 +-
 Documentation/git-update-index.txt      |   14 ++--
 Documentation/git-upload-archive.txt    |    2 +-
 Documentation/git-upload-pack.txt       |    8 +-
 Documentation/git-var.txt               |    2 +-
 Documentation/git-verify-pack.txt       |    2 +-
 Documentation/git-verify-tag.txt        |    2 +-
 Documentation/git-web--browse.txt       |    2 +-
 Documentation/git-whatchanged.txt       |    4 +-
 Documentation/git-write-tree.txt        |    8 +-
 Documentation/git.txt                   |    8 +-
 Documentation/gitattributes.txt         |   12 ++--
 Documentation/gitcore-tutorial.txt      |  148 +++++++++++++++---------------
 Documentation/gitcvs-migration.txt      |   10 +-
 Documentation/gitdiffcore.txt           |    8 +-
 Documentation/githooks.txt              |   56 ++++++------
 Documentation/gitignore.txt             |    4 +-
 Documentation/gitk.txt                  |    2 +-
 Documentation/gitrepository-layout.txt  |   16 ++--
 Documentation/gittutorial-2.txt         |   16 ++--
 Documentation/gittutorial.txt           |   42 +++++-----
 Documentation/gitworkflows.txt          |    6 +-
 Documentation/i18n.txt                  |    4 +-
 Documentation/merge-options.txt         |    4 +-
 Documentation/pull-fetch-param.txt      |    8 +-
 Documentation/urls-remotes.txt          |    4 +-
 115 files changed, 634 insertions(+), 626 deletions(-)
