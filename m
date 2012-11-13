From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH 0/5] win32: support echo for terminal-prompt
Date: Tue, 13 Nov 2012 15:01:23 +0100
Message-ID: <1352815288-3996-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: peff@peff.net
To: git@vger.kernel.org,
	msysgit@googlegroups.com
X-From: msysgit+bncBDR53PPJ7YHRBS5FRGCQKGQEBE5E3WI@googlegroups.com Tue Nov 13 15:01:59 2012
Return-path: <msysgit+bncBDR53PPJ7YHRBS5FRGCQKGQEBE5E3WI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f186.google.com ([209.85.217.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBS5FRGCQKGQEBE5E3WI@googlegroups.com>)
	id 1TYH3u-0002hJ-QN
	for gcvm-msysgit@m.gmane.org; Tue, 13 Nov 2012 15:01:58 +0100
Received: by mail-lb0-f186.google.com with SMTP id y2sf1038099lbk.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 13 Nov 2012 06:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=UlZHWstzQaOGUbWaHXXE32gqwVcWrNv1hsKijLLlLw8=;
        b=PIdzHYa3va84ft61/e6owVXu80HwrzVjE/YSKKUciVpJ/VTB4L0K47rWhrXBZtDAqR
         jMVZqlNT8QHp004unxhi0BZ3Xn7EZSwkMpuvK+Ag2H5kgKlT9EriwQuFYNyjt9cRVhN3
         97G7qMQYLdOOtIUzcq107Xx152xRP+/aIJxQUUMS7ZnLxmW/4WWH2bQQOn+Jbzf2CXec
         vcwFfcjpCF0FVnbhNEmDkQql6rYfFZhVTK533HDKTuFAA9J8f1KJwbmE4KDQJYyL8TfT
         KLmGjQjAApvFimd88ghAdkgBFhNkwXbbh4SxfLrIcfbMQJzRBlEYr+jNnq2A1gqdYhCl
         0QvQ==
Received: by 10.204.129.220 with SMTP id p28mr2088176bks.1.1352815308990;
        Tue, 13 Nov 2012 06:01:48 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.204.131.72 with SMTP id w8ls7888012bks.3.gmail; Tue, 13 Nov
 2012 06:01:47 -0800 (PST)
Received: by 10.204.129.9 with SMTP id m9mr1736437bks.1.1352815307101;
        Tue, 13 Nov 2012 06:01:47 -0800 (PST)
Received: by 10.204.129.9 with SMTP id m9mr1736436bks.1.1352815307081;
        Tue, 13 Nov 2012 06:01:47 -0800 (PST)
Received: from mail-lb0-f169.google.com (mail-lb0-f169.google.com [209.85.217.169])
        by gmr-mx.google.com with ESMTPS id x17si827417bkw.3.2012.11.13.06.01.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Nov 2012 06:01:47 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.217.169 as permitted sender) client-ip=209.85.217.169;
Received: by mail-lb0-f169.google.com with SMTP id gk1so506731lbb.28
        for <msysgit@googlegroups.com>; Tue, 13 Nov 2012 06:01:46 -0800 (PST)
Received: by 10.112.39.100 with SMTP id o4mr9433554lbk.23.1352815306851;
        Tue, 13 Nov 2012 06:01:46 -0800 (PST)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id f3sm3825785lbm.11.2012.11.13.06.01.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Nov 2012 06:01:45 -0800 (PST)
X-Mailer: git-send-email 1.8.0.msysgit.0.1.g1cbcfae.dirty
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.217.169 as permitted sender)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209603>

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
