From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 03/25] refs: add a new file, refs/refs.c, to hold common refs code
Date: Tue,  3 Nov 2015 08:39:47 +0100
Message-ID: <8cd6d2158e8e4512eae6f8c17e8fe2245b37e3dc.1446534991.git.mhagger@alum.mit.edu>
References: <cover.1446534991.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 08:47:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtWJR-0005Bk-SN
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 08:47:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752228AbbKCHrW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 02:47:22 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:44585 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750900AbbKCHrV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Nov 2015 02:47:21 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Nov 2015 02:47:21 EST
X-AuditID: 12074414-f794f6d000007852-8a-563864e39964
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 47.2D.30802.3E468365; Tue,  3 Nov 2015 02:40:19 -0500 (EST)
Received: from michael.fritz.box (p5DDB0E27.dip0.t-ipconnect.de [93.219.14.39])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tA37eDd0016391
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 3 Nov 2015 02:40:18 -0500
X-Mailer: git-send-email 2.6.2
In-Reply-To: <cover.1446534991.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsUixO6iqPs4xSLM4MN5IYuuK91MFg29V5gt
	bq+Yz2zxb0KNA4vH3/cfmDwWbCr1uHhJ2ePzJrkAlihum6TEkrLgzPQ8fbsE7oyeNw4Fb9kr
	/i/cwdLAuImti5GTQ0LARGLDs8eMELaYxIV764HiXBxCApcZJR5s2swM4RxjktjVvokJpIpN
	QFdiUU8zmC0ioCYxse0QC4jNLFAgMXvpVnYQW1ggVGLZ7bVgNSwCqhLbl54Ai/MKREnM3LaC
	CWKbnMSU++1gNqeAhcSDu3/AaoQEzCU23VvGNoGRdwEjwypGucSc0lzd3MTMnOLUZN3i5MS8
	vNQiXQu93MwSvdSU0k2MkNAR2cF45KTcIUYBDkYlHt4FS8zDhFgTy4orcw8xSnIwKYnyroux
	CBPiS8pPqcxILM6ILyrNSS0+xCjBwawkwlsQCJTjTUmsrEotyodJSXOwKInzflus7ickkJ5Y
	kpqdmlqQWgSTleHgUJLgvZQM1ChYlJqeWpGWmVOCkGbi4AQZziUlUpyal5JalFhakhEPioz4
	YmBsgKR4gPYmpIDsLS5IzAWKQrSeYlSUEue9CDJXACSRUZoHNxaWEF4xigN9Kcw7EaSKB5hM
	4LpfAQ1mAhocvs0UZHBJIkJKqoFxPsvFTonVnFc+Cc42n6/2PcyM/VTW5YZ7bmlSOV3MJf7L
	Z/wXdeiwNFKQ2ZRwfsqULM3+EwwHLm/iDomx553GzXF159XLfrV+DKnM/eFSh0O/q21tOs6u
	YCCsGN2y2TP+W9ZlrqOH9lg/tfy+xfdySc0nxz6WnFv7Y+VP5Z83f/nh+Z/MdD4l 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280765>

From: Ronnie Sahlberg <sahlberg@google.com>

Create a new file, refs/refs.c, that will be used to hold all the refs
code that is backend agnostic and can be used across all backends.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Makefile    | 1 +
 refs/refs.c | 3 +++
 2 files changed, 4 insertions(+)
 create mode 100644 refs/refs.c

diff --git a/Makefile b/Makefile
index 1a63383..be45704 100644
--- a/Makefile
+++ b/Makefile
@@ -764,6 +764,7 @@ LIB_OBJS += read-cache.o
 LIB_OBJS += reflog-walk.o
 LIB_OBJS += ref-filter.o
 LIB_OBJS += refs/files-backend.o
+LIB_OBJS += refs/refs.o
 LIB_OBJS += remote.o
 LIB_OBJS += replace_object.o
 LIB_OBJS += rerere.o
diff --git a/refs/refs.c b/refs/refs.c
new file mode 100644
index 0000000..77492ff
--- /dev/null
+++ b/refs/refs.c
@@ -0,0 +1,3 @@
+/*
+ * Common refs code for all backends.
+ */
-- 
2.6.2
