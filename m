From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 46/73] gettextize: git-rm basic messages
Date: Tue, 22 Feb 2011 23:42:05 +0000
Message-ID: <1298418152-27789-47-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:46:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1w6-0000rs-LC
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:46:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755714Ab1BVXqA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:46:00 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:52041 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755505Ab1BVXoT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:44:19 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3867035bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=sMzHOa7FuE2mfF1rCuwwyzZ7ye1+SpFYPDkEv07tMC0=;
        b=iu9Nh2hqkNWItkYJn9y57BnKkOjSinnKxrYq/usDPahj5rsTDOMEwdPmLTvoBpN3tS
         mVN0VguNhKrXwb1KclZSGTzkyQXPkZkG3uiMSKAqPQp1KaNUYwcTyehuVdNmFpoobgvM
         q1PM+3Wn6UO5w/8mKEuiOX1wD4NNottDPnmys=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=QGTVqK9Ti/MXQecKuMEGTFN3jkNd1zpCAMng7PuYEy3+q0aCt8M9Br1EAeFsanr3+f
         0ehCoWosqjTh8jTtQiTw4ymsHAg/gA+4tYnvMPysGn6E1Ul2ZMuPczCjYmlSS1muyxng
         yOdETmk0oKQOUGIiuDL+f9DEc+layu+TY5VnI=
Received: by 10.204.103.132 with SMTP id k4mr3041361bko.28.1298418258612;
        Tue, 22 Feb 2011 15:44:18 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.44.17
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167634>

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
