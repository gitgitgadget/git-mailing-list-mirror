From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 12/22] fsck.c: use the FORMATPRINTF macro to declare the gcc function attribute 'format printf'
Date: Thu, 11 Feb 2016 12:38:49 +0000
Message-ID: <1455194339-859-13-git-send-email-gitter.spiros@gmail.com>
References: <1455194339-859-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 13:39:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTqXB-000869-Mb
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 13:39:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752983AbcBKMjd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 07:39:33 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33706 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752816AbcBKMj2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 07:39:28 -0500
Received: by mail-wm0-f66.google.com with SMTP id c200so10464035wme.0
        for <git@vger.kernel.org>; Thu, 11 Feb 2016 04:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CK1r6PHa1Bddv4VXYqnU0eL4rFhNIyRR4Bw63yacUeo=;
        b=t7fU3XFAyLSrg1PRB/aWe5rt+vynigNns9X+1Vd2Y0fcf8hShV1FfzozO1MuRfQRR+
         7e7OV3KEO7C6uYiwgGF66sHpqoODzWtD/P9o7KbnnFbC3ipe6pspDdH2apkmi4pDoCG8
         gk0EkCJOJ+oqCZlHjL/gTP2PkuV1SUN51Zo72jwBZCelc37YA5kGvw3TBtCmOzIkWU7s
         6a13u7/swwHjDoHrE8CMwyyXO52Ow8fMDUxo2JENT511YdBCfuk96CMqL2RC0WR/Tspc
         dkKfayGBXAiSfi3OO2Vip13Qd6OKkJ+32iV9j+4rY2LKdDS/KKe0/PmasZBByUvUv39B
         YWVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CK1r6PHa1Bddv4VXYqnU0eL4rFhNIyRR4Bw63yacUeo=;
        b=gEIIgPXarF6yONOjpluj5qS5AAfZHyEM0w3p7PRGYc3ctYx0TUF4rcrHmbOrzghqvJ
         MksU8KO9aF21Wzn+Mz+/PKhO8T0KLuM7pc/KJN97d5MSbckKDVKz2O+YzIO5CI0wCOHF
         USBZWnJdnmB92zRRZYeLp0ffloXLDpRsA5IsDuo6DVxRGZy1LzORTZirC6JG5koYzXhD
         Cr8VIHpnH9Ae9bdIg4htXmPOw8AwbpIp3GpmJmKhWVeLZzMJJ902vx47t2xEA8e0bO6e
         5nQiHyfWZBmw6U+2zIgxiHT7uApFlLu3tLhrYwuzb7Sykqc5wHDTo66IBVEiUHHRZ78j
         N0xg==
X-Gm-Message-State: AG10YOSAX41eDKxtpASPHnXGlI7fkGEjtdaCsr5xuFh3sN3NSNij9PcjT1Y8TtQxCdyzcA==
X-Received: by 10.28.99.69 with SMTP id x66mr17964482wmb.95.1455194367352;
        Thu, 11 Feb 2016 04:39:27 -0800 (PST)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([40.113.119.92])
        by smtp.gmail.com with ESMTPSA id gt7sm7457368wjc.1.2016.02.11.04.39.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Feb 2016 04:39:26 -0800 (PST)
X-Mailer: git-send-email 2.7.0.327.gff4ea60.dirty
In-Reply-To: <1455194339-859-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285962>

Use the new FORMATPRINTF macro (in git-compat-util.h) to declare the gcc function
attribute 'format printf'

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 fsck.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fsck.c b/fsck.c
index c637f66..953b8e4 100644
--- a/fsck.c
+++ b/fsck.c
@@ -264,7 +264,7 @@ static void append_msg_id(struct strbuf *sb, const char *msg_id)
 	strbuf_addstr(sb, ": ");
 }
 
-__attribute__((format (printf, 4, 5)))
+FORMATPRINTF(4,5)
 static int report(struct fsck_options *options, struct object *object,
 	enum fsck_msg_id id, const char *fmt, ...)
 {
-- 
2.5.0
