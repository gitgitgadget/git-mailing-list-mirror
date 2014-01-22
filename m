From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv2 05/11] git p4 test: is_cli_file_writeable succeeds
Date: Wed, 22 Jan 2014 17:47:23 -0500
Message-ID: <1390430849-11436-5-git-send-email-pw@padd.com>
References: <20140122224421.GB4047@padd.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 22 23:48:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W66bQ-0005oX-MD
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 23:48:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756002AbaAVWsx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 17:48:53 -0500
Received: from honk.padd.com ([74.3.171.149]:42262 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755401AbaAVWsw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 17:48:52 -0500
Received: from arf.padd.com (unknown [50.105.0.78])
	by honk.padd.com (Postfix) with ESMTPSA id 14EAF712D;
	Wed, 22 Jan 2014 14:48:52 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 74CEB200AB; Wed, 22 Jan 2014 17:48:49 -0500 (EST)
X-Mailer: git-send-email 1.8.5.2.364.g6ac45cd
In-Reply-To: <20140122224421.GB4047@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240876>

Commit e9df0f9 (git p4: cygwin p4 client does not mark read-only,
2013-01-26) fixed a problem with "test -w" on cygwin, but mistakenly
marked the new test as failing.  Fix this.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/t9807-git-p4-submit.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9807-git-p4-submit.sh b/t/t9807-git-p4-submit.sh
index 1fb7bc7..4caf36e 100755
--- a/t/t9807-git-p4-submit.sh
+++ b/t/t9807-git-p4-submit.sh
@@ -17,7 +17,7 @@ test_expect_success 'init depot' '
 	)
 '
 
-test_expect_failure 'is_cli_file_writeable function' '
+test_expect_success 'is_cli_file_writeable function' '
 	(
 		cd "$cli" &&
 		echo a >a &&
-- 
1.8.5.2.364.g6ac45cd
