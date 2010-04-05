From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 21/43] index-pack: use RUN_SETUP_GENTLY
Date: Mon,  5 Apr 2010 20:41:06 +0200
Message-ID: <1270492888-26589-22-git-send-email-pclouds@gmail.com>
References: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 20:43:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyrH3-0000ps-CT
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 20:43:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756080Ab0DESmr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Apr 2010 14:42:47 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:44752 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756042Ab0DESmm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 14:42:42 -0400
Received: by mail-fx0-f227.google.com with SMTP id 27so1251549fxm.28
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 11:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=08GXZT7FE2JN4NRc/b6iE7UJ8gmLJ7fQTK3BF0OldMc=;
        b=QYZDSsLb2tQ1/DxqA/5HD2NTS43qBUIvxdo8yBY41Fpz2lb5AaiFyOKyeA+MyEuyii
         zZxC4shHmvuXOqwiVclCVwFF7cIDbGmQHP8ZH5LOVyjDgM8Ho+BpBpcndpJ+knP/zCGs
         C+VISPd6myLJd7+SapFMuXNItYgbvn38CMmF0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=WuqFeAFOCaiacDg1DkOLOrKJiCJUxpl5ma57NpDlrNIt21BImwb+sitCIN4Cy5Z3yh
         dnRwOx8swe69EYzWOzT5sT/tpQ02jP5TXbubMRZEV4V151UTVT9HK6YdW5MkB3sKPUlL
         jQs++NjfoF68daF/Z4vsaopZPRh8IpiwKbNkQ=
Received: by 10.223.56.216 with SMTP id z24mr6012552fag.82.1270492960964;
        Mon, 05 Apr 2010 11:42:40 -0700 (PDT)
Received: from dektop ([212.247.124.209])
        by mx.google.com with ESMTPS id e17sm26897694fke.27.2010.04.05.11.42.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 11:42:40 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon,  5 Apr 2010 20:42:38 +0200
X-Mailer: git-send-email 1.7.0.rc1.541.g2da82.dirty
In-Reply-To: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144026>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/index-pack.c |    2 --
 git.c                |    2 +-
 2 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 2a6359d..9aa6a13 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -879,7 +879,6 @@ int cmd_index_pack(int argc, const char **argv, con=
st char *prefix)
 	char *index_name_buf =3D NULL, *keep_name_buf =3D NULL;
 	struct pack_idx_entry **idx_objects;
 	unsigned char pack_sha1[20];
-	int nongit;
=20
 	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
 		usage(index_pack_usage);
@@ -889,7 +888,6 @@ int cmd_index_pack(int argc, const char **argv, con=
st char *prefix)
 	 * However if the cwd was inside .git/objects/pack/ then we need
 	 * to go back there or all the pack name arguments will be wrong.
 	 */
-	prefix =3D setup_git_directory_gently(&nongit);
 	git_config(git_index_pack_config, NULL);
 	if (prefix && chdir(prefix))
 		die("Cannot come back to cwd");
diff --git a/git.c b/git.c
index 96c2d21..fac3d1c 100644
--- a/git.c
+++ b/git.c
@@ -332,7 +332,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "grep", cmd_grep, RUN_SETUP_GENTLY | USE_PAGER },
 		{ "hash-object", cmd_hash_object, RUN_SETUP_GENTLY },
 		{ "help", cmd_help },
-		{ "index-pack", cmd_index_pack },
+		{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY },
 		{ "init", cmd_init_db },
 		{ "init-db", cmd_init_db },
 		{ "log", cmd_log, RUN_SETUP | USE_PAGER },
--=20
1.7.0.rc1.541.g2da82.dirty
