From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH] cat-file: remove definition of already defined variables
Date: Sun, 11 Jan 2015 00:13:23 +0600
Message-ID: <1420913603-794-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 10 19:14:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YA0Xw-00028i-2V
	for gcvg-git-2@plane.gmane.org; Sat, 10 Jan 2015 19:14:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754529AbbAJSN4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2015 13:13:56 -0500
Received: from mail-la0-f53.google.com ([209.85.215.53]:48717 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825AbbAJSNz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2015 13:13:55 -0500
Received: by mail-la0-f53.google.com with SMTP id gm9so19374778lab.12
        for <git@vger.kernel.org>; Sat, 10 Jan 2015 10:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Zw0I0tzHMNdKwFpL0l0DgT5zn5M+RXypre/SUbthvjA=;
        b=nC+pv8ZXqhAT0MF/W/Mq0z8cTlrkS70TZG1ruyQDgz/I4Oxz6aLDRP+2DBD2ejO2Q8
         1vneJno69mB3UGs7wJZfpWAQdjX/mg/2SlbrSGndcophND5vZaQezKyNsbReJcGXiIZ3
         dDRo6pLiZ443al2x/Xit7j1AVM7NTbbSU+U8mmZpTSpaTNLaBWsDGsnikAUyA8exsvUs
         Nqp4SUkjwTRdEUX/IF9sJ3AG3DXt48gzZDIEUFeI0QQpyuuVFJ6ad6pxGST+J8bcMpdY
         T/Z7+keOqEYfseuC3KP/5BuEbQFcfg0KfWb2htxLdMtaEBRkvUv1VZ1tbqovSYXyFzfx
         rDlw==
X-Received: by 10.152.6.67 with SMTP id y3mr28146071lay.90.1420913633823;
        Sat, 10 Jan 2015 10:13:53 -0800 (PST)
Received: from localhost.localdomain ([95.59.102.98])
        by mx.google.com with ESMTPSA id ba19sm2692283lab.23.2015.01.10.10.13.51
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 10 Jan 2015 10:13:53 -0800 (PST)
X-Mailer: git-send-email 2.2.1.532.g168b885.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262267>

'enum object_type type' and 'unsigned long size' are already defined
at the top of cat_one_file routine

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 builtin/cat-file.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 750b5a2..31b133b 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -75,8 +75,6 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
 		if (type_from_string(exp_type) == OBJ_BLOB) {
 			unsigned char blob_sha1[20];
 			if (sha1_object_info(sha1, NULL) == OBJ_TAG) {
-				enum object_type type;
-				unsigned long size;
 				char *buffer = read_sha1_file(sha1, &type, &size);
 				const char *target;
 				if (!skip_prefix(buffer, "object ", &target) ||
-- 
2.2.1.532.g168b885.dirty
