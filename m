From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git grep -O -i: if the pager is 'less', pass
 the '-i' option
Date: Thu, 15 May 2014 21:01:44 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1405152100350.14982@s15462909.onlinehome-server.info>
References: <20140514155010.GA4592@camelia.ucw.cz> <xmqq7g5okztp.fsf@gitster.dls.corp.google.com> <20140514182654.GA9218@google.com> <xmqqvbt8jjlg.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1405151943310.14982@s15462909.onlinehome-server.info>
 <20140515175344.GM9218@google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Stepan Kasal <kasal@ucw.cz>, 
    GIT Mailing-list <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: msysgit+bncBCZPH74Q5YNRBGU62SNQKGQE7NNPNHQ@googlegroups.com Thu May 15 21:01:48 2014
Return-path: <msysgit+bncBCZPH74Q5YNRBGU62SNQKGQE7NNPNHQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f185.google.com ([74.125.82.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBGU62SNQKGQE7NNPNHQ@googlegroups.com>)
	id 1Wl0uZ-0002a1-3L
	for gcvm-msysgit@m.gmane.org; Thu, 15 May 2014 21:01:47 +0200
Received: by mail-we0-f185.google.com with SMTP id w61sf146935wes.2
        for <gcvm-msysgit@m.gmane.org>; Thu, 15 May 2014 12:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=xMRBF+msaabQCZyL2Tt/cAyRV0UpTmjz49nB/UiUt3Y=;
        b=hiaTwvri00iB7msBie/H4LhocBjd0Y2q3nOgm5RxtUQhSg5kKhAmeCVAlZYdZabQKJ
         0D8rmR7nLl0HWaD2l7qvGoVgWhkyW+U2gAek+WzKQKkZL4NWzxMfgnst1+mNyvXdbr7S
         x+m8hYhW4yBjdLJrwDHX7ttqgJBHAMW4l0ufXYTcVWyo5eYu6xMWaiS4FgfbpWoCFzzY
         mB4uQ8gZ7an3gqXp+6+vaQziCdthKrmEgZhB/UlD9vozaKySmKfvM+fdpB/mizlXW1VA
         ox/+345B0N8zjqJYETgNqxaguTFJ6rS0lfeLZ/Evi71bxYk3PxBW5GuMQkxE1JhLR3U8
         yyrA==
X-Received: by 10.152.120.37 with SMTP id kz5mr26592lab.30.1400180506844;
        Thu, 15 May 2014 12:01:46 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.87.178 with SMTP id az18ls72947lab.4.gmail; Thu, 15 May
 2014 12:01:46 -0700 (PDT)
X-Received: by 10.152.36.6 with SMTP id m6mr1175880laj.0.1400180506222;
        Thu, 15 May 2014 12:01:46 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.18])
        by gmr-mx.google.com with ESMTPS id r49si1975972eep.0.2014.05.15.12.01.46
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 May 2014 12:01:46 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.18 as permitted sender) client-ip=212.227.15.18;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx101) with ESMTPSA (Nemesis) id 0MH4Os-1WYPjG3TBi-00DnOq;
 Thu, 15 May 2014 21:01:44 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <20140515175344.GM9218@google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:BBjzoQ4CikEkn2Q4Guhn6P1IzKdCln2Dqhe8ZvceyHLiKkJvh8k
 i0ic5U4OQH0ubQV9JSorhaDOPU1uHCzPHsYigzNDeZ77ApCDW31VJJtJv77JtFy1pmn9xzP
 zGVsRH7Fbm32ZJteib9kevwYb3lvEnpTY3yFrW+373hWKgdkFibBuYFh9V1T07H6DL+OENQ
 jAO/O05sjc1Lpzo7GiUXQ==
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.18 as
 permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249182>

Hi,

On Thu, 15 May 2014, Jonathan Nieder wrote:

> Johannes Schindelin wrote:
> > On Wed, 14 May 2014, Junio C Hamano wrote:
> 
> >> Spot on.  The change, especially with "-I", makes sense.
> >
> > Except that it was not tested with -I. If you change it that way and it
> > stops working on Windows, it's useless to me.
> 
> Are you saying that less on Windows doesn't have an "-I" option?

I did not say that.

> version.c tells me it was added in v266 (1994-12-26).

Thanks. That was the thing I was really looking for: an indication that -I
is not a new-fangled thing but a well-tested option that even old greps
have.

Ciao,
Dscho

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
