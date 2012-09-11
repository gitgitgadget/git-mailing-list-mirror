From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] rev-list/log: document logic with several limiting options
Date: Tue, 11 Sep 2012 16:45:53 +0200
Message-ID: <b23f3c547358b79731c7a25d9ac496138e6ab74d.1347374615.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 11 16:46:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBRjC-0007rj-VC
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 16:46:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759466Ab2IKOp5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Sep 2012 10:45:57 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:54092 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759170Ab2IKOpz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Sep 2012 10:45:55 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id ECF8320AF8
	for <git@vger.kernel.org>; Tue, 11 Sep 2012 10:45:54 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 11 Sep 2012 10:45:54 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:subject:date:message-id; s=
	smtpout; bh=q2NP3yFoHFh8xijm8UQWBY8kaD4=; b=iITC0rAlCCjcrozwonzo
	mOjPfVVigJtPaA/Z0lL4xMyFuyLOpVtxZ+d0asq9Aj0wtC7z+b8omBqL9B673OT1
	1PX7CvY1bzPUaXfYkDVCpQQuvj6cv4vlnNq/auHFVYCn6Vv052nl1tZhEOPVFV0Y
	gNC25oKTG4XVfQ7shcZna0s=
X-Sasl-enc: pzIWlmgNnoEQVGyC1JU9XOKF3QBMIVGjRwJ8HBO66cDo 1347374754
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 8BDCD8E0212;
	Tue, 11 Sep 2012 10:45:54 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.463.gbd9d638
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205233>

The current behavior is probably as useful as it is confusing. In any
case it is going to stay. So, document it.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
I would have written a test but don't really know where to stick it in.
rev-list has many small tests where it doesn't fit.

 Documentation/rev-list-options.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 5436eba..9c13df3 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -6,6 +6,12 @@ special notations explained in the description, additional commit
 limiting may be applied. Note that they are applied before commit
 ordering and formatting options, such as '--reverse'.
 
+All occurrences of the same option are ORed: '--grep=foo --grep=bar'
+limits to commits which match at least one of these conditions.
+
+Different options are ANDed: '--author=bar --grep=foo'
+limits to commits which match both conditions.
+
 --
 
 -n 'number'::
-- 
1.7.12.463.gbd9d638
