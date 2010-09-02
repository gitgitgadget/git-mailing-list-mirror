From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 15/25] gettextize: git-mv "bad" messages
Date: Thu,  2 Sep 2010 19:40:36 +0000
Message-ID: <1283456446-22577-16-git-send-email-avarab@gmail.com>
References: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 02 21:42:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrFgQ-0006jt-5T
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 21:42:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756661Ab0IBTmD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 15:42:03 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50195 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756658Ab0IBTmA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 15:42:00 -0400
Received: by mail-wy0-f174.google.com with SMTP id 35so81343wyb.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 12:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Xx/O0U7TD76XRbVTvIKfyYV71efG0Yp8hx1g+HLcA7k=;
        b=uksrq7aJuo2/yUTHm+zFVMeBrF5LWdutccLCIglE5b9J0V1rPc/Rz5hNLxqdX21ovq
         GxAD9fsLc3f09Au97BFVA7qTWo2+xaKtbeHYPcB/kbpAxmOA4vlmSrZQMGSCWqKql2Ti
         LJqUu2mppc6zeqsnMGM5QPw33PWaijfZpXSf4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=WiV2TrIamFx3AcbpCAkhKnUxSkUKIQ1x6WQIkj3n2NtItMmRD8Nqr4suqiZQYssra0
         m5GL3jkBU0jn9ui20jNZIeMPVemXfj5NqAhlCV6OFatFQh/D/snNw46Uzexgaaz7CLJn
         n4KFDsFmordg7kBB8F0FLbrb+ADlZK5KPDIsE=
Received: by 10.227.38.147 with SMTP id b19mr8571657wbe.150.1283456515152;
        Thu, 02 Sep 2010 12:41:55 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e31sm701885wbe.17.2010.09.02.12.41.53
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 02 Sep 2010 12:41:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.614.g1dc9
In-Reply-To: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155178>

Translate messages made by assigning to the "bad" char* variable.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/mv.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 5d99973..8c13096 100644
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
1.7.2.2.614.g1dc9
