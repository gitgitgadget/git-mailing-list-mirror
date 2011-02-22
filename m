From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 53/73] gettextize: git-push "prevent you from losing" message
Date: Tue, 22 Feb 2011 23:42:12 +0000
Message-ID: <1298418152-27789-54-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:46:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1w6-0000rs-29
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:46:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755713Ab1BVXpy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:45:54 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:33701 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755550Ab1BVXoZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:44:25 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3866742bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=pdS+JpsCxH4PWs2fCWjPpb7VgSR7md5AIuvsc7lorhg=;
        b=HZ6ojXHrxOLLwTP+5+NCWW7+Yium7PxfdkwlFfwCuluzed3vGduF9MIo5XEBZ8Rj36
         U4GGH4Vu7Ar0YbxY2wgm4CWrzQYNX6GBW9MVrRA/4TjPlvqxn6cspU3HgiXnsmQ3J6lz
         03HI5EHn7GlXx6aELFm0zxLs55EBnmgkmXZmU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=SF80OhXW6RlxGl3auHj/BS5sjUZV/8k/Qryi2HPyPRZ/CHzPs0l9pSEyGo4oMH3uqL
         knOMLPaJBOmub7soMGhoseaAzqq1BAUdTQ0U8o571SnzoBna+T1qJnIdLM0fW8BsHUuC
         2NBsHylGFfcl3zm6qjWmExnk0647fG5pFkYXs=
Received: by 10.204.121.138 with SMTP id h10mr388759bkr.40.1298418265031;
        Tue, 22 Feb 2011 15:44:25 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.44.24
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:44:24 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167631>

Gettextize the "To prevent you from losing history" message. A test in
lib-httpd.sh and another in t5541-http-push.sh explicitly checked for
this message. Change them to skip under GETTEXT_POISON=3DYesPlease.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/push.c       |    4 ++--
 t/lib-httpd.sh       |    2 +-
 t/t5541-http-push.sh |    7 +++++--
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 513bc57..8c8d8c7 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -129,9 +129,9 @@ static int push_with_options(struct transport *tran=
sport, int flags)
 		return 0;
=20
 	if (nonfastforward && advice_push_nonfastforward) {
-		fprintf(stderr, "To prevent you from losing history, non-fast-forwar=
d updates were rejected\n"
+		fprintf(stderr, _("To prevent you from losing history, non-fast-forw=
ard updates were rejected\n"
 				"Merge the remote changes (e.g. 'git pull') before pushing again. =
 See the\n"
-				"'Note about fast-forwards' section of 'git push --help' for detai=
ls.\n");
+				"'Note about fast-forwards' section of 'git push --help' for detai=
ls.\n"));
 	}
=20
 	return 1;
diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 3f24384..d3829b8 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -157,7 +157,7 @@ test_http_push_nonff() {
 		grep "^ ! \[rejected\][ ]*$BRANCH -> $BRANCH (non-fast-forward)$" ou=
tput
 	'
=20
-	test_expect_success 'non-fast-forward push shows help message' '
+	test_expect_success C_LOCALE_OUTPUT 'non-fast-forward push shows help=
 message' '
 		grep "To prevent you from losing history, non-fast-forward updates w=
ere rejected" \
 			output
 	'
diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
index b0c2a2c..0492877 100755
--- a/t/t5541-http-push.sh
+++ b/t/t5541-http-push.sh
@@ -128,11 +128,14 @@ test_expect_success 'push fails for non-fast-forw=
ard refs unmatched by remote he
=20
 	# push master too; this ensures there is at least one '"'push'"' comm=
and to
 	# the remote helper and triggers interaction with the helper.
-	test_must_fail git push -v origin +master master:retsam >output 2>&1 =
&&
+	test_must_fail git push -v origin +master master:retsam >output 2>&1'
=20
+test_expect_success 'push fails for non-fast-forward refs unmatched by=
 remote helper: remote output' '
 	grep "^ + [a-f0-9]*\.\.\.[a-f0-9]* *master -> master (forced update)$=
" output &&
-	grep "^ ! \[rejected\] *master -> retsam (non-fast-forward)$" output =
&&
+	grep "^ ! \[rejected\] *master -> retsam (non-fast-forward)$" output
+'
=20
+test_expect_success C_LOCALE_OUTPUT 'push fails for non-fast-forward r=
efs unmatched by remote helper: our output' '
 	grep "To prevent you from losing history, non-fast-forward updates we=
re rejected" \
 		output
 '
--=20
1.7.2.3
