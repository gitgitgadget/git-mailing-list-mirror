From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 2/2] t9119-git-svn-info.sh: test with svn 1.6.* as well
Date: Wed,  3 Mar 2010 21:34:32 +0100
Message-ID: <934da657767ac16dc137f68783769505f6b082fb.1267647872.git.git@drmicha.warpmail.net>
References: <d16ad252f24db9274bc9a5bcab959524eab823ed.1267636051.git.git@drmicha.warpmail.net>
Cc: Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 03 21:34:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmvHA-0002CO-5R
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 21:34:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756609Ab0CCUeV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 15:34:21 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:33098 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756601Ab0CCUeT (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Mar 2010 15:34:19 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 00FC1E33B4;
	Wed,  3 Mar 2010 15:34:18 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 03 Mar 2010 15:34:19 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=cg9VO4WjSYRXmn4iNquuWhns3xs=; b=l7110373WhrQztFuuErMGk3wVsMxgDa/JvaHRkBQiQK8XL1kM5bo42EDCN4bLEZQQ1ib6znGscct+sRrG1F93/YEfow5KVbUVoCrRr5fg4l2Yi+U7BFQSz2J3t7dqmc5qgdPWAac38pkCO+j5V1Jo/rIwgG/XsR+5Ezk4f8w1HQ=
X-Sasl-enc: OlQnXMBOQPkbxMt0Rqdn0l3Yrw8b4GvqQ04JHfpFfjhy 1267648458
Received: from localhost (p3EE2AD69.dip0.t-ipconnect.de [62.226.173.105])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 51F4B49CF9A;
	Wed,  3 Mar 2010 15:34:18 -0500 (EST)
X-Mailer: git-send-email 1.7.0.1.241.g6604f
In-Reply-To: <d16ad252f24db9274bc9a5bcab959524eab823ed.1267636051.git.git@drmicha.warpmail.net>
In-Reply-To: <cover.1267647872.git.git@drmicha.warpmail.net>
References: <cover.1267647872.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141476>

All tests in t9119 were disabled for subversion versions other than
1.[45].*. Make the test script run with subversion 1.[456].*.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t9119-git-svn-info.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/t/t9119-git-svn-info.sh b/t/t9119-git-svn-info.sh
index 95741cb..a9a558d 100755
--- a/t/t9119-git-svn-info.sh
+++ b/t/t9119-git-svn-info.sh
@@ -7,9 +7,10 @@ test_description='git svn info'
 . ./lib-git-svn.sh
 
 # Tested with: svn, version 1.4.4 (r25188)
+# Tested with: svn, version 1.6.[12345689]
 v=`svn_cmd --version | sed -n -e 's/^svn, version \(1\.[0-9]*\.[0-9]*\).*$/\1/p'`
 case $v in
-1.[45].*)
+1.[456].*)
 	;;
 *)
 	say "skipping svn-info test (SVN version: $v not supported)"
-- 
1.7.0.1.241.g6604f
