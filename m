From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 12/15] query_refspecs(): move some constants out of the loop
Date: Wed, 23 Oct 2013 17:50:45 +0200
Message-ID: <1382543448-2586-13-git-send-email-mhagger@alum.mit.edu>
References: <1382543448-2586-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org,
	=?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Szakmeister <john@szakmeister.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 23 17:52:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZ0jP-0002F0-S9
	for gcvg-git-2@plane.gmane.org; Wed, 23 Oct 2013 17:52:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751977Ab3JWPwU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Oct 2013 11:52:20 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:42202 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751722Ab3JWPwT (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Oct 2013 11:52:19 -0400
X-AuditID: 12074414-b7fb46d000002a4d-ae-5267f0b150e2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 4E.D2.10829.1B0F7625; Wed, 23 Oct 2013 11:52:17 -0400 (EDT)
Received: from localhost.localdomain (p57A247B5.dip0.t-ipconnect.de [87.162.71.181])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r9NFpLt5009100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 23 Oct 2013 11:52:14 -0400
X-Mailer: git-send-email 1.8.4
In-Reply-To: <1382543448-2586-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsUixO6iqLvxQ3qQwa8mGYvpXatZLLqudDNZ
	NPReYbaYd3cXk8WqW8uYLVbOuMFocXvFfGaLp52VFvNevGCz+NHSw+zA5fH3/Qcmj0vrXjJ5
	HPozhd3j2Yl2No9LL7+zeTzr3cPocfGSsseMltcsHp83yXkcuPyYLYAritsmKbGkLDgzPU/f
	LoE740EDZ0E7R8W+6f8YGxh3snUxcnJICJhI9Dy8DmWLSVy4tx7I5uIQErjMKLHp2BxWCOcK
	k8TOx+dZQKrYBHQlFvU0M4HYIgJqEhPbDrGAFDELTGSWOD59EViRsICPxLXdL8BsFgFViR+z
	voM18Aq4SLSd+c/YxcgBtE5O4uG3WJAwJ1D4wvHprCC2kICzxISFU9knMPIuYGRYxSiXmFOa
	q5ubmJlTnJqsW5ycmJeXWqRroZebWaKXmlK6iREStCI7GI+clDvEKMDBqMTD+6AlLUiINbGs
	uDL3EKMkB5OSKO+cd+lBQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4d9wFyvGmJFZWpRblw6Sk
	OViUxHm/LVb3ExJITyxJzU5NLUgtgsnKcHAoSfC6vgdqFCxKTU+tSMvMKUFIM3FwgggukA08
	QBtiQAp5iwsSc4sz0yGKTjEqSonzNoAkBEASGaV5cANg6eUVozjQP8K8iSBVPMDUBNf9Cmgw
	E9DgKUvSQAaXJCKkpBoYF51j2f4iZw27emL5UW37hPkXxVS8/uku+Fu+YvOMjfezZtyMszQu
	uuIg0lVbzJyt/3fhm7i7R49t7mCekXHxnsWGb/73VJ6Hbg1ds+Fcx5n7Z6MXLGw4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236518>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 remote.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/remote.c b/remote.c
index 5ade07f..ff5b62a 100644
--- a/remote.c
+++ b/remote.c
@@ -829,6 +829,8 @@ static int query_refspecs(struct refspec *refs, int ref_count, struct refspec *q
 {
 	int i;
 	int find_src = !query->src;
+	const char *needle = find_src ? query->dst : query->src;
+	char **result = find_src ? &query->src : &query->dst;
 
 	if (find_src && !query->dst)
 		return error("query_refspecs: need either src or dst");
@@ -837,8 +839,6 @@ static int query_refspecs(struct refspec *refs, int ref_count, struct refspec *q
 		struct refspec *refspec = &refs[i];
 		const char *key = find_src ? refspec->dst : refspec->src;
 		const char *value = find_src ? refspec->src : refspec->dst;
-		const char *needle = find_src ? query->dst : query->src;
-		char **result = find_src ? &query->src : &query->dst;
 
 		if (!refspec->dst)
 			continue;
-- 
1.8.4
