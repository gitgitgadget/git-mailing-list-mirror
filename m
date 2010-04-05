From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 08/43] archive: use RUN_SETUP_GENTLY
Date: Mon,  5 Apr 2010 20:40:53 +0200
Message-ID: <1270492888-26589-9-git-send-email-pclouds@gmail.com>
References: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 20:42:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyrFf-0005ZJ-Cd
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 20:42:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755945Ab0DESmG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Apr 2010 14:42:06 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:62876 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755930Ab0DESmD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 14:42:03 -0400
Received: by mail-fx0-f227.google.com with SMTP id 27so1250782fxm.28
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 11:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=XIot4DSVNgEXgjgwSbNHabhLgCHV3yV0DJ7RyeEA/Kc=;
        b=vcfezd6N3M7eLp1SbbPI1GC//0o049jQds4/B+mZEqmGAsqDDDX2vCMLnMXMqfHD8B
         VU9pMxA740eEptv1kun+p6vP22UsPFGld/EQo3PfufehXY/tTewdcnEhjwK4qk7s/VJl
         TC5B81jLNNQPK9pM+kV4dyqWVzfhzKBICkHFE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=GYTiWl0bZqsBMqvQx9pRjHKHE7K6lx3Ex0JyR1EF342+IUWuW3aAzKS0JqkZlQqJOZ
         GBx6sKyYZdMpGjfeK+ISKip6G5i6wVnGgaghR6sxOINEJwhs2oCUnJROV0Lc+sP/Ulj2
         AGVDhDKV2vnY94Xs7y6SYfRxX52ImO6nVImaY=
Received: by 10.223.35.12 with SMTP id n12mr5770333fad.35.1270492922279;
        Mon, 05 Apr 2010 11:42:02 -0700 (PDT)
Received: from dektop ([212.247.124.209])
        by mx.google.com with ESMTPS id 2sm13369002fks.12.2010.04.05.11.42.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 11:42:01 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon,  5 Apr 2010 20:41:59 +0200
X-Mailer: git-send-email 1.7.0.rc1.541.g2da82.dirty
In-Reply-To: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144009>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/archive.c |    2 +-
 git.c             |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/archive.c b/builtin/archive.c
index 6a887f5..ef0bef8 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -125,5 +125,5 @@ int cmd_archive(int argc, const char **argv, const =
char *prefix)
=20
 	setvbuf(stderr, NULL, _IOLBF, BUFSIZ);
=20
-	return write_archive(argc, argv, prefix, 1);
+	return write_archive(argc, argv, prefix, 0);
 }
diff --git a/git.c b/git.c
index 84dd78e..2b59f06 100644
--- a/git.c
+++ b/git.c
@@ -295,7 +295,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
 		{ "annotate", cmd_annotate, RUN_SETUP },
 		{ "apply", cmd_apply },
-		{ "archive", cmd_archive },
+		{ "archive", cmd_archive, RUN_SETUP_GENTLY },
 		{ "bisect--helper", cmd_bisect__helper, RUN_SETUP | NEED_WORK_TREE }=
,
 		{ "blame", cmd_blame, RUN_SETUP },
 		{ "branch", cmd_branch, RUN_SETUP },
@@ -384,7 +384,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "stripspace", cmd_stripspace },
 		{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
 		{ "tag", cmd_tag, RUN_SETUP },
-		{ "tar-tree", cmd_tar_tree },
+		{ "tar-tree", cmd_tar_tree, RUN_SETUP_GENTLY },
 		{ "unpack-file", cmd_unpack_file, RUN_SETUP },
 		{ "unpack-objects", cmd_unpack_objects, RUN_SETUP },
 		{ "update-index", cmd_update_index, RUN_SETUP },
--=20
1.7.0.rc1.541.g2da82.dirty
