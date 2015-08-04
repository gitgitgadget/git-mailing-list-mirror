From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 1/6] tests: fix broken && chains in t1509-root-worktree
Date: Tue,  4 Aug 2015 13:29:52 +0200
Message-ID: <1438687797-14254-2-git-send-email-ps@pks.im>
References: <1437997708-10732-1-git-send-email-ps@pks.im>
 <1438687797-14254-1-git-send-email-ps@pks.im>
Cc: ps@pks.im, peff@peff.net, pclouds@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 13:30:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMaQR-0006sg-S4
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 13:30:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933408AbbHDLaT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 07:30:19 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:48720 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933137AbbHDLaN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Aug 2015 07:30:13 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 9CEC520C39
	for <git@vger.kernel.org>; Tue,  4 Aug 2015 07:30:12 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Tue, 04 Aug 2015 07:30:12 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=+u4L
	Ea1gib75+GSWCuToUahmz8E=; b=byy26PO+GP/usfn0rcb0kPxg9lg5YObzyUgZ
	GX8eY3xQqtRyY3D3A1wRocIzpgug2PV25Prb6iWD3KRDzMLJGrejNJ/NPAiM06mn
	GgzF5LHP7fnEvaaJOsYAhDaKZ++DuZFlggnBWpr+RF5uBumgzMeRMJmaf+kR4z1I
	yCoyxMQ=
X-Sasl-enc: pieHRVpohXSOo2LsmfovNBW06atmZkQ6jsF8EyyUb4th 1438687812
Received: from localhost (x5ce1225a.dyn.telefonica.de [92.225.34.90])
	by mail.messagingengine.com (Postfix) with ESMTPA id 1DDB4C00012;
	Tue,  4 Aug 2015 07:30:12 -0400 (EDT)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1438687797-14254-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275247>

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1509-root-worktree.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t1509-root-worktree.sh b/t/t1509-root-worktree.sh
index b6977d4..0c80129 100755
--- a/t/t1509-root-worktree.sh
+++ b/t/t1509-root-worktree.sh
@@ -125,7 +125,7 @@ fi
 ONE_SHA1=d00491fd7e5bb6fa28c517a0bb32b8b506539d4d
 
 test_expect_success 'setup' '
-	rm -rf /foo
+	rm -rf /foo &&
 	mkdir /foo &&
 	mkdir /foo/bar &&
 	echo 1 > /foo/foome &&
@@ -218,7 +218,7 @@ unset GIT_WORK_TREE
 
 test_expect_success 'go to /' 'cd /'
 test_expect_success 'setup' '
-	rm -rf /.git
+	rm -rf /.git &&
 	echo "Initialized empty Git repository in /.git/" > expected &&
 	git init > result &&
 	test_cmp expected result
@@ -241,8 +241,8 @@ say "auto bare gitdir"
 
 # DESTROYYYYY!!!!!
 test_expect_success 'setup' '
-	rm -rf /refs /objects /info /hooks
-	rm /*
+	rm -rf /refs /objects /info /hooks &&
+	rm /* &&
 	cd / &&
 	echo "Initialized empty Git repository in /" > expected &&
 	git init --bare > result &&
-- 
2.5.0
