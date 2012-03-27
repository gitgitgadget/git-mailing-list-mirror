From: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: [PATCH] t4052: unset $COLUMNS inherited from environment
Date: Tue, 27 Mar 2012 07:10:03 +0200
Message-ID: <1332825003-2288-1-git-send-email-zbyszek@in.waw.pl>
References: <20120326234549.GA10172@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, pclouds@gmail.com,
	j.sixt@viscovery.net,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: git@vger.kernel.org, gitster@pobox.com, peff@peff.net
X-From: git-owner@vger.kernel.org Tue Mar 27 07:10:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCOg0-0002ea-Fe
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 07:10:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753596Ab2C0FKc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Mar 2012 01:10:32 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:56334 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752885Ab2C0FKa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 01:10:30 -0400
Received: from 89-78-221-60.dynamic.chello.pl ([89.78.221.60] helo=localhost.localdomain)
	by kawka.in.waw.pl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SCOft-0007qB-3d; Tue, 27 Mar 2012 07:10:29 +0200
X-Mailer: git-send-email 1.7.10.rc1.222.gc0040.dirty
In-Reply-To: <20120326234549.GA10172@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194006>

$COLUMNS must be unset to not interfere with the tests. The tests
already ignore the terminal size because output is redirected to a
file, but $COLUMNS overrides terminal size detection and changes the
test output away from the standard 80 even if not on a terminal.

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
---
Stupid omission. Please apply.

 t/t4052-stat-output.sh |    1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
index 328aa8f..1f47f1d 100755
--- a/t/t4052-stat-output.sh
+++ b/t/t4052-stat-output.sh
@@ -17,6 +17,7 @@ test_expect_success 'preparation' '
 	git commit -m message &&
 	echo a >"$name" &&
 	git commit -m message "$name"
+	sane_unset COLUMNS
 '
=20
 while read cmd args
--=20
1.7.10.rc1.222.gc0040.dirty
