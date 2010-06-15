From: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
Subject: [PATCH 3/5 v2] unpack_trees_options: update porcelain messages
Date: Tue, 15 Jun 2010 14:22:54 +0200
Message-ID: <1276604576-28092-4-git-send-email-diane.gasselin@ensimag.imag.fr>
References: <1276604576-28092-1-git-send-email-diane.gasselin@ensimag.imag.fr>
 <1276604576-28092-2-git-send-email-diane.gasselin@ensimag.imag.fr>
 <1276604576-28092-3-git-send-email-diane.gasselin@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	=?UTF-8?q?Cl=C3=A9ment=20Poulain?= 
	<clement.poulain@ensimag.imag.fr>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 15 14:23:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOVAt-0006TW-CO
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 14:23:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754995Ab0FOMXU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jun 2010 08:23:20 -0400
Received: from mx1.imag.fr ([129.88.30.5]:56986 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754820Ab0FOMXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 08:23:16 -0400
Received: from ensikerberos.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o5FCFAeB002479
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Tue, 15 Jun 2010 14:15:10 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensikerberos.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id o5FCNADp021134;
	Tue, 15 Jun 2010 14:23:10 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id o5FCNAI9028318;
	Tue, 15 Jun 2010 14:23:10 +0200
Received: (from gasselid@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id o5FCNAmQ028317;
	Tue, 15 Jun 2010 14:23:10 +0200
X-Mailer: git-send-email 1.6.6.7.ga5fe3
In-Reply-To: <1276604576-28092-3-git-send-email-diane.gasselin@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 15 Jun 2010 14:15:10 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o5FCFAeB002479
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: diane.gasselin@ensimag.imag.fr
MailScanner-NULL-Check: 1277208913.75245@6QZ8NW2mY1jwBfMveROPOQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149177>

Update porcelain messages of unpack_trees_options in order to have a go=
od layout
and add an advice for would_lose_untracked errors if advice_commit_befo=
re_merge
is enabled.

Update t3400 to have an expect_failure for the rebase verbose error mes=
sage.

Signed-off-by: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
Signed-off-by: Cl=C3=A9ment Poulain <clement.poulain@ensimag.imag.fr>
Signed-off-by: Axel Bonnet <axel.bonnet@ensimag.imag.fr>
---
 builtin/checkout.c |    2 +-
 merge-recursive.c  |   18 +++++++++---------
 t/t3400-rebase.sh  |    2 +-
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 23eae56..b9d056d 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -373,7 +373,7 @@ static int merge_working_tree(struct checkout_opts =
*opts,
 		topts.dst_index =3D &the_index;
=20
 		topts.msgs =3D get_porcelain_error_msgs("checkout");
-		topts.msgs.not_uptodate_file =3D "You have local changes to '%s'; ca=
nnot switch branches.";
+		topts.msgs.not_uptodate_file =3D "You have local changes to the foll=
owing files:\n%sCannot switch branches.";
=20
 		refresh_cache(REFRESH_QUIET);
=20
diff --git a/merge-recursive.c b/merge-recursive.c
index 80c9744..ee80553 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1183,31 +1183,31 @@ struct unpack_trees_error_msgs get_porcelain_er=
ror_msgs(const char *cmd)
 	struct unpack_trees_error_msgs msgs;
=20
 	/* would_overwrite */
-	msgs.would_overwrite =3D malloc(sizeof(char) * 72);
+	msgs.would_overwrite =3D malloc(sizeof(char) * 80);
 	sprintf((char *)msgs.would_overwrite,
-		"Your local changes to '%%s' would be overwritten by %s.  Aborting."=
,
+		"Your local changes to the following files would be overwritten by %=
s:\n%%s",
 		cmd);
 	/* not_uptodate_file */
 	msgs.not_uptodate_file =3D msgs.would_overwrite;
 	/* not_uptodate_dir */
 	msgs.not_uptodate_dir =3D
-		"Updating '%s' would lose untracked files in it.  Aborting.";
+		"Updating the following directories would lose untracked files in it=
:\n%s";
 	/* would_lose_untracked */
-	msgs.would_lose_untracked =3D malloc(sizeof(char) * 72);
+	msgs.would_lose_untracked =3D malloc(sizeof(char) * 80);
 	sprintf((char *)msgs.would_lose_untracked,
-		"Untracked working tree file '%%s' would be %%s by %s.  Aborting.",
+		"The following untracked working tree files would be %%s by %s:\n%%s=
",
 		cmd);
=20
 	if (advice_commit_before_merge) {
-		msgs.would_overwrite =3D malloc(sizeof(char) * 140);
+		msgs.would_overwrite =3D malloc(sizeof(char) * 160);
 		sprintf((char *)msgs.would_overwrite,
-			"Your local changes to '%%s' would be overwritten by %s.  Aborting.=
\n"
+			"Your local changes to the following files would be overwritten by =
%s:\n%%s"
 			"Please, commit your changes or stash them before you can %s.",
 			cmd, strcmp(cmd,"checkout") ? cmd : "swicth branches");
 		msgs.not_uptodate_file =3D msgs.would_overwrite;
-		msgs.would_lose_untracked =3D malloc (sizeof(char) * 135);
+		msgs.would_lose_untracked =3D malloc (sizeof(char) * 160);
 		sprintf((char *)msgs.would_lose_untracked,
-			"Untracked working tree file '%%s' would be %%s by %s.  Aborting.\n=
"
+			"The following untracked working tree files would be %%s by %s:\n%%=
s"
 			"Please move or remove them before you can %s.",
 			cmd, strcmp(cmd,"checkout") ? cmd : "swicth branches");
 	}
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index dbf7dfb..cbf160d 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -121,7 +121,7 @@ test_expect_success 'rebase a single mode change' '
      GIT_TRACE=3D1 git rebase master
 '
=20
-test_expect_success 'Show verbose error when HEAD could not be detache=
d' '
+test_expect_failure 'Show verbose error when HEAD could not be detache=
d' '
      : > B &&
      test_must_fail git rebase topic 2> output.err > output.out &&
      grep "Untracked working tree file .B. would be overwritten" outpu=
t.err
--=20
1.6.6.7.ga5fe3
