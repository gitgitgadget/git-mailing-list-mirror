From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 05/11] submodule-config: drop check against NULL
Date: Tue,  3 Nov 2015 16:37:08 -0800
Message-ID: <1446597434-1740-6-git-send-email-sbeller@google.com>
References: <1446597434-1740-1-git-send-email-sbeller@google.com>
Cc: ramsay@ramsayjones.plus.com, jacob.keller@gmail.com, peff@peff.net,
	gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com, j6t@kdbg.org,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 04 01:37:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ztm5H-00030L-PA
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 01:37:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965153AbbKDAhr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 19:37:47 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33431 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755984AbbKDAhY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 19:37:24 -0500
Received: by pabfh17 with SMTP id fh17so33771679pab.0
        for <git@vger.kernel.org>; Tue, 03 Nov 2015 16:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5wrLey9R5CEZxtmR0dOVHWEYcK6/H8vmGq3ChaecYDM=;
        b=UjXLALqusNWah+7LCM7/pYP2/uVNR/UYHf4G+p9XeMFSP2s5oP30o0bbxCFBgko2er
         1z5yONY6TgKv8IG9ffM6DO6XHdxQjvMD5+yfaPrRqwN3ynru9TSC2Lyd/NDeTDAlPc9U
         xarWegahC2n3d2vKz4kFT8hqSI8EVuJ72dRXXaQpqM/FRlAh8ELzLQMgCgF7e3IhnfDC
         3q3oMutRBjO0sv0IZG4FekelmoIG6oeb9N+wDCpvLF5sDNWk7ehM1FTJS2i5xcLsZnmi
         dek/fZ/icg5/IjqMBWky+e4i5x4uCtr+BJXejhw07QOEtSu7WWYiDdAy5aNo4dQhzQTU
         TqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5wrLey9R5CEZxtmR0dOVHWEYcK6/H8vmGq3ChaecYDM=;
        b=Lqf9FYzNo2To/aJhdXFu90s5SWFqqg9XjqxILd1W51kO8CtoZaIAX8tRMgfZK6eJkq
         iYRJLBCbtG8Mu6cX3pCB0/WeOgAtrvoM8JbNmYpnf7Ob12O6oudj4nmWwEhqHU4dvW6j
         vIjOtDoUxn6E9pSDGCuhSuSnoD1Uit/9C7zaVH6tWINRh4mEO0zcKWBISIiilKfhOb7i
         jSKdEMRvdCQ241wIbWZYdoE0xUomC57CHa7a0FUXJFQPh1F5gLaK1zrlnLjp3L6FYDGf
         DHPvUmMJpSWfme9AgeIaOIKJXF4uTsKRUZZFmXGXke3hR7cOY/oBnLIeYE3ke693oaB0
         MR3w==
X-Gm-Message-State: ALoCoQkF51aydW6gkuCibkkqjR8NSwHIqc6YVZQOTqHxnvaasn8G6HAVMFTmeWhTisUBx/xkvWvP
X-Received: by 10.67.14.161 with SMTP id fh1mr37636547pad.28.1446597444245;
        Tue, 03 Nov 2015 16:37:24 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:799e:c67e:2702:f55])
        by smtp.gmail.com with ESMTPSA id qv5sm31626343pbc.71.2015.11.03.16.37.23
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 03 Nov 2015 16:37:23 -0800 (PST)
X-Mailer: git-send-email 2.6.1.247.ge8f2a41.dirty
In-Reply-To: <1446597434-1740-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280842>

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
2.6.1.247.ge8f2a41.dirty
