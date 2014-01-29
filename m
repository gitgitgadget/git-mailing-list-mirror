From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 4/4] builtin/clean.c: reduce scope of variable
Date: Wed, 29 Jan 2014 05:36:15 -0800
Message-ID: <1391002575-9600-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 29 14:36:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8VJa-0008M8-69
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jan 2014 14:36:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752079AbaA2NgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jan 2014 08:36:22 -0500
Received: from mail-pd0-f169.google.com ([209.85.192.169]:40479 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294AbaA2NgV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jan 2014 08:36:21 -0500
Received: by mail-pd0-f169.google.com with SMTP id v10so1717256pde.0
        for <git@vger.kernel.org>; Wed, 29 Jan 2014 05:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=+mbl9EzvhO3Xbp8gfNUcSfRdQCs6/HrR4+/0exUb7CU=;
        b=mXe1cq4lxYEfWtSgVm9/2nQ3iBNg6cbzYgdy+b+bBL4ge7swBsOv1iAdJ5x0ABfBsb
         yvvVSrONB/KbHAbWQfyAObvHDlWZsULuvj4Z0+m6fPj2QKtvpgBn3/fcZTOFcRnbPzFj
         S67RIH0MOf83yKBFrTfWH2spfaR3y0MvBl1sKqmqsBcTp4rWlsLa9ccL5El8sQr8H3Rz
         9b34R0z4atq/tXIlM9P+fkF17YeTKEmnFYhMCCd/S/RZk/mJd5QGDnxIcRW4s8ih33f9
         4KhBhbvyJZXCZgBEnt1smOZwAovvUy859OBSDMhSuhe3uDLOAeZK7KzSCzr7vOVfg2Ij
         ps8Q==
X-Received: by 10.68.7.66 with SMTP id h2mr7861859pba.91.1391002579258;
        Wed, 29 Jan 2014 05:36:19 -0800 (PST)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id cz3sm7314765pbc.9.2014.01.29.05.36.18
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 29 Jan 2014 05:36:18 -0800 (PST)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241211>

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 builtin/clean.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 2f26297..a1f8969 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -154,7 +154,7 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 	DIR *dir;
 	struct strbuf quoted = STRBUF_INIT;
 	struct dirent *e;
-	int res = 0, ret = 0, gone = 1, original_len = path->len, len, i;
+	int res = 0, ret = 0, gone = 1, original_len = path->len, len;
 	unsigned char submodule_head[20];
 	struct string_list dels = STRING_LIST_INIT_DUP;
 
@@ -242,6 +242,7 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 	}
 
 	if (!*dir_gone && !quiet) {
+		int i;
 		for (i = 0; i < dels.nr; i++)
 			printf(dry_run ?  _(msg_would_remove) : _(msg_remove), dels.items[i].string);
 	}
-- 
1.7.10.4
