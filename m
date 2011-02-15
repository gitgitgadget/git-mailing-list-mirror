From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/2] git.c: reorder builtin command list
Date: Tue, 15 Feb 2011 10:09:03 +0700
Message-ID: <1297739344-28961-1-git-send-email-pclouds@gmail.com>
References: <7vvd0ms9ra.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 15 04:06:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpBFY-0007bG-Lb
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 04:06:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398Ab1BODGg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Feb 2011 22:06:36 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:62221 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934Ab1BODGf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 22:06:35 -0500
Received: by pwj3 with SMTP id 3so8323pwj.19
        for <git@vger.kernel.org>; Mon, 14 Feb 2011 19:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=2PPOd8oPIcgUPt2/J+Urqz9vOSHrqs7eqjhWdXKGVIY=;
        b=UfBR8n5+AtNuiI/yupz+qtcWHXKEPch5CoIR3K2z9ddt4VlGXrg5or1MoSw2F9sMtS
         DIJqmUtCf3ROkGkXjeyBnTI8EZlvoAJVr8lw06krgSK9LIl01Bf5KoAHsLJ6d1R/Swwr
         p9uahZdy6P2QHXJi/pOaTLOjKA6fa88j3A+Ew=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=rosoCHDjlSGLVcdbNZsFRTHI37q592GoJ48rvY3VtS/FhltXF0BH+K4SV/yKFI+iZt
         mCKe26Fs11rqGTGXUbBKRPzlKISOmL+kElfi82SdLm4vD59wiiOjtNmcmMW3qHxfLEkh
         EZdrOUuyrGRIzY+HLB7dqnbvH8PGBY+WGTQDg=
Received: by 10.142.143.5 with SMTP id q5mr3748960wfd.187.1297739194522;
        Mon, 14 Feb 2011 19:06:34 -0800 (PST)
Received: from tre ([115.73.232.10])
        by mx.google.com with ESMTPS id f5sm5032248wfo.4.2011.02.14.19.06.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 Feb 2011 19:06:33 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Tue, 15 Feb 2011 10:09:08 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <7vvd0ms9ra.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166806>

The majority of commands is in alphabet order except some. Reorder
them so it's easier to locate a command by eye and able to binary
search.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 check-ref-format and check-attr are moved up compared to previous
 patch. I checked the order with qsort() so it should be correct.

 git.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/git.c b/git.c
index 23610aa..57701e3 100644
--- a/git.c
+++ b/git.c
@@ -313,7 +313,6 @@ static void handle_internal_command(int argc, const=
 char **argv)
 	const char *cmd =3D argv[0];
 	static struct cmd_struct commands[] =3D {
 		{ "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
-		{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
 		{ "annotate", cmd_annotate, RUN_SETUP },
 		{ "apply", cmd_apply, RUN_SETUP_GENTLY },
 		{ "archive", cmd_archive },
@@ -322,15 +321,15 @@ static void handle_internal_command(int argc, con=
st char **argv)
 		{ "branch", cmd_branch, RUN_SETUP },
 		{ "bundle", cmd_bundle, RUN_SETUP_GENTLY },
 		{ "cat-file", cmd_cat_file, RUN_SETUP },
+		{ "check-attr", cmd_check_attr, RUN_SETUP },
+		{ "check-ref-format", cmd_check_ref_format },
 		{ "checkout", cmd_checkout, RUN_SETUP | NEED_WORK_TREE },
 		{ "checkout-index", cmd_checkout_index,
 			RUN_SETUP | NEED_WORK_TREE},
-		{ "check-ref-format", cmd_check_ref_format },
-		{ "check-attr", cmd_check_attr, RUN_SETUP },
 		{ "cherry", cmd_cherry, RUN_SETUP },
 		{ "cherry-pick", cmd_cherry_pick, RUN_SETUP | NEED_WORK_TREE },
-		{ "clone", cmd_clone },
 		{ "clean", cmd_clean, RUN_SETUP | NEED_WORK_TREE },
+		{ "clone", cmd_clone },
 		{ "commit", cmd_commit, RUN_SETUP | NEED_WORK_TREE },
 		{ "commit-tree", cmd_commit_tree, RUN_SETUP },
 		{ "config", cmd_config, RUN_SETUP_GENTLY },
@@ -358,8 +357,8 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "init-db", cmd_init_db },
 		{ "log", cmd_log, RUN_SETUP },
 		{ "ls-files", cmd_ls_files, RUN_SETUP },
-		{ "ls-tree", cmd_ls_tree, RUN_SETUP },
 		{ "ls-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
+		{ "ls-tree", cmd_ls_tree, RUN_SETUP },
 		{ "mailinfo", cmd_mailinfo },
 		{ "mailsplit", cmd_mailsplit },
 		{ "merge", cmd_merge, RUN_SETUP | NEED_WORK_TREE },
@@ -379,6 +378,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "notes", cmd_notes, RUN_SETUP },
 		{ "pack-objects", cmd_pack_objects, RUN_SETUP },
 		{ "pack-redundant", cmd_pack_redundant, RUN_SETUP },
+		{ "pack-refs", cmd_pack_refs, RUN_SETUP },
 		{ "patch-id", cmd_patch_id },
 		{ "peek-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
 		{ "pickaxe", cmd_blame, RUN_SETUP },
@@ -401,8 +401,10 @@ static void handle_internal_command(int argc, cons=
t char **argv)
 		{ "rm", cmd_rm, RUN_SETUP },
 		{ "send-pack", cmd_send_pack, RUN_SETUP },
 		{ "shortlog", cmd_shortlog, RUN_SETUP_GENTLY | USE_PAGER },
-		{ "show-branch", cmd_show_branch, RUN_SETUP },
 		{ "show", cmd_show, RUN_SETUP },
+		{ "show-branch", cmd_show_branch, RUN_SETUP },
+		{ "show-ref", cmd_show_ref, RUN_SETUP },
+		{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
 		{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
 		{ "stripspace", cmd_stripspace },
 		{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
@@ -415,13 +417,11 @@ static void handle_internal_command(int argc, con=
st char **argv)
 		{ "update-server-info", cmd_update_server_info, RUN_SETUP },
 		{ "upload-archive", cmd_upload_archive },
 		{ "var", cmd_var, RUN_SETUP_GENTLY },
+		{ "verify-pack", cmd_verify_pack },
 		{ "verify-tag", cmd_verify_tag, RUN_SETUP },
 		{ "version", cmd_version },
 		{ "whatchanged", cmd_whatchanged, RUN_SETUP },
 		{ "write-tree", cmd_write_tree, RUN_SETUP },
-		{ "verify-pack", cmd_verify_pack },
-		{ "show-ref", cmd_show_ref, RUN_SETUP },
-		{ "pack-refs", cmd_pack_refs, RUN_SETUP },
 	};
 	int i;
 	static const char ext[] =3D STRIP_EXTENSION;
--=20
1.7.4.74.g639db
