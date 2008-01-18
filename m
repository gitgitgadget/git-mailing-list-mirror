From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: What's not in 'master', and likely not to be until 1.5.4
Date: Fri, 18 Jan 2008 23:07:35 +0100
Message-ID: <20080118220735.B7F4B49B15@dx.sixt.local>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com> <1200022189-2400-2-git-send-email-mlevedahl@gmail.com> <7v1w8o4ws0.fsf@gitster.siamese.dyndns.org> <30e4a070801111252s4e17b9c4m62adeb9032963e66@mail.gmail.com> <7v63xzzszp.fsf@gitster.siamese.dyndns.org> <478855B5.9070600@gmail.com> <7vbq7ry405.fsf@gitster.siamese.dyndns.org> <47885B2C.8020809@gmail.com> <7v7iify2wm.fsf@gitster.siamese.dyndns.org> <4788BFA8.2030508@gmail.com> <7vwsqeubj8.fsf@gitster.siamese.dyndns.org> <47891658.3090604@gmail.com> <7vbq7qssd7.fsf@gitster.siamese.dyndns.org> <47893E1A.5020702@gmail.com> <7v4pdislrf.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de> <7vir1xmazm.fsf@gitster.siamese.dyndns.org> <7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org> 
 <7vfxwvfmd8.fsf_-_@gitster.siamese.dyndns.org> <47908CAF.90101@viscovery.net> <alpine.LSU.1.00.0801181948060.5731@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 18 23:08:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFzNi-0002Xr-8k
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 23:08:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764912AbYARWHl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 17:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764097AbYARWHl
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 17:07:41 -0500
Received: from smtp4.srv.eunet.at ([193.154.160.226]:37059 "EHLO
	smtp4.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763512AbYARWHi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 17:07:38 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp4.srv.eunet.at (Postfix) with ESMTP id 0469D9839E;
	Fri, 18 Jan 2008 23:07:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id B7F4B49B15;
	Fri, 18 Jan 2008 23:07:35 +0100 (CET)
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71070>

[Don't have Cc: in KNode. oh well...]

Johannes Schindelin wrote:
> On Fri, 18 Jan 2008, Johannes Sixt wrote:
>> BTW, how would you like to have a 40+ patch series presented that
>> implements the port to MinGW? Should I send to the ML despite its volume?
>> (Of course not before 1.5.4 is released.)
>> 
>> The current state of the series is available here:
>> http://repo.or.cz/w/git/mingw/j6t.git?a=shortlog;h=upstream
> 
> Comments from reading the patches briefly (since there are 42 patches, it
> needs quite some time to even do it briefly):

Thanks a lot!

I agree with everything I didn't quote from your message.

> - Possibly some of these commits could be folded back into
>   f90524e(Add target architecture MinGW):
> 
>   96a27f1(MinGW: Implement gettimeofday()),
>   2e05f891(Implement a rudimentary poll() emulation for Windows),
>   142bda0(Fake implementions of getpwuid(), getuid(), and getpwnam() for
> Windows),
>   e799caf(Implement setitimer() and sigaction()),
>   075fee7(Implement a wrapper of execve that can invoke shell scripts),
>   495f0af(Work around misbehaved rename() on Windows),
>   34cf7fd(Implement a pipe() replacement whose ends are not inherited to
> children),
>   4504323(Implement start_command() for Windows),
>   b8e84a6(Implement a work-around for a misbehaved vsnprintf on Windows),
>   08bbcb4(Windows: always chmod(, 0666) before unlink()),
>   f6bbf12(Windows: Implement a wrapper of the open() function),
>   56cedf3(Windows: Fix PRIuMAX definition),
>   7458a97(Windows: Implement wrappers for gethostbyname(), socket(), and
> connect()),
>   ef25947(Windows: Fix ntohl() related warnings about printf formatting),
>   b9db7ad(Windows: Implement a custom spawnve()), and
>   47dacb3(compat/pread.c: Add foward decl to fix warning)

This would become a gigantic patch, which I really dislike. It's much easier
to follow (and bisect) if things appear in smaller pieces.

> - d6596ed(gitk: Disable msgfmt on MinGW) and
>   004fb4b(Fix renaming .gitk-new to .gitk on Windows if there is already a
> .gitk)
>   are gitk patches.
>   Further, I think that d6596ed would be better done as an automatic
>   detection of msgfmt's presence; on my Eee PC, there is no msgfmt
>   either...

Let's do that later.

> - 20fd16e(Windows: Use a customized struct stat that also has the
> st_blocks member) should be folded into
>   6f97065(Add a new lstat and fstat implementation based on Win32 API)
>   (with a comment that you customized the struct stat, too)
> 
>   But then, without 20fd16e, git does not compile, so again I would rather
>   fold that back into the MinGW commit.

The custom lstat() implementation cannot come after the custom struct stat
because we can't call Windows's stat() with a custom struct stat. But I
also don't want the custom lstat() in the code from the beginning because
it's merely an optimization.

> - in git.git, the onelines are not terminated by "."

You mean commit messages?

> - I'd prefer f90524e(Add target architecture MinGW) to come last.
>   Alternatively, you could cut out the Makefile change so that the series
>   is still bisectable: MinGW will just not be supported until the very
>   end.

I strongly disagree. The series is completely bisectable on *nix. But if the
Makefile change comes last, it becomes difficult to bisect on MinGW.

> $ git grep __MINGW j6t/upstream
> 
> comes up with 26 hits.
> 
> The first of them: cache.h:381, function is_absolute_path().  That just
> cries out loud to be "#ifdef DOS_STYLE_PATHS" instead of "#ifdef
> __MINGW32__".
> 
> I guess there should also be -DHAS_NO_FORK_BUT_THREADS -DHAS_TMP_AND_TEMP
> -DHAS_WINSOCK2, but most of them look like -DDOS_STYLE_PATHS to me.

Doesn't this go too far? How many systems are there where not all of them
would be set at the same time?

-- Hannes
