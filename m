From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH WIP 1/3] diff-no-index: rename read_directory to avoid conflict from dir.h
Date: Wed,  5 Oct 2011 18:18:06 +1100
Message-ID: <1317799088-26626-2-git-send-email-pclouds@gmail.com>
References: <1317799088-26626-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 05 09:18:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBLkY-00055n-Et
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 09:18:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757833Ab1JEHSh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Oct 2011 03:18:37 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:54296 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755809Ab1JEHSg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 03:18:36 -0400
Received: by yxl31 with SMTP id 31so1292462yxl.19
        for <git@vger.kernel.org>; Wed, 05 Oct 2011 00:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Z3s7k3jpA3mrdZ7hv2oOFhjw5ZDK2vbNX9F5dRm4Ws4=;
        b=vfx1yIHA50dligqr2rgtSiS+89g1RnCYtMlXaA6gmw9AXy+gPiGDLpoukCBAe7atnb
         Qnp0TAS2VUUJQ/mv/AcmCouTz0TC7nXjm5gJ96uNbQImdCJfWwBE+qCG0BlDhtbc6RPi
         J2w9hEpl535dp42XtH2b1MHjNaDfH3f0v8p+o=
Received: by 10.236.155.1 with SMTP id i1mr12010061yhk.8.1317799116200;
        Wed, 05 Oct 2011 00:18:36 -0700 (PDT)
Received: from pclouds@gmail.com (220-244-161-237.static.tpgi.com.au. [220.244.161.237])
        by mx.google.com with ESMTPS id o48sm1217486yhl.4.2011.10.05.00.18.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 05 Oct 2011 00:18:35 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 05 Oct 2011 18:18:22 +1100
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1317799088-26626-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182831>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 diff-no-index.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 3a36144..927abb7 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -16,7 +16,7 @@
 #include "builtin.h"
 #include "string-list.h"
=20
-static int read_directory(const char *path, struct string_list *list)
+static int read_entire_directory(const char *path, struct string_list =
*list)
 {
 	DIR *dir;
 	struct dirent *e;
@@ -68,9 +68,9 @@ static int queue_diff(struct diff_options *o,
 		struct string_list p2 =3D STRING_LIST_INIT_DUP;
 		int len1 =3D 0, len2 =3D 0, i1, i2, ret =3D 0;
=20
-		if (name1 && read_directory(name1, &p1))
+		if (name1 && read_entire_directory(name1, &p1))
 			return -1;
-		if (name2 && read_directory(name2, &p2)) {
+		if (name2 && read_entire_directory(name2, &p2)) {
 			string_list_clear(&p1, 0);
 			return -1;
 		}
--=20
1.7.3.1.256.g2539c.dirty
