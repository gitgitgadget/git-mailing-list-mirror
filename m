From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv7 2/8] submodule-config: drop check against NULL
Date: Mon, 11 Jan 2016 11:41:55 -0800
Message-ID: <1452541321-27810-3-git-send-email-sbeller@google.com>
References: <1452541321-27810-1-git-send-email-sbeller@google.com>
Cc: jrnieder@gmail.com, Jens.Lehmann@web.de
To: sbeller@google.com, git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jan 11 20:42:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIiMD-000520-IK
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 20:42:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbcAKTmU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 14:42:20 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36736 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758791AbcAKTmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 14:42:16 -0500
Received: by mail-pf0-f177.google.com with SMTP id n128so49340915pfn.3
        for <git@vger.kernel.org>; Mon, 11 Jan 2016 11:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wPCwQGCa5swvpwRC3iAB8eQ0Y3ZPqX9cDuvNYV5Dxfw=;
        b=jOViGv43tS98fS7qhD6KvnZE5b+F/f3+zHRtFvOPZyqR2+e5RucR9HUaKEUCUmKZfx
         xN7fg1fX0O2hKlHoGhNW19mSqa4FbgLZDd3Fkwyes0hGwzE8MYwWz5RAWeUrpCwRt2lm
         w9hFGLyVvDRSA4rGg+i/0c5Q0U5DAw2loU0WWYXP3y5dZIH3IV2eA+YjD8CxkhcBRt69
         UZmaGRwM4CR4ZFD4hyCqjbES0KPmjM94KaAvDJIaT2qlcORLuJ9sJBRYnxMJY9uEiffm
         lzi61cTsQZdK8vXLB5hwfkif6N0zGg+MunfjqLpCcgU5ZRM5R39OwYExaz0LruROQxda
         QMog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wPCwQGCa5swvpwRC3iAB8eQ0Y3ZPqX9cDuvNYV5Dxfw=;
        b=invZ4avdqzGZINVOh/VQz4vr7LvaLPX5ycpkzIh4joLoakF/nSsWVvbFoihOmU1cqb
         F8IBbyQ3+ScB2TcrDkr9pbLNXQFboLTQN6MXgimgWRccgCXaOBdbFjJqvAWGvcM9lGKs
         wg/k+mGdW9OLeKUHfjxKzXi/eNAQTo7EZoss+L+wxhPOEA3LHP19xzvEDmur1+MnIwbr
         ZMU20q0CqLNbW9MKciUbXB4jeyoidGT6GuKWF5ob6H30FQQFL9xjmT+VZDOr1CBKqvnD
         67+jAhSv8Z/FHi08sIG8m0ab1ioGE4tbCkYmqkc//40GbncFgR/oLjTtFNqoYiAGEenL
         BcaQ==
X-Gm-Message-State: ALoCoQkitFt1uOxUXBKA8eIgZH3PI5MWS58q6FK1ag2mBs4Mzsu5ier1VdfINGDFyl8nFpif5YrSafwfoZ63P2flgjZsDol4/w==
X-Received: by 10.98.10.66 with SMTP id s63mr28992335pfi.119.1452541335970;
        Mon, 11 Jan 2016 11:42:15 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:8d8c:9316:e7e7:6f4f])
        by smtp.gmail.com with ESMTPSA id e82sm25084711pfb.76.2016.01.11.11.42.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 11 Jan 2016 11:42:15 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc1.7.gf4541cb.dirty
In-Reply-To: <1452541321-27810-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283704>

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
2.7.0.rc1.7.gf4541cb.dirty
