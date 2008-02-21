From: Mike Hommey <mh@glandium.org>
Subject: [PATCH] Don't verify host name in SSL certs when GIT_SSL_NO_VERIFY is set
Date: Thu, 21 Feb 2008 20:23:10 +0100
Message-ID: <1203621790-1415-1-git-send-email-mh@glandium.org>
References: <Pine.LNX.4.64.0802212003140.14691@yvahk3.pbagnpgbe.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Feb 21 20:23:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSH1G-0007P2-0R
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 20:23:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753083AbYBUTXK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 14:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752886AbYBUTXI
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 14:23:08 -0500
Received: from vuizook.err.no ([85.19.215.103]:58081 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752340AbYBUTXG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 14:23:06 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JSH0T-0000I6-Hy
	for git@vger.kernel.org; Thu, 21 Feb 2008 20:23:03 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JSH0g-0000NL-OB; Thu, 21 Feb 2008 20:23:10 +0100
X-Mailer: git-send-email 1.5.4.1.48.g0d77
In-Reply-To: <Pine.LNX.4.64.0802212003140.14691@yvahk3.pbagnpgbe.fr>
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74645>


Signed-off-by: Mike Hommey <mh@glandium.org>
---
 http.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/http.c b/http.c
index 5925d07..519621a 100644
--- a/http.c
+++ b/http.c
@@ -177,6 +177,7 @@ static CURL* get_curl_handle(void)
 	CURL* result = curl_easy_init();
 
 	curl_easy_setopt(result, CURLOPT_SSL_VERIFYPEER, curl_ssl_verify);
+	curl_easy_setopt(result, CURLOPT_SSL_VERIFYHOST, curl_ssl_verify * 2);
 #if LIBCURL_VERSION_NUM >= 0x070907
 	curl_easy_setopt(result, CURLOPT_NETRC, CURL_NETRC_OPTIONAL);
 #endif
-- 
1.5.4.1.48.g0d77
