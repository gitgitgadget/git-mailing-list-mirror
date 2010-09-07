From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 19/20] gettextize: git-am core say messages
Date: Tue,  7 Sep 2010 16:48:33 +0000
Message-ID: <1283878113-19533-10-git-send-email-avarab@gmail.com>
References: <1283877955-19105-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 07 18:51:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ot1OD-0004K7-4l
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 18:51:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172Ab0IGQuV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Sep 2010 12:50:21 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:65530 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932081Ab0IGQuT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 12:50:19 -0400
Received: by mail-wy0-f174.google.com with SMTP id 22so4443062wyf.19
        for <git@vger.kernel.org>; Tue, 07 Sep 2010 09:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=pcxWsqWdtAhCy+GyuNbonPj5HOzFKERGNvt4Jj3b3e4=;
        b=lM2Ri0cDVHUhqSKCtIhRN0r0eVnKvJWtfLn/2mOuyd/pDjNkmRU3kvIxuCFdg2UIXM
         MBEQRaPbbZH4NCBey6+ucskAScO0FN9hd8Nw9osG1SQSfPYJPsUMe0DDntgsC9yioJ+G
         dEpUXgPr+/J3bgy4fKHm4+j2jRI+x9IEtHH78=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=gIYMX7VK6rU/ldnPXXXbLf3geefTPNS+O8vG+BmRUwGfJFTzyygLKT306bqbaSTK3I
         /leTD/uV1K1ZC6vMT3zohoek5B3AhCMlRZ5GB9KLYDr4+DEBCV9TFiKkl+4ZH25vL/ym
         cPDialDpQUXhs/CpZh5ToKV1hUtb41rCsnYq4=
Received: by 10.216.159.131 with SMTP id s3mr5250058wek.99.1283878218286;
        Tue, 07 Sep 2010 09:50:18 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id k46sm4304936weq.34.2010.09.07.09.50.15
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 07 Sep 2010 09:50:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
In-Reply-To: <1283877955-19105-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155721>

Make the core git-am messages that use say() translatable. These are
visible on almost every git am invocation.

There are tests that depend on the "Applying" output that need to be
skipped along with this translation.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-am.sh           |    6 +++---
 t/t4150-am.sh       |    4 +++-
 t/t4151-am-abort.sh |    2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 90f2a9d..6992d92 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -723,7 +723,7 @@ To restore the original branch and stop patching ru=
n \"\$cmdline --abort\"."; ec
 		stop_here $this
 	fi
=20
-	say "Applying: $FIRSTLINE"
+	say "$(eval_gettext "Applying: \$FIRSTLINE")"
=20
 	case "$resolved" in
 	'')
@@ -768,7 +768,7 @@ did you forget to use 'git add'?"; echo
 		    # Applying the patch to an earlier tree and merging the
 		    # result may have produced the same tree as ours.
 		    git diff-index --quiet --cached HEAD -- && {
-			say No changes -- Patch already applied.
+			say "$(gettext "No changes -- Patch already applied.")"
 			go_next
 			continue
 		    }
@@ -794,7 +794,7 @@ did you forget to use 'git add'?"; echo
 			GIT_AUTHOR_DATE=3D
 		fi
 		parent=3D$(git rev-parse --verify -q HEAD) ||
-		say >&2 "applying to an empty history"
+		say >&2 "$(gettext "applying to an empty history")"
=20
 		if test -n "$committer_date_is_author_date"
 		then
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 1c3d8ed..59ba994 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -464,7 +464,9 @@ test_expect_success 'am newline in subject' '
 	git checkout first &&
 	test_tick &&
 	sed -e "s/second/second \\\n foo/" patch1 >patchnl &&
-	git am <patchnl >output.out 2>&1 &&
+	git am <patchnl >output.out 2>&1'
+
+test_expect_success NO_GETTEXT_POISON 'output: am newline in subject' =
'
 	grep "^Applying: second \\\n foo$" output.out
 '
=20
diff --git a/t/t4151-am-abort.sh b/t/t4151-am-abort.sh
index b55c411..5bb24f8 100755
--- a/t/t4151-am-abort.sh
+++ b/t/t4151-am-abort.sh
@@ -43,7 +43,7 @@ do
 		test_cmp expect actual
 	'
=20
-	test_expect_success "am$with3 --skip continue after failed am$with3" =
'
+	test_expect_success NO_GETTEXT_POISON "am$with3 --skip continue after=
 failed am$with3" '
 		test_must_fail git am$with3 --skip >output &&
 		test "$(grep "^Applying" output)" =3D "Applying: 6" &&
 		test_cmp file-2-expect file-2 &&
--=20
1.7.2.3.313.gcd15
