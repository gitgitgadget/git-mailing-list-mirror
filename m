From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH 1/3] Win32: make FILETIME conversion functions public
Date: Thu, 12 Feb 2015 00:51:09 +0100
Message-ID: <54DBEAED.5030201@gmail.com>
References: <54DBEAA5.6000205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Karsten Blees <karsten.blees@gmail.com>
To: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCH3XYXLXQDBB3GV56TAKGQEKEIACZQ@googlegroups.com Thu Feb 12 00:51:10 2015
Return-path: <msysgit+bncBCH3XYXLXQDBB3GV56TAKGQEKEIACZQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f55.google.com ([209.85.215.55])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBB3GV56TAKGQEKEIACZQ@googlegroups.com>)
	id 1YLh3l-0007JL-3N
	for gcvm-msysgit@m.gmane.org; Thu, 12 Feb 2015 00:51:09 +0100
Received: by labgd6 with SMTP id gd6sf1687018lab.2
        for <gcvm-msysgit@m.gmane.org>; Wed, 11 Feb 2015 15:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=uxcGIiqIjGCb7JqeklTR6OnyQJ3mQeVrckp09roXsw8=;
        b=L6CRkWWZudoJgX/eJi9FwNC+pzlVHhLZs2RPRaeG0WagQrhL4XUx+Db38ww3MKkKJY
         WLOMuhbffSVn9xv4XKN0yAdbofZHE2Sd9VV3AdHY5ibVS1QdAgq9B4ysjTVaER/uLhO4
         C43nGuiuyKbpJF7b6Z9ZlO6cQJoR8Eo92w1MAEJlEUemqYBji4DQUBLvhuzdllLl+8Oy
         wCfz+hOxr/V0f73LYumlcSujygClkypnOjo5lOMDdvmjZtv/Qs/9ZWCoyWnAAi608PzR
         KZLOya9Hmbmqq3JgKqVKf9E6uOgYDgnb+xyc1dK57fRxz7ui+LXkn5NZ4G2Q7GoKrDvm
         GMFw==
X-Received: by 10.180.228.36 with SMTP id sf4mr4858wic.1.1423698668794;
        Wed, 11 Feb 2015 15:51:08 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.186.71 with SMTP id fi7ls21945wic.28.canary; Wed, 11 Feb
 2015 15:51:08 -0800 (PST)
X-Received: by 10.181.13.236 with SMTP id fb12mr21349wid.1.1423698668007;
        Wed, 11 Feb 2015 15:51:08 -0800 (PST)
Received: from mail-wg0-x22d.google.com (mail-wg0-x22d.google.com. [2a00:1450:400c:c00::22d])
        by gmr-mx.google.com with ESMTPS id i7si33799wif.0.2015.02.11.15.51.07
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Feb 2015 15:51:08 -0800 (PST)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::22d as permitted sender) client-ip=2a00:1450:400c:c00::22d;
Received: by mail-wg0-f45.google.com with SMTP id k14so3654920wgh.4
        for <msysgit@googlegroups.com>; Wed, 11 Feb 2015 15:51:07 -0800 (PST)
X-Received: by 10.180.90.206 with SMTP id by14mr927133wib.0.1423698667940;
        Wed, 11 Feb 2015 15:51:07 -0800 (PST)
Received: from [10.1.116.53] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id a5sm129277wib.20.2015.02.11.15.51.06
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Feb 2015 15:51:07 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <54DBEAA5.6000205@gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c00::22d
 as permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263703>

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 compat/mingw.c | 16 ----------------
 compat/mingw.h | 16 ++++++++++++++++
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 70f3191..ba3cfb0 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -419,22 +419,6 @@ int mingw_chmod(const char *filename, int mode)
 	return _wchmod(wfilename, mode);
 }
 
-/*
- * The unit of FILETIME is 100-nanoseconds since January 1, 1601, UTC.
- * Returns the 100-nanoseconds ("hekto nanoseconds") since the epoch.
- */
-static inline long long filetime_to_hnsec(const FILETIME *ft)
-{
-	long long winTime = ((long long)ft->dwHighDateTime << 32) + ft->dwLowDateTime;
-	/* Windows to Unix Epoch conversion */
-	return winTime - 116444736000000000LL;
-}
-
-static inline time_t filetime_to_time_t(const FILETIME *ft)
-{
-	return (time_t)(filetime_to_hnsec(ft) / 10000000);
-}
-
 /* We keep the do_lstat code in a separate function to avoid recursion.
  * When a path ends with a slash, the stat will fail with ENOENT. In
  * this case, we strip the trailing slashes and stat again.
diff --git a/compat/mingw.h b/compat/mingw.h
index 5e499cf..f2a78b4 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -283,6 +283,22 @@ static inline int getrlimit(int resource, struct rlimit *rlp)
 }
 
 /*
+ * The unit of FILETIME is 100-nanoseconds since January 1, 1601, UTC.
+ * Returns the 100-nanoseconds ("hekto nanoseconds") since the epoch.
+ */
+static inline long long filetime_to_hnsec(const FILETIME *ft)
+{
+	long long winTime = ((long long)ft->dwHighDateTime << 32) + ft->dwLowDateTime;
+	/* Windows to Unix Epoch conversion */
+	return winTime - 116444736000000000LL;
+}
+
+static inline time_t filetime_to_time_t(const FILETIME *ft)
+{
+	return (time_t)(filetime_to_hnsec(ft) / 10000000);
+}
+
+/*
  * Use mingw specific stat()/lstat()/fstat() implementations on Windows.
  */
 #define off_t off64_t
-- 
2.3.0.3.ge7778af


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
