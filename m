From: "Chris Lee" <chris133@gmail.com>
Subject: Re: git-svnimport failed and now git-repack hates me
Date: Wed, 3 Jan 2007 18:16:51 -0800
Message-ID: <204011cb0701031816hda8af9bw4d4a469c2b111339@mail.gmail.com>
References: <204011cb0701031552j8292d23v950f828279702d3@mail.gmail.com>
	 <Pine.LNX.4.64.0701031737300.4989@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jan 04 16:29:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2UX2-00067x-LH
	for gcvg-git@gmane.org; Thu, 04 Jan 2007 16:29:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964906AbXADP3W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Jan 2007 10:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964911AbXADP3V
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jan 2007 10:29:21 -0500
Received: from smtp.osdl.org ([65.172.181.24]:58403 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964906AbXADP3T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jan 2007 10:29:19 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l04FTGWi018459
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 4 Jan 2007 07:29:16 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l04FTF5l022302;
	Thu, 4 Jan 2007 07:29:15 -0800
X-Return-Path: <chris133@gmail.com>
X-Received: from woody.osdl.org (localhost.localdomain [127.0.0.1])
	by woody.osdl.org (8.13.8/8.13.8) with ESMTP id l04F8CLU008057
	for <torvalds@localhost>; Thu, 4 Jan 2007 07:08:33 -0800
X-Received: from imap.osdl.org [65.172.181.5]
	by woody.osdl.org with IMAP (fetchmail-6.3.4)
	for <torvalds@localhost> (single-drop); Thu, 04 Jan 2007 07:08:33 -0800 (PST)
X-Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.24])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l04EsSpH021050
	for <torvalds@mail.gateway.osdl.net>; Thu, 4 Jan 2007 07:01:25 -0800
X-Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.236])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l042GqJh022926
	for <torvalds@osdl.org>; Wed, 3 Jan 2007 18:16:52 -0800
X-Received: by wr-out-0506.google.com with SMTP id i20so2173283wra
        for <torvalds@osdl.org>; Wed, 03 Jan 2007 18:16:51 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gCpbBN7VYwS5a2uvSFvE2H5Ge7nRlspPbOHnx0EZUdxeXvSTcp0liogeZwTjoH3BKZaXInN+iqti7S4KSNy7sTPzv4d8qMTgfwJLFO7Xj3RtPpBU1lZeAPdbcsPzZ8jtAbtQQ9BXuz8z/gCmArC92PsyHv4TleJ38JF7THd2TEs=
X-Received: by 10.90.105.19 with SMTP id d19mr13810667agc.1167877011870;
        Wed, 03 Jan 2007 18:16:51 -0800 (PST)
X-Received: by 10.90.80.11 with HTTP; Wed, 3 Jan 2007 18:16:51 -0800 (PST)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701031737300.4989@woody.osdl.org>
Content-Disposition: inline
Received-SPF: pass (domain of chris133@gmail.com designates 64.233.184.236 as permitted sender)
X-Spam-Status: No, hits=0.499 required=5 tests=FROM_ENDS_IN_NUMS,OSDL_HEADER_SPF_PASS
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.107__
X-MIMEDefang-Filter: osdl$Revision: 1.166 $
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35934>

On 1/3/07, Linus Torvalds <torvalds@osdl.org> wrote:
> > So I'm using git 1.4.1, and I have been experimenting with importing
> > the KDE sources from Subversion using git-svnimport.
>
> As one single _huge_ import? All the sub-projects together? I have to say,
> that sounds pretty horrid.

Unfortunately, that's how the KDE repo is organized. (I tried arguing
against this when they were going to do the original import, but I
lost the argument.) And git-svnimport doesn't appear to have any sort
of method for splitting a gigantic svn repo into several smaller git
repos.

> > First issue I ran into: On a machine with 4GB of RAM, when I tried to
> > do a full import, git-svnimport died after 309906 revisions, saying
> > that it couldn't fork.
> >
> > Checking `top` and `ps` revealed that there were no git-svnimport
> > processes doing anything, but all of my 4G of RAM was still marked as
> > used by the kernel. I had to do sysctl -w vm.drop_caches=3 to get it
> > to free all the RAM that the svn import had used up.
>
> I think that was just all cached, and all ok. The reason you didn't see
> any git-svnimport was that it had died off already, and all your memory
> was just caches. You could just have left it alone, and the kernel would
> have started re-using the memory for other things even without any
> "drop_caches".
>
> But what you did there didn't make anything worse, it was just likely had
> no real impact.

I got the tip about drop_caches from davej. Normally, when a process
taking up a huge amount of memory exits, it shows a bunch of free
memory in `top` and friends. I was a little bit surprised when that
didn't happen this time.

> However, it does sound like git-svnimport probably acts like git-cvsimport
> used to, and just keeps too much in memory - so it's never going to act
> really nicely..
>
> It also looks like git-svnimport never repacks the repo, which is
> absolutely horrible for performance on all levels. The CVS importer
> repacks every one thousand commits or something like that.

Yeah. I haven't bothered hacking git-svnimport yet - but it looks like
having it automatically repack every thousand revisions or so would
probably be a pretty big win.

> > Now, after that, I tried doing `git-repack -a` because I wanted to see
> > how small the packed archive would be (before trying to continue
> > importing the rest of the revisions. There are at least another 100k
> > revisions that I should be able to import, eventually.)
>
> I suspect you'd have been better off just re-starting, and using something
> like
>
>         while :
>         do
>                 git svnimport -l 1000 <...>
>                 .. figure out some way to decide if it's all done ..
>                 git repack -d
>         done
>
> which would make svnimport act a bit  more sanely, and repack
> incrementally. That should make both the import much faster, _and_ avoid
> any insane big repack at the end (well, you'd still want to do a "git
> repack -a -d" at the end to turn the many smaller packs into a bigger one,
> but it would be nicer).
>
> However, I don't know what the proper magic is for svnimport to do that
> sane "do it in chunks and tell when you're all done". Or even better - to
> just make it repack properly and not keep everything in memory.

You can pass limits to svnimport to give it a revision to start at and
another one to end at, so that wouldn't be too bad - I was thinking
about working around it like that (so that i don't have to go poking
around in the Perl code behind the svn importer).

By default, if I had, say, one pack with the first 1000 revisions, and
I imported another 1000, running 'git-repack' on its own would leave
the first pack alone and create a new pack with just the second 1000
revisions, right?

> > The repack finished after about nine hours, but when I try to do a
> > git-verify-pack on it, it dies with this error message:
> >
> > error: Packfile
> > .git/objects/pack/pack-540263fe66ab9398cc796f000d52531a5c6f3df3.pack
> > SHA1 mismatch with itself
>
> That sounds suspiciously like the bug we had in out POWER sha1
> implementation that would generate the wrong SHA1 for any pack-file that
> was over 512MB in size, due to an overflow in 32 bits (SHA1 does some
> counting in _bits_, so 512MB is 4G _bits_),
>
> Now, I assume you're not on POWER (and we fixed that bug anyway - and I
> think long before 1.4.1 too), but I could easily imagine the same bug in
> some other SHA1 implementation (or perhaps _another_ overflow at the 1GB
> or 2GB mark..). I assume that the pack-file you had was something horrid..
>
> I hope this is with a 64-bit kernel and a 64-bit user space? That should
> limit _some_ of the issues. But I would still not be surprised if your
> SHA1 libraries had some 32-bit ("unsigned int") or 31-bit ("int") limits
> in them somewhere - very few people do SHA1's over huge areas, and even
> when you do SHA1 on something like a DVD image (which is easily over any
> 4GB limit), that tends to be done as many smaller calls to the SHA1
> library routines.

This is on a dual-CPU dual-core Opteron, running the AMD64 variant of
Ubuntu's Edgy release (64-bit kernel, 64-bit native userland). The
pack-file was around 2.3GB.
