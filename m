From: David Greene <greened@obbligato.org>
Subject: [PATCH 2/7] contrib/subtree: Add test for missing subtree
Date: Thu, 12 Nov 2015 20:32:31 -0600
Message-ID: <1447381956-4771-3-git-send-email-greened@obbligato.org>
References: <1447381956-4771-1-git-send-email-greened@obbligato.org>
Cc: techlivezheng@gmail.com, alex.crezoff@gmail.com, davvid@gmail.com,
	cbailey32@bloomberg.net, danny0838@gmail.com, prohaska@zib.de,
	th.acker@arcor.de, sschuberth@gmail.com, peff@peff.net,
	gitter.spiros@gmail.com, nod.helm@gmail.com, gitster@pobox.com,
	"David A . Greene" <greened@obbligato.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 13 03:33:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zx4BB-0007Jz-Lo
	for gcvg-git-2@plane.gmane.org; Fri, 13 Nov 2015 03:33:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbbKMCda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2015 21:33:30 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:60469 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932345AbbKMCd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2015 21:33:29 -0500
Received: from chippewa-nat.cray.com ([136.162.34.1] helo=waller.us.cray.com)
	by johnson.obbligato.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
	(Exim 4.85)
	(envelope-from <greened@obbligato.org>)
	id 1Zx4Bk-0004iE-VO; Thu, 12 Nov 2015 20:34:09 -0600
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1447381956-4771-1-git-send-email-greened@obbligato.org>
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281226>

From: Techlive Zheng <techlivezheng@gmail.com>

Test that a merge from a non-existant subtree fails.

Signed-off-by: Techlive Zheng <techlivezheng@gmail.com>
Signed-off-by: David A. Greene <greened@obbligato.org>
---
 contrib/subtree/t/t7900-subtree.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index f9dda3d..4471786 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -123,6 +123,10 @@ test_expect_success 'no pull from non-existant subtree' '
 	test_must_fail git subtree pull --prefix="sub dir" ./"sub proj" sub1
 '
 
+test_expect_success 'no merge from non-existent subtree' '
+	test_must_fail git subtree merge --prefix="sub dir" FETCH_HEAD
+'
+
 test_expect_success 'check if --message works for add' '
 	git subtree add --prefix="sub dir" --message="Added subproject" sub1 &&
 	check_equal ''"$(last_commit_message)"'' "Added subproject" &&
-- 
2.6.1
