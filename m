From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] Add a Windows-specific fallback to getenv("HOME");
Date: Thu, 5 Jun 2014 15:39:26 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1406051411580.14982@s15462909.onlinehome-server.info>
References: <20140604114730.GB22250@camelia.ucw.cz> <CACsJy8BDk4gdRzjp_XpQXXMW1sEnS4DoedanFLONODuJXdeeRA@mail.gmail.com> <CABPQNSYXsu1muRTVUg6ybB9_MJP_wJi-4PmSec+8EwrvsCHMRw@mail.gmail.com> <alpine.DEB.1.00.1406041713500.14982@s15462909.onlinehome-server.info>
 <CABPQNSavYCrdUDyNru-HHMFkdgDRvaCp++f8ZgGKv07sS0eXGQ@mail.gmail.com> <alpine.DEB.1.00.1406041725460.14982@s15462909.onlinehome-server.info> <alpine.DEB.1.00.1406041741470.14982@s15462909.onlinehome-server.info> <538FCAF5.7030102@gmail.com>
 <20140605080317.GA28029@camelia.ucw.cz> <53903B22.70507@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: Stepan Kasal <kasal@ucw.cz>, Erik Faye-Lund <kusmabite@gmail.com>, 
    Duy Nguyen <pclouds@gmail.com>, GIT Mailing-list <git@vger.kernel.org>, 
    Thomas Braun <thomas.braun@virtuell-zuhause.de>, 
    msysGit <msysgit@googlegroups.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBCZPH74Q5YNRBFXGYGOAKGQENZUEHWI@googlegroups.com Thu Jun 05 15:39:35 2014
Return-path: <msysgit+bncBCZPH74Q5YNRBFXGYGOAKGQENZUEHWI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f64.google.com ([74.125.82.64])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBFXGYGOAKGQENZUEHWI@googlegroups.com>)
	id 1WsXtH-0005Tu-6C
	for gcvm-msysgit@m.gmane.org; Thu, 05 Jun 2014 15:39:35 +0200
Received: by mail-wg0-f64.google.com with SMTP id m15sf120360wgh.9
        for <gcvm-msysgit@m.gmane.org>; Thu, 05 Jun 2014 06:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=WAJ22CJ6tlgq2VwN25NTA2qIA0KHibI0TKaWUXA0oxo=;
        b=UDPzmsk34GFvNVSmHxZJcQsdrHe9YUhTLjINqPKBosnso3nKdKLh8P1Atte5+l8gaT
         7sOPLAyquRwjgCYqguzQZpG/jcdjz9pdjeV+1c31HtWKa7gXiU5CcK79i6N2AnvVX5KI
         4vKcvytLamtgSVTe8zHOZIaSkl/yxelRsa01Lt65WvOpr6Dq9JI0edQjE5QYupcY3juu
         TbNERW8Cbu7JBMTpoLAephmGkPgW5iErFxZAeezqMSdEF3YgRFyNs1+c0/k9k3vQ5SAz
         4wbplvQccfJrroQZXzmiUbP8D7JIQJjJ0TbnzWMJBi+TGMntA+26iPdfkHFLP/e7Z3ct
         wDJw==
X-Received: by 10.180.198.45 with SMTP id iz13mr22201wic.21.1401975574918;
        Thu, 05 Jun 2014 06:39:34 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.24.102 with SMTP id t6ls98374wif.33.gmail; Thu, 05 Jun
 2014 06:39:34 -0700 (PDT)
X-Received: by 10.180.211.114 with SMTP id nb18mr2395218wic.4.1401975573987;
        Thu, 05 Jun 2014 06:39:33 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.17.20])
        by gmr-mx.google.com with ESMTPS id s1si960125wiw.3.2014.06.05.06.39.33
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jun 2014 06:39:33 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.17.20 as permitted sender) client-ip=212.227.17.20;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx103) with ESMTPSA (Nemesis) id 0Lp3Qu-1WGAnU10ho-00ethk;
 Thu, 05 Jun 2014 15:39:28 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <53903B22.70507@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:kgirTdhIvb4PAtcZnAu4xSzLsLWW5ScKYxvh8Fyr9szq2PqUGUC
 vfu2WYa9YaHygMtfCmI2kmFkwoLTgoLanrgCUGW/782WhVd9j1G97ym6a/wvfshw4e7iqJb
 hfIMOacT5JcrU6y1udwgkRxl+GCWzNLJKqfk5++c5/v3t4EmyYW0k/M+8rX21yJoaUYE/cC
 1Kg0LFTEtquMxWuDSxE6w==
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.17.20 as
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250836>

Hi Karsten,

On Thu, 5 Jun 2014, Karsten Blees wrote:

> Am 05.06.2014 10:03, schrieb Stepan Kasal:
> 
>  * even if $HOME was empty, git should setenv("HOME") so that child
>  processes can benefit from it (similar to TMPDIR and TERM in current
>  msysgit's mingw_startup()). Not setting $HOME because it may
>  hypothetically break child processes is a very weak argument, as we
>  always did set $HOME in etc/profile (since the initial version back in
>  2007).

I do remember that I tried that first, as I mentioned in this thread.
There must have been a breakage preventing me from going that route.

And in particular with your changes to Unicodify the complete environment,
I am *highly* doubtful that child processes will be able to handle
themselves properly, unless we spend a whole lot of time converting back
and forth the environment when calling children.

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
