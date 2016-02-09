From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv9 2/6] submodule-config: drop check against NULL
Date: Tue,  9 Feb 2016 12:54:30 -0800
Message-ID: <1455051274-15256-3-git-send-email-sbeller@google.com>
References: <1455051274-15256-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, jrnieder@gmail.com, git@vger.kernel.org,
	Jens.Lehmann@web.de
X-From: git-owner@vger.kernel.org Tue Feb 09 21:54:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTFJJ-0001kw-5o
	for gcvg-git-2@plane.gmane.org; Tue, 09 Feb 2016 21:54:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbcBIUyt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2016 15:54:49 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34520 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752997AbcBIUyr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2016 15:54:47 -0500
Received: by mail-pf0-f177.google.com with SMTP id x65so13807733pfb.1
        for <git@vger.kernel.org>; Tue, 09 Feb 2016 12:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F2EJ1NUCCLY6Oc6Rwjlspw1RSgD8VGuGpnyqYEB7bWw=;
        b=oo8Ak3AsewOtoK87403DE87GyZ5ufUkGPCdLCnWMgS7pXgMc80AFA79B7DwrRB8RWL
         pu7V9G0PicInhCa4nleKJStMeNliWOt6DX1QvaB96M8zx33Rms0nOhIflnFcvcojCpQr
         MlF2AqGARCciSDLiiYrkxPrKTRWseQQYkc4maF8QjdcG+XIxgkoQ3sDfQFmI9ZMJb+kx
         MQiCpGk5Fcif65tll62x8wpKT0ixpt4ftcJDsBXlI86JDtoY3xb6EppQ+4K7o3B3SAmU
         pBp1kmF08J17kzkiTk97qKtJl6DqYv7LX3vsMGgBzhoJzPzqwGuTe15EsLABPsaCoBLy
         L1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F2EJ1NUCCLY6Oc6Rwjlspw1RSgD8VGuGpnyqYEB7bWw=;
        b=mRKmkGlVG9ank0Ctg2kdQOqVLcbdLlg9f3GUoOTpFfTBdvdVHsvtUd2VY7bG7cAswq
         7jj0j6tqzVNcjZF8tnuqV/5muSgYS17BCjJu8aG/z8Ezvla+uuL24ctZ7Y3/5ZKy1O/v
         s056XCAbQ0fRRDQhf/UIAaWJxnIrulM4qnuieSWfvrloCOOzg6u8oFntsCY/bLoXrUBM
         ceiiQi5tNF461QYMwo0BPH5ENyyWU7NYmeToLf0Eipv7gmKxvrIPM6frEKzykx9UzTZB
         Gk7ZilykJhw1LVQBWLoHhLHFTzMWggqsjQcwNq2Pnhv2eyt6zlkCuqO4KDgrMGATCSxh
         3U3g==
X-Gm-Message-State: AG10YOQRBidbdpDovJNvHapZIAomDDeRGBvtZ/qkz4L2D4/1FAUlcsrOsCpUBmjQnuc0thou
X-Received: by 10.98.17.129 with SMTP id 1mr53659170pfr.30.1455051287096;
        Tue, 09 Feb 2016 12:54:47 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:9085:4567:f3b3:63e9])
        by smtp.gmail.com with ESMTPSA id o90sm52639533pfi.17.2016.02.09.12.54.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 09 Feb 2016 12:54:46 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.35.gb0f7869.dirty
In-Reply-To: <1455051274-15256-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285859>

Adhere to the common coding style of Git and not check explicitly
for NULL throughout the file. There are still other occurrences in the
code base but that is usually inside of conditions with side effects.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule-config.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index a1af5de..d6c8d9c 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -266,7 +266,7 @@ static int parse_config(const char *var, const char *value, void *data)
 	if (!strcmp(item.buf, "path")) {
 		if (!value)
 			ret = config_error_nonbool(var);
-		else if (!me->overwrite && submodule->path != NULL)
+		else if (!me->overwrite && submodule->path)
 			warn_multiple_config(me->commit_sha1, submodule->name,
 					"path");
 		else {
@@ -290,7 +290,7 @@ static int parse_config(const char *var, const char *value, void *data)
 	} else if (!strcmp(item.buf, "ignore")) {
 		if (!value)
 			ret = config_error_nonbool(var);
-		else if (!me->overwrite && submodule->ignore != NULL)
+		else if (!me->overwrite && submodule->ignore)
 			warn_multiple_config(me->commit_sha1, submodule->name,
 					"ignore");
 		else if (strcmp(value, "untracked") &&
@@ -306,7 +306,7 @@ static int parse_config(const char *var, const char *value, void *data)
 	} else if (!strcmp(item.buf, "url")) {
 		if (!value) {
 			ret = config_error_nonbool(var);
-		} else if (!me->overwrite && submodule->url != NULL) {
+		} else if (!me->overwrite && submodule->url) {
 			warn_multiple_config(me->commit_sha1, submodule->name,
 					"url");
 		} else {
-- 
2.7.0.rc0.35.gb0f7869.dirty
