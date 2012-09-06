From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 1/8] t0060: move tests of real_path() from t0000 to here
Date: Fri,  7 Sep 2012 00:40:57 +0200
Message-ID: <1346971264-23744-2-git-send-email-mhagger@alum.mit.edu>
References: <1346971264-23744-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Orgad and Raizel Shaneh <orgads@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 00:41:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9kld-0007OG-5v
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 00:41:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753637Ab2IFWlg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 18:41:36 -0400
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:47591 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753343Ab2IFWlg (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Sep 2012 18:41:36 -0400
X-AuditID: 12074412-b7f216d0000008e3-e8-5049269fb7f6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 66.9D.02275.F9629405; Thu,  6 Sep 2012 18:41:35 -0400 (EDT)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q86MfGJT025515
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 6 Sep 2012 18:41:33 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1346971264-23744-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsUixO6iqDtfzTPA4MF8LouuK91MFg29V5gt
	nsy9y2xxe8V8Zov1ixpYLbqnvGV0YPP4+/4Dk8fOWXfZPR6+6mL3uHhJ2ePzJrkA1ihum6TE
	krLgzPQ8fbsE7oxPmy+yFKwSrNi2dyJ7A+Mavi5GTg4JAROJn1cOM0PYYhIX7q1n62Lk4hAS
	uMwocfzbFijnNJPEm1vzmUCq2AR0JRb1NIPZIgJqEhPbDrGA2MwC5xkl/txkB7GFBbwlnnff
	Barh4GARUJU41ugBEuYVcJG49OsyO8QyRYkf39cwg5RwCrhKTFsgBxIWAiqZ9/422wRG3gWM
	DKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdM30cjNL9FJTSjcxQkJLaAfj+pNyhxgFOBiVeHiN
	znoECLEmlhVX5h5ilORgUhLl/afkGSDEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhHfiL6By3pTE
	yqrUonyYlDQHi5I478/F6n5CAumJJanZqakFqUUwWRkODiUJXmVVoKGCRanpqRVpmTklCGkm
	Dk4QwQWygQdoQwBIIW9xQWJucWY6RNEpRkUpcV4TkIQASCKjNA9uACwJvGIUB/pHmDcIpIoH
	mEDgul8BDWYCGizyDOT04pJEhJRUA+M6dSeVb/+WhixM43J9ctrq1DOdLrPgHovQm7vbtj5W
	7JzE+Ssg5ZfTKaUQu0svH/5Zdc7te2/Rf0u/h5wTjnNv253hMl33KCd7rtOiihlCxo1PVfnS
	rQ7vkniy+qvR8nkzXs/p2MaVIyb1dVbEUqWsOTwzRH4Lz3ig/Pz+jj0CNtNeBh2O 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204931>

Suggested by: Johannes Sixt <j6t@kdbg.org>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t0000-basic.sh      | 18 ------------------
 t/t0060-path-utils.sh | 19 +++++++++++++++++++
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index ccb5435..ae6a3f0 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -450,24 +450,6 @@ test_expect_success 'update-index D/F conflict' '
 	test $numpath0 = 1
 '
 
-test_expect_success SYMLINKS 'real path works as expected' '
-	mkdir first &&
-	ln -s ../.git first/.git &&
-	mkdir second &&
-	ln -s ../first second/other &&
-	mkdir third &&
-	dir="$(cd .git; pwd -P)" &&
-	dir2=third/../second/other/.git &&
-	test "$dir" = "$(test-path-utils real_path $dir2)" &&
-	file="$dir"/index &&
-	test "$file" = "$(test-path-utils real_path $dir2/index)" &&
-	basename=blub &&
-	test "$dir/$basename" = "$(cd .git && test-path-utils real_path "$basename")" &&
-	ln -s ../first/file .git/syml &&
-	sym="$(cd first; pwd -P)"/file &&
-	test "$sym" = "$(test-path-utils real_path "$dir2/syml")"
-'
-
 test_expect_success 'very long name in the index handled sanely' '
 
 	a=a && # 1
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 53cf1f8..c8db144 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -139,4 +139,23 @@ test_expect_success 'strip_path_suffix' '
 	test c:/msysgit = $(test-path-utils strip_path_suffix \
 		c:/msysgit/libexec//git-core libexec/git-core)
 '
+
+test_expect_success SYMLINKS 'real path works as expected' '
+	mkdir first &&
+	ln -s ../.git first/.git &&
+	mkdir second &&
+	ln -s ../first second/other &&
+	mkdir third &&
+	dir="$(cd .git; pwd -P)" &&
+	dir2=third/../second/other/.git &&
+	test "$dir" = "$(test-path-utils real_path $dir2)" &&
+	file="$dir"/index &&
+	test "$file" = "$(test-path-utils real_path $dir2/index)" &&
+	basename=blub &&
+	test "$dir/$basename" = "$(cd .git && test-path-utils real_path "$basename")" &&
+	ln -s ../first/file .git/syml &&
+	sym="$(cd first; pwd -P)"/file &&
+	test "$sym" = "$(test-path-utils real_path "$dir2/syml")"
+'
+
 test_done
-- 
1.7.11.3
