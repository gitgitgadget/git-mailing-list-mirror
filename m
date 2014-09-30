From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 03/14] MINGW: compat/mingw.h: drop fork() definition
Date: Tue, 30 Sep 2014 11:02:32 +0400
Message-ID: <1412060563-22041-4-git-send-email-marat@slonopotamus.org>
References: <1412060563-22041-1-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: marat@slonopotamus.org,
	msysGit <msysgit@googlegroups.com>
To: git@vger.kernel.org
X-From: msysgit+bncBCE7TAPITACRBKFLVGQQKGQEW7EKULQ@googlegroups.com Tue Sep 30 09:03:06 2014
Return-path: <msysgit+bncBCE7TAPITACRBKFLVGQQKGQEW7EKULQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ee0-f64.google.com ([74.125.83.64])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCE7TAPITACRBKFLVGQQKGQEW7EKULQ@googlegroups.com>)
	id 1XYrSj-0008Tl-BU
	for gcvm-msysgit@m.gmane.org; Tue, 30 Sep 2014 09:03:05 +0200
Received: by mail-ee0-f64.google.com with SMTP id d49sf648252eek.19
        for <gcvm-msysgit@m.gmane.org>; Tue, 30 Sep 2014 00:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=aWemKHR/2nfCQjjOAhUCzhRCInNVZ7PZKcQ9kPwEJA8=;
        b=Rb88/28pvNZ2NJDjdDFxU4xLS3gC7XIUbBbpMhab5765xo0MPLCPBkRIuU9ljvSJOh
         0JotFGTEmJtVUWJG8/ji6U/L6kZZpcyQCe2RNXPtyiGlSzp0IyldnLVZ4ry/zffwRRq7
         A+cTAzRhddJF+3WPWYWkk+yH9CeEsDEYjzq25PYSRRVEggvHKihXFNAP5lrkpY3SkZMZ
         G9b9IegeG7nnP2WNAdC9PcerOadzTkmn8zrxDWiwFagGZS58VoJxn17Qon8LcNU6qgVR
         AnxMZHDqZEMGbHIWhudjV8cDPgfM+4wBYr2pJnu4NDUJ7T34IbfkX3vleTMWgDQqFzAz
         55Ow==
X-Received: by 10.180.184.129 with SMTP id eu1mr17115wic.1.1412060585140;
        Tue, 30 Sep 2014 00:03:05 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.98.228 with SMTP id el4ls5135wib.38.gmail; Tue, 30 Sep
 2014 00:03:04 -0700 (PDT)
X-Received: by 10.180.87.228 with SMTP id bb4mr506955wib.3.1412060584651;
        Tue, 30 Sep 2014 00:03:04 -0700 (PDT)
Received: from slonopotamus.org ([94.242.204.247])
        by gmr-mx.google.com with ESMTPS id f9si494713wib.2.2014.09.30.00.03.04
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Sep 2014 00:03:04 -0700 (PDT)
Received-SPF: none (google.com: marat@slonopotamus.org does not designate permitted sender hosts) client-ip=94.242.204.247;
Received: from [185.6.245.138] (helo=radchenko-d-lnx.mail.msk)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1XYrSf-0004X0-Jq; Tue, 30 Sep 2014 11:03:02 +0400
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257650>

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
