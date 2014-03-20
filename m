From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/8] ls_colors.c: new color descriptors
Date: Thu, 20 Mar 2014 17:15:47 +0700
Message-ID: <1395310551-23201-5-git-send-email-pclouds@gmail.com>
References: <1395310551-23201-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 20 11:16:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQa1C-00018k-7B
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 11:16:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbaCTKQE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Mar 2014 06:16:04 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:53355 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755217AbaCTKQC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 06:16:02 -0400
Received: by mail-pd0-f173.google.com with SMTP id z10so714951pdj.18
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 03:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=jZiy5ws1wNrpivRBOcJCgFlAzb1OFcJcCxlXwfz6+7o=;
        b=TnLpqXSz1GwJqqVf8XFnNsfEJDaJwGzJXUlB3Hni1sTu5aOiSaHBqwxWEE4CORv8ii
         0AVf1oYjZ4ooPDidE9Tso26+eMMl+h3sVby/vOhVyEQLIQcgwmBB6GwbUX4PIM7AXjRS
         SRLcFP3dwTb/j45xk+SdjoBvj7jRbyTZIQLm1dXhe6pyA8khQmJHMw2MB/V/HwIFKvdx
         JhwoUM0w6goebPPUCMYtH7IrZ75mCEkO4PDW9yk3euHDGK7yd1ptPDfT0LhiEP8po2bd
         lyj6wSaSIG3vXp4BGQREWW1lw1a6MzmOzZrEPTjoDfyfqNfuxvT7npl40Jekvzf9FS2x
         tltw==
X-Received: by 10.68.170.36 with SMTP id aj4mr47249380pbc.54.1395310562134;
        Thu, 20 Mar 2014 03:16:02 -0700 (PDT)
Received: from lanh ([115.73.251.167])
        by mx.google.com with ESMTPSA id dk1sm2958035pbc.46.2014.03.20.03.15.59
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 20 Mar 2014 03:16:01 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 20 Mar 2014 17:16:49 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1395310551-23201-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244535>

After coreutils moved to GPL-3 a couple more color descriptors were
added. parse_ls_color() will abort if it finds any of these so just
add them recognized (but never actually use them).

Reference commits (in coreutils.git)

0df338f (ls --color: do not colorize files with multiple hard links by =
default - 2009-06-10)
adc62b5 (ls: clean up after wrapped+colored file names with clear-to-EO=
L - 2008-12-31)
1e48b1f (ls: --color now highlights hard linked files, too - 2008-10-27=
)
84f6abf (ls: --color now highlights files with capabilities, too - 2008=
-08-01)
483297d (ls --color no longer outputs unnecessary escape sequences - 20=
08-02-12)

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 ls_colors.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/ls_colors.c b/ls_colors.c
index 23f1e0b..02fc632 100644
--- a/ls_colors.c
+++ b/ls_colors.c
@@ -5,9 +5,12 @@
 #define STREQ(a, b) (strcmp(a, b) =3D=3D 0)
=20
 enum indicator_no {
-	C_LEFT, C_RIGHT, C_END, C_NORM, C_FILE, C_DIR, C_LINK, C_FIFO, C_SOCK=
,
+	C_LEFT, C_RIGHT, C_END, C_RESET, C_NORM,
+	C_FILE, C_DIR, C_LINK, C_FIFO, C_SOCK,
 	C_BLK, C_CHR, C_MISSING, C_ORPHAN, C_EXEC, C_DOOR, C_SETUID, C_SETGID=
,
-	C_STICKY, C_OTHER_WRITABLE, C_STICKY_OTHER_WRITABLE
+	C_STICKY, C_OTHER_WRITABLE, C_STICKY_OTHER_WRITABLE,
+	C_CAP, C_MULTIHARDLINK, C_CLR_TO_EOL
+
 };
=20
 #define FILETYPE_INDICATORS				\
@@ -28,9 +31,9 @@ struct color_ext_type {
 };
=20
 static const char *const indicator_name[]=3D {
-	"lc", "rc", "ec", "no", "fi", "di", "ln", "pi", "so",
+	"lc", "rc", "ec", "rs", "no", "fi", "di", "ln", "pi", "so",
 	"bd", "cd", "mi", "or", "ex", "do", "su", "sg", "st",
-	"ow", "tw", NULL
+	"ow", "tw", "ca", "mh", "cl", NULL
 };
=20
 #define LEN_STR_PAIR(s) sizeof(s) - 1, s
@@ -38,6 +41,7 @@ static struct bin_str color_indicator[] =3D {
 	{ LEN_STR_PAIR("\033[") },	/* lc: Left of color sequence */
 	{ LEN_STR_PAIR("m") },		/* rc: Right of color sequence */
 	{ 0, NULL },			/* ec: End color (replaces lc+no+rc) */
+	{ 0, NULL },			/* rs: Reset to ordinary colors */
 	{ LEN_STR_PAIR("0") },		/* no: Normal */
 	{ LEN_STR_PAIR("0") },		/* fi: File: default */
 	{ LEN_STR_PAIR("01;34") },	/* di: Directory: bright blue */
@@ -55,6 +59,9 @@ static struct bin_str color_indicator[] =3D {
 	{ LEN_STR_PAIR("37;44") },	/* st: sticky: black on blue */
 	{ LEN_STR_PAIR("34;42") },	/* ow: other-writable: blue on green */
 	{ LEN_STR_PAIR("30;42") },	/* tw: ow w/ sticky: black on green */
+	{ 0, NULL },			/* ca: black on red */
+	{ 0, NULL },			/* mh: disabled by default */
+	{ 0, NULL },			/* cl: clear to end of line */
 };
=20
 static struct color_ext_type *color_ext_list =3D NULL;
--=20
1.9.0.40.gaa8c3ea
