From: Ryan Anderson <ryan@michonline.com>
Subject: [PATCH 1/1] Disable color detection during format-patch
Date: Sun,  9 Jul 2006 02:28:21 -0400
Message-ID: <11524265013620-git-send-email-ryan@michonline.com>
Reply-To: Ryan Anderson <ryan@michonline.com>
Cc: git@vger.kernel.org, Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Sun Jul 09 08:32:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzSpi-0005kV-2F
	for gcvg-git@gmane.org; Sun, 09 Jul 2006 08:31:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbWGIGbz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Jul 2006 02:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbWGIGbz
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Jul 2006 02:31:55 -0400
Received: from h4x0r5.com ([70.85.31.202]:52231 "EHLO h4x0r5.com")
	by vger.kernel.org with ESMTP id S932370AbWGIGby (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jul 2006 02:31:54 -0400
Received: from c-71-202-182-135.hsd1.ca.comcast.net ([71.202.182.135] helo=mythical)
	by h4x0r5.com with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1FzSmk-0005DP-2A; Sat, 08 Jul 2006 23:28:57 -0700
Received: from ryan by mythical with local (Exim 4.62)
	(envelope-from <ryan@mythryan2.michonline.com>)
	id 1FzSmE-0007dt-2C; Sun, 09 Jul 2006 02:28:22 -0400
To: junkio@cox.net
X-Mailer: git-send-email 1.4.1.g6bdc-dirty
X-michonline.com-MailScanner: Found to be clean
X-michonline.com-MailScanner-From: ryan@michonline.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23523>

Signed-off-by: Ryan Anderson <ryan@michonline.com>
---
 builtin-log.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 698b71e..0aeeaa4 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -105,6 +105,9 @@ static int git_format_config(const char 
 		strcat(extra_headers, value);
 		return 0;
 	}
+	if (!strcmp(var, "diff.color")) {
+		return 0;
+	}
 	return git_diff_config(var, value);
 }
 
-- 
1.4.1.gc473b-dirty
