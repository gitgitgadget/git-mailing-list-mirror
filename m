From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 16/22] pkt-line.h: use the FORMATPRINTF macro to declare the gcc function attribute 'format printf'
Date: Thu, 11 Feb 2016 12:38:53 +0000
Message-ID: <1455194339-859-17-git-send-email-gitter.spiros@gmail.com>
References: <1455194339-859-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 13:40:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTqXS-0008N9-K8
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 13:40:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753107AbcBKMj6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 07:39:58 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33734 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752878AbcBKMjb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 07:39:31 -0500
Received: by mail-wm0-f67.google.com with SMTP id c200so10464227wme.0
        for <git@vger.kernel.org>; Thu, 11 Feb 2016 04:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8Lilk3KHBvjmdCydo0E0JHP1zhhIRbztNyvngsbNSX4=;
        b=GmaR2oooKxCUdBb+AIFp2VSDGiho569KhW7aitFSmzV+KJ5a4oF7erI3jFyPiIm20Y
         hmYdsv4CCH6nNAIX1bNKGzhO2nLy7njoFqaL0ESmxdzFHkJzEX+nz128ZNm+lCEtUUh8
         Ut+nOTQQkt9+ufC+Wulc9AuymDr/aqGp/CbPzfrr62u0KS3Rmk9X4mF9g9loL/xiXFH2
         v3fgXmgEfJz/CWU46lpG/tceFqeUG5Ad0P+X5jyBYTNk5HsFH72rwDynPy3fnZpkwS8t
         nrDDBd8pA+JdbV4TrEjyj5Qu0wC96iOjhq8awm76wnbDCqbQ4/clwgEj3y+UGxKtIRp0
         1xXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8Lilk3KHBvjmdCydo0E0JHP1zhhIRbztNyvngsbNSX4=;
        b=TdeX44SrlGOknab4vLiILviFXTbgpb/qmYTnLQ/FNubnTCASuuJlx38u/XkxIbOvEs
         Gp+kpduBGg6/8Kb3rcVMw59jF+xaRKh0PkAlFhkGEOOU7FFRBTvJUxlhBq9x5m+84QHE
         9/qYBHRzNh4kOyiVheyRBOfT/zPfs6tZ0sfKk9dm7cQStpxh1lt+fXJ88CS2hErmmAR4
         GdDNkuicU1RBtmFM9xNozl6HURsT6WhCmp/bhYnq99vXqus4W+7bLpUo8sF9JFx1Oe6Z
         ocuIRLJazuG/UBVBfHJ+sudVEUFi3TkgqvdbxIthxe5g9KNRg0o3UfSSaRMrqnqoXhGe
         zMqg==
X-Gm-Message-State: AG10YORUiNVwgPXnrwG+mGU0AQRiWJaVqcysJQTWOFS9zgfAg5dlK3pp3vN3ft2dXPELAA==
X-Received: by 10.194.82.36 with SMTP id f4mr49243014wjy.87.1455194370078;
        Thu, 11 Feb 2016 04:39:30 -0800 (PST)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([40.113.119.92])
        by smtp.gmail.com with ESMTPSA id gt7sm7457368wjc.1.2016.02.11.04.39.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Feb 2016 04:39:29 -0800 (PST)
X-Mailer: git-send-email 2.7.0.327.gff4ea60.dirty
In-Reply-To: <1455194339-859-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285970>

Use the new FORMATPRINTF macro (in git-compat-util.h) to declare the gcc function
attribute 'format printf'

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 pkt-line.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/pkt-line.h b/pkt-line.h
index 3cb9d91..d3ba3be 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -20,9 +20,9 @@
  * side can't, we stay with pure read/write interfaces.
  */
 void packet_flush(int fd);
-void packet_write(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
+void packet_write(int fd, const char *fmt, ...) FORMATPRINTF(2,3);
 void packet_buf_flush(struct strbuf *buf);
-void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
+void packet_buf_write(struct strbuf *buf, const char *fmt, ...) FORMATPRINTF(2,3);
 
 /*
  * Read a packetized line into the buffer, which must be at least size bytes
-- 
2.5.0
