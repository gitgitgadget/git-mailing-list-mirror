From: dev+git@drbeat.li
Subject: [PATCH v2 3/5] update_unicode.sh: shorten uniset invocation path
Date: Fri, 19 Dec 2014 17:21:32 +0100
Message-ID: <1419006094-24572-3-git-send-email-dev+git@drbeat.li>
References: <1419006094-24572-1-git-send-email-dev+git@drbeat.li>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 19 17:21:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y20JO-0005Cv-JL
	for gcvg-git-2@plane.gmane.org; Fri, 19 Dec 2014 17:21:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752646AbaLSQVn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2014 11:21:43 -0500
Received: from smtp1.mail.fcom.ch ([212.60.46.170]:56237 "EHLO
	smtp1.mail.fcom.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751587AbaLSQVl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2014 11:21:41 -0500
Received: from drbeat.li (178-241-153-5.dyn.cable.fcom.ch [5.153.241.178])
	by smtp1.mail.fcom.ch (Postfix) with ESMTP id 686A820B92
	for <git@vger.kernel.org>; Fri, 19 Dec 2014 17:21:35 +0100 (CET)
Received: by drbeat.li (Postfix, from userid 1000)
	id BE828209BB; Fri, 19 Dec 2014 17:21:34 +0100 (CET)
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1419006094-24572-1-git-send-email-dev+git@drbeat.li>
X-Virus-Scanned: clamav-milter 0.98.4 at smtp1.mail.fcom.ch
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261573>

From: Beat Bolli <dev+git@drbeat.li>

"uniset/uniset" is a relative path; there's no need to prefix it with "./".

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 update_unicode.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/update_unicode.sh b/update_unicode.sh
index bed8916..f5cc14b 100755
--- a/update_unicode.sh
+++ b/update_unicode.sh
@@ -29,11 +29,11 @@ fi &&
 	) && {
 		UNICODE_DIR=. && export UNICODE_DIR &&
 		echo "static const struct interval zero_width[] = {" &&
-		./uniset/uniset --32 cat:Me,Mn,Cf + U+1160..U+11FF - U+00AD |
+		uniset/uniset --32 cat:Me,Mn,Cf + U+1160..U+11FF - U+00AD |
 		grep -v plane &&
 		echo "};" &&
 		echo "static const struct interval double_width[] = {" &&
-		./uniset/uniset --32 eaw:F,W &&
+		uniset/uniset --32 eaw:F,W &&
 		echo "};"
 	} >$UNICODEWIDTH_H
 )
-- 
2.1.3
