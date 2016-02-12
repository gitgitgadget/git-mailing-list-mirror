From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv11 2/7] submodule-config: drop check against NULL
Date: Fri, 12 Feb 2016 15:34:35 -0800
Message-ID: <1455320080-14648-3-git-send-email-sbeller@google.com>
References: <1455320080-14648-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com,
	Jens.Lehmann@web.de
X-From: git-owner@vger.kernel.org Sat Feb 13 00:34:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUNEh-0005Qz-JP
	for gcvg-git-2@plane.gmane.org; Sat, 13 Feb 2016 00:34:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518AbcBLXet (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2016 18:34:49 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35051 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325AbcBLXer (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2016 18:34:47 -0500
Received: by mail-pa0-f43.google.com with SMTP id ho8so54086687pac.2
        for <git@vger.kernel.org>; Fri, 12 Feb 2016 15:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gg0OL6+fO3Ckq4gIAbC2f2nr/mZBK2z/h4hobytx6Q4=;
        b=h6gTZJ+KBHTR2T0LtfQh/VRSUAxjTYtmGTeLInUB8sYDbCDaXQSKdzvbLSZpQo/9Ao
         mox9/Xcc74W83aDfynDMd5O2uyKNsvz+k5JkrChreIKmZFpfonSYIbn1gBPn4SFpBEiG
         Mk+1/rWoha1sVuDzwNdbi/5fnDVDRu9DBIr1Qs2/Mi8vI9Ti1nagSQlr0T2zNCTv/Xiu
         PKnoaVvwQ2iZgfwqJZBVZCi7GxBO/2NN53I4ibClr4GomCm33fUPdiuux5Io+qPxa2y/
         ZXhLHeKrh65r6ilayYlcA1iqrOeZFimCah0RWfTHk0m/C3BxTwVKv6Q5q8uJ7ZiBv6ku
         b8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gg0OL6+fO3Ckq4gIAbC2f2nr/mZBK2z/h4hobytx6Q4=;
        b=SldBos1HaAEHumXIHiv4kbmaXlVrW0USv1om8+TlpK0I8ZNnu1CKanVpEQLt70Bwnr
         hpQb51QEaRvewThC2EifpB8oI1QMhbvdQxFBt3AdIaA3hGqkN7gmAhnzo4FCmIVezEDZ
         zfP1LQ+YKSyBh5o0xXrOlj6GyNT0nN+wwRAiAVl+Utafa8RMzP4ziHIrbmA3WZsxb96S
         ql3jippAxljOc6vDmp9SXPzUcdMH8DatQHN92IGrdlBb6rQ4ZSurPurLpK1YKJ2NjBmf
         jqefPouTFB1gh4suQIq1m00Rx8s/HzNrP9m7+kuxRht28JLUxlaPa8pD6wjMpoKyPfi3
         c8rg==
X-Gm-Message-State: AG10YOQ1R2yX0HV8P7jPakqMj1e4gCG43ZhGEPk4BM5XiO6wEQ+O9yGxaUVvbPGox/EUo+/T
X-Received: by 10.66.237.38 with SMTP id uz6mr5988925pac.136.1455320086831;
        Fri, 12 Feb 2016 15:34:46 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:f1e7:203f:9d1e:8193])
        by smtp.gmail.com with ESMTPSA id 87sm15449156pfq.93.2016.02.12.15.34.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 12 Feb 2016 15:34:45 -0800 (PST)
X-Mailer: git-send-email 2.7.1.292.g18a4ced.dirty
In-Reply-To: <1455320080-14648-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286084>

Adhere to the common coding style of Git and not check explicitly
for NULL throughout the file. There are still other occurrences in the
code base but that is usually inside of conditions with side effects.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule-config.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index 254067b..afd294b 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -295,7 +295,7 @@ static int parse_config(const char *var, const char *value, void *data)
 	if (!strcmp(item.buf, "path")) {
 		if (!value)
 			ret = config_error_nonbool(var);
-		else if (!me->overwrite && submodule->path != NULL)
+		else if (!me->overwrite && submodule->path)
 			warn_multiple_config(me->commit_sha1, submodule->name,
 					"path");
 		else {
@@ -319,7 +319,7 @@ static int parse_config(const char *var, const char *value, void *data)
 	} else if (!strcmp(item.buf, "ignore")) {
 		if (!value)
 			ret = config_error_nonbool(var);
-		else if (!me->overwrite && submodule->ignore != NULL)
+		else if (!me->overwrite && submodule->ignore)
 			warn_multiple_config(me->commit_sha1, submodule->name,
 					"ignore");
 		else if (strcmp(value, "untracked") &&
@@ -335,7 +335,7 @@ static int parse_config(const char *var, const char *value, void *data)
 	} else if (!strcmp(item.buf, "url")) {
 		if (!value) {
 			ret = config_error_nonbool(var);
-		} else if (!me->overwrite && submodule->url != NULL) {
+		} else if (!me->overwrite && submodule->url) {
 			warn_multiple_config(me->commit_sha1, submodule->name,
 					"url");
 		} else {
-- 
2.7.1.292.g18a4ced.dirty
