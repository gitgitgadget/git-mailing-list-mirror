From: Marat Radchenko <marat@slonopotamus.org>
Subject: MinGW(-W64) compilation
Date: Sun, 28 Sep 2014 17:24:16 +0400
Message-ID: <1411910670-31285-1-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: marat@slonopotamus.org,
	msysGit <msysgit@googlegroups.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: msysgit+bncBCE7TAPITACRBX4YUCQQKGQEICMSZZY@googlegroups.com Sun Sep 28 15:25:56 2014
Return-path: <msysgit+bncBCE7TAPITACRBX4YUCQQKGQEICMSZZY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f185.google.com ([209.85.212.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCE7TAPITACRBX4YUCQQKGQEICMSZZY@googlegroups.com>)
	id 1XYEU5-0000Ar-5P
	for gcvm-msysgit@m.gmane.org; Sun, 28 Sep 2014 15:25:53 +0200
Received: by mail-wi0-f185.google.com with SMTP id cc10sf27923wib.12
        for <gcvm-msysgit@m.gmane.org>; Sun, 28 Sep 2014 06:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=4zZiVC9vvBR2dkCnZt0PNUaTbmAOd26oXJv9nTtffVI=;
        b=knMJHKgfowGae+Fn3SgExrWo2Que6s0oqi972mSWT2dF3FR3+us1NLfPxmtRlbNlk6
         887oNOCudZ2OOuI1o+eiO3JOQRMuuecDgKBsh4nCayzPgcnAlE8mseEfLlMG1U/ds4Ig
         VHU9kmlgKIyXgMJi0ymlpka/CiiHMABsjAE2HcQQcDClzGOLuWe27QCxHr8OSzy42voM
         yL0WFmuXVKaF1kkMxWgyRNddSnJOFSjqake1IivTBIyK4pMH+oFr4RG5NOe9B67YizRG
         RN0iAYrzp6JEASCRfb5pIbjVOq3Y5dA5Nrz6r+9wj6dosqTf2gcipv43Ccy3xOgp+n9V
         mbLQ==
X-Received: by 10.152.19.226 with SMTP id i2mr31547lae.5.1411910752785;
        Sun, 28 Sep 2014 06:25:52 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.20.201 with SMTP id p9ls515240lae.15.gmail; Sun, 28 Sep
 2014 06:25:50 -0700 (PDT)
X-Received: by 10.112.76.229 with SMTP id n5mr337007lbw.8.1411910750504;
        Sun, 28 Sep 2014 06:25:50 -0700 (PDT)
Received: from slonopotamus.org ([94.242.204.247])
        by gmr-mx.google.com with ESMTPS id el4si421303wid.1.2014.09.28.06.25.50
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Sep 2014 06:25:50 -0700 (PDT)
Received-SPF: none (google.com: marat@slonopotamus.org does not designate permitted sender hosts) client-ip=94.242.204.247;
Received: from [176.57.72.72] (helo=noblesse.home.ru)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1XYETy-0000Yl-Ja; Sun, 28 Sep 2014 17:25:47 +0400
X-Mailer: git-send-email 2.1.1
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257599>

This patch series fixes building on modern MinGW and MinGW-W64 (including x86_64!).

*Compilation* tested on:
 - MSVC (via WinGit environment)
 - msysGit environment
 - Linux cross-toolchain i686-pc-mingw32
 - Linux cross-toolchain i686-w64-mingw32
 - Linux cross-toolchain x86_64-w64-mingw32

Attention: in order to build on MinGW-W64, you need to use 'sf/v3.x' branch
from MinGW-W64 repo because MinGW-W64 releases do not yet have a fix
for https://sourceforge.net/p/mingw-w64/bugs/397

Workaround that allows to also build on older MinGW-W64 is currently
pending [1] on gnulib ML. If it is accepted, same fix [2] can be applied
to Git copy of poll.c.

[1]: http://lists.gnu.org/archive/html/bug-gnulib/2014-09/msg00076.html
[2]: http://git.661346.n2.nabble.com/PATCH-v2-MinGW-W64-cross-compilation-tp7609085p7609093.html

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
