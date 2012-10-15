From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 04/12] dir.c: rename excluded() to is_excluded()
Date: Mon, 15 Oct 2012 13:27:58 +0700
Message-ID: <1350282486-4646-4-git-send-email-pclouds@gmail.com>
References: <1350282212-4270-1-git-send-email-pclouds@gmail.com>
 <1350282486-4646-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Adam Spiers <git@adamspiers.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 08:29:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNeAe-0000xP-4c
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 08:29:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754043Ab2JOG2t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Oct 2012 02:28:49 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:55849 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753976Ab2JOG2t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 02:28:49 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so4544170pad.19
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 23:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=PNVdLp7pA606+yhaHezdk0zsTnEdMH74k5FTuvV0f7Y=;
        b=PwXVqn46JeJwbT/jeP7vU8Spf2JnkXSESxC1ZQ3FLI7FmYnW7bSWykSvSDa3Auh4/g
         fsFmkvA6HbugEkJojHszxfyiO0XV837aM6OTdyGQY4HK4NaHk6t+slPwoCk4OqXnRfk/
         LiLaQHyrgyCU1ZD+x8HkzlKWvgxEJ4lgejE27GAup1Szppc14IhEOvLP5G74unXYb98d
         rspRE0oRpKBAZEs9zq3CkHxK5MZdeEmCmXJ2r6daHkejb733P0Gz0RZuHbLRBtt9zLud
         q5xiUahWootLyY0psQD4HUdOTwe8ggP5yvOAApv7MHaSDJt1FZZpFxwEpgNyWWokzoR1
         XK8w==
Received: by 10.68.138.229 with SMTP id qt5mr33873460pbb.122.1350282528698;
        Sun, 14 Oct 2012 23:28:48 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id yi9sm8232325pbc.39.2012.10.14.23.28.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 14 Oct 2012 23:28:47 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 15 Oct 2012 13:28:38 +0700
X-Mailer: git-send-email 1.8.0.rc0.29.g1fdd78f
In-Reply-To: <1350282486-4646-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207715>

=46rom: Adam Spiers <git@adamspiers.org>

Continue adopting clearer names for exclude functions.  This is_*
naming pattern for functions returning booleans was discussed here:

http://thread.gmane.org/gmane.comp.version-control.git/204661/focus=3D2=
04924

Signed-off-by: Adam Spiers <git@adamspiers.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 attr.c |  2 +-
 dir.c  | 10 +++++-----
 dir.h  |  4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/attr.c b/attr.c
index 2fc6353..5362563 100644
--- a/attr.c
+++ b/attr.c
@@ -284,7 +284,7 @@ static struct match_attr *parse_attr_line(const cha=
r *line, const char *src,
  * (reading the file from top to bottom), .gitattribute of the root
  * directory (again, reading the file from top to bottom) down to the
  * current directory, and then scan the list backwards to find the fir=
st match.
- * This is exactly the same as what excluded() does in dir.c to deal w=
ith
+ * This is exactly the same as what is_excluded() does in dir.c to dea=
l with
  * .gitignore
  */
=20
diff --git a/dir.c b/dir.c
index 7e1a23b..50381f8 100644
--- a/dir.c
+++ b/dir.c
@@ -639,7 +639,7 @@ int is_excluded_from_list(const char *pathname,
 	return -1; /* undecided */
 }
=20
-static int excluded(struct dir_struct *dir, const char *pathname, int =
*dtype_p)
+static int is_excluded(struct dir_struct *dir, const char *pathname, i=
nt *dtype_p)
 {
 	int pathlen =3D strlen(pathname);
 	int st;
@@ -689,7 +689,7 @@ int is_path_excluded(struct path_exclude_check *che=
ck,
 	/*
 	 * we allow the caller to pass namelen as an optimization; it
 	 * must match the length of the name, as we eventually call
-	 * excluded() on the whole name string.
+	 * is_excluded() on the whole name string.
 	 */
 	if (namelen < 0)
 		namelen =3D strlen(name);
@@ -706,7 +706,7 @@ int is_path_excluded(struct path_exclude_check *che=
ck,
=20
 		if (ch =3D=3D '/') {
 			int dt =3D DT_DIR;
-			if (excluded(check->dir, path->buf, &dt))
+			if (is_excluded(check->dir, path->buf, &dt))
 				return 1;
 		}
 		strbuf_addch(path, ch);
@@ -715,7 +715,7 @@ int is_path_excluded(struct path_exclude_check *che=
ck,
 	/* An entry in the index; cannot be a directory with subentries */
 	strbuf_setlen(path, 0);
=20
-	return excluded(check->dir, name, dtype);
+	return is_excluded(check->dir, name, dtype);
 }
=20
 static struct dir_entry *dir_entry_new(const char *pathname, int len)
@@ -1015,7 +1015,7 @@ static enum path_treatment treat_one_path(struct =
dir_struct *dir,
 					  const struct path_simplify *simplify,
 					  int dtype, struct dirent *de)
 {
-	int exclude =3D excluded(dir, path->buf, &dtype);
+	int exclude =3D is_excluded(dir, path->buf, &dtype);
 	if (exclude && (dir->flags & DIR_COLLECT_IGNORED)
 	    && exclude_matches_pathspec(path->buf, path->len, simplify))
 		dir_add_ignored(dir, path->buf, path->len);
diff --git a/dir.h b/dir.h
index 2fce4bf..4b887cc 100644
--- a/dir.h
+++ b/dir.h
@@ -91,8 +91,8 @@ extern int match_pathname(const char *, int,
 			  const char *, int, int, int);
=20
 /*
- * The excluded() API is meant for callers that check each level of le=
ading
- * directory hierarchies with excluded() to avoid recursing into exclu=
ded
+ * The is_excluded() API is meant for callers that check each level of=
 leading
+ * directory hierarchies with is_excluded() to avoid recursing into ex=
cluded
  * directories.  Callers that do not do so should use this API instead=
=2E
  */
 struct path_exclude_check {
--=20
1.8.0.rc0.29.g1fdd78f
