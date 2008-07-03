From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: [PATCH 11/15] manpages: italicize git command names (which were in
 teletype font)
Date: Thu, 3 Jul 2008 00:45:27 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0807030037220.16085@harper.uchicago.edu>
References: <Pine.GSO.4.62.0806301650530.7190@harper.uchicago.edu>
 <7viqvqov01.fsf@gitster.siamese.dyndns.org> <Pine.GSO.4.62.0807022322380.16085@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jon Loeliger <jdl@jdl.com>, Dan McGee <dpmcgee@gmail.com>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Olivier Marin <dkr+ml.git@free.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 09:02:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEIpl-0003HF-Ok
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 09:02:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754991AbYGCG7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 02:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753723AbYGCG6I
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 02:58:08 -0400
Received: from smtp02.uchicago.edu ([128.135.12.75]:42096 "EHLO
	smtp02.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754899AbYGCFpq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 01:45:46 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp02.uchicago.edu (8.13.8/8.13.8) with ESMTP id m635jSKd023785;
	Thu, 3 Jul 2008 00:45:28 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m635jRMW019411;
	Thu, 3 Jul 2008 00:45:27 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <Pine.GSO.4.62.0807022322380.16085@harper.uchicago.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87234>

This patch is huge (256 KB), so I am not sending it. You can find it at
<http://home.uchicago.edu/~jrnieder/20080703-git-italics.txt>.

The names of git commands are not meant to be entered at the
commandline; they are just names. So we render them in italics,
as is usual for command names in manpages.

Using

	doit () {
	  perl -e 'for (<>) { s/\`(git-[^\`.]*)\`/'\''\1'\''/g; print }'
	}
	for i in git*.txt config.txt diff*.txt blame*.txt fetch*.txt i18n.txt \
	        merge*.txt pretty*.txt pull*.txt rev*.txt urls*.txt
	do
	  doit <"$i" >"$i+" && mv "$i+" "$i"
	done
	git diff

.

Signed-off-by: Jonathan Nieder <jrnieder@uchicago.edu>

	My script missed some spots, but I don't think there were
	any false positives. (I hope there weren't.)

 Documentation/config.txt                |   56 ++++++------
 Documentation/fetch-options.txt         |    8 +-
 Documentation/git-am.txt                |   14 ++--
 Documentation/git-apply.txt             |   10 +-
 Documentation/git-archimport.txt        |   12 +-
 Documentation/git-archive.txt           |    6 +-
 Documentation/git-bisect.txt            |    6 +-
 Documentation/git-blame.txt             |    8 +-
 Documentation/git-branch.txt            |    8 +-
 Documentation/git-bundle.txt            |   26 +++---
 Documentation/git-check-ref-format.txt  |    2 +-
 Documentation/git-checkout-index.txt    |    8 +-
 Documentation/git-checkout.txt          |    4 +-
 Documentation/git-cherry-pick.txt       |    2 +-
 Documentation/git-cherry.txt            |    6 +-
 Documentation/git-citool.txt            |    4 +-
 Documentation/git-clean.txt             |    4 +-
 Documentation/git-clone.txt             |    6 +-
 Documentation/git-commit-tree.txt       |    2 +-
 Documentation/git-commit.txt            |   20 ++--
 Documentation/git-config.txt            |   12 +-
 Documentation/git-cvsexportcommit.txt   |    2 +-
 Documentation/git-cvsimport.txt         |   18 ++--
 Documentation/git-cvsserver.txt         |   38 ++++----
 Documentation/git-daemon.txt            |   40 ++++----
 Documentation/git-describe.txt          |    6 +-
 Documentation/git-diff-files.txt        |    2 +-
 Documentation/git-diff-index.txt        |   20 ++--
 Documentation/git-diff-tree.txt         |   10 +-
 Documentation/git-fast-export.txt       |    8 +-
 Documentation/git-fast-import.txt       |   20 ++--
 Documentation/git-fetch-pack.txt        |   14 ++--
 Documentation/git-fetch.txt             |    2 +-
 Documentation/git-filter-branch.txt     |   14 ++--
 Documentation/git-fmt-merge-msg.txt     |    4 +-
 Documentation/git-for-each-ref.txt      |    2 +-
 Documentation/git-format-patch.txt      |    6 +-
 Documentation/git-fsck.txt              |    4 +-
 Documentation/git-gc.txt                |   20 ++--
 Documentation/git-get-tar-commit-id.txt |    6 +-
 Documentation/git-grep.txt              |    2 +-
 Documentation/git-gui.txt               |   20 ++--
 Documentation/git-hash-object.txt       |    2 +-
 Documentation/git-help.txt              |    6 +-
 Documentation/git-http-fetch.txt        |    2 +-
 Documentation/git-imap-send.txt         |    2 +-
 Documentation/git-index-pack.txt        |    8 +-
 Documentation/git-init.txt              |    6 +-
 Documentation/git-instaweb.txt          |    2 +-
 Documentation/git-log.txt               |    4 +-
 Documentation/git-ls-files.txt          |    6 +-
 Documentation/git-ls-remote.txt         |    2 +-
 Documentation/git-mailinfo.txt          |    4 +-
 Documentation/git-merge-base.txt        |    4 +-
 Documentation/git-merge-file.txt        |   10 +-
 Documentation/git-merge-index.txt       |    8 +-
 Documentation/git-merge-one-file.txt    |    4 +-
 Documentation/git-merge.txt             |   16 ++--
 Documentation/git-mergetool.txt         |   16 ++--
 Documentation/git-name-rev.txt          |    6 +-
 Documentation/git-pack-objects.txt      |    6 +-
 Documentation/git-pack-redundant.txt    |    2 +-
 Documentation/git-parse-remote.txt      |    2 +-
 Documentation/git-patch-id.txt          |    2 +-
 Documentation/git-peek-remote.txt       |    6 +-
 Documentation/git-prune.txt             |   14 ++--
 Documentation/git-pull.txt              |   10 +-
 Documentation/git-push.txt              |    4 +-
 Documentation/git-read-tree.txt         |   42 ++++----
 Documentation/git-rebase.txt            |   26 +++---
 Documentation/git-receive-pack.txt      |   12 +-
 Documentation/git-repack.txt            |   14 ++--
 Documentation/git-rerere.txt            |   28 +++---
 Documentation/git-reset.txt             |    2 +-
 Documentation/git-rev-list.txt          |    6 +-
 Documentation/git-rev-parse.txt         |   24 +++---
 Documentation/git-revert.txt            |    4 +-
 Documentation/git-rm.txt                |    4 +-
 Documentation/git-send-pack.txt         |   10 +-
 Documentation/git-sh-setup.txt          |    2 +-
 Documentation/git-shell.txt             |    2 +-
 Documentation/git-shortlog.txt          |    2 +-
 Documentation/git-show-branch.txt       |    2 +-
 Documentation/git-show-index.txt        |    4 +-
 Documentation/git-show-ref.txt          |    4 +-
 Documentation/git-show.txt              |    6 +-
 Documentation/git-stash.txt             |    6 +-
 Documentation/git-status.txt            |    6 +-
 Documentation/git-submodule.txt         |    4 +-
 Documentation/git-svn.txt               |  106 ++++++++++----------
 Documentation/git-symbolic-ref.txt      |    2 +-
 Documentation/git-tag.txt               |    8 +-
 Documentation/git-tar-tree.txt          |    6 +-
 Documentation/git-update-index.txt      |   22 ++--
 Documentation/git-upload-archive.txt    |    2 +-
 Documentation/git-upload-pack.txt       |    6 +-
 Documentation/git-var.txt               |    2 +-
 Documentation/git-verify-pack.txt       |    2 +-
 Documentation/git-verify-tag.txt        |    2 +-
 Documentation/git-web--browse.txt       |    6 +-
 Documentation/git-whatchanged.txt       |    4 +-
 Documentation/git-write-tree.txt        |    8 +-
 Documentation/git.txt                   |    8 +-
 Documentation/gitattributes.txt         |   16 ++--
 Documentation/gitcore-tutorial.txt      |  162 +++++++++++++++---------------
 Documentation/gitcvs-migration.txt      |   12 +-
 Documentation/gitdiffcore.txt           |   30 +++---
 Documentation/githooks.txt              |   74 +++++++-------
 Documentation/gitignore.txt             |    4 +-
 Documentation/gitk.txt                  |    2 +-
 Documentation/gitrepository-layout.txt  |   18 ++--
 Documentation/gittutorial-2.txt         |   16 ++--
 Documentation/gittutorial.txt           |   42 ++++----
 Documentation/i18n.txt                  |    4 +-
 Documentation/merge-options.txt         |    4 +-
 Documentation/pull-fetch-param.txt      |    8 +-
 Documentation/urls-remotes.txt          |    4 +-
 117 files changed, 713 insertions(+), 713 deletions(-)

patch at <http://home.uchicago.edu/~jrnieder/20080703-git-italics.txt>
