From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv21 02/10] submodule-config: drop check against NULL
Date: Mon, 29 Feb 2016 18:07:12 -0800
Message-ID: <1456798040-30129-3-git-send-email-sbeller@google.com>
References: <1456798040-30129-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jrnieder@gmail.com, pclouds@gmail.com,
	Jens.Lehmann@web.de, peff@peff.net, sunshine@sunshineco.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Mar 01 03:07:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaZiv-0002xr-SF
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 03:07:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610AbcCACHb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 21:07:31 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33711 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582AbcCACH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 21:07:29 -0500
Received: by mail-pa0-f54.google.com with SMTP id fl4so102374468pad.0
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 18:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=byxO0eXLYi6WnOkIXIrYJ5dBHSoNUh8KXyN7m4poAcE=;
        b=J2eY2nEIX2ROZKLghUCLz0WZ6iY/KL/Ixr+a44QiCr1JoUYqRjt3OX56SPJxY1in6d
         q6t/OX6vooyRu9LDYGsZtMFDNemFhCGKEitV7lGQ3k8hXC3CIC07rb20ADTdPGnpUDdA
         1Mdm/oYIt29q0prbtgQTEYTycWDzJLC9X4xQ89r5uzXI+Vp15sP8eGmUGsZoidK8xUNb
         hXy1q/QH6EXU7B1E4LoCHdICKWA/ha49fVC05OivjhrvylrLYxaf6/lvNLO9/JWRW+Q2
         RA5+GS9yiPOtpODJNTGx9sAr5LZv87DCQoYXDVPTHRohmO0dCwAXbwDo9Mfz/A4csFtc
         46/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=byxO0eXLYi6WnOkIXIrYJ5dBHSoNUh8KXyN7m4poAcE=;
        b=Ww4TkIvH9f06TuGyF7IU2KACSTfiP8+gX6KghhDFgRCzXVbrsIHTZ57ZneoiCin0sC
         v6/JWtb0R0/B2p4A1+rs9GDZp8zHlKRek8/nHh2cjmzLxdOIUsAmfSLId4wU/IT+V/Ae
         pyfZT8VkpETN5AmtFOKPEPXh4zncqoUGFUWYngsXmRXGX//r1tXLvZ19dL0Xfg4iAZXa
         F+lof8oNtEpO6I2idda9uL7yA0lsmqDUMssIuBfgk2RjC8Th5f4I8jHC7UHwtgFCivmg
         gtVCZmoXE+q1bkJfChpqoDrlJVm5nKI/2vOYeI9B9y3mP/n4pb+HySZev09AJhI7NZGy
         omQQ==
X-Gm-Message-State: AD7BkJJki4ieDZUr1VIY1kOjx6Eshg8yfxS+auzeg3JBOqsVp+Uuqane+Cbyza89DMfkdORE
X-Received: by 10.66.65.109 with SMTP id w13mr26309138pas.142.1456798048365;
        Mon, 29 Feb 2016 18:07:28 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:e195:dbe1:d842:476])
        by smtp.gmail.com with ESMTPSA id cq4sm40946554pad.28.2016.02.29.18.07.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 29 Feb 2016 18:07:27 -0800 (PST)
X-Mailer: git-send-email 2.8.0.rc0.1.g68b4e3f
In-Reply-To: <1456798040-30129-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287986>

Adhere to the common coding style of Git and not check explicitly
for NULL throughout the file. There are still other occurrences in the
code base but that is usually inside of conditions with side effects.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
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
2.8.0.rc0.1.g68b4e3f
