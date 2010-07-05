From: Peter Harris <pharris@opentext.com>
Subject: [PATCH 1/2] Fix MSVC build
Date: Mon,  5 Jul 2010 15:41:36 -0400
Message-ID: <1278358897-488-1-git-send-email-pharris@opentext.com>
Mime-Version: 1.0
Cc: git@vger.kernel.org, ramsay@ramsay1.demon.co.uk, jrnieder@gmail.com,
   Peter Harris <pharris@opentext.com>
To: msysgit@googlegroups.com
X-From: msysgit+bncCAAQ-O7I4QQaBEykQa0@googlegroups.com Mon Jul 05 21:50:41 2010
Return-path: <msysgit+bncCAAQ-O7I4QQaBEykQa0@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f186.google.com ([209.85.213.186])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCAAQ-O7I4QQaBEykQa0@googlegroups.com>)
	id 1OVrgd-0002Fl-7g
	for gcvm-msysgit@m.gmane.org; Mon, 05 Jul 2010 21:50:39 +0200
Received: by mail-yx0-f186.google.com with SMTP id 30sf614105yxk.3
        for <gcvm-msysgit@m.gmane.org>; Mon, 05 Jul 2010 12:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:mime-version:x-beenthere:received
         :received:received:received:received:received-spf:received:received
         :received:received:from:to:cc:subject:date:message-id:x-mailer
         :x-originalarrivaltime:x-archived:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=quLSKYRnOb9d023R6Z5WukF/ctUOJnexJKD0q8oROa4=;
        b=GsZ+ZlN7vw4DvQRQLgrSVYNBkv13w+8Y7NyQcyd5rTcpYSrkKI42un0rw5CU/Gs2uz
         4aOg7Ck3z3WH9Ka8b0HGr1QEegsxRzXnZw80pX7neDFx6Rux197Cgg5iwZeref6LF986
         abJdgC6TWEEJS6Pe1fNx5H8XzRYzaH1STVLdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:x-originalarrivaltime:x-archived
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        b=UImLkQJmnbBt/m8sAoVZmXklKxhKqGxE0vsTkkk9DcrJzH1XujmtUOmCtQvug1jALf
         UvyIvVPMgZtP3Fq4dc7qrpjJwiAmwoJHVleYv8gDMu0XWOZplS2BR+7QkF7TszIWYs1s
         SiGJ1p7/I2JVX0lSJO3RJnUyq4W/yzCKUHR1E=
Received: by 10.91.133.13 with SMTP id k13mr297188agn.33.1278359416682;
        Mon, 05 Jul 2010 12:50:16 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.101.145.32 with SMTP id x32ls7279372ann.0.p; Mon, 05 Jul 2010 
	12:50:15 -0700 (PDT)
Received: by 10.101.161.14 with SMTP id n14mr2812146ano.38.1278359415891;
        Mon, 05 Jul 2010 12:50:15 -0700 (PDT)
Received: by 10.231.161.82 with SMTP id q18mr327730ibx.11.1278358924388;
        Mon, 05 Jul 2010 12:42:04 -0700 (PDT)
Received: by 10.231.161.82 with SMTP id q18mr327729ibx.11.1278358924356;
        Mon, 05 Jul 2010 12:42:04 -0700 (PDT)
Received: from opentext.com (smtpout.opentext.com [204.138.115.203])
        by gmr-mx.google.com with ESMTP id db12si2802702ibb.5.2010.07.05.12.42.04;
        Mon, 05 Jul 2010 12:42:04 -0700 (PDT)
Received-SPF: pass (google.com: domain of pharris@opentext.com designates 204.138.115.203 as permitted sender) client-ip=204.138.115.203;
Received: from otwlpm01.smtp.dmz.opentext.com (otwlpm01.smtp.dmz.opentext.com [192.168.15.230])
	by opentext.com (8.12.8/8.12.8) with ESMTP id o65Jg3S9006315
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=FAIL);
	Mon, 5 Jul 2010 15:42:03 -0400
Received: from vectorsvc.wl.opentext.com (ava.wl.opentext.com [172.21.5.96])
	by otwlpm01.smtp.dmz.opentext.com (8.14.4/8.14.4) with ESMTP id o65Jg208011154
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 5 Jul 2010 15:42:02 -0400
	(envelope-from pharris@opentext.com)
Received: from OTWLMX04.opentext.net (otwlxg02.wl.opentext.com [10.2.102.24])
	by vectorsvc.wl.opentext.com (8.12.8/8.12.8) with ESMTP id o65Jg2qt006309;
	Mon, 5 Jul 2010 15:42:02 -0400
Received: from localhost.localdomain ([10.3.14.168]) by OTWLMX04.opentext.net with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 5 Jul 2010 15:42:02 -0400
X-Mailer: git-send-email 1.7.0.6
X-OriginalArrivalTime: 05 Jul 2010 19:42:02.0092 (UTC) FILETIME=[23B62AC0:01CB1C7A]
X-Archived: msg.1QVgoBV:2010-07-05:otwlpm01.smtp.dmz.opentext.com
X-Original-Sender: pharris@opentext.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com: 
	domain of pharris@opentext.com designates 204.138.115.203 as permitted 
	sender) smtp.mail=pharris@opentext.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, 
	<mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, 
	<mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150290>

Signed-off-by: Peter Harris <pharris@opentext.com>
---
 compat/mingw.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index 8104039..08fea02 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -14,11 +14,13 @@ typedef int uid_t;
 #define S_ISSOCK(x) 0
 
 #ifndef _STAT_H_
+#ifndef S_IRUSR
 #define S_IRUSR 0
 #define S_IWUSR 0
 #define S_IXUSR 0
 #define S_IRWXU (S_IRUSR | S_IWUSR | S_IXUSR)
 #endif
+#endif
 #define S_IRGRP 0
 #define S_IWGRP 0
 #define S_IXGRP 0
-- 
1.7.1.msysgit.0.4.gea744.MSVC
