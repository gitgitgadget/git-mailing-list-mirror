From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 06/22] builtin/update-index.c: use the FORMATPRINTF macro to declare the gcc function attribute 'format printf'
Date: Thu, 11 Feb 2016 12:38:43 +0000
Message-ID: <1455194339-859-7-git-send-email-gitter.spiros@gmail.com>
References: <1455194339-859-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 13:39:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTqWy-0007te-Gi
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 13:39:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752855AbcBKMj0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 07:39:26 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36131 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbcBKMjX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 07:39:23 -0500
Received: by mail-wm0-f65.google.com with SMTP id 128so10426158wmz.3
        for <git@vger.kernel.org>; Thu, 11 Feb 2016 04:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vYzn2JC6J9l8Ukm50NAoRogLkLHhzqlvrv7ZIK+J40k=;
        b=uQZ6PuL7Pm+qw2MjTFhQDGDXmb0Ihpm55bnSaBKSpAVLalnNtc3UwLT7BeZKeIwePi
         X7fAmn/m3Me5986f87a6K1jksp12OlcVRPo74AT1oguRqiCjd/eWEk0fJOHBdkXGD4ew
         hdcMJ50+DjWOF3Vei9yrSNwLmpOAm/b5SXiN9P0/Gc1JNxfc4KVSIN8RreKISjR6G/Oh
         sNGW1+L9I4PdjDgr56s3/B4L83V0rIUGBM1P5kma4llgc0mz2IpCuYbpX9joaZbwrC9A
         W/BLcPDa7H+4feyn0NfConGLs4YR4SW3lx7u0ywt/O5/pYchYjAxEkHRqf2mCzwcWzBo
         W5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vYzn2JC6J9l8Ukm50NAoRogLkLHhzqlvrv7ZIK+J40k=;
        b=f8X+JWAiPm81e1fbaS6jcBR5/KIcsrDqTmepyydu9l4Hd6mhYnGzTZK+xW7dKZo4Vj
         bRCipkfFP/6y9uH8YJsyFcFsVyp5Aw/ezby0VKTzzhP7Deckkt1ioe/F9g3W7sagsRLJ
         6hQn/M9HlP6410HfWT4WiE/AhyEfEpHleqB8o58MC9cyPSsepwLY3uG7HXIaFZ9H5jW7
         BZRpi/Khoc7AkCUWZyWRZIZk0dbRCFIv1i5AWlcZlUSnht8YQOfKzjz6oAMq/zbBKq5u
         JcrQXeBCO8aVqktEHstOUU3lI0vACf2Gd9wYOsKTaZ6BeV4aWBeZfBiYcHlcLgXU/wuR
         ADgQ==
X-Gm-Message-State: AG10YORh4D5fj23mFXMg9naO7nezx6uk0jfdgHcLq46l7a1yh+c7LCe3zhb0y6IeLUurbg==
X-Received: by 10.28.60.84 with SMTP id j81mr17862791wma.91.1455194362655;
        Thu, 11 Feb 2016 04:39:22 -0800 (PST)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([40.113.119.92])
        by smtp.gmail.com with ESMTPSA id gt7sm7457368wjc.1.2016.02.11.04.39.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Feb 2016 04:39:22 -0800 (PST)
X-Mailer: git-send-email 2.7.0.327.gff4ea60.dirty
In-Reply-To: <1455194339-859-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285959>

Use the new FORMATPRINTF macro (in git-compat-util.h) to declare the gcc function
attribute 'format printf'

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 builtin/update-index.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 7c5c143..cc62b76 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -35,7 +35,7 @@ static int mark_skip_worktree_only;
 #define UNMARK_FLAG 2
 static struct strbuf mtime_dir = STRBUF_INIT;
 
-__attribute__((format (printf, 1, 2)))
+FORMATPRINTF(1,2)
 static void report(const char *fmt, ...)
 {
 	va_list vp;
-- 
2.5.0
