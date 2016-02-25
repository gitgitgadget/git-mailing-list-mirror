From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv18 02/11] submodule-config: drop check against NULL
Date: Thu, 25 Feb 2016 15:08:19 -0800
Message-ID: <1456441708-13512-3-git-send-email-sbeller@google.com>
References: <xmqqoab4mnoc.fsf@gitster.mtv.corp.google.com>
 <1456441708-13512-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, sunshine@sunshineco.com, jrnieder@gmail.com
To: sbeller@google.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 26 00:09:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ522-00089u-C0
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 00:09:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752329AbcBYXJG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 18:09:06 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35392 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285AbcBYXJB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 18:09:01 -0500
Received: by mail-pf0-f171.google.com with SMTP id c10so41929903pfc.2
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 15:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GhDAMJO8T6VhrAGSxj9wN/RW5qX7B5343VWv3q4zgjU=;
        b=pa/jomCxNSNAz8fPGcgRsLQGGg4uN9OD+4SJ5DoyocOFafhlGM23ZFgrhk9CzJQksT
         SqE8j9JzCum4ChTQ0LITnN+AtLGcil0mG9rq+AYdwmmnpaYbQhB7NWV+US9BTRYpJINX
         cgIY8JeuTeE+KRmuRhEh6vB9W43uwLobIsg7mOt74yWyWeqDR5pX4iAG6T117gU6Rsdz
         uAerquARnH+kS6agRFhwjQpPbnGKr5LW3qobaoz4bAtc93XYHtc0j2py8IslCJrBBajs
         xNzWixLHpRl7Ir0Ft+IuU5TuZdI0PtksTB3FPB+XQonbpukDEGBOw5Ng1P8XlvTHdIAo
         p0sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GhDAMJO8T6VhrAGSxj9wN/RW5qX7B5343VWv3q4zgjU=;
        b=gdDomhtOBAFRh8eiiISJLCEV8Q5VjrBDrYvMi/lPQcb4IvUwaMAI9GuCG6OorUohtS
         xoPvVnLrPpC0xxBEQS3zOHdXDFJ+J3jgzTshykVvlXC9FlgQLqbqRGfCDFg0F9T4ME+8
         ygPJOzhKi/KLE1VXhq5Ac2uguNOc0HARV8TWM76R36cgTFImIo/xfmTxVRIoI9hu0mdg
         RdxoaTI3NoeGzbjSzXpWFHHt5p1YJ+3DuPMreb3VpOFa96VcmbjUyqUOOH+bf4RvrrCC
         wC/iUtPpTSiiRtt0TZx2SOrrGdd04XXrexhP26oAP/1Cvh251WfsznoPAueb2WArHdIB
         ogyg==
X-Gm-Message-State: AG10YOTX8oNQmpVBLhhBVIm9Pl3x4EJwrkF5yeH8rvs03sYOqT/BYU+JZzsDptI+w3tcX1GT
X-Received: by 10.98.68.73 with SMTP id r70mr67688958pfa.136.1456441740301;
        Thu, 25 Feb 2016 15:09:00 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:a893:1c03:aadb:c3d])
        by smtp.gmail.com with ESMTPSA id dg1sm14536184pad.18.2016.02.25.15.08.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 25 Feb 2016 15:08:59 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.36.g75877e4.dirty
In-Reply-To: <1456441708-13512-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287479>

Adhere to the common coding style of Git and not check explicitly
for NULL throughout the file. There are still other occurrences in the
code base but that is usually inside of conditions with side effects.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
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
2.7.0.rc0.36.g75877e4.dirty
