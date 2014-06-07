From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH v2 1/2] Win32: move main macro to a function
Date: Sat,  7 Jun 2014 08:46:40 +0200
Message-ID: <1402123601-26312-2-git-send-email-kasal@ucw.cz>
References: <53922F58.80509@gmail.com>
 <1402123601-26312-1-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysGit <msysgit@googlegroups.com>,
	Karsten Blees <blees@dcon.de>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Stepan Kasal <kasal@ucw.cz>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCU63DXMWULRBWHKZKOAKGQEVFPDDSA@googlegroups.com Sat Jun 07 08:46:49 2014
Return-path: <msysgit+bncBCU63DXMWULRBWHKZKOAKGQEVFPDDSA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f183.google.com ([209.85.217.183])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBWHKZKOAKGQEVFPDDSA@googlegroups.com>)
	id 1WtAOv-0001h0-91
	for gcvm-msysgit@m.gmane.org; Sat, 07 Jun 2014 08:46:49 +0200
Received: by mail-lb0-f183.google.com with SMTP id s7sf450350lbd.0
        for <gcvm-msysgit@m.gmane.org>; Fri, 06 Jun 2014 23:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=7F42+D3fSsMNR+sErqjQ8f0Qc6MZ3lHDVKnGAePMtCQ=;
        b=lh4lDKf0mnbcer/PnJeJ6NU6JcIWEiIpib3YuUZcUrnZ+6ODT4XtKujUyMMLAtsxGf
         6hy5w17LFiXk8aY/Q8k+0+/drJ0yNC+Q8jeqxd8Xz2jTKjBpe/55huAg3O2SKpUZgVYH
         qf42VmMcQ1EDjtkoNz5ox7XRNI4atKWTYWg9tNb6QKHXq1kzFHECszQzdSPLwkhhRaaS
         dayb4fIFjMiw0HflPhA0XelM1tjQLZ/voRwi83uXVtW6g7/BTiw5W+iEiVfsBs9kAtAg
         LaIswQyJZ8ov5fL0BXdXnIcS501tyr7pdq5EV8A+z7/75fjA3SrxsZ8Q1VOf7yIzZQer
         Q6vA==
X-Received: by 10.152.23.165 with SMTP id n5mr138874laf.5.1402123608868;
        Fri, 06 Jun 2014 23:46:48 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.9.135 with SMTP id z7ls205636laa.101.gmail; Fri, 06 Jun
 2014 23:46:47 -0700 (PDT)
X-Received: by 10.152.36.226 with SMTP id t2mr2657335laj.1.1402123607632;
        Fri, 06 Jun 2014 23:46:47 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id xk11si77372wib.0.2014.06.06.23.46.47
        for <msysgit@googlegroups.com>;
        Fri, 06 Jun 2014 23:46:47 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id 720A21C00A5; Sat,  7 Jun 2014 08:46:47 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1402123601-26312-1-git-send-email-kasal@ucw.cz>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251027>

From: Karsten Blees <blees@dcon.de>
Date: Fri, 7 Jan 2011 19:47:23 +0100

The code in the MinGW main macro is getting more and more complex, move to
a separate initialization function for readabiliy and extensibility.

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---
 compat/mingw.c | 15 +++++++++++++++
 compat/mingw.h | 14 ++++----------
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index a0e13bc..c03bafa 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1847,3 +1847,18 @@ int mingw_offset_1st_component(const char *path)
 
 	return offset + is_dir_sep(path[offset]);
 }
+
+void mingw_startup()
+{
+	/* copy executable name to argv[0] */
+	__argv[0] = xstrdup(_pgmptr);
+
+	/* initialize critical section for waitpid pinfo_t list */
+	InitializeCriticalSection(&pinfo_cs);
+
+	/* set up default file mode and file modes for stdin/out/err */
+	_fmode = _O_BINARY;
+	_setmode(_fileno(stdin), _O_BINARY);
+	_setmode(_fileno(stdout), _O_BINARY);
+	_setmode(_fileno(stderr), _O_BINARY);
+}
diff --git a/compat/mingw.h b/compat/mingw.h
index 3eaf822..15f0c9d 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -363,22 +363,16 @@ void free_environ(char **env);
 extern CRITICAL_SECTION pinfo_cs;
 
 /*
- * A replacement of main() that ensures that argv[0] has a path
- * and that default fmode and std(in|out|err) are in binary mode
+ * A replacement of main() that adds win32 specific initialization.
  */
 
+void mingw_startup();
 #define main(c,v) dummy_decl_mingw_main(); \
 static int mingw_main(c,v); \
 int main(int argc, char **argv) \
 { \
-	extern CRITICAL_SECTION pinfo_cs; \
-	_fmode = _O_BINARY; \
-	_setmode(_fileno(stdin), _O_BINARY); \
-	_setmode(_fileno(stdout), _O_BINARY); \
-	_setmode(_fileno(stderr), _O_BINARY); \
-	argv[0] = xstrdup(_pgmptr); \
-	InitializeCriticalSection(&pinfo_cs); \
-	return mingw_main(argc, argv); \
+	mingw_startup(); \
+	return mingw_main(__argc, __argv); \
 } \
 static int mingw_main(c,v)
 
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
