From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 20/22] transport-helper.c: use the FORMATPRINTF macro to declare the gcc function attribute 'format printf'
Date: Thu, 11 Feb 2016 12:38:57 +0000
Message-ID: <1455194339-859-21-git-send-email-gitter.spiros@gmail.com>
References: <1455194339-859-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 13:39:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTqXC-000869-R2
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 13:39:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753030AbcBKMjk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 07:39:40 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33784 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752979AbcBKMje (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 07:39:34 -0500
Received: by mail-wm0-f65.google.com with SMTP id c200so10464520wme.0
        for <git@vger.kernel.org>; Thu, 11 Feb 2016 04:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zXLMpb+JVXEzAR9zBpa55kWiHH3PvWuI+Wpop44ROtI=;
        b=KSzS/upzBbkK96qTkLO6oPSOrGmFIzmUt0hhmnUAquNYr+Q7oULABkPZMjnE6Gsdv/
         yFM+7f/eHzpHK0nRPpE7IbQ4gHHv0I0c6BPPmWGLagUUX7DnzP023exsp3nFuGHqNuTH
         tMG4bcP2ZyPNRquDEZxigDR2doWbW85mlm8UKj8ZXFvshTd9Eo2lDwqoGoUK/oqtt6uH
         p8hmmRPiP8RyQ8NQrMqkjoJC8sIfmR8NIrhHYjLMWE4ytEQ0+YHGQcRDHSgERf65HdWL
         Gz/met7DUCnMmuO0LiEgGDezJ+Asb6XCn77rs/JQ/8B1dJJ1A9nh2YRXvSLUwW7pLyXy
         c5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zXLMpb+JVXEzAR9zBpa55kWiHH3PvWuI+Wpop44ROtI=;
        b=DN4ZRJAkxlYmcmzGod6+PZ0sxf85O1aTTvq1rVmUXy9leOpMi3eQcNPH9GydCJ5IR+
         v4nXmZaIGabjS0i1q2KR+Z56rL+THVFW05vM8BAvolmAXtchD8SfJrQqgdIejiMVHQta
         LnbsBeM3qgnx39Msax4aUzHVbgoMqbgyolgWSPcVh645/RMlpIbUGhNGoIIHTMcbWvlt
         AlmF08TiV5lSN/f3hky3RrACogBeEziEft9qH1Ju2vUyxTlNzYXsA8WBCpPoH3pv6SH3
         g+Ujvcs7OXGuUOl68vLlzu6+nOXSXz1ehdtz3tRxHXst959m1U53XG0O7lXFVIhRQai6
         W2Cg==
X-Gm-Message-State: AG10YOQ+sBpXZ3U8nvrcco1T/RU7LeDEBo8AzmiuZ5MCMICsRIRTo3EnYYXUE3juxvTwZA==
X-Received: by 10.28.93.140 with SMTP id r134mr18121840wmb.80.1455194373207;
        Thu, 11 Feb 2016 04:39:33 -0800 (PST)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([40.113.119.92])
        by smtp.gmail.com with ESMTPSA id gt7sm7457368wjc.1.2016.02.11.04.39.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Feb 2016 04:39:32 -0800 (PST)
X-Mailer: git-send-email 2.7.0.327.gff4ea60.dirty
In-Reply-To: <1455194339-859-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285961>

Use the new FORMATPRINTF macro (in git-compat-util.h) to declare the gcc function
attribute 'format printf'

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 transport-helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/transport-helper.c b/transport-helper.c
index a6bff8b..94c7aab 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1069,7 +1069,7 @@ int transport_helper_init(struct transport *transport, const char *name)
 #define PBUFFERSIZE 8192
 
 /* Print bidirectional transfer loop debug message. */
-__attribute__((format (printf, 1, 2)))
+FORMATPRINTF(1,2)
 static void transfer_debug(const char *fmt, ...)
 {
 	va_list args;
-- 
2.5.0
