From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Do not call built-in aliases from scripts
Date: Fri, 28 Jun 2013 22:32:30 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1306282231300.28957@s15462909.onlinehome-server.info>
References: <CAHGBnuNUjaWH2UDsa6jGjf32M+b8-iezw4pKXR985mROFSLOKQ@mail.gmail.com> <alpine.DEB.1.00.1306272030291.28957@s15462909.onlinehome-server.info> <CAHGBnuOE6vYzM2bKs2SV1qJVoCOX=t-XWnd_Xbs1JRD+sY4dVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>, 
    msysGit Mailinglist <msysgit@googlegroups.com>, 
    Thomas Braun <thomas.braun@virtuell-zuhause.de>, 
    Pat Thoyts <patthoyts@users.sourceforge.net>, 
    Junio C Hamano <gitster@pobox.com>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: msysgit+bncBCZPH74Q5YNRBYHFW6HAKGQE4K7FN2I@googlegroups.com Fri Jun 28 22:32:33 2013
Return-path: <msysgit+bncBCZPH74Q5YNRBYHFW6HAKGQE4K7FN2I@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f191.google.com ([209.85.217.191])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBYHFW6HAKGQE4K7FN2I@googlegroups.com>)
	id 1UsfLN-0005Wt-Lb
	for gcvm-msysgit@m.gmane.org; Fri, 28 Jun 2013 22:32:33 +0200
Received: by mail-lb0-f191.google.com with SMTP id z5sf289914lbh.28
        for <gcvm-msysgit@m.gmane.org>; Fri, 28 Jun 2013 13:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :x-y-gmx-trusted:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:x-google-group-id:list-post
         :list-help:list-archive:sender:list-subscribe:list-unsubscribe
         :content-type;
        bh=xTm5zv/JeSZI8oklCJqA5CaDZItaslCGRuBFCkPmKB8=;
        b=V0mGp+3V2/svbViGMzZGogLOJDa8rxl8mg8yINwNW7hLycT68GuclsTaSuk45vRKkG
         USJxdZA6kc1Yzb9lf0b5rFYtjiEKYYqTH6aPCJ9f8Wi+w1d250Q2GwtE7HLVYNk0X08V
         kU/j5eVOdohwIFr9bWqr5i1rN/jGUbK2i6SfMGb4Ox6voMjSqjCA8Nyy/LYKj0xm5eCV
         ELF7yPti/bxPCsLdafam/JtxtzZuWiSsTxRz8JfF5AxEuVGW+HDdziDfmf2lVtClfC9I
         CMXpPi4IGWnbQzXFCVIgQjtnX5a7mwr 
X-Received: by 10.180.99.5 with SMTP id em5mr191650wib.8.1372451553086;
        Fri, 28 Jun 2013 13:32:33 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.212.47 with SMTP id nh15ls274208wic.22.gmail; Fri, 28 Jun
 2013 13:32:32 -0700 (PDT)
X-Received: by 10.14.214.8 with SMTP id b8mr16970191eep.1.1372451552346;
        Fri, 28 Jun 2013 13:32:32 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.17.22])
        by gmr-mx.google.com with ESMTP id bk51si1482227eeb.0.2013.06.28.13.32.32
        for <msysgit@googlegroups.com>;
        Fri, 28 Jun 2013 13:32:32 -0700 (PDT)
Received-SPF: pass (google.com: domain of johannes.schindelin@gmx.de designates 212.227.17.22 as permitted sender) client-ip=212.227.17.22;
Received: from mailout-de.gmx.net ([10.1.76.4]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0LqXNf-1UNRGT0SXZ-00e4sk for
 <msysgit@googlegroups.com>; Fri, 28 Jun 2013 22:32:32 +0200
Received: (qmail invoked by alias); 28 Jun 2013 20:32:32 -0000
Received: from s15462909.onlinehome-server.info (EHLO s15462909.onlinehome-server.info) [87.106.4.80]
  by mail.gmx.net (mp004) with SMTP; 28 Jun 2013 22:32:32 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19dvwxfP2BdUya+cIYsOuwvZPJF+64ks8tTWWLdPY
	Sm8Yb8Z3g2i7XL
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <CAHGBnuOE6vYzM2bKs2SV1qJVoCOX=t-XWnd_Xbs1JRD+sY4dVQ@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of johannes.schindelin@gmx.de designates 212.227.17.22 as
 permitted sender) smtp.mail=johannes.schindelin@gmx.de
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229234>

Hi Sebastian,

On Fri, 28 Jun 2013, Sebastian Schuberth wrote:

> On Thu, Jun 27, 2013 at 8:52 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> 
> >> --- a/git-merge-octopus.sh
> >> +++ b/git-merge-octopus.sh
> >> @@ -97,7 +97,7 @@ do
> >>       if test $? -ne 0
> >>       then
> >>               echo "Simple merge did not work, trying automatic merge."
> >> -             git-merge-index -o git-merge-one-file -a ||
> >> +             git merge-index -o git-merge-one-file -a ||
> >
> > This is a problem. 'git-merge-one-file' cannot be split here AFAICT.
> >
> > Of course, we could teach merge-index to read *two* parameters instead of
> > one when it encounters "git" as the <merge-program>. But that would be as
> > hacky as the whole dashed-form business to begin with.
> 
> I agree to all of your comments except this one: I did not split
> 'git-merge-one-file' here ...

I know. That is what I pointed out. git-merge-one-file was *not*
"un-dashed". And I explained the reason, too.

But if we really want to solve the problem you described earlier, we also
must not rely on git-merge-one-file to be present in libexec.

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
For more options, visit https://groups.google.com/groups/opt_out.
