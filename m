From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv6 13/16] t7601 (merge-pull-config): add missing &&
Date: Sun,  3 Oct 2010 14:00:11 -0600
Message-ID: <1286136014-7728-14-git-send-email-newren@gmail.com>
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
	id 1P2Uie-0002yx-HH
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 21:59:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754900Ab0JCT7P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 15:59:15 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:52092 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754868Ab0JCT7N (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 15:59:13 -0400
Received: by mail-px0-f174.google.com with SMTP id 10so1157426pxi.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 12:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=mXiYuZmDX9uJWG3ntWhGeCd4HB8gEmgvUjuT9maXXcM=;
        b=GP5mXT75uDsph47SlQj5tEvwknfsbR9D10lqqwdaqJIZr8GWtS6YgVUDu9TPD9X4V1
         u3+rU9RzyFYDFU8AP9gTnck0iqDDudSSYI0mh57ozW770w4DxHsLUKgYJvejArRPsCL+
         UrE8Rczx92HdiesylXeVJQSz8ybS9JpC9bwP8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=mk1mM87ljFy7H+4rvse9H7IKrv+wpY48MYY1Cq3zc3jdY9mPeNyHqllcPI3PpfDbM0
         fVE8zT4nuNG+W3KRll3zrBzgc1SX6KozBNZFioPW1nCbRLstr6JR5Myi23B5eTrHMbvM
         hkH5gOPPSgRksIn3F0Qglkcbsh371xEjWC21U=
Received: by 10.114.47.4 with SMTP id u4mr10112165wau.128.1286135953275;
        Sun, 03 Oct 2010 12:59:13 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id d2sm7661138wam.14.2010.10.03.12.59.11
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 12:59:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.66.gab790
In-Reply-To: <1286136014-7728-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157911>

Also prefix several relevant git merge commands with 'test_must_fail' t=
o
keep the tests passing.

Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t7601-merge-pull-config.sh |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.s=
h
index 7ba94ea..b44b293 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -114,13 +114,13 @@ test_expect_success 'setup conflicted merge' '
 test_expect_success 'merge picks up the best result' '
 	git config --unset-all pull.twohead &&
 	git reset --hard c5 &&
-	git merge -s resolve c6
+	test_must_fail git merge -s resolve c6 &&
 	resolve_count=3D$(conflict_count) &&
 	git reset --hard c5 &&
-	git merge -s recursive c6
+	test_must_fail git merge -s recursive c6 &&
 	recursive_count=3D$(conflict_count) &&
 	git reset --hard c5 &&
-	git merge -s recursive -s resolve c6
+	test_must_fail git merge -s recursive -s resolve c6 &&
 	auto_count=3D$(conflict_count) &&
 	test $auto_count =3D $recursive_count &&
 	test $auto_count !=3D $resolve_count
@@ -129,13 +129,13 @@ test_expect_success 'merge picks up the best resu=
lt' '
 test_expect_success 'merge picks up the best result (from config)' '
 	git config pull.twohead "recursive resolve" &&
 	git reset --hard c5 &&
-	git merge -s resolve c6
+	test_must_fail git merge -s resolve c6 &&
 	resolve_count=3D$(conflict_count) &&
 	git reset --hard c5 &&
-	git merge -s recursive c6
+	test_must_fail git merge -s recursive c6 &&
 	recursive_count=3D$(conflict_count) &&
 	git reset --hard c5 &&
-	git merge c6
+	test_must_fail git merge c6 &&
 	auto_count=3D$(conflict_count) &&
 	test $auto_count =3D $recursive_count &&
 	test $auto_count !=3D $resolve_count
--=20
1.7.3.1.66.gab790
