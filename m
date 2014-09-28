From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 09/14] MINGW: config.mak.uname: reorganize MinGW settings
Date: Sun, 28 Sep 2014 17:24:25 +0400
Message-ID: <1411910670-31285-10-git-send-email-marat@slonopotamus.org>
References: <1411910670-31285-1-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: marat@slonopotamus.org,
	msysGit <msysgit@googlegroups.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: msysgit+bncBCE7TAPITACRBZ4YUCQQKGQEKNJIGHA@googlegroups.com Sun Sep 28 15:26:01 2014
Return-path: <msysgit+bncBCE7TAPITACRBZ4YUCQQKGQEKNJIGHA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ee0-f57.google.com ([74.125.83.57])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCE7TAPITACRBZ4YUCQQKGQEKNJIGHA@googlegroups.com>)
	id 1XYEUD-0000Fz-Q1
	for gcvm-msysgit@m.gmane.org; Sun, 28 Sep 2014 15:26:01 +0200
Received: by mail-ee0-f57.google.com with SMTP id e53sf63067eek.22
        for <gcvm-msysgit@m.gmane.org>; Sun, 28 Sep 2014 06:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=2fFhoLmslgzLuVFWWmiCBWvDIU5qgtccmcd6ttHeReA=;
        b=y3QZ62JVbh9ohY3iWAi4ape7mpHaRhbKQHSeckuwtBTuUISr8b9ZfByAlj1b/YeMdR
         sSHsCLt234EPKXHDnLuX9MvSZay/oX27RtgpNxdl1mnKBggaGZcSAtsPOm3DqHlmYmHr
         AqL36OtSVIftIHinvYdezh6CKnZsnF/bGH0KHftCmzfPi0WIwM3GQe/BlkbRS1Syp8RX
         WPqc92FOp/EDT5g+ijOkCpZx7HVR7dTf/SqxvAMs7uHALzYSpLgeA4jXlL22rH2NfViH
         KjTJV66iZPCuZy0iLI5nDRTfbw5SO8Y3H+/hZT7OEYOFzdBPHWx5/yGJElpM3y/RGT9x
         1vCQ==
X-Received: by 10.152.28.66 with SMTP id z2mr651054lag.3.1411910761540;
        Sun, 28 Sep 2014 06:26:01 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.23.227 with SMTP id p3ls329336laf.39.gmail; Sun, 28 Sep
 2014 06:25:59 -0700 (PDT)
X-Received: by 10.152.2.97 with SMTP id 1mr293936lat.6.1411910759037;
        Sun, 28 Sep 2014 06:25:59 -0700 (PDT)
Received: from slonopotamus.org ([94.242.204.247])
        by gmr-mx.google.com with ESMTPS id i6si429251wiy.0.2014.09.28.06.25.58
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Sep 2014 06:25:59 -0700 (PDT)
Received-SPF: none (google.com: marat@slonopotamus.org does not designate permitted sender hosts) client-ip=94.242.204.247;
Received: from [176.57.72.72] (helo=noblesse.home.ru)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1XYEU8-0000Yl-Uh; Sun, 28 Sep 2014 17:25:57 +0400
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257604>

HAVE_LIBCHARSET_H and NO_R_TO_GCC_LINKER are not specific to
msysGit, they're general MinGW settings.

Logic behind HAVE_LIBCHARSET_H: if user is on MinGW and has iconv,
we expect him to have libcharset.h. If user doesn't have iconv,
he has to explicitly say so via NO_ICONV=1 regardless of this
commit.

Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
---
 config.mak.uname | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index c7aaa1c..f79c0e0 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -532,11 +532,11 @@ ifneq (,$(wildcard ../THIS_IS_MSYSGIT))
 	prefix =
 	INSTALL = /bin/install
 	EXTLIBS += /mingw/lib/libz.a
-	NO_R_TO_GCC_LINKER = YesPlease
 	INTERNAL_QSORT = YesPlease
-	HAVE_LIBCHARSET_H = YesPlease
 	NO_GETTEXT = YesPlease
 endif
+	HAVE_LIBCHARSET_H = YesPlease
+	NO_R_TO_GCC_LINKER = YesPlease
 endif
 ifeq ($(uname_S),QNX)
 	COMPAT_CFLAGS += -DSA_RESTART=0
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
