From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 03/14] MINGW: compat/mingw.h: drop fork() definition
Date: Sun, 28 Sep 2014 17:24:19 +0400
Message-ID: <1411910670-31285-4-git-send-email-marat@slonopotamus.org>
References: <1411910670-31285-1-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: marat@slonopotamus.org,
	msysGit <msysgit@googlegroups.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: msysgit+bncBCE7TAPITACRBYUYUCQQKGQEU2OSEHQ@googlegroups.com Sun Sep 28 15:25:56 2014
Return-path: <msysgit+bncBCE7TAPITACRBYUYUCQQKGQEU2OSEHQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f185.google.com ([209.85.212.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCE7TAPITACRBYUYUCQQKGQEU2OSEHQ@googlegroups.com>)
	id 1XYEU8-0000Bq-4v
	for gcvm-msysgit@m.gmane.org; Sun, 28 Sep 2014 15:25:56 +0200
Received: by mail-wi0-f185.google.com with SMTP id cc10sf27927wib.12
        for <gcvm-msysgit@m.gmane.org>; Sun, 28 Sep 2014 06:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=aWemKHR/2nfCQjjOAhUCzhRCInNVZ7PZKcQ9kPwEJA8=;
        b=XfyRQQOPUhQ3rA3QNBMix4d56cLdVdUqyu2lwmLjiPZaONLhJwYZ95vTMzHHkGPFNS
         nwT+59qk2YonZzESyhhARMf+gP+42QMn9OoDHHZP5xYbbWJv1cH+p7FOzO8k/mMEjsA9
         Y5Pad9/Obj1LVVNDQQ2kIw8/JY9Im3aOLAa3JgeD4iaj0S30X0+DgCaQU/E1LNQdvEYv
         b9Bc7izLNbhvOWAArSyKXOTCpFJ3vRejvnbu69fNp5Rfi8StwM5yG/F93FNYq9/B1ZBR
         92ddZQDFra07YzqHmfJAvgK5Sriup5lj8qqvwGiEyhIuPH/DGdxt7+PsbYGqBs+8wqRT
         7QOQ==
X-Received: by 10.152.19.226 with SMTP id i2mr31558lae.5.1411910755908;
        Sun, 28 Sep 2014 06:25:55 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.30.70 with SMTP id q6ls530536lah.62.gmail; Sun, 28 Sep
 2014 06:25:53 -0700 (PDT)
X-Received: by 10.112.131.33 with SMTP id oj1mr4893843lbb.7.1411910753470;
        Sun, 28 Sep 2014 06:25:53 -0700 (PDT)
Received: from slonopotamus.org ([94.242.204.247])
        by gmr-mx.google.com with ESMTPS id h1si447262wib.0.2014.09.28.06.25.53
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Sep 2014 06:25:53 -0700 (PDT)
Received-SPF: none (google.com: marat@slonopotamus.org does not designate permitted sender hosts) client-ip=94.242.204.247;
Received: from [176.57.72.72] (helo=noblesse.home.ru)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1XYEU2-0000Yl-DI; Sun, 28 Sep 2014 17:25:50 +0400
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257600>

fork() is not used in MinGW builds but causes a compiler warning
on x86_64 MinGW-W64: conflicting types for built-in function 'fork'

Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
Acked-by: Eric Faye-Lund <kusmabite@gmail.com>
---
 compat/mingw.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index ed79368..948a174 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -93,8 +93,6 @@ static inline int symlink(const char *oldpath, const char *newpath)
 { errno = ENOSYS; return -1; }
 static inline int fchmod(int fildes, mode_t mode)
 { errno = ENOSYS; return -1; }
-static inline pid_t fork(void)
-{ errno = ENOSYS; return -1; }
 static inline unsigned int alarm(unsigned int seconds)
 { return 0; }
 static inline int fsync(int fd)
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
