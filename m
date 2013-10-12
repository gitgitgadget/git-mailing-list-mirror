From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 02/10] transport-helper: fix extra lines
Date: Sat, 12 Oct 2013 02:05:27 -0500
Message-ID: <1381561533-20381-5-git-send-email-felipe.contreras@gmail.com>
References: <1381561533-20381-1-git-send-email-felipe.contreras@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:11:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtMc-0004MJ-Dp
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:11:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753878Ab3JLHLq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:11:46 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:42641 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214Ab3JLHLo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:11:44 -0400
Received: by mail-ob0-f178.google.com with SMTP id uz6so3437701obc.37
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WaRAuAqiKXotUk6bP05RUsuWtU/sgkFa0rtrv+50sA8=;
        b=dWJcy8Jn6rK0aywbs5q4bJDHP5xihPDyvvM7fLnEzG2NaqhAgVrwx6wLcU/CB80zEJ
         lmyZ6Gt9Rdufq/zHaPNhUAu/RmWGv5o8dEMwZX1P9QqBpvNOudBN6SEnK4gi5hxmACUR
         mKvWteQ7EMwHAHXBIS9QMcIRL9ky4qWUj7tGPGHzVHH6+AqQrDGPpjtd2VYuvJft4WWs
         4Km0VTbiooVFzB7QS8TJwSLZO/OTUGTECsKknK1FpNDPpSMy50LMMIXlQWtRaTm/PwHt
         FsEdYar4TJxCAgSiaG4pfR4Pa+mlFrP5KHtwUBYvsGUADgFT2hyvLcxJXl5Pmd9/6LD2
         ar6w==
X-Received: by 10.60.95.229 with SMTP id dn5mr17832605oeb.26.1381561904510;
        Sat, 12 Oct 2013 00:11:44 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id u8sm28641175obd.7.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:11:43 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561533-20381-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235973>

Commit 9c51558 (transport-helper: trivial code shuffle) moved these
lines above, but 99d9ec0 (Merge branch 'fc/transport-helper-no-refspec')
had a wrong merge conflict and readded them.

Reported-by: Richard Hansen <rhansen@bbn.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 transport-helper.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index cd913af..ed3384e 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -840,9 +840,6 @@ static int push_refs_with_export(struct transport *transport,
 		}
 		free(private);
 
-		if (ref->deletion)
-			die("remote-helpers do not support ref deletion");
-
 		if (ref->peer_ref) {
 			if (strcmp(ref->peer_ref->name, ref->name))
 				die("remote-helpers do not support old:new syntax");
-- 
1.8.4-fc
