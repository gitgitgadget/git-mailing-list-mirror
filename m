From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 11/12] gettextize: git-submodule "path not initialized" message
Date: Mon, 13 Sep 2010 22:09:17 +0000
Message-ID: <1284415758-20931-12-git-send-email-avarab@gmail.com>
References: <1284415758-20931-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 14 00:10:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvHEe-00079c-6W
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 00:10:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754934Ab0IMWK0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Sep 2010 18:10:26 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44144 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753864Ab0IMWKY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Sep 2010 18:10:24 -0400
Received: by mail-wy0-f174.google.com with SMTP id 22so6742715wyf.19
        for <git@vger.kernel.org>; Mon, 13 Sep 2010 15:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=WZArxATxWTevneTD1yZeWxa2rAXtJb1w77/qyTiOrpQ=;
        b=cRCGQsGJ3UYb2WbHXDDLPC5j3ZWrKVii3yhsyCsz/27sjOjnPT4JmBh/Vmu+OW2XQD
         8VVfHBvWcWH/dBs+cgkEBavNU0QetxnQprSbAKzehsg3oKQK6RKu3ojIVIxjybnS+L19
         bU8PDkfRbIHNJ8z+Ir+BRIBxwLor2apl5oN7M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=vgc2fIKPFLoySO4o57hYdWdI8/wt6tJ2huevmZIbF9ylEPll4BTU4QCt1ciM2vYXSS
         T5A9S7KxH5Ycg3RxX+KA4cRWqYpmiuyOmmfQQHGiPdQtemtPy8OPGezNbA6LXq44DNkc
         Ikc7Ywjlt4olJxxXOiUrqLPC3AdRfYq24+g1U=
Received: by 10.216.0.206 with SMTP id 56mr4960127web.33.1284415823488;
        Mon, 13 Sep 2010 15:10:23 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id w14sm4296416weq.9.2010.09.13.15.10.21
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 13 Sep 2010 15:10:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.220.gb4d42
In-Reply-To: <1284415758-20931-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156145>

Gettextize the "Submodule path '$path' not initialized" message. This
is explicitly tested for so we need to skip some tests with
NO_GETTEXT_POISON.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-submodule.sh           |    4 ++--
 t/t7400-submodule-basic.sh |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index cd37bf7..edf8774 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -441,8 +441,8 @@ cmd_update()
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
index 0531dd1..b25bcb6 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -349,7 +349,7 @@ test_expect_success 'apply submodule diff' '
 	test_cmp empty staged
 '
=20
-test_expect_success 'update --init' '
+test_expect_success NO_GETTEXT_POISON 'update --init' '
 	mv init init2 &&
 	git config -f .gitmodules submodule.example.url "$(pwd)/init2" &&
 	git config --remove-section submodule.example &&
--=20
1.7.3.rc1.220.gb4d42
