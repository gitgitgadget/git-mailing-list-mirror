From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] bash completion: Hide more plumbing commands
Date: Tue, 26 Aug 2008 19:11:44 +0200
Message-ID: <20080826171144.21328.82727.stgit@localhost>
References: <20080826171012.GO10360@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, andi@firstfloor.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 26 19:22:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY2FR-0001ct-1a
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 19:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757039AbYHZRVV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 13:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757017AbYHZRVV
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 13:21:21 -0400
Received: from [212.249.11.140] ([212.249.11.140]:33303 "EHLO pixie.suse.cz"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756993AbYHZRVU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 13:21:20 -0400
X-Greylist: delayed 553 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Aug 2008 13:21:20 EDT
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by pixie.suse.cz (Postfix) with ESMTP id DC3112ACCE7;
	Tue, 26 Aug 2008 19:11:44 +0200 (CEST)
In-Reply-To: <20080826171012.GO10360@machine.or.cz>
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93772>

git <tab><tab> still shows way too many commands, some of them
are clearly plumbing. This patch hides the plumbing commands
liberally (that is, in special cases, users still might want to
call one of the hidden commands, a *normal* workflow should never
involve these, though - and if it does, we have a UI problem anyway).

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 contrib/completion/git-completion.bash |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 89858c2..773d64b 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -386,7 +386,9 @@ __git_porcelain_commands ()
 		cat-file)         : plumbing;;
 		check-attr)       : plumbing;;
 		check-ref-format) : plumbing;;
+		checkout-index)   : plumbing;;
 		commit-tree)      : plumbing;;
+		count-objects)    : plumbing;;
 		cvsexportcommit)  : export;;
 		cvsimport)        : import;;
 		cvsserver)        : daemon;;
@@ -395,6 +397,7 @@ __git_porcelain_commands ()
 		diff-index)       : plumbing;;
 		diff-tree)        : plumbing;;
 		fast-import)      : import;;
+		fast-export)      : export;;
 		fsck-objects)     : plumbing;;
 		fetch-pack)       : plumbing;;
 		fmt-merge-msg)    : plumbing;;
@@ -404,6 +407,10 @@ __git_porcelain_commands ()
 		index-pack)       : plumbing;;
 		init-db)          : deprecated;;
 		local-fetch)      : plumbing;;
+		lost-found)       : deprecated;;
+		ls-files)         : plumbing;;
+		ls-remote)        : plumbing;;
+		ls-tree)          : plumbing;;
 		mailinfo)         : plumbing;;
 		mailsplit)        : plumbing;;
 		merge-*)          : plumbing;;
@@ -428,6 +435,7 @@ __git_porcelain_commands ()
 		runstatus)        : plumbing;;
 		sh-setup)         : internal;;
 		shell)            : daemon;;
+		show-ref)         : plumbing;;
 		send-pack)        : plumbing;;
 		show-index)       : plumbing;;
 		ssh-*)            : transport;;
@@ -442,6 +450,8 @@ __git_porcelain_commands ()
 		upload-archive)   : plumbing;;
 		upload-pack)      : plumbing;;
 		write-tree)       : plumbing;;
+		var)              : plumbing;;
+		verify-pack)      : plumbing;;
 		verify-tag)       : plumbing;;
 		*) echo $i;;
 		esac
