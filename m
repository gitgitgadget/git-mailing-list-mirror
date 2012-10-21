From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 2/8] real_path_internal(): add comment explaining use of cwd
Date: Sun, 21 Oct 2012 07:57:31 +0200
Message-ID: <1350799057-13846-3-git-send-email-mhagger@alum.mit.edu>
References: <1350799057-13846-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>,
	David Reiss <dreiss@facebook.com>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 21 07:58:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPoYW-0006Vm-PB
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 07:58:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659Ab2JUF6Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 01:58:24 -0400
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:61247 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751387Ab2JUF6W (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Oct 2012 01:58:22 -0400
X-AuditID: 12074414-b7f846d0000008b8-b4-50838efe87cf
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 63.9E.02232.EFE83805; Sun, 21 Oct 2012 01:58:22 -0400 (EDT)
Received: from michael.fritz.box (p57A24D34.dip.t-dialin.net [87.162.77.52])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q9L5w2Wp013120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 21 Oct 2012 01:58:20 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1350799057-13846-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsUixO6iqPuvrznAYP8lQYsjb54wW3Rd6Way
	aOi9wmzxZO5dZoujpywsbq+Yz2yx/t1VZgd2j7/vPzB5vGnvZfTYOesuu8fDV13sHhcvKXt8
	3iQXwBbFbZOUWFIWnJmep2+XwJ3x5M06loIFrBXXjl5kaWBsZ+li5OSQEDCRmL7qEBuELSZx
	4d56IJuLQ0jgMqPEm+XT2SGcM0wSrxa9YwSpYhPQlVjU08wEYosIqElMbDvEAlLELHCHUWLh
	lTfMIAlhAX+Jv1eXgI1lEVCV+Hr9ITuIzSvgIjHrE0SNhICixI/va8BsTgFXiSvL5oDVCwHV
	7Nz4nnECI+8CRoZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRboWermZJXqpKaWbGCEhJ7KD8chJ
	uUOMAhyMSjy8TNbNAUKsiWXFlbmHGCU5mJREeV/0AoX4kvJTKjMSizPii0pzUosPMUpwMCuJ
	8O4WBMrxpiRWVqUW5cOkpDlYlMR5vy1W9xMSSE8sSc1OTS1ILYLJynBwKEnwvgMZKliUmp5a
	kZaZU4KQZuLgBBFcIBt4gDaw94FsKC5IzC3OTIcoOsWoKCXOexNkggBIIqM0D24ALDm8YhQH
	+keY9xJIFQ8wscB1vwIazAQ02Jy7EWRwSSJCSqqBsTuq5sOnlj/2k70X9nT/5p28xV52/TPB
	nhP8R6v2iOt2KRl+YZtZU7/Cea7dMb9dx/ikTWQLtneHZR19OCv9/M9p7RMD/7PxvXx2bVdr
	if2vxQwTb62eIMD7rfyqLHf/4bN1T3+qdJQEf1M9N936De/kSRuX7U118t61yO/T 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208103>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 abspath.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/abspath.c b/abspath.c
index a7ab8e9..f8a526f 100644
--- a/abspath.c
+++ b/abspath.c
@@ -35,7 +35,14 @@ static const char *real_path_internal(const char *path, int die_on_error)
 {
 	static char bufs[2][PATH_MAX + 1], *buf = bufs[0], *next_buf = bufs[1];
 	char *retval = NULL;
+
+	/*
+	 * If we have to temporarily chdir(), store the original CWD
+	 * here so that we can chdir() back to it at the end of the
+	 * function:
+	 */
 	char cwd[1024] = "";
+
 	int buf_index = 1;
 
 	int depth = MAXDEPTH;
-- 
1.7.11.3
