From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv5 08/16] t4019 (diff-wserror): add lots of missing &&
Date: Sat,  2 Oct 2010 23:10:36 -0600
Message-ID: <1286082644-31595-9-git-send-email-newren@gmail.com>
References: <1286082644-31595-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, avarab@gmail.com, jrnieder@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 03 07:10:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2Gpr-0001zH-Be
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 07:10:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184Ab0JCFJe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 01:09:34 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:51054 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886Ab0JCFJc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 01:09:32 -0400
Received: by mail-px0-f174.google.com with SMTP id 10so1068077pxi.19
        for <git@vger.kernel.org>; Sat, 02 Oct 2010 22:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=h7NxYVXKJgN8DWOXLqFsoGY4Y/lMk3FNMV/RnvXrDCc=;
        b=VO8WPIEhmNZuePvNdHpPCoYKBDQ0nP0LmRSpISiSMFcORT2fMQ1ZEnMVQ2W912C96O
         r9KVAZ5zvb2ErsV6GvOsrkbLifNokc8cG2m+rLsQ/NdrCwKxOKMaM2HOIWnRWvVfo9FR
         dA2EXH2dLalAFynjPqCW5KVa8LDv0On+hw+e8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=skmjPkkEcwXaGGwnNTRA2X5/tbsTrvU/mBxyTGUY7S+iTQAN3RFgVBrXtOEde1ZE93
         6r6vsODeaWM24BVwJ1x/CQq/S1RhG6DYR6fjk8PkHv2qA+oFEowM4/ccSV9AjFGQvWRS
         ERfmJpRys3Af38iL0keL4eG1OUoAjpmfmjt+s=
Received: by 10.142.48.2 with SMTP id v2mr2441918wfv.276.1286082572339;
        Sat, 02 Oct 2010 22:09:32 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id o16sm4140250wfh.19.2010.10.02.22.09.29
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 02 Oct 2010 22:09:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.66.gab790
In-Reply-To: <1286082644-31595-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157837>

Also add test_might_fail in front of the git_config --unset commands th=
at
may be trying to unset a value that never got set (due to a previous
failing test) or that were already unset.

Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t4019-diff-wserror.sh |   52 +++++++++++++++++++++++----------------=
-------
 1 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/t/t4019-diff-wserror.sh b/t/t4019-diff-wserror.sh
index f6d1f1e..36f06c7 100755
--- a/t/t4019-diff-wserror.sh
+++ b/t/t4019-diff-wserror.sh
@@ -40,7 +40,7 @@ prepare_output () {
=20
 test_expect_success default '
=20
-	prepare_output
+	prepare_output &&
=20
 	grep Eight normal >/dev/null &&
 	grep HT error >/dev/null &&
@@ -52,8 +52,8 @@ test_expect_success default '
=20
 test_expect_success 'without -trail' '
=20
-	git config core.whitespace -trail
-	prepare_output
+	git config core.whitespace -trail &&
+	prepare_output &&
=20
 	grep Eight normal >/dev/null &&
 	grep HT error >/dev/null &&
@@ -65,9 +65,9 @@ test_expect_success 'without -trail' '
=20
 test_expect_success 'without -trail (attribute)' '
=20
-	git config --unset core.whitespace
-	echo "F whitespace=3D-trail" >.gitattributes
-	prepare_output
+	test_might_fail git config --unset core.whitespace &&
+	echo "F whitespace=3D-trail" >.gitattributes &&
+	prepare_output &&
=20
 	grep Eight normal >/dev/null &&
 	grep HT error >/dev/null &&
@@ -79,9 +79,9 @@ test_expect_success 'without -trail (attribute)' '
=20
 test_expect_success 'without -space' '
=20
-	rm -f .gitattributes
-	git config core.whitespace -space
-	prepare_output
+	rm -f .gitattributes &&
+	git config core.whitespace -space &&
+	prepare_output &&
=20
 	grep Eight normal >/dev/null &&
 	grep HT normal >/dev/null &&
@@ -93,9 +93,9 @@ test_expect_success 'without -space' '
=20
 test_expect_success 'without -space (attribute)' '
=20
-	git config --unset core.whitespace
-	echo "F whitespace=3D-space" >.gitattributes
-	prepare_output
+	test_might_fail git config --unset core.whitespace &&
+	echo "F whitespace=3D-space" >.gitattributes &&
+	prepare_output &&
=20
 	grep Eight normal >/dev/null &&
 	grep HT normal >/dev/null &&
@@ -107,9 +107,9 @@ test_expect_success 'without -space (attribute)' '
=20
 test_expect_success 'with indent-non-tab only' '
=20
-	rm -f .gitattributes
-	git config core.whitespace indent,-trailing,-space
-	prepare_output
+	rm -f .gitattributes &&
+	git config core.whitespace indent,-trailing,-space &&
+	prepare_output &&
=20
 	grep Eight error >/dev/null &&
 	grep HT normal >/dev/null &&
@@ -121,9 +121,9 @@ test_expect_success 'with indent-non-tab only' '
=20
 test_expect_success 'with indent-non-tab only (attribute)' '
=20
-	git config --unset core.whitespace
-	echo "F whitespace=3Dindent,-trailing,-space" >.gitattributes
-	prepare_output
+	test_might_fail git config --unset core.whitespace &&
+	echo "F whitespace=3Dindent,-trailing,-space" >.gitattributes &&
+	prepare_output &&
=20
 	grep Eight error >/dev/null &&
 	grep HT normal >/dev/null &&
@@ -135,9 +135,9 @@ test_expect_success 'with indent-non-tab only (attr=
ibute)' '
=20
 test_expect_success 'with cr-at-eol' '
=20
-	rm -f .gitattributes
-	git config core.whitespace cr-at-eol
-	prepare_output
+	rm -f .gitattributes &&
+	git config core.whitespace cr-at-eol &&
+	prepare_output &&
=20
 	grep Eight normal >/dev/null &&
 	grep HT error >/dev/null &&
@@ -149,9 +149,9 @@ test_expect_success 'with cr-at-eol' '
=20
 test_expect_success 'with cr-at-eol (attribute)' '
=20
-	git config --unset core.whitespace
-	echo "F whitespace=3Dtrailing,cr-at-eol" >.gitattributes
-	prepare_output
+	test_might_fail git config --unset core.whitespace &&
+	echo "F whitespace=3Dtrailing,cr-at-eol" >.gitattributes &&
+	prepare_output &&
=20
 	grep Eight normal >/dev/null &&
 	grep HT error >/dev/null &&
@@ -179,11 +179,11 @@ test_expect_success 'trailing empty lines (2)' '
 '
=20
 test_expect_success 'do not color trailing cr in context' '
-	git config --unset core.whitespace
+	test_might_fail git config --unset core.whitespace &&
 	rm -f .gitattributes &&
 	echo AAAQ | tr Q "\015" >G &&
 	git add G &&
-	echo BBBQ | tr Q "\015" >>G
+	echo BBBQ | tr Q "\015" >>G &&
 	git diff --color G | tr "\015" Q >output &&
 	grep "BBB.*${blue_grep}Q" output &&
 	grep "AAA.*\[mQ" output
--=20
1.7.3.1.66.gab790
