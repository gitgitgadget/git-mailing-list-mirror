From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 27/51] i18n: git-submodule $errmsg messages
Date: Sun,  3 Apr 2011 16:45:51 +0000
Message-ID: <1301849175-1697-28-git-send-email-avarab@gmail.com>
References: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 18:47:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6QSK-00055g-PX
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 18:47:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753002Ab1DCQq6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 12:46:58 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:47128 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752963Ab1DCQq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 12:46:57 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1502908eyx.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 09:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=W6/w2BTEpgiHcNLae3+bq3gx/gPJOLR7MevVzuy2TQQ=;
        b=YXtIa9OLA84rqEL/QTI/o3AtPRThW0OWkCWOrk/gqvjwoPfPh/pPNNOTh1tTMKoiN+
         4yIcsQJPOvddPQLkTpqke7In5hozNmo1r3n565zvbKIcxSFjSJikIAKRThznKaLkbcxm
         IPSN0yMNFpSf90AACEXiM+QwUHsY9mWkSS100=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=BUEnb4nw0pYMBExQFUBmV24KmYDp9Eir682eFfJaPZNhdNEca8eMQMNWtJ0oOxsD7D
         BXr1BIjfquRWWCnrGPdPz3vrHvfLAmoc7DBfz3c3fSZ4t/A4rucyZj+XuNI8QiWrjwge
         g+OWAhdCozv0erP8A3ohUkqSCs1yswFYgQ2qk=
Received: by 10.14.50.132 with SMTP id z4mr2797062eeb.205.1301849216291;
        Sun, 03 Apr 2011 09:46:56 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id w59sm2750567eeh.24.2011.04.03.09.46.55
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 09:46:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170715>

Gettextize warning messages stored in the $errmsg variable using
eval_gettext interpolation. This is explicitly tested for so we need
to skip some tests with C_LOCALE_OUTPUT.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-submodule.sh             |    6 +++---
 t/t7401-submodule-summary.sh |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 5fe29a2..b6c9a5b 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -646,13 +646,13 @@ cmd_summary() {
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
index efd220b..1b703fb 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -155,7 +155,7 @@ EOF
 rm -f sm1 &&
 test_create_repo sm1 &&
 head6=3D$(add_file sm1 foo6 foo7)
-test_expect_success 'nonexistent commit' "
+test_expect_success C_LOCALE_OUTPUT 'nonexistent commit' "
     git submodule summary >actual &&
     cat >expected <<-EOF &&
 * sm1 $head4...$head6:
--=20
1.7.4.1
