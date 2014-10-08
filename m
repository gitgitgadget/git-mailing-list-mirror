From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 14/14] MINGW: config.mak.uname: auto-detect MinGW
 build from compiler
Date: Wed,  8 Oct 2014 22:01:07 +0400
Message-ID: <1412791267-13356-15-git-send-email-marat@slonopotamus.org>
References: <1412791267-13356-1-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: marat@slonopotamus.org,
	msysGit <msysgit@googlegroups.com>
To: git@vger.kernel.org
X-From: msysgit+bncBCE7TAPITACRBH762WQQKGQEGUUZ54I@googlegroups.com Wed Oct 08 20:14:56 2014
Return-path: <msysgit+bncBCE7TAPITACRBH762WQQKGQEGUUZ54I@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f185.google.com ([209.85.217.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCE7TAPITACRBH762WQQKGQEGUUZ54I@googlegroups.com>)
	id 1XbvlH-0001Kk-Si
	for gcvm-msysgit@m.gmane.org; Wed, 08 Oct 2014 20:14:55 +0200
Received: by mail-lb0-f185.google.com with SMTP id u10sf818981lbd.22
        for <gcvm-msysgit@m.gmane.org>; Wed, 08 Oct 2014 11:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=dYtcQObGy84xVK2waYQWNrprbK/X+N3sBNKedgm1mws=;
        b=KAL3sDijvllokpkNJrIADuzGr4DdZRIOKhZ9DK15D6W10VKIXvB1pGzAZd9eRjp7mX
         PLEsz+z1tBP74f/QWGmPfGhCFqfIoRrFcfTId+4p9OnRP93CviRQrcbih7M5YPa0i+KI
         Qh4n1HrQ40yfYH6Gmcqgpl/zxeA8r+0+uQRJJ2SKV3Jk82ThmV+emiGkcZjBrJfBlFtw
         WGD1Ef3ux9OUSe56zq0jY+53p95iIMq/qR6v6niAJ53jd75UzJkgyAimNnaVlJOpLZR5
         6fHVO0IDuh1Xb2PhmIdWcAaf9p7qzL2m5z1IxdZzeVo1+nM5fp30zc7s/UWGfdH5dTKo
         NOyw==
X-Received: by 10.180.91.49 with SMTP id cb17mr71743wib.14.1412792095688;
        Wed, 08 Oct 2014 11:14:55 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.86.132 with SMTP id p4ls138080wiz.23.gmail; Wed, 08 Oct
 2014 11:14:55 -0700 (PDT)
X-Received: by 10.180.85.8 with SMTP id d8mr1803453wiz.0.1412792095042;
        Wed, 08 Oct 2014 11:14:55 -0700 (PDT)
Received: from slonopotamus.org ([94.242.204.247])
        by gmr-mx.google.com with ESMTPS id us10si125695lbc.1.2014.10.08.11.14.54
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Oct 2014 11:14:54 -0700 (PDT)
Received-SPF: none (google.com: marat@slonopotamus.org does not designate permitted sender hosts) client-ip=94.242.204.247;
Received: from [176.57.72.72] (helo=noblesse.home.ru)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1XbvYJ-0003Rz-8V; Wed, 08 Oct 2014 22:01:31 +0400
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1412791267-13356-1-git-send-email-marat@slonopotamus.org>
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
