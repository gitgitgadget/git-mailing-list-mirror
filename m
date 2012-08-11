From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] i18n: mark progress strings for translation
Date: Sat, 11 Aug 2012 18:25:04 +0700
Message-ID: <1344684304-22425-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 11 13:26:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T09pq-0005go-LG
	for gcvg-git-2@plane.gmane.org; Sat, 11 Aug 2012 13:26:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754198Ab2HKL0T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Aug 2012 07:26:19 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:59532 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754038Ab2HKL0S (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2012 07:26:18 -0400
Received: by pbbrr13 with SMTP id rr13so4276953pbb.19
        for <git@vger.kernel.org>; Sat, 11 Aug 2012 04:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=wBc3YbO8i5m9QHoEWWHVWyx99GZtPTYzrmpp/Br++04=;
        b=GHOqpG1fJOlz6jYPc3D9StKhUQjMHvkNfz36H/Py+9A0MWBptNE/EBOLOQ8jMV9mPv
         Wj3+IuKAMRTa2yffPt+UGXrHVdCz+7AKYOMyh8+Be4NPSZTVU+Ww5sqRBAEONuFY99/A
         8zo3yUpTuGwnjRp8npd6BzHfJsB0dq+h0e6eiYlcxzf2eP4TLJQuWRmR2Xonqyv5JbzT
         EX+euJX0b3Ri3LiBKYBO6eGij1qk6LnToDsv+6P3dJRA9kpHkK9daoyAYk2zmF/TgtaX
         hjwCtRbm9YkhfLSb1cSMJkAedcN+J5v43KkGZIsoVvH7LxwOG0q8QKN/P5MKAh28vDoe
         FjBg==
Received: by 10.68.228.231 with SMTP id sl7mr6109474pbc.45.1344684378434;
        Sat, 11 Aug 2012 04:26:18 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.55.147])
        by mx.google.com with ESMTPS id rd7sm1229211pbc.70.2012.08.11.04.26.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 11 Aug 2012 04:26:17 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 11 Aug 2012 18:25:06 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203286>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 I know it's late in the cycle so let's queue it for the next one
 before I forget it.
=20
 I'm after the "done\n" in index-pack but we should also make it
 possible to translate units (especially "bytes" which is plural).
 There are ellipsis elsewhere in this file but I don't think it's
 worth translating.

 progress.c | 15 ++++++++-------
 1 t=E1=BA=ADp tin =C4=91=C3=A3 b=E1=BB=8B thay =C4=91=E1=BB=95i, 8 =C4=
=91=C6=B0=E1=BB=A3c th=C3=AAm v=C3=A0o(+), 7 b=E1=BB=8B x=C3=B3a(-)

diff --git a/progress.c b/progress.c
index 3971f49..b69d657 100644
--- a/progress.c
+++ b/progress.c
@@ -9,6 +9,7 @@
  */
=20
 #include "git-compat-util.h"
+#include "gettext.h"
 #include "progress.h"
=20
 #define TP_IDX_MAX      8
@@ -117,29 +118,29 @@ static void throughput_string(struct throughput *=
tp, off_t total,
 {
 	int l =3D sizeof(tp->display);
 	if (total > 1 << 30) {
-		l -=3D snprintf(tp->display, l, ", %u.%2.2u GiB",
+		l -=3D snprintf(tp->display, l, _(", %u.%2.2u GiB"),
 			      (int)(total >> 30),
 			      (int)(total & ((1 << 30) - 1)) / 10737419);
 	} else if (total > 1 << 20) {
 		int x =3D total + 5243;  /* for rounding */
-		l -=3D snprintf(tp->display, l, ", %u.%2.2u MiB",
+		l -=3D snprintf(tp->display, l, _(", %u.%2.2u MiB"),
 			      x >> 20, ((x & ((1 << 20) - 1)) * 100) >> 20);
 	} else if (total > 1 << 10) {
 		int x =3D total + 5;  /* for rounding */
-		l -=3D snprintf(tp->display, l, ", %u.%2.2u KiB",
+		l -=3D snprintf(tp->display, l, _(", %u.%2.2u KiB"),
 			      x >> 10, ((x & ((1 << 10) - 1)) * 100) >> 10);
 	} else {
-		l -=3D snprintf(tp->display, l, ", %u bytes", (int)total);
+		l -=3D snprintf(tp->display, l, _(", %u bytes"), (int)total);
 	}
=20
 	if (rate > 1 << 10) {
 		int x =3D rate + 5;  /* for rounding */
 		snprintf(tp->display + sizeof(tp->display) - l, l,
-			 " | %u.%2.2u MiB/s",
+			 _(" | %u.%2.2u MiB/s"),
 			 x >> 10, ((x & ((1 << 10) - 1)) * 100) >> 10);
 	} else if (rate)
 		snprintf(tp->display + sizeof(tp->display) - l, l,
-			 " | %u KiB/s", rate);
+			 _(" | %u KiB/s"), rate);
 }
=20
 void display_throughput(struct progress *progress, off_t total)
@@ -236,7 +237,7 @@ struct progress *start_progress(const char *title, =
unsigned total)
=20
 void stop_progress(struct progress **p_progress)
 {
-	stop_progress_msg(p_progress, "done");
+	stop_progress_msg(p_progress, _("done"));
 }
=20
 void stop_progress_msg(struct progress **p_progress, const char *msg)
--=20
1.7.12.rc2.18.g61b472e
