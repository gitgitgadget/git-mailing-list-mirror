From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 23/48] i18n: git-submodule "Submodule change[...]" messages
Date: Sun,  8 May 2011 12:20:55 +0000
Message-ID: <1304857280-14773-24-git-send-email-avarab@gmail.com>
References: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 14:23:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ30x-0004Hv-C0
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 14:23:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753951Ab1EHMWN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 08:22:13 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:35010 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753603Ab1EHMVz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 08:21:55 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1327054ewy.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 05:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=8JRoIhfTFjIxJ7sohRvy4IMU47/QWyh7O7cHtFJNSeQ=;
        b=vlgKcA6rUFjY8sxNTMj1ACVhPPukxPPximvKLx/Vz316nn+wTyuz+p+TyLlQcwJahY
         UbYWjOywi78JYAN9GZMBUZCIIzEAHId/cYLuintUR/QCDivKF03aW+XjDRmEq/Q4+Vqc
         s7wv6GWaYpyl1OleAMn+X4pmSSGRti4l6Xo98=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ZZfPpcQwl6j25MeADJRzShxoWzeIjPTp1ShwxE4tPXknCBhe90wRYySDfwVi5xGLK7
         VopOycUacovWnVoJBIE7OmQ9eEdYt1xc8A3tpQ0qX6LoL514X/K62g10jGx4sHMqSpAn
         s6BypbFKkOYEC4by40GCkX4ZecyKrhkkFcI80=
Received: by 10.213.13.79 with SMTP id b15mr622207eba.95.1304857314616;
        Sun, 08 May 2011 05:21:54 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id n55sm2690046een.2.2011.05.08.05.21.53
        (version=SSLv3 cipher=OTHER);
        Sun, 08 May 2011 05:21:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173137>

Gettextize the "Submodules changed but not updated" and "Submodule
changes to be committed" messages. This is explicitly tested for so we
need to skip a portion of a test with test_i18ncmp.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-submodule.sh             |    4 ++--
 t/t7401-submodule-summary.sh |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index f0f885c3..7d2c51d 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -742,9 +742,9 @@ cmd_summary() {
 	done |
 	if test -n "$for_status"; then
 		if [ -n "$files" ]; then
-			echo "# Submodules changed but not updated:"
+			gettext "# Submodules changed but not updated:"; echo
 		else
-			echo "# Submodule changes to be committed:"
+			gettext "# Submodule changes to be committed:"; echo
 		fi
 		echo "#"
 		sed -e 's|^|# |' -e 's|^# $|#|'
diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.s=
h
index 7d7fde0..44ebc45 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -228,7 +228,7 @@ EOF
=20
 test_expect_success '--for-status' "
     git submodule summary --for-status HEAD^ >actual &&
-    test_cmp actual - <<EOF
+    test_i18ncmp actual - <<EOF
 # Submodule changes to be committed:
 #
 # * sm1 $head6...0000000:
--=20
1.7.4.4
