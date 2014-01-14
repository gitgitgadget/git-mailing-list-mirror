From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH] gitattributes: document more clearly where macros are allowed
Date: Tue, 14 Jan 2014 03:58:49 +0100
Message-ID: <1389668329-15719-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 14 03:59:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W2uDp-00073U-VU
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jan 2014 03:59:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752616AbaANC7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jan 2014 21:59:18 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:63377 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752596AbaANC7R (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Jan 2014 21:59:17 -0500
X-AuditID: 12074411-b7f426d000005455-6b-52d4a804450a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id B0.EA.21589.408A4D25; Mon, 13 Jan 2014 21:59:16 -0500 (EST)
Received: from michael.fritz.box (p57A241AD.dip0.t-ipconnect.de [87.162.65.173])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s0E2wuGt019020
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 13 Jan 2014 21:59:15 -0500
X-Mailer: git-send-email 1.8.5.2
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsUixO6iqMuy4kqQQXurukXXlW4mi4beK8wW
	t1fMZ3Zg9vj7/gOTx8VLyh6fN8kFMEdx2yQllpQFZ6bn6dslcGfcmL2SraCPq+Ly69OsDYwH
	OLoYOTkkBEwkZl94xQxhi0lcuLeerYuRi0NI4DKjROO8jewQzgkmid0fXrCDVLEJ6Eos6mlm
	ArFFBNQkJrYdYgGxmQUcJDZ/bmTsYuTgEBbwk9j8PwokzCKgKrHr71kWkDCvgIvE3rtGIKaE
	gILE6utCExi5FzAyrGKUS8wpzdXNTczMKU5N1i1OTszLSy3SNdXLzSzRS00p3cQI8bvgDsYZ
	J+UOMQpwMCrx8J5gvBIkxJpYVlyZe4hRkoNJSZQ3fSFQiC8pP6UyI7E4I76oNCe1+BCjBAez
	kghv5QKgHG9KYmVValE+TEqag0VJnJdvibqfkEB6YklqdmpqQWoRTFaGg0NJgjdzOVCjYFFq
	empFWmZOCUKaiYMTRHCBbOAB2tANUshbXJCYW5yZDlF0ilFRSpw3EiQhAJLIKM2DGwCL0FeM
	4kD/CPMmglTxAKMbrvsV0GAmoMG17pdABpckIqSkGhhrRDYlPdafOjWe+Zq/puMXv0kPYhjX
	v5d3OXvBeHvsAueNZuKH6lZzsW0rifF78fzYLsG3//nP/Ko12vntRmyoy9oZLv4tDRzWKp5J
	Ib82ClkamC3jftzSLtuxP7AxKZevIuDLj4Rj7+sZ1Xbcfdj7eJbqabvrgU0nDDdc3StXrX9K
	xqq+N1eJpTgj0VCLuag4EQCUdrWaqwIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240388>

The old text made it sound like macros are only allowed in the
.gitattributes file at the top-level of the working tree.  Make it
clear that they are also allowed in $GIT_DIR/info/attributes and in
the global and system-wide gitattributes files.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/gitattributes.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index b322a26..643c1ba 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -930,9 +930,12 @@ state.
 DEFINING MACRO ATTRIBUTES
 -------------------------
 
-Custom macro attributes can be defined only in the `.gitattributes`
-file at the toplevel (i.e. not in any subdirectory).  The built-in
-macro attribute "binary" is equivalent to:
+Custom macro attributes can be defined only in top-level gitattributes
+files (`$GIT_DIR/info/attributes`, the `.gitattributes` file at the
+top level of the working tree, or the global or system-wide
+gitattributes files), not in `.gitattributes` files in working tree
+subdirectories.  The built-in macro attribute "binary" is equivalent
+to:
 
 ------------
 [attr]binary -diff -merge -text
-- 
1.8.5.2
