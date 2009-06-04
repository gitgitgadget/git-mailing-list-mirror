From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv1+eps] git-repack.txt: Clarify implications of -a for dumb protocols
Date: Thu,  4 Jun 2009 13:34:55 +0200
Message-ID: <1244115295-28688-1-git-send-email-git@drmicha.warpmail.net>
References: <200906031950.56974.lists@informa.tiker.net>
Cc: lists@informa.tiker.net, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 04 13:35:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCBEG-00040R-A9
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 13:35:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753406AbZFDLfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2009 07:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752946AbZFDLfI
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jun 2009 07:35:08 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:46805 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752422AbZFDLfI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Jun 2009 07:35:08 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 2E32F34C586;
	Thu,  4 Jun 2009 07:35:10 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 04 Jun 2009 07:35:10 -0400
X-Sasl-enc: 86FpwMz1Z0imFBBY/wKTDveYmx5Pe5g9bORHsjJ/qUkw 1244115309
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6B3D054E1C;
	Thu,  4 Jun 2009 07:35:09 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.1.268.g94d6d1
In-Reply-To: <200906031950.56974.lists@informa.tiker.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120689>

The current text makes some users feel uneasy, worrying whether
'-a' could lead to corrupt repositories. Clarify that '-a'
may lead to performance issues only for dumb protocols.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Is that clear enough but concise?

Applies to maint.

[Sorry for the resend, I managed to mistype the subject.]

 Documentation/git-repack.txt |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index aaa8852..8af5505 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -32,7 +32,10 @@ OPTIONS
 	pack everything referenced into a single pack.
 	Especially useful when packing a repository that is used
 	for private development and there is no need to worry
-	about people fetching via dumb protocols from it.  Use
+	about people fetching via dumb protocols from it. 
+	(Over dumb protocols, one would have to fetch the whole new
+	pack in order to get any contained object, no matter how
+	many other objects in that pack exist locally already.) Use
 	with '-d'.  This will clean up the objects that `git prune`
 	leaves behind, but `git fsck --full` shows as
 	dangling.
-- 
1.6.3.1.268.g94d6d1
