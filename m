From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 2/6] git-reset.txt: reset does not change files in target
Date: Mon, 13 Sep 2010 10:06:32 +0200
Message-ID: <9669b7872536d2555d4b2c01560c552d97fdd81b.1284365021.git.git@drmicha.warpmail.net>
References: <cover.1284365021.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 13 10:17:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ov4Di-0004ll-Pu
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 10:16:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754533Ab0IMIQc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Sep 2010 04:16:32 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:56945 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754269Ab0IMIQW (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Sep 2010 04:16:22 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 1BB8521D;
	Mon, 13 Sep 2010 04:06:38 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 13 Sep 2010 04:06:38 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=vxfBJuxVRY1lfu6felSQLV6Hn0g=; b=ojhUU61EMQS+IVSFpxmgE1UKSt1uArkzovia/vsFF+Dh61TqRwsV4P0dQKMDWnkY5gxRH57vHf8n6rWCyDy44UWBDKasxRyXs4X9OnvZZzsXdNtJi1wJZ9mZUoieD6Xmvp3xJrfR9Rd1oJRqQEgfms6xB1B3LU+fYsJ3gt7PTHk=
X-Sasl-enc: yTlsamzutJTjFu55t2IsOSRdy3AX+PmYt8eICj1/5FhU 1284365197
Received: from localhost (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 92A7A4053A3;
	Mon, 13 Sep 2010 04:06:37 -0400 (EDT)
X-Mailer: git-send-email 1.7.3.rc1.215.g6997c
In-Reply-To: <cover.1284365021.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156080>

git-reset obviously cannot change files in an existing commit. Make it
not sound as if it could: reset can change HEAD and, in that sense, can
change which state a file in HEAD is in.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-reset.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 7d68b4c..8fb871c 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -295,7 +295,7 @@ file. For example, the first line of the first table means that if a
 file is in state A in the working tree, in state B in the index, in
 state C in HEAD and in state D in the target, then "git reset --soft
 target" will put the file in state A in the working tree, in state B
-in the index and in state D in HEAD.
+in the index and set HEAD to target (which has the file in state D).
 
       working index HEAD target         working index HEAD
       ----------------------------------------------------
-- 
1.7.3.rc1.215.g6997c
