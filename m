From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 43/51] i18n: git-bisect echo + gettext messages
Date: Sun,  3 Apr 2011 16:46:07 +0000
Message-ID: <1301849175-1697-44-git-send-email-avarab@gmail.com>
References: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 18:48:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6QTQ-0005RJ-VA
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 18:48:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753239Ab1DCQrr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 12:47:47 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:57591 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753142Ab1DCQrQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 12:47:16 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1502912eyx.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 09:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=R8fNr/5D0KjX6pgg4Du6o/nHl7/7EvduXy30KBcA8l4=;
        b=B3nTOf24bwf9qV1fX8h9JDROgH1z/rkH9tJWGJ3dBuOQxJg2NceUxBhNdLIS+d8aGj
         7BwK540vZlfsfVIUBy97wh9oUA3ItnqhTlzEGUxbTzqcKdqnbgKtX63RpFHB2nbuL49O
         IfidlZwY0JzJ7dqNmw5hWJ/TMNi0megs+Dl5c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=NPL0Uu9XOkVS8SxhsQatLZYRsP0cWvyArkBr5nq9FgOUIZlrspuwl9nf4V8et10IRz
         f7Sr6MZrqa/tKgtcZ7MUfrMkCpd8sXolItfdjxltukbia/s13W1ifvwRdV1D5dTk/+zn
         ZC5Pqs5FuZbLhEugO5mkvi5lk9DgMYltLJDkE=
Received: by 10.213.97.7 with SMTP id j7mr3173478ebn.112.1301849235279;
        Sun, 03 Apr 2011 09:47:15 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id w59sm2750567eeh.24.2011.04.03.09.47.14
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 09:47:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170734>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-bisect.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 4420b46..80607dc 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -36,7 +36,7 @@ _x40=3D"$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
=20
 bisect_autostart() {
 	test -s "$GIT_DIR/BISECT_START" || {
-		echo >&2 'You need to start by "git bisect start"'
+		echo >&2 "$(gettext "You need to start by \"git bisect start\"")"
 		if test -t 0
 		then
 			echo >&2 -n 'Do you want me to do it for you [Y/n]? '
@@ -239,7 +239,7 @@ bisect_next_check() {
 	t,,good)
 		# have bad but not good.  we could bisect although
 		# this is less optimum.
-		echo >&2 'Warning: bisecting only with a bad commit.'
+		echo >&2 "$(gettext "Warning: bisecting only with a bad commit.")"
 		if test -t 0
 		then
 			printf >&2 'Are you sure [Y/n]? '
@@ -403,7 +403,7 @@ bisect_run () {
=20
       if sane_grep "first bad commit could be any of" "$GIT_DIR/BISECT=
_RUN" \
 		> /dev/null; then
-	  echo >&2 "bisect run cannot continue any more"
+	  echo >&2 "$(gettext "bisect run cannot continue any more")"
 	  exit $res
       fi
=20
--=20
1.7.4.1
