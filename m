From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 1/2] test-lib.sh: Test for presence of git-init in the right path.
Date: Mon, 16 Mar 2009 18:03:11 +0100
Message-ID: <1237222992-19421-2-git-send-email-git@drmicha.warpmail.net>
References: <7v3adfc0n4.fsf@gitster.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 16 18:05:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjGFI-0007qy-3t
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 18:05:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756034AbZCPRDc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 13:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756025AbZCPRDc
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 13:03:32 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:58588 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755107AbZCPRDb (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Mar 2009 13:03:31 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 761AF2F04ED;
	Mon, 16 Mar 2009 13:03:29 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 16 Mar 2009 13:03:29 -0400
X-Sasl-enc: 9OCZBCR8XwWyFv6z5MX9xHSED0b6LYDdsxlhexr1H5QG 1237223008
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id DAAC23A673;
	Mon, 16 Mar 2009 13:03:28 -0400 (EDT)
X-Mailer: git-send-email 1.6.2.149.g6462
In-Reply-To: <7v3adfc0n4.fsf@gitster.siamese.dyndns.org>
In-Reply-To: <7v3adfc0n4.fsf@gitster.siamese.dyndns.org>
References: <7v3adfc0n4.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113346>

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
