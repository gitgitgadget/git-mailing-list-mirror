From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 10/51] i18n: git-am core say messages
Date: Sun,  3 Apr 2011 16:45:34 +0000
Message-ID: <1301849175-1697-11-git-send-email-avarab@gmail.com>
References: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 18:47:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6QSG-00055g-A2
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 18:47:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752793Ab1DCQqm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 12:46:42 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:59126 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752757Ab1DCQqk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 12:46:40 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1505877ewy.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 09:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=cEaziwMh7BYhQXY1hGLvNqM6CWS3GKiJMou1HPyuJEE=;
        b=ctOri4M+ZvrJ9SpUQfFE8jSd6TYM2+UjcCs1xafvXCRCVNPVxKjSXxmb2TM8KSWU5e
         AQP44zio1dCQkUqdZhn5HRSp9yqQKPuo4uh0O9BeLOmql7N/SsGWSy5sq7CLg5HHrRMS
         HC59h5zyYdFib2kyluIwjHl1NfqmuwuGFSZo0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=dYhVo6MCNsGwDYV+Anu5ogb+asv9cBHzr8d27nNuyTf8xX0bBs9p9R3rKeowpsSRtt
         gZJzYcWQApnpPsrdE6VIKEFJbsa7XiFYrhtT+m33CtRuuulaiRyS32DHr9ZGJb0VHS4M
         GE9Q4Ok8hRe/KvoqbMr9H5rOE4akM63vl4evM=
Received: by 10.14.124.139 with SMTP id x11mr1451755eeh.219.1301849199946;
        Sun, 03 Apr 2011 09:46:39 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id w59sm2750567eeh.24.2011.04.03.09.46.39
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 09:46:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170713>

Make the core git-am messages that use say() translatable. These are
visible on almost every git am invocation.

There are tests that depend on the "Applying" output that need to be
skipped along with this translation.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-am.sh           |    6 +++---
 t/t4150-am.sh       |    5 ++++-
 t/t4151-am-abort.sh |    2 +-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 2c8770b..a15c5cc 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -739,7 +739,7 @@ To restore the original branch and stop patching ru=
n \"\$cmdline --abort\"."; ec
 		stop_here $this
 	fi
=20
-	say "Applying: $FIRSTLINE"
+	say "$(eval_gettext "Applying: \$FIRSTLINE")"
=20
 	case "$resolved" in
 	'')
@@ -784,7 +784,7 @@ did you forget to use 'git add'?"; echo
 		    # Applying the patch to an earlier tree and merging the
 		    # result may have produced the same tree as ours.
 		    git diff-index --quiet --cached HEAD -- && {
-			say No changes -- Patch already applied.
+			say "$(gettext "No changes -- Patch already applied.")"
 			go_next
 			continue
 		    }
@@ -810,7 +810,7 @@ did you forget to use 'git add'?"; echo
 			GIT_AUTHOR_DATE=3D
 		fi
 		parent=3D$(git rev-parse --verify -q HEAD) ||
-		say >&2 "applying to an empty history"
+		say >&2 "$(gettext "applying to an empty history")"
=20
 		if test -n "$committer_date_is_author_date"
 		then
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 850fc96..aa3d4ad 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -464,7 +464,10 @@ test_expect_success 'am newline in subject' '
 	git checkout first &&
 	test_tick &&
 	sed -e "s/second/second \\\n foo/" patch1 >patchnl &&
-	git am <patchnl >output.out 2>&1 &&
+	git am <patchnl >output.out 2>&1
+'
+
+test_expect_success C_LOCALE_OUTPUT 'output: am newline in subject' '
 	grep "^Applying: second \\\n foo$" output.out
 '
=20
diff --git a/t/t4151-am-abort.sh b/t/t4151-am-abort.sh
index c95c4cc..b9d8f5e 100755
--- a/t/t4151-am-abort.sh
+++ b/t/t4151-am-abort.sh
@@ -43,7 +43,7 @@ do
 		test_cmp expect actual
 	'
=20
-	test_expect_success "am$with3 --skip continue after failed am$with3" =
'
+	test_expect_success C_LOCALE_OUTPUT "am$with3 --skip continue after f=
ailed am$with3" '
 		test_must_fail git am$with3 --skip >output &&
 		test "$(grep "^Applying" output)" =3D "Applying: 6" &&
 		test_cmp file-2-expect file-2 &&
--=20
1.7.4.1
