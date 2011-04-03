From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 28/51] i18n: git-submodule "Entering [...]" message
Date: Sun,  3 Apr 2011 16:45:52 +0000
Message-ID: <1301849175-1697-29-git-send-email-avarab@gmail.com>
References: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 18:48:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6QTU-0005RJ-8i
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 18:48:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753292Ab1DCQsT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 12:48:19 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:57591 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752704Ab1DCQq6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 12:46:58 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1502912eyx.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 09:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=E0s0/7PZWpFgBf9/uc53y/RFlLDh/A5VJ99vLPWzZ+g=;
        b=ddbJSq28DAHgT/TjoUL13K0c4uGblYhFC61ccuqQL1izVtK5LymH9Llx2ucEYcf2Hr
         1B76eodT2o8vCuFl/qE3LkE/ZjB1ig/DdQ9LHlGwE7bnqDh/I35hAC/dPexnRa2kDbLq
         /tEKJueVYFqN4PU1jT47TFIilJGC0PuippwnE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=lmLkn4t2zIwGBRV83a/Cth6oYBZBU8uhnAoed2AvWvcz+N9d/PNDmFylJ64rLAXVVV
         gZpb4eBCNNqgI02moscA52/d7y6jipnelNE3Fv0efCZkJOWohGiarLe9UnXpHtmj5tyF
         w4Nxah9GBmW9h8b4JLQULypKXJWIQ5Zhki6Oo=
Received: by 10.14.9.231 with SMTP id 79mr2922137eet.241.1301849217700;
        Sun, 03 Apr 2011 09:46:57 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id w59sm2750567eeh.24.2011.04.03.09.46.56
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 09:46:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170744>

Gettextize the "Entering [...]" message. This is explicitly tested for
so we need to skip some tests with C_LOCALE_OUTPUT.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-submodule.sh             |    2 +-
 t/t7407-submodule-foreach.sh |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index b6c9a5b..fceacf8 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -289,7 +289,7 @@ cmd_foreach()
 	do
 		if test -e "$path"/.git
 		then
-			say "Entering '$prefix$path'"
+			say "$(eval_gettext "Entering '\$prefix\$path'")"
 			name=3D$(module_name "$path")
 			(
 				prefix=3D"$prefix$path/"
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.s=
h
index e5be13c..4aa2d34 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -68,7 +68,7 @@ Entering 'sub3'
 $pwd/clone-foo3-sub3-$sub3sha1
 EOF
=20
-test_expect_success 'test basic "submodule foreach" usage' '
+test_expect_success C_LOCALE_OUTPUT 'test basic "submodule foreach" us=
age' '
 	git clone super clone &&
 	(
 		cd clone &&
@@ -153,7 +153,7 @@ Entering 'sub2'
 Entering 'sub3'
 EOF
=20
-test_expect_success 'test messages from "foreach --recursive"' '
+test_expect_success C_LOCALE_OUTPUT 'test messages from "foreach --rec=
ursive"' '
 	(
 		cd clone2 &&
 		git submodule foreach --recursive "true" > ../actual
--=20
1.7.4.1
