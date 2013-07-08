From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH] t0000: do not use export X=Y
Date: Mon, 8 Jul 2013 11:21:22 +0200
Message-ID: <201307081121.22769.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: trast@inf.ethz.ch, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 08 11:26:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uw7iR-0006SQ-HM
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 11:26:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532Ab3GHJ0f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Jul 2013 05:26:35 -0400
Received: from mout.web.de ([212.227.17.11]:49214 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752439Ab3GHJ0e convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jul 2013 05:26:34 -0400
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb004) with
 ESMTPA (Nemesis) id 0Lkm1c-1UNskF3yRY-00aROo; Mon, 08 Jul 2013 11:21:28 +0200
X-Provags-ID: V03:K0:5hfwrpe7ZWaDKlo0j70v9fLzFUmX/fZlYJ539v9soDgrSQoOPb/
 FpvnhbNOwWKqHtgL9Tqz7XP5oxN4ZgsFiILgZsCCt8TDTXtntlhGNyPKqCSBeDuKXH2wRJp
 zPMd+WZ110XqKe7TmmWGtIQjHI3fDMj2rF7Fl0wBY7Tr6yeyFkXOAC1ZLIaYUTUk+rBeUW9
 EvqhN10CHsTcw2EqJNv4g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229832>

The shell syntax "export X=3DY A=3DB" is not understood by all shells.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/t0000-basic.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 5c32288..10be52b 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -53,7 +53,8 @@ run_sub_test_lib_test () {
 		# Pretend we're a test harness.  This prevents
 		# test-lib from writing the counts to a file that will
 		# later be summarized, showing spurious "failed" tests
-		export HARNESS_ACTIVE=3Dt &&
+		HARNESS_ACTIVE=3Dt &&
+		export HARNESS_ACTIVE &&
 		cd "$name" &&
 		cat >"$name.sh" <<-EOF &&
 		#!$SHELL_PATH
--=20
1.8.3
