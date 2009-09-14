From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 12/17] Make usage of windows.h lean and mean
Date: Mon, 14 Sep 2009 15:11:25 +0200
Message-ID: <1b5c5e90392e813ffab4fd510b70e57903a451cc.1252925290.git.mstormo@gmail.com>
References: <cover.1252925290.git.mstormo@gmail.com> <1b36d8e041c9c1a6dc68f9cc3919fcf91b7a9ac6.1252925290.git.mstormo@gmail.com> <7786dfa1b74b5c4974bcf2018d3991c215a9466f.1252925290.git.mstormo@gmail.com> <e2eff51e8d956e7cf854bea9fb9f10491f6d6543.1252925290.git.mstormo@gmail.com> <baa73a58d459d9cd29227b1f0fb02306c14db807.1252925290.git.mstormo@gmail.com> <54b586ed58d1e9b4204658871f6f34453b48758b.1252925290.git.mstormo@gmail.com> <160ceafba5f58cfcadb13380e3d8ef724009b700.1252925290.git.mstormo@gmail.com> <1d699897d4163224ce22db9400569fab20547e9d.1252925290.git.mstormo@gmail.com> <8da5dcea21ce49b3a57fd224c088785a9f98e867.1252925290.git.mstormo@gmail.com> <a48108513bf13247ba9b42fd703ba679804e8d8a.1252925290.git.mstormo@gmail.com> <aed24a7f9524c9872f8a2455cfc5dd8baf6c3c0b.1252925290.git.mstorm
 o@gmail.com> <4931b7ac3102ee259353fe6b3c5ceeb2a67c53ba.1252925290.git.mstormo@gmail.com>
Cc: msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com, Marius Storm-Olsen <mstormo@gmail.com>
To: Johannes.Schindelin@gmx.de
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Sep 14 15:13:13 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f157.google.com ([209.85.210.157])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnBMn-0004Ql-5o
	for gcvm-msysgit@m.gmane.org; Mon, 14 Sep 2009 15:13:13 +0200
Received: by yxe29 with SMTP id 29so6077722yxe.16
        for <gcvm-msysgit@m.gmane.org>; Mon, 14 Sep 2009 06:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=jJAn7+xMO7HzBCiiEhUy036sxfCXxNDNJJfzwvKmQTQ=;
        b=u2G5UsPpRhpps9naUKby06C9zhoHKAa9acbgFicGCSHvo3sdz60RjoPs0ZTteXGVg0
         uamXyYGFD9nSrI17vEnH2dbSEGNTSqm7q/JikLas0Yas3lnsfG+vdYVhaM5xK7Vm6g3V
         abJ3MufNPotSX5yBYAZFLjEPThcR7v4Sgbt7E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=hLemMWFhHxnteEQGHR9gqHijMAb4z8ANBEoY9qU9MtBYR1cOocD6xTDC3kbll/kZGr
         6mnRdbUQypHq7nfJ8hsreMDXAOCkS8QyVfK2x0B6MoAg4XNSjVhxehD81KTl3YrByf+N
         bSeHr2olaYmAEyzT+sijm74tpkPIuOycHjQf0=
Received: by 10.150.5.1 with SMTP id 1mr1952582ybe.18.1252933986233;
        Mon, 14 Sep 2009 06:13:06 -0700 (PDT)
Received: by 10.176.207.9 with SMTP id e9gr6970yqg.0;
	Mon, 14 Sep 2009 06:12:56 -0700 (PDT)
X-Sender: mstormo@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.210.253.11 with SMTP id a11mr844873ebi.23.1252933975408; Mon, 14 Sep 2009 06:12:55 -0700 (PDT)
Received: by 10.210.253.11 with SMTP id a11mr844872ebi.23.1252933975373; Mon, 14 Sep 2009 06:12:55 -0700 (PDT)
Received: from ey-out-2122.google.com (ey-out-2122.google.com [74.125.78.27]) by gmr-mx.google.com with ESMTP id 15si1278761ewy.0.2009.09.14.06.12.54; Mon, 14 Sep 2009 06:12:54 -0700 (PDT)
Received-SPF: pass (google.com: domain of mstormo@gmail.com designates 74.125.78.27 as permitted sender) client-ip=74.125.78.27;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of mstormo@gmail.com designates 74.125.78.27 as permitted sender) smtp.mail=mstormo@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by ey-out-2122.google.com with SMTP id 4so515000eyf.13 for <msysgit@googlegroups.com>; Mon, 14 Sep 2009 06:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer:in-reply-to:references:in-reply-to:references; bh=8uFulFB4EEzO4ViRM3IVZxazlUbO9UhJYVxLMHIlcK4=; b=x87uSF5GJ4lAPvMewjJLp5K6agYW4nNWQ38qNdGwQA+rKrE+5RPuwahLmGiKzJlDlm 0//3FpBHHOzsDqwrqQE2tRlfNS2WmPipj5bPjhuPtmz1qYP0lHmgYAVz0jkO3KsbVli1 03fRNlwHaIF2s6w7ATMMEQxJ0WSZh38/PDwlk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references; b=iLgyI9iXXQCvjuKhLmJThyFJ78kEMQXKQAWBh2kLLCTMWBM4NVeQxgsJPcVAbQ/y0X TNpJv5qe3P4O7DkTWmao/r+2vhFXkJwuafDE7Wtkaw8el8bKdaKpKGgqHhJI1+xpBV2O hKz/zZY4NCTpfmjAgDJ6HjEBJtecvM8dtBYFQ=
Received: by 10.211.145.8 with SMTP id x8mr3163875ebn.67.1252933974227; Mon, 14 Sep 2009 06:12:54 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104]) by mx.google.com with ESMTPS id 10sm2690277eyz.2.2009.09.14.06.12.51 (version=SSLv3 cipher=RC4-MD5); Mon, 14 Sep 2009 06:12:51 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <4931b7ac3102ee259353fe6b3c5ceeb2a67c53ba.1252925290.git.mstormo@gmail.com>
In-Reply-To: <cover.1252925290.git.mstormo@gmail.com>
References: <cover.1252925290.git.mstormo@gmail.com>
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128468>


Centralize the include of windows.h in git-compat-util.h, turn on
WIN32_LEAN_AND_MEAN to avoid including plenty of other header files
which is not needed in Git. Also ensure we load winsock2.h first,
so we don't load the older winsock definitions at a later stage,
since they contain duplicate definitions.

When moving windows.h into git-compat-util.h, we need to protect
the definition of struct pollfd in mingw.h, since this file is used
by both MinGW and MSVC, and the latter defines this struct in
winsock2.h.

We need to keep the windows.h include in compat/win32.h, since its
shared by both MinGW and Cygwin, and we're not touching Cygwin in
this commit. The include in git-compat-util.h is protected with an
ifdef WIN32, which is not the case when compiling for Cygwin.

Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
---
 compat/mingw.c    |    2 ++
 compat/mingw.h    |    2 ++
 compat/msvc.h     |    7 -------
 compat/win32.h    |    2 ++
 compat/winansi.c  |    1 -
 git-compat-util.h |    6 ++++++
 thread-utils.c    |    5 +----
 7 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 90764eb..fe21c29 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -3,6 +3,8 @@
 #include <conio.h>
 #include "../strbuf.h"
 
+#include <shellapi.h>
+
 unsigned int _CRT_fmode = _O_BINARY;
 
 static int err_win_to_posix(DWORD winerr)
diff --git a/compat/mingw.h b/compat/mingw.h
index c43917c..4784adc 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -41,6 +41,7 @@ struct passwd {
 
 extern char *getpass(const char *prompt);
 
+#ifndef POLLIN
 struct pollfd {
 	int fd;           /* file descriptor */
 	short events;     /* requested events */
@@ -48,6 +49,7 @@ struct pollfd {
 };
 #define POLLIN 1
 #define POLLHUP 2
+#endif
 
 typedef void (__cdecl *sig_handler_t)(int);
 struct sigaction {
diff --git a/compat/msvc.h b/compat/msvc.h
index 6daf313..53a6d30 100644
--- a/compat/msvc.h
+++ b/compat/msvc.h
@@ -1,13 +1,6 @@
 #ifndef __MSVC__HEAD
 #define __MSVC__HEAD
 
-/* Define minimize windows version */
-#define WINVER 0x0500
-#define _WIN32_WINNT 0x0500
-#define _WIN32_WINDOWS 0x0410
-#define _WIN32_IE 0x0700
-#define NTDDI_VERSION NTDDI_WIN2KSP1
-#include <winsock2.h>
 #include <direct.h>
 #include <process.h>
 #include <malloc.h>
diff --git a/compat/win32.h b/compat/win32.h
index e8c178d..8ce9104 100644
--- a/compat/win32.h
+++ b/compat/win32.h
@@ -2,7 +2,9 @@
 #define WIN32_H
 
 /* common Win32 functions for MinGW and Cygwin */
+#ifndef WIN32         /* Not defined by Cygwin */
 #include <windows.h>
+#endif
 
 static inline int file_attr_to_st_mode (DWORD attr)
 {
diff --git a/compat/winansi.c b/compat/winansi.c
index 9217c24..dedce21 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -2,7 +2,6 @@
  * Copyright 2008 Peter Harris <git@peter.is-a-geek.org>
  */
 
-#include <windows.h>
 #include "../git-compat-util.h"
 
 /*
diff --git a/git-compat-util.h b/git-compat-util.h
index 8ea444f..8d6e29c 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -65,6 +65,12 @@
 #define _NETBSD_SOURCE 1
 #define _SGI_SOURCE 1
 
+#ifdef WIN32 /* Both MinGW and MSVC */
+#define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
+#include <winsock2.h>
+#include <windows.h>
+#endif
+
 #include <unistd.h>
 #include <stdio.h>
 #include <sys/stat.h>
diff --git a/thread-utils.c b/thread-utils.c
index 55e7e29..4f9c829 100644
--- a/thread-utils.c
+++ b/thread-utils.c
@@ -1,9 +1,6 @@
 #include "cache.h"
 
-#ifdef _WIN32
-#  define WIN32_LEAN_AND_MEAN
-#  include <windows.h>
-#elif defined(hpux) || defined(__hpux) || defined(_hpux)
+#if defined(hpux) || defined(__hpux) || defined(_hpux)
 #  include <sys/pstat.h>
 #endif
 
-- 
1.6.2.1.418.g33d56.dirty
