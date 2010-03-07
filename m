From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 16/18] ls-remote: use RUN_SETUP_GENTLY
Date: Sun,  7 Mar 2010 11:56:05 +0700
Message-ID: <1267937767-12504-17-git-send-email-pclouds@gmail.com>
References: <1267937767-12504-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 07 06:00:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No8bf-0003VZ-3v
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 06:00:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951Ab0CGFAf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Mar 2010 00:00:35 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49858 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923Ab0CGFAd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 00:00:33 -0500
Received: by mail-pw0-f46.google.com with SMTP id 8so3156711pwj.19
        for <git@vger.kernel.org>; Sat, 06 Mar 2010 21:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=WvJGCMS9aOhJ02BFBqZ5/ukwJ25+p0PUrqbIO83QgJk=;
        b=vtW31y8/CeMUkrL3+qD/edF2Pvnmdjics4wqLB/mJfspOPW8XBJIopDCUNTqpqxdy5
         nz/gJe02mSA1dR4s4nD+w4hgX1D0L5AjiAhMBJD6Hglvb9S19V4PQBO3T2IF/EEmfchp
         O0CfBYYzT3tIKGQPS0FyusfGbwymePPHiG1/s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=AA5401/BrriDh7AzuP6MQ31iyI8F7nc4ugC7BH3uMuX4BnrtIRosk0jmEPHtcpXIdT
         JMBWWMDx8JTxHepwFl5FdcExzASPJ4ivSZhbnbPAG834Jk/VmNAwu3WUMjMHD/QQ7jOA
         OIcSIyT67gUPgN76XVLoxCViewLlWLTHv1vq0=
Received: by 10.142.63.13 with SMTP id l13mr318819wfa.196.1267938032889;
        Sat, 06 Mar 2010 21:00:32 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.223.3])
        by mx.google.com with ESMTPS id 22sm3255183pzk.1.2010.03.06.21.00.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Mar 2010 21:00:32 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun,  7 Mar 2010 11:57:17 +0700
X-Mailer: git-send-email 1.7.0.195.g637a2
In-Reply-To: <1267937767-12504-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141659>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/ls-remote.c |    3 ---
 git.c               |    4 ++--
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 70f5622..998f2c8 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -31,7 +31,6 @@ int cmd_ls_remote(int argc, const char **argv, const =
char *prefix)
 {
 	int i;
 	const char *dest =3D NULL;
-	int nongit;
 	unsigned flags =3D 0;
 	const char *uploadpack =3D NULL;
 	const char **pattern =3D NULL;
@@ -40,8 +39,6 @@ int cmd_ls_remote(int argc, const char **argv, const =
char *prefix)
 	struct transport *transport;
 	const struct ref *ref;
=20
-	setup_git_directory_gently(&nongit);
-
 	for (i =3D 1; i < argc; i++) {
 		const char *arg =3D argv[i];
=20
diff --git a/git.c b/git.c
index 6a29756..e0c8904 100644
--- a/git.c
+++ b/git.c
@@ -338,7 +338,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "log", cmd_log, RUN_SETUP | USE_PAGER },
 		{ "ls-files", cmd_ls_files, RUN_SETUP },
 		{ "ls-tree", cmd_ls_tree, RUN_SETUP },
-		{ "ls-remote", cmd_ls_remote },
+		{ "ls-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
 		{ "mailinfo", cmd_mailinfo, RUN_SETUP_GENTLY },
 		{ "mailsplit", cmd_mailsplit },
 		{ "merge", cmd_merge, RUN_SETUP | NEED_WORK_TREE },
@@ -359,7 +359,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "pack-objects", cmd_pack_objects, RUN_SETUP },
 		{ "pack-redundant", cmd_pack_redundant, RUN_SETUP },
 		{ "patch-id", cmd_patch_id },
-		{ "peek-remote", cmd_ls_remote },
+		{ "peek-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
 		{ "pickaxe", cmd_blame, RUN_SETUP },
 		{ "prune", cmd_prune, RUN_SETUP },
 		{ "prune-packed", cmd_prune_packed, RUN_SETUP },
--=20
1.7.0.195.g637a2
