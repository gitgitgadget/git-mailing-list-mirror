From: =?utf-8?q?Gr=C3=A9goire=20Barbier?= <gb@gbarbier.org>
Subject: [PATCH] added #define DEFAULT_MAX_REQUESTS for USE_CURL_MULTI mode
Date: Sat, 19 Jan 2008 16:22:51 +0100
Message-ID: <1200756171-11696-5-git-send-email-gb@gbarbier.org>
References: <1200756171-11696-1-git-send-email-gb@gbarbier.org>
 <1200756171-11696-2-git-send-email-gb@gbarbier.org>
 <1200756171-11696-3-git-send-email-gb@gbarbier.org>
 <1200756171-11696-4-git-send-email-gb@gbarbier.org>
Cc: gitster@pobox.com, Gregoire Barbier <gb@gbarbier.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 19 16:23:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGFXb-0007U3-LP
	for gcvg-git-2@gmane.org; Sat, 19 Jan 2008 16:23:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759874AbYASPW5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2008 10:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759856AbYASPW4
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 10:22:56 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:48556 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754935AbYASPWz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2008 10:22:55 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id D3E301AB315;
	Sat, 19 Jan 2008 16:22:52 +0100 (CET)
Received: from localhost.localdomain (soy95-1-82-229-96-169.fbx.proxad.net [82.229.96.169])
	by smtp1-g19.free.fr (Postfix) with ESMTP id AC7A21AB31E;
	Sat, 19 Jan 2008 16:22:52 +0100 (CET)
X-Mailer: git-send-email 1.5.4.rc3.54.g4b665-dirty
In-Reply-To: <1200756171-11696-4-git-send-email-gb@gbarbier.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71114>

From: Gregoire Barbier <gb@gbarbier.org>

I'm not sure of which value is the good one, but 4 seems good since it's
not very high which would lead to resouce consumption problems.
---
 http.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/http.c b/http.c
index 8b04ae9..7b1bcb8 100644
--- a/http.c
+++ b/http.c
@@ -4,6 +4,7 @@ int data_received;
 int active_requests = 0;
 
 #ifdef USE_CURL_MULTI
+#define DEFAULT_MAX_REQUESTS 4
 static int max_requests = -1;
 static CURLM *curlm;
 #endif
-- 
1.5.4.rc3.52.g9a5bd-dirty
