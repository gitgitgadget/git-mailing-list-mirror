From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git on MSys (or how to make it easy for Windows users to compile
 git)
Date: Mon, 6 Aug 2007 01:11:24 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708060054020.14781@racer.site>
References: <Pine.LNX.4.64.0708022206130.14781@racer.site> 
 <460B6BF8541C4D9B916F02A12E0576F5@ntdev.corp.microsoft.com> 
 <46B2D4D9.4020103@trolltech.com>  <a1bbc6950708030258h16a6514kf5c637af13874fb7@mail.gmail.com>
  <Pine.LNX.4.64.0708031334530.14781@racer.site> 
 <E3C81783E0454702B1F38D0B68CE1AC0@ntdev.corp.microsoft.com> 
 <Pine.LNX.4.64.0708032231320.14781@racer.site> 
 <e7bda7770708031716i61f80d89o8970b3236a961613@mail.gmail.com> 
 <Pine.LNX.4.64.0708040123560.14781@racer.site>
 <e7bda7770708051641h15bd38abo659e74322e6232c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1479068283-1186359084=:14781"
Cc: Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	Marius Storm-Olsen <marius@trolltech.com>, git@vger.kernel.org
To: Torgil Svensson <torgil.svensson@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 06 02:12:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHqCe-0008PS-On
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 02:12:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757567AbXHFAME (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 20:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbXHFAMD
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 20:12:03 -0400
Received: from mail.gmx.net ([213.165.64.20]:56731 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751045AbXHFAMB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 20:12:01 -0400
Received: (qmail invoked by alias); 06 Aug 2007 00:11:59 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp056) with SMTP; 06 Aug 2007 02:11:59 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19sP+NTujZsizwD061oQmwOCQzlmak680xIcyJH9K
	4W3um3XOJwDShJ
X-X-Sender: gene099@racer.site
In-Reply-To: <e7bda7770708051641h15bd38abo659e74322e6232c0@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55088>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1479068283-1186359084=:14781
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 6 Aug 2007, Torgil Svensson wrote:

> On 8/4/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> > > 1. Unpacking in a folder that have space in it's path gave various 
> > > errors of this type (here, msysGit is unpacked on the desktop 
> > > C:\Documents and settings\.... ) : make[1]: C:/Documents: Command 
> > > not found
> >
> > Good point.  Did you fix it?  If so, where is the patch?  Or even 
> > better, what is your account on repo.or.cz so I can add it, and you 
> > can commit your fix yourself?
> 
> I didn't. I bypassed it (unpacked to C:\). I found the bug however 
> (missed quoting):
> 
> $ diff -urN msysGit msysGit-fixed
> diff -urN msysGit/git/git-gui/Makefile msysGit-fixed/git/git-gui/Makefile
> --- msysGit/git/git-gui/Makefile        Fri Aug  3 15:00:16 2007
> +++ msysGit-fixed/git/git-gui/Makefile  Mon Aug  6 01:22:53 2007
> @@ -4,7 +4,7 @@
>  #
> 
>  GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
> -       @$(SHELL_PATH) ./GIT-VERSION-GEN
> +       @"$(SHELL_PATH)" ./GIT-VERSION-GEN

AFAICT this _fixes_ compilation in a patch containing spaces, not break 
it.

> diff: msysGit/git/gitweb/test/M??rchen: No such file or directory
> diff: msysGit-fixed/git/gitweb/test/M??rchen: No such file or directory

Yes, that Märchen is a constant pain.  I think it is the reason Kai 
vanished: he does not want to bear the consequences of his wrong doing.

Of course, it has exposed errors regarding encoding in filenames.  But 
those are errors in the OSes (or in this case, MSys), and _not_ to be 
fixed within git.

> I'll make an account and send you the details when I get an public 
> SSH-key, haven't done that in windows before. Can I share private key on 
> both windows and Linux box?

Yes.  However, I inherently distrust Windows.  So I made a separate 
account on Windows.

NOTE: earlier installers included msys-rxvt.bat.  I now _know_ for a fact 
that a lot of things are strangely broken under Rxvt.  For example, 
creating an ssh key, of all things.

I'd be more than happy to add you to the member list.

> > > 2. rxvt-terminal had some freezes
> >
> > I did not experience those.  Could you research further?

Those "freezes" were due to the fact that Rxvt incorrectly updates stderr 
in a blocking way, or not at all (don't know which).  There are more 
things that do not work in Rxvt, and only after trying the same in cmd 
(which I do not like for various reasons) I found out that rxvt.exe is at 
fault.

I would be glad if somebody managed to compile rxvt herself and fix all 
those bugs (see http://code.google.com/p/msysgit/ for a short list of the 
most pressing issues I found).  As it is, I have enough work to do with 
the rest of msysGit, and for the moment, I can at least work in cmd.  Even 
ssh push works.

> Some observations:
> "git log" on mingw archive trigger this every time for me (hangs on
> different places each time).

Never experienced those.

> "cmd" terminal (msys.bat) seems to pipe "git log" to less while rxvt
> terminal outputs lots of text very fast (msys-rxvt.bat) and freezes.
> Output:ing lots of text itself doesn't seem to be an issue ("make -d"
> doesn't freeze and outputs _lots_ of text)

It never froze for me.  However, as stated, Rxvt is too workaroundable for 
me to work on it (although I like Rxvt better than cmd).  Any help 
appreciated very much.

> > > 3. "gitk --all" said "Error reading commits: fatal: write failure on
> > > stdout: Invalid argument"
> >
> > I did not even bother testing gitk...  Any idea what is going wrong?

gitk worked fine for me, as long as I had _any_ refs in the repo.

> The fconfigure -blocking command seems to be not supported under
> mingw. This patch makes the error go away. Another issue that is
> probably related to this is that gitk doesn't list all commits. I
> don't know how to solve this properly.
> 
> diff --git a/gitk b/gitk
> index 43d88ca..69e5149 100755
> --- a/gitk
> +++ b/gitk
> @@ -147,7 +147,7 @@ proc getcommitlines {fd view}  {
>         unset commfd($view)
>         notbusy $view
>         # set it blocking so we wait for the process to terminate
> -       fconfigure $fd -blocking 1
> +       #fconfigure $fd -blocking 1

I have to wonder how you called it... From msys.bat, cd'ing into a valid 
repository, I had no issues whatsoever.

> > > 4. Mouse-wheel didn't work to scroll views in gitk
> >
> > Again, no idea why.  Could you please investigate?
> 
> Tough one since I didn't take the tcl tk debugging class. Doesn't work
> for me in cygwin either. I don't know if it's implemented at all. Does
> it work for anyone else?

I just tested via VNC, and indeed, it does not work.  My guess is that 
MinGW's Tk version has a different number assigned to the scroll wheel 
(the scroll wheel is usually implemented as constant fire on a special 
mouse button; AFAICT buttons 4 and 5 are assumed to be the scroll buttons 
in gitk).

Now, I do not know what these are called on Windows, but there should be a 
thing like "xev" on Windows, too...  Anybody?

Ciao,
Dscho

--8323584-1479068283-1186359084=:14781--
