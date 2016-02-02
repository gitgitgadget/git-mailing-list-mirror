From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/8] submodule-config: drop check against NULL
Date: Tue,  2 Feb 2016 09:51:31 -0800
Message-ID: <1454435497-26429-3-git-send-email-sbeller@google.com>
References: <1454435497-26429-1-git-send-email-sbeller@google.com>
Cc: Jens.Lehmann@web.de, Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Tue Feb 02 18:52:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQf7k-0002UM-Ny
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 18:52:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756550AbcBBRvw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 12:51:52 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:32926 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756304AbcBBRvs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 12:51:48 -0500
Received: by mail-pf0-f171.google.com with SMTP id w123so16151548pfb.0
        for <git@vger.kernel.org>; Tue, 02 Feb 2016 09:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pTWspibdrn2UtKJuG4+cy6bcNdeqXp4PcqIlaNf1UjA=;
        b=Xt3Ol56qQaTXLGZbY817fOpG1i9Ny57wGudtYglRCb5MWc+FdYvwvSn6vMgHGogiGk
         8NE7yCvdcv7dYsl/9UkIcG78cRO2xohvdhEDw7AeuOnE9vhPkqcHtQYuz2Id8f8sD5+C
         fSTX9EwB/jGc99vSe7qt525o+gj390OcfCLypvmZ3PKqZq2jjirKpXjfYobzStK0Ohcq
         mheg9y/+youCPydb8NoGHVDCKNVol8BjSA4CcmRTRVFSZGk09AzIJswUBjv2wBfwl73y
         NvVlPy3FcHy43PNrhFbDLZKqxkunYXnGD8Zt1vAWYsWFvzQutuzSwMcV6yVtMmknSXqg
         iOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pTWspibdrn2UtKJuG4+cy6bcNdeqXp4PcqIlaNf1UjA=;
        b=I/0NmnzXKN/CP+wKqSf/cvMu9zHkOBP2lDLqGec8ZVyncoJoKqo8RcPczTpEPfY2vc
         MvmNMcFd3rj5zRgFUnR5loGOKzl1B30NZas+zSrbXLq2NVO6Au4pLb/pnuPXqx3jHthB
         Js5QiAxFhLCp26GyEs/UcOlFndacwV7JH2WjKbdGgYVfTMURxFlgq3LHxklHpUuVj/5Q
         zgaAKucYVHzyFwAOtR9QX8GX8/zCtahW44XlBI4BjfAe+HoJPk6UbQUVrfpAJ0zQsQz3
         xUy98xk/1+MdenXbJVv+i/+Ct8zP+ZRn+TmCFFkkZnYJn58LkuEiVut10PccZcjrIdPi
         cg9w==
X-Gm-Message-State: AG10YOT+blR6FtStzrZ2VLDg6OLNPORBArC7pLg2YAxq6XHBjhp281C3qokqSP6E2QTdlA4J
X-Received: by 10.98.70.139 with SMTP id o11mr49325480pfi.123.1454435507741;
        Tue, 02 Feb 2016 09:51:47 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:11e1:ff63:6d72:465a])
        by smtp.gmail.com with ESMTPSA id 6sm4100500pfo.58.2016.02.02.09.51.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 02 Feb 2016 09:51:46 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.42.ge5f5e2d
In-Reply-To: <1454435497-26429-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285290>

Adhere to the common coding style of Git and not check explicitly
for NULL throughout the file. There are still other occurrences in the
code base but that is usually inside of conditions with side effects.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.7.0.rc0.42.ge5f5e2d
