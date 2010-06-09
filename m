From: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
Subject: [RFC/ PATCH 3/5] unpack_trees_options: update porcelain messages
Date: Wed,  9 Jun 2010 14:44:04 +0200
Message-ID: <1276087446-25112-5-git-send-email-diane.gasselin@ensimag.imag.fr>
References: <1276087446-25112-1-git-send-email-diane.gasselin@ensimag.imag.fr>
 <1276087446-25112-2-git-send-email-diane.gasselin@ensimag.imag.fr>
 <1276087446-25112-3-git-send-email-diane.gasselin@ensimag.imag.fr>
 <1276087446-25112-4-git-send-email-diane.gasselin@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Diane <diane.gasselin@ensimag.imag.fr>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?UTF-8?q?Cl=C3=A9ment=20Poulain?= 
	<clement.poulain@ensimag.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 09 15:20:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMLCz-00011z-QD
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 15:20:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757565Ab0FINUh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jun 2010 09:20:37 -0400
Received: from mx2.imag.fr ([129.88.30.17]:33559 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757472Ab0FINUf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jun 2010 09:20:35 -0400
Received: from ensikerberos.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o59Cb5kl022379
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 9 Jun 2010 14:37:07 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensikerberos.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id o59CinjY010558;
	Wed, 9 Jun 2010 14:44:49 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id o59Cinhg025400;
	Wed, 9 Jun 2010 14:44:49 +0200
Received: (from gasselid@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id o59Cin6Z025399;
	Wed, 9 Jun 2010 14:44:49 +0200
X-Mailer: git-send-email 1.6.6.7.ga5fe3
In-Reply-To: <1276087446-25112-4-git-send-email-diane.gasselin@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 09 Jun 2010 14:37:07 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o59Cb5kl022379
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: diane.gasselin@ensimag.imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148774>

=46rom: Diane <diane.gasselin@ensimag.imag.fr>

Update porcelain messages of unpack_trees_options in order to have a go=
od layout.

Signed-off-by: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
Signed-off-by: Axel Bonnet <axel.bonnet@ensimag.imag.fr>
Signed-off-by: Cl=C3=A9ment Poulain <clement.poulain@ensimag.imag.fr>
---
 builtin/checkout.c |    2 +-
 merge-recursive.c  |   10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 88b1f43..9b2dca6 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -372,7 +372,7 @@ static int merge_working_tree(struct checkout_opts =
*opts,
 		topts.src_index =3D &the_index;
 		topts.dst_index =3D &the_index;
=20
-		topts.msgs.not_uptodate_file =3D "You have local changes to '%s'; ca=
nnot switch branches.";
+		topts.msgs.not_uptodate_file =3D "You have local changes to:\n%scann=
ot switch branches.";
=20
 		refresh_cache(REFRESH_QUIET);
=20
diff --git a/merge-recursive.c b/merge-recursive.c
index 206c103..62c07ab 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1182,19 +1182,19 @@ struct unpack_trees_error_msgs get_porcelain_er=
ror_msgs(void)
 {
 	struct unpack_trees_error_msgs msgs =3D {
 		/* would_overwrite */
-		"Your local changes to '%s' would be overwritten by merge.  Aborting=
=2E",
+		"Your local changes to the files:\n%swould be overwritten by merge."=
,
 		/* not_uptodate_file */
-		"Your local changes to '%s' would be overwritten by merge.  Aborting=
=2E",
+		"Your local changes to the files:\n%swould be overwritten by merge."=
,
 		/* not_uptodate_dir */
-		"Updating '%s' would lose untracked files in it.  Aborting.",
+		"Updating the directories:\n%swould lose untracked files in it.",
 		/* would_lose_untracked */
-		"Untracked working tree file '%s' would be %s by merge.  Aborting",
+		"Untracked working tree files:\n%swould be %s by merge.",
 		/* bind_overlap -- will not happen here */
 		NULL,
 	};
 	if (advice_commit_before_merge) {
 		msgs.would_overwrite =3D msgs.not_uptodate_file =3D
-			"Your local changes to '%s' would be overwritten by merge.  Abortin=
g.\n"
+			"Your local changes to the files:\n%swould be overwritten by merge.=
\n"
 			"Please, commit your changes or stash them before you can merge.";
 	}
 	return msgs;
--=20
1.6.6.7.ga5fe3
