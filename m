From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 2/5] t1404: document function test_update_rejected
Date: Tue,  7 Jun 2016 13:50:07 +0200
Message-ID: <2561c38f85648144d665e870ca42c133a3a78909.1465299118.git.mhagger@alum.mit.edu>
References: <cover.1465299118.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 13:51:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAFWz-0004XT-07
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 13:50:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161132AbcFGLuc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 07:50:32 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:61014 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161079AbcFGLu1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jun 2016 07:50:27 -0400
X-AuditID: 12074411-e3fff70000000955-3f-5756b4faf04a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 40.C7.02389.AF4B6575; Tue,  7 Jun 2016 07:50:18 -0400 (EDT)
Received: from michael.fritz.box (p548D6137.dip0.t-ipconnect.de [84.141.97.55])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u57BoCa1014544
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 7 Jun 2016 07:50:17 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1465299118.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOIsWRmVeSWpSXmKPExsUixO6iqPtrS1i4QcMKJYv5m04wWnRd6Way
	aOi9wmxxe8V8ZovuKW8ZLX609DA7sHn8ff+ByWPnrLvsHs969zB6XLyk7LHg+X12j8+b5ALY
	orhtkhJLyoIz0/P07RK4M870f2At+Mta8XzuVJYGxh8sXYycHBICJhIHD64Csrk4hAS2MkrM
	WPIFyjnGJPFxwm0mkCo2AV2JRT3NYLaIQIREw6sWRpAiZoF9jBIn180H6uDgEBZwktj32hOk
	hkVAVeLxv15mEJtXIEri9JMZjBDb5CQuT3/ABmJzClhInHi3EswWEjCXuNiyiXECI88CRoZV
	jHKJOaW5urmJmTnFqcm6xcmJeXmpRbqmermZJXqpKaWbGCEBJbiDccZJuUOMAhyMSjy8O76E
	hguxJpYVV+YeYpTkYFIS5X3oHRYuxJeUn1KZkVicEV9UmpNafIhRgoNZSYQ3YS1QjjclsbIq
	tSgfJiXNwaIkzsu3RN1PSCA9sSQ1OzW1ILUIJivDwaEkwftxM1CjYFFqempFWmZOCUKaiYMT
	ZDiXlEhxal5KalFiaUlGPCgG4ouBUQCS4gHa+wqknbe4IDEXKArReopRl2PBj9trmYRY8vLz
	UqXEebeBFAmAFGWU5sGtgKWPV4ziQB8L85oDk4kQDzD1wE16BbSECWjJsmvBIEtKEhFSUg2M
	fGcLipUqw9eF8Sh2785d43Inx9v+zarmCczzZ6ndON4fuTHz32S+mSsWXlzA7HI0wal7j0Go
	6y+7z0tPv3+j+Ohi3byyjteqjy7rsmY2X2numFPg4Zr9ryXkluTcxZK9fpvm/dgk 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296630>

And declare its variables to be local.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t1404-update-ref-errors.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/t1404-update-ref-errors.sh b/t/t1404-update-ref-errors.sh
index 2818460..a62d62a 100755
--- a/t/t1404-update-ref-errors.sh
+++ b/t/t1404-update-ref-errors.sh
@@ -3,7 +3,11 @@
 test_description='Test git update-ref error handling'
 . ./test-lib.sh
 
+# Create some references, perhaps run pack-refs --all, then try to
+# create some more references. Ensure that the second creation fails
+# with the correct error message.
 test_update_rejected () {
+	local prefix before pack create error &&
 	prefix="$1" &&
 	before="$2" &&
 	pack="$3" &&
-- 
2.8.1
