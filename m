From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] help.c: add a compatibility comment to cmd_version()
Date: Tue, 16 Apr 2013 13:33:25 -0700
Message-ID: <1366144405-61438-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 22:33:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USCZI-0004zM-50
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 22:33:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965183Ab3DPUdY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 16:33:24 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:47794 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965114Ab3DPUdX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 16:33:23 -0400
Received: by mail-pd0-f174.google.com with SMTP id p12so480635pdj.5
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 13:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=vFtckgR2h9VZplwkW7d095LgaTiDaDRNGXyTzt7Dz+s=;
        b=LP11e2xxqnOAxKS13aBfz+tnqB9e4aclIamn/ZnSaud+CzJQo6EfV0Lx+VyqjdTmf0
         yl2BwUwxiV3ghXOkxbQQ/jY0tIwpSj7khmhOKad2qrKh4HHcKobRYDJXQ0tl7Ms0GPth
         j3zmi6PWKI+f1ATGTFQRtfmWIbq0YXaz7P1uzo7RpiJAzYhOHIKPAMjeT0mL8l5hZw+Q
         wt0kzSx4b0P5U3vPmEQojmau+Eb0tbuhd2ZBhpL4OkGu1gkLAg6QXWnmytUDHh+yd94O
         2LYXiWzXvhjLsvrIdlTPQThLObhJ+2Lu1erhTORGEjBWa5gurCcte8mwEecY9nPrN6gD
         olAg==
X-Received: by 10.68.201.102 with SMTP id jz6mr4922379pbc.192.1366144403205;
        Tue, 16 Apr 2013 13:33:23 -0700 (PDT)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id mt13sm3303796pbc.15.2013.04.16.13.33.21
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 16 Apr 2013 13:33:22 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.652.ge104b5e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221465>

External projects have been known to parse the output of
"git version".  Help prevent future authors from changing
its format by adding a comment to its implementation.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 help.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/help.c b/help.c
index 1dfa0b0..02ba043 100644
--- a/help.c
+++ b/help.c
@@ -397,6 +397,10 @@ const char *help_unknown_cmd(const char *cmd)
 
 int cmd_version(int argc, const char **argv, const char *prefix)
 {
+	/*
+	 * The format of this string should be kept stable for compatibility
+	 * with external projects that rely on the output of "git version".
+	 */
 	printf("git version %s\n", git_version_string);
 	return 0;
 }
-- 
1.8.2.1.652.ge104b5e
