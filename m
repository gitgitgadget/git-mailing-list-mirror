From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 22/22] wt-status.h: use the FORMATPRINTF macro to declare the gcc function attribute 'format printf'
Date: Thu, 11 Feb 2016 12:38:59 +0000
Message-ID: <1455194339-859-23-git-send-email-gitter.spiros@gmail.com>
References: <1455194339-859-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 13:39:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTqXI-000869-IT
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 13:39:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753046AbcBKMjk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 07:39:40 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35732 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752954AbcBKMjf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 07:39:35 -0500
Received: by mail-wm0-f66.google.com with SMTP id g62so10464918wme.2
        for <git@vger.kernel.org>; Thu, 11 Feb 2016 04:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VIlfYHnbV9LHTwzQIB1Cvchf9l/2DnyB1P3oru0F49c=;
        b=tfgkmWZMZXVp+xY2eNhlVcp/2bZFHzsCOk8RD3Ozyc4LGsRd3/Ii1pTLkq1mVhlZ7w
         cXF/Talta6WpYPgbXMW+Ngb45+1dS2iE8Vdf6jcHNRVmO4UHpmQGKRCCmJpXD/jM2Cbt
         l8iwsLKuO0Of6u3LGNGSmXFodpYAsZCyjoT8Qc7KRFPXXyUFzS7r4/b8exWZNX3NYA+u
         MQaOVnlrYFTFEMPXLtiB2h8+NS6Z8kREl4g3FOkg7bUAYJcdjvSdHwxIdVpo3Qg6z+QR
         ifa7l7s2f52nt60l1nqAPtflVnLs2u0KBeS2LgBrF6Y/gVD2EzUVeB451wnlcKnIbYZW
         3QzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VIlfYHnbV9LHTwzQIB1Cvchf9l/2DnyB1P3oru0F49c=;
        b=EdiFhYruNJs942MyuMlZc9MSxF6aDlc9iZeoVTF5PfH80JsD1CqWIX7lwMgQuKiSNH
         L3fbyattDq7pXIgrZZxg9DPUPY2eGYrrvo76BIjUVEEJ6n9nKeOLFgvaugyuTVfNcw39
         8OwGeYeA1vlkU5aO7Ie/krKOJe4UyomnCs1OhrJK9K7QiKNjVC33WuyeusyrYVguM5uB
         IPh00mh72LIyvkXGdcHjUf288n+pUKU4+u3tNtzWiz2rJwu8QDdXkO/xgQe1zlE90r74
         c4u8f//b4K5dhZDGhq62jvYbCGE0jtkCvv8bDEpkMljgTlvPDTZs9FnQxfcm6BiqVdDL
         3QlA==
X-Gm-Message-State: AG10YOQx5+ef+ah8ANBvkZQop7ZLlegAQYqfiyDn4aIrnTXXjvvaAK2fvhCzxG84HYEf+g==
X-Received: by 10.194.158.73 with SMTP id ws9mr51621753wjb.40.1455194374568;
        Thu, 11 Feb 2016 04:39:34 -0800 (PST)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([40.113.119.92])
        by smtp.gmail.com with ESMTPSA id gt7sm7457368wjc.1.2016.02.11.04.39.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Feb 2016 04:39:34 -0800 (PST)
X-Mailer: git-send-email 2.7.0.327.gff4ea60.dirty
In-Reply-To: <1455194339-859-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285960>

Use the new FORMATPRINTF macro (in git-compat-util.h) to declare the gcc function
attribute 'format printf'

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 wt-status.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/wt-status.h b/wt-status.h
index c9b3b74..f8b403a 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -104,9 +104,9 @@ void wt_status_get_state(struct wt_status_state *state, int get_detached_from);
 void wt_shortstatus_print(struct wt_status *s);
 void wt_porcelain_print(struct wt_status *s);
 
-__attribute__((format (printf, 3, 4)))
+FORMATPRINTF(3,4)
 void status_printf_ln(struct wt_status *s, const char *color, const char *fmt, ...);
-__attribute__((format (printf, 3, 4)))
+FORMATPRINTF(3,4)
 void status_printf(struct wt_status *s, const char *color, const char *fmt, ...);
 
 #endif /* STATUS_H */
-- 
2.5.0
