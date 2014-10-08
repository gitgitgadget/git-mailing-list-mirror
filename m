From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 05/14] MINGW: config.mak.uname: allow using cURL for
 non-msysGit builds
Date: Wed,  8 Oct 2014 22:00:58 +0400
Message-ID: <1412791267-13356-6-git-send-email-marat@slonopotamus.org>
References: <1412791267-13356-1-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: marat@slonopotamus.org,
	msysGit <msysgit@googlegroups.com>
To: git@vger.kernel.org
X-From: msysgit+bncBCE7TAPITACRB4PX2WQQKGQENXYKY2I@googlegroups.com Wed Oct 08 20:01:22 2014
Return-path: <msysgit+bncBCE7TAPITACRB4PX2WQQKGQENXYKY2I@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f56.google.com ([74.125.82.56])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCE7TAPITACRB4PX2WQQKGQENXYKY2I@googlegroups.com>)
	id 1XbvYA-0003WR-B4
	for gcvm-msysgit@m.gmane.org; Wed, 08 Oct 2014 20:01:22 +0200
Received: by mail-wg0-f56.google.com with SMTP id y10sf783144wgg.1
        for <gcvm-msysgit@m.gmane.org>; Wed, 08 Oct 2014 11:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=X0V3TlCuclkvKuhux3WmqCE1/sjyeMyaOhBAyjmzr68=;
        b=WJUYxSc88CJHcyNUVN7cloN94y1d/y7l/RxPEB2HY6uasj3nZL/eZdmfUULdBndv0w
         5aSuzP2VYElkWzx7OgrF8KUUtYTLf0WsGgmCcz89Zdz3MGPyJkGQCz/N1UgW6UY/06E6
         le2OKsZ+nDPcNcx6xT3TmIrhTXdiHwDeIhV9L+yiD6A28R0GvRghYYomdjauO2rRb0vF
         gnUAKLlJSluiGqOi0PgsSjellVstlFSgj4FUM55y86WR6x20gxbj+zDWbMBmnLKxBycG
         2BUxklEMaDIZfd7e4/xGVzcW+BSBjFGsgED5DDzb09OV2ZsEPZET++m5Qg2rr3BgjaOR
         jXgA==
X-Received: by 10.180.228.74 with SMTP id sg10mr72366wic.4.1412791282089;
        Wed, 08 Oct 2014 11:01:22 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.88.170 with SMTP id bh10ls139125wib.19.gmail; Wed, 08 Oct
 2014 11:01:21 -0700 (PDT)
X-Received: by 10.180.160.169 with SMTP id xl9mr4740006wib.7.1412791281512;
        Wed, 08 Oct 2014 11:01:21 -0700 (PDT)
Received: from slonopotamus.org ([94.242.204.247])
        by gmr-mx.google.com with ESMTPS id ed3si931426wib.1.2014.10.08.11.01.21
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Oct 2014 11:01:21 -0700 (PDT)
Received-SPF: none (google.com: marat@slonopotamus.org does not designate permitted sender hosts) client-ip=94.242.204.247;
Received: from [176.57.72.72] (helo=noblesse.home.ru)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1XbvY7-0003Rz-1t; Wed, 08 Oct 2014 22:01:19 +0400
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
