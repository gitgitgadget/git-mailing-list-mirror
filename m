From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [RFC PATCH v4 10/19] dir.c: export excluded_1() and add_excludes_from_file_1()
Date: Thu, 20 Aug 2009 20:47:04 +0700
Message-ID: <1250776033-12395-11-git-send-email-pclouds@gmail.com>
References: <1250776033-12395-1-git-send-email-pclouds@gmail.com>
 <1250776033-12395-2-git-send-email-pclouds@gmail.com>
 <1250776033-12395-3-git-send-email-pclouds@gmail.com>
 <1250776033-12395-4-git-send-email-pclouds@gmail.com>
 <1250776033-12395-5-git-send-email-pclouds@gmail.com>
 <1250776033-12395-6-git-send-email-pclouds@gmail.com>
 <1250776033-12395-7-git-send-email-pclouds@gmail.com>
 <1250776033-12395-8-git-send-email-pclouds@gmail.com>
 <1250776033-12395-9-git-send-email-pclouds@gmail.com>
 <1250776033-12395-10-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 20 15:49:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Me81I-0007ZS-CZ
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 15:49:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754672AbZHTNsQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Aug 2009 09:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754670AbZHTNsP
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 09:48:15 -0400
Received: from mail-px0-f196.google.com ([209.85.216.196]:62823 "EHLO
	mail-px0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754666AbZHTNsO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2009 09:48:14 -0400
Received: by pxi34 with SMTP id 34so3269349pxi.4
        for <git@vger.kernel.org>; Thu, 20 Aug 2009 06:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=55KCnVSY+Xjddw/fma0HEHdwPHMpc/LEh11p/NeoebI=;
        b=fF3uOHpi6sCA7gICMU4I1535eAo8PnjhtpSd6uWjOebRwUJpcdoXO8V19Z8jr3Qj44
         3QC2vNq8uMPBLISCVPnK+q2h3EdC/TkGUyfNcIvAtjJHVtacbaz5xdLfG9dCS/3pO+ll
         Ra5O4B11xIb3KZBGdlMMlVDdJa6Ch1wkrNej8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=PJT4kqEijJ94nbTA5tfeH1pQIwh55z1f4liXqfTc5Sy6JBEO1NW/yyaBNmxOtsYRio
         lBcNke/EzoPetEEGKCD8gtqFOAHEhjv5+JSKiNFYF9WBXiEqqoSJTP5osFhZJA29lXQC
         RtYWEx8vBAotpMvLhpeXSh6acuQPFa/dcopMw=
Received: by 10.115.113.37 with SMTP id q37mr9294673wam.125.1250776095852;
        Thu, 20 Aug 2009 06:48:15 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.241.222])
        by mx.google.com with ESMTPS id 20sm186995pzk.9.2009.08.20.06.48.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 20 Aug 2009 06:48:15 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 20 Aug 2009 20:48:10 +0700
X-Mailer: git-send-email 1.6.3.GIT
In-Reply-To: <1250776033-12395-10-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126631>

These functions are used to handle .gitignore. They are now exported
so that sparse checkout can reuse.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c |   32 ++++++++++++++++----------------
 dir.h |    4 ++++
 2 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/dir.c b/dir.c
index a4a91d5..3a8d3e6 100644
--- a/dir.c
+++ b/dir.c
@@ -223,12 +223,12 @@ static void *read_skip_worktree_file_from_index(c=
onst char *path, size_t *size)
 	return data;
 }
=20
-static int add_excludes_from_file_1(const char *fname,
-				    const char *base,
-				    int baselen,
-				    char **buf_p,
-				    struct exclude_list *which,
-				    int check_index)
+int add_excludes_from_file_to_list(const char *fname,
+				   const char *base,
+				   int baselen,
+				   char **buf_p,
+				   struct exclude_list *which,
+				   int check_index)
 {
 	struct stat st;
 	int fd, i;
@@ -274,8 +274,8 @@ static int add_excludes_from_file_1(const char *fna=
me,
=20
 void add_excludes_from_file(struct dir_struct *dir, const char *fname)
 {
-	if (add_excludes_from_file_1(fname, "", 0, NULL,
-				     &dir->exclude_list[EXC_FILE], 0) < 0)
+	if (add_excludes_from_file_to_list(fname, "", 0, NULL,
+					   &dir->exclude_list[EXC_FILE], 0) < 0)
 		die("cannot use %s as an exclude file", fname);
 }
=20
@@ -324,9 +324,9 @@ static void prep_exclude(struct dir_struct *dir, co=
nst char *base, int baselen)
 		memcpy(dir->basebuf + current, base + current,
 		       stk->baselen - current);
 		strcpy(dir->basebuf + stk->baselen, dir->exclude_per_dir);
-		add_excludes_from_file_1(dir->basebuf,
-					 dir->basebuf, stk->baselen,
-					 &stk->filebuf, el, 1);
+		add_excludes_from_file_to_list(dir->basebuf,
+					       dir->basebuf, stk->baselen,
+					       &stk->filebuf, el, 1);
 		dir->exclude_stack =3D stk;
 		current =3D stk->baselen;
 	}
@@ -336,9 +336,9 @@ static void prep_exclude(struct dir_struct *dir, co=
nst char *base, int baselen)
 /* Scan the list and let the last match determine the fate.
  * Return 1 for exclude, 0 for include and -1 for undecided.
  */
-static int excluded_1(const char *pathname,
-		      int pathlen, const char *basename, int *dtype,
-		      struct exclude_list *el)
+int excluded_from_list(const char *pathname,
+		       int pathlen, const char *basename, int *dtype,
+		       struct exclude_list *el)
 {
 	int i;
=20
@@ -412,8 +412,8 @@ int excluded(struct dir_struct *dir, const char *pa=
thname, int *dtype_p)
=20
 	prep_exclude(dir, pathname, basename-pathname);
 	for (st =3D EXC_CMDL; st <=3D EXC_FILE; st++) {
-		switch (excluded_1(pathname, pathlen, basename,
-				   dtype_p, &dir->exclude_list[st])) {
+		switch (excluded_from_list(pathname, pathlen, basename,
+					   dtype_p, &dir->exclude_list[st])) {
 		case 0:
 			return 0;
 		case 1:
diff --git a/dir.h b/dir.h
index 320b6a2..3bead5f 100644
--- a/dir.h
+++ b/dir.h
@@ -69,7 +69,11 @@ extern int match_pathspec(const char **pathspec, con=
st char *name, int namelen,
 extern int fill_directory(struct dir_struct *dir, const char **pathspe=
c);
 extern int read_directory(struct dir_struct *, const char *path, int l=
en, const char **pathspec);
=20
+extern int excluded_from_list(const char *pathname, int pathlen, const=
 char *basename,
+			      int *dtype, struct exclude_list *el);
 extern int excluded(struct dir_struct *, const char *, int *);
+extern int add_excludes_from_file_to_list(const char *fname, const cha=
r *base, int baselen,
+					  char **buf_p, struct exclude_list *which, int check_index);
 extern void add_excludes_from_file(struct dir_struct *, const char *fn=
ame);
 extern void add_exclude(const char *string, const char *base,
 			int baselen, struct exclude_list *which);
--=20
1.6.3.GIT
