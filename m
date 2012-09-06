From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 4/8] t0060: verify that real_path() fails if passed the empty string
Date: Fri,  7 Sep 2012 00:41:00 +0200
Message-ID: <1346971264-23744-5-git-send-email-mhagger@alum.mit.edu>
References: <1346971264-23744-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Orgad and Raizel Shaneh <orgads@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 00:41:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9kle-0007OG-QE
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 00:41:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754273Ab2IFWll (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 18:41:41 -0400
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:63075 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754198Ab2IFWlk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Sep 2012 18:41:40 -0400
X-AuditID: 1207440e-b7f036d0000008b5-63-504926a39490
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 5F.9C.02229.3A629405; Thu,  6 Sep 2012 18:41:39 -0400 (EDT)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q86MfGJW025515
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 6 Sep 2012 18:41:38 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1346971264-23744-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsUixO6iqLtYzTPAoK1By6LrSjeTRUPvFWaL
	J3PvMlvcXjGf2WL9ogZWi+4pbxkd2Dz+vv/A5LFz1l12j4evutg9Ll5S9vi8SS6ANYrbJimx
	pCw4Mz1P3y6BO+PPtGtMBcdYK55e+cLSwHiKpYuRk0NCwETi5oEuVghbTOLCvfVsXYxcHEIC
	lxkl5h7axgLhnGaSmL/oFVgHm4CuxKKeZiYQW0RATWJi2yGwOLPAeUaJPzfZQWxhgXCJv0sW
	sYHYLAKqEoe+9IDFeQVcJJrnLWWD2KYo8eP7GuYuRg4OTgFXiWkL5EDCQkAl897fZpvAyLuA
	kWEVo1xiTmmubm5iZk5xarJucXJiXl5qka6xXm5miV5qSukmRkhw8e1gbF8vc4hRgINRiYfX
	6KxHgBBrYllxZe4hRkkOJiVR3n9KngFCfEn5KZUZicUZ8UWlOanFhxglOJiVRHgn/gIq501J
	rKxKLcqHSUlzsCiJ86otUfcTEkhPLEnNTk0tSC2CycpwcChJ8M5UBRoqWJSanlqRlplTgpBm
	4uAEEVwgG3iANgSAFPIWFyTmFmemQxSdYlSUEuctAkkIgCQySvPgBsDSwCtGcaB/hHm7QKp4
	gCkErvsV0GAmoMEiz0BOLy5JREhJNTDKblr45duZkIWX2Io+vF96SLN2UuVegRMbTs0+WXpU
	1erfjsc7/svVrD/z/L+eyNw3vq/f3rzj6rSrRX5uBTv76UVyPlaJp24wzjYSmfk0asq/db9W
	GSQGPLHibPvjJlV2/zfTCc2FZdtv7cg4eUlNZNuC+p6G6ndZ2l+2VSlP2tMmvOTE 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204934>

It doesn't, so mark the test as failing.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t0060-path-utils.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 924aa60..1118056 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -144,6 +144,10 @@ test_expect_success 'absolute path rejects the empty string' '
 	test_must_fail test-path-utils absolute_path ""
 '
 
+test_expect_failure 'real path rejects the empty string' '
+	test_must_fail test-path-utils real_path ""
+'
+
 test_expect_success SYMLINKS 'real path works as expected' '
 	mkdir first &&
 	ln -s ../.git first/.git &&
-- 
1.7.11.3
