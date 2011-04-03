From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 30/51] i18n: git-submodule "path not initialized" message
Date: Sun,  3 Apr 2011 16:45:54 +0000
Message-ID: <1301849175-1697-31-git-send-email-avarab@gmail.com>
References: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 18:48:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6QTT-0005RJ-6d
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 18:48:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753278Ab1DCQsO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 12:48:14 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:59126 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752946Ab1DCQrA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 12:47:00 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1505877ewy.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 09:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=VbLSeJKEZh7C+LER90m9k2Gw/KRv3BUWMrkPoahWSn8=;
        b=mOG5KV1KBxjReJkRLb2oBjzlEFes5cEn7X/fhOcFmlZL1iKcaF964kh6xVI9qsaejD
         3zbbjIFORzqzyvF9Y5U9lwsn/JsqW6NCEejnezca7qHSuIPLoByphtNCugDx1ZP15lkz
         2X6K3uy0hsmGm2LdZxRSgP+lZOqMNIvMLm3Gw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=FgzL8cH7dpjXuJzPCwLWG62COnoIVhSSTdtOMrZS1EwpUoJlSULLflbyCsNIX55oU5
         /TToIk/h4ehq116g7b+hHnEbOAm6MroBVM6DDLCxISll2bWYK1xlqSn8tHihl7aiUT4W
         45+hpsyDSQj21xLrt6jpBEaxH2j5a/bh8MNjE=
Received: by 10.213.22.18 with SMTP id l18mr3085234ebb.115.1301849219341;
        Sun, 03 Apr 2011 09:46:59 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id w59sm2750567eeh.24.2011.04.03.09.46.58
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 09:46:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170743>

Gettextize the "Submodule path '$path' not initialized" message. This
is explicitly tested for so we need to skip some tests with
C_LOCALE_OUTPUT.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-submodule.sh           |    4 ++--
 t/t7400-submodule-basic.sh |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 43a10e2..bc24b2f 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -436,8 +436,8 @@ cmd_update()
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
index 1911688..eded7e9 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -349,7 +349,7 @@ test_expect_success 'apply submodule diff' '
 	test_cmp empty staged
 '
=20
-test_expect_success 'update --init' '
+test_expect_success C_LOCALE_OUTPUT 'update --init' '
 	mv init init2 &&
 	git config -f .gitmodules submodule.example.url "$(pwd)/init2" &&
 	git config --remove-section submodule.example &&
--=20
1.7.4.1
