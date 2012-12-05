From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] mingw_rmdir: do not prompt for retry when non-empty
Date: Wed, 5 Dec 2012 17:02:10 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1212051657131.31987@s15462909.onlinehome-server.info>
References: <1354617713-7436-1-git-send-email-kusmabite@gmail.com> <alpine.DEB.1.00.1212041728210.31987@s15462909.onlinehome-server.info> <CABPQNSbcSEKApDBWWt7z67DvV6=JwTGebdk6hjgR1OppPyOQwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: msysgit+bncBCZPH74Q5YNRBBXA7WCQKGQETULHFWA@googlegroups.com Wed Dec 05 17:02:28 2012
Return-path: <msysgit+bncBCZPH74Q5YNRBBXA7WCQKGQETULHFWA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vc0-f186.google.com ([209.85.220.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBBXA7WCQKGQETULHFWA@googlegroups.com>)
	id 1TgHQZ-0000jH-MX
	for gcvm-msysgit@m.gmane.org; Wed, 05 Dec 2012 17:02:27 +0100
Received: by mail-vc0-f186.google.com with SMTP id fl17sf3163322vcb.3
        for <gcvm-msysgit@m.gmane.org>; Wed, 05 Dec 2012 08:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:x-authenticated:x-provags-id:date:from
         :x-x-sender:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-y-gmx-trusted:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=EPgrx9eCTN4J9N9TSxzFjB2U4mGKMQFruTl3vTSpIgs=;
        b=pD6oALVftsngC3DdYhBnvnafF0H2mzwmFhXW6suU2kY5s54ceJbpgYzNxSLfK1uTQb
         foEsoTMDwcNVAI2K5cGk33GlX896m31sLtE8pqQ/0Jv9+ViIX22xcM0s71tO9CiPczTt
         KKaLDF95o4nXWE+7IDWB45mFLl2zDhZMuDW7bUN4ADA84qvXcwSPJ8bsbzPxTxEPjG2R
         CJQE723DNoQmlRj47MpKn5Cj89BAL9jPPywmmMn4N6yS6WtFxp+GNHswJjnR1mXRMA56
         Vi72wqteHW7/LeIPd/ 
Received: by 10.50.191.131 with SMTP id gy3mr890765igc.1.1354723334935;
        Wed, 05 Dec 2012 08:02:14 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.193.228 with SMTP id hr4ls4188799igc.18.canary; Wed, 05 Dec
 2012 08:02:13 -0800 (PST)
Received: by 10.68.202.68 with SMTP id kg4mr3552922pbc.3.1354723333774;
        Wed, 05 Dec 2012 08:02:13 -0800 (PST)
Received: by 10.68.202.68 with SMTP id kg4mr3552921pbc.3.1354723333764;
        Wed, 05 Dec 2012 08:02:13 -0800 (PST)
Received: from mailout-de.gmx.net (mailout-de.gmx.net. [213.165.64.23])
        by gmr-mx.google.com with SMTP id m8si1005117pav.2.2012.12.05.08.02.13;
        Wed, 05 Dec 2012 08:02:13 -0800 (PST)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.23 as permitted sender) client-ip=213.165.64.23;
Received: (qmail invoked by alias); 05 Dec 2012 16:02:12 -0000
Received: from s15462909.onlinehome-server.info (EHLO s15462909.onlinehome-server.info) [87.106.4.80]
  by mail.gmx.net (mp019) with SMTP; 05 Dec 2012 17:02:12 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+VLslLs0qVBkHoqqSvDKrxqAqznxaVlXeVROGIBR
	fU6n/g5+6zrefC
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <CABPQNSbcSEKApDBWWt7z67DvV6=JwTGebdk6hjgR1OppPyOQwg@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of Johannes.Schindelin@gmx.de designates 213.165.64.23 as permitted
 sender) smtp.mail=Johannes.Schindelin@gmx.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211128>

Hi kusma,

On Wed, 5 Dec 2012, Erik Faye-Lund wrote:

> Sorry for a late reply.

Yeah, sorry, my replies tend to be delayed a lot. For the record: your
reply was not at all late.

> On Tue, Dec 4, 2012 at 5:35 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Tue, 4 Dec 2012, Erik Faye-Lund wrote:
> >
> >> in ab1a11be ("mingw_rmdir: set errno=ENOTEMPTY when appropriate"), a
> >> check was added to prevent us from retrying to delete a directory
> >> that is both in use and non-empty.
> >>
> >> However, this logic was slightly flawed; since we didn't return
> >> immediately, we end up falling out of the retry-loop, but right into
> >> the prompting loop.
> >>
> >> Fix this by simply returning from the function instead of breaking
> >> the loop.
> >>
> >> While we're at it, change the second break to a return as well; we
> >> already know that we won't enter the prompting-loop, beacuse
> >> is_file_in_use_error(GetLastError()) already evaluated to false.
> >
> > I usually prefer to break from the loop, to be able to add whatever
> > cleanup code we might need in the future after the loop.
> >
> > So does this fix the problem for you?
> >
> > -- snipsnap --
> > diff --git a/compat/mingw.c b/compat/mingw.c
> > index 04af3dc..504495a 100644
> > --- a/compat/mingw.c
> > +++ b/compat/mingw.c
> > @@ -259,7 +259,8 @@ int mingw_rmdir(const char *pathname)
> >                 return -1;
> >
> >         while ((ret = _wrmdir(wpathname)) == -1 && tries < ARRAY_SIZE(delay)) {
> > -               if (!is_file_in_use_error(GetLastError()))
> > +               errno = err_win_to_posix(GetLastError());
> > +               if (errno != EACCESS)
> >                         break;
> >                 if (!is_dir_empty(wpathname)) {
> >                         errno = ENOTEMPTY;
> > @@ -275,7 +276,7 @@ int mingw_rmdir(const char *pathname)
> >                 Sleep(delay[tries]);
> >                 tries++;
> >         }
> > -       while (ret == -1 && is_file_in_use_error(GetLastError()) &&
> > +       while (ret == -1 && errno == EACCESS &&
> >                ask_yes_no_if_possible("Deletion of directory '%s' failed. "
> >                         "Should I try again?", pathname))
> >                ret = _wrmdir(wpathname);
> 
> Yes, as long as you do s/EACCESS/EACCES/ first. I don't mind such a
> version instead.

As you probably suspected, I did not have a way to test-compile it before
sending.

The reason I was suggesting my version of the patch was to unify the error
handling: rather than relying on both errno and GetLastError() (but for
different error conditions), I would like to rely on only one: errno. That
way, they cannot contradict each other (as they did in your case).

However, I have no strong opinion on this, so please apply the version you
like better.

Ciao,
Dscho

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
