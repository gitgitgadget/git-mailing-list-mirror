From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's not in 'master', and likely not to be until 1.5.4
Date: Fri, 18 Jan 2008 22:37:29 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801182228470.5731@racer.site>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com> <1200022189-2400-2-git-send-email-mlevedahl@gmail.com> <7v1w8o4ws0.fsf@gitster.siamese.dyndns.org> <30e4a070801111252s4e17b9c4m62adeb9032963e66@mail.gmail.com> <7v63xzzszp.fsf@gitster.siamese.dyndns.org>
 <478855B5.9070600@gmail.com> <7vbq7ry405.fsf@gitster.siamese.dyndns.org> <47885B2C.8020809@gmail.com> <7v7iify2wm.fsf@gitster.siamese.dyndns.org> <4788BFA8.2030508@gmail.com> <7vwsqeubj8.fsf@gitster.siamese.dyndns.org> <47891658.3090604@gmail.com>
 <7vbq7qssd7.fsf@gitster.siamese.dyndns.org> <47893E1A.5020702@gmail.com> <7v4pdislrf.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de> <7vir1xmazm.fsf@gitster.siamese.dyndns.org>
 <7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org> <7vfxwvfmd8.fsf_-_@gitster.siamese.dyndns.org> <47908CAF.90101@viscovery.net> <alpine.LSU.1.00.0801181948060.5731@racer.site> <20080118220735.B7F4B49B15@dx.sixt.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Fri Jan 18 23:38:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFzqh-0004Vu-Qn
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 23:38:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762130AbYARWhh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 17:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762380AbYARWhh
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 17:37:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:39909 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759645AbYARWhg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 17:37:36 -0500
Received: (qmail invoked by alias); 18 Jan 2008 22:37:34 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp012) with SMTP; 18 Jan 2008 23:37:34 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18WiNsTZcIWdAKlTGxtG+Xa1CfKxWT0WVSvgGQBOT
	0FVgbMcIeMiali
X-X-Sender: gene099@racer.site
In-Reply-To: <20080118220735.B7F4B49B15@dx.sixt.local>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71071>

Hi,

On Fri, 18 Jan 2008, Johannes Sixt wrote:

> Johannes Schindelin wrote:
> 
> > - Possibly some of these commits could be folded back into
> >   f90524e(Add target architecture MinGW):
> > 
> >   96a27f1(MinGW: Implement gettimeofday()),
> >   2e05f891(Implement a rudimentary poll() emulation for Windows),
> >   142bda0(Fake implementions of getpwuid(), getuid(), and getpwnam() for
> > Windows),
> >   e799caf(Implement setitimer() and sigaction()),
> >   075fee7(Implement a wrapper of execve that can invoke shell scripts),
> >   495f0af(Work around misbehaved rename() on Windows),
> >   34cf7fd(Implement a pipe() replacement whose ends are not inherited to
> > children),
> >   4504323(Implement start_command() for Windows),
> >   b8e84a6(Implement a work-around for a misbehaved vsnprintf on Windows),
> >   08bbcb4(Windows: always chmod(, 0666) before unlink()),
> >   f6bbf12(Windows: Implement a wrapper of the open() function),
> >   56cedf3(Windows: Fix PRIuMAX definition),
> >   7458a97(Windows: Implement wrappers for gethostbyname(), socket(), and
> > connect()),
> >   ef25947(Windows: Fix ntohl() related warnings about printf formatting),
> >   b9db7ad(Windows: Implement a custom spawnve()), and
> >   47dacb3(compat/pread.c: Add foward decl to fix warning)
> 
> This would become a gigantic patch, which I really dislike. It's much 
> easier to follow (and bisect) if things appear in smaller pieces.

Yes, probably.  (See below for the bisection.)

> > - d6596ed(gitk: Disable msgfmt on MinGW) and
> >   004fb4b(Fix renaming .gitk-new to .gitk on Windows if there is already a
> > .gitk)
> >   are gitk patches.
> >   Further, I think that d6596ed would be better done as an automatic
> >   detection of msgfmt's presence; on my Eee PC, there is no msgfmt
> >   either...
> 
> Let's do that later.

I think these are more or less independent of the rest.

> > - 20fd16e(Windows: Use a customized struct stat that also has the
> > st_blocks member) should be folded into
> >   6f97065(Add a new lstat and fstat implementation based on Win32 API)
> >   (with a comment that you customized the struct stat, too)
> > 
> >   But then, without 20fd16e, git does not compile, so again I would rather
> >   fold that back into the MinGW commit.
> 
> The custom lstat() implementation cannot come after the custom struct 
> stat because we can't call Windows's stat() with a custom struct stat. 
> But I also don't want the custom lstat() in the code from the beginning 
> because it's merely an optimization.

Okay.

> > - in git.git, the onelines are not terminated by "."
> 
> You mean commit messages?

I meant the subjects of the commit messages.  I.e. "Add target 
architecture MinGW.".  But that's such a minor issue.

> > - I'd prefer f90524e(Add target architecture MinGW) to come last.
> >   Alternatively, you could cut out the Makefile change so that the series
> >   is still bisectable: MinGW will just not be supported until the very
> >   end.
> 
> I strongly disagree. The series is completely bisectable on *nix. But if 
> the Makefile change comes last, it becomes difficult to bisect on MinGW.

Hmm.  You're right, of course, for *nix.

But for MinGW I am not really sure, as you do not really get a 
fully functional system prior to all of the 42 patches...

I am really torn on this, because I can understand your point of view.

But when there would be an issue with MinGW, and I wanted to find out if 
it worked _at all_, it would be nice to have an easily determined commit 
where MinGW was supposed to be fully functional first, without a private 
tag or something.

Reading again what I wrote it appears that my opinion on that was strong; 
it is not.  I am not quite sure what would be best.  (In the end, I will 
always have the option to not care and let it be Junio's problem ;-)

> > $ git grep __MINGW j6t/upstream
> > 
> > comes up with 26 hits.
> > 
> > The first of them: cache.h:381, function is_absolute_path().  That just
> > cries out loud to be "#ifdef DOS_STYLE_PATHS" instead of "#ifdef
> > __MINGW32__".
> > 
> > I guess there should also be -DHAS_NO_FORK_BUT_THREADS 
> > -DHAS_TMP_AND_TEMP -DHAS_WINSOCK2, but most of them look like 
> > -DDOS_STYLE_PATHS to me.
> 
> Doesn't this go too far? How many systems are there where not all of 
> them would be set at the same time?

I am not only thinking about other systems... it is also a pretty nice way 
of documenting _why_ this change was made.  With the possible exception of 
HAS_TMP_AND_TEMP, I really would like to see that.  So much so that I 
hereby offer to do the transform myself.

Ciao,
Dscho
