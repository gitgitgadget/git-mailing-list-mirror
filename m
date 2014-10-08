From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 04/14] MINGW: do not fail at redefining pid_t on MinGW-W64
Date: Wed,  8 Oct 2014 22:00:57 +0400
Message-ID: <1412791267-13356-5-git-send-email-marat@slonopotamus.org>
References: <1412791267-13356-1-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: marat@slonopotamus.org,
	msysGit <msysgit@googlegroups.com>
To: git@vger.kernel.org
X-From: msysgit+bncBCE7TAPITACRB4HX2WQQKGQE75V42AQ@googlegroups.com Wed Oct 08 20:01:22 2014
Return-path: <msysgit+bncBCE7TAPITACRB4HX2WQQKGQE75V42AQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f58.google.com ([74.125.82.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCE7TAPITACRB4HX2WQQKGQE75V42AQ@googlegroups.com>)
	id 1XbvYA-0003WQ-0E
	for gcvm-msysgit@m.gmane.org; Wed, 08 Oct 2014 20:01:22 +0200
Received: by mail-wg0-f58.google.com with SMTP id l18sf844231wgh.3
        for <gcvm-msysgit@m.gmane.org>; Wed, 08 Oct 2014 11:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=iG/RHlteV4qoHgbKu2MI5Ctw6X0F/ZkEk46f5WrnVUY=;
        b=riOhSn08x+EYjutqvw4nUq+Pw0+iWDy61UONwGZsxQ7y83lbNE3yGgO60Qt5/FMT4G
         y759dI4+VZ9Z3MnYZDhKGdL9EGjwDPFv6UT87JN+vgMWESl16bYsi2/LqEXjSZJbDvSE
         RQ9A3v+NOD1+S/ce7YDuVW7QQJ3Ec8AK2NYakRcNDzgCJLoB0tMAJWUQMdEf3DJa8x3w
         NsHys1fn/gKSiWsn7TVj01Iu5c3GNru776uvADIqH2gMvU3iPv0/4i17B3TbXuliQblR
         zZx6C2sI236/6PI/dxCh1tYop0LyUkQaUJtFZOtfLVTescVQvWWqSWXFD6CCLy7sbZeX
         wh9A==
X-Received: by 10.152.42.137 with SMTP id o9mr23460lal.19.1412791281759;
        Wed, 08 Oct 2014 11:01:21 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.153.7.132 with SMTP id dc4ls84824lad.64.gmail; Wed, 08 Oct
 2014 11:01:20 -0700 (PDT)
X-Received: by 10.152.29.130 with SMTP id k2mr1825826lah.3.1412791280391;
        Wed, 08 Oct 2014 11:01:20 -0700 (PDT)
Received: from slonopotamus.org ([94.242.204.247])
        by gmr-mx.google.com with ESMTPS id f9si578318wib.2.2014.10.08.11.01.20
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Oct 2014 11:01:20 -0700 (PDT)
Received-SPF: none (google.com: marat@slonopotamus.org does not designate permitted sender hosts) client-ip=94.242.204.247;
Received: from [176.57.72.72] (helo=noblesse.home.ru)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1XbvY6-0003Rz-0M; Wed, 08 Oct 2014 22:01:18 +0400
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

pid_t is available in sys/types.h on both MinGW and MinGW-W64

Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
Acked-by: Eric Faye-Lund <kusmabite@gmail.com>
---
 compat/mingw.h | 1 -
 compat/msvc.h  | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index 1ddd663..ba05044 100644
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
