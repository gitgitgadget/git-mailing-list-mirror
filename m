From: Andrei Dinu <mandrei.dinu@gmail.com>
Subject: [PATCH v4 1/2] diff-no-index.c: rename read_directory()
Date: Wed, 19 Mar 2014 17:38:35 +0200
Message-ID: <1395243516-5753-1-git-send-email-mandrei.dinu@gmail.com>
Cc: Andrei Dinu <mandrei.dinu@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 19 16:39:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQIaq-0007k0-By
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 16:39:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965509AbaCSPji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 11:39:38 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:52705 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965431AbaCSPjd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 11:39:33 -0400
Received: by mail-ee0-f46.google.com with SMTP id t10so6646640eei.5
        for <git@vger.kernel.org>; Wed, 19 Mar 2014 08:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=qgvV0RxVNb4QlaM1trbB982rYQWQo6l+phVqrNtv4fk=;
        b=lxHy20WW/7H/nTqv9NN5O3nGwM7iUIrlxYulikFL+ibRjGlpzpDItUhy2+e+lvVFnD
         FHHvA0pgD9xBe8zcxLcSeSgFS8I8nUW1GWcjHt5lCqj9ecSNLxVjx1n+tPF08A5TZvfY
         smDLYsIrAuh2oXadNOXzINdXuco46zmGNSa3UPkLh2ObzdwN0tqA7fsk8B6fDU/hwUGk
         f3iYzrA2ryFfgK5QV7+iqwIXb1MqYBtKMNylFraZyL7bplUTfsVVIM6BMq+k6LIik3fi
         DznJ8TW7gCONU3rzszzlEureSMpLH2tVKdofWgeHdSmXD0b6QwkKojqUARb0JG4qAsU3
         A4PA==
X-Received: by 10.15.31.137 with SMTP id y9mr36556941eeu.12.1395243572334;
        Wed, 19 Mar 2014 08:39:32 -0700 (PDT)
Received: from localhost.localdomain (p5.eregie.pub.ro. [141.85.0.105])
        by mx.google.com with ESMTPSA id j41sm55401395eeg.10.2014.03.19.08.39.30
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 19 Mar 2014 08:39:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244454>


Signed-off-by: Andrei Dinu <mandrei.dinu@gmail.com>

---
 I plan on applying to GSoc 2014

 diff-no-index.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 8e10bff..5e4a76c 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -16,7 +16,7 @@
 #include "builtin.h"
 #include "string-list.h"
 
-static int read_directory(const char *path, struct string_list *list)
+static int read_directory_path(const char *path, struct string_list *list)
 {
 	DIR *dir;
 	struct dirent *e;
@@ -107,9 +107,9 @@ static int queue_diff(struct diff_options *o,
 		int i1, i2, ret = 0;
 		size_t len1 = 0, len2 = 0;
 
-		if (name1 && read_directory(name1, &p1))
+		if (name1 && read_directory_path(name1, &p1))
 			return -1;
-		if (name2 && read_directory(name2, &p2)) {
+		if (name2 && read_directory_path(name2, &p2)) {
 			string_list_clear(&p1, 0);
 			return -1;
 		}
-- 
1.7.9.5
