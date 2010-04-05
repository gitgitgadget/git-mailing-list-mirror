From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 13/43] bundle: use RUN_SETUP_GENTLY
Date: Mon,  5 Apr 2010 20:40:58 +0200
Message-ID: <1270492888-26589-14-git-send-email-pclouds@gmail.com>
References: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 20:43:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyrGz-0000ps-7h
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 20:43:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756047Ab0DESm0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Apr 2010 14:42:26 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:62876 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755987Ab0DESmS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 14:42:18 -0400
Received: by mail-fx0-f227.google.com with SMTP id 27so1250782fxm.28
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 11:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=4onMxjgH0beGR99RK4JG3WwFoHRM6ot5pIkcK5M2QNA=;
        b=vP8vfoI8If5lO2LI2L5S94uPtengPB7hMMyUFzo0b2Udiy/csMRcThCLoX39ltsZHe
         jbPV4DHdKlFMBdDTSb973ICWhmWL2c4lzReh5VaX41t5jBRt4WawXQbjjPZGrza5Wmkr
         tGPiZE8K0zpsELd8J9qcJkOWTf9QLC3lk+Lg4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=eENWgPjbDVsyXi4slqH1DXXRpeADIZFkXlaljiLJIb4kOCGijg45O8ma6Q2dVVgbYR
         0szLmM6O/jDWIqVCPD9RbYX0IQ+RccH4GVTIT/YsXFxxIYI+vgl8jIldo2+oROe2PFbC
         g37b5MLuYteQbLrq6KpUsBCc8o+rBF4Dv+88M=
Received: by 10.223.47.130 with SMTP id n2mr1991107faf.55.1270492937792;
        Mon, 05 Apr 2010 11:42:17 -0700 (PDT)
Received: from dektop ([212.247.124.209])
        by mx.google.com with ESMTPS id k29sm26919892fkk.15.2010.04.05.11.42.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 11:42:17 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon,  5 Apr 2010 20:42:14 +0200
X-Mailer: git-send-email 1.7.0.rc1.541.g2da82.dirty
In-Reply-To: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144015>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/bundle.c |    6 ++----
 git.c            |    2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index 2006cc5..80649ba 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -18,7 +18,6 @@ static const char builtin_bundle_usage[] =3D
 int cmd_bundle(int argc, const char **argv, const char *prefix)
 {
 	struct bundle_header header;
-	int nongit;
 	const char *cmd, *bundle_file;
 	int bundle_fd =3D -1;
 	char buffer[PATH_MAX];
@@ -31,7 +30,6 @@ int cmd_bundle(int argc, const char **argv, const cha=
r *prefix)
 	argc -=3D 2;
 	argv +=3D 2;
=20
-	prefix =3D setup_git_directory_gently(&nongit);
 	if (prefix && bundle_file[0] !=3D '/') {
 		snprintf(buffer, sizeof(buffer), "%s/%s", prefix, bundle_file);
 		bundle_file =3D buffer;
@@ -54,11 +52,11 @@ int cmd_bundle(int argc, const char **argv, const c=
har *prefix)
 		return !!list_bundle_refs(&header, argc, argv);
 	}
 	if (!strcmp(cmd, "create")) {
-		if (nongit)
+		if (!startup_info->have_repository)
 			die("Need a repository to create a bundle.");
 		return !!create_bundle(&header, bundle_file, argc, argv);
 	} else if (!strcmp(cmd, "unbundle")) {
-		if (nongit)
+		if (!startup_info->have_repository)
 			die("Need a repository to unbundle.");
 		return !!unbundle(&header, bundle_fd) ||
 			list_bundle_refs(&header, argc, argv);
diff --git a/git.c b/git.c
index 7820d22..a90e0c3 100644
--- a/git.c
+++ b/git.c
@@ -299,7 +299,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "bisect--helper", cmd_bisect__helper, RUN_SETUP | NEED_WORK_TREE }=
,
 		{ "blame", cmd_blame, RUN_SETUP },
 		{ "branch", cmd_branch, RUN_SETUP },
-		{ "bundle", cmd_bundle },
+		{ "bundle", cmd_bundle, RUN_SETUP_GENTLY },
 		{ "cat-file", cmd_cat_file, RUN_SETUP },
 		{ "checkout", cmd_checkout, RUN_SETUP | NEED_WORK_TREE },
 		{ "checkout-index", cmd_checkout_index,
--=20
1.7.0.rc1.541.g2da82.dirty
