From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 12/48] i18n: git-am printf(1) message to eval_gettext
Date: Sun,  8 May 2011 12:20:44 +0000
Message-ID: <1304857280-14773-13-git-send-email-avarab@gmail.com>
References: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 14:22:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ305-0003rg-Lr
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 14:22:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753684Ab1EHMVz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 08:21:55 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:50701 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752937Ab1EHMVm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 08:21:42 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1327021ewy.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 05:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=1YNsbKrCuVKl7n38Xfc4jNk5k1eUXZwkFudj5k1t2Mc=;
        b=gztahBZWNbTsjsnLG8DQ1H7YeS6vuhIz0ys+z6SuIRmBEolVderNxS0TCSAuP5SzNg
         NJJmqcZ3OmITJdJyDVK4R5u7yW64E4zMguPF/4Fjp6xsJWqx2OibZeSOj3zogsx2Xw+Y
         iS6lMQ7orfT1dcNWHfxvhX4ZG4Xq0782xzTCY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=OiHHZ3Lty3PaKz3Ha7f8p7Buq7XxZ2vvJYpTmggHydNMXD8HzlALkMMlrCaDgIhC/7
         IfA7R4/tw9MxSlvqkH5PH5G/Al2rNnPgDzLKqaOA3dz9ddHr+gs3GT4BlHjGIEchv7NS
         +LVCW1mBueh5uDCFjebgtdrtr6Mdo0oI2llIQ=
Received: by 10.213.113.201 with SMTP id b9mr619834ebq.65.1304857302191;
        Sun, 08 May 2011 05:21:42 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id n55sm2690046een.2.2011.05.08.05.21.41
        (version=SSLv3 cipher=OTHER);
        Sun, 08 May 2011 05:21:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173121>

Convert a message that used printf(1) format to use eval_gettext. It's
easier for translators to handle the latter, since the eval format
automatically gives them context via variable names.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-am.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 77ecae7..8554a67 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -794,7 +794,7 @@ did you forget to use 'git add'?"; echo
 	fi
 	if test $apply_status !=3D 0
 	then
-		printf 'Patch failed at %s %s\n' "$msgnum" "$FIRSTLINE"
+		eval_gettext 'Patch failed at $msgnum $FIRSTLINE'; echo
 		stop_here_user_resolve $this
 	fi
=20
--=20
1.7.4.4
