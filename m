From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 01/14] MINGW: compat/mingw.h: do not attempt to
 redefine lseek on mingw-w64
Date: Tue, 30 Sep 2014 11:02:30 +0400
Message-ID: <1412060563-22041-2-git-send-email-marat@slonopotamus.org>
References: <1412060563-22041-1-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: marat@slonopotamus.org,
	msysGit <msysgit@googlegroups.com>
To: git@vger.kernel.org
X-From: msysgit+bncBCE7TAPITACRBJNLVGQQKGQEIJGNEJA@googlegroups.com Tue Sep 30 09:03:02 2014
Return-path: <msysgit+bncBCE7TAPITACRBJNLVGQQKGQEIJGNEJA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f186.google.com ([209.85.212.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCE7TAPITACRBJNLVGQQKGQEIJGNEJA@googlegroups.com>)
	id 1XYrSg-0008RT-3Z
	for gcvm-msysgit@m.gmane.org; Tue, 30 Sep 2014 09:03:02 +0200
Received: by mail-wi0-f186.google.com with SMTP id fb4sf225245wid.23
        for <gcvm-msysgit@m.gmane.org>; Tue, 30 Sep 2014 00:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=dick/35AQXebPswDw4/UcACGBPrpLgfv2kN5oTxpbWw=;
        b=m8RQ9CRbIncNm4MfUiUbF6AZoOUwVIwtDBCpCzn+gfT01d0li15hn8FJSJu6MRtz23
         r0KpXLf4bCTBsoViBh8Fu2dnM5XIUGxuI9cv9Vfnzm7TmOcknHAzZkviX26jhL7G8ukD
         VoCAXbXyEmRtAdpM7yRVrG/UnRRSsEuBBw09teJodtU13F0Js1RcNDJ+baalcm7prPtT
         iSplE1VOchYGg026gkVc7NGEACP9dxJLfDMQMySkYQBQXQsCTaC1z2KlfBjoJUEdJjiS
         nMpIvB005YFXHfJdPsOrvecwnmLYigoXw0NglmGQ0epaX5b28a95f92kwaUj12An2HDZ
         U4NA==
X-Received: by 10.180.97.170 with SMTP id eb10mr7555wib.19.1412060581836;
        Tue, 30 Sep 2014 00:03:01 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.100.98 with SMTP id ex2ls3838wib.50.gmail; Tue, 30 Sep
 2014 00:03:01 -0700 (PDT)
X-Received: by 10.194.100.3 with SMTP id eu3mr93974wjb.6.1412060581340;
        Tue, 30 Sep 2014 00:03:01 -0700 (PDT)
Received: from slonopotamus.org ([94.242.204.247])
        by gmr-mx.google.com with ESMTPS id p7si515499wiz.1.2014.09.30.00.03.01
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Sep 2014 00:03:01 -0700 (PDT)
Received-SPF: none (google.com: marat@slonopotamus.org does not designate permitted sender hosts) client-ip=94.242.204.247;
Received: from [185.6.245.138] (helo=radchenko-d-lnx.mail.msk)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1XYrSa-0004X0-G4; Tue, 30 Sep 2014 11:02:56 +0400
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257648>

Unlike MinGW, MinGW-W64 has lseek already properly defined in io.h.

Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
Acked-by: Eric Faye-Lund <kusmabite@gmail.com>
---
 compat/mingw.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/compat/mingw.h b/compat/mingw.h
index df0e320..ed79368 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -281,7 +281,9 @@ static inline int getrlimit(int resource, struct rlimit *rlp)
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
