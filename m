From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Thu, 2 Mar 2006 17:10:22 +0100
Message-ID: <81b0412b0603020810l57f9ee5p270f9c288770d1a7@mail.gmail.com>
References: <81b0412b0602230000t58a88af6na1aa7e323dc0179d@mail.gmail.com>
	 <81b0412b0602230135w472aa6f3v72980f6f63bb355f@mail.gmail.com>
	 <81b0412b0602230141g46dbfaev6baa5083dee2d42@mail.gmail.com>
	 <43FD84EB.3040704@op5.se>
	 <81b0412b0602230210r3ffe6e2dta5dc86d6516692b9@mail.gmail.com>
	 <43FDB8CC.5000503@op5.se>
	 <81b0412b0602230607n22146a77k36929f0ad9e44d53@mail.gmail.com>
	 <20060226195552.GA30735@trixie.casa.cgf.cx>
	 <81b0412b0603020610q41d0ec98x80d112b7daa179fa@mail.gmail.com>
	 <20060302150016.GC2781@trixie.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 02 17:12:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEqNo-0004oJ-Ki
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 17:10:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751997AbWCBQKZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 11:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751993AbWCBQKZ
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 11:10:25 -0500
Received: from nproxy.gmail.com ([64.233.182.203]:25449 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751997AbWCBQKZ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Mar 2006 11:10:25 -0500
Received: by nproxy.gmail.com with SMTP id c31so306370nfb
        for <git@vger.kernel.org>; Thu, 02 Mar 2006 08:10:22 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AYdJZa8l0TkbiHfpO3qA1r5GempatGXktyqpW2IS/hlAolZBIBgKM4xCrPoxmP458hf0N3XeWUdxCkkaoDgVcxyq0HvicM1Obzu84w2/kD69WdK6ri3sNMAis+9GfTbtB2Cnd3s/HFu/aK2h+QW+S90+xDcgW251EnbrtIJoY+I=
Received: by 10.49.18.14 with SMTP id v14mr706543nfi;
        Thu, 02 Mar 2006 08:10:22 -0800 (PST)
Received: by 10.49.88.16 with HTTP; Thu, 2 Mar 2006 08:10:22 -0800 (PST)
To: "Christopher Faylor" <me@cgf.cx>
In-Reply-To: <20060302150016.GC2781@trixie.casa.cgf.cx>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17087>

On 3/2/06, Christopher Faylor <me@cgf.cx> wrote:
> >That's not enough.
> >Try interrupting busy processes. Like "git pull", "git clone" or make.
>
> Are you saying that typing CTRL-C doesn't work when you use "git pull"?

It does. Almost always. It's the seldom cases when this does not
really work which annoy me that much.

> If so, give me a real bug report that I can look into.  I interrupt
> "busy" processes on cygwin all of the time so I'm not going to spend a
> few hours typing "git pull" on my system only to find out that you are
> talking about an environment that uses ActiveState perl on Windows 95
> using Netware.

well, it is almost exactly the case: WinNT 2K. And I cannot change this.

> If you are reporting a problem you need to provide details.

I am NOT reporting a problem. Everyone knows there are these problems,
it's just almost no one (including me) cares enough about getting anything
to work sanely on windows.

Please, stop assuming that every my complaint is a bug report about
cygwin. It is not. You can use my mails as you please, even as bug reports.
If you ask nicely, I can provide more details maybe. But I am not asking
YOU for anything, and not complaining to YOU about anything.

I _do_not_ like how Cygwin workarounds windows, but I respect the
effort and understand why it happens. Still, I'd prefer it die. I'll try to
keep it moving, but no farther than needed and only when I really have to.

> There are also other mechanisms for a native windows
> program to deal with CTRL-C so this really shouldn't be an issue for
> any well-written program.

In windows you have to do hell of a lot useless typing to write what you
consider a "well-written program".

> >I wont be pressing anyone to implement them in windows, having the
> >knowledge.  What I'd actually suggest is to drop their implementation
> >entierly, returning ENOSYS,
>
> You're not being clear again, but if you are actually promoting the
> notion of cygwin not implementing signals then that is a really daft
> idea.  Really.  Go to the Cygwin web site and look at all of the
> packages which have been ported.  Now think about how they would work if
> Cygwin didn't support signals.  bash wouldn't work, openssh, X wouldn't
> work.

That's right. They are not _ported_. I'm not interested in xterm which
prints page in a minute.

> >so that programs are not fooled into believing that the system will
> >work as expected.  It never will.  "Ctrl-C" in windows console is just
> >a shortcut to TerminateProcess, live with that.
>
> Let me say it again since it isn't clear that you are getting it.  If
> signals in a pure cygwin environment don't work then that is *a bug*.

Whatever you say. I never expected them to, personally.

> If you are running pure windows programs in the mix with cygwin programs
> then if *they* don't stop when you hit CTRL-C, that is undoubtedly a bug
> in that pure windows program.

Maybe. I wouldn't blame that poor windows programmer though: it's hard,
boring and in 99.9999% of starts of that program - dead code.

> If you find that a pure windows program terminates when run from a
> windows command prompt but keeps running when run by a cygwin program
> then that is likely a cygwin problem that can be reported to the cygwin
> mailing list.

gui applications detach from cmd (not from cygwin console),
so that kind of pointless exercise.

> I'd suggest that using git with native windows programs should probably
> be considered "unsupported" since you seem to be having so much trouble
> with it.

I'd suggest calling cygwin ports unsupported.

> >I cannot use umask, because I have to use stupid windows programs, and
> >they always create "executable" *.c and *.h, and I cannot blindly
> >remove it with something like "chmod -R -x", because it'd remove it
> >also from executables.
>
>   find . -name '*.[ch]' | xargs chmod a-x

find . -name '*.[ch]' -o -name '*.[ch]pp' -o -name Makefile -o -name
'*.txt' -o ...ooh! damn it^C -print0| xargs -0 chmod -x
You oversimplifying.
