From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH v2 2/4] t6018: add tests for rev-list's --branches and --tags
Date: Fri, 14 May 2010 20:26:50 +0200
Message-ID: <ee2e0da5718c16fbfe65c61de85da8955bb52c63.1273861341.git.git@drmicha.warpmail.net>
References: <4BED7574.4070503@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 14 20:27:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCzbO-00071C-F8
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 20:27:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753300Ab0ENS07 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 14:26:59 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:59199 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753494Ab0ENS06 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 May 2010 14:26:58 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 1A98DF5F47;
	Fri, 14 May 2010 14:26:54 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 14 May 2010 14:26:54 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=zZF183hoa8J1mdG4XdNohe9+psE=; b=IXBWiTazJf68p9YcpQMNK2mB06p24HqHmkldGVBJmpjoJFjixEmhJLW1bLpS5nHjYZig5jASpvwPu9oEERvkWXMy9NB4eK3BGjStgj5pdWT3KHcGgd//YGAI9BOs5S9lmwM4I3xu8dk/GRy0FWSpx6yw87UhDGNAAjoe7KtIRp8=
X-Sasl-enc: ZI1anqWe2bIhEYbDUfAVP1OnoBkdrUn9kr83JtXaA+Vf 1273861613
Received: from localhost (p5485982A.dip0.t-ipconnect.de [84.133.152.42])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3763B4C2143;
	Fri, 14 May 2010 14:26:53 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.240.geeaa4d
In-Reply-To: <4BED7574.4070503@drmicha.warpmail.net>
In-Reply-To: <cover.1273861341.git.git@drmicha.warpmail.net>
References: <cover.1273861341.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147108>

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
