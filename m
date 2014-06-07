From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH v2 0/6] First part of Unicode console support for msysgit
Date: Sat,  7 Jun 2014 09:57:19 +0200
Message-ID: <1402127845-4862-1-git-send-email-kasal@ucw.cz>
References: <20140606183935.GA4197@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysGit <msysgit@googlegroups.com>,
	Stepan Kasal <kasal@ucw.cz>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCU63DXMWULRB2ELZOOAKGQERMNYXBI@googlegroups.com Sat Jun 07 09:57:31 2014
Return-path: <msysgit+bncBCU63DXMWULRB2ELZOOAKGQERMNYXBI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f183.google.com ([209.85.217.183])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRB2ELZOOAKGQERMNYXBI@googlegroups.com>)
	id 1WtBVJ-0004YI-4w
	for gcvm-msysgit@m.gmane.org; Sat, 07 Jun 2014 09:57:29 +0200
Received: by mail-lb0-f183.google.com with SMTP id s7sf442254lbd.20
        for <gcvm-msysgit@m.gmane.org>; Sat, 07 Jun 2014 00:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=y8rySLqh8kzmvxcrugM2aG0lKJd/LvSm8XUN2xgOysQ=;
        b=DDqinHnLwCABSbaQbse8SYPiKwApgOJqE6/CIw9lWBrCEdgUGM0RfkbiHERiResW9q
         KiwWo3zsSsXK/bi/bHyloyItoypqF1y0fMuTblbI83ELPqVnExBtcopkYIuccqdmrkMh
         DIDMtPE8N2lBZ7QXYU2T5A3NnFZGbfikkxV74pcTjPjNRVnVL3mn/9XDnudfLbls1L4K
         IY5+5a/tGazxNY8f9+zMn0b1WLxvZcwMHha/ZzWFr2gXOk/nJhAaCI2OruYvP6i2HX7y
         qlCAvkTUJJYSDjfwPIjxRnF40h177Vm+yIg9uhouGMGBKNJC2TysZX5tiJV9/rqflJUa
         ZXYw==
X-Received: by 10.152.26.129 with SMTP id l1mr255lag.38.1402127848846;
        Sat, 07 Jun 2014 00:57:28 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.30.73 with SMTP id q9ls198848lah.23.gmail; Sat, 07 Jun
 2014 00:57:27 -0700 (PDT)
X-Received: by 10.112.14.5 with SMTP id l5mr2674637lbc.6.1402127847852;
        Sat, 07 Jun 2014 00:57:27 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id ck3si803575wib.0.2014.06.07.00.57.27
        for <msysgit@googlegroups.com>;
        Sat, 07 Jun 2014 00:57:27 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id A2DD31C00A0; Sat,  7 Jun 2014 09:57:27 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <20140606183935.GA4197@camelia.ucw.cz>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251034>

Hello,
this patch series is to be applied on top of "move main() macro to a function",
discussed in another thread.

I added the two patches Karsten mentioned:
  Win32: add Unicode conversion functions
  Win32: fix broken pipe detection

I also copied the links for the fixups incuded.

Regards,
	Stepan

Karsten Blees (6):
  Support Unicode console output on Windows
  Detect console streams more reliably on Windows
  Warn if the Windows console font doesn't support Unicode
    includes fixups:
    - https://github.com/msysgit/git/commit/3abcb04d
    - https://github.com/msysgit/git/commit/981aa538
  Win32: add Unicode conversion functions
  Win32: Thread-safe windows console output
    includes fixups:
    - https://github.com/msysgit/git/commit/cd0792af
    - https://github.com/msysgit/git/commit/45e28a4d
  Win32: fix broken pipe detection

 compat/mingw.c   |  94 ++++++++++-
 compat/mingw.h   | 112 +++++++++++++-
 compat/winansi.c | 465 +++++++++++++++++++++++++++++++++++++++++--------------
 3 files changed, 546 insertions(+), 125 deletions(-)

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
