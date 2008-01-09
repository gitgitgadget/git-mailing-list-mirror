From: William Morgan <wmorgan-git@masanjin.net>
Subject: [PATCH] additional help when editing during interactive rebase
Date: Tue, 08 Jan 2008 19:29:01 -0800
Message-ID: <1199849225-sup-6981@south>
References: <1199845915-sup-797@south> <7vsl17pv1c.fsf@gitster.siamese.dyndns.org>
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 09 04:30:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCReE-0006w2-Ja
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 04:30:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751956AbYAID3h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 22:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752882AbYAID3g
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 22:29:36 -0500
Received: from nlpi029.sbcis.sbc.com ([207.115.36.58]:49856 "EHLO
	nlpi029.prodigy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752014AbYAID3f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 22:29:35 -0500
X-ORBL: [68.127.149.88]
Received: from south (adsl-68-127-149-88.dsl.pltn13.pacbell.net [68.127.149.88])
	by nlpi029.prodigy.net (8.13.8 out.dk.spool/8.13.8) with ESMTP id m093TXeH011761
	for <git@vger.kernel.org>; Tue, 8 Jan 2008 21:29:33 -0600
Received: from rubyist by south with local (Exim 4.63)
	(envelope-from <rubyist@masanjin.net>)
	id 1JCRcj-0007co-6u
	for git@vger.kernel.org; Tue, 08 Jan 2008 19:29:01 -0800
In-Reply-To: <7vsl17pv1c.fsf@gitster.siamese.dyndns.org>
User-Agent: Sup/0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69949>

Let the user know how to continue a rebase after amending a commit
during a git rebase --interactive session.

Signed-off-by: William Morgan <wmorgan@masanjin.net>
---
 git-rebase--interactive.sh |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index acdcc54..ccef1ac 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -258,11 +258,10 @@ do_next () {
 			die_with_patch $sha1 "Could not apply $sha1... $rest"
 		make_patch $sha1
 		: > "$DOTEST"/amend
-		warn
 		warn "You can amend the commit now, with"
-		warn
 		warn "	git commit --amend"
-		warn
+		warn "Once amended, continue with"
+		warn "	git rebase --continue"
 		exit 0
 		;;
 	squash|s)
-- 
1.5.4.rc2.69.g10f0

-- 
William <wmorgan-git@masanjin.net>
