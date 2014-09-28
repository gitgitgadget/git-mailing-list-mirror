From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 05/14] MINGW: config.mak.uname: allow using cURL for
 non-msysGit builds
Date: Sun, 28 Sep 2014 17:24:21 +0400
Message-ID: <1411910670-31285-6-git-send-email-marat@slonopotamus.org>
References: <1411910670-31285-1-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: marat@slonopotamus.org,
	msysGit <msysgit@googlegroups.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: msysgit+bncBCE7TAPITACRBY4YUCQQKGQE6HGORGA@googlegroups.com Sun Sep 28 15:25:58 2014
Return-path: <msysgit+bncBCE7TAPITACRBY4YUCQQKGQE6HGORGA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f192.google.com ([209.85.212.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCE7TAPITACRBY4YUCQQKGQE6HGORGA@googlegroups.com>)
	id 1XYEU9-0000D3-KD
	for gcvm-msysgit@m.gmane.org; Sun, 28 Sep 2014 15:25:57 +0200
Received: by mail-wi0-f192.google.com with SMTP id ex7sf135606wid.29
        for <gcvm-msysgit@m.gmane.org>; Sun, 28 Sep 2014 06:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=X0V3TlCuclkvKuhux3WmqCE1/sjyeMyaOhBAyjmzr68=;
        b=J8c+mVJs/AQO7mZeKtimVAGaAiX6UngHvTExXl1eBHPtpVShSNh6mk6EvJskdsol+y
         QbHLGrUdnnd8ucObHoOiMDKkOo1j8s92vBZa/OMiKHmjVbgEdTPGTZkon/F8+L8NN5S8
         pxK9W+XlIRqAGbURp4pyR0RjF8RCz5fstLNZfbMMZD+aoX2IrWUTcYpJcNi0S++Laver
         NQKaqdndvvT9sgMc0IN7E1N6ATDtQoPRhVfKQOmGMENVnVK8B21jgAk4+nplbKJbKCvQ
         G7IfGrZa9ex/kf2/K7gFpCCzX/YIqofvw1fcIepSBY2oZwSta5yrnP/bsOhaAs70d242
         ltVw==
X-Received: by 10.152.20.195 with SMTP id p3mr622000lae.1.1411910757343;
        Sun, 28 Sep 2014 06:25:57 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.2.194 with SMTP id 2ls543215law.108.gmail; Sun, 28 Sep
 2014 06:25:55 -0700 (PDT)
X-Received: by 10.112.131.33 with SMTP id oj1mr4893856lbb.7.1411910755180;
        Sun, 28 Sep 2014 06:25:55 -0700 (PDT)
Received: from slonopotamus.org ([94.242.204.247])
        by gmr-mx.google.com with ESMTPS id ca20si412033wib.3.2014.09.28.06.25.55
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Sep 2014 06:25:55 -0700 (PDT)
Received-SPF: none (google.com: marat@slonopotamus.org does not designate permitted sender hosts) client-ip=94.242.204.247;
Received: from [176.57.72.72] (helo=noblesse.home.ru)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1XYEU5-0000Yl-2H; Sun, 28 Sep 2014 17:25:53 +0400
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257601>

Is it absolutely valid and possible to have cURL in generic
MinGW environment. Building Git without cURL is still possible
by passing NO_CURL=1

Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
Acked-by: Eric Faye-Lund <kusmabite@gmail.com>
---
 config.mak.uname | 2 --
 1 file changed, 2 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index 20cbdcf..324a7fc 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -531,8 +531,6 @@ ifneq (,$(wildcard ../THIS_IS_MSYSGIT))
 	INTERNAL_QSORT = YesPlease
 	HAVE_LIBCHARSET_H = YesPlease
 	NO_GETTEXT = YesPlease
-else
-	NO_CURL = YesPlease
 endif
 endif
 ifeq ($(uname_S),QNX)
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
