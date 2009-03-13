From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 1/2] test-lib.sh: Test for presence of git-init in the right path.
Date: Fri, 13 Mar 2009 16:45:15 +0100
Message-ID: <1236959116-3334-2-git-send-email-git@drmicha.warpmail.net>
References: <1236959116-3334-1-git-send-email-git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 13 16:47:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Li9b9-0002QL-P4
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 16:47:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757963AbZCMPpe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 11:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757315AbZCMPpe
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 11:45:34 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:39939 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756983AbZCMPpd (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Mar 2009 11:45:33 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id C5E552EFA13;
	Fri, 13 Mar 2009 11:45:31 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 13 Mar 2009 11:45:31 -0400
X-Sasl-enc: lsdHsxhAfmTsgvhT2aFVxPf+BQGeueNMAfjXvU8rxSfc 1236959131
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2F377E885;
	Fri, 13 Mar 2009 11:45:31 -0400 (EDT)
X-Mailer: git-send-email 1.6.2.149.g6462
In-Reply-To: <1236959116-3334-1-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113199>

It just happens so that when GIT_EXEC_PATH points to a compiled checkout
of git.git it contains "git". Since this is not true in general make
test-lib check for "git-init" which is always in GIT_EXEC_PATH.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/test-lib.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 7a847ec..b9da86e 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -454,7 +454,7 @@ test_create_repo () {
 	repo="$1"
 	mkdir -p "$repo"
 	cd "$repo" || error "Cannot setup test environment"
-	"$GIT_EXEC_PATH/git" init "--template=$owd/../templates/blt/" >&3 2>&4 ||
+	"$GIT_EXEC_PATH/git-init" "--template=$owd/../templates/blt/" >&3 2>&4 ||
 	error "cannot run git init -- have you built things yet?"
 	mv .git/hooks .git/hooks-disabled
 	cd "$owd"
-- 
1.6.2.149.g6462
