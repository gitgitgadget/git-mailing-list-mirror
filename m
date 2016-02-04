From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv8 2/9] submodule-config: drop check against NULL
Date: Thu,  4 Feb 2016 14:09:29 -0800
Message-ID: <1454623776-3347-3-git-send-email-sbeller@google.com>
References: <1454623776-3347-1-git-send-email-sbeller@google.com>
Cc: jrnieder@gmail.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Feb 04 23:10:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRS6f-0007xR-Rm
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 23:10:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966224AbcBDWKX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 17:10:23 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36418 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964901AbcBDWJr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 17:09:47 -0500
Received: by mail-pa0-f53.google.com with SMTP id yy13so22212796pab.3
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 14:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+TbZgahIindxtp95aZzrOYyNqbF74N/6mPq41dIPAgg=;
        b=ncRAoaITPQr9UK+F+Kxv0wpoNTgny9oOEUtcuxweu4+3ZzCSz86HaQI6OHFaYKGaHW
         LLabGQJ096pKo1bnNUaXcC2Ql1EtLVv2MQm9f3WkQX8xYoU4tHmp3G5xd/6YEVv/h0AV
         2DbKBOKGCn7VXNgGYz1o+I8nvVTao1HAE6SauqPzuKHfK4uA5uvTvqbqfbSXmqLuC761
         RQGk1ZcU+1WiOxRsgGxD+zqOM1/DS1asT7RFsu1ESG691gm2JMPOEr2fVuKwhDKrzTKO
         fPCqMXq3lutR7ReDJqKmXw6LNkJHh/plZLcBOlw5KBKzmbqDSxJGWoJPrbkLnOrTRuOm
         xjFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+TbZgahIindxtp95aZzrOYyNqbF74N/6mPq41dIPAgg=;
        b=aVQ8r1PBd8aQnL+Wej16YlBgurxJCJ6wemYsFL77a7Rz06oFbDynXt074e2/nrgq0S
         qLscBTlE0pb7jrEqjmYCmiYqMtkOAVW4WWBLeg+Ku3XBI4v20wzZ3AENfJD+Pod5Fm0Z
         qxs0zBtQ4WzXqyBnADKMslYZsicVepvKF2FrBpwbQGN6jOHVkLdSBLXt5rsAMMplunsH
         dKLghq0dJZR1sPm7UOOy4UbZBrgBL3AeeplAws4JXYuuqPd9sqkUB7s1NuX5PSarjQRJ
         I7s6dFd0xsluPSgJ0MCOliTz4mwOfp2rMa3xtWqK+Wc3+Rps1TtkMOo4XAy82pgD0sZ1
         swog==
X-Gm-Message-State: AG10YORZXa3Tj8EKl9XC2YB21sUkQ/pGyaPmlXFBhy9q8i5hw9z7+KHqH7Se+cDrAjWxU0YS
X-Received: by 10.66.252.198 with SMTP id zu6mr14655539pac.107.1454623786707;
        Thu, 04 Feb 2016 14:09:46 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:5194:ebf5:4051:c1fd])
        by smtp.gmail.com with ESMTPSA id l14sm19347951pfb.73.2016.02.04.14.09.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 04 Feb 2016 14:09:45 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.41.gd102984.dirty
In-Reply-To: <1454623776-3347-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285507>

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
2.7.0.rc0.41.gd102984.dirty
