From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 06/14] MINGW: compat/winansi.c: do not redefine CONSOLE_FONT_INFOEX
Date: Wed,  8 Oct 2014 22:00:59 +0400
Message-ID: <1412791267-13356-7-git-send-email-marat@slonopotamus.org>
References: <1412791267-13356-1-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: marat@slonopotamus.org,
	msysGit <msysgit@googlegroups.com>
To: git@vger.kernel.org
X-From: msysgit+bncBCE7TAPITACRB47X2WQQKGQEQHUXHYI@googlegroups.com Wed Oct 08 20:01:25 2014
Return-path: <msysgit+bncBCE7TAPITACRB47X2WQQKGQEQHUXHYI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f56.google.com ([74.125.82.56])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCE7TAPITACRB47X2WQQKGQEQHUXHYI@googlegroups.com>)
	id 1XbvYB-0003Xx-IN
	for gcvm-msysgit@m.gmane.org; Wed, 08 Oct 2014 20:01:23 +0200
Received: by mail-wg0-f56.google.com with SMTP id y10sf818526wgg.11
        for <gcvm-msysgit@m.gmane.org>; Wed, 08 Oct 2014 11:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=y068VDQxBHfjSpMhdq4zkTYsXSDXWPD25LFXsrRH1FU=;
        b=LU9Q/NGkHS8nlQXibf7xDnTxUlmUraydq2uBmzlSAfBq+0YYiySSykuwBnNn5ZwMqY
         t7ecix/uqyUH2c4yy/2rtmPtKv7GqClO6ehVC0ESsCOcUGnqf2C9dZPqn+6IkceAD3w6
         7g7jMgUDgJBCps772E3YFUqkmFwe1Avel2Refo0KOhK0labq8yPLSv7DLTh9FkNv01tm
         y8WgvXlCr4bgxN01yPGa8D5wPy/47AQl12f4fDgzJVq6MBSbZVUzcVNae9NuOppJIJyp
         Q5m6Oh+bb51TsQL9jB+J0PvZFe77oJmMi/AKriK8+u493jMTYhnutdSHvnG9IYFyjEom
         QdtQ==
X-Received: by 10.180.126.69 with SMTP id mw5mr150629wib.3.1412791283340;
        Wed, 08 Oct 2014 11:01:23 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.94.2 with SMTP id cy2ls964959wib.18.canary; Wed, 08 Oct
 2014 11:01:22 -0700 (PDT)
X-Received: by 10.180.82.74 with SMTP id g10mr5433234wiy.0.1412791282707;
        Wed, 08 Oct 2014 11:01:22 -0700 (PDT)
Received: from slonopotamus.org ([94.242.204.247])
        by gmr-mx.google.com with ESMTPS id dz10si129262wib.0.2014.10.08.11.01.22
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Oct 2014 11:01:22 -0700 (PDT)
Received-SPF: none (google.com: marat@slonopotamus.org does not designate permitted sender hosts) client-ip=94.242.204.247;
Received: from [176.57.72.72] (helo=noblesse.home.ru)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1XbvY8-0003Rz-Aw; Wed, 08 Oct 2014 22:01:20 +0400
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
