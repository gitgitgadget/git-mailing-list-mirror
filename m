From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 01/10] transport-helper: fix extra lines
Date: Thu, 31 Oct 2013 03:36:29 -0600
Message-ID: <1383212197-14259-3-git-send-email-felipe.contreras@gmail.com>
References: <1383212197-14259-1-git-send-email-felipe.contreras@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 31 10:43:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vbomn-0003lV-Be
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 10:43:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753148Ab3JaJnZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 05:43:25 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:46216 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752836Ab3JaJnX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 05:43:23 -0400
Received: by mail-ob0-f169.google.com with SMTP id uz6so2787385obc.14
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 02:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UdX3V/uFiynjOcPxWosHIPnlavfFu6lxEopkWQzyYz4=;
        b=wP2Ba3vMYAhloC51R4wPidmawYrUO7faojo5+Dob9KZ+/OgMddKn/f9EItzcYJs30F
         KRDdH3t4J/nmCvAt2Y0PZCtalxq0kcA5lXOZWO2JW1pcuAkkGAoyp00UrYhSADNPb8rm
         5UQaSDW3wLPsztXnuoNezCoFFf+NYhM5HWtryeEB2y/lv7KS2qgbuxMq/5Hxjo5LYmUH
         kboXbv1BYCBbWvtdY+Ewaiz6bxONhouevIg8+yn3dE/JsFGlaDOV0np9UET4G7KJgXK0
         VJYvJRHz7dfN+953F7hGwgNxCSHpOdo0HXBmc7fuHdD3ISB/jj17Pwp5hidczG6DpMYq
         3Ksw==
X-Received: by 10.60.141.225 with SMTP id rr1mr1821124oeb.55.1383212603245;
        Thu, 31 Oct 2013 02:43:23 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id tz10sm4507170obc.10.2013.10.31.02.43.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2013 02:43:22 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.2+fc1
In-Reply-To: <1383212197-14259-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237103>

Commit 9c51558 (transport-helper: trivial code shuffle) moved these
lines above, but 99d9ec0 (Merge branch 'fc/transport-helper-no-refspec')
had a wrong merge conflict and readded them.

Reported-by: Richard Hansen <rhansen@bbn.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 transport-helper.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index b32e2d6..985eeea 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -874,9 +874,6 @@ static int push_refs_with_export(struct transport *transport,
 		}
 		free(private);
 
-		if (ref->deletion)
-			die("remote-helpers do not support ref deletion");
-
 		if (ref->peer_ref) {
 			if (strcmp(ref->peer_ref->name, ref->name))
 				die("remote-helpers do not support old:new syntax");
-- 
1.8.4.2+fc1
