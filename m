From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv12 2/7] submodule-config: drop check against NULL
Date: Thu, 18 Feb 2016 14:19:19 -0800
Message-ID: <1455833964-3629-3-git-send-email-sbeller@google.com>
References: <1455833964-3629-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Feb 18 23:19:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWWvG-0005Zk-3B
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 23:19:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946897AbcBRWTd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 17:19:33 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33226 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946730AbcBRWTb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 17:19:31 -0500
Received: by mail-pf0-f180.google.com with SMTP id q63so38831888pfb.0
        for <git@vger.kernel.org>; Thu, 18 Feb 2016 14:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DIxpNObagqhi2y0dgA+FoqJYdunHFVtOjotoyAc15/I=;
        b=Bidh1OdisfVxmz5PR/D8xp47EjvW4LtJBak0EnmHIPqlG+L7L4v0Q7LU2vfHakyIk9
         Kle4I+fkLjEd1g/BySaqcIBNKcUIBoquthLN35CAxs4AUK9yRBcDEvImjSo/hjDPe8uy
         mlP16mHm+iGnQ2tZPXA7h+6DswHHUvvh7QI0qjpU478usBQ2A59iXTHrrDshecvHidMI
         HiAVqUBgi2H9ccLPKbdL++beWQszBMKMZRQ86dWTNa6re6KWANZ5e0UDievcxAPf+CfU
         DhlvLht5IYVm/IZ56OrtVwWmJ6CbZFkKL8TbKfqWJ5H1vi5D5ZymicLoanzRepM78tJm
         xpuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DIxpNObagqhi2y0dgA+FoqJYdunHFVtOjotoyAc15/I=;
        b=kjvntfdio5rKYAEAy2A/XBBX72/uQKSvpldl5funwdg8c+I87lLDGExLJQnBQOMD1i
         8+JK2NbmaiwlaUak/s0wq0Kstx3P98oKfmell+wcGWXMWSVf2rCjflLXjApCV5d4Z0Z4
         WrVSmWZC4dPIJwrZIlvyDXc6IyWmV0t6wIO93zajBdt1VeBYObRbvHJZAcVptRtmM1WM
         DEBTI8fHy0Q8w2n5oJwIWYJ3Xi+qYeXncCfolJM45AGvYY3AORp/eBHK61nAjA5qhnLT
         ASpg6ofJ+Ik0rNeCSTIwhG8LfpYm0mCJs+PRvCF2d5SFGiP85L8Po6B4akJlEGHA3kWD
         d2Pg==
X-Gm-Message-State: AG10YOQmCL8JhWe+aH9Mc+BwqsLkBLszFhQIFIZSAxOGpkALi/vhC8MAgKZ5cUDIBp2iv8og
X-Received: by 10.98.1.197 with SMTP id 188mr13604695pfb.8.1455833970499;
        Thu, 18 Feb 2016 14:19:30 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:d444:f36c:1851:bb54])
        by smtp.gmail.com with ESMTPSA id s23sm12669208pfi.12.2016.02.18.14.19.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 18 Feb 2016 14:19:29 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.34.g65aed89
In-Reply-To: <1455833964-3629-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286625>

Adhere to the common coding style of Git and not check explicitly
for NULL throughout the file. There are still other occurrences in the
code base but that is usually inside of conditions with side effects.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 submodule-config.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index f8d1be9..02bcaa7 100644
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
2.7.0.rc0.34.g65aed89
