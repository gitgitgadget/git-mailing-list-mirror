From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 21/22] utf8.h: use the FORMATPRINTF macro to declare the gcc function attribute 'format printf'
Date: Thu, 11 Feb 2016 12:38:58 +0000
Message-ID: <1455194339-859-22-git-send-email-gitter.spiros@gmail.com>
References: <1455194339-859-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 13:39:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTqXA-000869-UZ
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 13:39:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753011AbcBKMjg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 07:39:36 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36252 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752816AbcBKMje (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 07:39:34 -0500
Received: by mail-wm0-f68.google.com with SMTP id 128so10427005wmz.3
        for <git@vger.kernel.org>; Thu, 11 Feb 2016 04:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=//Rwklg42yBlN/+hpa9iy6rPD90hFj4LUmHYhvH+PFk=;
        b=l8HrwLq8/g3ZxXW5kUh8O67GN9D4pAESgZ65VO52W97TqoITL2LnxlfAcxj4EOrTim
         NcFok3dqTSRAR+gnW7MSyrFMPq14NOjmk0PFfB90O5H8wju/tQlPNNAjOWr1XP//kc7g
         P0X0Yvr7/ZwXOGmLhbJ6v2SU/fmxEBw13eNJBWvkCynLornbvblfmY3lVbXwb6w/d4Vs
         +ARe2EwscVy7nwciaERL5wD+V3AwAcRtRjB+Zxg/I6XJFXYjU8iffWHpyt2y39Qt8jZO
         6L+oOGVulK6p+xUv1DRGpByV9H26WEoQyXUq6E55vVXDkgoSPfOnSjtdzJrrM530JObZ
         da+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=//Rwklg42yBlN/+hpa9iy6rPD90hFj4LUmHYhvH+PFk=;
        b=WaSurovmWhlYGoMSfJQiqfUxmm+zLh/RbjFVkRzFT8gjkggJ9iHr/+0AD1sfygMOX0
         RJaupRg3Bo+FesyWE5Bhg2KeXkNzdFwUWINUo+jTQlrY1ho8FhHTH4gK079wk4/TR0Od
         SV0HEeQsVUKlGamffhy2jct6dPX7jLGcCvvGE/F+YfJN4e1U7bsSUwGtixMfTfyHDY3X
         FSvxzQO37KAckwyJ6jepeapd3Mx60eia3DWqPpT7VkSFCKqIE+2oRvOwVRsP0Ou41LOm
         dgxRL1nR0ZCitBKYsrKiZ6f9KAflxvSujfTuEPpu05FQ8LqlFPq7PhnMgHe5rxVOMEXV
         MZLw==
X-Gm-Message-State: AG10YOS5FHF8QPIlTaV2EaXGh64oCXK3z+YxW/zEdPk+SyrVzcG2o70+9Rw56OQIRD8Byw==
X-Received: by 10.194.192.170 with SMTP id hh10mr50447835wjc.69.1455194373888;
        Thu, 11 Feb 2016 04:39:33 -0800 (PST)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([40.113.119.92])
        by smtp.gmail.com with ESMTPSA id gt7sm7457368wjc.1.2016.02.11.04.39.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Feb 2016 04:39:33 -0800 (PST)
X-Mailer: git-send-email 2.7.0.327.gff4ea60.dirty
In-Reply-To: <1455194339-859-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285965>

Use the new FORMATPRINTF macro (in git-compat-util.h) to declare the gcc function
attribute 'format printf'

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 utf8.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/utf8.h b/utf8.h
index 7930b44..3dc301c 100644
--- a/utf8.h
+++ b/utf8.h
@@ -10,7 +10,7 @@ int utf8_strwidth(const char *string);
 int is_utf8(const char *text);
 int is_encoding_utf8(const char *name);
 int same_encoding(const char *, const char *);
-__attribute__((format (printf, 2, 3)))
+FORMATPRINTF(2,3)
 int utf8_fprintf(FILE *, const char *, ...);
 
 extern const char utf8_bom[];
-- 
2.5.0
