From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH] tests: turn off git-daemon tests if FIFOs are not available
Date: Thu, 29 May 2014 13:36:14 +0200
Organization: <)><
Message-ID: <20140529113614.GA24293@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysgit@googlegroups.com
To: GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCU63DXMWULRBMFXTSOAKGQEQFUTNNA@googlegroups.com Thu May 29 13:36:17 2014
Return-path: <msysgit+bncBCU63DXMWULRBMFXTSOAKGQEQFUTNNA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f59.google.com ([74.125.82.59])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBMFXTSOAKGQEQFUTNNA@googlegroups.com>)
	id 1Wpyd7-0007P4-57
	for gcvm-msysgit@m.gmane.org; Thu, 29 May 2014 13:36:17 +0200
Received: by mail-wg0-f59.google.com with SMTP id x12sf20851wgg.4
        for <gcvm-msysgit@m.gmane.org>; Thu, 29 May 2014 04:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:mime-version:organization
         :user-agent:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type
         :content-disposition;
        bh=ZujVwpSPvFFhWiOUydyhZ6+X1LtwdWiu/kd5gP0pT8Q=;
        b=QZFdkeUkKj1Dj1ek/4hQ8Nmw14d2pQhkfWj4qdj3lWPyQMb/7X+zHbYcXr4ny8URXT
         xFD7/4O5b6fab2viVCnJ1m83Hpg4AEnzOBDHQJfC4PvyNpaVjkrh6Ot5MUPAzbOKFvSg
         fHmbcmELxEJO+bIm1M8nX1q4NMe9U926ileVoZzMrL5ePHuawrh+HTNt+eWNeymoAoj/
         21DnjJJ4wfr4iOnGDrgVejTi62sOT2FupLzgb6i54Bm8iEAaAcK4n0L4aVreCNp9LFWH
         5l8uH/HugE324Mkv8MZYY6ClMeWWP9D5tx2N1OKLoA6uNdjOMxHDU/cnVrUWTGcvK3KF
         tGog==
X-Received: by 10.180.72.48 with SMTP id a16mr114073wiv.17.1401363376502;
        Thu, 29 May 2014 04:36:16 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.24.102 with SMTP id t6ls176467wif.33.gmail; Thu, 29 May
 2014 04:36:15 -0700 (PDT)
X-Received: by 10.180.74.44 with SMTP id q12mr795118wiv.4.1401363375636;
        Thu, 29 May 2014 04:36:15 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id g42si447407eev.1.2014.05.29.04.36.15
        for <msysgit@googlegroups.com>;
        Thu, 29 May 2014 04:36:15 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 50DDE1C00EF;
	Thu, 29 May 2014 13:36:15 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s4TBaFxB024308;
	Thu, 29 May 2014 13:36:15 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s4TBaEhH024307;
	Thu, 29 May 2014 13:36:14 +0200
User-Agent: Mutt/1.5.19 (2009-01-05)
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
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250362>

Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---

Hi,
  mingw does not have FIFOs, so it cannot run git-daemon tests.
Stepan

 t/lib-git-daemon.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh
index bc4b341..9b1271c 100644
--- a/t/lib-git-daemon.sh
+++ b/t/lib-git-daemon.sh
@@ -23,6 +23,11 @@ then
 	test_done
 fi
 
+if ! test_have_prereq PIPE
+then
+	test_skip_or_die $GIT_TEST_GIT_DAEMON "file system does not support FIFOs"
+fi
+
 LIB_GIT_DAEMON_PORT=${LIB_GIT_DAEMON_PORT-${this_test#t}}
 
 GIT_DAEMON_PID=
-- 
1.9.2.msysgit.0.493.g4becbf6.dirty

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
