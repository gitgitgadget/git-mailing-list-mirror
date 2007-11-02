From: Blake Ramsdell <blaker@gmail.com>
Subject: [PATCH] Fixed a gcc 4.0.1 complaint about an uninitialized variable
Date: Thu,  1 Nov 2007 19:38:22 -0700
Message-ID: <1193971102-61907-2-git-send-email-blaker@gmail.com>
References: <1193971102-61907-1-git-send-email-blaker@gmail.com>
Cc: Blake Ramsdell <blaker@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 02 04:44:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InnSR-0000Jz-6O
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 04:44:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752611AbXKBDoP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 23:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752540AbXKBDoP
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 23:44:15 -0400
Received: from c-24-17-217-200.hsd1.wa.comcast.net ([24.17.217.200]:50624 "EHLO
	Adverlingus.local" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752495AbXKBDoO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 23:44:14 -0400
X-Greylist: delayed 3951 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Nov 2007 23:44:14 EDT
Received: by Adverlingus.local (Postfix, from userid 501)
	id BCDE6EFDD6; Thu,  1 Nov 2007 19:38:22 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.GIT
In-Reply-To: <1193971102-61907-1-git-send-email-blaker@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63059>

Signed-off-by: Blake Ramsdell <blaker@gmail.com>
---
 transport.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/transport.c b/transport.c
index 400af71..cac1870 100644
--- a/transport.c
+++ b/transport.c
@@ -107,7 +107,7 @@ static void insert_packed_refs(const char *packed_refs, struct ref **list)
 		return;
 
 	for (;;) {
-		int cmp, len;
+		int cmp = 0, len;
 
 		if (!fgets(buffer, sizeof(buffer), f)) {
 			fclose(f);
-- 
1.5.3.GIT
