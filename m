From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 44/72] gettextize: git-mv "bad" messages
Date: Sat, 19 Feb 2011 19:24:27 +0000
Message-ID: <1298143495-3681-45-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:30:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsVK-00042j-Dh
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:30:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756106Ab1BST3x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:29:53 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:61282 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756084Ab1BST2E (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:28:04 -0500
Received: by eye27 with SMTP id 27so2347203eye.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=6ytxoP+c/Zua+5a7US89XuiSoA4e5HNWuZ3P4CtB4e4=;
        b=R9OxnZlAFaGzMsbqSEwGA/89ENMx6C7iDjvMZD7p3gXSw4GyOp/tvige3y6oSvUIAN
         wqQMLm0WKzpJhf621R2/NAquFg/+x2py8yIJOontplXVVjCklQCueiVbs4mmK/qboDzX
         V3/53bVWWNQWk4U00LJouFgKOp21m+VI2hDMc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=pyb1dH1dUaeoc7uLVIGt/gHTJgOuMFzIZ0T+MWQOwn0FLFMdxawRVipO/dXQD4P1G3
         VfjP7h0Wy805XXI1hAW4TKB4KDC2HQ6JKrBoRPQ5/d0ZXxXdHNtc4+stjRDp5eErwRZr
         Upg7biufFEOS5RHIBSTOgXZHSHWVlY0Y7tQYE=
Received: by 10.213.33.206 with SMTP id i14mr2518221ebd.80.1298143683371;
        Sat, 19 Feb 2011 11:28:03 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.28.02
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:28:02 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167366>

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
