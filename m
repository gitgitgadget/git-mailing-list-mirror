From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH] cat-file: Move assignment to the buffer declaration
Date: Fri,  9 Jan 2015 00:20:03 +0600
Message-ID: <1420741203-21107-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 08 19:21:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9Hgx-0001NY-S8
	for gcvg-git-2@plane.gmane.org; Thu, 08 Jan 2015 19:20:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757145AbbAHSUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2015 13:20:13 -0500
Received: from mail-lb0-f179.google.com ([209.85.217.179]:45433 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756991AbbAHSUL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2015 13:20:11 -0500
Received: by mail-lb0-f179.google.com with SMTP id z11so4318654lbi.10
        for <git@vger.kernel.org>; Thu, 08 Jan 2015 10:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=o/ntf1aioVWsTl5DZaJePJROCnF8MXF7278GGOTErGI=;
        b=T042y+vxezmXsUeRx/V9/seVv99w1TUPs+Xr0GjrsSNrx6Y8kMZp90qU60v3K0vgJO
         WV48i2F46IM2+dZdFcAiNkHk0MXVPuZp5knZNEeCNy2nTtRTkpZvIgXek+r/rsjHJLgC
         fTUMx3RlsAQqu/PSubvomVeCh/UqtNXI/u4JBR25pZIyxS8pVb/x4wTOmzc7i2SZFWTn
         7Yhv4xvCzPHwghL5KVB1dSaN1oEP9vFkFYVyZyT3vRa4ZKOgmiF2uJu5rYP3flByRPDV
         FlD6J7hDeSnaic2BafG5SMMeCAxzjdV5NHl8YOogLh+eDuH5fiCO65n26C4odlxmsKpq
         MGAQ==
X-Received: by 10.112.156.169 with SMTP id wf9mr16088545lbb.85.1420741210070;
        Thu, 08 Jan 2015 10:20:10 -0800 (PST)
Received: from localhost.localdomain ([95.59.128.28])
        by mx.google.com with ESMTPSA id xq3sm1303974lbb.15.2015.01.08.10.20.07
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Jan 2015 10:20:09 -0800 (PST)
X-Mailer: git-send-email 2.2.1.268.g1e6f5b2.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262205>

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 builtin/cat-file.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index f8d8129..840ace2 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -17,14 +17,13 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
 {
 	unsigned char sha1[20];
 	enum object_type type;
-	char *buf;
+	char *buf = NULL;
 	unsigned long size;
 	struct object_context obj_context;
 
 	if (get_sha1_with_context(obj_name, 0, sha1, &obj_context))
 		die("Not a valid object name %s", obj_name);
 
-	buf = NULL;
 	switch (opt) {
 	case 't':
 		type = sha1_object_info(sha1, NULL);
-- 
2.2.1.268.g1e6f5b2.dirty
