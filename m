From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 02/15] Add define guards to compat/win32.h
Date: Wed, 16 Sep 2009 10:20:18 +0200
Message-ID: <26c067500d8adf17a2d75e2956e4d4a6cef27fc1.1253088099.git.mstormo@gmail.com>
References: <cover.1253088099.git.mstormo@gmail.com> <213f3c7799721c3f42ffa689498175f0495048eb.1253088099.git.mstormo@gmail.com>
Cc: Johannes.Schindelin@gmx.de, msysgit@googlegroups.com, gitster@pobox.com, j6t@kdbg.org, lznuaa@gmail.com, raa.lkml@gmail.com, snaury@gmail.com, Marius Storm-Olsen <mstormo@gmail.com>
To: git@vger.kernel.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Sep 16 10:21:12 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f137.google.com ([209.85.210.137])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnplI-0004o9-Lm
	for gcvm-msysgit@m.gmane.org; Wed, 16 Sep 2009 10:21:12 +0200
Received: by yxe1 with SMTP id 1so8797092yxe.21
        for <gcvm-msysgit@m.gmane.org>; Wed, 16 Sep 2009 01:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=fspQn4zzlLA1RFgKODvy4NGEQYL4p9tyZ4Iuq5DwI3E=;
        b=P35eE5w39qQS0XE2/8Q5PqrxrBI0dBqfG1rdweFWDmUJY05j4TpAywnEfDqIudKJDl
         RaK/PvmxV8kvKJKATgLqljqpf/xU2R5K8YGz6+PRVJE0N3mXoirNlp6LzLB4bMbEsVSh
         qMGCGrTJ580CIzDbQZ/bFtPml/forXf7ZYPhA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=bRG4Nl2K+QGgJOAexGJn1F6jgkTqHacd2+RzfPmW0nKtL7fsg4OYC4+5PUqSArnyjq
         NSBwvGE6JDmTbExww3gbkSObZoZr7m3Is3V6jKKUbGkkvpfL4rVZlIJtBS6iwYJ+fM2/
         k7zUDq9h05bweUUbPB7KqcZD0KV1g+suWnimc=
Received: by 10.90.107.20 with SMTP id f20mr1338796agc.7.1253089266051;
        Wed, 16 Sep 2009 01:21:06 -0700 (PDT)
Received: by 10.177.5.4 with SMTP id h4gr7037yqi.0;
	Wed, 16 Sep 2009 01:20:54 -0700 (PDT)
X-Sender: mstormo@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.211.161.13 with SMTP id n13mr1281126ebo.2.1253089253297; Wed, 16 Sep 2009 01:20:53 -0700 (PDT)
Received: by 10.211.161.13 with SMTP id n13mr1281125ebo.2.1253089253265; Wed, 16 Sep 2009 01:20:53 -0700 (PDT)
Received: from mail-ew0-f228.google.com (mail-ew0-f228.google.com [209.85.219.228]) by gmr-mx.google.com with ESMTP id 14si1701049ewy.5.2009.09.16.01.20.52; Wed, 16 Sep 2009 01:20:52 -0700 (PDT)
Received-SPF: pass (google.com: domain of mstormo@gmail.com designates 209.85.219.228 as permitted sender) client-ip=209.85.219.228;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of mstormo@gmail.com designates 209.85.219.228 as permitted sender) smtp.mail=mstormo@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by mail-ew0-f228.google.com with SMTP id 28so828988ewy.4 for <msysgit@googlegroups.com>; Wed, 16 Sep 2009 01:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer:in-reply-to:references:in-reply-to:references; bh=MBKRKj5IZGpYDkTjC7dmJC0KPjJsQwdA2ermmNznTmE=; b=JikE/85VNM+d2uCL5LxN+IHZbAzcuPDWf7a+tpioOWz6k1r98oFm9xZvl1tH4/dNtO +ZK5AGs3QKrFSGTR0AL3f42rIMyzPMIFCWxaSUUUSPQ+vCyF0uEjM+xcOWvfJXJb3ea6 nyrSbzNiluzsKEke7mQET97TsOzW+LXXIUZQo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references; b=rFO4D2Euu+8n5f7YPgryEEEVG4eatj1LoekUJraOh2Z/ArI88syvLPnmNrg7zs5FgX rBsyrJvByZSloN/3g85qSfhGKHzzo3PL7WR2lKfl8EXGxvY5nOv5HljXPr7kJDwG21oq RLbxt5GJqm/tGpif1VGnc1nOMG51wi/GQ4xWM=
Received: by 10.211.188.3 with SMTP id q3mr1918086ebp.69.1253089252172; Wed, 16 Sep 2009 01:20:52 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104]) by mx.google.com with ESMTPS id 10sm1370859eyd.16.2009.09.16.01.20.50 (version=SSLv3 cipher=RC4-MD5); Wed, 16 Sep 2009 01:20:51 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <213f3c7799721c3f42ffa689498175f0495048eb.1253088099.git.mstormo@gmail.com>
In-Reply-To: <cover.1253088099.git.mstormo@gmail.com>
References: <cover.1253088099.git.mstormo@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128617>


Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
---
 compat/win32.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/compat/win32.h b/compat/win32.h
index c26384e..e8c178d 100644
--- a/compat/win32.h
+++ b/compat/win32.h
@@ -1,3 +1,6 @@
+#ifndef WIN32_H
+#define WIN32_H
+
 /* common Win32 functions for MinGW and Cygwin */
 #include <windows.h>
 
@@ -32,3 +35,5 @@ static inline int get_file_attr(const char *fname, WIN32_FILE_ATTRIBUTE_DATA *fd
 		return ENOENT;
 	}
 }
+
+#endif
-- 
1.6.2.1.418.g33d56.dirty
