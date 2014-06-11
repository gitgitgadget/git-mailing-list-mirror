From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH 5/7] Win32: Unicode arguments (outgoing)
Date: Wed, 11 Jun 2014 11:37:44 +0200
Message-ID: <1402479466-8500-6-git-send-email-kasal@ucw.cz>
References: <1402479466-8500-1-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysGit <msysgit@googlegroups.com>,
	Karsten Blees <blees@dcon.de>,
	Stepan Kasal <kasal@ucw.cz>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCU63DXMWULRB7OG4COAKGQEU5PATQQ@googlegroups.com Wed Jun 11 11:38:11 2014
Return-path: <msysgit+bncBCU63DXMWULRB7OG4COAKGQEU5PATQQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f190.google.com ([209.85.217.190])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRB7OG4COAKGQEU5PATQQ@googlegroups.com>)
	id 1Wueys-0004Js-EI
	for gcvm-msysgit@m.gmane.org; Wed, 11 Jun 2014 11:38:06 +0200
Received: by mail-lb0-f190.google.com with SMTP id p9sf993132lbv.17
        for <gcvm-msysgit@m.gmane.org>; Wed, 11 Jun 2014 02:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=w62L2aI126u4zZOoUVM5nek/h91z8U5/zVyoJd80AoI=;
        b=K6KvA2J1YPyHl+ErYF0i5KVzEvFlSW55n/WWvf5P/RZseQPC9PCjL3yrABUBEJlI14
         YjwUqeeK8HEJkubwVhi1+KWZmBadmpVNRONolvrGFLJb+9GiEP9SGzdNUEPcK2UiK5M8
         9MAjPCceN1/9UqEvL+MBkFKxH8tRERDcIU0chYOZTrafy86Wba5sGgJUnQaV9BTYrk2j
         kY+7+10PmOI/W40FJd2Pyud4yoAcq2g7VNdu2af80Y9adM39wIa/3V+BJy1wG1SZNl4y
         /POG9siUQNtTfABzuWs8ECaD+LSXvmnVQP1yZq1NZjWbXpG2iozc3hIdLw7f04H2RSm1
         HgBw==
X-Received: by 10.152.27.168 with SMTP id u8mr409166lag.0.1402479486306;
        Wed, 11 Jun 2014 02:38:06 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.28.136 with SMTP id b8ls431357lah.0.gmail; Wed, 11 Jun
 2014 02:38:05 -0700 (PDT)
X-Received: by 10.112.13.36 with SMTP id e4mr1467794lbc.11.1402479484990;
        Wed, 11 Jun 2014 02:38:04 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id gz10si1289240wib.0.2014.06.11.02.38.04
        for <msysgit@googlegroups.com>;
        Wed, 11 Jun 2014 02:38:04 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id 9D0FF1C00AB; Wed, 11 Jun 2014 11:38:04 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1402479466-8500-1-git-send-email-kasal@ucw.cz>
X-Original-Sender: kasal@ucw.cz
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: kasal@ucw.cz does not designate permitted sender hosts) smtp.mail=kasal@ucw.cz
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251355>

From: Karsten Blees <blees@dcon.de>
Date: Sun, 16 Jan 2011 18:27:53 +0100

Convert command line arguments from UTF-8 to UTF-16 when creating other
processes.

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---
 compat/mingw.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 1140a13..8a7b047 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -831,9 +831,10 @@ static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char **env,
 			      const char *dir,
 			      int prepend_cmd, int fhin, int fhout, int fherr)
 {
-	STARTUPINFO si;
+	STARTUPINFOW si;
 	PROCESS_INFORMATION pi;
 	struct strbuf envblk, args;
+	wchar_t wcmd[MAX_PATH], wdir[MAX_PATH], *wargs;
 	unsigned flags;
 	BOOL ret;
 
@@ -869,6 +870,11 @@ static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char **env,
 	si.hStdOutput = winansi_get_osfhandle(fhout);
 	si.hStdError = winansi_get_osfhandle(fherr);
 
+	if (xutftowcs_path(wcmd, cmd) < 0)
+		return -1;
+	if (dir && xutftowcs_path(wdir, dir) < 0)
+		return -1;
+
 	/* concatenate argv, quoting args as we go */
 	strbuf_init(&args, 0);
 	if (prepend_cmd) {
@@ -886,6 +892,10 @@ static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char **env,
 			free(quoted);
 	}
 
+	wargs = xmalloc((2 * args.len + 1) * sizeof(wchar_t));
+	xutftowcs(wargs, args.buf, 2 * args.len + 1);
+	strbuf_release(&args);
+
 	if (env) {
 		int count = 0;
 		char **e, **sorted_env;
@@ -907,12 +917,12 @@ static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char **env,
 	}
 
 	memset(&pi, 0, sizeof(pi));
-	ret = CreateProcess(cmd, args.buf, NULL, NULL, TRUE, flags,
-		env ? envblk.buf : NULL, dir, &si, &pi);
+	ret = CreateProcessW(wcmd, wargs, NULL, NULL, TRUE, flags,
+		env ? envblk.buf : NULL, dir ? wdir : NULL, &si, &pi);
 
 	if (env)
 		strbuf_release(&envblk);
-	strbuf_release(&args);
+	free(wargs);
 
 	if (!ret) {
 		errno = ENOENT;
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
