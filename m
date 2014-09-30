From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 09/14] MINGW: config.mak.uname: reorganize MinGW settings
Date: Tue, 30 Sep 2014 11:02:38 +0400
Message-ID: <1412060563-22041-10-git-send-email-marat@slonopotamus.org>
References: <1412060563-22041-1-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: marat@slonopotamus.org,
	msysGit <msysgit@googlegroups.com>
To: git@vger.kernel.org
X-From: msysgit+bncBCE7TAPITACRBMVLVGQQKGQEPLHEOWI@googlegroups.com Tue Sep 30 09:03:15 2014
Return-path: <msysgit+bncBCE7TAPITACRBMVLVGQQKGQEPLHEOWI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f185.google.com ([74.125.82.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCE7TAPITACRBMVLVGQQKGQEPLHEOWI@googlegroups.com>)
	id 1XYrSs-00007L-Rf
	for gcvm-msysgit@m.gmane.org; Tue, 30 Sep 2014 09:03:14 +0200
Received: by mail-we0-f185.google.com with SMTP id p10sf413122wes.22
        for <gcvm-msysgit@m.gmane.org>; Tue, 30 Sep 2014 00:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=2fFhoLmslgzLuVFWWmiCBWvDIU5qgtccmcd6ttHeReA=;
        b=f+xEI3jLXjwx7rUbLJyuwm+2BcPVlJZis8dOTUnygzYlNk8mx4o3m0XoIlRiX9cMDL
         98Md+EGDxvbSzPHedO5GrdgB6mGMU6Pkix4NultOdo0lnipYeErmJ5y2I3HF2DhI4Kym
         r7ZJ6akhiYJIw+Gkds5Md/Nvq7zbJfgxrvkG1sMNZmQD/A/d+gfXKrpGAd+OpvG+tVgv
         0uX5EDq/SF9VY08L0ZOUreiqq42jqRQeWxKYFsREk3qkXDqIgYsSyP39BdTKxkxcSQKI
         ch60C6XeDrApW2UKOtZiy8JP/Nj4hl8bNSUqJlIL/4qnxAYVRbNos/uZfQKUpl0u9PyY
         0MCQ==
X-Received: by 10.180.91.137 with SMTP id ce9mr77392wib.0.1412060594623;
        Tue, 30 Sep 2014 00:03:14 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.83.41 with SMTP id n9ls588991wiy.10.canary; Tue, 30 Sep
 2014 00:03:14 -0700 (PDT)
X-Received: by 10.194.170.167 with SMTP id an7mr1252683wjc.4.1412060594143;
        Tue, 30 Sep 2014 00:03:14 -0700 (PDT)
Received: from slonopotamus.org ([94.242.204.247])
        by gmr-mx.google.com with ESMTPS id ca20si728744wib.3.2014.09.30.00.03.14
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Sep 2014 00:03:14 -0700 (PDT)
Received-SPF: none (google.com: marat@slonopotamus.org does not designate permitted sender hosts) client-ip=94.242.204.247;
Received: from [185.6.245.138] (helo=radchenko-d-lnx.mail.msk)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1XYrSp-0004X0-3y; Tue, 30 Sep 2014 11:03:11 +0400
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257654>

HAVE_LIBCHARSET_H and NO_R_TO_GCC_LINKER are not specific to
msysGit, they're general MinGW settings.

Logic behind HAVE_LIBCHARSET_H: if user is on MinGW and has iconv,
we expect him to have libcharset.h. If user doesn't have iconv,
he has to explicitly say so via NO_ICONV=1 regardless of this
commit.

Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
---
 config.mak.uname | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index c7aaa1c..f79c0e0 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -532,11 +532,11 @@ ifneq (,$(wildcard ../THIS_IS_MSYSGIT))
 	prefix =
 	INSTALL = /bin/install
 	EXTLIBS += /mingw/lib/libz.a
-	NO_R_TO_GCC_LINKER = YesPlease
 	INTERNAL_QSORT = YesPlease
-	HAVE_LIBCHARSET_H = YesPlease
 	NO_GETTEXT = YesPlease
 endif
+	HAVE_LIBCHARSET_H = YesPlease
+	NO_R_TO_GCC_LINKER = YesPlease
 endif
 ifeq ($(uname_S),QNX)
 	COMPAT_CFLAGS += -DSA_RESTART=0
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
