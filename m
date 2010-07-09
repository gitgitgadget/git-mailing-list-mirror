From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] test-lib: TAP compliance for skipping tests on request
Date: Fri,  9 Jul 2010 13:15:19 +0200
Message-ID: <97f41d49b6e374d3e66908f3c62844da27312501.1278673984.git.git@drmicha.warpmail.net>
Cc: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 09 13:16:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXBZG-0008IJ-O3
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 13:16:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755511Ab0GILQ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jul 2010 07:16:26 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:54931 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754063Ab0GILQZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jul 2010 07:16:25 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 6722C1690B0;
	Fri,  9 Jul 2010 07:16:14 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 09 Jul 2010 07:16:14 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id; s=smtpout; bh=OpQcbHxXChfX4qMEKFe72RpniX0=; b=pzCQaAVGZLiEMR5MyF2AMOrhLWN77y7CNzNduD1xBHtNUdr1xX+Nywk7C2Reukv6GRA08rzIUvONBRow8Lw8au6yFTOZizIbtyQNZIKmkgG0HpnEko0kcLX8aZl6IZps0KtgwWQfEe//Hp9jIc7QhrY0l2EJNxdiu10Q3lDnlqQ=
X-Sasl-enc: WDedW76zaHWKwDxiVd8duUyAlJwBUaPwjchXRtL9Tt5I 1278674173
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D05374DFF0C;
	Fri,  9 Jul 2010 07:16:13 -0400 (EDT)
X-Mailer: git-send-email 1.7.2.rc1.212.g850a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150651>

Make the output TAP compliant for tests skipped on request (GI_SKIP_TESTS).

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
We may want to better spell out the reasons, but I think
it's good enough like this for *explicitly* skipped tests.

 t/test-lib.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 8e3de53..2076271 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -395,7 +395,7 @@ test_skip () {
 	case "$to_skip" in
 	t)
 		say_color skip >&3 "skipping test: $@"
-		say_color skip "ok $test_count: # skip $1"
+		say_color skip "ok $test_count # SKIP $1"
 		: true
 		;;
 	*)
@@ -838,7 +838,7 @@ done
 case "$to_skip" in
 t)
 	say_color skip >&3 "skipping test $this_test altogether"
-	say_color skip "skip all tests in $this_test"
+	skip_all="skip all tests in $this_test"
 	test_done
 esac
 
-- 
1.7.2.rc1.212.g850a
