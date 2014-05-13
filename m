From: Stepan Kasal <kasal@ucw.cz>
Subject: Re: [PATCH 2/2] wincred: avoid overwriting configured variables
Date: Tue, 13 May 2014 15:53:56 +0200
Organization: <)><
Message-ID: <20140513135356.GA30110@camelia.ucw.cz>
References: <20140430064610.GA22094@camelia.ucw.cz> <CABPQNSZsviaGqFeKZE4ofF6HoUQrPvNPuowar4YDjk_Mbu5iCQ@mail.gmail.com> <20140430112724.GA22929@camelia.ucw.cz> <CABPQNSafKXDLyBj5OYW-PPWdxfxQtC23vKQsQ-_Pa1empU=n8g@mail.gmail.com> <20140513055953.GA28182@camelia.ucw.cz> <20140513060144.GC28182@camelia.ucw.cz> <CABPQNSYU5haMzdy2cDn=KF2+j_aFK19Ju+x+LTeex6JqWJMncQ@mail.gmail.com> <CAMP44s2p0t9cBg=rOdY74MKOYzekCoCj8K20F8ARjQ0RQmJygg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>,
        Pat Thoyts <patthoyts@users.sourceforge.net>,
        msysGit <msysgit@googlegroups.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: msysgit+bncBCU63DXMWULRB5WHZCNQKGQEDLT26NQ@googlegroups.com Tue May 13 15:54:00 2014
Return-path: <msysgit+bncBCU63DXMWULRB5WHZCNQKGQEDLT26NQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f183.google.com ([209.85.217.183])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRB5WHZCNQKGQEDLT26NQ@googlegroups.com>)
	id 1WkD9b-0003sh-9Z
	for gcvm-msysgit@m.gmane.org; Tue, 13 May 2014 15:53:59 +0200
Received: by mail-lb0-f183.google.com with SMTP id s7sf33850lbd.20
        for <gcvm-msysgit@m.gmane.org>; Tue, 13 May 2014 06:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:organization:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=ossrD4MNL8y70Y+gM9RFOBtN8d0qgNVZJfzW/B5KSuo=;
        b=ld6IJ6+ta3ePZDGLe6sP8LfojlQvQSt3fhYOeIes0AnaH1BnLNlfJy+MvcXhfFGnZD
         BNZRcPc3FILkMZwDnrcASdYG61aqwS4CZoSh5Oyg5rAPwsuE5F6VWNmqOJ/E3WqpzHAm
         oVh+VskkeVzmwSzM5kqaQzjY9Lup4LENLA/PMIIqxst68gFiachk3xMIO04k6qoAYSCC
         oCN1aRjDWb2U4kOrWGr4GMWYDY4AMcARhy8Bznbdj97gvjxEC6bDQZJyjr+l0TmZLrfj
         lTx0PURF3ZSl0lvRqFEXjKNNZISExXyQAehvQdfW7rYT9iaesl4NfpqAYxyyzQgTTM/k
         z8BQ==
X-Received: by 10.152.116.44 with SMTP id jt12mr17389lab.10.1399989238856;
        Tue, 13 May 2014 06:53:58 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.170.228 with SMTP id ap4ls58361lac.20.gmail; Tue, 13 May
 2014 06:53:57 -0700 (PDT)
X-Received: by 10.112.219.42 with SMTP id pl10mr2636lbc.22.1399989237939;
        Tue, 13 May 2014 06:53:57 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id u49si2052134eeo.1.2014.05.13.06.53.57
        for <msysgit@googlegroups.com>;
        Tue, 13 May 2014 06:53:57 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 9957A1C010E;
	Tue, 13 May 2014 15:53:57 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s4DDrvp1030224;
	Tue, 13 May 2014 15:53:57 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s4DDruQ7030223;
	Tue, 13 May 2014 15:53:56 +0200
In-Reply-To: <CAMP44s2p0t9cBg=rOdY74MKOYzekCoCj8K20F8ARjQ0RQmJygg@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248784>

Hello,

On Tue, May 13, 2014 at 08:18:26AM -0500, Felipe Contreras wrote:
> Set by whom? If it's by the environment you should be running 'make -e'.

... or on command line (through recursive make, prehaps).
But these both take precedence over makefile assignments.

Another issue is the interaction with included makefile fragments.
Actually, both
	CC = gcc
	-include ../../../config.mak
and
	-include ../../../config.mak
	CC ?= gcc
are very close.  (They would differ if config.mak contained "?=".)

I was confused by the former, but perhaps it's only me.

Stepan

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
