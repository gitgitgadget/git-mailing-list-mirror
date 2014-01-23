From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH v2] Makefile: Fix compilation of Windows resource file
Date: Thu, 23 Jan 2014 08:28:58 +0100
Message-ID: <52E0C4BA.4080405@viscovery.net>
References: <52DD857C.6060005@ramsay1.demon.co.uk>	<xmqqy529t5bb.fsf@gitster.dls.corp.google.com>	<xmqqppnlt3u3.fsf@gitster.dls.corp.google.com>	<52DEF9F2.1000905@ramsay1.demon.co.uk>	<xmqqk3dssxpb.fsf@gitster.dls.corp.google.com>	<52DF6B6C.4020708@viscovery.net>	<xmqq38kgyozt.fsf@gitster.dls.corp.google.com>	<52DFF4E8.8060605@viscovery.net>	<xmqqppnjyl10.fsf@gitster.dls.corp.google.com> <xmqqeh3zydrz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, 
 Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
 GIT Mailing-list <git@vger.kernel.org>, 
 Pat Thoyts <patthoyts@users.sourceforge.net>
To: msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCJYV6HBKQIL7CMDS4CRUBBZRHQZG@googlegroups.com Thu Jan 23 08:29:06 2014
Return-path: <msysgit+bncBCJYV6HBKQIL7CMDS4CRUBBZRHQZG@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f192.google.com ([209.85.217.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCJYV6HBKQIL7CMDS4CRUBBZRHQZG@googlegroups.com>)
	id 1W6Eim-0008Ez-7e
	for gcvm-msysgit@m.gmane.org; Thu, 23 Jan 2014 08:29:04 +0100
Received: by mail-lb0-f192.google.com with SMTP id n15sf129311lbi.29
        for <gcvm-msysgit@m.gmane.org>; Wed, 22 Jan 2014 23:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=tGhDUyjTz8XqOBDl0Cs00ES5oAG+DuKCHepDUJlyY/U=;
        b=wysGnvi9AdIUMHv6Pi6SHsjy7MGkATxGiTD5IwrI+Jh9Uu+Of3MdmzD9oiYbEXU0VQ
         fwaa4kkO9eTSQLN62eOTNd/MZ4oExzcecPFgJWRuj1js30qBsRevPmIoYrV+WBbly4L4
         g4gjuvG24h7yG5Iob16ze+tanoME9moLJzbfYZvhvLLpre8EazWGC6h1KvdclK6nI20a
         jAs/3qaGsdInveyI4TAF9n9Wqs7pFmNMfyEYu7SiHZeiBDIR8Q5Cn39MoizkhSQI0jVX
         faJXbCzxL1bbExfyWjfTQG6aizemUXxiVy9V1nO7J9/Z38r5XFLlL7eMir1IZe1Svj+E
         K68g==
X-Received: by 10.180.183.37 with SMTP id ej5mr192737wic.14.1390462143886;
        Wed, 22 Jan 2014 23:29:03 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.75.206 with SMTP id e14ls54549wiw.18.canary; Wed, 22 Jan
 2014 23:29:02 -0800 (PST)
X-Received: by 10.180.10.234 with SMTP id l10mr13652734wib.0.1390462142963;
        Wed, 22 Jan 2014 23:29:02 -0800 (PST)
Received: from so.liwest.at (so.liwest.at. [212.33.55.18])
        by gmr-mx.google.com with ESMTPS id c48si485963eeb.1.2014.01.22.23.29.02
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 22 Jan 2014 23:29:02 -0800 (PST)
Received-SPF: neutral (google.com: 212.33.55.18 is neither permitted nor denied by best guess record for domain of j.sixt@viscovery.net) client-ip=212.33.55.18;
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1W6Eih-0006gg-Bt; Thu, 23 Jan 2014 08:28:59 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id DA84716613;
	Thu, 23 Jan 2014 08:28:58 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <xmqqeh3zydrz.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Spam-Score: -1.0 (-)
X-Original-Sender: j.sixt@viscovery.net
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: 212.33.55.18 is neither permitted nor denied by best guess
 record for domain of j.sixt@viscovery.net) smtp.mail=j.sixt@viscovery.net
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240903>

From: Johannes Sixt <j6t@kdbg.org>

If the git version number consists of less than three period
separated numbers, then the Windows resource file compilation
issues a syntax error:

  $ touch git.rc
  $ make V=1 git.res
  GIT_VERSION = 1.9.rc0
  windres -O coff \
            -DMAJOR=1 -DMINOR=9 -DPATCH=rc0 \
            -DGIT_VERSION="\\\"1.9.rc0\\\"" git.rc -o git.res
  C:\msysgit\msysgit\mingw\bin\windres.exe: git.rc:2: syntax error
  make: *** [git.res] Error 1
  $

Note that -DPATCH=rc0.

The values passed via -DMAJOR=, -DMINOR=, and -DPATCH= are used in
FILEVERSION and PRODUCTVERSION statements, which expect up to four numeric
values. These version numbers are intended for machine consumption. They
are typically inspected by installers to decide whether a file to be
installed is newer than one that exists on the system, but are not used
for much else.

We can be pretty certain that there are no tools that look at these
version numbers, not even the installer of Git for Windows does.
Therefore, to fix the syntax error, fill in only the first two numbers,
which we are guaranteed to find in Git version numbers.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 That "not even the installer of Git for Windows uses" the FILEVERSION
 numbers is a bold statement of mine (I did not check). If I am wrong,
 this approach for a fix is not viable, and a better fix would be
 needed. Otherwise, an Acked-By would be appreciated so that we can
 have this fix in upstream ASAP.

 Makefile | 2 +-
 git.rc   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index b4af1e2..99b2b89 100644
--- a/Makefile
+++ b/Makefile
@@ -1773,7 +1773,7 @@ $(SCRIPT_LIB) : % : %.sh GIT-SCRIPT-DEFINES
 
 git.res: git.rc GIT-VERSION-FILE
 	$(QUIET_RC)$(RC) \
-	  $(join -DMAJOR= -DMINOR= -DPATCH=, $(wordlist 1,3,$(subst -, ,$(subst ., ,$(GIT_VERSION))))) \
+	  $(join -DMAJOR= -DMINOR=, $(wordlist 1,2,$(subst -, ,$(subst ., ,$(GIT_VERSION))))) \
 	  -DGIT_VERSION="\\\"$(GIT_VERSION)\\\"" $< -o $@
 
 ifndef NO_PERL
diff --git a/git.rc b/git.rc
index bce6db9..33aafb7 100644
--- a/git.rc
+++ b/git.rc
@@ -1,6 +1,6 @@
 1 VERSIONINFO
-FILEVERSION     MAJOR,MINOR,PATCH,0
-PRODUCTVERSION  MAJOR,MINOR,PATCH,0
+FILEVERSION     MAJOR,MINOR,0,0
+PRODUCTVERSION  MAJOR,MINOR,0,0
 BEGIN
   BLOCK "StringFileInfo"
   BEGIN
-- 
1.9.rc0.1179.g5088b55

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
For more options, visit https://groups.google.com/groups/opt_out.
