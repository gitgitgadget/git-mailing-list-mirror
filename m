From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv5 13/16] t7601 (merge-pull-config): add missing &&
Date: Sat,  2 Oct 2010 23:10:41 -0600
Message-ID: <1286082644-31595-14-git-send-email-newren@gmail.com>
References: <1286082644-31595-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, avarab@gmail.com, jrnieder@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 03 07:10:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2Gpu-0001zH-1p
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 07:10:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752558Ab0JCFJq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 01:09:46 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:60045 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752339Ab0JCFJo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 01:09:44 -0400
Received: by mail-pz0-f46.google.com with SMTP id 34so1066499pzk.19
        for <git@vger.kernel.org>; Sat, 02 Oct 2010 22:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=yYtka3fgYfdNkM9QzaqYrAploQGwcGmaZ326EypNdzY=;
        b=PTjKpt5Qs4GOZ8ENBB9dtJEunyVgC2Xyoc6UBluYx7r3hBAGeThBewbXx3MW7Sfoe4
         JsLH1HW3Gj/qSM+tvtQ5UPmb17Fb7nuqJxC2eN5INwSCHtZt3FYxrjHOSF9uFP/8C2St
         NiA6axa743WFBxYmJq2WMKKK3ie5kmLgpeH3k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=SsBBGNQDogbEqZ4ESQEO3HtxVrCI/AP2SVw5vkhLQr+eiuPffbdcBGtXPPF5M4O/HI
         02txGy4iFsrqu5+S2ShfjdkYUzYBBemCutuP0pfYXwiK4S996PpqPNJG0yV8LJIcrR0i
         P6jrTpVLTFGRFckyWuIekVLdAbBiJfniaQrI8=
Received: by 10.142.246.14 with SMTP id t14mr768044wfh.13.1286082584293;
        Sat, 02 Oct 2010 22:09:44 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id o16sm4140250wfh.19.2010.10.02.22.09.42
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 02 Oct 2010 22:09:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.66.gab790
In-Reply-To: <1286082644-31595-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157840>

Also prefix several relevant git merge commands with 'test_must_fail' t=
o
keep the tests passing.

Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
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
