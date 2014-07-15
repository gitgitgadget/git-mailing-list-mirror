From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH 0/3] fix test suite with mingw-unicode patches
Date: Tue, 15 Jul 2014 15:43:14 +0200
Message-ID: <1405431797-20899-1-git-send-email-kasal@ucw.cz>
References: <20140712075035.GA12400@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: GIT Mailing-list <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>,
	Stepan Kasal <kasal@ucw.cz>
To: Karsten Blees <karsten.blees@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
X-From: msysgit+bncBCU63DXMWULRB767SSPAKGQEKNW2XJI@googlegroups.com Tue Jul 15 15:43:28 2014
Return-path: <msysgit+bncBCU63DXMWULRB767SSPAKGQEKNW2XJI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f189.google.com ([74.125.82.189])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRB767SSPAKGQEKNW2XJI@googlegroups.com>)
	id 1X730y-00077Q-Cd
	for gcvm-msysgit@m.gmane.org; Tue, 15 Jul 2014 15:43:28 +0200
Received: by mail-we0-f189.google.com with SMTP id p10sf321855wes.26
        for <gcvm-msysgit@m.gmane.org>; Tue, 15 Jul 2014 06:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=Llo99zbZFwUR0MG0Sxv64IOkXRYD9R7OToaHG9EbUkc=;
        b=DYTxFli4oBvkt2yGipFVskGXql19S7AO28NNyD54UJ2e5c6AH2wBhWalSHorsZKPhj
         tT2AddYZAl2dUFW7Irvs5952vNbG3db8t2l4xH73LXcO5dm29OOVecI4SoLFZNuJ1v9u
         0tMmg1xDhKVUpR/tA2G96IFX5+xyq8k1bbgQjtxqXs3SYMgA+pcpQQUTAsrYX+nVQbWs
         5pxucNzTOsCJkNOSEqzAjJRXdRPWhEWEIS97QEfKk90TNFxw9msF/pNuFrWsK14PLHWB
         tUixpVGImM8doAlr92v6U6cuC5BRaSiiHXf+ZxREnqV/tsnLDDNaEq3JNBc9d0v+KhSF
         AI8Q==
X-Received: by 10.180.73.180 with SMTP id m20mr19084wiv.14.1405431807919;
        Tue, 15 Jul 2014 06:43:27 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.99.137 with SMTP id eq9ls97795wib.37.gmail; Tue, 15 Jul
 2014 06:43:27 -0700 (PDT)
X-Received: by 10.194.143.109 with SMTP id sd13mr234754wjb.6.1405431806704;
        Tue, 15 Jul 2014 06:43:26 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id r13si650344wib.0.2014.07.15.06.43.26
        for <msysgit@googlegroups.com>;
        Tue, 15 Jul 2014 06:43:26 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id 8261B1C014E; Tue, 15 Jul 2014 15:43:26 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <20140712075035.GA12400@ucw.cz>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253556>

Hello Hannes,
attached please find the patches that Karsten pointed out:

1) The unicode file name support was omitted from his unicode patch
series; my mistake, sorry.  There is still big part missing: support
for unicode environment; I can only hope the tests would choke on
that.

2) Windows cannot pass non-UTF parameters (commit messages in this
case): original patch by Pat Thoyts was extended to apply to other
similar cases: the commit msg is passed through stdin.

If there are still problems remaining, please tell us.

Thanks,
	Stepan

Karsten Blees (2):
  Win32: Unicode file name support (except dirent)
  Win32: Unicode file name support (dirent)

Pat Thoyts and Stepan Kasal(1):
  tests: do not pass iso8859-1 encoded parameter

 compat/mingw.c                   | 198 +++++++++++++++++++++++++++++----------
 compat/mingw.h                   |  18 +++-
 compat/win32/dirent.c            |  30 ++----
 compat/win32/dirent.h            |   2 +-
 t/t4041-diff-submodule-option.sh |   6 +-
 t/t4205-log-pretty-formats.sh    |   2 +-
 t/t6006-rev-list-format.sh       |   4 +-
 t/t7102-reset.sh                 |   8 +-
 8 files changed, 184 insertions(+), 84 deletions(-)

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
