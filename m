From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv10 2/7] submodule-config: drop check against NULL
Date: Thu, 11 Feb 2016 18:03:07 -0800
Message-ID: <1455242592-19352-3-git-send-email-sbeller@google.com>
References: <1455242592-19352-1-git-send-email-sbeller@google.com>
Cc: jrnieder@gmail.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 12 03:03:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aU35L-00017H-5s
	for gcvg-git-2@plane.gmane.org; Fri, 12 Feb 2016 03:03:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900AbcBLCDr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 21:03:47 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33252 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309AbcBLCDY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 21:03:24 -0500
Received: by mail-pa0-f41.google.com with SMTP id fl4so26494474pad.0
        for <git@vger.kernel.org>; Thu, 11 Feb 2016 18:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gg0OL6+fO3Ckq4gIAbC2f2nr/mZBK2z/h4hobytx6Q4=;
        b=epksXWvlzVA6ib4rR9EbXwAQgzGWdQ4pkPrVtXUX3usyR/XppnkImKepOYpruh9RuD
         R5zbHHUjoq+2xwBtq1jZHla5QOJJeSNlIRjo/txdUzbABtsLFhO0YR8EozrLwWXjfKHT
         DlDkKL5paqyNcwgAV4wTXylCiaUSSc5VHOOFS13peax9aPTLQfY2ST87eGD1NHJyBE8j
         G6Ahdleq8XRwiB8GBLn1ZwpDZnK3Qra1IcydXvadxRHIQuenMnVl/HpSzeCL2G3/EAZn
         394onyNv2FI1m+AQQlUag9A8JcQkgqWiMFXcamwLJMSpQRTsXB4fpEI4EiEr+1OQcnpe
         RRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gg0OL6+fO3Ckq4gIAbC2f2nr/mZBK2z/h4hobytx6Q4=;
        b=MwG2kTd5LUdlVv1DcLBXjyn/i9ZKO7mY7W06Aq91iGo/TPBKMBMEtPqykB/tbsXAbt
         Ib5QQOJRdkc7nkz3OfxFVZSKW33EAVebqIh0yjBtpSNq2llCzbdvCokI/TCDVZ1x+hjH
         S8/eI+H7DtsGasLA5IOSDGNZ5FZlDyd98YWQDll3Xu8EC8OnOKP17bbOUkYMz8wV0vIP
         iezcCmKZ8MzKv+3SegGR2ofFsBZMyovX5rY2iJEqkO+AwZKjWvGWBa5jedp9gOoxKxNG
         C1n5ErTZGjqSWEzKz4kBkL4RejopFI0Q3YmnL3A0hOOU0t66mXT1hcZBBlJy3+XvYBkZ
         Fktg==
X-Gm-Message-State: AG10YOSwM8KCmo54itv3+efVNhj/z6DeS9YQSzVL/jrB4kJVo0PkRc1j8AmgyYCunbbvwg8p
X-Received: by 10.67.1.164 with SMTP id bh4mr71629674pad.118.1455242604061;
        Thu, 11 Feb 2016 18:03:24 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:994e:7471:3f:c285])
        by smtp.gmail.com with ESMTPSA id w89sm15080032pfi.13.2016.02.11.18.03.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 Feb 2016 18:03:23 -0800 (PST)
X-Mailer: git-send-email 2.7.1.292.g18a4ced.dirty
In-Reply-To: <1455242592-19352-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286035>

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
