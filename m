From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v3] i18n: branch: mark strings for translation
Date: Tue, 16 Apr 2013 11:37:50 +0800
Message-ID: <e31669b2dc24ac07de4ed23e00d5a38de5fcda8b.1366082959.git.worldhello.net@gmail.com>
References: <20130416024021.GG3262@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 05:38:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URwj3-0004Wq-E2
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 05:38:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935603Ab3DPDi2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Apr 2013 23:38:28 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:54380 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935355Ab3DPDi1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 23:38:27 -0400
Received: by mail-pb0-f50.google.com with SMTP id jt11so43238pbb.37
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 20:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=DlKBSmhO3MAdH5uHp2IIoSd/AjltI1O4xjYzIbYc0sg=;
        b=v8cN2tfDaPyEBHvGo/HyFDgYb782wvHjZs2cY9tJ0h7Moj9DBGena4e9ZTa74VV76z
         MJivWHoVfV6njxyEu0xYWjWVgvM83w3SfvQmb2UR0AujAZAUA2p7c1OIO5/FbeU1DEwR
         zSO1NbIv2rbHydDhLVyBxmliw1CScQlSVepU0zz9yIYDI8WBntQZXrCv7X8RxZB/hua1
         tEdARMKbjkssVz0tWPs2US/zK00653uGuM4A1Kg8CRUX+uy2fUUARbXYqb2y7FPX6Cle
         kklBmAHQUmaD9NwW6XEb2tz1k86WJUUY3680dnQV4Ulbzmw9X78uGXTAvMuO1S62PjFG
         8/Zw==
X-Received: by 10.68.253.73 with SMTP id zy9mr619338pbc.135.1366083507162;
        Mon, 15 Apr 2013 20:38:27 -0700 (PDT)
Received: from localhost.localdomain ([114.248.137.58])
        by mx.google.com with ESMTPS id vv6sm738329pab.6.2013.04.15.20.38.23
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 15 Apr 2013 20:38:26 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.350.gd29561d
In-Reply-To: <20130416024021.GG3262@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221355>

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Reviewed-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
> Micronit: it would be nicer to use printf_ln to save translators the
> trouble of worrying about the final newline.
Reroll with the help of Jonathan Nieder.

 branch.c | 54 +++++++++++++++++++++++++++---------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/branch.c b/branch.c
index 6ae6a..97c72 100644
--- a/branch.c
+++ b/branch.c
@@ -57,7 +57,7 @@ void install_branch_config(int flag, const char *loca=
l, const char *origin, cons
 	if (remote_is_branch
 	    && !strcmp(local, shortname)
 	    && !origin) {
-		warning("Not setting branch %s as its own upstream.",
+		warning(_("Not setting branch %s as its own upstream."),
 			local);
 		return;
 	}
@@ -78,25 +78,25 @@ void install_branch_config(int flag, const char *lo=
cal, const char *origin, cons
=20
 	if (flag & BRANCH_CONFIG_VERBOSE) {
 		if (remote_is_branch && origin)
-			printf(rebasing ?
-			       "Branch %s set up to track remote branch %s from %s by rebas=
ing.\n" :
-			       "Branch %s set up to track remote branch %s from %s.\n",
-			       local, shortname, origin);
+			printf_ln(rebasing ?
+				  _("Branch %s set up to track remote branch %s from %s by rebasin=
g.") :
+				  _("Branch %s set up to track remote branch %s from %s."),
+				  local, shortname, origin);
 		else if (remote_is_branch && !origin)
-			printf(rebasing ?
-			       "Branch %s set up to track local branch %s by rebasing.\n" :
-			       "Branch %s set up to track local branch %s.\n",
-			       local, shortname);
+			printf_ln(rebasing ?
+				  _("Branch %s set up to track local branch %s by rebasing.") :
+				  _("Branch %s set up to track local branch %s."),
+				  local, shortname);
 		else if (!remote_is_branch && origin)
-			printf(rebasing ?
-			       "Branch %s set up to track remote ref %s by rebasing.\n" :
-			       "Branch %s set up to track remote ref %s.\n",
-			       local, remote);
+			printf_ln(rebasing ?
+				  _("Branch %s set up to track remote ref %s by rebasing.") :
+				  _("Branch %s set up to track remote ref %s."),
+				  local, remote);
 		else if (!remote_is_branch && !origin)
-			printf(rebasing ?
-			       "Branch %s set up to track local ref %s by rebasing.\n" :
-			       "Branch %s set up to track local ref %s.\n",
-			       local, remote);
+			printf_ln(rebasing ?
+				  _("Branch %s set up to track local ref %s by rebasing.") :
+				  _("Branch %s set up to track local ref %s."),
+				  local, remote);
 		else
 			die("BUG: impossible combination of %d and %p",
 			    remote_is_branch, origin);
@@ -115,7 +115,7 @@ static int setup_tracking(const char *new_ref, cons=
t char *orig_ref,
 	int config_flags =3D quiet ? 0 : BRANCH_CONFIG_VERBOSE;
=20
 	if (strlen(new_ref) > 1024 - 7 - 7 - 1)
-		return error("Tracking not set up: name too long: %s",
+		return error(_("Tracking not set up: name too long: %s"),
 				new_ref);
=20
 	memset(&tracking, 0, sizeof(tracking));
@@ -134,7 +134,7 @@ static int setup_tracking(const char *new_ref, cons=
t char *orig_ref,
 		}
=20
 	if (tracking.matches > 1)
-		return error("Not tracking: ambiguous information for ref %s",
+		return error(_("Not tracking: ambiguous information for ref %s"),
 				orig_ref);
=20
 	install_branch_config(config_flags, new_ref, tracking.remote,
@@ -179,12 +179,12 @@ int validate_new_branchname(const char *name, str=
uct strbuf *ref,
 			    int force, int attr_only)
 {
 	if (strbuf_check_branch_ref(ref, name))
-		die("'%s' is not a valid branch name.", name);
+		die(_("'%s' is not a valid branch name."), name);
=20
 	if (!ref_exists(ref->buf))
 		return 0;
 	else if (!force && !attr_only)
-		die("A branch named '%s' already exists.", ref->buf + strlen("refs/h=
eads/"));
+		die(_("A branch named '%s' already exists."), ref->buf + strlen("ref=
s/heads/"));
=20
 	if (!attr_only) {
 		const char *head;
@@ -192,7 +192,7 @@ int validate_new_branchname(const char *name, struc=
t strbuf *ref,
=20
 		head =3D resolve_ref_unsafe("HEAD", sha1, 0, NULL);
 		if (!is_bare_repository() && head && !strcmp(head, ref->buf))
-			die("Cannot force update the current branch.");
+			die(_("Cannot force update the current branch."));
 	}
 	return 1;
 }
@@ -247,7 +247,7 @@ void create_branch(const char *head,
 			}
 			die(_(upstream_missing), start_name);
 		}
-		die("Not a valid object name: '%s'.", start_name);
+		die(_("Not a valid object name: '%s'."), start_name);
 	}
=20
 	switch (dwim_ref(start_name, strlen(start_name), sha1, &real_ref)) {
@@ -267,18 +267,18 @@ void create_branch(const char *head,
 		}
 		break;
 	default:
-		die("Ambiguous object name: '%s'.", start_name);
+		die(_("Ambiguous object name: '%s'."), start_name);
 		break;
 	}
=20
 	if ((commit =3D lookup_commit_reference(sha1)) =3D=3D NULL)
-		die("Not a valid branch point: '%s'.", start_name);
+		die(_("Not a valid branch point: '%s'."), start_name);
 	hashcpy(sha1, commit->object.sha1);
=20
 	if (!dont_change_ref) {
 		lock =3D lock_any_ref_for_update(ref.buf, NULL, 0);
 		if (!lock)
-			die_errno("Failed to lock ref for update");
+			die_errno(_("Failed to lock ref for update"));
 	}
=20
 	if (reflog)
@@ -296,7 +296,7 @@ void create_branch(const char *head,
=20
 	if (!dont_change_ref)
 		if (write_ref_sha1(lock, sha1, msg) < 0)
-			die_errno("Failed to write ref");
+			die_errno(_("Failed to write ref"));
=20
 	strbuf_release(&ref);
 	free(real_ref);
--=20
1.8.2.1.350.gd29561d
