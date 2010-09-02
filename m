From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 16/25] gettextize: git-rm basic messages
Date: Thu,  2 Sep 2010 19:40:37 +0000
Message-ID: <1283456446-22577-17-git-send-email-avarab@gmail.com>
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
	id 1OrFgR-0006jt-6U
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 21:42:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756174Ab0IBTmN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 15:42:13 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62423 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756629Ab0IBTmK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 15:42:10 -0400
Received: by mail-ww0-f44.google.com with SMTP id 40so1282223wwj.1
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 12:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=AGxgUPZlrszjskJGWaTKEvH9GlVmtfTTQLWik++sOYo=;
        b=A0awOmamTBLBTwh4Rl+haBzpkG+2Zjvk9aD68Qaa8TqFTy+EmhYneHXV5tBYclKRWV
         Wsx7ITcn1YEwpyJM9ttkLLWBpzytrIDbmw6XNBVeEzLjsqfg6Q+KjfrRFiaG9Ol8zOFs
         DZ5SUi2/CpVXt9RePtE8CCPEDuxJc3Bev4fXs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=X5RGX5k8UvIHKjtJoZHQDve9BQuKC9IL6hzgTynOJrPQNs2hAjy76HE2Tinjaz9Qs4
         JKQz4qVpdFUak9MOVamPEDD3ght8r852LFFC3wccCfW31QMAxBmm7pbKSVnn1PlgpWSo
         aWO42y+22NpCH82eoy/PYVuXewr9ZSc8VVuaw=
Received: by 10.227.20.69 with SMTP id e5mr8698450wbb.87.1283456518879;
        Thu, 02 Sep 2010 12:41:58 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e31sm701885wbe.17.2010.09.02.12.41.58
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 02 Sep 2010 12:41:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.614.g1dc9
In-Reply-To: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155179>

Make the basic git-mv messages translatable, but skip things like "rm
'%s'\n" and "git rm '%s'\n" for now.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/rm.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index f3772c8..68656f3 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -115,19 +115,19 @@ static int check_local_mod(unsigned char *head, i=
nt index_only)
 		 */
 		if (local_changes && staged_changes) {
 			if (!index_only || !(ce->ce_flags & CE_INTENT_TO_ADD))
-				errs =3D error("'%s' has staged content different "
+				errs =3D error(_("'%s' has staged content different "
 					     "from both the file and the HEAD\n"
-					     "(use -f to force removal)", name);
+					     "(use -f to force removal)"), name);
 		}
 		else if (!index_only) {
 			if (staged_changes)
-				errs =3D error("'%s' has changes staged in the index\n"
+				errs =3D error(_("'%s' has changes staged in the index\n"
 					     "(use --cached to keep the file, "
-					     "or -f to force removal)", name);
+					     "or -f to force removal)"), name);
 			if (local_changes)
-				errs =3D error("'%s' has local modifications\n"
+				errs =3D error(_("'%s' has local modifications\n"
 					     "(use --cached to keep the file, "
-					     "or -f to force removal)", name);
+					     "or -f to force removal)"), name);
 		}
 	}
 	return errs;
@@ -168,7 +168,7 @@ int cmd_rm(int argc, const char **argv, const char =
*prefix)
 	newfd =3D hold_locked_index(&lock_file, 1);
=20
 	if (read_cache() < 0)
-		die("index file corrupt");
+		die(_("index file corrupt"));
=20
 	pathspec =3D get_pathspec(prefix, argv);
 	refresh_index(&the_index, REFRESH_QUIET, pathspec, NULL, NULL);
@@ -191,7 +191,7 @@ int cmd_rm(int argc, const char **argv, const char =
*prefix)
 		for (i =3D 0; (match =3D pathspec[i]) !=3D NULL ; i++) {
 			if (!seen[i]) {
 				if (!ignore_unmatch) {
-					die("pathspec '%s' did not match any files",
+					die(_("pathspec '%s' did not match any files"),
 					    match);
 				}
 			}
@@ -199,7 +199,7 @@ int cmd_rm(int argc, const char **argv, const char =
*prefix)
 				seen_any =3D 1;
 			}
 			if (!recursive && seen[i] =3D=3D MATCHED_RECURSIVELY)
-				die("not removing '%s' recursively without -r",
+				die(_("not removing '%s' recursively without -r"),
 				    *match ? match : ".");
 		}
=20
@@ -235,7 +235,7 @@ int cmd_rm(int argc, const char **argv, const char =
*prefix)
 			printf("rm '%s'\n", path);
=20
 		if (remove_file_from_cache(path))
-			die("git rm: unable to remove %s", path);
+			die(_("git rm: unable to remove %s"), path);
 	}
=20
 	if (show_only)
@@ -265,7 +265,7 @@ int cmd_rm(int argc, const char **argv, const char =
*prefix)
 	if (active_cache_changed) {
 		if (write_cache(newfd, active_cache, active_nr) ||
 		    commit_locked_index(&lock_file))
-			die("Unable to write new index file");
+			die(_("Unable to write new index file"));
 	}
=20
 	return 0;
--=20
1.7.2.2.614.g1dc9
