From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC 1/5] mingw: make fgetc raise SIGINT if apropriate
Date: Tue, 4 Dec 2012 18:12:02 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1212041809150.31987@s15462909.onlinehome-server.info>
References: <1352815447-8824-1-git-send-email-kusmabite@gmail.com> <1352815447-8824-2-git-send-email-kusmabite@gmail.com> <alpine.DEB.1.00.1211301857170.31987@s15462909.onlinehome-server.info>
 <CABPQNSaCV820zhJGdW++LMf2U7AeODSbfukix3fMfffmNex4YA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com, peff@peff.net
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: msysgit+bncBCZPH74Q5YNRBZG57CCQKGQEFFSRF4A@googlegroups.com Tue Dec 04 18:12:17 2012
Return-path: <msysgit+bncBCZPH74Q5YNRBZG57CCQKGQEFFSRF4A@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f186.google.com ([209.85.212.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBZG57CCQKGQEFFSRF4A@googlegroups.com>)
	id 1Tfw2b-0008Hi-0o
	for gcvm-msysgit@m.gmane.org; Tue, 04 Dec 2012 18:12:17 +0100
Received: by mail-wi0-f186.google.com with SMTP id hm9sf381014wib.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 04 Dec 2012 09:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:x-authenticated:x-provags-id:date:from
         :x-x-sender:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-y-gmx-trusted:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=cabU1dYVKpEbqBWGu1b9gPHT34Rw0ope3cfyxJt00Xc=;
        b=rUL3+Dq33o6Xpfvz2yCpkh/H7iAu4IqhdFm5HO5vAQQu1upS0Xm/AIDKiP8oP6ifXA
         cDQOScAaKXI+6mgG+6n3StreudcbBnQKoPDHuAvq8DoJBIHF3e/X6zwYINypbHiKNWTC
         +OqOKDZYvOJFB5NU0jlpy47u8K+gmldY8sqKUR7HMZCwHZ+UTSGxsmGSb8k9aZxwjEVz
         cEet6+7PLpnVEijwI8u+6zkT3/o4NOOoYWrLgyULcXZTbVDBmWI1j17A5zyzcwqHyfcn
         fwdalXazyZO2kQK4Zz 
Received: by 10.180.94.1 with SMTP id cy1mr646841wib.5.1354641125306;
        Tue, 04 Dec 2012 09:12:05 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.97.130 with SMTP id ea2ls373047wib.20.gmail; Tue, 04 Dec
 2012 09:12:04 -0800 (PST)
Received: by 10.14.224.201 with SMTP id x49mr2107368eep.5.1354641124171;
        Tue, 04 Dec 2012 09:12:04 -0800 (PST)
Received: by 10.14.224.201 with SMTP id x49mr2107367eep.5.1354641124160;
        Tue, 04 Dec 2012 09:12:04 -0800 (PST)
Received: from mailout-de.gmx.net (mailout-de.gmx.net. [213.165.64.22])
        by gmr-mx.google.com with SMTP id u8si577021een.1.2012.12.04.09.12.04;
        Tue, 04 Dec 2012 09:12:04 -0800 (PST)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.22 as permitted sender) client-ip=213.165.64.22;
Received: (qmail invoked by alias); 04 Dec 2012 17:12:03 -0000
Received: from s15462909.onlinehome-server.info (EHLO s15462909.onlinehome-server.info) [87.106.4.80]
  by mail.gmx.net (mp036) with SMTP; 04 Dec 2012 18:12:03 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/B3F4dXgLBzH576kYI3Aj0LsT86Qbe0kORMqyOKl
	axgDy9CKmN8saL
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <CABPQNSaCV820zhJGdW++LMf2U7AeODSbfukix3fMfffmNex4YA@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of Johannes.Schindelin@gmx.de designates 213.165.64.22 as permitted
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211088>

Hi kusma,

On Sat, 1 Dec 2012, Erik Faye-Lund wrote:

> On Fri, Nov 30, 2012 at 6:58 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Hi,
> >
> > On Tue, 13 Nov 2012, Erik Faye-Lund wrote:
> >
> >> Set a control-handler to prevent the process from terminating, and
> >> simulate SIGINT so it can be handled by a signal-handler as usual.
> >
> > One thing you might want to mention is that the fgetc() handling is not
> > thread-safe, and intentionally so: if two threads read from the same
> > console, we are in trouble anyway.
> 
> I'm not entirely sure if I know what you mean. Do you suggest that two
> threads can race for setting the console ctrl-handler?

That was my idea, yes.

> I don't think that's the case; "SetConsoleCtrlHandler(x, TRUE)" adds a
> console handler to the handler-chain, and SetConsoleCtrlHandler(x,
> FALSE) removes it. If two threads add handlers, it is my understanding
> that one of them will be run, only to report "no, no more ctrl-handling
> needed". Since both handlers block further ctrl-handling, I don't think
> there's a problem.

My idea was that the SetConsoleCtrlHandler(x, FALSE) could remove the
handler prematurely iff another thread wanted to install the very same
handler (but it was already installed by the first thread).

But as I said: for this to happen, *two* threads need to want to access
the console for reading. In that case we'd be in bigger trouble than
thread unsafety... We cannot read two passwords from the same console at
the same time.

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
