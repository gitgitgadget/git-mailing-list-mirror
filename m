From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH 0/5] First part of Unicode console support for msysgit
Date: Fri,  6 Jun 2014 15:42:48 +0200
Message-ID: <1402062173-9602-1-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysGit <msysgit@googlegroups.com>,
	Stepan Kasal <kasal@ucw.cz>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCU63DXMWULRB5EKY6OAKGQEC7CDM2I@googlegroups.com Fri Jun 06 15:43:24 2014
Return-path: <msysgit+bncBCU63DXMWULRB5EKY6OAKGQEC7CDM2I@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f57.google.com ([74.125.82.57])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRB5EKY6OAKGQEC7CDM2I@googlegroups.com>)
	id 1WsuQP-0000fN-4G
	for gcvm-msysgit@m.gmane.org; Fri, 06 Jun 2014 15:43:17 +0200
Received: by mail-wg0-f57.google.com with SMTP id l18sf317540wgh.2
        for <gcvm-msysgit@m.gmane.org>; Fri, 06 Jun 2014 06:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=KRRqnv1IfTF32kn14Jo37V7hIGr3JXTySCkixmAESIE=;
        b=PmMKtU9/0ZIjHbNPeouE3K6Bp4wxsuIPvwz79NRyeK64IjMvhRMPQJaJdiK+zQXpDH
         HmN9vIvulLTiPEJh7yjlmA+6aR45bolrqhW2ScioEdFpNNdO8v13HlLsTg+B0eZsXsWn
         vU+yBk2UsCzYTJeiWAvVCm/ku6JCLRTVpWOdfIirYnB4U4ooO5OFfbPS69rfErrH748M
         ZEeRvTLc3yZMaxOCwtos89r9KoLtmwEmvaO0iBPIh/dhKlJwGAL8/vd3gj1G6Z7a/wUS
         NB/qYQOoyfdkPuYZks6Syzx8eOsu6gE4TKsqDbvMvcTfVw/IgfojthOQuNkz4IrVseBV
         A0zg==
X-Received: by 10.152.36.100 with SMTP id p4mr14889laj.14.1402062196797;
        Fri, 06 Jun 2014 06:43:16 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.206.66 with SMTP id lm2ls119067lac.88.gmail; Fri, 06 Jun
 2014 06:43:15 -0700 (PDT)
X-Received: by 10.152.43.101 with SMTP id v5mr1992lal.10.1402062195810;
        Fri, 06 Jun 2014 06:43:15 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id xk11si1306772wib.0.2014.06.06.06.43.15
        for <msysgit@googlegroups.com>;
        Fri, 06 Jun 2014 06:43:15 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id 8CADC1C009F; Fri,  6 Jun 2014 15:43:15 +0200 (CEST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250903>

Hello,

this is first part of the unicode support pathes from msysgit.

The first three patches originate in Jun 2010, though some fixups from 2012
have been squashed in.
The fourth one is just a trivial prerequisite for
the last one, that was written in Jan 2012, with a fixup from Mar 2012.

Regards,
	Stepan

Karsten Blees (5):
  Support Unicode console output on Windows
  Detect console streams more reliably on Windows
  Warn if the Windows console font doesn't support Unicode
  Win32: move main macro to a function
  Win32: Thread-safe windows console output

 compat/mingw.c   |  24 ++-
 compat/mingw.h   |  24 +--
 compat/winansi.c | 446 ++++++++++++++++++++++++++++++++++++++++---------------
 3 files changed, 356 insertions(+), 138 deletions(-)

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
