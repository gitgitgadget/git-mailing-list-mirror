From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv6 08/16] t4019 (diff-wserror): add lots of missing &&
Date: Sun,  3 Oct 2010 14:00:06 -0600
Message-ID: <1286136014-7728-9-git-send-email-newren@gmail.com>
References: <1286136014-7728-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, avarab@gmail.com, jrnieder@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 03 21:59:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2Uic-0002yx-Vs
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 21:59:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754881Ab0JCT7H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 15:59:07 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:55187 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754841Ab0JCT7C (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 15:59:02 -0400
Received: by pzk34 with SMTP id 34so1156376pzk.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 12:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=wdH/+U1W3b67Hf8rqPUywrxZBOnBw/Eu5ygR0mR/U7M=;
        b=TOwnO+liazaaGzFqpSMFmC00jHTG9wSpMV1jBU2n+x8JW5YKoL6CXwxkphvC9HRH6m
         HXof0UaM7eVSEg8XsKefVQoOKWPF3fPuIVNInCbP5wCeG3ngPasAzm3NYOREThChxqrK
         idH/+jJFqFzfoaTLmm+pm90pBdvJ1HmqQtStA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=k6zhIiQZTsFlWOomoxqU4LWm22B98izCH3/4y52z8HqdWGOTVpPEvloYuw8jTREKqY
         TL+MIyioJKdU7exo5lvKt7gb1Qp12yrS+QnfqKbfh3O7xe6XB/hqJRd1NyACUjgdFK/g
         Y3jqokgVYjJZHSNxavyjqGNaIlX8wVCEhAD5w=
Received: by 10.114.67.8 with SMTP id p8mr10115997waa.102.1286135941616;
        Sun, 03 Oct 2010 12:59:01 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id d2sm7661138wam.14.2010.10.03.12.58.59
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 12:59:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.66.gab790
In-Reply-To: <1286136014-7728-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157914>

Also add test_might_fail in front of the git_config --unset commands th=
at
may be trying to unset a value that never got set (due to a previous
failing test) or that were already unset.

Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t4019-diff-wserror.sh |   53 ++++++++++++++++++++++++---------------=
--------
 1 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/t/t4019-diff-wserror.sh b/t/t4019-diff-wserror.sh
index f6d1f1e..f7c85ec 100755
--- a/t/t4019-diff-wserror.sh
+++ b/t/t4019-diff-wserror.sh
@@ -36,11 +36,12 @@ prepare_output () {
 	git diff --color >output
 	$grep_a "$blue_grep" output >error
 	$grep_a -v "$blue_grep" output >normal
+	return 0
 }
=20
 test_expect_success default '
=20
-	prepare_output
+	prepare_output &&
=20
 	grep Eight normal >/dev/null &&
 	grep HT error >/dev/null &&
@@ -52,8 +53,8 @@ test_expect_success default '
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
@@ -65,9 +66,9 @@ test_expect_success 'without -trail' '
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
@@ -79,9 +80,9 @@ test_expect_success 'without -trail (attribute)' '
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
@@ -93,9 +94,9 @@ test_expect_success 'without -space' '
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
@@ -107,9 +108,9 @@ test_expect_success 'without -space (attribute)' '
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
@@ -121,9 +122,9 @@ test_expect_success 'with indent-non-tab only' '
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
@@ -135,9 +136,9 @@ test_expect_success 'with indent-non-tab only (attr=
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
@@ -149,9 +150,9 @@ test_expect_success 'with cr-at-eol' '
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
@@ -179,11 +180,11 @@ test_expect_success 'trailing empty lines (2)' '
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
