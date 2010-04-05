From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 14/43] diff: use RUN_SETUP_GENTLY
Date: Mon,  5 Apr 2010 20:40:59 +0200
Message-ID: <1270492888-26589-15-git-send-email-pclouds@gmail.com>
References: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 20:43:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyrGz-0000ps-PF
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 20:43:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755987Ab0DESm3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Apr 2010 14:42:29 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:44752 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756001Ab0DESmV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 14:42:21 -0400
Received: by mail-fx0-f227.google.com with SMTP id 27so1251549fxm.28
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 11:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=I1JF9i9vxfFGx2Ask5ZqWIx9LDOkLn9+GQviAuQyZxQ=;
        b=C4luRCla+BoYeINKB2N0LuHQa3D+XNbpKEIiPZWdr9DEHXvFmfVWSxtJDuUtvP6Qys
         AsMIeZoJD1JvkZ/sMQNxzLXTdZVGlm7ZCG4imLEj2JK/nNW5JuaRKNGheGO+HjoQZYZH
         MAyOK2nnVj/IJakpGFg3c96dTVKmdKfIHPLVs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=pXtpSS5KQktCR1OCUJwmUN9t6jYT5sjsKDv9MJhesb18MPvNFzTtLx2tqj56wN/Gpo
         9NxHfWuGx0r10ICc/OJdm03ajWcrE9fmXMpxTrFRGG9Wb5/wZy7AD+cqf8+KGN3XOGvj
         u+RwkOKTCrMEsQCFpJjZbcFp5x/pdNbQ4YJ4o=
Received: by 10.223.92.152 with SMTP id r24mr1032806fam.74.1270492940225;
        Mon, 05 Apr 2010 11:42:20 -0700 (PDT)
Received: from dektop ([212.247.124.209])
        by mx.google.com with ESMTPS id e17sm596846fke.57.2010.04.05.11.42.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 11:42:19 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon,  5 Apr 2010 20:42:17 +0200
X-Mailer: git-send-email 1.7.0.rc1.541.g2da82.dirty
In-Reply-To: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144013>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
1.7.0.rc1.541.g2da82.dirty
