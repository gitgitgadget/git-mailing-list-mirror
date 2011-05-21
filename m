From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 24/48] i18n: git-submodule $errmsg messages
Date: Sat, 21 May 2011 18:44:05 +0000
Message-ID: <1306003469-22939-25-git-send-email-avarab@gmail.com>
References: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:47:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNrCm-0001Bj-No
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 20:47:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757213Ab1EUSqy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2011 14:46:54 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:64800 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756720Ab1EUSpY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 14:45:24 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1444610eyx.19
        for <git@vger.kernel.org>; Sat, 21 May 2011 11:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=ofumf82ZLuxZipuoL6BlJfcSW9ZTjYeboGpFnnYfV/A=;
        b=jvuDMPYZ5EjVKXWfOZ1+4Yio2veaotaL9CBMRuQtn0NaCeevaK/ddkRcD7ky5UFdnW
         YplzOWEhpoohDF2zE1CUAgvarIiHe94ZQZpWMoUCktDcdz47tgN+NQxI79juDabJ/nC+
         qQdEm5cWQAbs7Fpt3eGwzK7nYsHudevdJjhIU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=C3VYmm2SMe4UOelZ2+PCys2+fUhlqKO5qukps4qX0cUMVCWUw7LFcHYbq0OZzfJq0/
         4hUjJK3auBM5SKW+IrdvOAnPXF7KsfvSPpeUD/qQf750VrpG5UBNNNpC1c1TqUU0Ac/S
         2+LiCRlDMIwMZNLhadAJ0TZJwF3qg2RKO7SaI=
Received: by 10.14.44.197 with SMTP id n45mr279221eeb.146.1306003523875;
        Sat, 21 May 2011 11:45:23 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id y14sm1130434eeh.3.2011.05.21.11.45.23
        (version=SSLv3 cipher=OTHER);
        Sat, 21 May 2011 11:45:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174153>

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
index 60ea58e..5de34e4 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -678,13 +678,13 @@ cmd_summary() {
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
1.7.5.1
