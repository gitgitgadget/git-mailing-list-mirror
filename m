From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH 0/2] mingw: macro main(), const warnings
Date: Thu, 29 May 2014 12:43:29 +0200
Organization: <)><
Message-ID: <20140529104329.GA24021@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Erik Faye-Lund <kusmabite@gmail.com>, msysgit@googlegroups.com,
        Karsten Blees <karsten.blees@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCU63DXMWULRBVE6TSOAKGQESYWW7FQ@googlegroups.com Thu May 29 12:43:33 2014
Return-path: <msysgit+bncBCU63DXMWULRBVE6TSOAKGQESYWW7FQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f189.google.com ([209.85.212.189])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBVE6TSOAKGQESYWW7FQ@googlegroups.com>)
	id 1Wpxo5-0000Zr-53
	for gcvm-msysgit@m.gmane.org; Thu, 29 May 2014 12:43:33 +0200
Received: by mail-wi0-f189.google.com with SMTP id cc10sf42736wib.6
        for <gcvm-msysgit@m.gmane.org>; Thu, 29 May 2014 03:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:mime-version:organization
         :user-agent:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type
         :content-disposition;
        bh=3Q6YVrMpPpGtRC0Wxf9/PMNqqWoYruezn8fiys/ZEQ0=;
        b=pIrZXY0XQ23M364Hba9KiyK4kAG2WvYv4yYcDNB0aDgZupVD5HmDIoetWyYcCNWmR1
         ft1IDAfsAEOoGs9ghkpncJm6p2RS2dyDkpkKDY70cikR2KKUtEcyZSOJXTz7SVcoBXh/
         jkWpFoPy0AkM3/wXXKpqalXeQvCM+orKkFEJRTb57tYz+GUVTGaK/zJrcFVKt64uR9gU
         fLe2aekmGi7JNU4n6W/IA1w/+waqYxd6g4nOsGRouApQaB1lbzYRVam7+6iKDJomciC/
         kt3Z1fID6jKkF7kjTym2Osc8TLY73P45xEh8XugUSpjTqTCMMmQ2k7rNXKMycCnsH3Cl
         G3kw==
X-Received: by 10.180.108.207 with SMTP id hm15mr87876wib.21.1401360212862;
        Thu, 29 May 2014 03:43:32 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.160.164 with SMTP id xl4ls170829wib.5.gmail; Thu, 29 May
 2014 03:43:31 -0700 (PDT)
X-Received: by 10.180.207.42 with SMTP id lt10mr4119914wic.6.1401360211820;
        Thu, 29 May 2014 03:43:31 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id g42si364112eev.1.2014.05.29.03.43.30
        for <msysgit@googlegroups.com>;
        Thu, 29 May 2014 03:43:30 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 5FC0F1C00E5;
	Thu, 29 May 2014 12:43:30 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s4TAhTpD024087;
	Thu, 29 May 2014 12:43:30 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s4TAhTad024086;
	Thu, 29 May 2014 12:43:29 +0200
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250356>

Hello,

mingw.h defines a preprocessor macro main(), so that it can wrap the
original function and hoook into initialization.

The real main() function can have different types of its second
parameter (char**, const char**, char*[]).  It is not easy to match
the type and gcc issues a const warning.  My patch fixes that.

There were solutions for the same issue published ([1], [2]), but
none of them appeared in junio/pu.  This new solution should be more
future proof, as it modifies only compat/mingw.h; the *.c files can
have any of the types mentioned above.

I promise to take care of the integration into msysGit if this patch
gets accepted.  To make it easier, I'm submitting a patch that has
been part of msysGit for 3 years.

Karsten Blees (1):
  Win32: move main macro to a function

Stepan Kasal (1):
  mingw: avoid const warning

 compat/mingw.c | 15 +++++++++++++++
 compat/mingw.h | 17 ++++++-----------
 2 files changed, 21 insertions(+), 11 deletions(-)

-- 
1.9.2.msysgit.0.496.g23aa553

[1] a hack to fix the warning, by Pat Thoyts, in msysGit since
1.8.5.2.msysgit.0 (Dec 2013):
https://github.com/msysgit/git/commit/6949537a

[2] more elgant fix:
From: Marat Radchenko <marat@slonopotamus.org>
Date: Tue, 29 Apr 2014 13:12:02 +0400
http://article.gmane.org/gmane.comp.version-control.git/247535

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
