From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] t2019-checkout-ambiguous-ref.sh: depend on C_LOCALE_OUTPUT
Date: Sun,  3 Apr 2011 13:33:39 +0000
Message-ID: <1301837619-20277-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 15:33:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6NRC-0008O5-72
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 15:33:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752129Ab1DCNdr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 09:33:47 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:40164 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813Ab1DCNdq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 09:33:46 -0400
Received: by eyx24 with SMTP id 24so1471888eyx.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 06:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=GMSzqrAJ8TKxT9xdLmCQ/9ppGxe1APwW6GsZeQK1unc=;
        b=ghz8OCUqT3zw0NazKqUL3VpOHde1GcllNmhZ2ltFDcjY2uqKgaHSVnMnDeuh+vBIJM
         x8wiMonYbj7OMFOzr4JkTRde1WG+6Iy8DSJZ27csCx18EoRhlBFdsj39v5P7S5wDOeOJ
         fIsrCwp+q4s0GhmBI0o1UcUCx6Vbz3XH6Jhmg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=FwBchR0lIB5CUvtpepoh6VvbShypxZQmP2kCt1IlrEaTr9YIprV+yZ7aCkaC3/HgXE
         PKb98NzC+i10nYHsSaXk/lxJ5BRWTpdfZV5ySDXn7+0+mJ3c2/Lf6hDSZ4yPNhIScBWF
         UzZJgMj2tIM9ek8uidI6eaev9IMo5lJYZScPk=
Received: by 10.14.126.137 with SMTP id b9mr2937135eei.238.1301837625594;
        Sun, 03 Apr 2011 06:33:45 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id x54sm2667103eeh.12.2011.04.03.06.33.44
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 06:33:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170691>

The t2019-checkout-ambiguous-ref.sh tests added by Junio in
v1.7.4.3~12^2 broke on Git built with GETTEXT_POISON=3DYesPlease. Add
C_LOCALE_OUTPUT to the relevant test files to fix this.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t2019-checkout-ambiguous-ref.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t2019-checkout-ambiguous-ref.sh b/t/t2019-checkout-ambig=
uous-ref.sh
index 943541d..cc34e55 100755
--- a/t/t2019-checkout-ambiguous-ref.sh
+++ b/t/t2019-checkout-ambiguous-ref.sh
@@ -29,7 +29,7 @@ test_expect_success 'checkout chooses branch over tag=
' '
 	test_cmp expect file
 '
=20
-test_expect_success 'checkout reports switch to branch' '
+test_expect_success C_LOCALE_OUTPUT 'checkout reports switch to branch=
' '
 	grep "Switched to branch" stderr &&
 	! grep "^HEAD is now at" stderr
 '
@@ -51,7 +51,7 @@ test_expect_success VAGUENESS_SUCCESS 'checkout choos=
es branch over tag' '
 	test_cmp expect file
 '
=20
-test_expect_success VAGUENESS_SUCCESS 'checkout reports switch to bran=
ch' '
+test_expect_success VAGUENESS_SUCCESS,C_LOCALE_OUTPUT 'checkout report=
s switch to branch' '
 	grep "Switched to branch" stderr &&
 	! grep "^HEAD is now at" stderr
 '
--=20
1.7.4.1
