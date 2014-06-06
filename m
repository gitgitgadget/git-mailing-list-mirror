From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH 2/5] Win32 dirent: remove unused dirent.d_reclen member
Date: Fri,  6 Jun 2014 15:43:18 +0200
Message-ID: <1402062201-9709-3-git-send-email-kasal@ucw.cz>
References: <1402062201-9709-1-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysGit <msysgit@googlegroups.com>,
	Karsten Blees <blees@dcon.de>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Stepan Kasal <kasal@ucw.cz>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCU63DXMWULRBAMLY6OAKGQE5IXTXZI@googlegroups.com Fri Jun 06 15:43:38 2014
Return-path: <msysgit+bncBCU63DXMWULRBAMLY6OAKGQE5IXTXZI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f189.google.com ([74.125.82.189])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBAMLY6OAKGQE5IXTXZI@googlegroups.com>)
	id 1WsuQc-0000pF-LA
	for gcvm-msysgit@m.gmane.org; Fri, 06 Jun 2014 15:43:30 +0200
Received: by mail-we0-f189.google.com with SMTP id w62sf325695wes.16
        for <gcvm-msysgit@m.gmane.org>; Fri, 06 Jun 2014 06:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=Nl3ho1QFIDVfHhe9e2OLeB7/vqV01sPbTR9l5RZf62c=;
        b=E7v6rEzqkwPoCb3BFPJBoNDI4QwYSCrbXp5dUj8znIhrHmaqxeMfcQgUbumVjEqoFt
         2D9Yp+vBgTwuuG6KQdEUtyLgMsV8UKqZgefN7OC3G4iXmG60fvN49Nt+vU9ik2UbArmh
         drtwoN4O53x9OMOrKbu9bRaa3dYHSwBaH/8ZtT+Pyx2qKzaHAWw93o+A7cdG4tpnF8N8
         PJG/ZS1wPZE9UlfnQicj2hbNNSeDGvF0oNrWOP4bhPdVIKWV0squrs+o/Jsx6HycUA2s
         Q6l/w/GDEXud4ZXs6CQMBcRA/n+qE8ZmTchFhHKJs8FHkBtw1Z3l3ITFiFL/QlkDoGat
         Nspg==
X-Received: by 10.152.2.228 with SMTP id 4mr4374lax.37.1402062210390;
        Fri, 06 Jun 2014 06:43:30 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.198.236 with SMTP id jf12ls132201lac.60.gmail; Fri, 06 Jun
 2014 06:43:29 -0700 (PDT)
X-Received: by 10.112.140.170 with SMTP id rh10mr1340221lbb.7.1402062209386;
        Fri, 06 Jun 2014 06:43:29 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id ck3si598729wib.0.2014.06.06.06.43.29
        for <msysgit@googlegroups.com>;
        Fri, 06 Jun 2014 06:43:29 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id 234571C00A5; Fri,  6 Jun 2014 15:43:29 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1402062201-9709-1-git-send-email-kasal@ucw.cz>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250910>

From: Karsten Blees <blees@dcon.de>

Remove the union around dirent.d_type and the unused dirent.d_reclen member
(which was necessary for compatibility with the MinGW dirent runtime, which
is no longer used).

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---
 compat/win32/dirent.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/compat/win32/dirent.h b/compat/win32/dirent.h
index b38973b..7f4e6c7 100644
--- a/compat/win32/dirent.h
+++ b/compat/win32/dirent.h
@@ -10,10 +10,7 @@ typedef struct DIR DIR;
 
 struct dirent {
 	char d_name[FILENAME_MAX];       /* File name. */
-	union {
-		unsigned short d_reclen; /* Always zero. */
-		unsigned char  d_type;   /* Reimplementation adds this */
-	};
+	unsigned char d_type;      /* file type to prevent lstat after readdir */
 };
 
 DIR *opendir(const char *dirname);
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
