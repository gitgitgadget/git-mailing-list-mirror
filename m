From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 09/48] i18n: git-am "Apply?" message
Date: Sun,  8 May 2011 12:20:41 +0000
Message-ID: <1304857280-14773-10-git-send-email-avarab@gmail.com>
References: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 14:23:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ31g-0004kb-4a
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 14:23:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754184Ab1EHMXs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 08:23:48 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:35010 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753216Ab1EHMVj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 08:21:39 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1327054ewy.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 05:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=RUfyXUE1VzxrWXGdyq7dppYz48aGaMJzF9IqLSIk2z4=;
        b=p6JfsL2aX0g9oA3gE0j3fo8W5cGqLTTKoGsB5hkz7xdvnWbytp/OvTB0LPbqUeJpUz
         3ijHCzDRA/Gm0m9DpAbKdGufCQ+E27UArYhuizVqRJbVsHdM8AyqZMrl13S8/ZBFTWh3
         QjmfR3q8Vwx497O8bWMiIvN1CrC0Yad12iuRM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=THzEKVoOlAS7NqrUOTGvIJtLSrSfEln4KdyYASZnDcjnycE1v42xlIL9omrHkirgio
         0aNylG0p64o7r7ljX+jcXKjaUCFeAaYpQNYnjuvU72MfWBcBQ26yhq+xWc62xuYsP2nG
         vImIqzoO/VTKXuW/2HCs2+nDOf1yR/ccISUwM=
Received: by 10.213.3.20 with SMTP id 20mr668491ebl.47.1304857298713;
        Sun, 08 May 2011 05:21:38 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id n55sm2690046een.2.2011.05.08.05.21.37
        (version=SSLv3 cipher=OTHER);
        Sun, 08 May 2011 05:21:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173151>

Make the "Apply? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all" message
translatable, and leave a note in a TRANSLATORS comment explaining
that translators have to preserve a mention of the y/n/e/v/a
characters since the program will expect them, and not their
localized equivalents.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-am.sh |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index ed48673..2c8770b 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -700,7 +700,10 @@ To restore the original branch and stop patching r=
un \"\$cmdline --abort\"."; ec
 		echo "--------------------------"
 		cat "$dotest/final-commit"
 		echo "--------------------------"
-		printf "Apply? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all "
+		# TRANSLATORS: Make sure to include [y], [n], [e], [v] and [a]
+		# in your translation. The program will only accept English
+		# input at this point.
+		gettext "Apply? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all "
 		read reply
 		case "$reply" in
 		[yY]*) action=3Dyes ;;
--=20
1.7.4.4
