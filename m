From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH] Add NEED_WORK_TREE for more commands
Date: Sat, 27 Oct 2007 15:19:10 +0700
Message-ID: <20071027081910.GA23381@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 27 10:19:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlgtH-00054N-HB
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 10:19:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751705AbXJ0ITU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Oct 2007 04:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751639AbXJ0ITT
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Oct 2007 04:19:19 -0400
Received: from rv-out-0910.google.com ([209.85.198.191]:38061 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485AbXJ0ITS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2007 04:19:18 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1014365rvb
        for <git@vger.kernel.org>; Sat, 27 Oct 2007 01:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent;
        bh=cXYiYGRemZEu82hSF/1h8m+8g8URDWU/mCG1JyRrU0A=;
        b=OhWyv1nM3EujU1GD+lsHI23ynzbDoYFrMsAlOFbMtOLxpjmvPCEJPISDo6290Ne+S5N0FOiFu5GSFZjEqjf/JVpU7bwl+9hxWz3lTCp423ywyDq8eWWCB9KdXwxO6AWcyVNUXfgOyrZZOwkm+UccFrfnmRhM+4SF36zac0wH63s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent;
        b=LJErjkvCCkxAqLBJJ6L8K9Brx8hYQV/tPbP8/+usB59ih8lnubFB683qxok9gu432h955qNI0CBMyCh+WTDOaqa6/fAzZIgQ6kcsRHdOHfdZcH2jh25lE2+Fy47BadnG10Fx1jvoEP143JM8Vcdg1s0WBThWOREe0ga5l+TzQ/E=
Received: by 10.141.161.6 with SMTP id n6mr1907289rvo.1193473157589;
        Sat, 27 Oct 2007 01:19:17 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.1.6])
        by mx.google.com with ESMTPS id l31sm8247327rvb.2007.10.27.01.19.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 27 Oct 2007 01:19:16 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 27 Oct 2007 15:19:10 +0700
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62469>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 git.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/git.c b/git.c
index 23a430c..9db40b3 100644
--- a/git.c
+++ b/git.c
@@ -307,10 +307,10 @@ static void handle_internal_command(int argc, con=
st char **argv)
 	const char *cmd =3D argv[0];
 	static struct cmd_struct commands[] =3D {
 		{ "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
-		{ "annotate", cmd_annotate, RUN_SETUP },
+		{ "annotate", cmd_annotate, RUN_SETUP | NEED_WORK_TREE },
 		{ "apply", cmd_apply },
 		{ "archive", cmd_archive },
-		{ "blame", cmd_blame, RUN_SETUP },
+		{ "blame", cmd_blame, RUN_SETUP | NEED_WORK_TREE },
 		{ "branch", cmd_branch, RUN_SETUP },
 		{ "bundle", cmd_bundle },
 		{ "cat-file", cmd_cat_file, RUN_SETUP },
@@ -333,7 +333,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "fetch--tool", cmd_fetch__tool, RUN_SETUP },
 		{ "fmt-merge-msg", cmd_fmt_merge_msg, RUN_SETUP },
 		{ "for-each-ref", cmd_for_each_ref, RUN_SETUP },
-		{ "format-patch", cmd_format_patch, RUN_SETUP },
+		{ "format-patch", cmd_format_patch, RUN_SETUP | NEED_WORK_TREE },
 		{ "fsck", cmd_fsck, RUN_SETUP },
 		{ "fsck-objects", cmd_fsck, RUN_SETUP },
 		{ "gc", cmd_gc, RUN_SETUP },
@@ -346,7 +346,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "init", cmd_init_db },
 		{ "init-db", cmd_init_db },
 		{ "log", cmd_log, RUN_SETUP | USE_PAGER },
-		{ "ls-files", cmd_ls_files, RUN_SETUP },
+		{ "ls-files", cmd_ls_files, RUN_SETUP | NEED_WORK_TREE },
 		{ "ls-tree", cmd_ls_tree, RUN_SETUP },
 		{ "mailinfo", cmd_mailinfo },
 		{ "mailsplit", cmd_mailsplit },
@@ -363,7 +363,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "reflog", cmd_reflog, RUN_SETUP },
 		{ "repo-config", cmd_config },
 		{ "rerere", cmd_rerere, RUN_SETUP },
-		{ "reset", cmd_reset, RUN_SETUP },
+		{ "reset", cmd_reset, RUN_SETUP | NEED_WORK_TREE },
 		{ "rev-list", cmd_rev_list, RUN_SETUP },
 		{ "rev-parse", cmd_rev_parse, RUN_SETUP },
 		{ "revert", cmd_revert, RUN_SETUP | NEED_WORK_TREE },
@@ -377,7 +377,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "tag", cmd_tag, RUN_SETUP },
 		{ "tar-tree", cmd_tar_tree },
 		{ "unpack-objects", cmd_unpack_objects, RUN_SETUP },
-		{ "update-index", cmd_update_index, RUN_SETUP },
+		{ "update-index", cmd_update_index, RUN_SETUP | NEED_WORK_TREE },
 		{ "update-ref", cmd_update_ref, RUN_SETUP },
 		{ "upload-archive", cmd_upload_archive },
 		{ "verify-tag", cmd_verify_tag, RUN_SETUP },
--=20
1.5.3.rc4.3.gab089
