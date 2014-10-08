From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 01/14] MINGW: compat/mingw.h: do not attempt to
 redefine lseek on mingw-w64
Date: Wed,  8 Oct 2014 22:00:54 +0400
Message-ID: <1412791267-13356-2-git-send-email-marat@slonopotamus.org>
References: <1412791267-13356-1-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: marat@slonopotamus.org,
	msysGit <msysgit@googlegroups.com>
To: git@vger.kernel.org
X-From: msysgit+bncBCE7TAPITACRB3PX2WQQKGQEQD462LA@googlegroups.com Wed Oct 08 20:01:19 2014
Return-path: <msysgit+bncBCE7TAPITACRB3PX2WQQKGQEQD462LA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f189.google.com ([209.85.212.189])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCE7TAPITACRB3PX2WQQKGQEQD462LA@googlegroups.com>)
	id 1XbvY7-0003Tr-Az
	for gcvm-msysgit@m.gmane.org; Wed, 08 Oct 2014 20:01:19 +0200
Received: by mail-wi0-f189.google.com with SMTP id ex7sf628657wid.26
        for <gcvm-msysgit@m.gmane.org>; Wed, 08 Oct 2014 11:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=sEZMTYvCSlfI9HEidFMZNgkHEUEvFybiMmcMCXALExc=;
        b=NG3sm0p4EbVMLGcSzlA6hA07SJ8sR9MocTpyG8hVy/dKqWuARMBHuy2OUHA8Mmc0ff
         V1q1s/8kCCCJsKVLQIGqOa1YjClffTKmf/pknTOhHN9tO2jnjr3Ad6949vRzakS3k9Pa
         OsenfoGqdEWIoQJ4EmvVAI4tjE9a8dK/BsRiapjLVpsqLRti8Uq5CHt5PsOZayeZZepO
         PKOSVCtAV/Vqj0BgFWUML4voRKA5IU1g39M+PcQjV79I/oySafgvhBTxPwEs9y0wb7HN
         2ffhCDggEczB7yRei/A6do5QI7B8qe7homAcWUKKYRz2jMV8nNhUnXfxFIbGTGspmCwb
         2k7Q==
X-Received: by 10.152.30.1 with SMTP id o1mr19905lah.38.1412791279080;
        Wed, 08 Oct 2014 11:01:19 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.26.130 with SMTP id l2ls84561lag.45.gmail; Wed, 08 Oct
 2014 11:01:17 -0700 (PDT)
X-Received: by 10.112.137.230 with SMTP id ql6mr579029lbb.13.1412791277405;
        Wed, 08 Oct 2014 11:01:17 -0700 (PDT)
Received: from slonopotamus.org ([94.242.204.247])
        by gmr-mx.google.com with ESMTPS id ca20si924877wib.3.2014.10.08.11.01.17
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Oct 2014 11:01:17 -0700 (PDT)
Received-SPF: none (google.com: marat@slonopotamus.org does not designate permitted sender hosts) client-ip=94.242.204.247;
Received: from [176.57.72.72] (helo=noblesse.home.ru)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1XbvY0-0003Rz-DE; Wed, 08 Oct 2014 22:01:12 +0400
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

Unlike MinGW, MinGW-W64 has lseek already properly defined in io.h.

Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
Acked-by: Eric Faye-Lund <kusmabite@gmail.com>
---
 compat/mingw.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/compat/mingw.h b/compat/mingw.h
index 5e499cf..36a47cb 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -286,7 +286,9 @@ static inline int getrlimit(int resource, struct rlimit *rlp)
  * Use mingw specific stat()/lstat()/fstat() implementations on Windows.
  */
 #define off_t off64_t
+#ifndef lseek
 #define lseek _lseeki64
+#endif
 
 /* use struct stat with 64 bit st_size */
 #ifdef stat
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
