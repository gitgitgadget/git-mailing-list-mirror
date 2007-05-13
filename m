From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 3/3] Use "stg applied" instead of reading the applied
	file directly
Date: Sun, 13 May 2007 20:27:30 +0200
Message-ID: <20070513182730.18810.72629.stgit@yoghurt>
References: <20070513182720.18810.64330.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 13 20:37:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnIxC-0000KD-TO
	for gcvg-git@gmane.org; Sun, 13 May 2007 20:37:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757449AbXEMSh5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 13 May 2007 14:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757564AbXEMSh5
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 14:37:57 -0400
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:35294 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757449AbXEMSh4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 May 2007 14:37:56 -0400
Received: from c83-250-140-11.bredband.comhem.se ([83.250.140.11]:50795 helo=yoghurt)
	by ch-smtp01.sth.basefarm.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.66)
	(envelope-from <kha@treskal.com>)
	id 1HnIx8-0000eS-5s; Sun, 13 May 2007 20:37:55 +0200
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by yoghurt with esmtp (Exim 4.62)
	(envelope-from <kha@treskal.com>)
	id 1HnIn4-0004u7-P4; Sun, 13 May 2007 20:27:30 +0200
In-Reply-To: <20070513182720.18810.64330.stgit@yoghurt>
User-Agent: StGIT/0.12
X-Scan-Result: No virus found in message 1HnIx8-0000eS-5s.
X-Scan-Signature: ch-smtp01.sth.basefarm.net 1HnIx8-0000eS-5s 214abf0f99594110fc251c15ee09ad78
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47162>

=46rom: Karl Hasselstr=C3=B6m <kha@treskal.com>



Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
---

 t/t1500-float.sh |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t1500-float.sh b/t/t1500-float.sh
index dbcd8ce..814c9bd 100755
--- a/t/t1500-float.sh
+++ b/t/t1500-float.sh
@@ -20,37 +20,37 @@ test_expect_success \
 	 stg new F -m "f" && echo F >f.txt && stg add f.txt && stg refresh &&
 	 stg new G -m "g" && echo G >g.txt && stg add g.txt && stg refresh &&
 	 stg pop &&
-	 test "`echo \`cat .git/patches/master/applied\``" =3D "A B C D E F"
+	 test "$(echo $(stg applied))" =3D "A B C D E F"
 	'
=20
 test_expect_success \
 	'Float A to top' \
 	'stg float A &&
-	 test "`echo \`cat .git/patches/master/applied\``" =3D "B C D E F A"
+	 test "$(echo $(stg applied))" =3D "B C D E F A"
 	'
 test_expect_success \
 	'Float A to top (noop)' \
 	'stg float A &&
-	 test "`echo \`cat .git/patches/master/applied\``" =3D "B C D E F A"
+	 test "$(echo $(stg applied))" =3D "B C D E F A"
 	'
 test_expect_success \
 	'Float B C to top' \
 	'stg float B C &&
-	 test "`echo \`cat .git/patches/master/applied\``" =3D "D E F A B C"
+	 test "$(echo $(stg applied))" =3D "D E F A B C"
 	'
 test_expect_success \
 	'Float E A to top' \
 	'stg float E A &&
-	 test "`echo \`cat .git/patches/master/applied\``" =3D "D F B C E A"
+	 test "$(echo $(stg applied))" =3D "D F B C E A"
 	'
 test_expect_success \
 	'Float E to top' \
 	'stg float E &&
-	 test "`echo \`cat .git/patches/master/applied\``" =3D "D F B C A E"
+	 test "$(echo $(stg applied))" =3D "D F B C A E"
 	'
 test_expect_success \
 	'Float G F to top' \
 	'stg float G F &&
-	 test "`echo \`cat .git/patches/master/applied\``" =3D "D B C A E G F=
"
+	 test "$(echo $(stg applied))" =3D "D B C A E G F"
 	'
 test_done
