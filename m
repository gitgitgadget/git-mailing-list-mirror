From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 50/51] i18n: git-bisect [Y/n] messages
Date: Sun,  3 Apr 2011 16:46:14 +0000
Message-ID: <1301849175-1697-51-git-send-email-avarab@gmail.com>
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
	id 1Q6QTP-0005RJ-SF
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 18:48:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753217Ab1DCQrg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 12:47:36 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:59126 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753176Ab1DCQrX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 12:47:23 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1505877ewy.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 09:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=SrTiYVLDEbYwpn79dzstea1NNBrvAI8O6oivRk+/EcY=;
        b=EbCWlLCzsvKpILlHVDRoBzItlAsv8k38dSvxPMvOQDTb8JkEoodlAPUmvGYU2c8odp
         JC5l/LyYEWD0bpLux7UT/+adMyY+qI9AwkITFt5WZ+F/OemsVatLYoEZR90O3a7TBdmW
         xwMk+6lSILfQz60J2979Pn2a8vKeDsYIWf2rk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=cbffSwlJDolkCctbAj3hNDJsbMdCyPmq4VmNgAk3+MI0KsK7XJrVf13QA3kmKUfxAj
         6JarAqD7H1MXt2KW67Cqr6cxtfDl5tQPrZcKPFZQBgziLBAdkyjHbi5Tkpgf7H4WC5XB
         3dQB0hd/Q8yn0672OsjUp/Jt3XplUi4rdLaEk=
Received: by 10.213.34.193 with SMTP id m1mr3251756ebd.6.1301849242899;
        Sun, 03 Apr 2011 09:47:22 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id w59sm2750567eeh.24.2011.04.03.09.47.21
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 09:47:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170735>

Gettextize the [Y/n] questions git-bisect presents, and leave a note
in a TRANSLATORS comment explaining that translators have to preserve
a mention of the Y/n characters since the program will expect them,
and not their localized equivalents.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-bisect.sh |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index e05b53b..9bc18fe 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -39,7 +39,10 @@ bisect_autostart() {
 		echo >&2 "$(gettext "You need to start by \"git bisect start\"")"
 		if test -t 0
 		then
-			echo >&2 -n 'Do you want me to do it for you [Y/n]? '
+			# TRANSLATORS: Make sure to include [Y] and [n] in your
+			# translation. The program will only accept English input
+			# at this point.
+			echo >&2 -n "$(gettext "Do you want me to do it for you [Y/n]? ")"
 			read yesno
 			case "$yesno" in
 			[Nn]*)
@@ -242,7 +245,10 @@ bisect_next_check() {
 		echo >&2 "$(gettext "Warning: bisecting only with a bad commit.")"
 		if test -t 0
 		then
-			printf >&2 'Are you sure [Y/n]? '
+			# TRANSLATORS: Make sure to include [Y] and [n] in your
+			# translation. The program will only accept English input
+			# at this point.
+			printf >&2 "$(gettext "Are you sure [Y/n]? ")"
 			read yesno
 			case "$yesno" in [Nn]*) exit 1 ;; esac
 		fi
--=20
1.7.4.1
