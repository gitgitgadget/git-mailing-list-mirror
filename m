From: Christian Hesse <mail@eworm.de>
Subject: [PATCH 1/1] tests: make comment match the code
Date: Tue, 16 Dec 2014 09:40:05 +0100
Message-ID: <1418719205-13832-1-git-send-email-mail@eworm.de>
Cc: Christian Hesse <mail@eworm.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 16 09:43:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0nj0-0005S3-G6
	for gcvg-git-2@plane.gmane.org; Tue, 16 Dec 2014 09:43:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbaLPImJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2014 03:42:09 -0500
Received: from mx.mylinuxtime.de ([148.251.109.235]:53254 "EHLO
	mx.mylinuxtime.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892AbaLPImD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2014 03:42:03 -0500
Received: from leda.eworm.de (unknown [10.10.1.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx.mylinuxtime.de (Postfix) with ESMTPSA id DE1BF2434C;
	Tue, 16 Dec 2014 09:42:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.9.2 mx.mylinuxtime.de DE1BF2434C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=eworm.de; s=mail;
	t=1418719320; bh=ZjQ+gC0nMvYiUASe/l5xN7dpF2j4ZYNfVNAhIdSwcsw=;
	h=From:To:Cc:Subject:Date;
	b=C+KxSJfjTFrAD5rDSVxDZjnUoreajqaAhbQ/YMmCKQeWiXZwNTIbjAqPMX3n7ZcNI
	 qB72PGgWz7R6+uv6K1yO81B+GzEv4fbqXPetLazgeD7Bj+g9gDof4LsjY0P7aLuu+O
	 x9u9/Bbgs6twzWEgX2V7aZsU1BoPq2kfyEPjd6o8=
Received: by leda.eworm.de (Postfix, from userid 1000)
	id 9AACA1002BF; Tue, 16 Dec 2014 09:41:55 +0100 (CET)
X-Mailer: git-send-email 2.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261439>

GnuPG homedir is generated on the fly and keys are imported from
armored key file. Make commet match available key info and new key
generation procedure.

Signed-off-by: Christian Hesse <mail@eworm.de>
---
 t/lib-gpg.sh | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index 33de402..d88da29 100755
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -12,10 +12,20 @@ else
 		say "Your version of gpg (1.0.6) is too buggy for testing"
 		;;
 	*)
-		# key generation info: gpg --homedir t/lib-gpg --gen-key
-		# Type DSA and Elgamal, size 2048 bits, no expiration date.
-		# Name and email: C O Mitter <committer@example.com>
+		# Available key info:
+		# * Type DSA and Elgamal, size 2048 bits, no expiration date,
+		#   name and email: C O Mitter <committer@example.com>
+		# * Type RSA, size 2048 bits, no expiration date,
+		#   name and email: Eris Discordia <discord@example.net>
 		# No password given, to enable non-interactive operation.
+		# To generate new key:
+		#	gpg --homedir /tmp/gpghome --gen-key
+		# To write armored exported key to keyring:
+		#	gpg --homedir /tmp/gpghome --export-secret-keys \
+		#		--armor 0xDEADBEEF >> lib-gpg/keyring.gpg
+		# To export ownertrust:
+		#	gpg --homedir /tmp/gpghome --export-ownertrust \
+		#		> lib-gpg/ownertrust
 		mkdir ./gpghome &&
 		chmod 0700 ./gpghome &&
 		GNUPGHOME="$(pwd)/gpghome" &&
-- 
2.2.0
