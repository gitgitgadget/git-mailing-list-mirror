From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v2] i18n: branch: mark strings for translation
Date: Sat, 13 Apr 2013 22:08:27 +0800
Message-ID: <b841ddcc538f77c89859efe867fc638005dc13f9.1365861788.git.worldhello.net@gmail.com>
References: <CACsJy8DK5U3XErjDYZJZ+RBywDypuDotc-cH=CYGcd9Pu=V4PQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.co>
X-From: git-owner@vger.kernel.org Sat Apr 13 16:08:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UR18S-0003Sm-Qw
	for gcvg-git-2@plane.gmane.org; Sat, 13 Apr 2013 16:08:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753870Ab3DMOIx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Apr 2013 10:08:53 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:36625 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753785Ab3DMOIv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Apr 2013 10:08:51 -0400
Received: by mail-pb0-f44.google.com with SMTP id wz12so1857310pbc.3
        for <git@vger.kernel.org>; Sat, 13 Apr 2013 07:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=e/eFNxCu9583mAFLa6le0fqxh2Jj0BCHSKOBM9egesI=;
        b=qRr04cPz0YNJjVw6kAD1/w1yC0mlEcwD7eFiEUC2t+YmF1quwpFPy0TbZtyDm4NqgO
         jHpqwA8t9fzgmKcBaTreqY0jsuCk4KVCMIHh2JHKkkx2lAdKQ3O2i3d5AiXpmoUTP7wL
         iT16rufQGoRYN9BRwuOdgd1AcOtzoPZW/DSbGuRWf46Z6/LxTCKh47D+sPoAy1+Rjx9W
         C71HxtH8bO0+Si/QG5jWNLW2ukjGjSQDZ3qTHmHX6rKtcbQnGuPnF+P/WwWtVnxxls/n
         Yt+BJ63CiIm0aZGzvV/CvPRFnZsoUh5GVVpO4glo9k48wUv9nzJTVKAGMGxdT+046P63
         aF+w==
X-Received: by 10.66.154.33 with SMTP id vl1mr20595920pab.60.1365862130738;
        Sat, 13 Apr 2013 07:08:50 -0700 (PDT)
Received: from localhost.localdomain ([114.248.153.32])
        by mx.google.com with ESMTPS id do4sm12765107pbc.8.2013.04.13.07.08.43
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 13 Apr 2013 07:08:49 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.350.g7baa3ba
In-Reply-To: <CACsJy8DK5U3XErjDYZJZ+RBywDypuDotc-cH=CYGcd9Pu=V4PQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221063>

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Reviewed-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
---
Not mark "BUG: impossible combination of %d and %p", which would
never happen.

 branch.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/branch.c b/branch.c
index 6ae6a..4ddd69 100644
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
@@ -79,23 +79,23 @@ void install_branch_config(int flag, const char *lo=
cal, const char *origin, cons
 	if (flag & BRANCH_CONFIG_VERBOSE) {
 		if (remote_is_branch && origin)
 			printf(rebasing ?
-			       "Branch %s set up to track remote branch %s from %s by rebas=
ing.\n" :
-			       "Branch %s set up to track remote branch %s from %s.\n",
+			       _("Branch %s set up to track remote branch %s from %s by reb=
asing.\n") :
+			       _("Branch %s set up to track remote branch %s from %s.\n"),
 			       local, shortname, origin);
 		else if (remote_is_branch && !origin)
 			printf(rebasing ?
-			       "Branch %s set up to track local branch %s by rebasing.\n" :
-			       "Branch %s set up to track local branch %s.\n",
+			       _("Branch %s set up to track local branch %s by rebasing.\n"=
) :
+			       _("Branch %s set up to track local branch %s.\n"),
 			       local, shortname);
 		else if (!remote_is_branch && origin)
 			printf(rebasing ?
-			       "Branch %s set up to track remote ref %s by rebasing.\n" :
-			       "Branch %s set up to track remote ref %s.\n",
+			       _("Branch %s set up to track remote ref %s by rebasing.\n") =
:
+			       _("Branch %s set up to track remote ref %s.\n"),
 			       local, remote);
 		else if (!remote_is_branch && !origin)
 			printf(rebasing ?
-			       "Branch %s set up to track local ref %s by rebasing.\n" :
-			       "Branch %s set up to track local ref %s.\n",
+			       _("Branch %s set up to track local ref %s by rebasing.\n") :
+			       _("Branch %s set up to track local ref %s.\n"),
 			       local, remote);
 		else
 			die("BUG: impossible combination of %d and %p",
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
1.8.2.1.350.g7baa3ba
