From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [RFC] test-lib.sh: No POSIXPERM for cygwin
Date: Sun, 27 Jan 2013 15:57:08 +0100
Message-ID: <201301271557.08994.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: j6t@kdbg.org, tboegi@web.de
To: ramsay@ramsay1.demon.co.uk, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 27 15:59:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzThL-0004I2-FC
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 15:59:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756102Ab3A0O6r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Jan 2013 09:58:47 -0500
Received: from mout.web.de ([212.227.17.11]:54462 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756020Ab3A0O6p convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Jan 2013 09:58:45 -0500
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb003) with
 ESMTPA (Nemesis) id 0MbyJ4-1UGSsX3Jfa-00JYGT; Sun, 27 Jan 2013 15:58:44 +0100
X-Provags-ID: V02:K0:3QUa1fNWA2UbgH+RzvDmJhtbgWxlD51MC6tTP9/GAfe
 XapfDKjgmdOx4vmwVJR6cOPR+tP4OJecnlFMCeD8mUpbR+Stz3
 z5ibCuYSsCSyI147YThT0d2mq7nwihijtD2stDJLqabNAA4Wyz
 O2pHz8XMwCi72rdHf/UCnXld2ioZcdyfodoISnktYAY1eu/mqV
 8LbVvua8OpoXC81IcIRHQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214705>

t0070 and t1301 fail when running the test suite under cygwin.
Skip the failing tests by unsetting POSIXPERM.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/test-lib.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 1a6c4ab..94b097e 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -669,7 +669,6 @@ case $(uname -s) in
 	test_set_prereq SED_STRIPS_CR
 	;;
 *CYGWIN*)
-	test_set_prereq POSIXPERM
 	test_set_prereq EXECKEEPSPID
 	test_set_prereq NOT_MINGW
 	test_set_prereq SED_STRIPS_CR
--=20
1.8.1.1
