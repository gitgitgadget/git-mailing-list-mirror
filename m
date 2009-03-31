From: Martin Storsjo <martin@martin.st>
Subject: [PATCH] Allow any HTTP authentication scheme, not only basic
Date: Tue, 31 Mar 2009 20:31:26 +0300
Message-ID: <1238520686-546-1-git-send-email-martin@martin.st>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 31 20:06:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoiLG-0001aQ-JB
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 20:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754715AbZCaSEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 14:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753882AbZCaSEJ
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 14:04:09 -0400
Received: from smtp2.abo.fi ([130.232.213.77]:33991 "EHLO smtp2.abo.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752668AbZCaSEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 14:04:09 -0400
X-Greylist: delayed 1959 seconds by postgrey-1.27 at vger.kernel.org; Tue, 31 Mar 2009 14:04:08 EDT
Received: from localhost.localdomain (albin.abo.fi [130.232.81.192])
	by smtp2.abo.fi (8.14.3/8.12.9) with ESMTP id n2VHVQ8H007890
	for <git@vger.kernel.org>; Tue, 31 Mar 2009 20:31:27 +0300
X-Mailer: git-send-email 1.6.0.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (smtp2.abo.fi [130.232.213.77]); Tue, 31 Mar 2009 20:31:27 +0300 (EEST)
X-Virus-Scanned: by foxy.abo.fi (foxy.abo.fi: Tue Mar 31 20:31:27 2009)
X-Scanned-By: MIMEDefang 2.64 on 130.232.213.77
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Martin Storsjo <martin@martin.st>
---
 http.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/http.c b/http.c
index 2fc55d6..7cb53e8 100644
--- a/http.c
+++ b/http.c
@@ -165,6 +165,7 @@ static CURL *get_curl_handle(void)
 #if LIBCURL_VERSION_NUM >= 0x070907
 	curl_easy_setopt(result, CURLOPT_NETRC, CURL_NETRC_OPTIONAL);
 #endif
+	curl_easy_setopt(result, CURLOPT_HTTPAUTH, CURLAUTH_ANY);
 
 	init_curl_http_auth(result);
 
-- 
1.6.0.2
