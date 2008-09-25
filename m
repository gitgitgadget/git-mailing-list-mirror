From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH] usage.c: remove unused functions
Date: Thu, 25 Sep 2008 18:41:04 +0900
Message-ID: <20080925184104.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 25 11:43:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KinN0-0006NZ-Q9
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 11:42:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752872AbYIYJlh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 05:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752862AbYIYJlh
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 05:41:37 -0400
Received: from karen.lavabit.com ([72.249.41.33]:43295 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752750AbYIYJlg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 05:41:36 -0400
Received: from f.earth.lavabit.com (f.earth.lavabit.com [192.168.111.15])
	by karen.lavabit.com (Postfix) with ESMTP id BD4B1C8A48;
	Thu, 25 Sep 2008 04:41:35 -0500 (CDT)
Received: from 2236.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id FAY8RJ6LF0EY; Thu, 25 Sep 2008 04:41:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=pioyN94W81sVc/nqBRBRUpmaqnLOSMJ8Bnv4AlhlhF3jmwtrrl+FBcliwhCT2F6VIXNgnZzXqom1sPpdYIkAo6QBAeE0JYKUx5aP8Ts2QXyhtadmquZxLSPIUPgUXwhOp+WhCC64r48X0sFgkgrBvGQMtf9fIFVmji/85AHGFxA=;
  h=From:To:Cc:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96740>

This removes three functions that are not used anywhere.

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---
 git-compat-util.h |    3 ---
 usage.c           |   16 ----------------
 2 files changed, 0 insertions(+), 19 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index db2836f..2ac832f 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -154,10 +154,7 @@ extern void die(const char *err, ...) NORETURN __attribute__((format (printf, 1,
 extern int error(const char *err, ...) __attribute__((format (printf, 1, 2)));
 extern void warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
 
-extern void set_usage_routine(void (*routine)(const char *err) NORETURN);
 extern void set_die_routine(void (*routine)(const char *err, va_list params) NORETURN);
-extern void set_error_routine(void (*routine)(const char *err, va_list params));
-extern void set_warn_routine(void (*routine)(const char *warn, va_list params));
 
 extern int prefixcmp(const char *str, const char *prefix);
 extern time_t tm_to_time_t(const struct tm *tm);
diff --git a/usage.c b/usage.c
index a5fc4ec..24f5fc0 100644
--- a/usage.c
+++ b/usage.c
@@ -41,27 +41,11 @@ static void (*die_routine)(const char *err, va_list params) NORETURN = die_built
 static void (*error_routine)(const char *err, va_list params) = error_builtin;
 static void (*warn_routine)(const char *err, va_list params) = warn_builtin;
 
-void set_usage_routine(void (*routine)(const char *err) NORETURN)
-{
-	usage_routine = routine;
-}
-
 void set_die_routine(void (*routine)(const char *err, va_list params) NORETURN)
 {
 	die_routine = routine;
 }
 
-void set_error_routine(void (*routine)(const char *err, va_list params))
-{
-	error_routine = routine;
-}
-
-void set_warn_routine(void (*routine)(const char *warn, va_list params))
-{
-	warn_routine = routine;
-}
-
-
 void usage(const char *err)
 {
 	usage_routine(err);

-- 
1.6.0.2

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
