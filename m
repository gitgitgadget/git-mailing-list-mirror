From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 14/14] MINGW: config.mak.uname: auto-detect MinGW
 build from compiler
Date: Sun, 28 Sep 2014 17:24:30 +0400
Message-ID: <1411910670-31285-15-git-send-email-marat@slonopotamus.org>
References: <1411910670-31285-1-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: marat@slonopotamus.org,
	msysGit <msysgit@googlegroups.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: msysgit+bncBCE7TAPITACRBUU2UCQQKGQEUIIVVLQ@googlegroups.com Sun Sep 28 15:29:56 2014
Return-path: <msysgit+bncBCE7TAPITACRBUU2UCQQKGQEUIIVVLQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f191.google.com ([209.85.217.191])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCE7TAPITACRBUU2UCQQKGQEUIIVVLQ@googlegroups.com>)
	id 1XYEXy-0001XN-J6
	for gcvm-msysgit@m.gmane.org; Sun, 28 Sep 2014 15:29:54 +0200
Received: by mail-lb0-f191.google.com with SMTP id b6sf110807lbj.28
        for <gcvm-msysgit@m.gmane.org>; Sun, 28 Sep 2014 06:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=dYtcQObGy84xVK2waYQWNrprbK/X+N3sBNKedgm1mws=;
        b=jUow4IjpFoE1XmHtW0E6NM1ZL4v28tKoGDFgHx40BbDryrFzrcweMd/OsirXVB4LPP
         DT+W+RglRXNTTtKr83g4Hp3LjTh4pf97RPvrvk98kzbObayQWKR7GRHTab3zV7lZzcdN
         7NS2vR76b2srHcAmJBh2ixukzsivXyQk4BuGg4RCJVbBAN5JjP5uhCmKkDtwXoMfHMNH
         zh40U8VhEDitduc7FiVJpxRrW8/vUcOTbBEhg/mpkCEg5/RcUhPJ9NwDSIYJyDZJRGq2
         by0Ty0cb4DwbSxwqgUSAaMg7lLrfaWu5f0877jurWv5K5SmU36//zfgTWNrakxGsed91
         jZuQ==
X-Received: by 10.180.76.41 with SMTP id h9mr217227wiw.9.1411910994372;
        Sun, 28 Sep 2014 06:29:54 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.211.42 with SMTP id mz10ls360967wic.35.gmail; Sun, 28 Sep
 2014 06:29:53 -0700 (PDT)
X-Received: by 10.180.106.197 with SMTP id gw5mr961490wib.1.1411910993774;
        Sun, 28 Sep 2014 06:29:53 -0700 (PDT)
Received: from slonopotamus.org ([94.242.204.247])
        by gmr-mx.google.com with ESMTPS id n6si426154wiv.0.2014.09.28.06.29.53
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Sep 2014 06:29:53 -0700 (PDT)
Received-SPF: none (google.com: marat@slonopotamus.org does not designate permitted sender hosts) client-ip=94.242.204.247;
Received: from [176.57.72.72] (helo=noblesse.home.ru)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1XYEUE-0000Yl-CJ; Sun, 28 Sep 2014 17:26:02 +0400
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257607>

When crosscompiling, one cannot rely on `uname` from host system.

Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
---
 config.mak.uname | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index 9f7037e..182da50 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -14,6 +14,11 @@ ifdef MSVC
 	uname_O := Windows
 endif
 
+ifneq (,$(findstring mingw,$(CC_MACH)))
+	uname_S := MINGW
+	uname_O := MINGW
+endif
+
 # We choose to avoid "if .. else if .. else .. endif endif"
 # because maintaining the nesting to match is a pain.  If
 # we had "elif" things would have been much nicer...
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
