From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 14/18] diff: use RUN_SETUP_GENTLY
Date: Sun,  7 Mar 2010 11:56:03 +0700
Message-ID: <1267937767-12504-15-git-send-email-pclouds@gmail.com>
References: <1267937767-12504-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 07 06:00:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No8bd-0003VZ-Sv
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 06:00:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860Ab0CGFA1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Mar 2010 00:00:27 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49858 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832Ab0CGFAY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 00:00:24 -0500
Received: by mail-pw0-f46.google.com with SMTP id 8so3156711pwj.19
        for <git@vger.kernel.org>; Sat, 06 Mar 2010 21:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=LRJeJgtu8LL5ibIPH2xEGtMjl15amedsAydc0Jxbfys=;
        b=jj5F6CdQdyBiBl3tkz2COBC/QtHpIJ/Fe0FE5yfZ9W3B2fGfoZ4L35iOaqG1oZIcWX
         Sspt8x6uN0KN9dLy+sQ8Pp7+17nmslf2BOtOPXaDrgdoAba07x0dPy6TVQYm9PyTWK4C
         6bsFyX5w298vABvMmtqvZ7eTW/YGuoVPQRsKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=mtfIlfzM1ri/7WZ9BZUe7I/xQxnWOWjS5areOgPpeoCjZbSLtkSL8F+2JMq32p2niq
         K5wWI1bEBRG/c+mikjopjRPZo+k05h/zON2knj6WJ0lKw/85/y9Ml3nvKGAS0gc7XQx/
         mPfK0FUEoitdHW6KzwszZ61Y/kkeGgt07+1HA=
Received: by 10.142.59.6 with SMTP id h6mr2030273wfa.330.1267938024363;
        Sat, 06 Mar 2010 21:00:24 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.223.3])
        by mx.google.com with ESMTPS id 23sm3231339pzk.6.2010.03.06.21.00.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Mar 2010 21:00:23 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun,  7 Mar 2010 11:57:08 +0700
X-Mailer: git-send-email 1.7.0.195.g637a2
In-Reply-To: <1267937767-12504-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141657>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/diff.c |    6 ++----
 git.c          |    2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index ffcdd05..e4bd855 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -252,7 +252,6 @@ int cmd_diff(int argc, const char **argv, const cha=
r *prefix)
 	int ents =3D 0, blobs =3D 0, paths =3D 0;
 	const char *path =3D NULL;
 	struct blobinfo blob[2];
-	int nongit;
 	int result =3D 0;
=20
 	/*
@@ -278,7 +277,6 @@ int cmd_diff(int argc, const char **argv, const cha=
r *prefix)
 	 * Other cases are errors.
 	 */
=20
-	prefix =3D setup_git_directory_gently(&nongit);
 	git_config(git_diff_ui_config, NULL);
=20
 	if (diff_use_color_default =3D=3D -1)
@@ -287,7 +285,7 @@ int cmd_diff(int argc, const char **argv, const cha=
r *prefix)
 	init_revisions(&rev, prefix);
=20
 	/* If this is a no-index diff, just run it and exit there. */
-	diff_no_index(&rev, argc, argv, nongit, prefix);
+	diff_no_index(&rev, argc, argv, !startup_info->have_repository, prefi=
x);
=20
 	/* Otherwise, we are doing the usual "git" diff */
 	rev.diffopt.skip_stat_unmatch =3D !!diff_auto_refresh_index;
@@ -296,7 +294,7 @@ int cmd_diff(int argc, const char **argv, const cha=
r *prefix)
 	DIFF_OPT_SET(&rev.diffopt, ALLOW_EXTERNAL);
 	DIFF_OPT_SET(&rev.diffopt, ALLOW_TEXTCONV);
=20
-	if (nongit)
+	if (!startup_info->have_repository)
 		die("Not a git repository");
 	argc =3D setup_revisions(argc, argv, &rev, NULL);
 	if (!rev.diffopt.output_format) {
diff --git a/git.c b/git.c
index a90e0c3..02ba3b2 100644
--- a/git.c
+++ b/git.c
@@ -315,7 +315,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "config", cmd_config, RUN_SETUP_GENTLY },
 		{ "count-objects", cmd_count_objects, RUN_SETUP },
 		{ "describe", cmd_describe, RUN_SETUP },
-		{ "diff", cmd_diff },
+		{ "diff", cmd_diff, RUN_SETUP_GENTLY },
 		{ "diff-files", cmd_diff_files, RUN_SETUP | NEED_WORK_TREE },
 		{ "diff-index", cmd_diff_index, RUN_SETUP },
 		{ "diff-tree", cmd_diff_tree, RUN_SETUP },
--=20
1.7.0.195.g637a2
