From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Re: [PATCH] Add a Windows-specific fallback to getenv("HOME");
Date: Wed, 4 Jun 2014 17:18:52 +0200
Message-ID: <CABPQNSavYCrdUDyNru-HHMFkdgDRvaCp++f8ZgGKv07sS0eXGQ@mail.gmail.com>
References: <20140604114730.GB22250@camelia.ucw.cz> <CACsJy8BDk4gdRzjp_XpQXXMW1sEnS4DoedanFLONODuJXdeeRA@mail.gmail.com>
 <CABPQNSYXsu1muRTVUg6ybB9_MJP_wJi-4PmSec+8EwrvsCHMRw@mail.gmail.com> <alpine.DEB.1.00.1406041713500.14982@s15462909.onlinehome-server.info>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>, Stepan Kasal <kasal@ucw.cz>, 
	GIT Mailing-list <git@vger.kernel.org>, Thomas Braun <thomas.braun@virtuell-zuhause.de>, 
	msysGit <msysgit@googlegroups.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: msysgit+bncBDR53PPJ7YHRBBHSXSOAKGQEXKVLGHA@googlegroups.com Wed Jun 04 17:19:34 2014
Return-path: <msysgit+bncBDR53PPJ7YHRBBHSXSOAKGQEXKVLGHA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pb0-f58.google.com ([209.85.160.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBBHSXSOAKGQEXKVLGHA@googlegroups.com>)
	id 1WsCyT-0005hU-Pp
	for gcvm-msysgit@m.gmane.org; Wed, 04 Jun 2014 17:19:34 +0200
Received: by mail-pb0-f58.google.com with SMTP id jt11sf2121873pbb.3
        for <gcvm-msysgit@m.gmane.org>; Wed, 04 Jun 2014 08:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=qdzXcJgg/So6jIs1uKIgFj8oZAyvYQblVAJvnpPQe0k=;
        b=cO1xHa7GpT3Yo1GF4kTJCfeU2UZuP2KWVd6veWWi9A5KvjdDx8T+bwhP1OFNkYF9Kz
         hXPrbLZGMuNjrzEqKvh3QAbWobOLrpRPcv+yPt7OZRp9qaEeJQMyi6VMmHWovCupX5jV
         QZPWAhMvOoAuiQZA8EFu3S8sBuYDluvNTBO/u1k3pgZ8hmHikWLm2airB9X3VHVRoHl5
         HRWZI/DPZB79GRotyy7/o9++E4dkcZIi4NDGF0GQNEKXymlwwDKQJNa2NZUm/uQ+5COQ
         hpI74ueIcYt2xRD1N6xrnJOqfXVjHwELOPZRweR9oOx6NOmAMfmsIgsqQPW1p3cZW6zk
         Y5bg==
X-Received: by 10.140.21.233 with SMTP id 96mr67824qgl.19.1401895172727;
        Wed, 04 Jun 2014 08:19:32 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.85.138 with SMTP id n10ls3221900qgd.4.gmail; Wed, 04 Jun
 2014 08:19:32 -0700 (PDT)
X-Received: by 10.58.198.130 with SMTP id jc2mr22769802vec.9.1401895172269;
        Wed, 04 Jun 2014 08:19:32 -0700 (PDT)
Received: from mail-ie0-x234.google.com (mail-ie0-x234.google.com [2607:f8b0:4001:c03::234])
        by gmr-mx.google.com with ESMTPS id f6si1714082igq.1.2014.06.04.08.19.32
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 04 Jun 2014 08:19:32 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c03::234 as permitted sender) client-ip=2607:f8b0:4001:c03::234;
Received: by mail-ie0-f180.google.com with SMTP id tp5so7151676ieb.25
        for <msysgit@googlegroups.com>; Wed, 04 Jun 2014 08:19:32 -0700 (PDT)
X-Received: by 10.50.50.231 with SMTP id f7mr8104556igo.42.1401895172144; Wed,
 04 Jun 2014 08:19:32 -0700 (PDT)
Received: by 10.64.227.43 with HTTP; Wed, 4 Jun 2014 08:18:52 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1406041713500.14982@s15462909.onlinehome-server.info>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c03::234
 as permitted sender) smtp.mail=kusmabite@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250739>

On Wed, Jun 4, 2014 at 5:14 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Erik,
>
> On Wed, 4 Jun 2014, Erik Faye-Lund wrote:
>
>> On Wed, Jun 4, 2014 at 3:47 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> > On Wed, Jun 4, 2014 at 6:47 PM, Stepan Kasal <kasal@ucw.cz> wrote:
>> >> @@ -133,7 +133,7 @@ char *git_path(const char *fmt, ...)
>> >>  void home_config_paths(char **global, char **xdg, char *file)
>> >>  {
>> >>         char *xdg_home = getenv("XDG_CONFIG_HOME");
>> >> -       char *home = getenv("HOME");
>> >> +       const char *home = get_home_directory();
>> >>         char *to_free = NULL;
>> >>
>> >>         if (!home) {
>> >
>> > Just checking. Instead of replace the call sites, can we check and
>> > setenv("HOME") if it's missing instead? MinGW port already replaces
>> > main(). Extra initialization should not be a problem. I feel
>> > "getenv("HOME")" a tiny bit more familiar than get_home_directory(),
>> > but that's really weak argument as the number of call sites has not
>> > increased in 4 years.
>>
>> Yeah. But we already set %HOME% to %HOMEDRIVE%%HOMEPATH% in
>> /etc/profile, git-cmd.bat, gitk.cmd *and* git-wrapper... Do we really
>> need one more place?
>>
>> It seems some of these could be dropped...
>
> No. Git is not always called through Bash or the git-wrapper,
> unfortunately.

I'm aware of that. But you said in a previous e-mail that e.g putty
got confused when we set HOME. How is this a problem for git.exe, but
not when we set it in the shell?

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
