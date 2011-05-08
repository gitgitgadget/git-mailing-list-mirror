From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 24/48] i18n: git-submodule $errmsg messages
Date: Sun,  8 May 2011 12:20:56 +0000
Message-ID: <1304857280-14773-25-git-send-email-avarab@gmail.com>
References: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 14:23:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ31P-0004a3-6I
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 14:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754139Ab1EHMX3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 08:23:29 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:56660 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753685Ab1EHMV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 08:21:56 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1327019ewy.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 05:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=xin77xTGrHrNDPo7S6q+8Z/MilFvDrrZOP+hIq3t9BY=;
        b=AGlztUBzVJJNYtWBjYO1U2WMH1EPP0Kr1QoxQU3u6cXktKK/6B7fYiG43a4NCCWvoM
         kz0G0CoIq5jMecvu1HgiylwAACv3yCfvO1OCPQLd8TXMKWuaVecVezXNb5tYUN+TRJqB
         iKx3RKjjpOuh42OEVFTtKYZxNVDuqsE84adi0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Tm0+e6PcoSgSBmYPB2O3baTTvcJgFqWBNkeHMB2gMgOgtY+Q+gfj7rdxj+7kKI2jwv
         e6X5ZPUXZr9JDxby/CTTRENOiO/M65nLRbtDDvnSNhJ4ONOkDKvq3X+gL4Dz2YX0t/FS
         RM/IkS1L52EsH5TD4thFC9rT6O2UBq+M80PD8=
Received: by 10.14.22.8 with SMTP id s8mr2775358ees.49.1304857315522;
        Sun, 08 May 2011 05:21:55 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id n55sm2690046een.2.2011.05.08.05.21.54
        (version=SSLv3 cipher=OTHER);
        Sun, 08 May 2011 05:21:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173148>

Gettextize warning messages stored in the $errmsg variable using
eval_gettext interpolation. This is explicitly tested for so we
need to skip a portion of a test with test_i18ncmp.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-submodule.sh             |    6 +++---
 t/t7401-submodule-summary.sh |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 7d2c51d..7bebdf9 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -675,13 +675,13 @@ cmd_summary() {
 		total_commits=3D
 		case "$missing_src,$missing_dst" in
 		t,)
-			errmsg=3D"  Warn: $name doesn't contain commit $sha1_src"
+			errmsg=3D"$(eval_gettext "  Warn: \$name doesn't contain commit \$s=
ha1_src")"
 			;;
 		,t)
-			errmsg=3D"  Warn: $name doesn't contain commit $sha1_dst"
+			errmsg=3D"$(eval_gettext "  Warn: \$name doesn't contain commit \$s=
ha1_dst")"
 			;;
 		t,t)
-			errmsg=3D"  Warn: $name doesn't contain commits $sha1_src and $sha1=
_dst"
+			errmsg=3D"$(eval_gettext "  Warn: \$name doesn't contain commits \$=
sha1_src and \$sha1_dst")"
 			;;
 		*)
 			errmsg=3D
diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.s=
h
index 44ebc45..cfa6632 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -162,7 +162,7 @@ test_expect_success 'nonexistent commit' "
   Warn: sm1 doesn't contain commit $head4_full
=20
 EOF
-    test_cmp actual expected
+    test_i18ncmp actual expected
 "
=20
 commit_file
--=20
1.7.4.4
