From: Marat Radchenko <marat@slonopotamus.org>
Subject: [NOT_A_PATCH] A naive attempt to cross-build Linux->mingw64 Git
Date: Tue, 22 Apr 2014 02:14:39 +0400
Message-ID: <1398118479-7731-1-git-send-email-marat@slonopotamus.org>
References: <535569e92cbcc_32c48493101f@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Marat Radchenko <marat@slonopotamus.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	git@vger.kernel.org,
	msysGit Mailinglist <msysgit@googlegroups.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: msysgit+bncBCE7TAPITACRBV5Q22NAKGQE3Q77C3I@googlegroups.com Tue Apr 22 00:14:51 2014
Return-path: <msysgit+bncBCE7TAPITACRBV5Q22NAKGQE3Q77C3I@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ee0-f58.google.com ([74.125.83.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCE7TAPITACRBV5Q22NAKGQE3Q77C3I@googlegroups.com>)
	id 1WcMUB-000670-Rw
	for gcvm-msysgit@m.gmane.org; Tue, 22 Apr 2014 00:14:47 +0200
Received: by mail-ee0-f58.google.com with SMTP id b15sf393352eek.13
        for <gcvm-msysgit@m.gmane.org>; Mon, 21 Apr 2014 15:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=tbZ4OcceVL4WmpNgqy2CJ5Gag3jReM8SdAwGNUc2pgg=;
        b=L5Y15tL+jSjzFIagJTjx7HKeWOUNoFdEn4CAfXK0P5VuMK0xSu2NU83YDtuJTTxRRH
         g5zwbPZzFPIj8CU/YBA5Q/0fui5A8Evf1jWM4l6wM5NwnaK5XMHTKJKZi7rkQtXRpHpP
         m00OVT3iTiDCynFp7GOlpDIS7vku3zq7yHwKKfjJipgS0NTiOTPikE4wSR2JKSKVcspl
         ib0/efgvXmndAXwMEvvWF48M6jJ92jV+WyyFywmztihfusHCaHMDceDBglVvAq5uhJXr
         cKB6u79Hx5OPxAeWTVbR+quTHoEqAPP60sxITZ34kUoK8M96ZUVAGikgWMbPbsFOkqm0
         m5yg==
X-Received: by 10.180.108.100 with SMTP id hj4mr93572wib.21.1398118487571;
        Mon, 21 Apr 2014 15:14:47 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.90.20 with SMTP id bs20ls167062wib.2.gmail; Mon, 21 Apr
 2014 15:14:46 -0700 (PDT)
X-Received: by 10.180.37.203 with SMTP id a11mr1381509wik.0.1398118486719;
        Mon, 21 Apr 2014 15:14:46 -0700 (PDT)
Received: from slonopotamus.org ([94.242.204.247])
        by gmr-mx.google.com with ESMTPS id ck4si349233wib.1.2014.04.21.15.14.46
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Apr 2014 15:14:46 -0700 (PDT)
Received-SPF: none (google.com: marat@slonopotamus.org does not designate permitted sender hosts) client-ip=94.242.204.247;
Received: from [176.57.72.72] (helo=noblesse.home.ru)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1WcMU5-0000VI-Lw; Tue, 22 Apr 2014 02:14:42 +0400
X-Mailer: git-send-email 1.9.2
In-Reply-To: <535569e92cbcc_32c48493101f@nysa.notmuch>
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
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246656>

config.mak.uname: provide a way to explicitely request MinGW build.
This is required to perform Linux->MinGW crosscompilation.
---

> Personally I don't see why ideally I shouldn't be able to build upstream Git
> for Windows with mingw without leaving my Linux system.

One day you might be able, but as of today...

1. Obtain x86_64-w64-mingw32 compiler for your *nix distro
 * [Gentoo] emerge crossdev && crossdev -t x86_64-w64-mingw32
 * [Debian/Ubuntu] apt-get install mingw-w64
2. Apply patch from this email to Git sources (git/git or msysgit/git - doesn't matter)
3. `make CC=x86_64-w64-mingw32-gcc MINGW=1`
4. Observe errors [1]

I would be happy to find out I'm doing something wrong -- Johannes says building
mingw64 Git is dirt-easy.

[1]:
In file included from /usr/x86_64-w64-mingw32/usr/include/windows.h:9:0,
                 from /usr/x86_64-w64-mingw32/usr/include/winsock2.h:23,
                 from git-compat-util.h:93,
                 from cache.h:4,
                 from credential-store.c:1:
/usr/x86_64-w64-mingw32/usr/include/_mingw.h:456:2: error: #error You cannot use 32-bit time_t (_USE_32BIT_TIME_T) with _WIN64
 #error You cannot use 32-bit time_t (_USE_32BIT_TIME_T) with _WIN64
  ^
In file included from git-compat-util.h:134:0,
                 from cache.h:4,
                 from credential-store.c:1:
compat/mingw.h:8:13: error: conflicting types for 'pid_t'
 typedef int pid_t;
             ^
In file included from /usr/x86_64-w64-mingw32/usr/include/process.h:12:0,
                 from /usr/x86_64-w64-mingw32/usr/include/unistd.h:11,
                 from git-compat-util.h:98,
                 from cache.h:4,
                 from credential-store.c:1:
/usr/x86_64-w64-mingw32/usr/include/sys/types.h:68:16: note: previous declaration of 'pid_t' was here
 typedef _pid_t pid_t;
                ^

 config.mak.uname | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index 82b8dff..4f4d84f 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -13,6 +13,11 @@ ifdef MSVC
 	uname_O := Windows
 endif
 
+ifdef MINGW
+	uname_S := MINGW
+	uname_O := MINGW
+endif
+
 # We choose to avoid "if .. else if .. else .. endif endif"
 # because maintaining the nesting to match is a pain.  If
 # we had "elif" things would have been much nicer...
-- 
1.8.3.2

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
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
