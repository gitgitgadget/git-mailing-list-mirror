From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH 4/5] Win32: move main macro to a function
Date: Fri,  6 Jun 2014 15:42:52 +0200
Message-ID: <1402062173-9602-5-git-send-email-kasal@ucw.cz>
References: <1402062173-9602-1-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysGit <msysgit@googlegroups.com>,
	Karsten Blees <blees@dcon.de>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Stepan Kasal <kasal@ucw.cz>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCU63DXMWULRB5EKY6OAKGQEC7CDM2I@googlegroups.com Fri Jun 06 15:43:23 2014
Return-path: <msysgit+bncBCU63DXMWULRB5EKY6OAKGQEC7CDM2I@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f60.google.com ([74.125.82.60])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRB5EKY6OAKGQEC7CDM2I@googlegroups.com>)
	id 1WsuQP-0000f9-3B
	for gcvm-msysgit@m.gmane.org; Fri, 06 Jun 2014 15:43:17 +0200
Received: by mail-wg0-f60.google.com with SMTP id n12sf307603wgh.25
        for <gcvm-msysgit@m.gmane.org>; Fri, 06 Jun 2014 06:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=jb7CC/hSVTa1N3dV6kSy2ZJ8xtd01zARthiJnGbMcrI=;
        b=XkjIyf/MrNVTILo7FzADMVWg+kAL+/mCF1Zpr5z6UK10iJBBWMW18LNL1yPz14zbfj
         Btn/JbkOQKP4/ZmYaDA2WTAwQqT8Wt1Kt7uYpYn48DXsyRoY4mjxADMyFUWy8WY6ChhZ
         f++PIpYOcca1ED0WgLlxyTsyMzYdIigEB8KDUh6ZetkT67pfCw4d5vnwsE1pIGCDLxfh
         I7qdVQS1GxPeght74FjHa7IeYnEKeGm7ljEWprIOde1V1v3QsfUU+h1a0EF2Wu9QW9Mr
         wizOcX7WIBP3Ns0Yrvf4Dua3l85nYrULyMha/jT4BpZfk+QMVWqQKbhIubR31Mwzt+4R
         15lw==
X-Received: by 10.152.4.136 with SMTP id k8mr15111lak.17.1402062196840;
        Fri, 06 Jun 2014 06:43:16 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.44.165 with SMTP id f5ls133708lam.39.gmail; Fri, 06 Jun
 2014 06:43:15 -0700 (PDT)
X-Received: by 10.152.22.38 with SMTP id a6mr1410043laf.6.1402062195816;
        Fri, 06 Jun 2014 06:43:15 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id eh2si1304822wib.2.2014.06.06.06.43.15
        for <msysgit@googlegroups.com>;
        Fri, 06 Jun 2014 06:43:15 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id A058E1C00A8; Fri,  6 Jun 2014 15:43:15 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1402062173-9602-1-git-send-email-kasal@ucw.cz>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250905>

From: Karsten Blees <blees@dcon.de>

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
index a465d1e..96d15ca 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -365,22 +365,16 @@ void free_environ(char **env);
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
