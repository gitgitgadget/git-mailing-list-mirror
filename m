From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 06/14] MINGW: compat/winansi.c: do not redefine CONSOLE_FONT_INFOEX
Date: Tue, 30 Sep 2014 11:02:35 +0400
Message-ID: <1412060563-22041-7-git-send-email-marat@slonopotamus.org>
References: <1412060563-22041-1-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: marat@slonopotamus.org,
	msysGit <msysgit@googlegroups.com>
To: git@vger.kernel.org
X-From: msysgit+bncBCE7TAPITACRBLNLVGQQKGQE7654HTY@googlegroups.com Tue Sep 30 09:03:14 2014
Return-path: <msysgit+bncBCE7TAPITACRBLNLVGQQKGQE7654HTY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f190.google.com ([209.85.217.190])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCE7TAPITACRBLNLVGQQKGQE7654HTY@googlegroups.com>)
	id 1XYrSp-0008WM-Ek
	for gcvm-msysgit@m.gmane.org; Tue, 30 Sep 2014 09:03:11 +0200
Received: by mail-lb0-f190.google.com with SMTP id l4sf1842lbv.17
        for <gcvm-msysgit@m.gmane.org>; Tue, 30 Sep 2014 00:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=y068VDQxBHfjSpMhdq4zkTYsXSDXWPD25LFXsrRH1FU=;
        b=TOb64cpC79o7b+Wq9648/VGvD+ZU4Uk3EDYPoCXo+2C0l0B12gITZS1ddr4ZwW8IqT
         OZKD8QweEgDKYAEEr5DAArq2p4khmikgWmh1NgVGmp4dsFCYBRG5AYB3SvmfWiJ7q3B3
         7lzN/ik0M5CKQeYEaLXc0A1QPlsL5IIlnrRfut28rl2iy5BIM60ecOJFRDtxrB0MgF3f
         vYho6s0PukoL8k3dmvALCAXBaZfU30mvYkzK8EcNXTk7BEaPIwGi6vcmxAqzad1nJ6uI
         zD5tMVB3IFdsoHAv0ZJfq7kMyHkjgnWbVftYhpNUAzJuelpGyoGRRM0LYShnkUdPaDdX
         mksw==
X-Received: by 10.152.5.130 with SMTP id s2mr449las.41.1412060591261;
        Tue, 30 Sep 2014 00:03:11 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.21.97 with SMTP id u1ls315lae.105.gmail; Tue, 30 Sep 2014
 00:03:09 -0700 (PDT)
X-Received: by 10.112.198.226 with SMTP id jf2mr2386630lbc.1.1412060589176;
        Tue, 30 Sep 2014 00:03:09 -0700 (PDT)
Received: from slonopotamus.org ([94.242.204.247])
        by gmr-mx.google.com with ESMTPS id go4si735069wib.3.2014.09.30.00.03.08
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Sep 2014 00:03:08 -0700 (PDT)
Received-SPF: none (google.com: marat@slonopotamus.org does not designate permitted sender hosts) client-ip=94.242.204.247;
Received: from [185.6.245.138] (helo=radchenko-d-lnx.mail.msk)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1XYrSk-0004X0-TX; Tue, 30 Sep 2014 11:03:07 +0400
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257653>

Unlike MinGW, MinGW-W64 has CONSOLE_FONT_INFOEX already properly defined
in wincon.h.

Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
---
 compat/winansi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/winansi.c b/compat/winansi.c
index efc5bb3..0ac3297 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -22,7 +22,7 @@ static int non_ascii_used = 0;
 static HANDLE hthread, hread, hwrite;
 static HANDLE hconsole1, hconsole2;
 
-#ifdef __MINGW32__
+#if defined(__MINGW32__) && !defined(__MINGW64_VERSION_MAJOR)
 typedef struct _CONSOLE_FONT_INFOEX {
 	ULONG cbSize;
 	DWORD nFont;
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
