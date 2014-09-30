From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 05/14] MINGW: config.mak.uname: allow using cURL for
 non-msysGit builds
Date: Tue, 30 Sep 2014 11:02:34 +0400
Message-ID: <1412060563-22041-6-git-send-email-marat@slonopotamus.org>
References: <1412060563-22041-1-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: marat@slonopotamus.org,
	msysGit <msysgit@googlegroups.com>
To: git@vger.kernel.org
X-From: msysgit+bncBCE7TAPITACRBK5LVGQQKGQEU3CGM7Q@googlegroups.com Tue Sep 30 09:03:09 2014
Return-path: <msysgit+bncBCE7TAPITACRBK5LVGQQKGQEU3CGM7Q@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f184.google.com ([209.85.217.184])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCE7TAPITACRBK5LVGQQKGQEU3CGM7Q@googlegroups.com>)
	id 1XYrSm-0008V9-N6
	for gcvm-msysgit@m.gmane.org; Tue, 30 Sep 2014 09:03:08 +0200
Received: by mail-lb0-f184.google.com with SMTP id p9sf318242lbv.1
        for <gcvm-msysgit@m.gmane.org>; Tue, 30 Sep 2014 00:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=X0V3TlCuclkvKuhux3WmqCE1/sjyeMyaOhBAyjmzr68=;
        b=IMqUNu3YTG51B+49/7H5EMVZe4/gW8fmqDl2C6EqlwzOIt0NllIa3NA02PmV8GYWnB
         VDyLFd5Lux5Q6iGiIcJLLIH5Djh70GIYVJFqgrar3cRTNQtMo/gUkdtZxOg+R8vXeWUw
         RoHj6sq3A+3/kbTzaN/2spB7Vn4ikBYcmSU89Agxdgu1uA9soGX7aXurSIG/Mm+PfPRb
         sOOOqys8ntWbfcBwzeNU44QHAGrEn+MthjgWBEyd2o2unPOkAHalgFzqdMyShq+RtlFu
         Tqmb/ENwZI/pXELotTCHmGFG+yGdRi9ayvCwjadiWC1SwT5JtH4GFlYoAt/BiScq/Gg4
         XPLQ==
X-Received: by 10.181.11.225 with SMTP id el1mr18009wid.14.1412060587670;
        Tue, 30 Sep 2014 00:03:07 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.14.106 with SMTP id o10ls6586wic.13.gmail; Tue, 30 Sep
 2014 00:03:07 -0700 (PDT)
X-Received: by 10.194.179.196 with SMTP id di4mr5595573wjc.0.1412060587230;
        Tue, 30 Sep 2014 00:03:07 -0700 (PDT)
Received: from slonopotamus.org ([94.242.204.247])
        by gmr-mx.google.com with ESMTPS id p7si515515wiz.1.2014.09.30.00.03.07
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Sep 2014 00:03:07 -0700 (PDT)
Received-SPF: none (google.com: marat@slonopotamus.org does not designate permitted sender hosts) client-ip=94.242.204.247;
Received: from [185.6.245.138] (helo=radchenko-d-lnx.mail.msk)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1XYrSj-0004X0-Pk; Tue, 30 Sep 2014 11:03:06 +0400
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257652>

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
