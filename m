From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Re: [PATCH] Add a Windows-specific fallback to getenv("HOME");
Date: Wed, 4 Jun 2014 17:13:32 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1406041711540.14982@s15462909.onlinehome-server.info>
References: <20140604114730.GB22250@camelia.ucw.cz> <CACsJy8BDk4gdRzjp_XpQXXMW1sEnS4DoedanFLONODuJXdeeRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: Stepan Kasal <kasal@ucw.cz>, GIT Mailing-list <git@vger.kernel.org>, 
    Thomas Braun <thomas.braun@virtuell-zuhause.de>, 
    msysGit <msysgit@googlegroups.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: msysgit+bncBCZPH74Q5YNRBH7PXSOAKGQEJFE4U5A@googlegroups.com Wed Jun 04 17:13:39 2014
Return-path: <msysgit+bncBCZPH74Q5YNRBH7PXSOAKGQEJFE4U5A@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-oa0-f58.google.com ([209.85.219.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBH7PXSOAKGQEJFE4U5A@googlegroups.com>)
	id 1WsCsi-0001Xz-Dy
	for gcvm-msysgit@m.gmane.org; Wed, 04 Jun 2014 17:13:36 +0200
Received: by mail-oa0-f58.google.com with SMTP id j17sf2044475oag.23
        for <gcvm-msysgit@m.gmane.org>; Wed, 04 Jun 2014 08:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=yK27TN0rS1/JpeXiKb0u4OykhlxLd+MUeXD9Ny+woLE=;
        b=DV61iAIR7NWVytfybYRv8ejZh0uwp+nWuePeOLFDODdrdZ9Iaeg5AHHcpzaHXY4Q1Q
         sYx6P1zS2bDf3SS7Mv/YhwQ72suHUAkXd3ziHDCtodS1o/rCOBzcrjUH9pCKyolriAVr
         ZqrZE8TxGotJITfN52DYuM7C06rHpnyR5CC4b8g8MTZ4pT90rFYJTbIYSMe1mFPC0tkN
         m7CiA+dsGnc1kg4UxvWEMJRf/gO+a0ANYcywHCiyV1R48kWERcuSPRTL4KEqF+5Hz8oB
         SE26TuuKmCauMiOZqrEBh5u7Jfq7irpzDyKgYW4ZSozjYAndQUSCiQ9EKENVQKJDpgzx
         W5zg==
X-Received: by 10.140.19.161 with SMTP id 30mr21485qgh.35.1401894815554;
        Wed, 04 Jun 2014 08:13:35 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.24.42 with SMTP id 39ls3040721qgq.26.gmail; Wed, 04 Jun
 2014 08:13:34 -0700 (PDT)
X-Received: by 10.236.162.9 with SMTP id x9mr18683783yhk.17.1401894814925;
        Wed, 04 Jun 2014 08:13:34 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.15])
        by gmr-mx.google.com with ESMTPS id oj6si1212907pbb.0.2014.06.04.08.13.34
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jun 2014 08:13:34 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.15 as permitted sender) client-ip=212.227.15.15;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx002) with ESMTPSA (Nemesis) id 0M3RZI-1WaoWK3tnU-00qwPZ;
 Wed, 04 Jun 2014 17:13:33 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <CACsJy8BDk4gdRzjp_XpQXXMW1sEnS4DoedanFLONODuJXdeeRA@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:M8/5jWjWl42kCpbM0HcN3DHof3iFXUb95RX+1YF0584AjrEkLuL
 hS5770ketKQURrpnAYOsKonrHV6SRgVXopsQhEdjl56OfRDpFswbEgbY2r0wjX49aBvbRY8
 W3tJbEw8gi5li1BdAIK5uQhe0dv3M9b7OwTR+fi3207fImzGMQP8de/yduyL/tzzbqLkYV6
 Swo9i4qyH9H7l7cAv3MOg==
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.15 as
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250737>

Hi Duy,

On Wed, 4 Jun 2014, Duy Nguyen wrote:

> On Wed, Jun 4, 2014 at 6:47 PM, Stepan Kasal <kasal@ucw.cz> wrote:
> > @@ -133,7 +133,7 @@ char *git_path(const char *fmt, ...)
> >  void home_config_paths(char **global, char **xdg, char *file)
> >  {
> >         char *xdg_home = getenv("XDG_CONFIG_HOME");
> > -       char *home = getenv("HOME");
> > +       const char *home = get_home_directory();
> >         char *to_free = NULL;
> >
> >         if (!home) {
> 
> Just checking. Instead of replace the call sites, can we check and
> setenv("HOME") if it's missing instead? MinGW port already replaces
> main(). Extra initialization should not be a problem. I feel
> "getenv("HOME")" a tiny bit more familiar than get_home_directory(),
> but that's really weak argument as the number of call sites has not
> increased in 4 years.

There is a good reason why we did not go for that (noticably cheaper)
solution. In fact, it used to be our solution until too many things got
broken by setting the HOME variable: Git is not the only program making
use of that variable (and IIRC Putty or a merge helper got seriously
confused when we set it).

So I am afraid, no, we cannot simply setenv(HOME).

Ciao,
Johannes

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
