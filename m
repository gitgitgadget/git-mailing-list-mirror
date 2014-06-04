From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Re: [PATCH] Add a Windows-specific fallback to getenv("HOME");
Date: Wed, 4 Jun 2014 17:46:54 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1406041741470.14982@s15462909.onlinehome-server.info>
References: <20140604114730.GB22250@camelia.ucw.cz> <CACsJy8BDk4gdRzjp_XpQXXMW1sEnS4DoedanFLONODuJXdeeRA@mail.gmail.com> <CABPQNSYXsu1muRTVUg6ybB9_MJP_wJi-4PmSec+8EwrvsCHMRw@mail.gmail.com> <alpine.DEB.1.00.1406041713500.14982@s15462909.onlinehome-server.info>
 <CABPQNSavYCrdUDyNru-HHMFkdgDRvaCp++f8ZgGKv07sS0eXGQ@mail.gmail.com> <alpine.DEB.1.00.1406041725460.14982@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: Duy Nguyen <pclouds@gmail.com>, Stepan Kasal <kasal@ucw.cz>, 
    GIT Mailing-list <git@vger.kernel.org>, 
    Thomas Braun <thomas.braun@virtuell-zuhause.de>, 
    msysGit <msysgit@googlegroups.com>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: msysgit+bncBCZPH74Q5YNRB4P6XSOAKGQE4GYEHJI@googlegroups.com Wed Jun 04 17:46:59 2014
Return-path: <msysgit+bncBCZPH74Q5YNRB4P6XSOAKGQE4GYEHJI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f63.google.com ([209.85.215.63])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRB4P6XSOAKGQE4GYEHJI@googlegroups.com>)
	id 1WsDP0-0000SW-Ff
	for gcvm-msysgit@m.gmane.org; Wed, 04 Jun 2014 17:46:58 +0200
Received: by mail-la0-f63.google.com with SMTP id b8sf728944lan.8
        for <gcvm-msysgit@m.gmane.org>; Wed, 04 Jun 2014 08:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=UaEyq5N5Uxp38YLlaEUh6mN2cH9FgMwqkJH3SZlJMqo=;
        b=NIzWPkzQKJnfOar7FYd+iZtgWuA5tVCr1WuZeuuy0UeiPu4xxLLoQ6VnEChrnO5r/0
         v7SIWM9l9FUE3j89ZnSfjr2zBnLJAiIAwxhm7bVUO54KHJN+pMdyeAMZuIAb/6u/+SED
         PFboA8JkcAh6ZBzIPguKM1eil4IGgYhuiDg+TsSXk+ns1lHwmXxOVy2cBrUuuWNDkCxz
         bGe3BoJEx3HmX8Im4DpWslZMh6MPV3GtCQVH6GvpaUw0FJcGhkdpViG5VQUVQgUoZmys
         KE7abWNa3Bns+mPJ5UBWCicPUa5uX6wu2xVD1AzNHvJf2bETkmai+7xG6WNPx+QF8/nT
         5Bfg==
X-Received: by 10.152.2.228 with SMTP id 4mr10735lax.37.1401896818310;
        Wed, 04 Jun 2014 08:46:58 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.27.66 with SMTP id r2ls552674lag.29.gmail; Wed, 04 Jun
 2014 08:46:57 -0700 (PDT)
X-Received: by 10.112.149.162 with SMTP id ub2mr529509lbb.18.1401896817589;
        Wed, 04 Jun 2014 08:46:57 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.19])
        by gmr-mx.google.com with ESMTPS id h4si1218770wib.2.2014.06.04.08.46.57
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jun 2014 08:46:57 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.19 as permitted sender) client-ip=212.227.15.19;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx001) with ESMTPSA (Nemesis) id 0LiDKt-1WVTUz1ZoJ-00nUHb;
 Wed, 04 Jun 2014 17:46:54 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <alpine.DEB.1.00.1406041725460.14982@s15462909.onlinehome-server.info>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:cU3CSQII+J0/U90QtB/bwrrd5532kcZo7eJ31Sn4JINozbXvMP/
 oIWxcohLwKugfM2vX4cDftIul+0i85wMcXfKC+2+lnzY4RYesThJgnxE8aHr80e+Ky2ASdS
 vX27jZQyLyyNIg5nuwdYjieFEbuDQ1TSxd1mf66EqtAtbrTQrJxEnBz/dYLfaPIhUvsfWpi
 2Ma3CfKruX0D97npZ96TA==
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.19 as
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250742>

Hi kusma,

On Wed, 4 Jun 2014, Johannes Schindelin wrote:

> The problem arises whenever git.exe calls subprocesses. You can pollute
> the environment by setting HOME, I do not recall the details, but I
> remember that we had to be very careful *not* to do that, hence the patch.
> Sorry, has been a long time.

Actually, a quick search in my Applegate vaults^W^Wmail archives suggests
that we had tons of troubles with non-ASCII characters in the path.

Given that none of us really has time to recreate the problems, or to take
care of them if there arises a new problem due to setting the HOME
variable again (remember: while we have UTF-8 support in Git, thanks to
Karsten's tireless efforts, and while that seems to fix the biggest bugs
for us, other MinGW software does not have that luxury and will continue
to barf on non-ASCII characters in the HOME variable), I would be strongly
in favor of fixing the problem by the root: avoiding to have Git rely on
the HOME environment variable to be set, but instead add a clean API call
that even says what it is supposed to do: gimme the user's home
directory's path. And that is exactly what the patch does.

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
