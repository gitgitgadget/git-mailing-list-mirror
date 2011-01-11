From: Alexey Shumkin <zapped@mail.ru>
Subject: [PATCH] userdiff: match Pascal class methods
Date: Tue, 11 Jan 2011 11:53:59 +0300
Message-ID: <1294736039-5912-1-git-send-email-zapped@mail.ru>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 11 09:54:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcZzh-0005mz-GM
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 09:54:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755476Ab1AKIyP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 03:54:15 -0500
Received: from smtp13.mail.ru ([94.100.176.90]:57071 "EHLO smtp13.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754041Ab1AKIyM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 03:54:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail;
	h=Message-Id:Date:Subject:Cc:To:From; bh=aBfjXYZRi1NQoH2Ou4Wmxy3qdudl5hnbff2QPcJbnic=;
	b=GOfGMtSGRG5tcWURhW2vtUVzRaue+MWtGPSzD86VLXaBmZNykL9WYgozo0u3RhHCExBDMHCFSCruS9P4fVKz38RWfSEGrrpdGI98fSdHiJEg52Pg0Gc2GtqnLG/tltpa;
Received: from [85.140.106.43] (port=42124 helo=localhost.localdomain)
	by smtp13.mail.ru with asmtp 
	id 1PcZzW-0008VA-00; Tue, 11 Jan 2011 11:54:10 +0300
X-Mailer: git-send-email 1.7.3.4.3.g3f811
X-Mras: Ok
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164922>

Class declarations were already covered by the second pattern, but class methods have the 'class' keyword in front too. Account for it.

Signed-off-by: Alexey Shumkin <zapped@mail.ru>
Acked-by: Thomas Rast <trast@student.ethz.ch>
---
 userdiff.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/userdiff.c b/userdiff.c
index f9e05b5..259a382 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -52,7 +52,7 @@ PATTERNS("objc",
 	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->"
 	 "|[^[:space:]]|[\x80-\xff]+"),
 PATTERNS("pascal",
-	 "^((procedure|function|constructor|destructor|interface|"
+	 "^(((class[ \t]+)?(procedure|function)|constructor|destructor|interface|"
 		"implementation|initialization|finalization)[ \t]*.*)$"
 	 "\n"
 	 "^(.*=[ \t]*(class|record).*)$",
-- 
1.7.3.4.3.g3f811
