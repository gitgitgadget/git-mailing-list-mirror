From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: [PATCH 1/3] http: authenticate on NTLM proxies and others suppported,
 by CuRL
Date: Tue, 28 Feb 2012 13:52:17 +0100
Message-ID: <4F4CCE01.8080300@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, peff@peff.net, sam@vilain.net,
	sam.vilain@catalyst.net.nz
X-From: git-owner@vger.kernel.org Tue Feb 28 14:08:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2MnX-0002F1-CP
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 14:08:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300Ab2B1NIs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 08:08:48 -0500
Received: from luthien1.map.es ([213.9.211.102]:45995 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756996Ab2B1NIq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 08:08:46 -0500
Received: from correo.map.es (unknown [10.1.24.31])
	by luthien2.map.es (Postfix) with ESMTP id 29460F871D;
	Tue, 28 Feb 2012 12:53:42 +0100 (CET)
Received: from [10.47.128.147] (unknown [10.1.29.79])
	by correo.map.es (Postfix) with ESMTP id 3C75ED4EB9;
	Tue, 28 Feb 2012 12:53:35 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: 29460F871D.46199
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1331034822.54657@4ZNMfjJntBldcGgQmvc/gw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191729>

Signed-off-by: Nelson Benitez Leon <nbenitezl@gmail.com>
---
 http.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/http.c b/http.c
index 0ffd79c..8ac8eb6 100644
--- a/http.c
+++ b/http.c
@@ -295,8 +295,10 @@ static CURL *get_curl_handle(void)
 	if (curl_ftp_no_epsv)
 		curl_easy_setopt(result, CURLOPT_FTP_USE_EPSV, 0);
 
-	if (curl_http_proxy)
+	if (curl_http_proxy) {
 		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
+		curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
+	}
 
 	return result;
 }
-- 
1.7.7.6
