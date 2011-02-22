From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 45/73] gettextize: git-mv "bad" messages
Date: Tue, 22 Feb 2011 23:42:04 +0000
Message-ID: <1298418152-27789-46-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:44:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1uK-0008HI-CL
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:44:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755545Ab1BVXoV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:44:21 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:51284 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755443Ab1BVXoS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:44:18 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3867040bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=6ytxoP+c/Zua+5a7US89XuiSoA4e5HNWuZ3P4CtB4e4=;
        b=JEz1WC+TEqv17GXyOjwM7muszEGz/W+SGhzsad0QGlYbzhquxLpBXoiNzK28CMW07u
         ajnOTjWVBeV5iZ41hPJCIFTC2TQlqEgAV/7q3tV4eOfRAmTrViF1aumvAmEZz0QIDeGI
         8mYxolFsgCNWboPp66UxpXoVmllkiVD5A+tY8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=oILbt+9TPQVcs72YngIc+h6lKe5if0Og0YQTcm9fEmickdbR9iBtyR6wdZwEuCBPG/
         nr2GGcOFPzjjD335dAehNcjrLKBX4gfr+4Uz2OCO8Y+hoF1wb0U+/rpDD3Uxd5zxWm4i
         D0eaOqgdV6nRgeH0gfh0V/2JH5117LdakCX8w=
Received: by 10.204.56.14 with SMTP id w14mr3157960bkg.27.1298418257535;
        Tue, 22 Feb 2011 15:44:17 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.44.16
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:44:17 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167603>

Gettextize messages made by assigning to the "bad" char* variable.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/mv.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 18a2218..40f33ca 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -104,13 +104,13 @@ int cmd_mv(int argc, const char **argv, const cha=
r *prefix)
=20
 		length =3D strlen(src);
 		if (lstat(src, &st) < 0)
-			bad =3D "bad source";
+			bad =3D _("bad source");
 		else if (!strncmp(src, dst, length) &&
 				(dst[length] =3D=3D 0 || dst[length] =3D=3D '/')) {
-			bad =3D "can not move directory into itself";
+			bad =3D _("can not move directory into itself");
 		} else if ((src_is_dir =3D S_ISDIR(st.st_mode))
 				&& lstat(dst, &st) =3D=3D 0)
-			bad =3D "cannot move directory over file";
+			bad =3D _("cannot move directory over file");
 		else if (src_is_dir) {
 			const char *src_w_slash =3D add_slash(src);
 			int len_w_slash =3D length + 1;
@@ -132,7 +132,7 @@ int cmd_mv(int argc, const char **argv, const char =
*prefix)
 			free((char *)src_w_slash);
=20
 			if (last - first < 1)
-				bad =3D "source directory is empty";
+				bad =3D _("source directory is empty");
 			else {
 				int j, dst_len;
=20
@@ -163,9 +163,9 @@ int cmd_mv(int argc, const char **argv, const char =
*prefix)
 				argc +=3D last - first;
 			}
 		} else if (cache_name_pos(src, length) < 0)
-			bad =3D "not under version control";
+			bad =3D _("not under version control");
 		else if (lstat(dst, &st) =3D=3D 0) {
-			bad =3D "destination exists";
+			bad =3D _("destination exists");
 			if (force) {
 				/*
 				 * only files can overwrite each other:
@@ -175,10 +175,10 @@ int cmd_mv(int argc, const char **argv, const cha=
r *prefix)
 					warning(_("%s; will overwrite!"), bad);
 					bad =3D NULL;
 				} else
-					bad =3D "Cannot overwrite";
+					bad =3D _("Cannot overwrite");
 			}
 		} else if (string_list_has_string(&src_for_dst, dst))
-			bad =3D "multiple sources for the same target";
+			bad =3D _("multiple sources for the same target");
 		else
 			string_list_insert(&src_for_dst, dst);
=20
--=20
1.7.2.3
