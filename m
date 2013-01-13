From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 31/31] Rename field "raw" to "_raw" in struct pathspec
Date: Sun, 13 Jan 2013 19:35:39 +0700
Message-ID: <1358080539-17436-32-git-send-email-pclouds@gmail.com>
References: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 13 13:39:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuMqm-0000To-1O
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 13:39:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755219Ab3AMMjX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2013 07:39:23 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33977 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755188Ab3AMMjW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 07:39:22 -0500
Received: by mail-pa0-f45.google.com with SMTP id bg2so1760766pad.18
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 04:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=5F95boL1hiWWq2VRzuvsjWY3d0dI7TslfHzZEi0zPWU=;
        b=ZaOOlHtBy+/44LCdSEYBdev9ETWHaF7HAB3PPCsIb4xNx9F7UJrL0Hb85NV+k3L9Vn
         ww5+NyEqb4Ir4TX3jfThSVOYpp29Cbd4WDXDZLVGJmETheF3BNZQLt49SImtVZEpPiT9
         shBqJkg5LP0f8Xp/3bL7Kf+l9ppHfE6SF4J/qAvWrASMLroxz5HoIQ0K0JsrvEASFzHK
         rSp3/WCCKuJnOZobKSISEkD4NR6ijhm+IQsJPDsFNSjBVnm3dDFlGZAw4MCoTU3q4ZZJ
         722LJJp+hF7Dt95dlCaev7Ji6enSZO/KCXsttevme6g43zLqIsGSxxW0N3lEnO1eZhPl
         3nuw==
X-Received: by 10.66.83.136 with SMTP id q8mr223197306pay.83.1358080762092;
        Sun, 13 Jan 2013 04:39:22 -0800 (PST)
Received: from lanh ([115.74.52.72])
        by mx.google.com with ESMTPS id pj1sm6285689pbb.71.2013.01.13.04.39.19
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 04:39:21 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jan 2013 19:39:36 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213371>

This patch is essentially no-op. It helps catching new use of this
field though. This field is introduced as an intermediate step for the
pathspec conversion and will be removed eventually. At this stage no
more access sites should be introduced.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 archive.c          | 2 +-
 builtin/add.c      | 2 +-
 builtin/checkout.c | 2 +-
 builtin/ls-tree.c  | 2 +-
 cache.h            | 2 +-
 dir.c              | 4 ++--
 setup.c            | 6 +++---
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/archive.c b/archive.c
index ef50d49..d9da58b 100644
--- a/archive.c
+++ b/archive.c
@@ -236,7 +236,7 @@ static void parse_pathspec_arg(const char **pathspe=
c,
 	 */
 	parse_pathspec(&ar_args->pathspec, PATHSPEC_FROMTOP, 0, "", pathspec)=
;
 	if (ar_args->pathspec.nr) {
-		pathspec =3D ar_args->pathspec.raw;
+		pathspec =3D ar_args->pathspec._raw;
 		while (*pathspec) {
 			if (!path_exists(ar_args->tree, *pathspec))
 				die("path not found: %s", *pathspec);
diff --git a/builtin/add.c b/builtin/add.c
index 9edab95..a7840c8 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -209,7 +209,7 @@ int interactive_add(int argc, const char **argv, co=
nst char *prefix, int patch)
=20
 	return run_add_interactive(NULL,
 				   patch ? "--patch" : NULL,
-				   pathspec.raw);
+				   pathspec._raw);
 }
=20
 static int edit_patch(int argc, const char **argv, const char *prefix)
diff --git a/builtin/checkout.c b/builtin/checkout.c
index d2fc996..1b413e2 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -253,7 +253,7 @@ static int checkout_paths(const struct checkout_opt=
s *opts,
=20
 	if (opts->patch_mode)
 		return run_add_interactive(revision, "--patch=3Dcheckout",
-					   opts->pathspec.raw);
+					   opts->pathspec._raw);
=20
 	lock_file =3D xcalloc(1, sizeof(struct lock_file));
=20
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index e03aaaf..58899a5 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -35,7 +35,7 @@ static int show_recursive(const char *base, int basel=
en, const char *pathname)
 	if (ls_options & LS_RECURSIVE)
 		return 1;
=20
-	s =3D pathspec.raw;
+	s =3D pathspec._raw;
 	if (!s)
 		return 0;
=20
diff --git a/cache.h b/cache.h
index 13cc217..c7a8d28 100644
--- a/cache.h
+++ b/cache.h
@@ -482,7 +482,7 @@ extern int ie_modified(const struct index_state *, =
struct cache_entry *, struct
 #define PATHSPEC_ONESTAR 1	/* the pathspec pattern sastisfies GFNM_ONE=
STAR */
=20
 struct pathspec {
-	const char **raw; /* get_pathspec() result, not freed by free_pathspe=
c() */
+	const char **_raw; /* get_pathspec() result, not freed by free_pathsp=
ec() */
 	int nr;
 	unsigned int has_wildcard:1;
 	unsigned int recursive:1;
diff --git a/dir.c b/dir.c
index 2a1bcb8..efc676c 100644
--- a/dir.c
+++ b/dir.c
@@ -108,7 +108,7 @@ int fill_directory(struct dir_struct *dir, const st=
ruct pathspec *pathspec)
 	len =3D common_prefix_len(pathspec);
=20
 	/* Read the directory and prune it */
-	read_directory(dir, pathspec->nr ? pathspec->raw[0] : "", len, pathsp=
ec);
+	read_directory(dir, pathspec->nr ? pathspec->_raw[0] : "", len, paths=
pec);
 	return len;
 }
=20
@@ -1235,7 +1235,7 @@ int read_directory(struct dir_struct *dir, const =
char *path, int len, const stru
 	if (has_symlink_leading_path(path, len))
 		return dir->nr;
=20
-	simplify =3D create_simplify(pathspec ? pathspec->raw : NULL);
+	simplify =3D create_simplify(pathspec ? pathspec->_raw : NULL);
 	if (!len || treat_leading_path(dir, path, len, simplify))
 		read_directory_recursive(dir, path, len, 0, simplify);
 	free_simplify(simplify);
diff --git a/setup.c b/setup.c
index b6f419d..69ca047 100644
--- a/setup.c
+++ b/setup.c
@@ -332,7 +332,7 @@ void parse_pathspec(struct pathspec *pathspec,
 		raw[0] =3D prefix;
 		raw[1] =3D NULL;
 		pathspec->nr =3D 1;
-		pathspec->raw =3D raw;
+		pathspec->_raw =3D raw;
 		return;
 	}
=20
@@ -342,7 +342,7 @@ void parse_pathspec(struct pathspec *pathspec,
=20
 	pathspec->nr =3D n;
 	pathspec->items =3D item =3D xmalloc(sizeof(*item) * n);
-	pathspec->raw =3D argv;
+	pathspec->_raw =3D argv;
 	prefixlen =3D prefix ? strlen(prefix) : 0;
=20
 	for (i =3D 0; i < n; i++) {
@@ -372,7 +372,7 @@ const char **get_pathspec(const char *prefix, const=
 char **pathspec)
 {
 	struct pathspec ps;
 	parse_pathspec(&ps, PATHSPEC_FROMTOP, 0, prefix, pathspec);
-	return ps.raw;
+	return ps._raw;
 }
=20
 /*
--=20
1.8.0.rc2.23.g1fb49df
