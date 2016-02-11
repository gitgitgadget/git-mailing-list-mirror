From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 13/22] http-backend.c: use the FORMATPRINTF macro to declare the gcc function attribute 'format printf'
Date: Thu, 11 Feb 2016 12:38:50 +0000
Message-ID: <1455194339-859-14-git-send-email-gitter.spiros@gmail.com>
References: <1455194339-859-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 13:40:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTqXJ-000869-Nv
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 13:39:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753066AbcBKMju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 07:39:50 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36176 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752825AbcBKMjc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 07:39:32 -0500
Received: by mail-wm0-f67.google.com with SMTP id 128so10426548wmz.3
        for <git@vger.kernel.org>; Thu, 11 Feb 2016 04:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aFCjsvgsBQbShSAOX/VM/QTiMJ48AQt0zn4GEB+oBB0=;
        b=tywi1pla6SI9BpOvI6pOkdPqYlTHbQ63ynx87/DZHlYjFd0qCMxahh5PlFnwgHOyaz
         uRNuF+BxxsStmWwVRtov/CSnDXCcZ2cL/ExSguoql2F3GPD14iK2j+ge3lal0uPiiPdN
         4gd5I/HqmH2lCkfiQtsPzJSg0Q1vr0lgST4ck6aFZ6+Tt2vk9/YkZWGHJyMa96aWqP/J
         nF/QW2ZcfREFlT+bgeDttV7whcLXMN7Q6OHwxWdOTfROe6oHl0dv0i2xvHW1XkHiWRV+
         dFfTZy5bPGspHoEdE8Rf3S444oOt18/9RXaGpMBxJJsTB30iQkd917bos9qUphRjxF36
         ALAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aFCjsvgsBQbShSAOX/VM/QTiMJ48AQt0zn4GEB+oBB0=;
        b=YvZTPCcH9LI+FBrY6STzy/yfQvoUBP2QO2JB/JSTpZ3Op041PTOoMs/tZHyMYletw5
         1S0mlSuPKuSYTQU1nqOBqsZBn7Q4cnn9A9w1o7Rxuqu7Co/wyKb8AvcRfpo1fIHDxPYa
         pMiB9MkpHunrwTslWwXD4upfwxEhpjWJOrBmla91qkMt5HKhkmfXTnDWYAg8UH0ENoG5
         AUQLuvftmYTfelqxq2AOFuchd2lTcyrzaT3N+47bXXeGloUmTTg3OoS20LFoOrkxysCb
         Rfb4ERk2tHPAxa8XY5C7tRHTOlnX6b+bvL/zU8Dy2Le3NYXylcosoV0nameTXjzqp3Oc
         zA4w==
X-Gm-Message-State: AG10YOSdln+2wyQs5YIZmWYJbzwGjZb6OoJNdUWHnXOvQ9dL3l9/LnUJN4GqZvRDdqThfw==
X-Received: by 10.194.2.41 with SMTP id 9mr27384613wjr.10.1455194368032;
        Thu, 11 Feb 2016 04:39:28 -0800 (PST)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([40.113.119.92])
        by smtp.gmail.com with ESMTPSA id gt7sm7457368wjc.1.2016.02.11.04.39.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Feb 2016 04:39:27 -0800 (PST)
X-Mailer: git-send-email 2.7.0.327.gff4ea60.dirty
In-Reply-To: <1455194339-859-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285968>

Use the new FORMATPRINTF macro (in git-compat-util.h) to declare the gcc function
attribute 'format printf'

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 http-backend.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index 8870a26..c05e99f 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -58,7 +58,7 @@ static const char *get_parameter(const char *name)
 	return i ? i->util : NULL;
 }
 
-__attribute__((format (printf, 2, 3)))
+FORMATPRINTF(2,3)
 static void format_write(int fd, const char *fmt, ...)
 {
 	static char buffer[1024];
@@ -116,7 +116,7 @@ static void end_headers(void)
 	write_or_die(1, "\r\n", 2);
 }
 
-__attribute__((format (printf, 1, 2)))
+FORMATPRINTF(1,2)
 static NORETURN void not_found(const char *err, ...)
 {
 	va_list params;
@@ -132,7 +132,7 @@ static NORETURN void not_found(const char *err, ...)
 	exit(0);
 }
 
-__attribute__((format (printf, 1, 2)))
+FORMATPRINTF(1,2)
 static NORETURN void forbidden(const char *err, ...)
 {
 	va_list params;
-- 
2.5.0
