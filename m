From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 27/48] i18n: git-submodule "path not initialized" message
Date: Sat, 21 May 2011 18:44:08 +0000
Message-ID: <1306003469-22939-28-git-send-email-avarab@gmail.com>
References: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:45:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNrBS-0000TI-Ru
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 20:45:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757007Ab1EUSpn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2011 14:45:43 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:39530 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450Ab1EUSp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 14:45:28 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1444607eyx.19
        for <git@vger.kernel.org>; Sat, 21 May 2011 11:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=Xv22RRgSjoNXbY+YQ/v2epYOQkyUZFCfdUcDmtsgQeA=;
        b=Jc6AYMFgasQICStWo07oCn8GPZE2AbaAZG08tL0plEAB9AamLiEw5yr23Oj+/k29bF
         t7OLi6kULgFyUKwFzPPGs8YAjxAYSz2ZrHRx3p7A7ldc01py0W/byj/z7iW90oUEWZwX
         KJApl7oIJouuTG1o/KvblGRXU3Mq2Bx+FN3X0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=BCcCuul6nxNYbfx/R6cUNX7jlMTtz1qrwIFfDVhOtm3paZgDexUFj905I8o/4a8Jl9
         gq5WLT0gYOan+zrNhHzpRoJvvtnyidopTgZcPklrDoV+FRHBr2Ugn86p3WYpwL3LJBw+
         KbwVN1M5L79pSRjGmulStoLCQgnPJWFh+abHg=
Received: by 10.14.47.208 with SMTP id t56mr275687eeb.122.1306003527374;
        Sat, 21 May 2011 11:45:27 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id y14sm1130434eeh.3.2011.05.21.11.45.26
        (version=SSLv3 cipher=OTHER);
        Sat, 21 May 2011 11:45:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174131>

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
index 11c4bad..654a8cb 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -464,8 +464,8 @@ cmd_update()
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
1.7.5.1
