From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 11/22] daemon.c: use the FORMATPRINTF macro to declare the gcc function attribute 'format printf'
Date: Thu, 11 Feb 2016 12:38:48 +0000
Message-ID: <1455194339-859-12-git-send-email-gitter.spiros@gmail.com>
References: <1455194339-859-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 13:40:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTqXc-00006h-Pf
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 13:40:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752872AbcBKMj3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 07:39:29 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36162 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbcBKMj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 07:39:27 -0500
Received: by mail-wm0-f66.google.com with SMTP id 128so10426466wmz.3
        for <git@vger.kernel.org>; Thu, 11 Feb 2016 04:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=URSjBKWEtgk7Tl6hMDjtk7m8zryMHsFJI+WS6PHgHVg=;
        b=yAZhrt0eUdF83nd+fthvHgwVWmqwIXajjcnVIiRbB4sdCWMA2uPtPMsD9LuB+ak40I
         3vsuKC9AVjHdCm5V+cSt25qI7Mz+KRrWSFtkKHN4pHavQejz7svN9n9LP9c0+S2WYHJt
         RuJSRGjL5BS03ESSNnC+LuLRHEmjJhOq5MheoaaWb09Pt/lD7IMsbSbMoP6f70rNeuUF
         aKj7PWBAEpIg9/aH9C/GnATOYGy0ZldCvcz1NKQao48UC/U/r2fKxgbTpyOGp6S6muCp
         2eGnHLxrnj5OSBUEzDX6+0uF+2rh+YmTj9QXqgzrTbkpfTcw2kx2YfibKhp5xGn19I90
         2DFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=URSjBKWEtgk7Tl6hMDjtk7m8zryMHsFJI+WS6PHgHVg=;
        b=iMdu25nmALu3xSY2JR9trLxpxr6SvLqftEQYYOsz8//VlZyJRoQouaP8d61lZQTKw6
         Ui0Gg+SyzykT9vAoOv0jXh6GWPgdcdiWTk4dUWvKih069IeA4yvGzinZ6sIkBk7Imru1
         OWSW4MtfJYCdueWoUGabGsVUOOvlUKB/4P3C4F5Gvuzzf7Yrc+rxVAHMSXljgeS3RE3F
         4/TxCqzHNmY8TWGYV8eFGr2K/kp7w+XSupOznMc7e/j3AEMwQga9gTPYxAL012ehemmQ
         nD5uUvcanmnROJ6byvLPTpRi5J18nSy+EPRxtH/M/lRETvlPuGxCijqnIUtm8FktqdIL
         okgA==
X-Gm-Message-State: AG10YOSzPQN8G1FrAkn00MO8xu7yCOl/FRjAVXythLOtkqUbEPepps7EBspHkySAW0jUTw==
X-Received: by 10.28.128.138 with SMTP id b132mr18270943wmd.26.1455194366193;
        Thu, 11 Feb 2016 04:39:26 -0800 (PST)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([40.113.119.92])
        by smtp.gmail.com with ESMTPSA id gt7sm7457368wjc.1.2016.02.11.04.39.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Feb 2016 04:39:25 -0800 (PST)
X-Mailer: git-send-email 2.7.0.327.gff4ea60.dirty
In-Reply-To: <1455194339-859-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285973>

Use the new FORMATPRINTF macro (in git-compat-util.h) to declare the gcc function
attribute 'format printf'

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 daemon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/daemon.c b/daemon.c
index 46b411c..b4a9207 100644
--- a/daemon.c
+++ b/daemon.c
@@ -95,7 +95,7 @@ static void logreport(int priority, const char *err, va_list params)
 	}
 }
 
-__attribute__((format (printf, 1, 2)))
+FORMATPRINTF(1,2)
 static void logerror(const char *err, ...)
 {
 	va_list params;
@@ -104,7 +104,7 @@ static void logerror(const char *err, ...)
 	va_end(params);
 }
 
-__attribute__((format (printf, 1, 2)))
+FORMATPRINTF(1,2)
 static void loginfo(const char *err, ...)
 {
 	va_list params;
-- 
2.5.0
