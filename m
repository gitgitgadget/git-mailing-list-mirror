From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH 6/7] Win32: Unicode arguments (incoming)
Date: Wed, 11 Jun 2014 11:37:45 +0200
Message-ID: <1402479466-8500-7-git-send-email-kasal@ucw.cz>
References: <1402479466-8500-1-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysGit <msysgit@googlegroups.com>,
	Karsten Blees <blees@dcon.de>,
	Stepan Kasal <kasal@ucw.cz>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCU63DXMWULRB7OG4COAKGQEU5PATQQ@googlegroups.com Wed Jun 11 11:38:06 2014
Return-path: <msysgit+bncBCU63DXMWULRB7OG4COAKGQEU5PATQQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f62.google.com ([209.85.215.62])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRB7OG4COAKGQEU5PATQQ@googlegroups.com>)
	id 1Wueys-0004Jn-9i
	for gcvm-msysgit@m.gmane.org; Wed, 11 Jun 2014 11:38:06 +0200
Received: by mail-la0-f62.google.com with SMTP id pv20sf994794lab.7
        for <gcvm-msysgit@m.gmane.org>; Wed, 11 Jun 2014 02:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=JuJ+khhKJEuOGzWFMWMVQ0umc5UE3+4+fBm6EixhJPo=;
        b=NamF1ulFXNvhOfmGGC0b0Jbe/aPgjzaCyNvyTRzgZzf9ZTxAcO2z6sigHnO49VtPze
         z3iEgYelTcEBon5dK8s7bcG3YGwAql6hcK5asvCwTKRhFS1FH7RAoPS/bMvtp5A7GiSJ
         X3SlzQWrO5mPW5S2XM/LqjRbtU35Xc4O8NEHcchzS0GZHSarvimoXNoDBew/0VrkatJN
         FolJqf1PO3cH/Pf7dNf2fgSLl0tQcSRadgV1Gnm85gxU18XdzyhxkLg3IMKvEIuCZMxl
         jgPKpzIoCTOEfRc1d5sncLg9TEF52kQGUdrxB1skJS7CyuCVoVkyrVnh37W30Ct6ZG8R
         4WaA==
X-Received: by 10.152.203.193 with SMTP id ks1mr7719lac.29.1402479486159;
        Wed, 11 Jun 2014 02:38:06 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.29.229 with SMTP id n5ls470416lah.2.gmail; Wed, 11 Jun
 2014 02:38:05 -0700 (PDT)
X-Received: by 10.112.155.67 with SMTP id vu3mr1792251lbb.9.1402479484990;
        Wed, 11 Jun 2014 02:38:04 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id s3si1183449wic.3.2014.06.11.02.38.04
        for <msysgit@googlegroups.com>;
        Wed, 11 Jun 2014 02:38:04 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id A27AC1C00AF; Wed, 11 Jun 2014 11:38:04 +0200 (CEST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251349>

From: Karsten Blees <blees@dcon.de>
Date: Sun, 16 Jan 2011 18:28:27 +0100

Convert command line arguments from UTF-16 to UTF-8 on startup.

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---
 compat/mingw.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 8a7b047..3baaa4d 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1943,10 +1943,48 @@ int xwcstoutf(char *utf, const wchar_t *wcs, size_t utflen)
  */
 int _CRT_glob = 0;
 
+typedef struct {
+	int newmode;
+} _startupinfo;
+
+extern int __wgetmainargs(int *argc, wchar_t ***argv, wchar_t ***env, int glob,
+		_startupinfo *si);
+
+static NORETURN void die_startup()
+{
+	fputs("fatal: not enough memory for initialization", stderr);
+	exit(128);
+}
+
 void mingw_startup()
 {
-	/* copy executable name to argv[0] */
-	__argv[0] = xstrdup(_pgmptr);
+	int i, len, maxlen, argc;
+	char *buffer;
+	wchar_t **wenv, **wargv;
+	_startupinfo si;
+
+	/* get wide char arguments and environment */
+	si.newmode = 0;
+	if (__wgetmainargs(&argc, &wargv, &wenv, _CRT_glob, &si) < 0)
+		die_startup();
+
+	/* determine size of argv and environ conversion buffer */
+	maxlen = wcslen(_wpgmptr);
+	for (i = 1; i < argc; i++)
+		maxlen = max(maxlen, wcslen(wargv[i]));
+
+	/* allocate buffer (wchar_t encodes to max 3 UTF-8 bytes) */
+	maxlen = 3 * maxlen + 1;
+	buffer = xmalloc(maxlen);
+
+	/* convert command line arguments and environment to UTF-8 */
+	len = xwcstoutf(buffer, _wpgmptr, maxlen);
+	__argv[0] = xmemdupz(buffer, len);
+	for (i = 1; i < argc; i++) {
+		len = xwcstoutf(buffer, wargv[i], maxlen);
+		__argv[i] = xmemdupz(buffer, len);
+	}
+	free(buffer);
 
 	/* initialize critical section for waitpid pinfo_t list */
 	InitializeCriticalSection(&pinfo_cs);
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
