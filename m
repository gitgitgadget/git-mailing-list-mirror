From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v2] strbuf: describe the return value of strbuf_read_file
Date: Tue, 14 Jun 2016 11:44:11 +0530
Message-ID: <20160614061411.4061-1-pranit.bauva@gmail.com>
Cc: larsxschneider@gmail.com, christian.couder@gmail.com,
	chriscool@tuxfamily.org, Pranit Bauva <pranit.bauva@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 14 08:15:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bChdB-0004TE-GP
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 08:15:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbcFNGPP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 02:15:15 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35276 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbcFNGPO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 02:15:14 -0400
Received: by mail-pf0-f194.google.com with SMTP id t190so12146569pfb.2
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 23:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ocfgf6Fscg8Xg/FYFkf2ikzW+i5fvFOe8LAiL4S4MSQ=;
        b=P/eTDnshzFPS96utNErQv+P8i/XL2Eq9TFkkAecPcBa5gSxP6KtPsTkXdnq1hRkUvU
         1zLuBSxoatZopYJyF75XW68Xsi6HPJwE8SI+RSpwMNB1fomL5ownaT1/oPjQ6JTVMHSL
         FIC87kljjlkFGM8Riwsij9xonpAoJltC/gPM/Rd1LJEWvRItnlalWMe44o1R0Ymi29py
         RTrgO4rwgXSWhaoMuwEGfrJo1o38t3DzuRAcK+RHMCOm2WCEklpzBBPUnNjw2gKG6pbN
         s0sa4h84K0p7RiBTsYOz7UFStlLzof5Vc7uZ4d+MZYlB80Xa5eOkQgR2u3G/anJKEa48
         hz2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ocfgf6Fscg8Xg/FYFkf2ikzW+i5fvFOe8LAiL4S4MSQ=;
        b=TD7oElNPyCL3uy1cdn8a1fIyW7FKv7hRw5gTVXQXVKzhJw5A5RNG3oCyAwrnTa9Zd9
         WdrqlsIw682oTUpnqAVl49PKwXrtrN5LION1OngriaTg9WajxIz4lXYwJo9FHppWYT72
         HY3kVmdr8GvKJWQgyGOTZ29YJSy2UZQ6/HaikxvFGgGMQ4HVrVJ2v54aQASLFOT1UPu6
         gauY9f+4mvh2rNy4ydqE6zt2NAt0siRKJJmbziH0boq2Ymsplu5UkF3YYGst33pmRmyY
         mWBjSdrJAgZcGA2jQphCl7r+ffnivv1SrP77MyiQ5FKCSl/MTv4LaEdi+bSjq5pTYnoE
         gL2Q==
X-Gm-Message-State: ALyK8tKd8fdF8ogUAsakkz1X0NXadsQ7qGD6YMixd5qFQs6ZSR/yi3cWCPU3huJk4T4wrg==
X-Received: by 10.98.36.130 with SMTP id k2mr1871662pfk.118.1465884913361;
        Mon, 13 Jun 2016 23:15:13 -0700 (PDT)
Received: from localhost.localdomain ([27.106.79.124])
        by smtp.gmail.com with ESMTPSA id g86sm41999130pfd.67.2016.06.13.23.15.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jun 2016 23:15:12 -0700 (PDT)
X-Mailer: git-send-email 2.8.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297266>

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 strbuf.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/strbuf.h b/strbuf.h
index 7987405..83c5c98 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -377,6 +377,8 @@ extern ssize_t strbuf_read_once(struct strbuf *, int fd, size_t hint);
 /**
  * Read the contents of a file, specified by its path. The third argument
  * can be used to give a hint about the file size, to avoid reallocs.
+ * Return the number of bytes read or a negative value if some error
+ * occurred while opening or reading the file.
  */
 extern ssize_t strbuf_read_file(struct strbuf *sb, const char *path, size_t hint);
 
-- 
2.8.4
