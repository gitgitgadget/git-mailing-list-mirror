From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2] test-lib: TAP compliance for skipping tests on request
Date: Mon, 12 Jul 2010 12:33:49 +0200
Message-ID: <82aab66bffd86b562c76a13a4666d3cf22a64cca.1278930335.git.git@drmicha.warpmail.net>
References: <AANLkTiml1lQlSBDGgUg9scsvsaffDT2n405USmsSIm1n@mail.gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 12 12:34:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYGLf-00050W-Gh
	for gcvg-git-2@lo.gmane.org; Mon, 12 Jul 2010 12:34:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751683Ab0GLKev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jul 2010 06:34:51 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:50874 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751497Ab0GLKeu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jul 2010 06:34:50 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id DFE9E10A5CE;
	Mon, 12 Jul 2010 06:34:49 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 12 Jul 2010 06:34:50 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=2YSgibY+AQFGoR5wAb2Fiw6nLdE=; b=LCDBIhtVVwlkZcUVSsXOp7FAaUqQ10hMi5SC1Xcf0RR73XGRSW4oInuPl3I8yCGe8a2ZsmbHQOTCEvH5ZaeYHuB77/H9fTdJo2eQYNonwvVDXEOJ0LdZ9BqlTVTkz21Vu6naWV1nEcA7mdkcjXq0RHtW4pN78AYUiOEEbJEWwn8=
X-Sasl-enc: Rq6PZyfbj8drtgZxf+dfr2WADkg77YtqjDuao3c7UHIE 1278930884
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 0A5574E68CD;
	Mon, 12 Jul 2010 06:34:43 -0400 (EDT)
X-Mailer: git-send-email 1.7.2.rc1.212.g850a
In-Reply-To: <AANLkTiml1lQlSBDGgUg9scsvsaffDT2n405USmsSIm1n@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150809>

Make the output TAP compliant for tests skipped on request (GIT_SKIP_TESTS).

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
v2 has a typo fix in the commit message and the spelling of "skip"
as suggested by AAB.

I think I've read it differently in the RFC, but then I was also confused about
the "#" in the RFC, and following the "reference" implementation (as per AAB)
should be the best approach.

 t/test-lib.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index bc06564..db8371c 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -396,7 +396,7 @@ test_skip () {
 	case "$to_skip" in
 	t)
 		say_color skip >&3 "skipping test: $@"
-		say_color skip "ok $test_count: # skip $1"
+		say_color skip "ok $test_count # skip $1"
 		: true
 		;;
 	*)
@@ -833,7 +833,7 @@ do
 	case "$this_test" in
 	$skp)
 		say_color skip >&3 "skipping test $this_test altogether"
-		say_color skip "skip all tests in $this_test"
+		skip_all="skip all tests in $this_test"
 		test_done
 	esac
 done
-- 
1.7.2.rc1.212.g850a
