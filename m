From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH v5 5/8] imap-send: build imap-send on Windows
Date: Wed, 21 Oct 2009 19:04:48 +0200
Message-ID: <1256144691-2908-6-git-send-email-kusmabite@gmail.com>
References: <1256144691-2908-1-git-send-email-kusmabite@gmail.com> <1256144691-2908-2-git-send-email-kusmabite@gmail.com> <1256144691-2908-3-git-send-email-kusmabite@gmail.com> <1256144691-2908-4-git-send-email-kusmabite@gmail.com> <1256144691-2908-5-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Oct 21 19:05:49 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qy0-f163.google.com ([209.85.221.163])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0edA-0007fq-8r
	for gcvm-msysgit@m.gmane.org; Wed, 21 Oct 2009 19:05:48 +0200
Received: by mail-qy0-f163.google.com with SMTP id 35so5684134qyk.24
        for <gcvm-msysgit@m.gmane.org>; Wed, 21 Oct 2009 10:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=7N/ui09W5ShmtEYF/+Xw3enCYCleeqUcfx4ThXKObAs=;
        b=OGA39HK8A3yVSPhZUMmPynwlBl90lyHNEqHAX/p7GZUslfTv2KqjRqWDDiGf9TxZdk
         SXRVRGEav171P8A5urp8kjUyd2Cq3+CKskoDd/HXidAgZ2Q+xBjJyeqMfBxx2FS28rYL
         +3iwtwjLqfcmYXGtmB2Eo/0G0ajZPU3oQNCv8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=bqHSADWjUPlnY5PHCDAMhlIAuaJPy1R6W6LP7dNQKxNrKK4/+k+t+Erke7ljN7mBpk
         jb7uRUYwpmkJJ+a1/hflHs4QSzIHBJL/jOzlySY9zyhohiaxlIVsQ0gRb8eELf8jd1gs
         IYlmiNcoGlXntbeRZyzF2d3AHyqZVslR87d5g=
Received: by 10.224.68.12 with SMTP id t12mr401712qai.12.1256144741752;
        Wed, 21 Oct 2009 10:05:41 -0700 (PDT)
Received: by 10.177.105.17 with SMTP id h17gr7479yqm.0;
	Wed, 21 Oct 2009 10:05:32 -0700 (PDT)
X-Sender: kusmabite@googlemail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.211.156.12 with SMTP id i12mr713565ebo.28.1256144731912; Wed, 21 Oct 2009 10:05:31 -0700 (PDT)
Received: by 10.211.156.12 with SMTP id i12mr713564ebo.28.1256144731892; Wed, 21 Oct 2009 10:05:31 -0700 (PDT)
Received: from mail-ew0-f218.google.com (mail-ew0-f218.google.com [209.85.219.218]) by gmr-mx.google.com with ESMTP id 13si41625ewy.6.2009.10.21.10.05.30; Wed, 21 Oct 2009 10:05:30 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 209.85.219.218 as permitted sender) client-ip=209.85.219.218;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of kusmabite@googlemail.com designates 209.85.219.218 as permitted sender) smtp.mail=kusmabite@googlemail.com; dkim=pass (test mode) header.i=@googlemail.com
Received: by mail-ew0-f218.google.com with SMTP id 18so6524555ewy.43 for <msysgit@googlegroups.com>; Wed, 21 Oct 2009 10:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=googlemail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer:in-reply-to:references; bh=OHuyH7jBwrcHuIJzUba9KPQb4Q5pTyIEf/CktTpICbE=; b=A7VC4FQYRofN1+erZcTE7JMP2WmeZYckUGIc/qJcQv+B4du7dyK6ndG/DssEKta3yL 6rVl3e3mtBrwfcg/lz/unsH5rkdC3YBX1loXglDIj0QNTgMaqb/ewMiJZZDs9rvTHLJr kv1Q/IkEy4KnerQ5cbVZoRBT5DZ49JwC9wNZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=googlemail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references; b=BVAjfGQ8+yRVKDp01eObrrdatSurcbFC/0GETVXLb7kjGF8E75nD9Zn50JUAwEp/1n myInkO+ruSiSRAjO8sP2DJzKMNs3pv0ybzVv0ElWfxUw8c/HY65gKSA3oiCkhBq33dYP 1iiQ6OKFqoch7XJRhyDEk8vetUrHmxGsH+Xu8=
Received: by 10.211.161.26 with SMTP id n26mr3201644ebo.74.1256144730543; Wed, 21 Oct 2009 10:05:30 -0700 (PDT)
Received: from localhost ([77.40.159.131]) by mx.google.com with ESMTPS id 28sm73518eyg.7.2009.10.21.10.05.29 (version=TLSv1/SSLv3 cipher=RC4-MD5); Wed, 21 Oct 2009 10:05:30 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.msysgit.0
In-Reply-To: <1256144691-2908-5-git-send-email-kusmabite@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130933>


Since the POSIX-specific tunneling code has been replaced
by the run-command API (and a compile-error has been
cleaned away), we can now enable imap-send on Windows
builds.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index fea237b..0d13af3 100644
--- a/Makefile
+++ b/Makefile
@@ -354,6 +354,7 @@ EXTRA_PROGRAMS =
 PROGRAMS += $(EXTRA_PROGRAMS)
 PROGRAMS += git-fast-import$X
 PROGRAMS += git-hash-object$X
+PROGRAMS += git-imap-send$X
 PROGRAMS += git-index-pack$X
 PROGRAMS += git-merge-index$X
 PROGRAMS += git-merge-tree$X
@@ -1075,7 +1076,6 @@ EXTLIBS += -lz
 
 ifndef NO_POSIX_ONLY_PROGRAMS
 	PROGRAMS += git-daemon$X
-	PROGRAMS += git-imap-send$X
 endif
 ifndef NO_OPENSSL
 	OPENSSL_LIBSSL = -lssl
-- 
1.6.4.msysgit.0
