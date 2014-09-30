From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 04/14] MINGW: do not fail at redefining pid_t on MinGW-W64
Date: Tue, 30 Sep 2014 11:02:33 +0400
Message-ID: <1412060563-22041-5-git-send-email-marat@slonopotamus.org>
References: <1412060563-22041-1-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: marat@slonopotamus.org,
	msysGit <msysgit@googlegroups.com>
To: git@vger.kernel.org
X-From: msysgit+bncBCE7TAPITACRBKVLVGQQKGQEVE6XEPY@googlegroups.com Tue Sep 30 09:03:07 2014
Return-path: <msysgit+bncBCE7TAPITACRBKVLVGQQKGQEVE6XEPY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ee0-f57.google.com ([74.125.83.57])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCE7TAPITACRBKVLVGQQKGQEVE6XEPY@googlegroups.com>)
	id 1XYrSk-0008UI-Tl
	for gcvm-msysgit@m.gmane.org; Tue, 30 Sep 2014 09:03:06 +0200
Received: by mail-ee0-f57.google.com with SMTP id c41sf223906eek.2
        for <gcvm-msysgit@m.gmane.org>; Tue, 30 Sep 2014 00:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=MVZFtxTWVxDzucPewvpf22luxePvbgKb5HnL9gkde3k=;
        b=RLoIP30hremuQoGqYA8FB3+UBNMmhFOtGDKu5YDQLIOt2VWYKz6gVqGy91UKy20nqR
         87k+apFtdMfQCDdfv8WxjuvN5y1G82w93HzMt317uXW2rqpOnX5vZ4cRmxrMH511uxVP
         Ieiljma330cOG8TTi/nzUE7rcuPetY6PvIw5VFB/KHrrzJZDurVlBBabx5zw/xWazMab
         DPu/omM0junZ6+hGK1qLtp7NVcxp8mHM6XlGuuM+0ypPAqlIuRsf7gMlTPXy8FHgfEoe
         RDgnZFVFiLwtzFTfytzbSNgDRC+m02TAzoOA5ZILlru2Z9u6onbSDrXaF1HDpXLTU6K/
         Xo0A==
X-Received: by 10.181.13.42 with SMTP id ev10mr17560wid.6.1412060586631;
        Tue, 30 Sep 2014 00:03:06 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.100.200 with SMTP id fa8ls615668wib.19.canary; Tue, 30 Sep
 2014 00:03:06 -0700 (PDT)
X-Received: by 10.194.57.237 with SMTP id l13mr1050wjq.7.1412060586143;
        Tue, 30 Sep 2014 00:03:06 -0700 (PDT)
Received: from slonopotamus.org ([94.242.204.247])
        by gmr-mx.google.com with ESMTPS id p7si515513wiz.1.2014.09.30.00.03.06
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Sep 2014 00:03:06 -0700 (PDT)
Received-SPF: none (google.com: marat@slonopotamus.org does not designate permitted sender hosts) client-ip=94.242.204.247;
Received: from [185.6.245.138] (helo=radchenko-d-lnx.mail.msk)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1XYrSi-0004X0-2w; Tue, 30 Sep 2014 11:03:04 +0400
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257651>

pid_t is available in sys/types.h on both MinGW and MinGW-W64

Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
Acked-by: Eric Faye-Lund <kusmabite@gmail.com>
---
 compat/mingw.h | 1 -
 compat/msvc.h  | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index 948a174..d113b19 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -5,7 +5,6 @@
  * things that are not available in header files
  */
 
-typedef int pid_t;
 typedef int uid_t;
 typedef int socklen_t;
 #define hstrerror strerror
diff --git a/compat/msvc.h b/compat/msvc.h
index 580bb55..a63d878 100644
--- a/compat/msvc.h
+++ b/compat/msvc.h
@@ -15,6 +15,8 @@
 #define strtoull     _strtoui64
 #define strtoll      _strtoi64
 
+typedef int pid_t;
+
 static __inline int strcasecmp (const char *s1, const char *s2)
 {
 	int size1 = strlen(s1);
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
