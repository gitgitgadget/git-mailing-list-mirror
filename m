From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 06/14] MINGW: compat/winansi.c: do not redefine CONSOLE_FONT_INFOEX
Date: Sun, 28 Sep 2014 17:24:22 +0400
Message-ID: <1411910670-31285-7-git-send-email-marat@slonopotamus.org>
References: <1411910670-31285-1-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: marat@slonopotamus.org,
	msysGit <msysgit@googlegroups.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: msysgit+bncBCE7TAPITACRBZEYUCQQKGQECMOYBBI@googlegroups.com Sun Sep 28 15:26:04 2014
Return-path: <msysgit+bncBCE7TAPITACRBZEYUCQQKGQECMOYBBI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f55.google.com ([209.85.215.55])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCE7TAPITACRBZEYUCQQKGQECMOYBBI@googlegroups.com>)
	id 1XYEUA-0000D8-33
	for gcvm-msysgit@m.gmane.org; Sun, 28 Sep 2014 15:25:58 +0200
Received: by mail-la0-f55.google.com with SMTP id hz20sf13989lab.20
        for <gcvm-msysgit@m.gmane.org>; Sun, 28 Sep 2014 06:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=y068VDQxBHfjSpMhdq4zkTYsXSDXWPD25LFXsrRH1FU=;
        b=VyNPF1SEIzJohRVyLdMuKemIcvzFQqmPk9vK9yqsJ4p6wKX99zOq71yb+5bfp29r7/
         C+0aBbA+aU7VmSw+6G8GsfL+MhcVbIONiNvsIChhnmyxsI+7vEP2inxwucio2xw3oK52
         zS3h9FJtRZ4Wk6ofLKGFEwAb0oCExr1kIp+u25+c703YlOADUxFfpOXX/zyWyxx78/98
         x5JWe06K0igw++Vm1A0ogTupw87tOix/IJqzQiKuNJIOuZZg/P0VHWNs1hvzTwOHbL0P
         mOcJ+dMwITozBy6ldXaBo/aQv0dA/tLD3Fd6a8+7x1WKiRG2B/XqwkYizdO41EaHSetF
         DTJA==
X-Received: by 10.152.19.226 with SMTP id i2mr31568lae.5.1411910757856;
        Sun, 28 Sep 2014 06:25:57 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.7.141 with SMTP id j13ls550878laa.5.gmail; Sun, 28 Sep
 2014 06:25:56 -0700 (PDT)
X-Received: by 10.112.76.229 with SMTP id n5mr337077lbw.8.1411910756079;
        Sun, 28 Sep 2014 06:25:56 -0700 (PDT)
Received: from slonopotamus.org ([94.242.204.247])
        by gmr-mx.google.com with ESMTPS id n6si425823wiv.0.2014.09.28.06.25.56
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Sep 2014 06:25:56 -0700 (PDT)
Received-SPF: none (google.com: marat@slonopotamus.org does not designate permitted sender hosts) client-ip=94.242.204.247;
Received: from [176.57.72.72] (helo=noblesse.home.ru)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1XYEU6-0000Yl-0V; Sun, 28 Sep 2014 17:25:54 +0400
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257606>

Unlike MinGW, MinGW-W64 has CONSOLE_FONT_INFOEX already properly defined
in wincon.h.

Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
---
 compat/winansi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/winansi.c b/compat/winansi.c
index efc5bb3..0ac3297 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -22,7 +22,7 @@ static int non_ascii_used = 0;
 static HANDLE hthread, hread, hwrite;
 static HANDLE hconsole1, hconsole2;
 
-#ifdef __MINGW32__
+#if defined(__MINGW32__) && !defined(__MINGW64_VERSION_MAJOR)
 typedef struct _CONSOLE_FONT_INFOEX {
 	ULONG cbSize;
 	DWORD nFont;
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
