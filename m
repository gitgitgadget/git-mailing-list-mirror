From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/4] t7005: do not exit inside test.
Date: Sat, 22 Dec 2007 19:55:33 -0800
Message-ID: <1198382136-15724-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 23 04:56:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J6Hwg-0008Cc-KO
	for gcvg-git-2@gmane.org; Sun, 23 Dec 2007 04:56:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754283AbXLWDzr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2007 22:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754584AbXLWDzr
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Dec 2007 22:55:47 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45729 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753046AbXLWDzq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2007 22:55:46 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 18B2A258D;
	Sat, 22 Dec 2007 22:55:41 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B5633258C;
	Sat, 22 Dec 2007 22:55:38 -0500 (EST)
X-Mailer: git-send-email 1.5.4.rc1.19.g9151fa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69165>

The way to signal failure is to leave non-zero in $?, not abort
the entire test.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7005-editor.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t7005-editor.sh b/t/t7005-editor.sh
index 44228b5..c1cec55 100755
--- a/t/t7005-editor.sh
+++ b/t/t7005-editor.sh
@@ -37,7 +37,7 @@ test_expect_success 'dumb should error out when falling back on vi' '
 	if git commit --amend
 	then
 		echo "Oops?"
-		exit 1
+		false
 	else
 		: happy
 	fi
-- 
1.5.4.rc1.19.g9151fa
