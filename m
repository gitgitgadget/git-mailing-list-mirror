From: Andrew Pimlott <andrew@pimlott.net>
Subject: [PATCH] lib-rebase: use write_script
Date: Thu, 27 Jun 2013 11:30:25 -0700
Message-ID: <1372357825-21824-1-git-send-email-andrew@pimlott.net>
Cc: Andrew Pimlott <andrew@pimlott.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 27 20:30:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsGy4-0008Lu-Ma
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 20:30:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753992Ab3F0Sat (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jun 2013 14:30:49 -0400
Received: from pimlott.net ([72.249.23.100]:55022 "EHLO fugue.pimlott.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753671Ab3F0Sas (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 14:30:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pimlott.net; s=default;
	h=Message-Id:Date:Subject:Cc:To:From; bh=ydjG0eqq1QoMNazH38+I2q/2M/+JB5kbbLrKA1W91uA=;
	b=YuzTkhzE/HhKAJHW7QetII7UHruxzeInHaW6QAzpbB3U4xPM74jzRzwDOouNvNIY4AFxWGgSKX7spJxlkOYyyrZDtFN+j0oguf7ObmfWTYrW7KPL0ViPzDwDq3MAER9AakTfE+J//8AumwRmitnZumcU2/ZvWFfK67uGuoLshNY=;
Received: from c-71-198-212-229.hsd1.ca.comcast.net ([71.198.212.229] helo=oinkpad.pimlott.net)
	by fugue.pimlott.net with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <andrew@pimlott.net>)
	id 1UsGxz-0006oA-KG; Thu, 27 Jun 2013 11:30:47 -0700
Received: from andrew by oinkpad.pimlott.net with local (Exim 4.80)
	(envelope-from <andrew@pimlott.net>)
	id 1UsGxs-0005gX-Jo; Thu, 27 Jun 2013 18:30:40 +0000
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229141>


Signed-off-by: Andrew Pimlott <andrew@pimlott.net>
---
 t/lib-rebase.sh |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index 0b41155..7b42199 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -24,8 +24,7 @@
 #   ">" -- Add a blank line.
 
 set_fake_editor () {
-	echo "#!$SHELL_PATH" >fake-editor.sh
-	cat >> fake-editor.sh <<\EOF
+	write_script fake-editor.sh <<\EOF
 case "$1" in
 */COMMIT_EDITMSG)
 	test -z "$EXPECT_HEADER_COUNT" ||
@@ -65,7 +64,6 @@ cat "$1"
 EOF
 
 	test_set_editor "$(pwd)/fake-editor.sh"
-	chmod a+x fake-editor.sh
 }
 
 # After set_cat_todo_editor, rebase -i will write the todo list (ignoring
-- 
1.7.10.4
