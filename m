From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 07/14] Fix BASIC_LDFLAGS and COMPAT_CFLAGS for 64bit MinGW-w64
Date: Sun, 28 Sep 2014 17:24:23 +0400
Message-ID: <1411910670-31285-8-git-send-email-marat@slonopotamus.org>
References: <1411910670-31285-1-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: marat@slonopotamus.org,
	msysGit <msysgit@googlegroups.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ray Donnelly <mingw.android@gmail.com>
To: git@vger.kernel.org
X-From: msysgit+bncBCE7TAPITACRBZMYUCQQKGQE6WFH2ZY@googlegroups.com Sun Sep 28 15:25:58 2014
Return-path: <msysgit+bncBCE7TAPITACRBZMYUCQQKGQE6WFH2ZY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f189.google.com ([74.125.82.189])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCE7TAPITACRBZMYUCQQKGQE6WFH2ZY@googlegroups.com>)
	id 1XYEUA-0000D7-46
	for gcvm-msysgit@m.gmane.org; Sun, 28 Sep 2014 15:25:58 +0200
Received: by mail-we0-f189.google.com with SMTP id q58sf251992wes.16
        for <gcvm-msysgit@m.gmane.org>; Sun, 28 Sep 2014 06:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=ZuLoIAuMpbiwe37m517MEPJYKxEaQjh4Xtwnvp0nEtc=;
        b=fOfOGTWWii3yi2ocHW2oFDf3E7C4wlZQluFEfBbQNSc/gfccGyajaXnVeig8HJQqzj
         drgo3vNNLvG1Wj1ILVvUuuo6ZUm7yXDRIXPKkqcOKy5k9BjhFRSJgm839nS6l6mASHtl
         4SBgkSHbMS9COf2n/QWOrdICgKmr8NPVyWZJH/s0Wnnz3XnB/VXB/EexDGJOmgGVTYmQ
         X9+4iApnXvUTMBJcltQHN5fQtn25+wiU11pG/2niGFxvEM9tKgq0O9gHUMTii2oQmEev
         yy238YQOjBrxM1kObUtZaUg7FTxzLGxl+F7ik3LK+8kbeLweLLfK/ldQn6KyXduHOV7v
         qy+g==
X-Received: by 10.180.85.6 with SMTP id d6mr217004wiz.6.1411910757862;
        Sun, 28 Sep 2014 06:25:57 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.19.99 with SMTP id d3ls357758wie.41.canary; Sun, 28 Sep
 2014 06:25:57 -0700 (PDT)
X-Received: by 10.180.24.72 with SMTP id s8mr1322711wif.1.1411910757182;
        Sun, 28 Sep 2014 06:25:57 -0700 (PDT)
Received: from slonopotamus.org ([94.242.204.247])
        by gmr-mx.google.com with ESMTPS id cd14si178029wib.1.2014.09.28.06.25.57
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Sep 2014 06:25:57 -0700 (PDT)
Received-SPF: none (google.com: marat@slonopotamus.org does not designate permitted sender hosts) client-ip=94.242.204.247;
Received: from [176.57.72.72] (helo=noblesse.home.ru)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1XYEU6-0000Yl-W5; Sun, 28 Sep 2014 17:25:55 +0400
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1411910670-31285-1-git-send-email-marat@slonopotamus.org>
X-Original-Sender: marat@slonopotamus.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: marat@slonopotamus.org does not designate permitted sender
 hosts) smtp.mail=marat@slonopotamus.org
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257603>

From: Ray Donnelly <mingw.android@gmail.com>

Signed-off-by: Ray Donnelly <mingw.android@gmail.com>
Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
---
 config.mak.uname | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index 324a7fc..4470a928 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -6,6 +6,7 @@ uname_O := $(shell sh -c 'uname -o 2>/dev/null || echo not')
 uname_R := $(shell sh -c 'uname -r 2>/dev/null || echo not')
 uname_P := $(shell sh -c 'uname -p 2>/dev/null || echo not')
 uname_V := $(shell sh -c 'uname -v 2>/dev/null || echo not')
+CC_MACH := $(shell sh -c '$(CC) -dumpmachine 2>/dev/null || echo not')
 
 ifdef MSVC
 	# avoid the MingW and Cygwin configuration sections
@@ -509,12 +510,15 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_POSIX_GOODIES = UnfortunatelyYes
 	DEFAULT_HELP_FORMAT = html
 	NO_D_INO_IN_DIRENT = YesPlease
-	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -D_USE_32BIT_TIME_T -DNOGDI -Icompat -Icompat/win32
+	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/win32
+	ifneq (,$(findstring i686,$(CC_MACH)))
+		COMPAT_CFLAGS += -D_USE_32BIT_TIME_T
+		BASIC_LDFLAGS += -Wl,--large-address-aware
+	endif
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/winansi.o \
 		compat/win32/pthread.o compat/win32/syslog.o \
 		compat/win32/dirent.o
-	BASIC_LDFLAGS += -Wl,--large-address-aware
 	EXTLIBS += -lws2_32
 	GITLIBS += git.res
 	PTHREAD_LIBS =
-- 
2.1.1

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
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
