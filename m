From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 04/22] builtin/index-pack.c: use the FORMATPRINTF macro to declare the gcc function attribute 'format printf'
Date: Thu, 11 Feb 2016 12:38:41 +0000
Message-ID: <1455194339-859-5-git-send-email-gitter.spiros@gmail.com>
References: <1455194339-859-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 13:40:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTqYA-0000Xw-I1
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 13:40:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753166AbcBKMka (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 07:40:30 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33825 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268AbcBKMjV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 07:39:21 -0500
Received: by mail-wm0-f65.google.com with SMTP id p63so10438189wmp.1
        for <git@vger.kernel.org>; Thu, 11 Feb 2016 04:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=la5daEQYKANzdNkFtpaww5pfjNK7Nx3vtxAkRR2mL00=;
        b=t2yGjSlaWZ2Scq2332ebvn8LRCkqCD/C4XATlc1jAy9ARpkcDx4FLDzDKB+5MB5hwn
         fmvYf+vcrRDhbjCpvkLzwL5n/KPi9/oEdZjRazqQR4+3RyvdXAa78J1kmeKAT+vIxcLp
         VHirUHMzHmHpSO98CJqCsJzjGXPrzzq/GqAhXg7RYXyOgRJ1lu7uwbYBSw7afXZnJQz9
         CrWJi69cRBJiMlgkPJn3T7AJPAs8LYFnx8+mFw/w/Nc6NyxFzkcqo3Wha8hko9eKpD5n
         sec5n9ex/tpXEa0NcYZ+BV/VqacwuEPN+QBcaLetNMBoeDC9/MnhyqoPZ38qfXgvpJXj
         KCgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=la5daEQYKANzdNkFtpaww5pfjNK7Nx3vtxAkRR2mL00=;
        b=biGA4pSufEIgsw07lHuGyzPyfWfAPG1LvMc5oWCa0TB/pxR3XX82Eaakdsg13m21Oz
         qHKMOA21/TJLdmJUAfzJQt4gyk6z41TaHZgNIJa4Q53Y+KF8m+j+J29P29GU+0Y7zpH1
         ZBftx8aCtL6OadzM7VaD8CiZgj3VswwtoQfsyHJ/PKpknFbVUYCjGpwGbE9b72NPdeAu
         pKM/wa64Vf/7cb8601lvOLQOo/ApUgL/VKlRR1wFyCYeVtvX4LRNY6XhRfkQVcTArkzY
         KIaRqiDys5MIJV6r0eHmmgfQJ29N/obQ8N2+V08XdlAlT9gR8h9kLgsBqKF99CRymmGY
         owJQ==
X-Gm-Message-State: AG10YOTQrPafRcMsCClSXvQtC0yKIRmJw09g/cbEyu7IsB9He0XKX1UwdfuSWR9G90eqlg==
X-Received: by 10.28.221.68 with SMTP id u65mr17945489wmg.95.1455194360701;
        Thu, 11 Feb 2016 04:39:20 -0800 (PST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285978>

Use the new FORMATPRINTF macro (in git-compat-util.h) to declare the gcc function
attribute 'format printf'

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 builtin/index-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 6a01509..5941963 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -339,7 +339,7 @@ static void parse_pack_header(void)
 }
 
 static NORETURN void bad_object(unsigned long offset, const char *format,
-		       ...) __attribute__((format (printf, 2, 3)));
+		       ...) FORMATPRINTF(2,3);
 
 static NORETURN void bad_object(unsigned long offset, const char *format, ...)
 {
-- 
2.5.0
