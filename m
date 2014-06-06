From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH 2/5] Win32 dirent: remove unused dirent.d_reclen member
Date: Fri,  6 Jun 2014 22:15:41 +0200
Message-ID: <1402085744-15829-3-git-send-email-kasal@ucw.cz>
References: <5391ED57.1000601@gmail.com>
 <1402085744-15829-1-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysGit <msysgit@googlegroups.com>,
	Karsten Blees <blees@dcon.de>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Stepan Kasal <kasal@ucw.cz>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCU63DXMWULRB6OCZCOAKGQEVG45WZQ@googlegroups.com Fri Jun 06 22:15:57 2014
Return-path: <msysgit+bncBCU63DXMWULRB6OCZCOAKGQEVG45WZQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f61.google.com ([209.85.215.61])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRB6OCZCOAKGQEVG45WZQ@googlegroups.com>)
	id 1Wt0YL-0005KE-Uq
	for gcvm-msysgit@m.gmane.org; Fri, 06 Jun 2014 22:15:53 +0200
Received: by mail-la0-f61.google.com with SMTP id hr17sf415719lab.16
        for <gcvm-msysgit@m.gmane.org>; Fri, 06 Jun 2014 13:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=LGTpZr20vRijdAk08l6XIRIdQ+V0sJM1XhzccgAyhnA=;
        b=xR0WIjNVA+mPlx4Z0JcA72u/4mkGutrV4JK42f6QHDJytqjNNWO+5gHBjvnQiP2BUN
         WAgiAQED4LUUg7mZsrzxu66yRh8AMWh6MP6zIkU9mhbk2hWcP1r4OWT4B1avZ5qZbcpI
         vk/1sTOMCz2M3k0POneL1JOkPPVpmpNzfzTP8hSUSrjL8NEDOV+KkKgsYQR8GVGnl9LR
         32sxKPytRwF/SAV8Eayq8Apdd/4QDJ5y4d+EADF/LQVOjsgGeB5XYVDv0vVTm9sohsJd
         iYMJ/o4rVfdpBWErFVtBRkusApkHPHkQldvz+7Bpa5joNzxbbSCHORvr3DLwUBNPjurw
         c0Aw==
X-Received: by 10.180.20.43 with SMTP id k11mr37422wie.12.1402085753714;
        Fri, 06 Jun 2014 13:15:53 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.79.232 with SMTP id m8ls161600wix.38.canary; Fri, 06 Jun
 2014 13:15:52 -0700 (PDT)
X-Received: by 10.180.182.17 with SMTP id ea17mr1564167wic.3.1402085752903;
        Fri, 06 Jun 2014 13:15:52 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id xk11si1421718wib.0.2014.06.06.13.15.52
        for <msysgit@googlegroups.com>;
        Fri, 06 Jun 2014 13:15:52 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id B4ED31C00A8; Fri,  6 Jun 2014 22:15:52 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1402085744-15829-1-git-send-email-kasal@ucw.cz>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250964>

From: Karsten Blees <blees@dcon.de>
Date: Fri, 7 Jan 2011 17:38:25 +0100

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
