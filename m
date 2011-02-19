From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 45/72] gettextize: git-rm basic messages
Date: Sat, 19 Feb 2011 19:24:28 +0000
Message-ID: <1298143495-3681-46-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:28:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsTp-0003Eb-DY
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:28:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756127Ab1BST2N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:28:13 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:60199 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755983Ab1BST2F (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:28:05 -0500
Received: by mail-ew0-f46.google.com with SMTP id 5so1970492ewy.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=sMzHOa7FuE2mfF1rCuwwyzZ7ye1+SpFYPDkEv07tMC0=;
        b=l/AmB8Gol+h368w5NWEApdURg/MlGYJzKQk+SwdBcnkcEUjZvMWshiuRMX62mJeHnr
         GORQmhelL8HBr794Nn262ZE/GqAJwj9+5wIH8oVL1phiCbFDBoZS5I1tqh/9lxH4rMNM
         UcdpydDqlXHK/yrUblS7ZXTc9Hl3tmUZGJCfw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=vA93QMZe56uTCCmx/mlQWaZwV0/Wrw3Kqwqyvdj3hY/vGILNXtfbEo5kjr22KEXNuo
         jxNkmHFdwcdUcSxM0u6e+LTkG9A7c4etP65o67zMr1ykvICQt6qAd4dbE9jPNNfefssR
         cqDuBqSQVHoYBNGEwX+OcpTGhMjFZo4F4oGr0=
Received: by 10.213.19.14 with SMTP id y14mr2520938eba.82.1298143684643;
        Sat, 19 Feb 2011 11:28:04 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.28.03
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:28:03 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167337>

Make the basic git-mv messages translatable, but skip things like "rm
'%s'\n" and "git rm '%s'\n" for now.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/rm.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index ff491d7..90c8a50 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -106,19 +106,19 @@ static int check_local_mod(unsigned char *head, i=
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
@@ -159,7 +159,7 @@ int cmd_rm(int argc, const char **argv, const char =
*prefix)
 	newfd =3D hold_locked_index(&lock_file, 1);
=20
 	if (read_cache() < 0)
-		die("index file corrupt");
+		die(_("index file corrupt"));
=20
 	pathspec =3D get_pathspec(prefix, argv);
 	refresh_index(&the_index, REFRESH_QUIET, pathspec, NULL, NULL);
@@ -183,7 +183,7 @@ int cmd_rm(int argc, const char **argv, const char =
*prefix)
 		for (i =3D 0; (match =3D pathspec[i]) !=3D NULL ; i++) {
 			if (!seen[i]) {
 				if (!ignore_unmatch) {
-					die("pathspec '%s' did not match any files",
+					die(_("pathspec '%s' did not match any files"),
 					    match);
 				}
 			}
@@ -191,7 +191,7 @@ int cmd_rm(int argc, const char **argv, const char =
*prefix)
 				seen_any =3D 1;
 			}
 			if (!recursive && seen[i] =3D=3D MATCHED_RECURSIVELY)
-				die("not removing '%s' recursively without -r",
+				die(_("not removing '%s' recursively without -r"),
 				    *match ? match : ".");
 		}
=20
@@ -227,7 +227,7 @@ int cmd_rm(int argc, const char **argv, const char =
*prefix)
 			printf("rm '%s'\n", path);
=20
 		if (remove_file_from_cache(path))
-			die("git rm: unable to remove %s", path);
+			die(_("git rm: unable to remove %s"), path);
 	}
=20
 	if (show_only)
@@ -257,7 +257,7 @@ int cmd_rm(int argc, const char **argv, const char =
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
1.7.2.3
