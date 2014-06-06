From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH 1/5] Win32 dirent: remove unused dirent.d_ino member
Date: Fri,  6 Jun 2014 22:15:40 +0200
Message-ID: <1402085744-15829-2-git-send-email-kasal@ucw.cz>
References: <5391ED57.1000601@gmail.com>
 <1402085744-15829-1-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysGit <msysgit@googlegroups.com>,
	Karsten Blees <blees@dcon.de>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Stepan Kasal <kasal@ucw.cz>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCU63DXMWULRB6OCZCOAKGQEVG45WZQ@googlegroups.com Fri Jun 06 22:15:59 2014
Return-path: <msysgit+bncBCU63DXMWULRB6OCZCOAKGQEVG45WZQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f56.google.com ([209.85.215.56])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRB6OCZCOAKGQEVG45WZQ@googlegroups.com>)
	id 1Wt0YL-0005KF-VS
	for gcvm-msysgit@m.gmane.org; Fri, 06 Jun 2014 22:15:54 +0200
Received: by mail-la0-f56.google.com with SMTP id mc6sf406283lab.11
        for <gcvm-msysgit@m.gmane.org>; Fri, 06 Jun 2014 13:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=QYciLgMsdZbjujdbD+35XS7v6cAaeVx4WcII7DvMD20=;
        b=lzpkvVN76gquWyO/r7g+QBnc+3aDOP8BZbQjPdJwp6F2dX6/rA0ySNelt/WaRmjXJi
         yLv3OfrC/hwy6zbtrjt32g6nb3V08Ajacm6jtiV5XX5ij8Ge8b7IUpXU6v4r04QCx5VK
         Gts/qSXpyEEaxSqa+cpPMXhe7oVhfb8pjPOw7k2QtErgIF2PD//TMdO1F5pCU4elYOU8
         kiHme/K/LNsE0LqB7KqT2j8/+yGCHRUzeKh9wBmvz/OBNlxYSCrnrlQueeciJdH5Cmrx
         U5p5F6ATWHpA7hhYuzefVvoXPeDkUjtFaGJOxy+D26L5r6FEiFQjL90aeFStWOApr89T
         e1nQ==
X-Received: by 10.180.75.13 with SMTP id y13mr37039wiv.3.1402085753754;
        Fri, 06 Jun 2014 13:15:53 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.74.100 with SMTP id s4ls170548wiv.18.canary; Fri, 06 Jun
 2014 13:15:52 -0700 (PDT)
X-Received: by 10.180.14.129 with SMTP id p1mr1816565wic.0.1402085752921;
        Fri, 06 Jun 2014 13:15:52 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id ck3si706875wib.0.2014.06.06.13.15.52
        for <msysgit@googlegroups.com>;
        Fri, 06 Jun 2014 13:15:52 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id B06041C00A6; Fri,  6 Jun 2014 22:15:52 +0200 (CEST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250961>

From: Karsten Blees <blees@dcon.de>
Date: Fri, 7 Jan 2011 17:34:33 +0100

There are no proper inodes on Windows, so remove dirent.d_ino and #define
NO_D_INO_IN_DIRENT in the Makefile (this skips e.g. an ineffective qsort in
fsck.c).

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---
 compat/win32/dirent.h | 1 -
 config.mak.uname      | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/compat/win32/dirent.h b/compat/win32/dirent.h
index 927a25c..b38973b 100644
--- a/compat/win32/dirent.h
+++ b/compat/win32/dirent.h
@@ -9,7 +9,6 @@ typedef struct DIR DIR;
 #define DT_LNK     3
 
 struct dirent {
-	long d_ino;                      /* Always zero. */
 	char d_name[FILENAME_MAX];       /* File name. */
 	union {
 		unsigned short d_reclen; /* Always zero. */
diff --git a/config.mak.uname b/config.mak.uname
index 1ae675b..8131c81 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -354,6 +354,7 @@ ifeq ($(uname_S),Windows)
 	NO_POSIX_GOODIES = UnfortunatelyYes
 	NATIVE_CRLF = YesPlease
 	DEFAULT_HELP_FORMAT = html
+	NO_D_INO_IN_DIRENT = YesPlease
 
 	CC = compat/vcbuild/scripts/clink.pl
 	AR = compat/vcbuild/scripts/lib.pl
@@ -503,6 +504,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_INET_NTOP = YesPlease
 	NO_POSIX_GOODIES = UnfortunatelyYes
 	DEFAULT_HELP_FORMAT = html
+	NO_D_INO_IN_DIRENT = YesPlease
 	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -D_USE_32BIT_TIME_T -DNOGDI -Icompat -Icompat/win32
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/winansi.o \
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
