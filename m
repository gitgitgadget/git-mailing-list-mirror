From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH/RFC 0/5] win32: support echo for terminal-prompt
Date: Tue, 13 Nov 2012 15:04:02 +0100
Message-ID: <1352815447-8824-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: peff@peff.net
To: git@vger.kernel.org,
	msysgit@googlegroups.com
X-From: msysgit+bncBDR53PPJ7YHRB2NGRGCQKGQETGGFH2I@googlegroups.com Tue Nov 13 15:04:36 2012
Return-path: <msysgit+bncBDR53PPJ7YHRB2NGRGCQKGQETGGFH2I@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f58.google.com ([209.85.215.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRB2NGRGCQKGQETGGFH2I@googlegroups.com>)
	id 1TYH6R-0003t8-Gj
	for gcvm-msysgit@m.gmane.org; Tue, 13 Nov 2012 15:04:35 +0100
Received: by mail-la0-f58.google.com with SMTP id p5sf2505325lag.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 13 Nov 2012 06:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=UlZHWstzQaOGUbWaHXXE32gqwVcWrNv1hsKijLLlLw8=;
        b=gHsUv0tW81Lih/opCZMjbIXGDs67q0chnD+DhFJTwk5X1udlilWrpiw9Z4sToUSGkM
         +lXU0TW5uPOFsMoey86CPgyOWcQxlPa/2X1Vr5j07xnG7TNDR3a6W9kM6FifrEpE+znH
         1bmNoF/C89euMH0Qao+XhPO4IXsUoaFQVxqmRl1La03oAlf3DbSfUx+r3gXm32Etp8vq
         x6yemqIhvb2LPhQSR9OTk3xK+7ySKufqCyuc0f//zdgsSeC1Ar+AJAfeGYsAo506YVRQ
         PtwSp2IYRJh8lP+L43yx+61P6f7S/PCgBmusIfQjbV56+45Y3OVqKFSHdoZvvU2y55pA
         Z0+A==
Received: by 10.204.4.198 with SMTP id 6mr308903bks.5.1352815465935;
        Tue, 13 Nov 2012 06:04:25 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.204.11.220 with SMTP id u28ls4872934bku.4.gmail; Tue, 13 Nov
 2012 06:04:25 -0800 (PST)
Received: by 10.204.145.140 with SMTP id d12mr1745194bkv.6.1352815464953;
        Tue, 13 Nov 2012 06:04:24 -0800 (PST)
Received: by 10.204.145.140 with SMTP id d12mr1745191bkv.6.1352815464893;
        Tue, 13 Nov 2012 06:04:24 -0800 (PST)
Received: from mail-la0-f53.google.com (mail-la0-f53.google.com [209.85.215.53])
        by gmr-mx.google.com with ESMTPS id l1si828339bka.2.2012.11.13.06.04.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Nov 2012 06:04:24 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.215.53 as permitted sender) client-ip=209.85.215.53;
Received: by mail-la0-f53.google.com with SMTP id w12so2929679lag.12
        for <msysgit@googlegroups.com>; Tue, 13 Nov 2012 06:04:24 -0800 (PST)
Received: by 10.112.83.7 with SMTP id m7mr2758246lby.15.1352815464697;
        Tue, 13 Nov 2012 06:04:24 -0800 (PST)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id jk8sm3830840lab.7.2012.11.13.06.04.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Nov 2012 06:04:23 -0800 (PST)
X-Mailer: git-send-email 1.8.0.msysgit.0.1.g1cbcfae.dirty
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.215.53 as permitted sender)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209604>

We currently only support getpass, which does not echo at all, for
git_terminal_prompt on Windows. The Windows console is perfectly
capable of doing this, so let's make it so.

This implementation tries to reuse the /dev/tty-code as much as
possible.

The big reason that this becomes a bit hairy is that Ctrl+C needs
to be handled correctly, so we don't leak the console state to a
non-echoing setting when a user aborts.

Windows makes this bit a little bit tricky, in that we need to
implement SIGINT for fgetc. However, I suspect that this is a good
thing to do in the first place.

An earlier iteration was also breifly discussed here:
http://mid.gmane.org/CABPQNSaUCEDU4+2N63n0k_XwSXOP_iFZG3GEYSPSBPcSVV8wRQ@mail.gmail.com

The series can also be found here, only with an extra patch that
makes the (interactive) testing a bit easier:

https://github.com/kusma/git/tree/work/terminal-cleanup

Erik Faye-Lund (5):
  mingw: make fgetc raise SIGINT if apropriate
  compat/terminal: factor out echo-disabling
  compat/terminal: separate input and output handles
  mingw: reuse tty-version of git_terminal_prompt
  mingw: get rid of getpass implementation

 compat/mingw.c    |  91 +++++++++++++++++++++++++++-----------
 compat/mingw.h    |   8 +++-
 compat/terminal.c | 129 ++++++++++++++++++++++++++++++++++++++++--------------
 3 files changed, 169 insertions(+), 59 deletions(-)

-- 
1.8.0.7.gbeffeda

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
