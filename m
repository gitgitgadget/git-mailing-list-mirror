From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv17 02/11] submodule-config: drop check against NULL
Date: Wed, 24 Feb 2016 19:06:49 -0800
Message-ID: <1456369618-18127-3-git-send-email-sbeller@google.com>
References: <1456369618-18127-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, sunshine@sunshineco.com, jrnieder@gmail.com
To: sbeller@google.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Feb 25 04:07:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYmH0-0000mq-85
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 04:07:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759891AbcBYDHL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 22:07:11 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34937 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759882AbcBYDHH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 22:07:07 -0500
Received: by mail-pa0-f51.google.com with SMTP id ho8so24505955pac.2
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 19:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vYgfvTtr2kKuIQ7Y+Ojamgr6zShHyJ7du6aJCRAaxJY=;
        b=CN2xFzpgQ2lDdeA1g59SY2igB2VJu50UzaWKxSwTysTMEjwkwO0VgBIf0iE7uSgvul
         WDWdcHxsaZGXQeo6PIRiEH2TYDa0UMj7DCahFCIILArRPIJEAuIy6Ct4gtSiLcZXDZgP
         toEYihgdcYdiohGzSZh0r31TzTW4ygQugAbsZzkcpZR6XfkxrJbWxaTHfcHPza6rX4dm
         0Y65zeH/Lvn7ViOItUL/snOWWgVHlugY525tqVmH8aoCi51zzfiZkSSo2H83vGoFFFIr
         vE0s6bUG5duTFIe4xpvbOo8dLCrcYCNb/vFjiECprdl2AfyNBWOJ4xgs4B6pkgWvBCPm
         5ocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vYgfvTtr2kKuIQ7Y+Ojamgr6zShHyJ7du6aJCRAaxJY=;
        b=NXGUKKwR1a0rkt5xJMb4tuYTf2vxp4WDXPXfVin7rHc80ywJQUfdETu7fopfTJPlBV
         JkpBXkmYdP/91u5VJ++sXWR4nWfoOxvxfpjFI/jncCBH9jHXIRraVE9WZLQnnQMBfNk3
         fwm8S3prlAikTgGwJ74ysajm+iAJWY6Eb7NdDeGwX5bPLPDC8vzcLaEQzzIxpalmgq4k
         +NaSW9FsqvURDFS0kMr5wND0B+OGHDylRO4N44kirP5LnNlf9krShG1gbMviSe0b6XBP
         4qFk6A/4J1Qbl/qNS8rUIBlRmtBtyphyTNwvmAdy0W6uOpkAmQJKDe0cmZjlaicSrVOF
         I3bg==
X-Gm-Message-State: AG10YOQmUZCnGhnKhEzGTA50dCiaNghw3SSCbkJ1uO6iOg3cgDZv9xQjCFpsysI3EDpFgYv3
X-Received: by 10.66.144.4 with SMTP id si4mr59819321pab.0.1456369626443;
        Wed, 24 Feb 2016 19:07:06 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:74de:af7a:dfba:15a4])
        by smtp.gmail.com with ESMTPSA id m16sm7946558pfi.75.2016.02.24.19.07.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 Feb 2016 19:07:05 -0800 (PST)
X-Mailer: git-send-email 2.7.2.373.g1655498.dirty
In-Reply-To: <1456369618-18127-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287316>

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
2.7.2.373.g1655498.dirty
