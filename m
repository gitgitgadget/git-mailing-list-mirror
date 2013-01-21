From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v2 2/3] t0050: honor CASE_INSENSITIVE_FS in add (with different case)
Date: Mon, 21 Jan 2013 17:46:15 +0100
Message-ID: <201301211746.16213.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 21 17:46:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxKWC-0006Yj-6G
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 17:46:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752691Ab3AUQqX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jan 2013 11:46:23 -0500
Received: from mout.web.de ([212.227.17.12]:51024 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751859Ab3AUQqW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2013 11:46:22 -0500
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb003) with
 ESMTPA (Nemesis) id 0MBTD4-1Tnx7r1iti-00AnXV; Mon, 21 Jan 2013 17:46:21 +0100
X-Provags-ID: V02:K0:HSWqxcxT7k7Z5KiqQNz2LD3n/Drz/WoibzQHmtowIIw
 lmdHfkSBoPpjXsN4gmWRx/RlRCTfcQcS4PWz0NvSrtfDScWG3D
 8k2tNjA7lS4fmbF0H+nCwESWUomuWi0aGzNp+cJXVUjE6H0sTY
 CSAhmC9426uanGs3Ovepbq6JZlSgrXVzXr1SyJ5YxokgCb8pJz
 iMHCnttISbgzmVCcFrB5Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214131>

The test case "add (with different case)" indicates a
known breakage when run on a case insensitive file system.

The test is invalid for case sensitive file system, it will always fail=
=2E

Check the precondition CASE_INSENSITIVE_FS before running it.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
Changes since v1: Corrected and improved commit message
 t/t0050-filesystem.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
index ccd685d..a6fa3c5 100755
--- a/t/t0050-filesystem.sh
+++ b/t/t0050-filesystem.sh
@@ -88,7 +88,7 @@ test_expect_success 'merge (case change)' '
=20
=20
=20
-test_expect_failure 'add (with different case)' '
+test_expect_failure CASE_INSENSITIVE_FS 'add (with different case)' '
=20
 	git reset --hard initial &&
 	rm camelcase &&
--=20
1.8.0.197.g5a90748
