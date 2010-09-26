From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv4 07/15] t4019 (diff-wserror): add lots of missing &&
Date: Sun, 26 Sep 2010 17:14:31 -0600
Message-ID: <1285542879-16381-8-git-send-email-newren@gmail.com>
References: <1285542879-16381-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 27 01:14:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P00Pw-0005ch-3f
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 01:14:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758288Ab0IZXNU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Sep 2010 19:13:20 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:43680 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758249Ab0IZXNR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 19:13:17 -0400
Received: by mail-pw0-f46.google.com with SMTP id 6so1036112pwj.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 16:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=yODw6PcduKbnr1n95hAWshDv4SvjsUaqZ5DfJWHbLmA=;
        b=jtekZ+VjBQZDgjFW5/hEowjlyY/Ns0bp57ER8sBfchzGfRGow1fu3NSbMnYID9Krpr
         dkGlj/XE0XXkRW25Y2EIOQgtFQGprjlwyqgRoVYwR+Wts/qVdn6S45CvQYgVKVSGmbhR
         m50kQ1mhkrv20BR8GsXopUQEypSmGObQZL5DQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=viDx1ClMaVe5VHG5ToUCTia20W9QBYB9q+sd716IYJD0G6RicNK5PfW4hYAVlh8m0k
         tjZdW5A16k+ciaYXuvo1DQg+sQdjh9cQw7mGB9456ZqG4nznCZNvgCYcF+e89DtyaJ+P
         H2sb5P/05Cq+ybHUGZQkZrVgsY8aS8vP5vZHQ=
Received: by 10.114.39.18 with SMTP id m18mr7351628wam.196.1285542797246;
        Sun, 26 Sep 2010 16:13:17 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id c24sm9242157wam.19.2010.09.26.16.13.15
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 26 Sep 2010 16:13:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.95.g14291
In-Reply-To: <1285542879-16381-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157272>

Also add a test_might_fail in front of the final git_config --unset
core.whitespace as that value may have already been unset previously.

Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t4019-diff-wserror.sh |   52 +++++++++++++++++++++++----------------=
-------
 1 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/t/t4019-diff-wserror.sh b/t/t4019-diff-wserror.sh
index f6d1f1e..2557ec7 100755
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
+	git config --unset core.whitespace &&
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
+	git config --unset core.whitespace &&
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
+	git config --unset core.whitespace &&
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
+	git config --unset core.whitespace &&
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
1.7.3.95.g14291
