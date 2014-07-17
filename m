From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH 06/13] Win32: unify environment function names
Date: Thu, 17 Jul 2014 17:37:59 +0200
Message-ID: <1405611486-10176-7-git-send-email-kasal@ucw.cz>
References: <1405611486-10176-1-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Karsten Blees <karsten.blees@gmail.com>,
	msysGit <msysgit@googlegroups.com>,
	Karsten Blees <blees@dcon.de>,
	Stepan Kasal <kasal@ucw.cz>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCU63DXMWULRBZ63T6PAKGQES63JOCQ@googlegroups.com Thu Jul 17 17:38:21 2014
Return-path: <msysgit+bncBCU63DXMWULRBZ63T6PAKGQES63JOCQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f192.google.com ([74.125.82.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBZ63T6PAKGQES63JOCQ@googlegroups.com>)
	id 1X7nl9-0008Vc-Uu
	for gcvm-msysgit@m.gmane.org; Thu, 17 Jul 2014 17:38:16 +0200
Received: by mail-we0-f192.google.com with SMTP id x48sf333733wes.9
        for <gcvm-msysgit@m.gmane.org>; Thu, 17 Jul 2014 08:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=B8M659rr1xJcWjglclK0P4PkA6XEl+m4xKw6KVs9gcA=;
        b=Lb5VkGgDF1TyjhYZ7Uc1LMqhPJkieRW9x9P1PyCpBWlaiaJ3TizXu8z4tHrBvK0AUg
         ctvtgmRsp7FqdyQjoVkTVXAdPleYmMvQi0YhiFfZ7KcGMRoNMcUcjngD8v7TWX/XAHdb
         3VIceI+k3TCofwWTGIyPelCut6Hkz+sH2aXdvN8Clm2pi3vWxomgE3n5I+kS5OScUXdz
         kBEndgkXKB14qNq+0lWsEwgcN1styzGjoF6mUWrf0vCxkL1LZgl/X+5rjXO6RcgjpX/6
         ouIYsurBElHWSNnmdLvT7OQWUUut3KSLasJ1D/donaDmvrG1/bAJ7qejFnXWuwwuNCJ4
         zDQw==
X-Received: by 10.152.27.162 with SMTP id u2mr10362lag.16.1405611495643;
        Thu, 17 Jul 2014 08:38:15 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.178.162 with SMTP id cz2ls214923lac.33.gmail; Thu, 17 Jul
 2014 08:38:14 -0700 (PDT)
X-Received: by 10.152.203.199 with SMTP id ks7mr3770128lac.0.1405611494647;
        Thu, 17 Jul 2014 08:38:14 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id mx7si1076316wic.1.2014.07.17.08.38.14
        for <msysgit@googlegroups.com>;
        Thu, 17 Jul 2014 08:38:14 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id 6CA621C01A7; Thu, 17 Jul 2014 17:38:14 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1405611486-10176-1-git-send-email-kasal@ucw.cz>
X-Original-Sender: kasal@ucw.cz
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: kasal@ucw.cz does not designate permitted sender hosts) smtp.mail=kasal@ucw.cz
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253758>

From: Karsten Blees <blees@dcon.de>

Environment helper functions use random naming ('env' prefix or suffix or
both, with or without '_'). Change to POSIX naming scheme ('env' suffix,
no '_').

Env_setenv has more in common with putenv than setenv. Change to do_putenv.

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---
 compat/mingw.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index fe869ed..89fe62b 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -898,7 +898,7 @@ static char *path_lookup(const char *cmd, char **path, int exe_only)
 	return prog;
 }
 
-static int env_compare(const void *a, const void *b)
+static int compareenv(const void *a, const void *b)
 {
 	char *const *ea = a;
 	char *const *eb = b;
@@ -992,7 +992,7 @@ static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char **env,
 		/* environment must be sorted */
 		sorted_env = xmalloc(sizeof(*sorted_env) * (count + 1));
 		memcpy(sorted_env, env, sizeof(*sorted_env) * (count + 1));
-		qsort(sorted_env, count, sizeof(*sorted_env), env_compare);
+		qsort(sorted_env, count, sizeof(*sorted_env), compareenv);
 
 		/* create environment block from temporary environment */
 		for (e = sorted_env; *e; e++) {
@@ -1193,7 +1193,7 @@ void free_environ(char **env)
 	free(env);
 }
 
-static int lookup_env(char **env, const char *name, size_t nmln)
+static int lookupenv(char **env, const char *name, size_t nmln)
 {
 	int i;
 
@@ -1208,10 +1208,10 @@ static int lookup_env(char **env, const char *name, size_t nmln)
 /*
  * If name contains '=', then sets the variable, otherwise it unsets it
  */
-static char **env_setenv(char **env, const char *name)
+static char **do_putenv(char **env, const char *name)
 {
 	char *eq = strchrnul(name, '=');
-	int i = lookup_env(env, name, eq-name);
+	int i = lookupenv(env, name, eq-name);
 
 	if (i < 0) {
 		if (*eq) {
@@ -1242,7 +1242,7 @@ char **make_augmented_environ(const char *const *vars)
 
 	while (*vars) {
 		const char *v = *vars++;
-		env = env_setenv(env, strchr(v, '=') ? xstrdup(v) : v);
+		env = do_putenv(env, strchr(v, '=') ? xstrdup(v) : v);
 	}
 	return env;
 }
@@ -1262,7 +1262,7 @@ char *mingw_getenv(const char *name)
 
 int mingw_putenv(const char *namevalue)
 {
-	environ = env_setenv(environ, namevalue);
+	environ = do_putenv(environ, namevalue);
 	return 0;
 }
 
-- 
2.0.0.9635.g0be03cb

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
