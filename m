From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH 1/2] Win32: move main macro to a function
Date: Thu, 29 May 2014 12:45:52 +0200
Organization: <)><
Message-ID: <20140529104552.GB24021@camelia.ucw.cz>
References: <20140529104329.GA24021@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Erik Faye-Lund <kusmabite@gmail.com>, msysgit@googlegroups.com,
        Karsten Blees <karsten.blees@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCU63DXMWULRBYU7TSOAKGQEHZMCHRQ@googlegroups.com Thu May 29 12:45:55 2014
Return-path: <msysgit+bncBCU63DXMWULRBYU7TSOAKGQEHZMCHRQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f56.google.com ([209.85.215.56])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBYU7TSOAKGQEHZMCHRQ@googlegroups.com>)
	id 1WpxqM-0003hZ-Hm
	for gcvm-msysgit@m.gmane.org; Thu, 29 May 2014 12:45:54 +0200
Received: by mail-la0-f56.google.com with SMTP id mc6sf13198lab.21
        for <gcvm-msysgit@m.gmane.org>; Thu, 29 May 2014 03:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:organization:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=NR1qktH2FbBPU1RCG83sZQzISOOR5VZYhYk1v5cwKuA=;
        b=BW0++yKPDTA3EylTph3Tff9tP+hxblNES65DQNG7mjTDiBBDjNmyccy+bwUJi2lgFR
         v8aqxl+U4eCfTGpZgdjlETMOhEWlf3dwYxbbXQTkIXtIC3XTRCSRXRkwb7KfIjNe60Lx
         TPqnUg+q0DdfZE5RjaeYJT1pDonPoZvm1JoIukhNJIu7sXFlyiHg6XcpeDGiRO+OxQNi
         4AfgzinDwOfR6JukN69BkUTBaHLcD9HubJCdtWlb2KYnBfd4EVtnzBwjv7w/Vvwr28cm
         s0N8dFVQ0AvVHFP853OwhpdmcN7e9C0W9nwLgK2+xmhP4oBYLEw9s377NDmoFL9R4Y2/
         GU4Q==
X-Received: by 10.180.14.5 with SMTP id l5mr113524wic.12.1401360354368;
        Thu, 29 May 2014 03:45:54 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.78.170 with SMTP id c10ls174499wix.9.gmail; Thu, 29 May
 2014 03:45:53 -0700 (PDT)
X-Received: by 10.180.82.134 with SMTP id i6mr4103548wiy.1.1401360353641;
        Thu, 29 May 2014 03:45:53 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id g42si367222eev.1.2014.05.29.03.45.53
        for <msysgit@googlegroups.com>;
        Thu, 29 May 2014 03:45:53 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 68C5A1C00ED;
	Thu, 29 May 2014 12:45:53 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s4TAjrBN024118;
	Thu, 29 May 2014 12:45:53 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s4TAjqYX024117;
	Thu, 29 May 2014 12:45:53 +0200
In-Reply-To: <20140529104329.GA24021@camelia.ucw.cz>
User-Agent: Mutt/1.5.19 (2009-01-05)
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
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250357>

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
1.9.2.msysgit.0.496.g23aa553

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
