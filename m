From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH 2/3] t0050: honor CASE_INSENSITIVE_FS in add (with different case)
Date: Sat, 19 Jan 2013 08:19:29 +0100
Message-ID: <201301190819.29767.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 19 08:19:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwSib-0003m7-Rr
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jan 2013 08:19:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219Ab3ASHTg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Jan 2013 02:19:36 -0500
Received: from mout.web.de ([212.227.15.4]:55030 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750878Ab3ASHTg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Jan 2013 02:19:36 -0500
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0MRl2f-1TU5yI0ha5-00TRum; Sat, 19 Jan 2013 08:19:35 +0100
X-Provags-ID: V02:K0:EdAk5oiHPVLzFHrwweSzCvswgemC9PWE/plUWqszgYn
 fZSH7FbAhfSwi32EddY6muw0I3rmlr14GyRw8UrNyVEMrtJO76
 PnnmsQObtEHWkjREi6n1UZeILkTb9WcUKhGW1Be4JfMgbyJrgz
 ZS/R1nnbOkjwHF5p2XpsvOpc+aHukySv8GRgZMbG8dKAHRKCro
 8mY2ZhuC7nIMqbublr9xw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213959>

The test case "add (with different case)" indicates a
known breakage when run on a case sensitive file system.

The test is invalid for case sensitive file system,
check the precondition CASE_INSENSITIVE_FS before running it.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
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
