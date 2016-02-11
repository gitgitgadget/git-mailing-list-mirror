From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 09/22] color.h: use the FORMATPRINTF macro to declare the gcc function attribute 'format printf'
Date: Thu, 11 Feb 2016 12:38:46 +0000
Message-ID: <1455194339-859-10-git-send-email-gitter.spiros@gmail.com>
References: <1455194339-859-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 13:40:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTqXR-0008N9-DP
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 13:40:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752941AbcBKMjb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 07:39:31 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35616 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752825AbcBKMjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 07:39:25 -0500
Received: by mail-wm0-f65.google.com with SMTP id g62so10464186wme.2
        for <git@vger.kernel.org>; Thu, 11 Feb 2016 04:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bY7Jsk4aKwlLIgfQDRWazvDG+hSFAHD0YkzTp5DRM4M=;
        b=bgLUOalMlNOCd7lL76jVVyroEmcUp80KK70fsE4GVUEAVKlocTDwmLJQQlH7esVzTo
         6SqqX2xiTUd769RFRwGJAbrDjGEx979LNBqm/7fg0czOgLAejof0NQLfmrSxw/buUpc7
         i2x3G/lPpuCKBsqjMGzUpJQecQotH69z9hc03MpdHx+MyPWYiF0phpj3p0zrbMeyZKfy
         S8Fwrn8wsnB3RlIMUBuMLneJ5uFqNahjTP3NWz6L2wgFbnRJaB6ZM0GYu/tXxhjHzHwL
         xep178THItSIfy/7pQWjSlSUx9F3WVnnivvSh1utWbrx+MZnSHatnBdrnVQg02eOFSXu
         jTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bY7Jsk4aKwlLIgfQDRWazvDG+hSFAHD0YkzTp5DRM4M=;
        b=b9/6Of6dt2AdRXqxzWUQsOVCqqq60h7vDoqshCXizhNsUMd7CJgWfo9+LcPjyEXOx+
         tGHQg6rg055jytp3xNhh5wrQ7rDls2X9JObVM3b6m7LfwBuWqOZ43QbydxGfL+37tZxy
         XmOogdK7RO3SI/1k1DuqKk/htVj0DAC30iTCw3I7SfVwRmdhBWtGz6jOKWYlR2Gp4Ipq
         LISUXe8IA+6b8L83JAoKhzszXxaeWDLpYCZ3j72Hjx66LTcF801ICCyRiGMK3KxYvOfq
         CVOptnm3ewGo9pFY4Ne9h7PDZdI9IsSVAzZ7gWLDk5i/Noq/yv5QjJgDxJRCun1J2tR/
         MqTQ==
X-Gm-Message-State: AG10YOTBmU6AN4wG3iBjVnv7Bm2nT3cm3F2KOh0iKKoIZo+fQt72BzAwQkP3595qls9EGA==
X-Received: by 10.28.100.134 with SMTP id y128mr18233438wmb.87.1455194364834;
        Thu, 11 Feb 2016 04:39:24 -0800 (PST)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([40.113.119.92])
        by smtp.gmail.com with ESMTPSA id gt7sm7457368wjc.1.2016.02.11.04.39.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Feb 2016 04:39:24 -0800 (PST)
X-Mailer: git-send-email 2.7.0.327.gff4ea60.dirty
In-Reply-To: <1455194339-859-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285967>

Use the new FORMATPRINTF macro (in git-compat-util.h) to declare the gcc function
attribute 'format printf'

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 color.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/color.h b/color.h
index e155d13..8f763d7 100644
--- a/color.h
+++ b/color.h
@@ -86,9 +86,9 @@ int git_config_colorbool(const char *var, const char *value);
 int want_color(int var);
 int color_parse(const char *value, char *dst);
 int color_parse_mem(const char *value, int len, char *dst);
-__attribute__((format (printf, 3, 4)))
+FORMATPRINTF(3,4)
 int color_fprintf(FILE *fp, const char *color, const char *fmt, ...);
-__attribute__((format (printf, 3, 4)))
+FORMATPRINTF(3,4)
 int color_fprintf_ln(FILE *fp, const char *color, const char *fmt, ...);
 void color_print_strbuf(FILE *fp, const char *color, const struct strbuf *sb);
 
-- 
2.5.0
