From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH av/i18n 1/2] tests: Symlink share and po into valgrind wrapper directory
Date: Sun, 25 Jul 2010 11:50:55 +0200
Message-ID: <ba054975988a4a799bcd81a74acd865815ae9bf5.1280051448.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 25 11:51:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcxrN-0006Ri-Cd
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 11:51:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377Ab0GYJu6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jul 2010 05:50:58 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:5392 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750910Ab0GYJu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 05:50:58 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sun, 25 Jul
 2010 11:50:56 +0200
Received: from localhost.localdomain (217.162.250.31) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.0.702.0; Sun, 25 Jul
 2010 11:50:55 +0200
X-Mailer: git-send-email 1.7.2.289.g93c76
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151719>

This is required since with --valgrind, the $GIT_EXEC_PATH that is
used to determine the proper location of these directories points to
.../t/valgrind/bin.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 t/test-lib.sh |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 4ae0de8..2f4bb27 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -735,6 +735,8 @@ then
 	do
 		make_valgrind_symlink $file
 	done
+	make_symlink "$TEST_DIRECTORY/../po" "$GIT_VALGRIND"/bin/po
+	make_symlink "$TEST_DIRECTORY/../share" "$GIT_VALGRIND"/bin/share
 	OLDIFS=$IFS
 	IFS=:
 	for path in $PATH
-- 
1.7.2.289.g93c76
