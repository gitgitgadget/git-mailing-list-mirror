From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 3/6] git-reset.txt: reset --soft is not a no-op
Date: Wed, 15 Sep 2010 22:47:41 +0200
Message-ID: <f78f891e34a6509e937e1235dffcdfb789ef9cc9.1284582409.git.git@drmicha.warpmail.net>
References: <cover.1284365021.git.git@drmicha.warpmail.net>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 15 22:49:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ovyuo-0005JE-MA
	for gcvg-git-2@lo.gmane.org; Wed, 15 Sep 2010 22:49:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755142Ab0IOUrs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Sep 2010 16:47:48 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:57865 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755123Ab0IOUrs (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Sep 2010 16:47:48 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id A48E75FB;
	Wed, 15 Sep 2010 16:47:47 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 15 Sep 2010 16:47:47 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=R9kCnL+bZ0v1ITVWI3+C1u61Ksg=; b=P226wvkgWsOEe8n0yfVha8Da5bMLogueLfpLDF/5WvlXBcyVXywobXccvoeIo1rIabcOJpk0M6lpdvUBwTrH55Tut4LYj/jOC7/Ss5iLlViBU8smMJ7VwoKZIbTKqm+NQ7vc86bsLI/DlBNmAHAwQhxzH8L5lguLzaPpzeUup8E=
X-Sasl-enc: RhpGltFXDIGH03R35zC1gNZeHbu7TA1waAInp0PFH5px 1284583666
Received: from localhost (p548580A7.dip0.t-ipconnect.de [84.133.128.167])
	by mail.messagingengine.com (Postfix) with ESMTPSA id F0383400500;
	Wed, 15 Sep 2010 16:47:46 -0400 (EDT)
X-Mailer: git-send-email 1.7.3.rc1.215.g6997c
In-Reply-To: <cover.1284365021.git.git@drmicha.warpmail.net>
In-Reply-To: <cover.1284582409.git.git@drmicha.warpmail.net>
References: <cover.1284582409.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156255>

Make it clearer that git reset --soft actually does something (changing
HEAD). While it is mentioned in the previous paragraph already it can
be easily overlooked otherwise.

Also, git reset --soft does not look at the index nor the worktree, so
there is no "good order" requirement.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-reset.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index e443740..8762a0c 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -42,10 +42,10 @@ linkgit:git-add[1]).
 +
 --
 --soft::
-	Does not touch the index file nor the working tree at all, but
-	requires them to be in a good order. This leaves all your changed
-	files "Changes to be committed", as 'git status' would
-	put it.
+	Does not touch the index file nor the working tree at all (but
+	resets the head to <commit>, just like all modes do). This leaves
+	all your changed files "Changes to be committed", as 'git status'
+	would put it.
 
 --mixed::
 	Resets the index but not the working tree (i.e., the changed files
-- 
1.7.3.rc1.215.g6997c
