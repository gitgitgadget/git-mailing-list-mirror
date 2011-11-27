From: =?UTF-8?q?Jan=20St=C4=99pie=C5=84?= 
	<jstepien@users.sourceforge.net>
Subject: [PATCH] Remove redundant assignments
Date: Sun, 27 Nov 2011 09:05:42 +0100
Message-ID: <1322381142-20645-1-git-send-email-jstepien@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Jan=20St=C4=99pie=C5=84?= 
	<jstepien@users.sourceforge.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 27 09:14:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUZsy-0007oT-HF
	for gcvg-git-2@lo.gmane.org; Sun, 27 Nov 2011 09:14:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857Ab1K0IOp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Nov 2011 03:14:45 -0500
Received: from r245-52.iq.pl ([86.111.245.52]:54273 "EHLO stepien.cc"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751234Ab1K0IOo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Nov 2011 03:14:44 -0500
X-Greylist: delayed 513 seconds by postgrey-1.27 at vger.kernel.org; Sun, 27 Nov 2011 03:14:44 EST
Received: from jan-sl300-arch.warszawa.vectranet.pl (095160035162.warszawa.vectranet.pl [95.160.35.162])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by stepien.cc (Postfix) with ESMTPSA id 1548C2A10D2C;
	Sun, 27 Nov 2011 09:06:10 +0100 (CET)
X-Mailer: git-send-email 1.7.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185968>

There were two redundant variable assignments in transport.c and
wt-status.c. Removing them hasn't introduced any compiler warnings or
regressions.

Signed-off-by: Jan St=C4=99pie=C5=84 <jstepien@users.sourceforge.net>
---
 transport.c |    2 +-
 wt-status.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/transport.c b/transport.c
index 51814b5..5143718 100644
--- a/transport.c
+++ b/transport.c
@@ -105,7 +105,7 @@ static void insert_packed_refs(const char *packed_r=
efs, struct ref **list)
 		return;
=20
 	for (;;) {
-		int cmp =3D cmp, len;
+		int cmp, len;
=20
 		if (!fgets(buffer, sizeof(buffer), f)) {
 			fclose(f);
diff --git a/wt-status.c b/wt-status.c
index 70fdb76..35f61f4 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -229,7 +229,7 @@ static void wt_status_print_change_data(struct wt_s=
tatus *s,
 {
 	struct wt_status_change_data *d =3D it->util;
 	const char *c =3D color(change_type, s);
-	int status =3D status;
+	int status;
 	char *one_name;
 	char *two_name;
 	const char *one, *two;
--=20
1.7.7.4
