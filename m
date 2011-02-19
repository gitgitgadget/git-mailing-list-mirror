From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 52/72] gettextize: git-push "prevent you from losing" message
Date: Sat, 19 Feb 2011 19:24:35 +0000
Message-ID: <1298143495-3681-53-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:28:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsTr-0003Eb-LG
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:28:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756194Ab1BST2W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:28:22 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:61282 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756068Ab1BST2L (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:28:11 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so2347203eye.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=pzHSLfdno55jWbaJNMN2Rfjm9ICEOANto7jzqqSRAIc=;
        b=yEAoihkd2AEOPXKDUhTeVV61YSc30LsLguk4QUMWm9E7EwIJa1oOxEDRNabcDecAIl
         WAMnJ1Hr8HwaCi2l+S6ey9U7G+KepnwC7qEmajS1T7zyzbscmqLWwhrKVU4d+/F5DNe9
         X2lfEoLIxvT94oQGUI+FukT7Kdemjmr5iElJw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=X4qsbvBH8AiNdQYX9C9MA+jvEoH2JBGgzGrN5GYa7RlC4BhnUFKvXm5EetCltJRJ2a
         oE3w2bcSAkuvAXqUeZDiJ9LI3vHjTgY4IdZcCdnK62a3T41UgO4hiw5LwfD+XBP3l5yc
         rYB2tMp1G3JTQCUghqYe2MyhwY5KtrHImtgj0=
Received: by 10.14.17.193 with SMTP id j41mr2420468eej.38.1298143690661;
        Sat, 19 Feb 2011 11:28:10 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.28.09
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:28:10 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167339>

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
index 3f24384..0f0b35a 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -157,7 +157,7 @@ test_http_push_nonff() {
 		grep "^ ! \[rejected\][ ]*$BRANCH -> $BRANCH (non-fast-forward)$" ou=
tput
 	'
=20
-	test_expect_success 'non-fast-forward push shows help message' '
+	test_expect_success NO_GETTEXT_POISON 'non-fast-forward push shows he=
lp message' '
 		grep "To prevent you from losing history, non-fast-forward updates w=
ere rejected" \
 			output
 	'
diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
index b0c2a2c..b341d8b 100755
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
+test_expect_success NO_GETTEXT_POISON 'push fails for non-fast-forward=
 refs unmatched by remote helper: our output' '
 	grep "To prevent you from losing history, non-fast-forward updates we=
re rejected" \
 		output
 '
--=20
1.7.2.3
