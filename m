From: Ossi Herrala <oherrala@gmail.com>
Subject: [PATCH] Fix settings in default_user_config template
Date: Fri, 17 Apr 2015 17:50:10 +0300
Message-ID: <1429282210-38538-1-git-send-email-oherrala@gmail.com>
Cc: Ossi Herrala <oherrala@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 17 16:50:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yj7bG-0007il-1Y
	for gcvg-git-2@plane.gmane.org; Fri, 17 Apr 2015 16:50:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934867AbbDQOu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2015 10:50:29 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:32779 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932603AbbDQOuY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2015 10:50:24 -0400
Received: by layy10 with SMTP id y10so82204177lay.0
        for <git@vger.kernel.org>; Fri, 17 Apr 2015 07:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=0aRkBrkupRAXvojnWQB6HDLaessXpBTDT5qO9akZVIo=;
        b=sNPKOnkQhvTeISLD5eBHnpSlYBpL2NRMTV/NyvuDbDLNj02RcsFiGYwkrs4fM2BTcm
         K+yMfztDek+bYSOFZSs66Qz7z7ZcNc0GtBEK8Z11wJa8aanOMTfNJIW+LMUATSIQA9lP
         n2eQIE0XVBHsj2CnbtjhB+rsd88g807BAAm5NswsMcuVbtSsRYRs6v+9BiUKNsRUnzdA
         wWcySPp9UXzeM2Pc9KfC2FIq9qY5qoxXHnGYQhkKsUCMySbBYAljCZVpw8csv9y2C4Je
         /+8bCPnWLEgyQDz80G9Ukxh3aVDJyip0jdOn1pfmTu0bJsMeDodLe/IKfvlxiNsfvLl8
         uVIQ==
X-Received: by 10.152.7.239 with SMTP id m15mr4171347laa.95.1429282222959;
        Fri, 17 Apr 2015 07:50:22 -0700 (PDT)
Received: from localhost.localdomain (nat4.panoulu.net. [212.50.147.101])
        by mx.google.com with ESMTPSA id wh9sm2461433lbb.45.2015.04.17.07.50.21
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Apr 2015 07:50:22 -0700 (PDT)
X-Mailer: git-send-email 2.3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267359>

The name (not user) and email setting should be in config section
"user" and not in "core" as documented in Documentation/config.txt.
---
 builtin/config.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index d32c532..bfd3016 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -455,9 +455,9 @@ static char *default_user_config(void)
 	struct strbuf buf = STRBUF_INIT;
 	strbuf_addf(&buf,
 		    _("# This is Git's per-user configuration file.\n"
-		      "[core]\n"
+		      "[user]\n"
 		      "# Please adapt and uncomment the following lines:\n"
-		      "#	user = %s\n"
+		      "#	name = %s\n"
 		      "#	email = %s\n"),
 		    ident_default_name(),
 		    ident_default_email());
-- 
2.3.5
