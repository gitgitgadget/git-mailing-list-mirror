From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 03/14] MINGW: compat/mingw.h: drop fork() definition
Date: Wed,  8 Oct 2014 22:00:56 +0400
Message-ID: <1412791267-13356-4-git-send-email-marat@slonopotamus.org>
References: <1412791267-13356-1-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: marat@slonopotamus.org,
	msysGit <msysgit@googlegroups.com>
To: git@vger.kernel.org
X-From: msysgit+bncBCE7TAPITACRB37X2WQQKGQEMICCUVA@googlegroups.com Wed Oct 08 20:01:20 2014
Return-path: <msysgit+bncBCE7TAPITACRB37X2WQQKGQEMICCUVA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f58.google.com ([74.125.82.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCE7TAPITACRB37X2WQQKGQEMICCUVA@googlegroups.com>)
	id 1XbvY8-0003VP-HI
	for gcvm-msysgit@m.gmane.org; Wed, 08 Oct 2014 20:01:20 +0200
Received: by mail-wg0-f58.google.com with SMTP id l18sf841853wgh.13
        for <gcvm-msysgit@m.gmane.org>; Wed, 08 Oct 2014 11:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=emUhJL53ATbP1ppfUBUTS0gZfCnTQczzkkZQiMGuKds=;
        b=PpXqRxiM6eV9E8N+osDS0I8xRoLO1y8emS8wRBO6/NaSCDhf9zTgHh7j5eV5hQE3+R
         1QpIqOJdUDpKsGCL1c8W0leIZD1TKt6ppv1xmiwBIlc6oUGQHwqXuBchOLvlSs7HmoQv
         yg9I0omZgjA90379FLb/STFhObR0h0phOjx3Hj05888wKBoegcsfBO90ydP1LgwBvF8c
         AqL6UTJMMXpCdt9KgXgCeJ9r3idJ1dVq0BPrMcXSoswkMwSuctHArFuFpjINt0uzqnsJ
         a5JGX3uKs2UqaraONi4S5JFwKuTBPQCU3oToSSezNYurv8yJfvb+90IiAwAM3PdwoJ9e
         6rAw==
X-Received: by 10.152.9.228 with SMTP id d4mr23358lab.27.1412791280258;
        Wed, 08 Oct 2014 11:01:20 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.234.233 with SMTP id uh9ls84651lac.70.gmail; Wed, 08 Oct
 2014 11:01:18 -0700 (PDT)
X-Received: by 10.152.29.130 with SMTP id k2mr1825812lah.3.1412791278895;
        Wed, 08 Oct 2014 11:01:18 -0700 (PDT)
Received: from slonopotamus.org ([94.242.204.247])
        by gmr-mx.google.com with ESMTPS id ca20si924884wib.3.2014.10.08.11.01.18
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Oct 2014 11:01:18 -0700 (PDT)
Received-SPF: none (google.com: marat@slonopotamus.org does not designate permitted sender hosts) client-ip=94.242.204.247;
Received: from [176.57.72.72] (helo=noblesse.home.ru)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1XbvY5-0003Rz-2K; Wed, 08 Oct 2014 22:01:17 +0400
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

fork() is not used in MinGW builds but causes a compiler warning
on x86_64 MinGW-W64: conflicting types for built-in function 'fork'

Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
Acked-by: Eric Faye-Lund <kusmabite@gmail.com>
---
 compat/mingw.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index 36a47cb..1ddd663 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -92,8 +92,6 @@ static inline int symlink(const char *oldpath, const char *newpath)
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
