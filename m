From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 04/25] copy.c: delete unused code in copy_file()
Date: Wed, 13 Apr 2016 20:15:25 +0700
Message-ID: <1460553346-12985-5-git-send-email-pclouds@gmail.com>
References: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 15:16:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqKeZ-00040O-CK
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 15:16:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760604AbcDMNQP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2016 09:16:15 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:33738 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759970AbcDMNQO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 09:16:14 -0400
Received: by mail-pa0-f67.google.com with SMTP id vv3so3899540pab.0
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 06:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N998MSB9xpn3CDHmxjLdkPXl9vqNt1DS14RfiOm38qU=;
        b=DZypTwlqIgwIaUvl8O2aIziFme+mqj5q1TE5zs11/qmge3Y+EsCgDHJ0MVXPPlopAP
         ZQaKVyc//czmznzyc+8FMs3CS9GwWVpJJXOUvLon3/FEzPSbwzTSWHvU6wVzPaWqlGU9
         +iRNoo4wcdwQXbUbvyr5qqttrcJ6SWrgCGcMjKUoBdnOwj8WNhhmqbxjOZcnwY1t6DVp
         FsoONI/7E2U9dXJC4XR8vudcKYBWJklxl10NZuj4pbptQhrz89LWAtbO0TtbSxVyFmar
         fVofRPOFz7hIi87owBNL01jjzSiC7NPjZwHRcer3R599Ob+OZhzvw2g+SZJxeYu7VNMk
         sGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N998MSB9xpn3CDHmxjLdkPXl9vqNt1DS14RfiOm38qU=;
        b=TkUmeFhmM5miraBhEKLyYUlsl+NQxN8iPKrQfxwnadpUPasqSC2IY7CajPxO419UlR
         THUHdsUsw3CpneU3R76d2bjszuGNUcicLQbnsQxlP7ijAIowgRif66mAYWQWMR1eUYMn
         24Ta2WZZz9V29ldbh8HQt5bo5ZQz9I3KvqjtfIxyfqZBxzD2OD8kKxS34xdtKTir7hAp
         ZG8KSgAK7NECrywkd2zyd+bqxFWLps5VgHNLL3PSFod0EEw2kTCtANP5rVzh6oyUEy7w
         6suufLDnVLvMS5C2BSM8o5ViqSy8H15ONewgobSxDQwd6MALstdxo0gXCGIF5d+neN/C
         5DYg==
X-Gm-Message-State: AOPr4FVYohOVOw6sZ5miBthKOfFDCdXHW/D63S7TBWV/D+Rd61HCL8Lak2B+6B2z3bSY+w==
X-Received: by 10.66.62.232 with SMTP id b8mr12782716pas.104.1460553368500;
        Wed, 13 Apr 2016 06:16:08 -0700 (PDT)
Received: from lanh ([115.76.233.41])
        by smtp.gmail.com with ESMTPSA id l14sm51171558pfi.23.2016.04.13.06.16.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2016 06:16:07 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Apr 2016 20:16:14 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291425>

 - selinux preservation code
 - make-link code
 - delete link dereference code
 - non-recursive copy code
 - stat no preservation code
 - verbose printing code

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 copy.c | 101 +++++----------------------------------------------------=
--------
 1 file changed, 7 insertions(+), 94 deletions(-)

diff --git a/copy.c b/copy.c
index 29e9d5b..d24a8ae 100644
--- a/copy.c
+++ b/copy.c
@@ -82,14 +82,7 @@ int FAST_FUNC copy_file(const char *source, const ch=
ar *dest, int flags)
 	smallint dest_exists =3D 0;
 	smallint ovr;
=20
-/* Inverse of cp -d ("cp without -d") */
-#define FLAGS_DEREF (flags & (FILEUTILS_DEREFERENCE + FILEUTILS_DEREFE=
RENCE_L0))
-
-	if ((FLAGS_DEREF ? stat : lstat)(source, &source_stat) < 0) {
-		/* This may be a dangling symlink.
-		 * Making [sym]links to dangling symlinks works, so... */
-		if (flags & (FILEUTILS_MAKE_SOFTLINK|FILEUTILS_MAKE_HARDLINK))
-			goto make_links;
+	if (lstat(source, &source_stat) < 0) {
 		bb_perror_msg("can't stat '%s'", source);
 		return -1;
 	}
@@ -109,35 +102,12 @@ int FAST_FUNC copy_file(const char *source, const=
 char *dest, int flags)
 		dest_exists =3D 1;
 	}
=20
-#if ENABLE_SELINUX
-	if ((flags & FILEUTILS_PRESERVE_SECURITY_CONTEXT) && is_selinux_enabl=
ed() > 0) {
-		security_context_t con;
-		if (lgetfilecon(source, &con) >=3D 0) {
-			if (setfscreatecon(con) < 0) {
-				bb_perror_msg("can't set setfscreatecon %s", con);
-				freecon(con);
-				return -1;
-			}
-		} else if (errno =3D=3D ENOTSUP || errno =3D=3D ENODATA) {
-			setfscreatecon_or_die(NULL);
-		} else {
-			bb_perror_msg("can't lgetfilecon %s", source);
-			return -1;
-		}
-	}
-#endif
-
 	if (S_ISDIR(source_stat.st_mode)) {
 		DIR *dp;
 		const char *tp;
 		struct dirent *d;
 		mode_t saved_umask =3D 0;
=20
-		if (!(flags & FILEUTILS_RECUR)) {
-			bb_error_msg("omitting directory '%s'", source);
-			return -1;
-		}
-
 		/* Did we ever create source ourself before? */
 		tp =3D is_in_ino_dev_hashtable(&source_stat);
 		if (tp) {
@@ -160,8 +130,6 @@ int FAST_FUNC copy_file(const char *source, const c=
har *dest, int flags)
 			saved_umask =3D umask(0);
=20
 			mode =3D source_stat.st_mode;
-			if (!(flags & FILEUTILS_PRESERVE_STATUS))
-				mode =3D source_stat.st_mode & ~saved_umask;
 			/* Allow owner to access new dir (at least for now) */
 			mode |=3D S_IRWXU;
 			if (mkdir(dest, mode) < 0) {
@@ -210,45 +178,17 @@ int FAST_FUNC copy_file(const char *source, const=
 char *dest, int flags)
 		goto preserve_mode_ugid_time;
 	}
=20
-	if (flags & (FILEUTILS_MAKE_SOFTLINK|FILEUTILS_MAKE_HARDLINK)) {
-		int (*lf)(const char *oldpath, const char *newpath);
- make_links:
-		/* Hmm... maybe
-		 * if (DEREF && MAKE_SOFTLINK) source =3D realpath(source) ?
-		 * (but realpath returns NULL on dangling symlinks...) */
-		lf =3D (flags & FILEUTILS_MAKE_SOFTLINK) ? symlink : link;
-		if (lf(source, dest) < 0) {
-			ovr =3D ask_and_unlink(dest, flags);
-			if (ovr <=3D 0)
-				return ovr;
-			if (lf(source, dest) < 0) {
-				bb_perror_msg("can't create link '%s'", dest);
-				return -1;
-			}
-		}
-		/* _Not_ jumping to preserve_mode_ugid_time:
-		 * (sym)links don't have those */
-		return 0;
-	}
-
-	if (/* "cp thing1 thing2" without -R: just open and read() from thing=
1 */
-	    !(flags & FILEUTILS_RECUR)
-	    /* "cp [-opts] regular_file thing2" */
-	 || S_ISREG(source_stat.st_mode)
-	 /* DEREF uses stat, which never returns S_ISLNK() =3D=3D true.
-	  * So the below is never true: */
-	 /* || (FLAGS_DEREF && S_ISLNK(source_stat.st_mode)) */
-	) {
+	if (S_ISREG(source_stat.st_mode) ) { /* "cp [-opts] regular_file thin=
g2" */
 		int src_fd;
 		int dst_fd;
 		mode_t new_mode;
=20
-		if (!FLAGS_DEREF && S_ISLNK(source_stat.st_mode)) {
+		if (S_ISLNK(source_stat.st_mode)) {
 			/* "cp -d symlink dst": create a link */
 			goto dont_cat;
 		}
=20
-		if (ENABLE_FEATURE_PRESERVE_HARDLINKS && !FLAGS_DEREF) {
+		if (ENABLE_FEATURE_PRESERVE_HARDLINKS) {
 			const char *link_target;
 			link_target =3D is_in_ino_dev_hashtable(&source_stat);
 			if (link_target) {
@@ -295,25 +235,6 @@ int FAST_FUNC copy_file(const char *source, const =
char *dest, int flags)
 			}
 		}
=20
-#if ENABLE_SELINUX
-		if ((flags & (FILEUTILS_PRESERVE_SECURITY_CONTEXT|FILEUTILS_SET_SECU=
RITY_CONTEXT))
-		 && is_selinux_enabled() > 0
-		) {
-			security_context_t con;
-			if (getfscreatecon(&con) =3D=3D -1) {
-				bb_perror_msg("getfscreatecon");
-				return -1;
-			}
-			if (con) {
-				if (setfilecon(dest, con) =3D=3D -1) {
-					bb_perror_msg("setfilecon:%s,%s", dest, con);
-					freecon(con);
-					return -1;
-				}
-				freecon(con);
-			}
-		}
-#endif
 		if (bb_copyfd_eof(src_fd, dst_fd) =3D=3D -1)
 			retval =3D -1;
 		/* Careful with writing... */
@@ -348,9 +269,8 @@ int FAST_FUNC copy_file(const char *source, const c=
har *dest, int flags)
 				bb_perror_msg("can't create symlink '%s'", dest);
 				return -1;
 			}
-			if (flags & FILEUTILS_PRESERVE_STATUS)
-				if (lchown(dest, source_stat.st_uid, source_stat.st_gid) < 0)
-					bb_perror_msg("can't preserve %s of '%s'", "ownership", dest);
+			if (lchown(dest, source_stat.st_uid, source_stat.st_gid) < 0)
+				bb_perror_msg("can't preserve %s of '%s'", "ownership", dest);
 		}
 		/* _Not_ jumping to preserve_mode_ugid_time:
 		 * symlinks don't have those */
@@ -370,10 +290,7 @@ int FAST_FUNC copy_file(const char *source, const =
char *dest, int flags)
=20
  preserve_mode_ugid_time:
=20
-	if (flags & FILEUTILS_PRESERVE_STATUS
-	/* Cannot happen: */
-	/* && !(flags & (FILEUTILS_MAKE_SOFTLINK|FILEUTILS_MAKE_HARDLINK)) */
-	) {
+	if (1 /*FILEUTILS_PRESERVE_STATUS*/) {
 		struct timeval times[2];
=20
 		times[1].tv_sec =3D times[0].tv_sec =3D source_stat.st_mtime;
@@ -389,10 +306,6 @@ int FAST_FUNC copy_file(const char *source, const =
char *dest, int flags)
 			bb_perror_msg("can't preserve %s of '%s'", "permissions", dest);
 	}
=20
-	if (flags & FILEUTILS_VERBOSE) {
-		printf("'%s' -> '%s'\n", source, dest);
-	}
-
 	return retval;
 }
 #endif
--=20
2.8.0.rc0.210.gd302cd2
