From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv5 3/9] submodule-config: drop check against NULL
Date: Tue, 24 Nov 2015 17:14:50 -0800
Message-ID: <1448414096-22021-4-git-send-email-sbeller@google.com>
References: <1448414096-22021-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 25 02:15:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1OgQ-0001bX-59
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 02:15:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbbKYBPk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2015 20:15:40 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35245 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753852AbbKYBPG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2015 20:15:06 -0500
Received: by pacej9 with SMTP id ej9so39160256pac.2
        for <git@vger.kernel.org>; Tue, 24 Nov 2015 17:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uPJxWSiTEH/IJ6xeAxJiVefU00abL/u8D4mA4B2xANs=;
        b=ZV5p+AgA3fjLRV9uM9KZWQCSA6/inH/NmRvecWrL8Z6kCxGwNXW6bjXoPzEq1ogyKC
         BnaUZp9eE8Z2bUhGdOuSEQ2UyeiEewgdHHv03qrz4O7ITynHgQwcGBYpQ1sbiiyCDQOm
         jchuSM+VVdZ2ozQZJN+KgW3dwWRKvPX9FjEn7HAmBytnASOrUMzRex6IU9yLHS3mt7AF
         QXt956TvoIFDaTMwE/YwOAGVoM7pNMo4t3pqMl8fsiFbB6aKwIbwrLopD23UhMTLZHuJ
         fP9TUxBlGwUuwEZgE1qDGJo56qVMyAfbqOhMxnHffIs8bn+wnYOEfPuQodpt740jCpG4
         FpWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uPJxWSiTEH/IJ6xeAxJiVefU00abL/u8D4mA4B2xANs=;
        b=RpUBwQsQaVjCQwdDb3Cgt/Ew6wN7Yu161oD6mS+75x21Ptzb+q1/n5JAgTb/+RUTlB
         xJKmO6c3ro7mhEVUQGBYZQQrvqDNf+VAtFxqZSDQOyo7NTA7N5PFG5qwSwLxgHGw+sQ+
         PXrFUsT5WUD7AroApb2+m3f7fJYFbBuTGQ9WMFalrd9+L5cNOz5m7rEhFJEjCLcY8lz7
         fHGGtQ9INLYHAwZaSHuhBnfto17ryTuLyJNo8IEmx4j4md1/jEnqpAP8QtIL0gcyW3jE
         eKSdOABrZqWdpU/fVUZ35dTXaDAEmkQjVnzWPkanUHPiLXS4SnGne7dS/jtwf6NtC5Lq
         CW/w==
X-Gm-Message-State: ALoCoQmUfkuh0DDQaAVn70xdZ28zUE1UtBXU2irQKU6SiuuO36JXZ5ZzKuGKQsPAMPeMV1LSrnW6
X-Received: by 10.98.68.8 with SMTP id r8mr27180470pfa.159.1448414105833;
        Tue, 24 Nov 2015 17:15:05 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:5407:71cc:c14:4343])
        by smtp.gmail.com with ESMTPSA id f67sm12655767pfd.9.2015.11.24.17.15.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 24 Nov 2015 17:15:05 -0800 (PST)
X-Mailer: git-send-email 2.6.1.261.g0d9c4c1
In-Reply-To: <1448414096-22021-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281667>

Adhere to the common coding style of Git and not check explicitly
for NULL throughout the file. There are still other occurrences in the
code base but that is usually inside of conditions with side effects.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule-config.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index 4239b0e..6d01941 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -265,7 +265,7 @@ static int parse_config(const char *var, const char *value, void *data)
 	if (!strcmp(item.buf, "path")) {
 		if (!value)
 			ret = config_error_nonbool(var);
-		else if (!me->overwrite && submodule->path != NULL)
+		else if (!me->overwrite && submodule->path)
 			warn_multiple_config(me->commit_sha1, submodule->name,
 					"path");
 		else {
@@ -289,7 +289,7 @@ static int parse_config(const char *var, const char *value, void *data)
 	} else if (!strcmp(item.buf, "ignore")) {
 		if (!value)
 			ret = config_error_nonbool(var);
-		else if (!me->overwrite && submodule->ignore != NULL)
+		else if (!me->overwrite && submodule->ignore)
 			warn_multiple_config(me->commit_sha1, submodule->name,
 					"ignore");
 		else if (strcmp(value, "untracked") &&
@@ -305,7 +305,7 @@ static int parse_config(const char *var, const char *value, void *data)
 	} else if (!strcmp(item.buf, "url")) {
 		if (!value) {
 			ret = config_error_nonbool(var);
-		} else if (!me->overwrite && submodule->url != NULL) {
+		} else if (!me->overwrite && submodule->url) {
 			warn_multiple_config(me->commit_sha1, submodule->name,
 					"url");
 		} else {
@@ -315,7 +315,7 @@ static int parse_config(const char *var, const char *value, void *data)
 	} else if (!strcmp(item.buf, "update")) {
 		if (!value)
 			ret = config_error_nonbool(var);
-		else if (!me->overwrite && submodule->update != NULL)
+		else if (!me->overwrite && submodule->update)
 			warn_multiple_config(me->commit_sha1, submodule->name,
 					     "update");
 		else {
-- 
2.6.1.261.g0d9c4c1
