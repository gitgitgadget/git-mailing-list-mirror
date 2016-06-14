From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [TIG PATCH] test: make diff/log work with git 2.9
Date: Tue, 14 Jun 2016 10:34:48 +0200
Message-ID: <8f70b88987a2c69252c939a17c3cd474fe69d66b.1465893112.git.git@drmicha.warpmail.net>
Cc: Jonas Fonseca <fonseca@diku.dk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 14 10:34:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCjoH-00044h-Ib
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 10:34:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768AbcFNIex (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 04:34:53 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:53774 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751763AbcFNIev (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jun 2016 04:34:51 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 9F7DD21B9A;
	Tue, 14 Jun 2016 04:34:50 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Tue, 14 Jun 2016 04:34:50 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:date:from:message-id:subject:to:x-sasl-enc:x-sasl-enc; s=
	mesmtp; bh=e+f8hwAKVjMYCSHA4igcEWhJ6hI=; b=Tj1Rx02cGnapku7CLJp88
	oSurbEj1wiWg2t5tT3O+c40apEHMJoBclg2D7GwXCkFps8K07PwJ0rgCWnkkC+RW
	9IeCHM9vTbiMOWCZDNKkkopEiCB0dE+vpa+GSZhPFumDzSbhDj1wjb24xtRdl1or
	4fv+w8sxX8YFyw+j7HUTMQ=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:message-id:subject:to
	:x-sasl-enc:x-sasl-enc; s=smtpout; bh=e+f8hwAKVjMYCSHA4igcEWhJ6h
	I=; b=E4EA+ppTJOcKgVnZO5y3XPypnxg4KQQb0brhgdQE3SyWxU9/9zqrn4viJ8
	O3wG0HaBr5pjsiWWWZCmnSPPQ6W+ro9A7B6zNcva85Wtv4sS3mJzu/WUeKQheLos
	UHEN9frzx1a/TMfWLg7dDxM+f/ACxe5fiSfjiIh1wZgm33vfM=
X-Sasl-enc: kqg+IRsZ6sTyKgyLNOb1svjmeYOJzT9zgMTJJwkFqVn5 1465893290
Received: from localhost (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id 134ECF2022;
	Tue, 14 Jun 2016 04:34:49 -0400 (EDT)
X-Mailer: git-send-email 2.9.0.382.g87fd384
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297274>

git 2.9.0 switches the default for diff.renames to true.

Set this to false in config so that the test suite runs unmodified for
old and new git.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 test/tools/libgit.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/test/tools/libgit.sh b/test/tools/libgit.sh
index 6a8aa54..0bce451 100644
--- a/test/tools/libgit.sh
+++ b/test/tools/libgit.sh
@@ -33,6 +33,7 @@ git_config()
 {
 	git config --local user.name "Committer"
 	git config --local user.email "c.ommitter@example.net"
+	git config --local diff.renames false
 }
 
 git_init()
-- 
2.9.0.382.g87fd384
