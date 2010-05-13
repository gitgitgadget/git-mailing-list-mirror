From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 2/4] t6018: add tests for rev-list's --branches and --tags
Date: Thu, 13 May 2010 16:24:36 +0200
Message-ID: <ee2e0da5718c16fbfe65c61de85da8955bb52c63.1273760226.git.git@drmicha.warpmail.net>
References: <20100505033536.GB8779@coredump.intra.peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 13 16:25:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCZLP-0006Qf-B3
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 16:24:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758275Ab0EMOYn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 May 2010 10:24:43 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:52754 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757933Ab0EMOYm (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 May 2010 10:24:42 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 9CAE0F64C0;
	Thu, 13 May 2010 10:24:41 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 13 May 2010 10:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=zZF183hoa8J1mdG4XdNohe9+psE=; b=NmL1GvdVk90tTZBMqtcB2HJPJtTSWoJj1lGa78tlxXqOAG3BsSzsZtD92wA67PKhONtbQytB5MPvcHauWPZYjuoyu8v7ho8CnlkN/2DJD6JTeIltu6GXUeU/sZXlQ+WhpbuMJaFDr9HVPRor97aHwECDu0e2m/QpdefLeUN6Smg=
X-Sasl-enc: ne6UQHoUraIG5tdVUUVLbcQHOUtNcSB4ONKtCG+ll+4h 1273760680
Received: from localhost (p54859DBB.dip0.t-ipconnect.de [84.133.157.187])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8A8465465F;
	Thu, 13 May 2010 10:24:40 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.240.geeaa4d
In-Reply-To: <20100505033536.GB8779@coredump.intra.peff.net>
In-Reply-To: <cover.1273760226.git.git@drmicha.warpmail.net>
References: <cover.1273760226.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147011>

so that we know when they break.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t6018-rev-list-glob.sh |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/t/t6018-rev-list-glob.sh b/t/t6018-rev-list-glob.sh
index 8d3fa7d..dbedc4d 100755
--- a/t/t6018-rev-list-glob.sh
+++ b/t/t6018-rev-list-glob.sh
@@ -162,6 +162,13 @@ test_expect_success 'rev-list --branches=subspace' '
 	compare rev-list "subspace/one subspace/two" "--branches=subspace"
 
 '
+
+test_expect_success 'rev-list --branches' '
+
+	compare rev-list "master subspace-x someref other/three subspace/one subspace/two" "--branches"
+
+'
+
 test_expect_success 'rev-list --glob=heads/someref/* master' '
 
 	compare rev-list "master" "--glob=heads/someref/* master"
@@ -186,6 +193,12 @@ test_expect_success 'rev-list --tags=foo' '
 
 '
 
+test_expect_success 'rev-list --tags' '
+
+	compare rev-list "foo/bar" "--tags"
+
+'
+
 test_expect_success 'rev-list --remotes=foo' '
 
 	compare rev-list "foo/baz" "--remotes=foo"
-- 
1.7.1.240.geeaa4d
