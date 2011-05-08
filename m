From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 27/48] i18n: git-submodule "path not initialized" message
Date: Sun,  8 May 2011 12:20:59 +0000
Message-ID: <1304857280-14773-28-git-send-email-avarab@gmail.com>
References: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 14:23:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ30p-0004Hv-JO
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 14:23:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754019Ab1EHMWV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 08:22:21 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:50701 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753797Ab1EHMV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 08:21:59 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1327021ewy.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 05:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=Ru1EBml8dIsxfjBASO5suoQYgLokLwPISKKqMFxlG6c=;
        b=X4MhunW092hFL/IW6aDbp6VSd2mrgM3KDsVMMOhv7qW/pNbgP0xbQBdprafwCrp/FR
         gOVESN+S3U7WevOYhMf3nyJIQ0mlyyVET/05gCC3BEVXf7rHHK7GsLTzp/NLElwas5YE
         EvNF/9JhYzMs7QC5iuzVI9poHqn+v4YX/VPQs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=JvlvaQtYtfqsd9UYh1mYsE/ur4J6KrNPFVzgx7X+aUlypBLYeO/0NE6hiIQyZcJqcZ
         aOiDIxTszzUaYD5OVtK60MazRmeAHO1bvwkCDPfDG/QHFdz5PhxQrLVDL3RaPuDSRcU9
         W+jyKnsDyQQjofTG8kUsayAsGtA+y1iFIVcrY=
Received: by 10.14.4.32 with SMTP id 32mr2767317eei.141.1304857318384;
        Sun, 08 May 2011 05:21:58 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id n55sm2690046een.2.2011.05.08.05.21.57
        (version=SSLv3 cipher=OTHER);
        Sun, 08 May 2011 05:21:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173126>

Gettextize the "Submodule path '$path' not initialized" message. This
is explicitly tested for so we need to skip a portion of a test with
test_i18grep.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-submodule.sh           |    4 ++--
 t/t7400-submodule-basic.sh |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index ca33125..b1df660 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -461,8 +461,8 @@ cmd_update()
 			# Only mention uninitialized submodules when its
 			# path have been specified
 			test "$#" !=3D "0" &&
-			say "Submodule path '$path' not initialized" &&
-			say "Maybe you want to use 'update --init'?"
+			say "$(eval_gettext "Submodule path '\$path' not initialized
+Maybe you want to use 'update --init'?")"
 			continue
 		fi
=20
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index ea3b445..b2b26b7 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -357,7 +357,7 @@ test_expect_success 'update --init' '
=20
 	git submodule update init > update.out &&
 	cat update.out &&
-	grep "not initialized" update.out &&
+	test_i18ngrep "not initialized" update.out &&
 	! test -d init/.git &&
=20
 	git submodule update --init init &&
--=20
1.7.4.4
