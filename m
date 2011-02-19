From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 26/72] gettextize: git-commit formatting messages
Date: Sat, 19 Feb 2011 19:24:09 +0000
Message-ID: <1298143495-3681-27-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:30:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsW2-0004Tk-Ny
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:30:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755978Ab1BSTab convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:30:31 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:56673 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755971Ab1BST1r (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:27:47 -0500
Received: by mail-ew0-f46.google.com with SMTP id 5so1970368ewy.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=Q7i4XLgh/Knn4v/9lm0ysoyxgljGEmLapOxNmwGIA1Q=;
        b=AxuknSXPPiUs9QGGMlHGiX/mwR4JYJ7LCJt+sF5/lAaaOA6LYdp7bouV+CpipnvAM1
         LR7f9IdfooR3NVdUp+vfprtfhc10Fkk4AIUBs9RfyEAkadkw48dtPk2guiFy8n1cwTDq
         /DF7PSp5SygZO4pWAJUp/oeeLt9Xdlq3epLZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=q1zqT045xRXCExGL3o5pf4Q5ihUy7dcwwKY3kYrU61pbPvsK4/KHtwJiAN3ot70MvM
         PNMhvI6iuLNQJNPY1JuaOajfPllPr6vDnc8RtSxh4/9C1intu3eOc9nNA1HC//0Us37+
         6agiwRuDn5oJPOivNPB+/N2izJwQczHj32JRk=
Received: by 10.213.27.202 with SMTP id j10mr2566292ebc.49.1298143666359;
        Sat, 19 Feb 2011 11:27:46 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.27.45
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:27:45 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167378>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/commit.c  |   12 ++++++------
 t/t7502-commit.sh |    4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 0198e90..c7c6c59 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -696,12 +696,12 @@ static int prepare_to_commit(const char *index_fi=
le, const char *prefix,
 		char *ai_tmp, *ci_tmp;
 		if (in_merge)
 			fprintf(fp,
-				"#\n"
+				_("#\n"
 				"# It looks like you may be committing a MERGE.\n"
 				"# If this is not correct, please remove the file\n"
 				"#	%s\n"
 				"# and try again.\n"
-				"#\n",
+				"#\n"),
 				git_path("MERGE_HEAD"));
=20
 		fprintf(fp,
@@ -725,15 +725,15 @@ static int prepare_to_commit(const char *index_fi=
le, const char *prefix,
 		ci_tmp =3D cut_ident_timestamp_part(committer_ident.buf);
 		if (strcmp(author_ident->buf, committer_ident.buf))
 			fprintf(fp,
-				"%s"
-				"# Author:    %s\n",
+				_("%s"
+				"# Author:    %s\n"),
 				ident_shown++ ? "" : "#\n",
 				author_ident->buf);
=20
 		if (!user_ident_sufficiently_given())
 			fprintf(fp,
-				"%s"
-				"# Committer: %s\n",
+				_("%s"
+				"# Committer: %s\n"),
 				ident_shown++ ? "" : "#\n",
 				committer_ident.buf);
=20
diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index 50da034..9204a4d 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -234,7 +234,7 @@ echo "#
 # Author:    $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
 #" >> expect
=20
-test_expect_success 'author different from committer' '
+test_expect_success NO_GETTEXT_POISON 'author different from committer=
' '
=20
 	echo >>negative &&
 	git commit -e -m "sample"
@@ -248,7 +248,7 @@ rm -f expect.tmp
 echo "# Committer:
 #" >> expect
=20
-test_expect_success 'committer is automatic' '
+test_expect_success NO_GETTEXT_POISON 'committer is automatic' '
=20
 	echo >>negative &&
 	(
--=20
1.7.2.3
