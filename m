From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 25/48] i18n: git-submodule "Entering [...]" message
Date: Sat, 21 May 2011 18:44:06 +0000
Message-ID: <1306003469-22939-26-git-send-email-avarab@gmail.com>
References: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:47:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNrCm-0001Bj-0w
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 20:47:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757207Ab1EUSqw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2011 14:46:52 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42788 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198Ab1EUSpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 14:45:25 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1444603eyx.19
        for <git@vger.kernel.org>; Sat, 21 May 2011 11:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=MVszR/PWAJVhTBMQqSLI4GnZ2Fx/6EpBKYZZgkZC7vE=;
        b=fi5aoGTuBOb8nHkOKdVXNEkAy/sLLHqk77Afng1pAlQAd11f56guW1AZIxFCYn10/c
         boGfzILRV4u7NNu18OW+9kX+KKIZkNepOS0QwkrXnO3P6lgDAdttQhu3dK3PpZ/2EEkA
         cYB8xScxxvL4FT6alAPtRXLfXSkqihfhakj30=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=uNmg60QI0lRlyQr6IK/MIAjjyCLRlCaIyH+IoCAOP2ndaimc0v5mpE2L7pub04HayP
         RWiq7Ii8zQmRWERbJtYrchaj17om95c4jfPTnpO/7mVh5yCngvaLYzS1rvXn6gaswCY6
         ytkIzOBVm7DDl+6xYiYfZfh5kEONN8/XFQJyA=
Received: by 10.14.100.195 with SMTP id z43mr284048eef.31.1306003525302;
        Sat, 21 May 2011 11:45:25 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id y14sm1130434eeh.3.2011.05.21.11.45.23
        (version=SSLv3 cipher=OTHER);
        Sat, 21 May 2011 11:45:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174150>

Gettextize the "Entering [...]" message. This is explicitly tested for
so we need to skip a portion of a test with test_i18ncmp.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-submodule.sh             |    2 +-
 t/t7407-submodule-foreach.sh |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 5de34e4..f7d7f51 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -306,7 +306,7 @@ cmd_foreach()
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
index e5be13c..ae3bd18 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -77,7 +77,7 @@ test_expect_success 'test basic "submodule foreach" u=
sage' '
 		git config foo.bar zar &&
 		git submodule foreach "git config --file \"\$toplevel/.git/config\" =
foo.bar"
 	) &&
-	test_cmp expect actual
+	test_i18ncmp expect actual
 '
=20
 test_expect_success 'setup nested submodules' '
@@ -158,7 +158,7 @@ test_expect_success 'test messages from "foreach --=
recursive"' '
 		cd clone2 &&
 		git submodule foreach --recursive "true" > ../actual
 	) &&
-	test_cmp expect actual
+	test_i18ncmp expect actual
 '
=20
 cat > expect <<EOF
--=20
1.7.5.1
