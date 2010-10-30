From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 072/161] gettextize: git-push "prevent you from losing" message
Date: Sat, 30 Oct 2010 08:16:10 +0000
Message-ID: <1288426571-7072-2-git-send-email-avarab@gmail.com>
References: <1288426571-7072-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Thomas Rast <trast@student.ethz.ch>,
	Christian Stimming <stimming@tuhh.de>,
	Thomas Hochstein <thh@inter.net>,
	Andreas Schwab <schwab@linux-m68k.org>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jan Engelhardt <jengelh@medozas.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 30 10:17:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PC6cX-0001Q9-Kw
	for gcvg-git-2@lo.gmane.org; Sat, 30 Oct 2010 10:17:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752560Ab0J3IQ5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Oct 2010 04:16:57 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:64202 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752539Ab0J3IQy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Oct 2010 04:16:54 -0400
Received: by mail-ww0-f44.google.com with SMTP id 15so4322813wwe.1
        for <git@vger.kernel.org>; Sat, 30 Oct 2010 01:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=ueB7s+GA/LsETy9fhVtT98FZ9KuMB+2Ef4J9uQr9s4M=;
        b=tTw3LG/2SGAu6K/BXabE3xhfVB76h4vLzipnNSMLAXqZpalh5fH2BsByWoYouLxtce
         7KXX9Hs6MpkqRYCA7VXxn/x+yyHMGDeeV3uthbAsI7cD1XrFSdPA5HLetCBcklgdA0yX
         0KWyh7OIHOQvGFwki+8dAl8c5HWQup6nee0kc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Pv5373pqmbSlMTCu/kbd5EGV/tBhdCxjjBiV+q+gdC1ghv/ME/5SkJ/JVySTMlUpr7
         sjPRJoUEKyXZ4QSugatdBLrBVFnrDz0GSqi/aXr2GDeiq/beXmnXjyh8/V9KigD9AsH2
         AiirO1Bs3rW1nuNpdaKeZ3FnmcrmL1Frz3CbM=
Received: by 10.227.143.194 with SMTP id w2mr13129232wbu.127.1288426613236;
        Sat, 30 Oct 2010 01:16:53 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id b30sm2924684wbb.22.2010.10.30.01.16.52
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 30 Oct 2010 01:16:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.50.g1e633
In-Reply-To: <1288426571-7072-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160392>

Gettextize the "To prevent you from losing history" message. A test in
lib-httpd.sh and another in t5541-http-push.sh explicitly checked for
this message. Change them to skip under GETTEXT_POISON=3DYesPlease.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

I've modified this to skip an additional test in t/t5541-http-push.sh
that started failing after recent modifications to that file in
upstream.

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
index e733f65..817b865 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -154,7 +154,7 @@ test_http_push_nonff() {
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
1.7.3.1.50.g1e633
