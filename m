From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv13 2/7] submodule-config: drop check against NULL
Date: Thu, 18 Feb 2016 15:33:13 -0800
Message-ID: <1455838398-12379-3-git-send-email-sbeller@google.com>
References: <1455838398-12379-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 19 00:33:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWY4x-00049V-NK
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 00:33:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1948686AbcBRXd2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 18:33:28 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35169 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1948679AbcBRXdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 18:33:25 -0500
Received: by mail-pa0-f49.google.com with SMTP id ho8so40121369pac.2
        for <git@vger.kernel.org>; Thu, 18 Feb 2016 15:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/Is2jjoss5R9/rMCxR2jYQ9+5IyUB72YrlLorIyCVjk=;
        b=nczd9fsy1Iya9crUTey3tyaj1UqQhhLmpLK+q+mWexAGRH++HdA1PA+TlfuNEEZ9hl
         1bEgVfX3xZ+vlw3QopcXVSyPfHijHrtEipPDJWpASzn5N4i0BbC7ZnIEqqn9RRfNx2bT
         GcHeG1usBf0XCWHwZSaiflj/DChuE62/6dpXp4Ev8EDkRGWz4b3v5jrT3+D2tf4bxOav
         F6HHvS5CBYfix1ryo1l2FwUi1psCOVuua+Lx2hCeArvO44DrKn0MZJBygi0tCOv4fQsG
         tkKLohe2I3AHQSmlgwwJnA1+OqNjFdqfZMyhK0mS6TLY24gsCOg4U3vYJSYOKA4kavxJ
         b7oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/Is2jjoss5R9/rMCxR2jYQ9+5IyUB72YrlLorIyCVjk=;
        b=FwaW7uH8ekyUOu/MRrSMK8qba9fMf6VpZo3i978MEGQRhEnS7FGYmVAoYY3zfgV7Op
         pXwCWwRAoCRyoK9LuZK/jjQn5dXM1xscTUIZIpFhlj9xweG11oL8CraVuJ2IbI1kORCn
         jZpaUykG7NGU9G8Z1NMrSnzutcd4xbHzmrWMkFxi6K4mkJj2ORPvpv4Fe5WlmfVjGFNG
         EcGOa1ONSCaX+lsrCKcKnAiJoPJr1OD+OOP26WTXyQ1WJBIft74AOGnNco1gsSf1WuMb
         Xq+oJGtEMsN0jqTlKH5E6xhhuVH1WNIZ3CBm95kV6LmNy49ComXph5L/3Tq/i91oCZtb
         su7Q==
X-Gm-Message-State: AG10YOTtOeArA4YV7NN7Cny6ohexNZhPqkyk75TCIEnHTu5jE/AY0TGdk9JUm9ju3diGlgee
X-Received: by 10.66.246.165 with SMTP id xx5mr14001762pac.87.1455838404774;
        Thu, 18 Feb 2016 15:33:24 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:d444:f36c:1851:bb54])
        by smtp.gmail.com with ESMTPSA id tn5sm12759837pac.32.2016.02.18.15.33.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 18 Feb 2016 15:33:24 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.34.g65aed89
In-Reply-To: <1455838398-12379-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286648>

Adhere to the common coding style of Git and not check explicitly
for NULL throughout the file. There are still other occurrences in the
code base but that is usually inside of conditions with side effects.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 submodule-config.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index a5cd2ee..9fa2269 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -267,7 +267,7 @@ static int parse_config(const char *var, const char *value, void *data)
 	if (!strcmp(item.buf, "path")) {
 		if (!value)
 			ret = config_error_nonbool(var);
-		else if (!me->overwrite && submodule->path != NULL)
+		else if (!me->overwrite && submodule->path)
 			warn_multiple_config(me->commit_sha1, submodule->name,
 					"path");
 		else {
@@ -291,7 +291,7 @@ static int parse_config(const char *var, const char *value, void *data)
 	} else if (!strcmp(item.buf, "ignore")) {
 		if (!value)
 			ret = config_error_nonbool(var);
-		else if (!me->overwrite && submodule->ignore != NULL)
+		else if (!me->overwrite && submodule->ignore)
 			warn_multiple_config(me->commit_sha1, submodule->name,
 					"ignore");
 		else if (strcmp(value, "untracked") &&
@@ -307,7 +307,7 @@ static int parse_config(const char *var, const char *value, void *data)
 	} else if (!strcmp(item.buf, "url")) {
 		if (!value) {
 			ret = config_error_nonbool(var);
-		} else if (!me->overwrite && submodule->url != NULL) {
+		} else if (!me->overwrite && submodule->url) {
 			warn_multiple_config(me->commit_sha1, submodule->name,
 					"url");
 		} else {
-- 
2.7.0.rc0.34.g65aed89
