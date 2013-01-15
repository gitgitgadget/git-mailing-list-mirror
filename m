From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 10/14] imap-send.c: remove unused field imap_store::trashnc
Date: Tue, 15 Jan 2013 09:06:28 +0100
Message-ID: <1358237193-8887-11-git-send-email-mhagger@alum.mit.edu>
References: <1358237193-8887-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 09:07:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tv1Yo-0002j4-6c
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 09:07:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756289Ab3AOIHc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 03:07:32 -0500
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:52997 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755800Ab3AOIHY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jan 2013 03:07:24 -0500
X-AuditID: 1207440f-b7f276d0000008b2-e4-50f50e3b9079
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id E2.9F.02226.B3E05F05; Tue, 15 Jan 2013 03:07:23 -0500 (EST)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r0F86n5W029668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 15 Jan 2013 03:07:22 -0500
X-Mailer: git-send-email 1.8.0.3
In-Reply-To: <1358237193-8887-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsUixO6iqGvN9zXAYNkKI4uuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M5Y8fk1U8FLlooT3y+xNDA+
	Z+5i5OSQEDCROLtgKRuELSZx4d56MFtI4DKjxPcOTgj7DJPEjOdJIDabgK7Eop5mJhBbREBN
	YmLbIRYQm1nAQWLz50ZGEFtYwE/i4/m5rCA2i4CqxKs/jWD1vAIuEuf3r4LaqyDxeuclsBpO
	oPjVn8eYIXY5S3zZcJpxAiPvAkaGVYxyiTmlubq5iZk5xanJusXJiXl5qUW6Jnq5mSV6qSml
	mxghgcK/g7FrvcwhRgEORiUe3pu6XwKEWBPLiitzDzFKcjApifJ2cH0NEOJLyk+pzEgszogv
	Ks1JLT7EKMHBrCTC6/MOqJw3JbGyKrUoHyYlzcGiJM6rvkTdT0ggPbEkNTs1tSC1CCYrw8Gh
	JMEbwws0VLAoNT21Ii0zpwQhzcTBCSK4QDbwAG14xQ1UyFtckJhbnJkOUXSKUVFKnNcMZIIA
	SCKjNA9uACymXzGKA/0jzBsEUsUDTAdw3a+ABjMBDd609zPI4JJEhJRUA6Ofxq/OvXdSX68z
	maOyS5D35vO9gomTf7e2ntoptqdP+g1Dil/A5jpZBYG/R26nS4StFiwsc7QtfDrxZ3bBons8
	k74bR8qHLe+61J8fXTh3/ZRzTTvvHrA+Z3XIZHvOtx+9j97PLYkQ/MG2+91Wu1NTq+JZt2a1
	TrI7q/KNdbvQvkjrbvfbzkVKLMUZiYZazEXFiQC/pViExAIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213611>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 imap-send.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index ff44013..909e4db 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -127,7 +127,6 @@ struct imap_store {
 	int uidvalidity;
 	struct imap *imap;
 	const char *prefix;
-	unsigned /*currentnc:1,*/ trashnc:1;
 };
 
 struct imap_cmd_cb {
@@ -1080,7 +1079,6 @@ static struct store *imap_open_store(struct imap_server_conf *srvc)
 	} /* !preauth */
 
 	ctx->prefix = "";
-	ctx->trashnc = 1;
 	return (struct store *)ctx;
 
 bail:
-- 
1.8.0.3
