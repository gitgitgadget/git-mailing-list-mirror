From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] t6302: fix up expect files for tests 34-36
Date: Thu, 31 Mar 2016 19:48:22 +0100
Message-ID: <56FD70F6.5070206@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: karthik.188@gmail.com
X-From: git-owner@vger.kernel.org Thu Mar 31 20:48:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alhdx-0004BK-06
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 20:48:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756675AbcCaSs2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 14:48:28 -0400
Received: from avasout07.plus.net ([84.93.230.235]:46088 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753216AbcCaSs1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 14:48:27 -0400
Received: from [10.0.2.15] ([91.125.197.102])
	by avasout07 with smtp
	id cioQ1s0022D2Veb01ioR09; Thu, 31 Mar 2016 19:48:25 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=QqujpgGd c=1 sm=1 tr=0
 a=mTUfFwB0nGOO66Ym8a+i3w==:117 a=mTUfFwB0nGOO66Ym8a+i3w==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=EBOSESyhAAAA:8 a=6pCRjmksMqS_bgSp0JwA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290445>


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Karthik,

If you need to re-roll the patches in your 'kn/ref-filter-branch-list'
branch, could you please squash this into the relevant patch (which
would be equivalent to commit 86cd4d32, "ref-filter: implement %(if),
%(then), and %(else) atoms", 30-03-2016).

It looks like these tests were written before Eric 'es/test-gpg-tags'
branch was applied.

Thanks!

ATB,
Ramsay Jones


 t/t6302-for-each-ref-filter.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 98a1c49..7420e48 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -349,6 +349,8 @@ test_expect_success 'check %(if)...%(then)...%(end) atoms' '
 	A U Thor: refs/heads/side
 	A U Thor: refs/odd/spot
 
+
+
 	A U Thor: refs/tags/foo1.10
 	A U Thor: refs/tags/foo1.3
 	A U Thor: refs/tags/foo1.6
@@ -367,7 +369,9 @@ test_expect_success 'check %(if)...%(then)...%(else)...%(end) atoms' '
 	A U Thor: refs/heads/master
 	A U Thor: refs/heads/side
 	A U Thor: refs/odd/spot
-	No author: refs/tags/double-tag
+	No author: refs/tags/annotated-tag
+	No author: refs/tags/doubly-annotated-tag
+	No author: refs/tags/doubly-signed-tag
 	A U Thor: refs/tags/foo1.10
 	A U Thor: refs/tags/foo1.3
 	A U Thor: refs/tags/foo1.6
@@ -385,7 +389,9 @@ test_expect_success 'ignore spaces in %(if) atom usage' '
 	master: Head ref
 	side: Not Head ref
 	odd/spot: Not Head ref
-	double-tag: Not Head ref
+	annotated-tag: Not Head ref
+	doubly-annotated-tag: Not Head ref
+	doubly-signed-tag: Not Head ref
 	foo1.10: Not Head ref
 	foo1.3: Not Head ref
 	foo1.6: Not Head ref
-- 
2.8.0
