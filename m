From: mhagger@alum.mit.edu
Subject: [PATCH 02/17] Rename static function fetch_pack() to http_fetch_pack()
Date: Thu, 23 Aug 2012 10:10:27 +0200
Message-ID: <1345709442-16046-3-git-send-email-mhagger@alum.mit.edu>
References: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 10:18:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4ScP-0008Ab-KP
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 10:18:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933702Ab2HWISQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 04:18:16 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:59086 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933693Ab2HWISL (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Aug 2012 04:18:11 -0400
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Aug 2012 04:18:11 EDT
X-AuditID: 1207440d-b7f236d000000943-f1-5035e59736a0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id A7.50.02371.795E5305; Thu, 23 Aug 2012 04:11:03 -0400 (EDT)
Received: from michael.fritz.box (p57A2588E.dip.t-dialin.net [87.162.88.142])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7N8AkV2030408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 23 Aug 2012 04:11:02 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsUixO6iqDv9qWmAwesJJhZdV7qZLBp6rzBb
	3F4xn9niR0sPswOLx9/3H5g8nvXuYfS4eEnZ4/MmuQCWKG6bpMSSsuDM9Dx9uwTujHNbD7AV
	nOao6Pj7nbGBsY29i5GTQ0LAROLHy/csELaYxIV769m6GLk4hAQuM0rs+fmCBcI5yyTx6FY7
	K0gVm4CUxMvGHrBuEQE1iYlth8C6mQVSJDqedzOC2MIC/hL7trcyg9gsAqoS6w+vAqvnFXCR
	+PJ9EyPENkWJH9/XgNVwCrhKLICKCwHVfGy8yTyBkXcBI8MqRrnEnNJc3dzEzJzi1GTd4uTE
	vLzUIl0jvdzMEr3UlNJNjJAA4t3B+H+dzCFGAQ5GJR7eF+amAUKsiWXFlbmHGCU5mJREef89
	AgrxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4Q2fB5TjTUmsrEotyodJSXOwKInzqi1R9xMSSE8s
	Sc1OTS1ILYLJynBwKEnw3nkC1ChYlJqeWpGWmVOCkGbi4AQRXCAbeIA2KD4F2VBckJhbnJkO
	UXSKUVFKnPckyAQBkERGaR7cAFisv2IUB/pHmHcySBUPME3Adb8CGswENFjtqjHI4JJEhJRU
	A6Pz430Ptbhk/Q9MbL0uMEMujFflRxRjenjtp/nRmeyZN7dqfxe0WuVy6+mtTzP2q0pzfYoJ
	/Wxey1vLHXrtgZTSyVVRUpnHxa8evzLx0DFT9qT7tqzzr5suEuxN/35D2OYRY2hqU6P6x5LK
	9e+fSXKobPzwc7LBtNk/nsaYZ4QF5Txk/cgyo0GJpTgj0VCLuag4EQBJwwAg0AIA 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204119>

From: Michael Haggerty <mhagger@alum.mit.edu>

Avoid confusion with the non-static function of the same name from
fetch-pack.h.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 http-walker.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/http-walker.c b/http-walker.c
index 51a906e..1516c5e 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -396,7 +396,7 @@ static int fetch_indices(struct walker *walker, struct alt_base *repo)
 	return ret;
 }
 
-static int fetch_pack(struct walker *walker, struct alt_base *repo, unsigned char *sha1)
+static int http_fetch_pack(struct walker *walker, struct alt_base *repo, unsigned char *sha1)
 {
 	struct packed_git *target;
 	int ret;
@@ -524,7 +524,7 @@ static int fetch(struct walker *walker, unsigned char *sha1)
 	if (!fetch_object(walker, altbase, sha1))
 		return 0;
 	while (altbase) {
-		if (!fetch_pack(walker, altbase, sha1))
+		if (!http_fetch_pack(walker, altbase, sha1))
 			return 0;
 		fetch_alternates(walker, data->alt->base);
 		altbase = altbase->next;
-- 
1.7.11.3
