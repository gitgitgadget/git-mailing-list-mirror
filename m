From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 2/8] t0060: verify that absolute_path() fails if passed the empty string
Date: Fri,  7 Sep 2012 00:40:58 +0200
Message-ID: <1346971264-23744-3-git-send-email-mhagger@alum.mit.edu>
References: <1346971264-23744-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Orgad and Raizel Shaneh <orgads@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 00:41:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9kld-0007OG-MW
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 00:41:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753892Ab2IFWli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 18:41:38 -0400
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:60433 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753343Ab2IFWlh (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Sep 2012 18:41:37 -0400
X-AuditID: 12074413-b7f786d0000008bb-f6-504926a05170
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 70.E5.02235.0A629405; Thu,  6 Sep 2012 18:41:36 -0400 (EDT)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q86MfGJU025515
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 6 Sep 2012 18:41:35 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1346971264-23744-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsUixO6iqLtAzTPA4PIzDYuuK91MFg29V5gt
	nsy9y2xxe8V8Zov1ixpYLbqnvGV0YPP4+/4Dk8fOWXfZPR6+6mL3uHhJ2ePzJrkA1ihum6TE
	krLgzPQ8fbsE7oyutgb2gp2sFTNOrWduYDzM0sXIySEhYCIx7fReJghbTOLCvfVsXYxcHEIC
	lxklzu3pYIJwTjNJ/Oj/AFbFJqArsainGcwWEVCTmNh2CGwSs8B5Rok/N9lBbGGBaIkT39+A
	2SwCqhJPt31iBLF5BVwkFr7vZobYpijx4/saIJuDg1PAVWLaAjmQsBBQybz3t9kmMPIuYGRY
	xSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRrrpebWaKXmlK6iRESXMI7GHedlDvEKMDBqMTDO/W8
	R4AQa2JZcWXuIUZJDiYlUd5/Sp4BQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4J/4CKudNSays
	Si3Kh0lJc7AoifOqLVH3ExJITyxJzU5NLUgtgsnKcHAoSfBGqwINFSxKTU+tSMvMKUFIM3Fw
	gggukA08QBt4gHEpxFtckJhbnJkOUXSKUVFKnLcIZIIASCKjNA9uACwNvGIUB/pHmLcLpIoH
	mELgul8BDWYCGizyDOT04pJEhJRUA6NBx4S3C7Ye01ZsXq3RZJcVHVWdNLFHWZBh77kKTdOp
	Gbfmz78ZKf32ikK/r2W5sUzcsWUdHGzXLfe9a1qec67OeG5U0vWAyv5VzUUreLwXbGcI7LX5
	Kap49SPz8fzXwWlFfyO2mlcFld39qd0yQ035p7ksZ6yYA4fV3ms6v29s+Xsq40Uq 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204933>

It doesn't, so mark the test as failing.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t0060-path-utils.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index c8db144..d91e516 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -140,6 +140,10 @@ test_expect_success 'strip_path_suffix' '
 		c:/msysgit/libexec//git-core libexec/git-core)
 '
 
+test_expect_failure 'absolute path rejects the empty string' '
+	test_must_fail test-path-utils absolute_path ""
+'
+
 test_expect_success SYMLINKS 'real path works as expected' '
 	mkdir first &&
 	ln -s ../.git first/.git &&
-- 
1.7.11.3
