From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 12/43] apply: use RUN_SETUP_GENTLY
Date: Mon,  5 Apr 2010 20:40:57 +0200
Message-ID: <1270492888-26589-13-git-send-email-pclouds@gmail.com>
References: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 20:42:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyrFh-0005ZJ-Ja
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 20:42:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756003Ab0DESmX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Apr 2010 14:42:23 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:44752 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755864Ab0DESmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 14:42:16 -0400
Received: by fxm27 with SMTP id 27so1251549fxm.28
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 11:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=96FkAg5KkMP19B95NA5ShKzAeIdvYtn5qgocgp/KEU4=;
        b=N47zWw/xCG7obJB/tPHQg73K/F1hDFp97k5xWyLr9WjHl47/Ix4jcqvzi3l1W9Fmb4
         E7wWhEspR0OiQgs6eLYh+wv1OcVI8j6VcWdQIutbAGIb0IANhu7gpdMbmAgj2Dz27E3n
         PELJn7aHPC7s1IoPKmGCQjwp2OABnQmXVYz2E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ES5ZCsHhtlY2hkh1ylyf/vI2PJY2stKukJrjocWXxr6UnSclIYKAcM71vCVuGGkp5S
         1NGzMfv7brfzAxEUP0izWclb7UAmNeNKmNUmn1e6Zf3sLbBFSE+/VzXskkTLKubQN8ql
         MzRXEHx+g//mQMjNYXukcQId/7s/5TttfTdYw=
Received: by 10.87.63.31 with SMTP id q31mr9495228fgk.18.1270492934717;
        Mon, 05 Apr 2010 11:42:14 -0700 (PDT)
Received: from dektop ([212.247.124.209])
        by mx.google.com with ESMTPS id g28sm18262fkg.58.2010.04.05.11.42.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 11:42:13 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon,  5 Apr 2010 20:42:12 +0200
X-Mailer: git-send-email 1.7.0.rc1.541.g2da82.dirty
In-Reply-To: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144010>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c |    7 +++----
 git.c           |    2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 7ca9047..bb957d4 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3621,7 +3621,6 @@ int cmd_apply(int argc, const char **argv, const =
char *unused_prefix)
 {
 	int i;
 	int errs =3D 0;
-	int is_not_gitdir;
 	int binary;
 	int force_apply =3D 0;
=20
@@ -3694,7 +3693,7 @@ int cmd_apply(int argc, const char **argv, const =
char *unused_prefix)
 		OPT_END()
 	};
=20
-	prefix =3D setup_git_directory_gently(&is_not_gitdir);
+	prefix =3D startup_info->prefix;
 	prefix_length =3D prefix ? strlen(prefix) : 0;
 	git_config(git_apply_config, NULL);
 	if (apply_default_whitespace)
@@ -3709,10 +3708,10 @@ int cmd_apply(int argc, const char **argv, cons=
t char *unused_prefix)
 		apply =3D apply_verbosely =3D 1;
 	if (!force_apply && (diffstat || numstat || summary || check || fake_=
ancestor))
 		apply =3D 0;
-	if (check_index && is_not_gitdir)
+	if (check_index && !startup_info->have_repository)
 		die("--index outside a repository");
 	if (cached) {
-		if (is_not_gitdir)
+		if (!startup_info->have_repository)
 			die("--cached outside a repository");
 		check_index =3D 1;
 	}
diff --git a/git.c b/git.c
index 0e052c8..7820d22 100644
--- a/git.c
+++ b/git.c
@@ -294,7 +294,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
 		{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
 		{ "annotate", cmd_annotate, RUN_SETUP },
-		{ "apply", cmd_apply },
+		{ "apply", cmd_apply, RUN_SETUP_GENTLY },
 		{ "archive", cmd_archive, RUN_SETUP_GENTLY },
 		{ "bisect--helper", cmd_bisect__helper, RUN_SETUP | NEED_WORK_TREE }=
,
 		{ "blame", cmd_blame, RUN_SETUP },
--=20
1.7.0.rc1.541.g2da82.dirty
