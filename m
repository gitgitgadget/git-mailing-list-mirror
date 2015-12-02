From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH] Fix quoting of redirect in test script
Date: Wed,  2 Dec 2015 20:50:07 +0000
Message-ID: <1449089407-14921-1-git-send-email-charles@hashpling.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 02 21:50:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4EM3-0001x5-4j
	for gcvg-git-2@plane.gmane.org; Wed, 02 Dec 2015 21:50:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754643AbbLBUuS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2015 15:50:18 -0500
Received: from host02.zombieandprude.com ([80.82.119.138]:52855 "EHLO
	host02.zombieandprude.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751881AbbLBUuR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2015 15:50:17 -0500
Received: from hashpling.plus.com ([212.159.69.125]:43553)
	by host02.zombieandprude.com with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA256:128)
	(Exim 4.80)
	(envelope-from <charles@hashpling.org>)
	id 1a4ELt-0007Gf-SR; Wed, 02 Dec 2015 20:50:14 +0000
X-Mailer: git-send-email 2.4.0.53.g8440f74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281915>

From: Charles Bailey <cbailey32@bloomberg.net>

---
 t/t3404-rebase-interactive.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

If you are using bash (at least 4.3.30 or 4.3.42) this actually causes
an error due to an "ambiguous redirect" because there is a space in
"trash directory".

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 98eb49a..9067e02 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1234,7 +1234,7 @@ test_expect_success 'tabs and spaces are accepted in the todolist' '
 		# Turn single spaces into space/tab mix
 		sed "1s/ /	/g; 2s/ /  /g; 3s/ / 	/g" "$1"
 		printf "\n\t# comment\n #more\n\t # comment\n"
-	) >$1.new
+	) >"$1.new"
 	mv "$1.new" "$1"
 	EOF
 	test_set_editor "$(pwd)/add-indent.sh" &&
-- 
2.4.0.53.g8440f74
