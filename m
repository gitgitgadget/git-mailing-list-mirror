From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH 13/15] daemon: use socklen_t
Date: Fri, 22 Oct 2010 02:05:42 +0200
Message-ID: <1287705944-5668-13-git-send-email-kusmabite@gmail.com>
References: <1287705944-5668-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Cc: msysgit@googlegroups.com,
	j6t@kdbg.org,
	avarab@gmail.com,
	sunshine@sunshineco.com,
	jrnieder@gmail.com,
	schwab@linux-m68k.org,
	patthoyts@gmail.com
To: git@vger.kernel.org
X-From: msysgit+bncCOPdven-DxChq4PmBBoE5vnKeA@googlegroups.com Fri Oct 22 02:07:25 2010
Return-path: <msysgit+bncCOPdven-DxChq4PmBBoE5vnKeA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ww0-f58.google.com ([74.125.82.58])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCOPdven-DxChq4PmBBoE5vnKeA@googlegroups.com>)
	id 1P95AH-0004SJ-OE
	for gcvm-msysgit@m.gmane.org; Fri, 22 Oct 2010 02:07:21 +0200
Received: by mail-ww0-f58.google.com with SMTP id 28sf109548wwb.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 21 Oct 2010 17:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:mime-version:x-beenthere:received
         :received:received:received:received-spf:received:received:received
         :from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=uOKK+PmlM/MPaRwjsdhb7ZKQix1jrcFhd+BuvdoeFME=;
        b=0pa5NyZp2QGXXX8srpq6kt7sIwwOwkacn5WIJDqWcR1hivoOThwSRYqC3CzneoV31m
         YVz5BDkbVDgoOha87joOVymj+/18DnPuNA8RgJ9kMRMQxmswu4g2uqllGr5GuQuGzZmm
         v3jI9VDty0hQmNvc/weut5ofiwoTNvlx+ro3M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        b=m+lxz7n9UQpG9Y9v15j8k2g2bnFDGek4u1P7rmJC/IroO/+kixu5l6uek990hEJmZW
         K/wj57lMlaD3ujllWEH2FYm5XCcU3ZiE7eQBxJYmo7+QXMYoY8oMSP7qIVlNC54n/68i
         HTCWf5IHnGgrP1x8PBzPO6t2+wgm1Y208GQFo=
Received: by 10.216.237.35 with SMTP id x35mr292212weq.5.1287706017901;
        Thu, 21 Oct 2010 17:06:57 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.14.24.73 with SMTP id w49ls268198eew.4.p; Thu, 21 Oct 2010
 17:06:57 -0700 (PDT)
Received: by 10.14.45.11 with SMTP id o11mr167433eeb.20.1287706016890;
        Thu, 21 Oct 2010 17:06:56 -0700 (PDT)
Received: by 10.14.45.11 with SMTP id o11mr167432eeb.20.1287706016873;
        Thu, 21 Oct 2010 17:06:56 -0700 (PDT)
Received: from mail-ew0-f48.google.com (mail-ew0-f48.google.com [209.85.215.48])
        by gmr-mx.google.com with ESMTP id q11si1427785eeh.0.2010.10.21.17.06.55;
        Thu, 21 Oct 2010 17:06:55 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.215.48 as permitted sender) client-ip=209.85.215.48;
Received: by ewy3 with SMTP id 3so188948ewy.21
        for <msysgit@googlegroups.com>; Thu, 21 Oct 2010 17:06:55 -0700 (PDT)
Received: by 10.213.35.145 with SMTP id p17mr8736752ebd.84.1287706015729;
        Thu, 21 Oct 2010 17:06:55 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id w20sm2464297eeh.6.2010.10.21.17.06.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 17:06:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
In-Reply-To: <1287705944-5668-1-git-send-email-kusmabite@gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.215.48 as permitted sender)
 smtp.mail=kusmabite@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159604>

Windows's accept()-function takes the last argument as an int, but glibc
takes an unsigned int. Use socklen_t to get rid of a warning. This is
basically a revert of 7fa0908, but we have already been depending on
socklen_t existing since June 2006 (commit 5b276ee4). I guess this means
that socklen_t IS defined on OSX after all - at least in recent headers.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 daemon.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/daemon.c b/daemon.c
index 19b4eb3..af13f4a 100644
--- a/daemon.c
+++ b/daemon.c
@@ -597,7 +597,7 @@ static struct child {
 	struct sockaddr_storage address;
 } *firstborn;
 
-static void add_child(struct child_process *cld, struct sockaddr *addr, int addrlen)
+static void add_child(struct child_process *cld, struct sockaddr *addr, socklen_t addrlen)
 {
 	struct child *newborn, **cradle;
 
@@ -654,7 +654,7 @@ static void check_dead_children(void)
 }
 
 static char **cld_argv;
-static void handle(int incoming, struct sockaddr *addr, int addrlen)
+static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
 {
 	struct child_process cld = { 0 };
 	char addrbuf[300] = "REMOTE_ADDR=", portbuf[300];
@@ -904,7 +904,7 @@ static int service_loop(struct socketlist *socklist)
 		for (i = 0; i < socklist->nr; i++) {
 			if (pfd[i].revents & POLLIN) {
 				struct sockaddr_storage ss;
-				unsigned int sslen = sizeof(ss);
+				socklen_t sslen = sizeof(ss);
 				int incoming = accept(pfd[i].fd, (struct sockaddr *)&ss, &sslen);
 				if (incoming < 0) {
 					switch (errno) {
-- 
1.7.3.1.199.g72340
