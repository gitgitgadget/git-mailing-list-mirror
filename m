From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 04/48] i18n: git-am eval_gettext messages
Date: Sun,  8 May 2011 12:20:36 +0000
Message-ID: <1304857280-14773-5-git-send-email-avarab@gmail.com>
References: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 14:21:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ2zc-0003bV-DD
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 14:21:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753347Ab1EHMVl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 08:21:41 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:50701 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752937Ab1EHMVe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 08:21:34 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1327021ewy.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 05:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=z8J+rxgFIW729sh5EiD37VFGzt1q4MziyM5Ic0y49BY=;
        b=WKb7Lk4uqeikzaFZQMqB0pJSoda9mnCoQABwIDd5SHVV3Qv6qZ6oVKQRBTxHSpFT9N
         6O4EheGhbbXHeNh45TSPrh5w936BEQHe5UpsyKdr2obwNRfc8lf87w8iuMzwM1+ez0Dj
         g2zlVHNNeDywKA8cc0NlVqORaIsD1gR9B5KyY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=woHwvz2D2hBiLFgI0s90rKmGMQ6MYkn/fdC2ibm1u+AY1WeJ8t4J3gC7hHCKDauom5
         p7uXwtP5Nf16fUPRnvVWS66RNwRL+LTODkLLq+18MJReNtXSyw3xfTHIMdFOeVorEN7p
         ztGo1+6J4SeKsP9CoVcivJtWRUwkAsEcq1NYA=
Received: by 10.213.113.131 with SMTP id a3mr1950299ebq.36.1304857294076;
        Sun, 08 May 2011 05:21:34 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id n55sm2690046een.2.2011.05.08.05.21.32
        (version=SSLv3 cipher=OTHER);
        Sun, 08 May 2011 05:21:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173108>

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
1.7.4.4
