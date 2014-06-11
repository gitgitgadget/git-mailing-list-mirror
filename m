From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH 0/7] Second part of msysgit/unicode
Date: Wed, 11 Jun 2014 11:37:39 +0200
Message-ID: <1402479466-8500-1-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysGit <msysgit@googlegroups.com>,
	Stepan Kasal <kasal@ucw.cz>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCU63DXMWULRB7OG4COAKGQEU5PATQQ@googlegroups.com Wed Jun 11 11:38:08 2014
Return-path: <msysgit+bncBCU63DXMWULRB7OG4COAKGQEU5PATQQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f190.google.com ([209.85.212.190])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRB7OG4COAKGQEU5PATQQ@googlegroups.com>)
	id 1Wueys-0004Jp-D9
	for gcvm-msysgit@m.gmane.org; Wed, 11 Jun 2014 11:38:06 +0200
Received: by mail-wi0-f190.google.com with SMTP id bs8sf71254wib.27
        for <gcvm-msysgit@m.gmane.org>; Wed, 11 Jun 2014 02:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=BVYHsZdqd/DyVpPPuVqvs4ixSdOwiGZ8ZqhjsutaYJU=;
        b=nQOR8MZgSwUqJzpNX4YVHC2LFAb6IGr1xlrWIPPglCdfkO3cZQSlFRGirjnZE9ht5H
         FSdPqo/gjplJ5uVKmv+KytSESfSFZ9y4d7DB8d/VSjKxOacTR3HY/B25lTVeOY0hj5j1
         DyYRckMNLPiKkMCeSpPjmgOhFkWy95Xc4wQNn3ehxK4bfnGViveRyEKfo+s1JK08RgmT
         gbDt00md6KtROzJXfI7NUCxQIEt43T1rAU3jP14iykWhFkNY5tzVcITAZpO/S+mp9hjD
         q9jUjtENrtNLAh6CBSLibiGnDnpRD3YU2csnSjvpF1hoQAclse4eIWGt4WerUokpe+l3
         1Qbw==
X-Received: by 10.152.42.225 with SMTP id r1mr8062lal.13.1402479486161;
        Wed, 11 Jun 2014 02:38:06 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.36.167 with SMTP id r7ls432030laj.10.gmail; Wed, 11 Jun
 2014 02:38:04 -0700 (PDT)
X-Received: by 10.112.140.170 with SMTP id rh10mr4799248lbb.7.1402479484793;
        Wed, 11 Jun 2014 02:38:04 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id gz10si1289239wib.0.2014.06.11.02.38.04
        for <msysgit@googlegroups.com>;
        Wed, 11 Jun 2014 02:38:04 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id 870E81C009B; Wed, 11 Jun 2014 11:38:04 +0200 (CEST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251350>

This is the second part of the time-proven unicode suport branch from msysgit.
This batch is a collection of small independent changes, limited to mingw.c.
The only exception is the last patch: it changes gitk and git-gui.

(The third and last part of msysgit/unicode branch will all be about
environment handling.)

Johannes Schindelin (1):
  Let mingw_execve() return an int

Karsten Blees (6):
  Win32: simplify internal mingw_spawn* APIs
  Win32: fix potential multi-threading issue
  MinGW: disable CRT command line globbing
  Win32: Unicode arguments (outgoing)
  Win32: Unicode arguments (incoming)
    - also contains small part of 8c452ca Win32: use low-level memory alloc...
  Unicode file name support (gitk and git-gui)

 compat/mingw.c          | 94 +++++++++++++++++++++++++++++++++++++------------
 git-gui/git-gui.sh      | 11 +++---
 git-gui/lib/browser.tcl |  2 +-
 git-gui/lib/index.tcl   |  6 ++--
 gitk-git/gitk           | 15 ++++----
 5 files changed, 90 insertions(+), 38 deletions(-)

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
