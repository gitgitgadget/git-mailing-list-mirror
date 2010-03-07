From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 15/18] help: use RUN_SETUP_GENTLY
Date: Sun,  7 Mar 2010 11:56:04 +0700
Message-ID: <1267937767-12504-16-git-send-email-pclouds@gmail.com>
References: <1267937767-12504-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 07 06:00:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No8be-0003VZ-Ej
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 06:00:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925Ab0CGFAd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Mar 2010 00:00:33 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:47112 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883Ab0CGFA2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 00:00:28 -0500
Received: by pvb32 with SMTP id 32so1119941pvb.19
        for <git@vger.kernel.org>; Sat, 06 Mar 2010 21:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=x5GUvdyq60Rqy95kMVddRFZfleNnWMxodga77Xqmf1g=;
        b=vNh7JThUV/uLv21edSpqxHQ/whOjCdS7H3JQ5oioghL6R33Eqg/F3ZxoWFl3L6OMzP
         v0008Wd3gwat2HF8uvhbxflN6z5ZSxi4n5hUCaz9+9quNHoq7nU50c3eUwMtHvoTYt87
         nxR+eLERe7teKJaebBYvItgx/KIQcRfBTKyP4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=KX1OmliYdo0/3LKotbVq5T8xX7cYhyJB4neL+PQq4oQ7bHmmyfdFyacU0gFFrqSBcL
         9ndIll40oKXb3aulNRR+Fw4YnqDO+gVvPcdjafUQtGgyzc7xj4PcBSmkPYdHGm9pUx20
         CXL52sT0Mw0x8L8Yt9DEsqoVnhyQW/3Qbn/9I=
Received: by 10.142.62.35 with SMTP id k35mr2056906wfa.197.1267938028630;
        Sat, 06 Mar 2010 21:00:28 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.223.3])
        by mx.google.com with ESMTPS id 20sm3269895pzk.11.2010.03.06.21.00.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Mar 2010 21:00:28 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun,  7 Mar 2010 11:57:13 +0700
X-Mailer: git-send-email 1.7.0.195.g637a2
In-Reply-To: <1267937767-12504-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141658>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/help.c |    2 --
 git.c          |    2 +-
 2 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index 3182a2b..4988629 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -414,7 +414,6 @@ static void show_html_page(const char *git_cmd)
=20
 int cmd_help(int argc, const char **argv, const char *prefix)
 {
-	int nongit;
 	const char *alias;
 	enum help_format parsed_help_format;
 	load_command_list("git-", &main_cmds, &other_cmds);
@@ -437,7 +436,6 @@ int cmd_help(int argc, const char **argv, const cha=
r *prefix)
 		return 0;
 	}
=20
-	setup_git_directory_gently(&nongit);
 	git_config(git_help_config, NULL);
=20
 	if (parsed_help_format !=3D HELP_FORMAT_NONE)
diff --git a/git.c b/git.c
index 02ba3b2..6a29756 100644
--- a/git.c
+++ b/git.c
@@ -331,7 +331,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "get-tar-commit-id", cmd_get_tar_commit_id },
 		{ "grep", cmd_grep, RUN_SETUP_GENTLY | USE_PAGER },
 		{ "hash-object", cmd_hash_object, RUN_SETUP_GENTLY },
-		{ "help", cmd_help },
+		{ "help", cmd_help, RUN_SETUP_GENTLY },
 		{ "index-pack", cmd_index_pack },
 		{ "init", cmd_init_db },
 		{ "init-db", cmd_init_db },
--=20
1.7.0.195.g637a2
