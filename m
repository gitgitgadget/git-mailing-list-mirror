From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH v3 5/8] imap-send: build imap-send on Windows
Date: Tue, 13 Oct 2009 19:25:22 +0000
Message-ID: <1255461925-2244-6-git-send-email-kusmabite@gmail.com>
References: <1255461925-2244-1-git-send-email-kusmabite@gmail.com> <1255461925-2244-2-git-send-email-kusmabite@gmail.com> <1255461925-2244-3-git-send-email-kusmabite@gmail.com> <1255461925-2244-4-git-send-email-kusmabite@gmail.com> <1255461925-2244-5-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Tue Oct 13 21:26:47 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f141.google.com ([209.85.210.141])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxn0y-0006o6-Rx
	for gcvm-msysgit@m.gmane.org; Tue, 13 Oct 2009 21:26:33 +0200
Received: by yxe5 with SMTP id 5so3397509yxe.24
        for <gcvm-msysgit@m.gmane.org>; Tue, 13 Oct 2009 12:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=yOX+adsV66PDfbXTZUZ6bgqS9YKA7V6l8dVLM0vBMtQ=;
        b=DPNrbyByyeoBP5W80GrqdX2MLZDxFr8MLuV1ROmOPLSDN0axHwcp1TXSuKswi+Gj9M
         rOOeRKHMsDFYk23sbS5OicpbhyiE/dEG4+T5cd6UjRX/SBl5RkB0cNE1xmR6D9+ap3/F
         Wb2jgdF/yaEQf8+RIBGL3L8jT32SMk+WBllX0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=Gk7HLWqoLV/hSbgn2STvP9gYRxGp3VMzLBst4Wp8eNUVz9Yhb0KBeh2le3shI8d3rL
         5MZXgIDc//MmrxBFTlqVEGcQXTzd/YhYKfbwoDXKm9SIq00jSXcKs4Ury1uzsMAUpB5f
         GbuRVnQj0shrwJHkq0x/Dapg0fD+/+0pIv+9g=
Received: by 10.150.112.3 with SMTP id k3mr913109ybc.25.1255461985375;
        Tue, 13 Oct 2009 12:26:25 -0700 (PDT)
Received: by 10.176.140.25 with SMTP id n25gr7399yqd.0;
	Tue, 13 Oct 2009 12:26:24 -0700 (PDT)
X-Sender: kusmabite@googlemail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.210.173.4 with SMTP id v4mr555510ebe.27.1255461983042; Tue, 13 Oct 2009 12:26:23 -0700 (PDT)
Received: by 10.210.173.4 with SMTP id v4mr555509ebe.27.1255461983016; Tue, 13 Oct 2009 12:26:23 -0700 (PDT)
Received: from ey-out-2122.google.com (ey-out-2122.google.com [74.125.78.24]) by gmr-mx.google.com with ESMTP id 16si335512ewy.7.2009.10.13.12.26.21; Tue, 13 Oct 2009 12:26:22 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 74.125.78.24 as permitted sender) client-ip=74.125.78.24;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of kusmabite@googlemail.com designates 74.125.78.24 as permitted sender) smtp.mail=kusmabite@googlemail.com; dkim=pass (test mode) header.i=@googlemail.com
Received: by ey-out-2122.google.com with SMTP id 9so794191eyd.25 for <msysgit@googlegroups.com>; Tue, 13 Oct 2009 12:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=googlemail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer:in-reply-to:references; bh=7fDBljWjknzrLhXzu5rpFG8j5j33mPqUBLyQLBlvrTk=; b=XigJ8NNWw1WHOhEji+OWSx5pElOPDL4WopVatLjc5xm3yCO+cTpwymnIyA4OlgTtyB ZEnUPpESzJFW7qmkV7YNjcxouCiLt+C5MU1jeAAUISbne6yJ8324HA5b3JPWruWl8Sf2 E/kZgnbfgaejpK1u4zKDmQvPwC0F5xGo+usvM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=googlemail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references; b=J+/fcTANdu81/lKw9Jvl9jc/Bug36sDbLaxD3aZjBahKN3SRQBbxDwRsK/4+ZRaqlD rssjDf8OqVJMVhQgphxmYELfVlQdLS366c6QNbBXvHK9i0LhF4MtDPzAzMR7Dn8w6FYh AaKYVBgePCxAbCgq1Ed2Q8AF2m622HJsOCKQ4=
Received: by 10.211.173.14 with SMTP id a14mr6072322ebp.39.1255461981849; Tue, 13 Oct 2009 12:26:21 -0700 (PDT)
Received: from localhost (cm-84.215.142.12.getinternet.no [84.215.142.12]) by mx.google.com with ESMTPS id 5sm382237eyh.9.2009.10.13.12.26.20 (version=TLSv1/SSLv3 cipher=RC4-MD5); Tue, 13 Oct 2009 12:26:21 -0700 (PDT)
X-Mailer: git-send-email 1.6.4
In-Reply-To: <1255461925-2244-5-git-send-email-kusmabite@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130187>


Since the POSIX-specific tunneling code has been replaced
by the run-command API (and a compile-error has been
cleaned away), we can now enable imap-send on Windows
builds.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index fea237b..3ddb3b3 100644
--- a/Makefile
+++ b/Makefile
@@ -365,6 +365,7 @@ PROGRAMS += git-show-index$X
 PROGRAMS += git-unpack-file$X
 PROGRAMS += git-upload-pack$X
 PROGRAMS += git-var$X
+PROGRAMS += git-imap-send$X
 
 # List built-in command $C whose implementation cmd_$C() is not in
 # builtin-$C.o but is linked in as part of some other command.
@@ -1075,7 +1076,6 @@ EXTLIBS += -lz
 
 ifndef NO_POSIX_ONLY_PROGRAMS
 	PROGRAMS += git-daemon$X
-	PROGRAMS += git-imap-send$X
 endif
 ifndef NO_OPENSSL
 	OPENSSL_LIBSSL = -lssl
-- 
1.6.4
