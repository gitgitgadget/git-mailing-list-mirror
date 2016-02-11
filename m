From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 07/22] builtin/upload-archive.c: use the FORMATPRINTF macro to declare the gcc function attribute 'format printf'
Date: Thu, 11 Feb 2016 12:38:44 +0000
Message-ID: <1455194339-859-8-git-send-email-gitter.spiros@gmail.com>
References: <1455194339-859-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 13:40:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTqXr-0000Gj-VB
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 13:40:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753115AbcBKMkR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 07:40:17 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33666 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752360AbcBKMjY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 07:39:24 -0500
Received: by mail-wm0-f65.google.com with SMTP id c200so10463763wme.0
        for <git@vger.kernel.org>; Thu, 11 Feb 2016 04:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a9uSVzcg0hsslbgJ4LB5mX9IrB9k10+z9nsBupyNIk0=;
        b=z/cVD8/imaH0GMOBTndac+h9Nh4I3zSp8yRilITAsVLrw+z2S/m7GOGPgHxLZpU+7m
         O0Di/l/CwRlbJk1VPBlT7LvTfTrovDXnLoOxFPnhxg+cVNyxr59r1rmvsjEU1d5VDd3K
         Zeih+6B+n/+2+AoSntkxmYuDZ5EN0X5Mo6NfSXk9zh35da53InMdw7Z4rhBTLLomIeB3
         GBkYs5pBdItjD+w5GnnTvuaRYOWnZu/rdNFFfE/UZi5W3ytn3Da5jxxKYTHYMV+hYLCz
         kacE5CU3ACOcu3myQJPkc255/H3lXdHgk4Mv/KyRbvfucundsTQEuVhqT12+qynkOGUl
         JptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a9uSVzcg0hsslbgJ4LB5mX9IrB9k10+z9nsBupyNIk0=;
        b=Bad2LGjw9XRqCTltLtoTAZMBf0dDj9d2viAXEfmjQQg3MOW71fkksHMzAe6E5JA6lN
         W7pBeR8yIkZUtFvmquR61TMcE4gRUP5hRzDW+OP8PqFo2N/vB7J8400dwwrkci/f2c6a
         tR5iSMBysDyCcFv49Ht47o3vooeZh3k6za9cwTleQ8xFI2rm5VyA9MKV2KRD586+V2nP
         8/uwucsjUgVFx18hc8YW89cpQr/5w/eXuRz7XLn1CXMHJYt1gyZkKiZ/N27EG0eJqEaH
         +lvH2NdbkES85wa4FAlZ/WEOQ5sPKwUkK9jbt/wyKSs+y2CjIxAHlgWOwXxHyYFsIgmc
         nHJQ==
X-Gm-Message-State: AG10YOSTtPI29OBlDRfrsiEpN4qCWT1FjHOl5w6+f4I2F99ODhh9lZzDSyhxWyGHKcmt2Q==
X-Received: by 10.194.240.234 with SMTP id wd10mr51324712wjc.129.1455194363346;
        Thu, 11 Feb 2016 04:39:23 -0800 (PST)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([40.113.119.92])
        by smtp.gmail.com with ESMTPSA id gt7sm7457368wjc.1.2016.02.11.04.39.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Feb 2016 04:39:22 -0800 (PST)
X-Mailer: git-send-email 2.7.0.327.gff4ea60.dirty
In-Reply-To: <1455194339-859-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285977>

Use the new FORMATPRINTF macro (in git-compat-util.h) to declare the gcc function
attribute 'format printf'

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 builtin/upload-archive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index dbfe14f..3d23106 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -46,7 +46,7 @@ int cmd_upload_archive_writer(int argc, const char **argv, const char *prefix)
 	return write_archive(sent_argv.argc, sent_argv.argv, prefix, 0, NULL, 1);
 }
 
-__attribute__((format (printf, 1, 2)))
+FORMATPRINTF(1,2)
 static void error_clnt(const char *fmt, ...)
 {
 	struct strbuf buf = STRBUF_INIT;
-- 
2.5.0
