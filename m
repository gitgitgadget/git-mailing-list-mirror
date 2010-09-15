From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 2/6] git-reset.txt: reset does not change files in target
Date: Wed, 15 Sep 2010 22:47:40 +0200
Message-ID: <248631a67b2f6bce911ccaeaf7b5762f57041e4f.1284582409.git.git@drmicha.warpmail.net>
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
	id 1Ovyuo-0005JE-4L
	for gcvg-git-2@lo.gmane.org; Wed, 15 Sep 2010 22:49:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755108Ab0IOUrq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Sep 2010 16:47:46 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:49655 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755056Ab0IOUrp (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Sep 2010 16:47:45 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 29A5E60F;
	Wed, 15 Sep 2010 16:47:45 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 15 Sep 2010 16:47:45 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=6VKWZEREWSgMSKPgkiAElqZfT1g=; b=QHjc3VPQf9BDY/kIvXkE+DCXYQQZEOEhNiAt05YzGxOAtiV5AuTcpLKlUiTBIxXLgccH/tFME37jrYgkptvRQP1n+8RO71gAnHTpY5Xg3U8MEG2Wk9Znrcuehi2NznFrPG0t2iwQvGG9Tiu7XzCy0cgLmlnQ+fn5zqIS6E/DldI=
X-Sasl-enc: rXgxyKPpzCQHOX0ivdnn+vmuFfiuPcxNH6oam0xJwth/ 1284583664
Received: from localhost (p548580A7.dip0.t-ipconnect.de [84.133.128.167])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 7B3E3400500;
	Wed, 15 Sep 2010 16:47:44 -0400 (EDT)
X-Mailer: git-send-email 1.7.3.rc1.215.g6997c
In-Reply-To: <cover.1284365021.git.git@drmicha.warpmail.net>
In-Reply-To: <cover.1284582409.git.git@drmicha.warpmail.net>
References: <cover.1284582409.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156254>

git-reset obviously cannot change files in an existing commit. Make it
not sound as if it could: reset can change HEAD and, in that sense, can
change which state a file in HEAD is in.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-reset.txt |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 91bd2e9..e443740 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -294,8 +294,10 @@ In these tables, A, B, C and D are some different states of a
 file. For example, the first line of the first table means that if a
 file is in state A in the working tree, in state B in the index, in
 state C in HEAD and in state D in the target, then "git reset --soft
-target" will put the file in state A in the working tree, in state B
-in the index and in state D in HEAD.
+target" will leave the file in the working tree in state A and in the
+index in state B.  It resets (i.e. moves) the HEAD (i.e. the tip of
+the current branch, if you are on one) to "target" (which has the file
+in state D).
 
       working index HEAD target         working index HEAD
       ----------------------------------------------------
-- 
1.7.3.rc1.215.g6997c
