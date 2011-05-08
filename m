From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 47/48] i18n: git-bisect [Y/n] messages
Date: Sun,  8 May 2011 12:21:19 +0000
Message-ID: <1304857280-14773-48-git-send-email-avarab@gmail.com>
References: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 14:23:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ30v-0004Hv-NF
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 14:23:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754077Ab1EHMWm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 08:22:42 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:48739 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753984Ab1EHMWT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 08:22:19 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1325631eyx.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 05:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=aPDKEGye/uJrmC/xej93Edr20YksW906cvRvQemjH8U=;
        b=F5KsL/Y9S2bUVd8W76oGe4ZckwPknMCUofwCSRPQGKJETP/5VJx0HRJ/GMJPGeUqHk
         ppe62LhhwiUwubdIL/ULwNc7QAzSx0npbcSShnrje9S5y63fJY0rIyegQam/H81FKxCs
         sILEiWO0ftEd43xuQcwI5WBH6+prNEPZohu9k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=XnLYdalypcsO+8JUoQg/ciZBCzQ4x+pC8NhStgAOScZq33Dk+HMV6NHAo+juEGc4hx
         AUPb9n7shaNwDxNSRSR2vOAHbzfIgMSz/kfSodJKmea2DnGBEhsoutOwrh00RVphnLvR
         00TDijoptmYrYeoLfNQZYOIPdUAUYuwoXr+MM=
Received: by 10.213.12.196 with SMTP id y4mr160585eby.16.1304857338416;
        Sun, 08 May 2011 05:22:18 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id n55sm2690046een.2.2011.05.08.05.22.17
        (version=SSLv3 cipher=OTHER);
        Sun, 08 May 2011 05:22:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173135>

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
1.7.4.4
