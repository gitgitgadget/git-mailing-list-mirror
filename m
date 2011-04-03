From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 04/51] i18n: git-am eval_gettext messages
Date: Sun,  3 Apr 2011 16:45:28 +0000
Message-ID: <1301849175-1697-5-git-send-email-avarab@gmail.com>
References: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 18:46:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6QRl-0004uP-9y
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 18:46:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752768Ab1DCQqg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 12:46:36 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:47128 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752582Ab1DCQqf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 12:46:35 -0400
Received: by eyx24 with SMTP id 24so1502908eyx.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 09:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=Vs36vf7UZ9LR/JMLDSkpmEymIqjdcB6dknILftYue9Y=;
        b=vxNybPD/ZmT18epFpMKzPOypf7Hy9QixZyhdzFizsmNo2NrtxpnLCZIE9Un1e7Ewza
         u+1mIy8wUFxR/pOrKDXCD+qVQXsHPe3hotCqjjWPkhlhqSNydrTc+f0+Gbck0kb8DZsx
         CX3AG9JW7XGMxqubNO7XZ40Fi1HMH2nt96j6M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=w8wO90uAL3+waJ7V4GGCrbPNid60ihLMI71LjinaYLCIM1qou1VS0FanbIWqC39yMA
         JZkjmjcH42aao0uSS9BOBim6yv6LGUu53XseJ93yZsc8U7H98/WFyrj8c7mrLfKimfs+
         IuDdncFJ2eSM3UgDunnUJc5WoKM7EMQnsHzOo=
Received: by 10.14.9.231 with SMTP id 79mr2922019eet.241.1301849194237;
        Sun, 03 Apr 2011 09:46:34 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id w59sm2750567eeh.24.2011.04.03.09.46.33
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 09:46:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170709>

Messages that use variables to be interpolated need to use
eval_gettext(), this wrapper will eval the message and expand the
variable for us.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-am.sh |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 5a152b0..7c0273c 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -99,9 +99,9 @@ stop_here_user_resolve () {
 	    printf '%s\n' "$resolvemsg"
 	    stop_here $1
     fi
-    echo "When you have resolved this problem run \"$cmdline --resolve=
d\"."
-    echo "If you would prefer to skip this patch, instead run \"$cmdli=
ne --skip\"."
-    echo "To restore the original branch and stop patching run \"$cmdl=
ine --abort\"."
+    eval_gettext "When you have resolved this problem run \"\$cmdline =
--resolved\".
+If you would prefer to skip this patch, instead run \"\$cmdline --skip=
\".
+To restore the original branch and stop patching run \"\$cmdline --abo=
rt\"."; echo
=20
     stop_here $1
 }
@@ -608,9 +608,9 @@ do
 			go_next && continue
=20
 		test -s "$dotest/patch" || {
-			echo "Patch is empty.  Was it split wrong?"
-			echo "If you would prefer to skip this patch, instead run \"$cmdlin=
e --skip\"."
-			echo "To restore the original branch and stop patching run \"$cmdli=
ne --abort\"."
+			eval_gettext "Patch is empty.  Was it split wrong?
+If you would prefer to skip this patch, instead run \"\$cmdline --skip=
\".
+To restore the original branch and stop patching run \"\$cmdline --abo=
rt\"."; echo
 			stop_here $this
 		}
 		rm -f "$dotest/original-commit" "$dotest/author-script"
--=20
1.7.4.1
