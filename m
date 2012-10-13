From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] t0003-attributes.sh: Don't overwrite t/.gitattributes
Date: Sat, 13 Oct 2012 18:44:33 +0100
Message-ID: <5079A881.7010802@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 13 19:48:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TN5pK-00008n-Bs
	for gcvg-git-2@plane.gmane.org; Sat, 13 Oct 2012 19:48:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753067Ab2JMRpY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2012 13:45:24 -0400
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:54020 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751857Ab2JMRpY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2012 13:45:24 -0400
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 2D53812823E;
	Sat, 13 Oct 2012 18:45:22 +0100 (BST)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 8278E128239;	Sat, 13 Oct 2012 18:45:21 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta009.tch.inty.net (Postfix) with ESMTP;	Sat, 13 Oct 2012 18:45:20 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
X-MDF-HostID: 22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207575>


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Junio,

This test in the current pu branch (commit bb0e6bf "Merge branch
'aw/rebase-am-failure-detection' into pu", 11-10-2012) overwrites
the contents of t/.gitattributes. Note that the merge of the two
branches 'nd/wildmatch' and 'nd/attr-match-optim-more' both add
new tests at the end, and *both* sets initially 'cd ..' ...

ATB,
Ramsay Jones

 t/t0003-attributes.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 7ed288f..fe80af7 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -247,7 +247,6 @@ test_expect_success 'patterns starting with exclamation' '
 '
 
 test_expect_success '"**" test' '
-	cd .. &&
 	echo "**/f foo=bar" >.gitattributes &&
 	cat <<\EOF >expect &&
 f: foo: bar
-- 
1.7.12
