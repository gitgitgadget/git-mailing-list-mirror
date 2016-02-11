From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 05/22] builtin/receive-pack.c: use the FORMATPRINTF macro to declare the gcc function attribute 'format printf'
Date: Thu, 11 Feb 2016 12:38:42 +0000
Message-ID: <1455194339-859-6-git-send-email-gitter.spiros@gmail.com>
References: <1455194339-859-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 13:40:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTqXm-0000DJ-5c
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 13:40:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753121AbcBKMkS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 07:40:18 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33832 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313AbcBKMjW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 07:39:22 -0500
Received: by mail-wm0-f65.google.com with SMTP id p63so10438242wmp.1
        for <git@vger.kernel.org>; Thu, 11 Feb 2016 04:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BH1lYzlMyyxkDcKjcdVm2PinIXVDO4HIvzrzMOjVkYM=;
        b=Csa6L/XEAeEHsfdRCZsQAdQYZuWO/InhtW7UQIPOvKo45sdrpclH9pax6tF1GFaOHr
         X2e/jfYYa4trsZkzhZ69EZNRjRX0NHi2Fnec/yhg0oCs4P3QeTgQjEMLD2so2te3J2mF
         O/shux2Rg8NIk+DmZAD/jTexnNOgn+0eHh4yQ7dXtkeY9Luez8zUyHC4sTjrPCEVdsiH
         w+jTvC+yekf6ARCpDDeYzc/Pje73dlZvzPMHn4wC9UV3vP6yYssS3hflUs4c8FuW/1Xd
         qwr+7YHEhyTQjP8Pqo1kJs8y0rFqUWedrW5DkY10o/L+PKDfL2GwY78QhgewUyVLq7/w
         t6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BH1lYzlMyyxkDcKjcdVm2PinIXVDO4HIvzrzMOjVkYM=;
        b=OViUtvKrLUljLPosdHXEb0+HKkI6K6fYK6+x05thptrH0DHi+fAO4YX5+Tsye6CjhH
         bIIKn2c6RpXz41mLiXhx3tQTLPH7DCj+lAh3wjCbltCPT9a+tvx8P9SNxaPcAWh0BnoV
         XbqIqfVk8iTG01EQaddSwxTb8DWKmbXJMFYHPhzCxyz65JsbdszuTSAXwHcP4UZizR8u
         sJlzqY/64TSOa+7Nwb5CVmpqczDulPhjh74K6Qj4wlGClvBoMbfl14b+UfZo6Cm7jcUV
         kdBDR2RzRGDCGqCzTACLaLJu8NnmeSoxeWhp2s9ay9lkbfXrsBdVoHQXpxklKxjCk5Ys
         yHEw==
X-Gm-Message-State: AG10YOTXaFfFZfYZ+MH6JEmPE2+GbY2ZFm1emSUJxWsk+gzA+M23Vn/Kl6lVuATRyD3dmw==
X-Received: by 10.28.228.213 with SMTP id b204mr17851153wmh.82.1455194361462;
        Thu, 11 Feb 2016 04:39:21 -0800 (PST)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([40.113.119.92])
        by smtp.gmail.com with ESMTPSA id gt7sm7457368wjc.1.2016.02.11.04.39.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Feb 2016 04:39:20 -0800 (PST)
X-Mailer: git-send-email 2.7.0.327.gff4ea60.dirty
In-Reply-To: <1455194339-859-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285975>

Use the new FORMATPRINTF macro (in git-compat-util.h) to declare the gcc function
attribute 'format printf'

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 builtin/receive-pack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index f2d6761..956278f 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -277,8 +277,8 @@ struct command {
 	char ref_name[FLEX_ARRAY]; /* more */
 };
 
-static void rp_error(const char *err, ...) __attribute__((format (printf, 1, 2)));
-static void rp_warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
+static void rp_error(const char *err, ...) FORMATPRINTF(1,2);
+static void rp_warning(const char *err, ...) FORMATPRINTF(1,2);
 
 static void report_message(const char *prefix, const char *err, va_list params)
 {
-- 
2.5.0
