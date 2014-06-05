From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Re: [PATCH] Add a Windows-specific fallback to getenv("HOME");
Date: Thu, 5 Jun 2014 14:03:39 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1406051354000.14982@s15462909.onlinehome-server.info>
References: <20140604114730.GB22250@camelia.ucw.cz> <CACsJy8BDk4gdRzjp_XpQXXMW1sEnS4DoedanFLONODuJXdeeRA@mail.gmail.com> <CABPQNSYXsu1muRTVUg6ybB9_MJP_wJi-4PmSec+8EwrvsCHMRw@mail.gmail.com> <alpine.DEB.1.00.1406041713500.14982@s15462909.onlinehome-server.info>
 <CABPQNSavYCrdUDyNru-HHMFkdgDRvaCp++f8ZgGKv07sS0eXGQ@mail.gmail.com> <alpine.DEB.1.00.1406041725460.14982@s15462909.onlinehome-server.info> <alpine.DEB.1.00.1406041741470.14982@s15462909.onlinehome-server.info> <538FCAF5.7030102@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: Erik Faye-Lund <kusmabite@gmail.com>, Duy Nguyen <pclouds@gmail.com>, 
    Stepan Kasal <kasal@ucw.cz>, GIT Mailing-list <git@vger.kernel.org>, 
    Thomas Braun <thomas.braun@virtuell-zuhause.de>, 
    msysGit <msysgit@googlegroups.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBCZPH74Q5YNRBH5ZYGOAKGQE6SKDMEY@googlegroups.com Thu Jun 05 14:03:48 2014
Return-path: <msysgit+bncBCZPH74Q5YNRBH5ZYGOAKGQE6SKDMEY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qa0-f63.google.com ([209.85.216.63])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBH5ZYGOAKGQE6SKDMEY@googlegroups.com>)
	id 1WsWOW-0004Xu-8L
	for gcvm-msysgit@m.gmane.org; Thu, 05 Jun 2014 14:03:44 +0200
Received: by mail-qa0-f63.google.com with SMTP id j5sf224969qaq.8
        for <gcvm-msysgit@m.gmane.org>; Thu, 05 Jun 2014 05:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=Gk9ag9O8snOqCYsO9LS8D2c04ENMzYDJLC+XgbL0K9c=;
        b=NbcVdMDHhyrznx0m+mDIkN9e5aXrkloSdzIsKSIvKW4mwweop8Zrbyu90mh7CIIYm+
         FxpbGRpX59Y/Rwubusbcwm70tB+HKRjoGkFcglA5/d4gZ6UfqjfO9jQOMXdxEhDI7vU/
         qOZXjf4t/B8qQ7f+H1lXnxgkXXN464ozMx1sr83IxgbQXQIEcOnmfz6LYC1j/Sqgf7jH
         wjYfFqBwivMS2ndUu++jQEl8oaIde04OOxCTphfAkRN+CNXh11xqZGLf75Gj7TerlD1w
         Ga/HK0gjNQsN0HM9pY9RN+oC2M9RMlgMzvHxpzitvHfoMsybdg3RHeQw0PhsWU9GYDaT
         OmWA==
X-Received: by 10.140.91.245 with SMTP id z108mr186911qgd.16.1401969823475;
        Thu, 05 Jun 2014 05:03:43 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.22.39 with SMTP id 36ls97787qgm.75.gmail; Thu, 05 Jun 2014
 05:03:43 -0700 (PDT)
X-Received: by 10.58.225.197 with SMTP id rm5mr25280503vec.5.1401969823032;
        Thu, 05 Jun 2014 05:03:43 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.19])
        by gmr-mx.google.com with ESMTPS id jx10si1069349pbd.2.2014.06.05.05.03.42
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jun 2014 05:03:42 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.19 as permitted sender) client-ip=212.227.15.19;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx101) with ESMTPSA (Nemesis) id 0MgGDK-1X7HaP30QY-00Neam;
 Thu, 05 Jun 2014 14:03:39 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <538FCAF5.7030102@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:e8NutdA5jtB2XVX/OI8jSFZFNTLScFDcBxP9GNkOqqejbdruQsM
 MK8aqA78mCoqf0ua1c6CSi5+SPCylwgI/V9S4x46arrRIwknrG/3s9TBUQ2Ne2PrlZwR9F3
 3Vs2CWigF51MamKeqQTC8udvZmDpkGiV0dFwLBiNK6ae3NB+OumqrHlbTkBmr+7TW6pVwqu
 /lcv861wUsAkgHTzhaCxw==
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250831>

Hi Karsten,

On Thu, 5 Jun 2014, Karsten Blees wrote:

> After a bit of digging in the history and the old googlegroups issue
> tracker, I think this patch is completely unrelated to the non-ASCII
> problems.

Actually, the non-ASCII problems were the trigger for my patch.

> In summary, this patch fixes 'git config' for the portable version only,
> and it only does so partially.

Care to elaborate?

> Am 04.06.2014 17:46, schrieb Johannes Schindelin:
> 
> > I would be strongly in favor of fixing the problem by the root:
> > avoiding to have Git rely on the HOME environment variable to be set,
> > but instead add a clean API call that even says what it is supposed to
> > do: gimme the user's home directory's path. And that is exactly what
> > the patch does.
> 
> By that argument we'd have to introduce API abstractions for every
> environment variable that could possibly resemble a path (PATH, TMPDIR,
> GIT_DIR, GIT_WORK_DIR, GIT_TRACE* etc.).

But of course you are mixing things here. GIT_* are purely Git-specific
constructs, so there is no possibility for confusion. PATH and TMPDIR need
to be handled specially (as does HOME) because we are reusing environment
variable concepts that pose their own set of problems on Windows because
of the separator, the path separator and the encoding problems.

I understand that it is easy to confuse my want for a API function for the
home variable with handling for other environment variables. But that HOME
is an environment variable is not the point at all! It just *happens* to
be an environment variable on Linux/Unix.

> We already have similar fallback logic for TMPDIR that is completely
> non-intrusive to core git code (fully encapsulated in mingw.c, see
> mingw_getenv (upstream) or mingw_startup (msysgit)). IMO such a solution
> would be hugely preferable over adding an additional
> get_home_directory() API (and continuously checking that no new upstream
> code accidentally introduces another 'getenv("HOME")').

Well, since you mention that TMPDIR hack: this is a hack. We are bending
over in order for upstream not having to accomodate non-POSIX operating
systems. But how much cleaner would it be if there was an API call with
varargs. After all, by the reasoning "TMPDIR is a standard on Unix" you
would also have to special case "/tmp/" in all the open/opendir/etc
functions because the temporary directory is /tmp/ on Linux/Unix, right?

Render me even more convinced that the API call is the cleanest way to go,
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
