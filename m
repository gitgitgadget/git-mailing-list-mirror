From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH 13/13] Enable color output in Windows cmd.exe
Date: Thu, 17 Jul 2014 17:38:06 +0200
Message-ID: <1405611486-10176-14-git-send-email-kasal@ucw.cz>
References: <1405611486-10176-1-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Karsten Blees <karsten.blees@gmail.com>,
	msysGit <msysgit@googlegroups.com>,
	Karsten Blees <blees@dcon.de>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stepan Kasal <kasal@ucw.cz>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCU63DXMWULRBZ63T6PAKGQES63JOCQ@googlegroups.com Thu Jul 17 17:38:18 2014
Return-path: <msysgit+bncBCU63DXMWULRBZ63T6PAKGQES63JOCQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f188.google.com ([209.85.212.188])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBZ63T6PAKGQES63JOCQ@googlegroups.com>)
	id 1X7nlA-0008Vd-03
	for gcvm-msysgit@m.gmane.org; Thu, 17 Jul 2014 17:38:16 +0200
Received: by mail-wi0-f188.google.com with SMTP id z2sf305879wiv.25
        for <gcvm-msysgit@m.gmane.org>; Thu, 17 Jul 2014 08:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=O15pfcsFbmxMPO5QQfEAyvrFNQ7FBpE5Pzfux88BAJc=;
        b=ch3Uxqs9YmkPvg0CZK/yI12jV5mX4E79eIWLx6jdkXV+DAVzHHxM8Idzol4hwhlYbK
         J9e/i9mR4gHit0+eWz/Gw0ZtCD3qefmKvL6Ui93X+hW6Fc6bXuTEUt3fns+SRARJmwaU
         sktAn5M+7/Q1JXBOsa5i7gjiAAqdSGhU4hQJe1ZchFDv1SvB12idBcpZ8eYUxXekmnMP
         a5fq9bQLKCx6zPNdQb4H/QCL296omEQdfFrv0Em/K0Pn0tjgHeHhcPADJHdQC+yiIDdN
         M89t9QvWhFnzKxessBjKuE8NOIwXtpWpn3nDtwQQ+BeJ4E9utOl1S/6MXzmajl2uCEKE
         vJUQ==
X-Received: by 10.180.13.139 with SMTP id h11mr94251wic.21.1405611495666;
        Thu, 17 Jul 2014 08:38:15 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.19.68 with SMTP id c4ls449401wie.13.gmail; Thu, 17 Jul
 2014 08:38:14 -0700 (PDT)
X-Received: by 10.194.243.35 with SMTP id wv3mr180177wjc.7.1405611494790;
        Thu, 17 Jul 2014 08:38:14 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id o6si608387wij.1.2014.07.17.08.38.14
        for <msysgit@googlegroups.com>;
        Thu, 17 Jul 2014 08:38:14 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id 955C01C01B0; Thu, 17 Jul 2014 17:38:14 +0200 (CEST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253748>

From: Karsten Blees <blees@dcon.de>

Git requires the TERM environment variable to be set for all color*
settings. Simulate the TERM variable if it is not set (default on Windows).

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---
 compat/mingw.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index 6d4ec56..19975fa 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2112,6 +2112,10 @@ void mingw_startup()
 			setenv("TMPDIR", tmp, 1);
 	}
 
+	/* simulate TERM to enable auto-color (see color.c) */
+	if (!getenv("TERM"))
+		setenv("TERM", "cygwin", 1);
+
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
