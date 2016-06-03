From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 01/38] resolve_gitlink_ref(): eliminate temporary variable
Date: Fri,  3 Jun 2016 23:03:36 +0200
Message-ID: <c1efb665029d679bdeb3865dffd02e5e8f45db97.1464983301.git.mhagger@alum.mit.edu>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 23:05:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8wHE-0000Yi-Ar
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 23:05:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932645AbcFCVEl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 17:04:41 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:61153 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752645AbcFCVEc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 17:04:32 -0400
X-AuditID: 1207440f-8bbff700000008e4-cb-5751f0d9e0eb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 90.EB.02276.9D0F1575; Fri,  3 Jun 2016 17:04:25 -0400 (EDT)
Received: from michael.fritz.box (p548D60E2.dip0.t-ipconnect.de [84.141.96.226])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u53L4KcR003260
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 3 Jun 2016 17:04:24 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1464983301.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsUixO6iqHvrQ2C4wbpWVov5m04wWnRd6Way
	aOi9wmxxe8V8ZovuKW8ZLX609DBbzLxqbXHmTSOjA4fH3/cfmDx2zrrL7vGsdw+jx8VLyh77
	l25j81j8wMtjwfP77B6fN8kFcERx2yQllpQFZ6bn6dslcGdMObaQpWAue8WJrjssDYz/WbsY
	OTkkBEwkXs+awtTFyMUhJLCVUWLfhg3MIAkhgeNMEnMnaYLYbAK6Eot6mplAbBGBCImGVy2M
	IA3MAnOYJG4/7ARrEBbwkng+Yw2YzSKgKtF2eCE7iM0rECXxaPk0FohtchKXpz9gA7E5BSwk
	Wj6vYoVYZi7ReOowywRGngWMDKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdE30cjNL9FJTSjcx
	QoKOfwdj13qZQ4wCHIxKPLwnXgSGC7EmlhVX5h5ilORgUhLl3XsHKMSXlJ9SmZFYnBFfVJqT
	WnyIUYKDWUmEN+U1UI43JbGyKrUoHyYlzcGiJM6rvkTdT0ggPbEkNTs1tSC1CCYrw8GhJMG7
	6D1Qo2BRanpqRVpmTglCmomDE2Q4l5RIcWpeSmpRYmlJRjwoBuKLgVEAkuIB2sv9AWRvcUFi
	LlAUovUUoy7Hgh+31zIJseTl56VKifMeAtkhAFKUUZoHtwKWYl4xigN9LMw7B6SKB5ie4Ca9
	AlrCBLSk4JE/yJKSRISUVAOjbZTCPB5Gi9/BolwHDPz+mTCZfdmk1WCWc8j81ZukR3PXqW2Y
	cfxwYXe7oaJ/bZZR2U+plDNPmvXDFPgcA67uPO0h3TU7qkKr84LtE84fAdudvE6G 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296373>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 36bf128..2f9d79a 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1387,7 +1387,7 @@ static int resolve_gitlink_ref_recursive(struct ref_cache *refs,
 
 int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sha1)
 {
-	int len = strlen(path), retval;
+	int len = strlen(path);
 	struct strbuf submodule = STRBUF_INIT;
 	struct ref_cache *refs;
 
@@ -1404,8 +1404,7 @@ int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *sh
 	}
 	strbuf_release(&submodule);
 
-	retval = resolve_gitlink_ref_recursive(refs, refname, sha1, 0);
-	return retval;
+	return resolve_gitlink_ref_recursive(refs, refname, sha1, 0);
 }
 
 /*
-- 
2.8.1
