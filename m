From: Mark Wooding <mdw@distorted.org.uk>
Subject: [PATCH 6/9] http: Turn on verbose Curl messages if GIT_CURL_VERBOSE set in environment
Date: Wed, 01 Feb 2006 11:44:37 +0000
Message-ID: <20060201114437.5042.53074.stgit@metalzone.distorted.org.uk>
References: <20060201112822.5042.41256.stgit@metalzone.distorted.org.uk>
X-From: git-owner@vger.kernel.org Wed Feb 01 12:45:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4GPn-00055O-Ve
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 12:44:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161026AbWBALok (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 06:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161024AbWBALoj
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 06:44:39 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:6384 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S932444AbWBALoi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2006 06:44:38 -0500
Received: (qmail 6574 invoked from network); 1 Feb 2006 11:44:37 -0000
Received: from localhost (HELO metalzone.distorted.org.uk) (?FI70QFrIC4O//c8AevB/GkmsyfyAStuD?@127.0.0.1)
  by localhost with SMTP; 1 Feb 2006 11:44:37 -0000
To: git@vger.kernel.org
In-Reply-To: <20060201112822.5042.41256.stgit@metalzone.distorted.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15411>

From: Mark Wooding <mdw@distorted.org.uk>

Signed-off-by: Mark Wooding <mdw@distorted.org.uk>
---

 http.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/http.c b/http.c
index 521323c..d0c92dc 100644
--- a/http.c
+++ b/http.c
@@ -192,6 +192,9 @@ static CURL* get_curl_handle(void)
 
 	curl_easy_setopt(result, CURLOPT_FOLLOWLOCATION, 1);
 
+	if (getenv("GIT_CURL_VERBOSE"))
+		curl_easy_setopt(result, CURLOPT_VERBOSE, 1);
+
 	return result;
 }
 
