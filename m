From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 14/14] MINGW: config.mak.uname: auto-detect MinGW
 build from compiler
Date: Tue, 30 Sep 2014 11:02:43 +0400
Message-ID: <1412060563-22041-15-git-send-email-marat@slonopotamus.org>
References: <1412060563-22041-1-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: marat@slonopotamus.org,
	msysGit <msysgit@googlegroups.com>
To: git@vger.kernel.org
X-From: msysgit+bncBCE7TAPITACRB3VQVGQQKGQEOHD4XKY@googlegroups.com Tue Sep 30 09:14:57 2014
Return-path: <msysgit+bncBCE7TAPITACRB3VQVGQQKGQEOHD4XKY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f63.google.com ([74.125.82.63])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCE7TAPITACRB3VQVGQQKGQEOHD4XKY@googlegroups.com>)
	id 1XYreC-0004in-As
	for gcvm-msysgit@m.gmane.org; Tue, 30 Sep 2014 09:14:56 +0200
Received: by mail-wg0-f63.google.com with SMTP id n12sf1117397wgh.28
        for <gcvm-msysgit@m.gmane.org>; Tue, 30 Sep 2014 00:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=dYtcQObGy84xVK2waYQWNrprbK/X+N3sBNKedgm1mws=;
        b=VQPB83BV7Mlf/Er3aifdDj84yDbGpvK9OErCbjG0U9oqdV5eNn/H3UZYMF/ow5Jfqf
         DSHVJZmq9kgfjVdQCcSTSNSNeQ/1f6QGYjaVwq7iYH6Olv8efgmKJ9fkT/w73sl+vBar
         70xa0pxVtA1sM93LqlXOfZU5nUNLGtstJ+/ZHjLKRHGKDqpg2dZl1VaYDMIwrU4jpHoG
         DHBNfIqZuxIwuTj+G+fsVOXHp6uDPm48Rlir2Bjrg28CXIZ6UokrmCDHl61bnerEIYI9
         dZEGr+3s4WKLGvD9aIIzezee4EVBT7EfCDJCfgq67YmoFKQ+OGWBLmJWsB0/hgEXd+sX
         oYZA==
X-Received: by 10.152.36.71 with SMTP id o7mr2530laj.29.1412061296047;
        Tue, 30 Sep 2014 00:14:56 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.28.39 with SMTP id y7ls6265lag.0.gmail; Tue, 30 Sep 2014
 00:14:54 -0700 (PDT)
X-Received: by 10.112.182.8 with SMTP id ea8mr1278408lbc.11.1412061294239;
        Tue, 30 Sep 2014 00:14:54 -0700 (PDT)
Received: from slonopotamus.org ([94.242.204.247])
        by gmr-mx.google.com with ESMTPS id n6si743827wiv.0.2014.09.30.00.14.54
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Sep 2014 00:14:54 -0700 (PDT)
Received-SPF: none (google.com: marat@slonopotamus.org does not designate permitted sender hosts) client-ip=94.242.204.247;
Received: from [185.6.245.138] (helo=radchenko-d-lnx.mail.msk)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1XYrSx-0004X0-Aw; Tue, 30 Sep 2014 11:03:19 +0400
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1412060563-22041-1-git-send-email-marat@slonopotamus.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257657>

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
