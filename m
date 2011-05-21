From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 47/48] i18n: git-bisect [Y/n] messages
Date: Sat, 21 May 2011 18:44:28 +0000
Message-ID: <1306003469-22939-48-git-send-email-avarab@gmail.com>
References: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:46:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNrC4-0000od-Au
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 20:46:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757129Ab1EUSqJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2011 14:46:09 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:64800 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757023Ab1EUSpq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 14:45:46 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1444610eyx.19
        for <git@vger.kernel.org>; Sat, 21 May 2011 11:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=7KQmXrGPBued7rGhcyhdxxMQcP5lDxQyRMU30tNI2JM=;
        b=R15n3gb/YOa8MRfj/+HC98v0JsnyVEV2Vd3K+uS7848Tto9StLa16NrA+yUjU0098I
         90XeX1vPcoCPwROtVsixmo53hKn/wIVwOtsmZsynVlwrZ2nfpoC9Gwd2DfGLl59KjF9Z
         Xv6djtK/rh/XVLY9d6M5G3oGvbCLCt84vTF/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Ffqvf1guyQ8RwV/jx0ZRUkDshdfMufxnHFDD/ZMPQnRfrowoaZDJ0cXCHUTU60Uiiu
         S2FmMF4SjnCMSpFs6BsFrnc8lyBd0TFockcgVUd3uWlZkd2uyVnsLtbu+MI9gIF6yUdf
         tLzxAKJUw7PdTrcKNBUFdMBP+9Ulh5FrUdY/8=
Received: by 10.14.11.28 with SMTP id 28mr279270eew.86.1306003545878;
        Sat, 21 May 2011 11:45:45 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id y14sm1130434eeh.3.2011.05.21.11.45.45
        (version=SSLv3 cipher=OTHER);
        Sat, 21 May 2011 11:45:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174141>

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
index 081677b..4416455 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -42,7 +42,10 @@ bisect_autostart() {
 		) >&2
 		if test -t 0
 		then
-			echo >&2 -n 'Do you want me to do it for you [Y/n]? '
+			# TRANSLATORS: Make sure to include [Y] and [n] in your
+			# translation. The program will only accept English input
+			# at this point.
+            gettext "Do you want me to do it for you [Y/n]? " >&2
 			read yesno
 			case "$yesno" in
 			[Nn]*)
@@ -248,7 +251,10 @@ bisect_next_check() {
 		) >&2
 		if test -t 0
 		then
-			printf >&2 'Are you sure [Y/n]? '
+			# TRANSLATORS: Make sure to include [Y] and [n] in your
+			# translation. The program will only accept English input
+			# at this point.
+			gettext "Are you sure [Y/n]? " >&2
 			read yesno
 			case "$yesno" in [Nn]*) exit 1 ;; esac
 		fi
--=20
1.7.5.1
