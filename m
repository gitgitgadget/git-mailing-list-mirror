From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's not in 'master', and likely not to be until 1.5.4
Date: Fri, 18 Jan 2008 20:36:52 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801181948060.5731@racer.site>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com> <1200022189-2400-2-git-send-email-mlevedahl@gmail.com> <7v1w8o4ws0.fsf@gitster.siamese.dyndns.org> <30e4a070801111252s4e17b9c4m62adeb9032963e66@mail.gmail.com> <7v63xzzszp.fsf@gitster.siamese.dyndns.org>
 <478855B5.9070600@gmail.com> <7vbq7ry405.fsf@gitster.siamese.dyndns.org> <47885B2C.8020809@gmail.com> <7v7iify2wm.fsf@gitster.siamese.dyndns.org> <4788BFA8.2030508@gmail.com> <7vwsqeubj8.fsf@gitster.siamese.dyndns.org> <47891658.3090604@gmail.com>
 <7vbq7qssd7.fsf@gitster.siamese.dyndns.org> <47893E1A.5020702@gmail.com> <7v4pdislrf.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de> <7vir1xmazm.fsf@gitster.siamese.dyndns.org>
 <7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org> <7vfxwvfmd8.fsf_-_@gitster.siamese.dyndns.org> <47908CAF.90101@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jan 18 21:37:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFxy2-0002xF-UI
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 21:37:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760944AbYARUhB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 15:37:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760965AbYARUhB
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 15:37:01 -0500
Received: from mail.gmx.net ([213.165.64.20]:37974 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760337AbYARUg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 15:36:59 -0500
Received: (qmail invoked by alias); 18 Jan 2008 20:36:58 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp002) with SMTP; 18 Jan 2008 21:36:58 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18MNst/UdYMkrqLiV4gmkdvl6dqMqQXbl4psP4N3a
	2tMX1l1v8j2wRP
X-X-Sender: gene099@racer.site
In-Reply-To: <47908CAF.90101@viscovery.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71059>

Hi,

On Fri, 18 Jan 2008, Johannes Sixt wrote:

> Junio C Hamano schrieb:
> > Here is an update to the list I sent earlier.  Topics that I
> > thought may deserve attention, discussion and eventual inclusion
> > but are not 1.5.4 material.
> 
> BTW, how would you like to have a 40+ patch series presented that
> implements the port to MinGW? Should I send to the ML despite its volume?
> (Of course not before 1.5.4 is released.)
> 
> The current state of the series is available here:
> http://repo.or.cz/w/git/mingw/j6t.git?a=shortlog;h=upstream

Comments from reading the patches briefly (since there are 42 patches, it 
needs quite some time to even do it briefly):

- Possibly some of these commits could be folded back into
  f90524e(Add target architecture MinGW):

  96a27f1(MinGW: Implement gettimeofday()),
  2e05f891(Implement a rudimentary poll() emulation for Windows),
  142bda0(Fake implementions of getpwuid(), getuid(), and getpwnam() for 
	  Windows),
  e799caf(Implement setitimer() and sigaction()),
  075fee7(Implement a wrapper of execve that can invoke shell scripts),
  495f0af(Work around misbehaved rename() on Windows),
  34cf7fd(Implement a pipe() replacement whose ends are not inherited to 
	  children),
  4504323(Implement start_command() for Windows),
  b8e84a6(Implement a work-around for a misbehaved vsnprintf on Windows),
  08bbcb4(Windows: always chmod(, 0666) before unlink()),
  f6bbf12(Windows: Implement a wrapper of the open() function),
  56cedf3(Windows: Fix PRIuMAX definition),
  7458a97(Windows: Implement wrappers for gethostbyname(), socket(), and 
	  connect()),
  ef25947(Windows: Fix ntohl() related warnings about printf formatting),
  b9db7ad(Windows: Implement a custom spawnve()), and
  47dacb3(compat/pread.c: Add foward decl to fix warning)

- 142bda0(Fake implementions of getpwuid(), getuid(), and getpwnam() for 
	  Windows)
  does not really implement getuid() and getpwnam(), and does not "fake" 
  the implementation of getpwuid() either, but has a minimal 
  implementation of it (affecting the other two functions, of course).

- d6596ed(gitk: Disable msgfmt on MinGW) and
  004fb4b(Fix renaming .gitk-new to .gitk on Windows if there is already a 
	  .gitk)
  are gitk patches.

  Further, I think that d6596ed would be better done as an automatic 
  detection of msgfmt's presence; on my Eee PC, there is no msgfmt 
  either...

- 20fd16e(Windows: Use a customized struct stat that also has the 
	  st_blocks member) should be folded into
  6f97065(Add a new lstat and fstat implementation based on Win32 API)
  (with a comment that you customized the struct stat, too)

  But then, without 20fd16e, git does not compile, so again I would rather
  fold that back into the MinGW commit.

- I would group the following path related commits:

  f15879a(MSYS: local clone must use the drive letter in absolute paths),
  788324d(Handle Windows style absolute paths in 
	  safe_create_leading_directories( )),
  851d28d(Treat Windows style path names),
  8b9ce70(On Windows use the Windows style PATH separator in add_path()),
  8811d9c(On Windows strip ".exe" from the program name),
  af7a879(Windows: Disambiguate DOS style paths from SSH URLs),

  71911a8(Windows: TMP and TEMP environment variables specify a temporary 
	  directory),

  ea035ed(Turn builtin_exec_path into a function.)
  4e7e438(Compute the ultimate fallback for exec_path from the program 
	  invocation),

  abd87b3(Windows: Use a relative default template_dir and ETC_GITCONFIG),
  7162bf5(When installing, be prepared that template_dir may be relative).

  The latter two probably want to be merged, too.

- in git.git, the onelines are not terminated by "."

- in f6bbf12(Windows: Implement a wrapper of the open() function) there is 
  a typo: "on^".

- 47dacb3(compat/pread.c: Add foward decl to fix warning) has a typo:
  "foward".

- The SOB line does not come last in 075fee7(Implement a wrapper of execve 
  that can invoke shell scripts.)

- I'd prefer f90524e(Add target architecture MinGW) to come last.  
  Alternatively, you could cut out the Makefile change so that the series 
  is still bisectable: MinGW will just not be supported until the very 
  end.

Implementation-wise I could not go into too much depth, naturally, but one 
thing still struck me as odd:

	$ git grep __MINGW j6t/upstream

comes up with 26 hits.

The first of them: cache.h:381, function is_absolute_path().  That just 
cries out loud to be "#ifdef DOS_STYLE_PATHS" instead of "#ifdef 
__MINGW32__".

I guess there should also be -DHAS_NO_FORK_BUT_THREADS -DHAS_TMP_AND_TEMP 
-DHAS_WINSOCK2, but most of them look like -DDOS_STYLE_PATHS to me.

Uff.  That were quite some things to wade through, and it's only to get 
worse when I start for real ;-)

Ciao,
Dscho
