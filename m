From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 25/48] i18n: git-submodule "Entering [...]" message
Date: Sun,  8 May 2011 12:20:57 +0000
Message-ID: <1304857280-14773-26-git-send-email-avarab@gmail.com>
References: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 14:22:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ309-0003rg-HO
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 14:22:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753965Ab1EHMWO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 08:22:14 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:48739 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752937Ab1EHMV5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 08:21:57 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1325631eyx.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 05:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=ZMH2uGcnZfrVeh7kjWhFn+QdFAHyl43/kDFkiOqyiMM=;
        b=SAa7QuGS8+FpuDAmVM9isaKAlRAhouXm0ZeYYqMpaSMZR6vA5JdhXfq/sIWNjs/Q5y
         5MO3dEwItICCGQmKqxxYQJgFNQFlztPt8Ez3Tmfr6VtGfW2cGprKEeo8YaITnbXb4me5
         NjMx2lzoUw3QsFvDrwGWicSM4cTWfL4R9p+xg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=oIY3CGZHqWbWOGkfSH2lWYGBry6tT30PAN+IOZoBi241D+NePsCBPx7zavipuERs3t
         dSQPeeNpcXWwNYSQo6ZH78LbFKIhUK7oVS4vg9Dyrbj0CwccL/v/5VKmZbwMlLmLDcw1
         gQkj3FdNpAKzI7hTZX5VKbW2EH4N8WUfCk9r4=
Received: by 10.14.53.134 with SMTP id g6mr2613952eec.6.1304857316487;
        Sun, 08 May 2011 05:21:56 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id n55sm2690046een.2.2011.05.08.05.21.55
        (version=SSLv3 cipher=OTHER);
        Sun, 08 May 2011 05:21:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173118>

Gettextize the "Entering [...]" message. This is explicitly tested for
so we need to skip a portion of a test with test_i18ncmp.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-submodule.sh             |    2 +-
 t/t7407-submodule-foreach.sh |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 7bebdf9..be63bc2 100755
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
1.7.4.4
