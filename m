From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH 0/5] Windows dirent patches
Date: Fri,  6 Jun 2014 15:43:16 +0200
Message-ID: <1402062201-9709-1-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysGit <msysgit@googlegroups.com>,
	Stepan Kasal <kasal@ucw.cz>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCU63DXMWULRBAMLY6OAKGQE5IXTXZI@googlegroups.com Fri Jun 06 15:43:36 2014
Return-path: <msysgit+bncBCU63DXMWULRBAMLY6OAKGQE5IXTXZI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f57.google.com ([209.85.215.57])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBAMLY6OAKGQE5IXTXZI@googlegroups.com>)
	id 1WsuQc-0000p1-1h
	for gcvm-msysgit@m.gmane.org; Fri, 06 Jun 2014 15:43:30 +0200
Received: by mail-la0-f57.google.com with SMTP id hr17sf317432lab.22
        for <gcvm-msysgit@m.gmane.org>; Fri, 06 Jun 2014 06:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=K4KqJPui/tpWaWjzTsr3NpciJdxoCAA8CCub3bAvUqw=;
        b=AjF+x5zqI43xBkhSCq0USzuSuwF4aJs7U6d2jgesZd7M7yxVc/52Thlhd4TGWLXa9W
         iMMQbefPcwYobAGygO+J4BOzetS3iP9vWBCNpR/gTYPKRrefVAsln/2Tb9W5k5ZhrYue
         C028ilP/w3f+3xF6p3Sr0oWj894YuKij9JZ7xfelkxIeFueww4VBmszybY2QKEQNZ6as
         M2rhSOgxulIC3zIKd99j9V93Pzdn6GdWCcP1WCeoMcQZaGmzVs31zhRTVRpeAqqxiRAJ
         i468x3AyepEsm5Yh7ZilhIn+Oq0A7/8dp57jo4wTl+ZbuPfKqz+P9vZm99/TrXvF61xk
         Z4Qg==
X-Received: by 10.152.28.6 with SMTP id x6mr7873lag.32.1402062209885;
        Fri, 06 Jun 2014 06:43:29 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.87.178 with SMTP id az18ls133653lab.4.gmail; Fri, 06 Jun
 2014 06:43:29 -0700 (PDT)
X-Received: by 10.152.43.3 with SMTP id s3mr1315917lal.5.1402062209256;
        Fri, 06 Jun 2014 06:43:29 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id x7si1305907wiw.1.2014.06.06.06.43.29
        for <msysgit@googlegroups.com>;
        Fri, 06 Jun 2014 06:43:29 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id 1B6071C009F; Fri,  6 Jun 2014 15:43:29 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.4
X-Original-Sender: kasal@ucw.cz
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: kasal@ucw.cz does not designate permitted sender hosts) smtp.mail=kasal@ucw.cz
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250913>

Hello,

This is a series of dirent modifications, 4 tiny ones and one bigger.
As the date indicates, these are battle tested in mysgit for several years.

Regards,
	Stepan

Karsten Blees (5):
  Win32 dirent: remove unused dirent.d_ino member
  Win32 dirent: remove unused dirent.d_reclen member
  Win32 dirent: change FILENAME_MAX to MAX_PATH
  Win32 dirent: clarify #include directives
  Win32 dirent: improve dirent implementation

 compat/win32/dirent.c | 116 ++++++++++++++++++++++++--------------------------
 compat/win32/dirent.h |   8 +---
 config.mak.uname      |   2 +
 3 files changed, 59 insertions(+), 67 deletions(-)

-- 
2.0.0.9635.g0be03cb

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
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
