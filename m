From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] git-repack.txt: Clarify implications of -a for dumb protocols
Date: Tue,  9 Jun 2009 18:15:47 +0200
Message-ID: <1244564147-15918-1-git-send-email-git@drmicha.warpmail.net>
References: <780e0a6b0906051214t76f2bf37u96cc0b8039f63d23@mail.gmail.com>
Cc: Stephen Boyd <bebarino@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 09 18:16:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME3za-0000f4-BM
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 18:16:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753363AbZFIQPv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 12:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752958AbZFIQPu
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 12:15:50 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:54089 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750878AbZFIQPu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2009 12:15:50 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 889B635F838;
	Tue,  9 Jun 2009 12:15:52 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 09 Jun 2009 12:15:52 -0400
X-Sasl-enc: /KWDgZAbJnD5ccDUODLNPzP5+QAxXwMOsDSVl8LhqzVS 1244564151
Received: from localhost (p54859AE3.dip0.t-ipconnect.de [84.133.154.227])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9D9EA2F0AB;
	Tue,  9 Jun 2009 12:15:51 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.2.278.gb6431.dirty
In-Reply-To: <780e0a6b0906051214t76f2bf37u96cc0b8039f63d23@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121185>

The current text makes some users feel uneasy, worrying whether
'-a' could lead to corrupt repositories. Clarify that '-a'
may lead to performance issues only for dumb protocols.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Helped-by: Stephen Boyd <bebarino@gmail.com>

 Documentation/git-repack.txt |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index aaa8852..c9257a1 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -31,11 +31,14 @@ OPTIONS
 	Instead of incrementally packing the unpacked objects,
 	pack everything referenced into a single pack.
 	Especially useful when packing a repository that is used
-	for private development and there is no need to worry
-	about people fetching via dumb protocols from it.  Use
+	for private development. Use
 	with '-d'.  This will clean up the objects that `git prune`
 	leaves behind, but `git fsck --full` shows as
 	dangling.
++
+Note that users fetching over dumb protocols will have to fetch the
+whole new pack in order to get any contained object, no matter how many
+other objects in that pack they already have locally.
 
 -A::
 	Same as `-a`, unless '-d' is used.  Then any unreachable
-- 
1.6.3.2.278.gb6431.dirty
