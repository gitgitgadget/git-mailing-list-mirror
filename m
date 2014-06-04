From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Re: [PATCH] Add a Windows-specific fallback to getenv("HOME");
Date: Wed, 4 Jun 2014 17:27:07 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1406041725460.14982@s15462909.onlinehome-server.info>
References: <20140604114730.GB22250@camelia.ucw.cz> <CACsJy8BDk4gdRzjp_XpQXXMW1sEnS4DoedanFLONODuJXdeeRA@mail.gmail.com> <CABPQNSYXsu1muRTVUg6ybB9_MJP_wJi-4PmSec+8EwrvsCHMRw@mail.gmail.com> <alpine.DEB.1.00.1406041713500.14982@s15462909.onlinehome-server.info>
 <CABPQNSavYCrdUDyNru-HHMFkdgDRvaCp++f8ZgGKv07sS0eXGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: Duy Nguyen <pclouds@gmail.com>, Stepan Kasal <kasal@ucw.cz>, 
    GIT Mailing-list <git@vger.kernel.org>, 
    Thomas Braun <thomas.braun@virtuell-zuhause.de>, 
    msysGit <msysgit@googlegroups.com>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: msysgit+bncBCZPH74Q5YNRBTXVXSOAKGQEL2N7DRI@googlegroups.com Wed Jun 04 17:27:17 2014
Return-path: <msysgit+bncBCZPH74Q5YNRBTXVXSOAKGQEL2N7DRI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-oa0-f63.google.com ([209.85.219.63])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBTXVXSOAKGQEL2N7DRI@googlegroups.com>)
	id 1WsD5r-0002vJ-HP
	for gcvm-msysgit@m.gmane.org; Wed, 04 Jun 2014 17:27:11 +0200
Received: by mail-oa0-f63.google.com with SMTP id o6sf2087945oag.28
        for <gcvm-msysgit@m.gmane.org>; Wed, 04 Jun 2014 08:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=cA2Jk/ucugBUON7qWJv6egH6VBJW4KdGuu98+PNjqk8=;
        b=tWdHrPOdk/G0Zn9E5FYRo1QxnUFpaSF7r8juruiO9J98TSx4cgbYMhnFnx6Aq1H87h
         1KcNo44VRodqPof3NRitWOZZ0apizc0NVlS5/sRw5KIxTlnniJNF6T6NPQeZQdUzRFRc
         ADEuI/RS5HIjugqGx7UBRKm/ZmxvZGOZUNjw/LVA+uZd3u6lQ/VWmyh89k6PPmYjcARr
         kdiRkXyb3v4dWS/nOempA/I1Wx5TOb58glhn9EnrfEicOtGZp6Qy4BsCqd1ixdXgkpxi
         YEcAIEm5EtrVFZ5HAZGodVY4ykVikE4E4SNtjnkmwkFoXY5SMaK05Fmd36pzle8dy/w0
         Kjuw==
X-Received: by 10.140.95.141 with SMTP id i13mr964781qge.3.1401895630647;
        Wed, 04 Jun 2014 08:27:10 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.84.72 with SMTP id k66ls3021557qgd.96.gmail; Wed, 04 Jun
 2014 08:27:10 -0700 (PDT)
X-Received: by 10.236.87.73 with SMTP id x49mr19357971yhe.30.1401895630121;
        Wed, 04 Jun 2014 08:27:10 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.17.20])
        by gmr-mx.google.com with ESMTPS id ci7si800942qcb.1.2014.06.04.08.27.09
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jun 2014 08:27:10 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.17.20 as permitted sender) client-ip=212.227.17.20;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0Mcmmn-1X9bUD1OvR-00HzDf;
 Wed, 04 Jun 2014 17:27:08 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <CABPQNSavYCrdUDyNru-HHMFkdgDRvaCp++f8ZgGKv07sS0eXGQ@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:E+USvFy77VlNhPtJfmci/OtloufzLOQZvL89e5zkiaDGCy9In5E
 MFs0ECDKfs3zR8iV2/Y78v6cTLIqqlzIoFwyDVlZDHKZg8J8nLFb4Fiu6n+v24KAuKNSfXs
 AUaNEC7vdxzG7eyBfYygkUwInBHzqP++kYvpkSHsMeVSsEiihGvE4FiWgW7pj2P6vr2M1bw
 a4j60ak39B54JXnvqsAVQ==
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250740>

Hi kusma,

On Wed, 4 Jun 2014, Erik Faye-Lund wrote:

> On Wed, Jun 4, 2014 at 5:14 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Wed, 4 Jun 2014, Erik Faye-Lund wrote:
> >
> >> On Wed, Jun 4, 2014 at 3:47 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> >> > On Wed, Jun 4, 2014 at 6:47 PM, Stepan Kasal <kasal@ucw.cz> wrote:
> >> >> @@ -133,7 +133,7 @@ char *git_path(const char *fmt, ...)
> >> >>  void home_config_paths(char **global, char **xdg, char *file)
> >> >>  {
> >> >>         char *xdg_home = getenv("XDG_CONFIG_HOME");
> >> >> -       char *home = getenv("HOME");
> >> >> +       const char *home = get_home_directory();
> >> >>         char *to_free = NULL;
> >> >>
> >> >>         if (!home) {
> >> >
> >> > Just checking. Instead of replace the call sites, can we check and
> >> > setenv("HOME") if it's missing instead? MinGW port already replaces
> >> > main(). Extra initialization should not be a problem. I feel
> >> > "getenv("HOME")" a tiny bit more familiar than
> >> > get_home_directory(), but that's really weak argument as the number
> >> > of call sites has not increased in 4 years.
> >>
> >> Yeah. But we already set %HOME% to %HOMEDRIVE%%HOMEPATH% in
> >> /etc/profile, git-cmd.bat, gitk.cmd *and* git-wrapper... Do we really
> >> need one more place?
> >>
> >> It seems some of these could be dropped...
> >
> > No. Git is not always called through Bash or the git-wrapper,
> > unfortunately.
> 
> I'm aware of that. But you said in a previous e-mail that e.g putty got
> confused when we set HOME. How is this a problem for git.exe, but not
> when we set it in the shell?

The problem arises whenever git.exe calls subprocesses. You can pollute
the environment by setting HOME, I do not recall the details, but I
remember that we had to be very careful *not* to do that, hence the patch.
Sorry, has been a long time.

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
