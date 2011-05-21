From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 23/48] i18n: git-submodule "Submodule change[...]" messages
Date: Sat, 21 May 2011 18:44:04 +0000
Message-ID: <1306003469-22939-24-git-send-email-avarab@gmail.com>
References: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:47:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNrCn-0001Bj-EU
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 20:47:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757217Ab1EUSq7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2011 14:46:59 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:45234 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756658Ab1EUSpX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 14:45:23 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1451059ewy.19
        for <git@vger.kernel.org>; Sat, 21 May 2011 11:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=xroQy/824WSlymJV0ld51xd724YpfFcdjDeOIkuoE4Y=;
        b=vENjQig6az2G6Sx5BltkxYG5DSH/uf8W7DDZqTCmI3Ozjui+iti40FlQaBW/o2x9kf
         MVSY7dyS9HGn2n6yi297WCqRchEcKP6u3ce33Q1c6bG8aEAeMZmzXA8QfimbhiD6lBec
         qsT4AOB3CAV5gfgE4TBtEp6u6OVVvqa7x8ZMM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=FxlyJ3+zl7Jmed6Gs7JPySTwdkxeFRqU0z/Z6gXoERzPd01sdP3M6h0RhuZqGg++xt
         CvnQ33e9CT4Xto7wHHGmHDGrB6IZSBsX1cJ7RoAS+TIBgNs9B3Ivfcwhj/ET9V3kjR1R
         ZmmCB9087Z1HCBsJgn8iyDRE6vrMG5yuHoaRQ=
Received: by 10.14.37.73 with SMTP id x49mr259626eea.164.1306003523027;
        Sat, 21 May 2011 11:45:23 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id y14sm1130434eeh.3.2011.05.21.11.45.22
        (version=SSLv3 cipher=OTHER);
        Sat, 21 May 2011 11:45:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174155>

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
index 444e1c5..60ea58e 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -745,9 +745,9 @@ cmd_summary() {
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
1.7.5.1
