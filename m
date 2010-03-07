From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 08/18] archive: use RUN_SETUP_GENTLY
Date: Sun,  7 Mar 2010 11:55:57 +0700
Message-ID: <1267937767-12504-9-git-send-email-pclouds@gmail.com>
References: <1267937767-12504-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 07 06:00:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No8b1-0000K9-Uz
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 06:00:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754520Ab0CGE77 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Mar 2010 23:59:59 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:39125 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754484Ab0CGE76 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Mar 2010 23:59:58 -0500
Received: by mail-pv0-f174.google.com with SMTP id 32so1119814pvb.19
        for <git@vger.kernel.org>; Sat, 06 Mar 2010 20:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=u+8ofMe5iLgMR/kzewVPm8zIVO4iJzHrpDBE60MDnAE=;
        b=uN/9o+szbyEzRIb0MmWVAX2vqGQ6IM3F/TUeT0jt7bcGRPgMdrSd2XDfRT+k7+fLfc
         XB0XLyWoWb+YJgemKEm8tp+2Tma+dKphY0UW6yZ8/z1NAXCDi4u0UI2Lf+8EHGtMeO0H
         DLZBPnjaB4u7KQB6T85JPwcFRTOULHDME9I7A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=msM30/pgjCL82jQHy+ouMmC0rbYJbmrDgbwoXrKGR02YHntThcljs0oTuEK4NSnXza
         4R/cWUDatnRK0oH4+4rfFu1p+8bB6lGCP7VxYPA3JLuo46PPFad/PVsYXGhtUIxo5esi
         w4hi2JP+5OPn/nENheHgo9zTTf8HMblpKNzuY=
Received: by 10.114.215.30 with SMTP id n30mr2146534wag.56.1267937997955;
        Sat, 06 Mar 2010 20:59:57 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.223.3])
        by mx.google.com with ESMTPS id 20sm3269473pzk.11.2010.03.06.20.59.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Mar 2010 20:59:57 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun,  7 Mar 2010 11:56:42 +0700
X-Mailer: git-send-email 1.7.0.195.g637a2
In-Reply-To: <1267937767-12504-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141652>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
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
1.7.0.195.g637a2
