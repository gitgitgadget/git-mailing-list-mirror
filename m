From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 01/12] dir.c: rename cryptic 'which' variable to more consistent name
Date: Mon, 15 Oct 2012 13:27:55 +0700
Message-ID: <1350282486-4646-1-git-send-email-pclouds@gmail.com>
References: <1350282212-4270-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Adam Spiers <git@adamspiers.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 08:28:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNeAE-0000UO-Oj
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 08:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754006Ab2JOG2Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Oct 2012 02:28:24 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:60685 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753976Ab2JOG2X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 02:28:23 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so4626454pbb.19
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 23:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=1+pymS0gykOWCcG/DWbGD8AltT0QDqQApECBkaqtOzQ=;
        b=VXycDeW78lmQo2C2DECXok7nLxxcWs44x7+XhJolR1EEQjXYkpL0lLpVv4bKnXnSgS
         B5M8X/otphfXVndwl9d3GpZ+lDuX6LjKcaYVWm3Tz2a4y2ocDUyKPVqlQ+SzZUrnTSv8
         ESWlF1mOGzVf0GQ0XfRjxchltMRWGirPAMFmwWKBLoAhgsE+TFLiMwkoA8ZUStsy8YZh
         f12UyMHUOYtOmq3boXy96AvnuWxvVKV3F3AtZFY8nVXy5YyesAcfFISAqoaDf+zxGMjW
         ZrO07tElPAr0+/Y+sm6G18/Yh0nmSnFjngHtuF0zA8gcuKcVW0yBmE+I6EjDuB+lUHh4
         qLQg==
Received: by 10.68.252.133 with SMTP id zs5mr34245577pbc.152.1350282503329;
        Sun, 14 Oct 2012 23:28:23 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id pi1sm8584353pbb.7.2012.10.14.23.28.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Oct 2012 23:28:22 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 15 Oct 2012 13:28:13 +0700
X-Mailer: git-send-email 1.8.0.rc0.29.g1fdd78f
In-Reply-To: <1350282212-4270-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207712>

=46rom: Adam Spiers <git@adamspiers.org>

'el' is only *slightly* less cryptic, but is already used as the
variable name for a struct exclude_list pointer in numerous other
places, so this reduces the number of cryptic variable names in use by
one :-)

Signed-off-by: Adam Spiers <git@adamspiers.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c | 10 +++++-----
 dir.h |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/dir.c b/dir.c
index ee8e711..f7219b5 100644
--- a/dir.c
+++ b/dir.c
@@ -347,7 +347,7 @@ void parse_exclude_pattern(const char **pattern,
 }
=20
 void add_exclude(const char *string, const char *base,
-		 int baselen, struct exclude_list *which)
+		 int baselen, struct exclude_list *el)
 {
 	struct exclude *x;
 	int patternlen;
@@ -371,8 +371,8 @@ void add_exclude(const char *string, const char *ba=
se,
 	x->base =3D base;
 	x->baselen =3D baselen;
 	x->flags =3D flags;
-	ALLOC_GROW(which->excludes, which->nr + 1, which->alloc);
-	which->excludes[which->nr++] =3D x;
+	ALLOC_GROW(el->excludes, el->nr + 1, el->alloc);
+	el->excludes[el->nr++] =3D x;
 }
=20
 static void *read_skip_worktree_file_from_index(const char *path, size=
_t *size)
@@ -414,7 +414,7 @@ int add_excludes_from_file_to_list(const char *fnam=
e,
 				   const char *base,
 				   int baselen,
 				   char **buf_p,
-				   struct exclude_list *which,
+				   struct exclude_list *el,
 				   int check_index)
 {
 	struct stat st;
@@ -461,7 +461,7 @@ int add_excludes_from_file_to_list(const char *fnam=
e,
 		if (buf[i] =3D=3D '\n') {
 			if (entry !=3D buf + i && entry[0] !=3D '#') {
 				buf[i - (i && buf[i-1] =3D=3D '\r')] =3D 0;
-				add_exclude(entry, base, baselen, which);
+				add_exclude(entry, base, baselen, el);
 			}
 			entry =3D buf + i + 1;
 		}
diff --git a/dir.h b/dir.h
index f5c89e3..69cc7d2 100644
--- a/dir.h
+++ b/dir.h
@@ -105,11 +105,11 @@ extern int path_excluded(struct path_exclude_chec=
k *, const char *, int namelen,
=20
=20
 extern int add_excludes_from_file_to_list(const char *fname, const cha=
r *base, int baselen,
-					  char **buf_p, struct exclude_list *which, int check_index);
+					  char **buf_p, struct exclude_list *el, int check_index);
 extern void add_excludes_from_file(struct dir_struct *, const char *fn=
ame);
 extern void parse_exclude_pattern(const char **string, int *patternlen=
, int *flags, int *nowildcardlen);
 extern void add_exclude(const char *string, const char *base,
-			int baselen, struct exclude_list *which);
+			int baselen, struct exclude_list *el);
 extern void free_excludes(struct exclude_list *el);
 extern int file_exists(const char *);
=20
--=20
1.8.0.rc0.29.g1fdd78f
