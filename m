From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 18/43] merge-file: use RUN_SETUP_GENTLY
Date: Mon,  5 Apr 2010 20:41:03 +0200
Message-ID: <1270492888-26589-19-git-send-email-pclouds@gmail.com>
References: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 20:43:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyrH2-0000ps-8h
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 20:43:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756075Ab0DESmm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Apr 2010 14:42:42 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:60474 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756008Ab0DESme (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 14:42:34 -0400
Received: by fg-out-1718.google.com with SMTP id d23so368980fga.1
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 11:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=irMsNAHUEWhNhXpzcHXm7s7QHeIrARbtsRGt4VfASjA=;
        b=lbTR6fuwyPlfeT0YbXii/+y6kFY7F0oKbfS6mgr+RCIQbCqUlZSXY98WMt9IIKGXeR
         //3DOH6lVoBk8F4ujsBdNFpq8UHwneg3Hv9jBNRd/mkCwvDJmPiIhR+r3KyJIiT/Mh1L
         ugfMByKZBzH2/vxIYjq9bzJ6JVcEoZbUZ2ZVw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=AoKLarwvyFwtnnyiSD0srvU3g6WLsCMYc1cTFU++K2hJ3U+32gipayHNMDOelfLEFT
         0cC+XbfOmXy6N8hfUVcIMW2Ms16P2cXIfVeUrCIQAudeSoigPPRHjSpasQUJz049M3ql
         +reK8Ppn6MVKJSNrg7dShcmLOUCu2dquXpEfs=
Received: by 10.87.53.22 with SMTP id f22mr6423125fgk.41.1270492952394;
        Mon, 05 Apr 2010 11:42:32 -0700 (PDT)
Received: from dektop ([212.247.124.209])
        by mx.google.com with ESMTPS id 16sm8080448fxm.8.2010.04.05.11.42.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 11:42:31 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon,  5 Apr 2010 20:42:29 +0200
X-Mailer: git-send-email 1.7.0.rc1.541.g2da82.dirty
In-Reply-To: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144023>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/merge-file.c |    4 +---
 git.c                |    2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index 69cc683..493ff76 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -28,7 +28,6 @@ int cmd_merge_file(int argc, const char **argv, const=
 char *prefix)
 	xmparam_t xmp =3D {{XDF_NEED_MINIMAL}};
 	int ret =3D 0, i =3D 0, to_stdout =3D 0;
 	int quiet =3D 0;
-	int nongit;
 	struct option options[] =3D {
 		OPT_BOOLEAN('p', "stdout", &to_stdout, "send results to standard out=
put"),
 		OPT_SET_INT(0, "diff3", &xmp.style, "use a diff3 based merge", XDL_M=
ERGE_DIFF3),
@@ -50,8 +49,7 @@ int cmd_merge_file(int argc, const char **argv, const=
 char *prefix)
 	xmp.style =3D 0;
 	xmp.favor =3D 0;
=20
-	prefix =3D setup_git_directory_gently(&nongit);
-	if (!nongit) {
+	if (startup_info->have_repository) {
 		/* Read the configuration file */
 		git_config(git_xmerge_config, NULL);
 		if (0 <=3D git_xmerge_style)
diff --git a/git.c b/git.c
index 567d533..96c2d21 100644
--- a/git.c
+++ b/git.c
@@ -343,7 +343,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "mailsplit", cmd_mailsplit },
 		{ "merge", cmd_merge, RUN_SETUP | NEED_WORK_TREE },
 		{ "merge-base", cmd_merge_base, RUN_SETUP },
-		{ "merge-file", cmd_merge_file },
+		{ "merge-file", cmd_merge_file, RUN_SETUP_GENTLY },
 		{ "merge-index", cmd_merge_index, RUN_SETUP },
 		{ "merge-ours", cmd_merge_ours, RUN_SETUP },
 		{ "merge-recursive", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE=
 },
--=20
1.7.0.rc1.541.g2da82.dirty
