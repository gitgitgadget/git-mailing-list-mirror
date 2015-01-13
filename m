From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH] format-patch: print format-patch usage if there are no arguments
Date: Tue, 13 Jan 2015 23:54:22 +0600
Message-ID: <1421171662-12164-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 18:54:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YB5fl-0000G7-QQ
	for gcvg-git-2@plane.gmane.org; Tue, 13 Jan 2015 18:54:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753212AbbAMRy3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2015 12:54:29 -0500
Received: from mail-la0-f42.google.com ([209.85.215.42]:54169 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752782AbbAMRy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2015 12:54:28 -0500
Received: by mail-la0-f42.google.com with SMTP id gd6so4025422lab.1
        for <git@vger.kernel.org>; Tue, 13 Jan 2015 09:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=4imzANStWaxRpmu4o55jvPXDp62oTMHzztfpKRBxCZQ=;
        b=ebKNmLNNDet+CuxoQRP+pdPGv1kcgYZYU/Ku29SNKrjGUiuh+hryJ0N1ifVwApaciV
         RVxfZBzljbcyfr6gArrZQoDJrpn1rNBVsW+/ZJ8h4DIUldX0SMcP0aJrqp+h4B/6yBbN
         JLajg6potOaK0NYeY43DVyeNnjElQg8nA6IKAm3lgAolBqBTkaoXfPNO14hW41zNvwMB
         Kdu3unZ4OqqXNgW0Rg5RaYjw9qTIh0J+yEYJTHmEUBmg4JcfP1DqJ5qdaif3Mt8J6kB2
         Acos5+ZdROu7TQTSJ8rvhjwYXpFmnQbKf3z2xVJbktq6lBNfQZNCZhDcfcxkFerxGKve
         F8WQ==
X-Received: by 10.152.207.37 with SMTP id lt5mr43408195lac.66.1421171667113;
        Tue, 13 Jan 2015 09:54:27 -0800 (PST)
Received: from localhost.localdomain ([95.59.128.47])
        by mx.google.com with ESMTPSA id ba3sm5154998lbc.35.2015.01.13.09.54.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Jan 2015 09:54:26 -0800 (PST)
X-Mailer: git-send-email 2.3.0.rc0.239.g0ae1f56.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262342>

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 builtin/log.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/builtin/log.c b/builtin/log.c
index ad3cfd8..4431b50 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1246,6 +1246,10 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
+	/* We need at least one revision */
+	if (argc == 1)
+		usage_with_options(builtin_format_patch_usage, builtin_format_patch_options);
+
 	extra_hdr.strdup_strings = 1;
 	extra_to.strdup_strings = 1;
 	extra_cc.strdup_strings = 1;
-- 
2.3.0.rc0.239.g0ae1f56.dirty
