From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH 3/3] contrib/subtree: Small tidy-up to test
Date: Mon, 22 Jun 2015 14:53:30 +0100
Message-ID: <1434981210-13036-3-git-send-email-charles@hashpling.org>
References: <1434981210-13036-1-git-send-email-charles@hashpling.org>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 22 15:53:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z72Ad-0000dB-6N
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 15:53:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756277AbbFVNxq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 09:53:46 -0400
Received: from host02.zombieandprude.com ([80.82.119.138]:33177 "EHLO
	host02.zombieandprude.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756166AbbFVNxg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 09:53:36 -0400
Received: from hashpling.plus.com ([212.159.69.125]:60387)
	by host02.zombieandprude.com with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA256:128)
	(Exim 4.80)
	(envelope-from <charles@hashpling.org>)
	id 1Z72AI-0004JB-IJ; Mon, 22 Jun 2015 14:53:34 +0100
X-Mailer: git-send-email 2.4.0.53.g8440f74
In-Reply-To: <1434981210-13036-1-git-send-email-charles@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272342>

From: Charles Bailey <cbailey32@bloomberg.net>

There's no need to switch branches to parse another branch's ancestry.

Signed-off-by: Charles Bailey <cbailey32@bloomberg.net>
---
 contrib/subtree/t/t7900-subtree.sh | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 001c604..bd3df97 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -221,9 +221,7 @@ test_expect_success 'check hash of split' '
 	spl1=$(git subtree split --prefix subdir) &&
 	git subtree split --prefix subdir --branch splitbr1test &&
 	check_equal ''"$(git rev-parse splitbr1test)"'' "$spl1" &&
-	git checkout splitbr1test &&
-	new_hash=$(git rev-parse HEAD~2) &&
-	git checkout mainline &&
+	new_hash=$(git rev-parse splitbr1test~2) &&
 	check_equal ''"$new_hash"'' "$subdir_hash"
 '
 
-- 
2.4.0.53.g8440f74
