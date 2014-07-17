From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH 00/13] mingw unicode environment
Date: Thu, 17 Jul 2014 17:37:53 +0200
Message-ID: <1405611486-10176-1-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Karsten Blees <karsten.blees@gmail.com>,
	msysGit <msysgit@googlegroups.com>,
	Stepan Kasal <kasal@ucw.cz>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCU63DXMWULRBZW3T6PAKGQEDK2U75A@googlegroups.com Thu Jul 17 17:38:19 2014
Return-path: <msysgit+bncBCU63DXMWULRBZW3T6PAKGQEDK2U75A@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f185.google.com ([209.85.217.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBZW3T6PAKGQEDK2U75A@googlegroups.com>)
	id 1X7nl9-0008VX-DT
	for gcvm-msysgit@m.gmane.org; Thu, 17 Jul 2014 17:38:15 +0200
Received: by mail-lb0-f185.google.com with SMTP id w7sf185569lbi.2
        for <gcvm-msysgit@m.gmane.org>; Thu, 17 Jul 2014 08:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=ioYpfUiTAOZ+erUWC/3Gh9Lp5cehBzofvA7a3wGQE7w=;
        b=hvcqphdpHXwg3+vDoe/Id0UDCZTQJLR09yYMLmHrBOxVYQeCGerUC+LnDM4QQQbOnq
         egARaxNzY/l5hk90RhGK72LE6nIzZwNqC/J15VkBkXkzfN0tbF8G+WbigA/kzfixrIky
         akfB+MM7iBjSpWDcEemUfOxYK/wRMwRUvijmuwvX/atGE+OjTURTn6SBZtDF0get/UJx
         Pq/5SpiADYGMPBx+VyISSK5r+4n8gf8nFo1bgNwuUQ0BhiFlvIOMY+MertSDm+GcK9Cx
         Dihc8gdZhkVgKkYZa/TsMxDS/xzqwKbc/RCLvXlSa8wqCcESnWNOA0RdlyN1moSUnpK8
         4HhA==
X-Received: by 10.180.85.232 with SMTP id k8mr94611wiz.21.1405611495162;
        Thu, 17 Jul 2014 08:38:15 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.81.229 with SMTP id d5ls924082wiy.5.canary; Thu, 17 Jul
 2014 08:38:14 -0700 (PDT)
X-Received: by 10.180.85.39 with SMTP id e7mr2139954wiz.0.1405611494479;
        Thu, 17 Jul 2014 08:38:14 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id r19si911026wik.0.2014.07.17.08.38.14
        for <msysgit@googlegroups.com>;
        Thu, 17 Jul 2014 08:38:14 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id 51C941C0196; Thu, 17 Jul 2014 17:38:14 +0200 (CEST)
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
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253749>

Hello,

this is the remainder of Karsten's unicode branch, that is a time
proven part of msysGit.  (If this code is accepted, only one patch
would only remain: gitk and git-gui fixes.)

When rebasing Karsten's work, I have eliminated two commits:
https://github.com/msysgit/git/commit/f967550
https://github.com/msysgit/git/commit/290bf81

These commits only moved code down and up; this was not necessary, one
forward declaration was all I needed.

One of the patches differs from the original version: "Enable color..."
Following Karsten's suggestion, I have changed the value of env. var.
TERM from "winterm" to "cygwin".  This is because the subprocesses see
the variable and may try to find it in (their copy of) termcap.

Enjoy,
   Stepan

Karsten Blees (13):
  Revert "Windows: teach getenv to do a case-sensitive search"
  Win32: Unicode environment (outgoing)
  Win32: Unicode environment (incoming)
  Win32: fix environment memory leaks
  Win32: unify environment case-sensitivity
  Win32: unify environment function names
  Win32: factor out environment block creation
  Win32: don't copy the environment twice when spawning child processes
  Win32: reduce environment array reallocations
  Win32: use low-level memory allocation during initialization
  Win32: keep the environment sorted
  Win32: patch Windows environment on startup
  Enable color output in Windows cmd.exe

 compat/mingw.c   | 290 +++++++++++++++++++++++++++++++------------------------
 compat/mingw.h   |  11 +--
 config.mak.uname |   2 -
 run-command.c    |  10 +-
 4 files changed, 170 insertions(+), 143 deletions(-)

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
