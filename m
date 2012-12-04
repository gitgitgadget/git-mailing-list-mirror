From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v2 0/6] win32: support echo for terminal-prompt
Date: Tue,  4 Dec 2012 09:10:36 +0100
Message-ID: <1354608642-5316-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysgit@googlegroups.com,
	johannes.schindelin@gmx.de,
	gitster@pobox.com,
	peff@peff.net
To: git@vger.kernel.org
X-From: msysgit+bncBDR53PPJ7YHRBI7A62CQKGQEKZCCE2Y@googlegroups.com Tue Dec 04 09:11:29 2012
Return-path: <msysgit+bncBDR53PPJ7YHRBI7A62CQKGQEKZCCE2Y@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ee0-f58.google.com ([74.125.83.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBI7A62CQKGQEKZCCE2Y@googlegroups.com>)
	id 1TfnbD-0004e1-Vj
	for gcvm-msysgit@m.gmane.org; Tue, 04 Dec 2012 09:11:28 +0100
Received: by mail-ee0-f58.google.com with SMTP id e49sf1485824eek.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 04 Dec 2012 00:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=wrHbMpJgMjt9TqcO2q3gGhS8VrhVi/MuuAxYAQSkgHo=;
        b=kkRewDU4E5+BPFccKijCIxQv3PwFsP+VKdoJNoUQDHjAw3XAoDuyUmRpq8c6hUU8f5
         bcoMn+yrPwHbdMPK9XEbUq2frNwwAs6AEzlttCtCuiMpwQ8SfoLjOB68MJc4ncsjg3z5
         71WqsI1azIA5yknHKT/m6GQ51BJYd/XTxJXovSEcdH+M4bHTemVJcG4vaqPCfEnU4QUY
         ZCduwV5mTQE3TUNVnPme/w2oWrT0bxxMq8+3miAmFt0J56eMWvq0Z7xLBD2H/HqWO85y
         MmYPQw1XTsl4PTHoO+hhI7KHrIN2UC4FT8xO7dMG5jQ4xn+Vmq2bgOvPLfg8hi7emucZ
         lC3A==
Received: by 10.180.95.201 with SMTP id dm9mr326557wib.8.1354608676192;
        Tue, 04 Dec 2012 00:11:16 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.8.193 with SMTP id t1ls1247614wia.14.canary; Tue, 04 Dec
 2012 00:11:15 -0800 (PST)
Received: by 10.204.145.215 with SMTP id e23mr1790002bkv.0.1354608675503;
        Tue, 04 Dec 2012 00:11:15 -0800 (PST)
Received: by 10.204.145.215 with SMTP id e23mr1790001bkv.0.1354608675487;
        Tue, 04 Dec 2012 00:11:15 -0800 (PST)
Received: from mail-la0-f42.google.com (mail-la0-f42.google.com [209.85.215.42])
        by gmr-mx.google.com with ESMTPS id l1si44247bka.2.2012.12.04.00.11.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 04 Dec 2012 00:11:15 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.215.42 as permitted sender) client-ip=209.85.215.42;
Received: by mail-la0-f42.google.com with SMTP id s15so5989644lag.1
        for <msysgit@googlegroups.com>; Tue, 04 Dec 2012 00:11:15 -0800 (PST)
Received: by 10.152.106.4 with SMTP id gq4mr11944354lab.44.1354608675168;
        Tue, 04 Dec 2012 00:11:15 -0800 (PST)
Received: from localhost (cm-84.215.107.111.getinternet.no. [84.215.107.111])
        by mx.google.com with ESMTPS id u9sm293686lbf.5.2012.12.04.00.11.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 04 Dec 2012 00:11:14 -0800 (PST)
X-Mailer: git-send-email 1.7.11.msysgit.0.5.g0225efe.dirty
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.215.42 as permitted sender)
 smtp.mail=kusmabite@gmail.com; dkim=pass header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211070>

So here's v2 of this series. For reference, you can find v1 and
it's discussions here: 

http://mid.gmane.org/1352815288-3996-1-git-send-email-kusmabite@gmail.com

The changes since the last round:
 * 1/6: This patch has been added. It was missing in the last round,
        due to stupidity on my behalf. I'm sorry about that.
 * 3/6: This patch got a fixup for the disable_echo function signature
        squashed in. I forgot "void" for the empty parameter list.
	Thanks to Junio for noticing.

Otherwise, things are unchanged.

Erik Faye-Lund (6):
  mingw: correct exit-code for SIGALRM's SIG_DFL
  mingw: make fgetc raise SIGINT if apropriate
  compat/terminal: factor out echo-disabling
  compat/terminal: separate input and output handles
  mingw: reuse tty-version of git_terminal_prompt
  mingw: get rid of getpass implementation

 compat/mingw.c    |  88 +++++++++++++++++++++++++++----------
 compat/mingw.h    |   8 +++-
 compat/terminal.c | 129 ++++++++++++++++++++++++++++++++++++++++--------------
 3 files changed, 169 insertions(+), 56 deletions(-)

-- 
1.8.0.4.g3c6fb4f.dirty

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
