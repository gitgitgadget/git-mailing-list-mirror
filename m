From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH] Win32: move main macro to a function
Date: Thu, 1 May 2014 00:28:36 +0200
Organization: <)><
Message-ID: <20140430222836.GB27914@camelia.ucw.cz>
References: <1398762726-22825-1-git-send-email-marat@slonopotamus.org> <1398762726-22825-9-git-send-email-marat@slonopotamus.org> <5360B5EC.1070907@gmail.com> <20140430221728.GA27914@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Marat Radchenko <marat@slonopotamus.org>,
        GIT Mailing-list <git@vger.kernel.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Erik Faye-Lund <kusmabite@gmail.com>, msysgit@googlegroups.com,
        Pat Thoyts <patthoyts@users.sourceforge.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j.sixt@viscovery.net>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBCU63DXMWULRBF7SQWNQKGQEP4ONPPY@googlegroups.com Thu May 01 00:28:42 2014
Return-path: <msysgit+bncBCU63DXMWULRBF7SQWNQKGQEP4ONPPY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f186.google.com ([209.85.212.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBF7SQWNQKGQEP4ONPPY@googlegroups.com>)
	id 1WfczY-0003HZ-Jo
	for gcvm-msysgit@m.gmane.org; Thu, 01 May 2014 00:28:40 +0200
Received: by mail-wi0-f186.google.com with SMTP id hi5sf241664wib.13
        for <gcvm-msysgit@m.gmane.org>; Wed, 30 Apr 2014 15:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:organization:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=zalLRsWFsEDp9BnWo/LqKbvebYSuqMCVB2A9zaY9Syk=;
        b=XpDXaMCKtarzxtVc+Gb3+8QIf6KGh+15ywh8QJtUoRMEw0n9vsJOaBHHFEGM5XJjSj
         JFU0rFG6mCwsaFAusTUdaAt8lub8CqCPGeOYrk5Clwdt1+dsRAA7W/ToJjLHNQGREM0w
         YxWw3Wpr5GaXGjIV8qTyr9i/lbH9wBflnRvjJBaSk1CrtiBU+Ao1JbbBI7a5+SN7TWKu
         RXMhTY2cF030pCRNFx81R3rXc9R1ldXSK4kRAnaiXGRiaE2mSphn+I2czr/9JpVGXYth
         a9LeqdmfIP02xGcuArUBeIBd4rHKcoy/3ten5Nzz5jcwdz26Wm8NTg1ZW00znEv8MBBq
         i56w==
X-Received: by 10.152.37.98 with SMTP id x2mr44251laj.13.1398896920255;
        Wed, 30 Apr 2014 15:28:40 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.44.170 with SMTP id f10ls124467lam.56.gmail; Wed, 30 Apr
 2014 15:28:39 -0700 (PDT)
X-Received: by 10.112.59.136 with SMTP id z8mr303536lbq.8.1398896919049;
        Wed, 30 Apr 2014 15:28:39 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id m49si912517eeu.0.2014.04.30.15.28.37
        for <msysgit@googlegroups.com>;
        Wed, 30 Apr 2014 15:28:38 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id A949C1C00FB;
	Thu,  1 May 2014 00:28:37 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s3UMSbQo028162;
	Thu, 1 May 2014 00:28:37 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s3UMSacM028160;
	Thu, 1 May 2014 00:28:36 +0200
In-Reply-To: <20140430221728.GA27914@camelia.ucw.cz>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247799>

From: Karsten Blees <blees@dcon.de>
Date: Fri, 7 Jan 2011 19:47:23 +0100

The code in the MinGW main macro is getting more and more complex,
move to a separate initialization function for readabiliy and
extensibility.

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---

Hello,
  this is commit 0115ef83 alias 9206e7fd that Karsten mentioned.

Junio, this one has been in msysgit for 2 or 3 years, so you can
suppose it is acked.

Have a nice day,
	Stepan

 compat/mingw.c | 15 +++++++++++++++
 compat/mingw.h | 16 +++++-----------
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index e9892f8..1d11e9f 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1823,3 +1823,18 @@ pid_t waitpid(pid_t pid, int *status, int options)
 	errno = EINVAL;
 	return -1;
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
index e033e72..95bcc75 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -361,22 +361,16 @@ void free_environ(char **env);
 extern CRITICAL_SECTION pinfo_cs;
 
 /*
- * A replacement of main() that ensures that argv[0] has a path
- * and that default fmode and std(in|out|err) are in binary mode
+ * A replacement of main() that adds win32 specific initialization.
  */
 
+void mingw_startup();
 #define main(c,v) dummy_decl_mingw_main(); \
 static int mingw_main(c,v); \
-int main(int argc, char **argv) \
+int main(c,v) \
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
