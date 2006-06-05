From: Alec Warner <antarus@gentoo.org>
Subject: Re: irc usage..
Date: Sun, 04 Jun 2006 20:33:31 -0400
Organization: Gentoo
Message-ID: <44837BDB.2090601@gentoo.org>
References: <Pine.LNX.4.64.0605201016090.10823@g5.osdl.org>	 <447B7669.8050805@gentoo.org>	 <46a038f90605301531g4f8b37c7qab9a717833c64ebc@mail.gmail.com>	 <Pine.LNX.4.64.0605301604130.24646@g5.osdl.org>	 <46a038f90605301804u3beabf4ct97c8a0ea6ef7b995@mail.gmail.com>	 <447D043D.1020609@gentoo.org>	 <46a038f90605302305g7a969a62r277af1724b912069@mail.gmail.com>	 <447DA028.3040606@gentoo.org>	 <46a038f90605311503o1526c664qe61b0f3f40929b92@mail.gmail.com>	 <447E4611.7000309@gentoo.org> <46a038f90606010047r676840d2nd91ad2361abbe1c8@mail.gmail.com>
Reply-To: antarus@gentoo.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Donnie Berkholz <spyderous@gentoo.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Yann Dirson <ydirson@altern.org>,
	Git Mailing List <git@vger.kernel.org>,
	Matthias Urlichs <smurf@smurf.noris.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 05 02:33:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fn32R-0003xR-Qp
	for gcvg-git@gmane.org; Mon, 05 Jun 2006 02:33:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbWFEAdo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Jun 2006 20:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbWFEAdo
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 20:33:44 -0400
Received: from jeeves.egr.msu.edu ([35.9.37.127]:54929 "EHLO egr.msu.edu")
	by vger.kernel.org with ESMTP id S932350AbWFEAdn (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Jun 2006 20:33:43 -0400
Received: from [69.176.143.70] (69-176-143-70.dov.spartan-net.net [69.176.143.70])
	(authenticated bits=0)
	by egr.msu.edu (8.13.6/8.13.4) with ESMTP id k550XDTP005748
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 4 Jun 2006 20:33:13 -0400 (EDT)
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060528)
X-Accept-Language: en-us, en
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90606010047r676840d2nd91ad2361abbe1c8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21300>

Martin Langhoff wrote:
> On 6/1/06, Alec Warner <antarus@gentoo.org> wrote:
> 
>> After reading the whole thread on this, I've using a git checkout of
>> git, cvsps-2.1 and cvs-1.11.12, running overnight in verbose mode with
>> screen.  Hopefully will have a repo in the morning ;)
> 
> 
> Good stuff. I am rerunning it to prove (and bench) a complete an
> uninterrupted import. So far it's done 4hs 30m, footprint grown to
> 207MB, 49750 commits. So I think it will be done in approx 30hs on
> this single-cpu opteron.
> 
> Most commits are small, but there is a handful that are downright
> massive -- and we hold all the file list in memory, which I think
> explains (most of) the memory growth. I've looked into avoiding
> holding the whole filelist in memory, but it involves rewriting the
> cvsps output parsing loop, which is better left for a rainy day, with
> a test case that doesn't take 30hs to resolve.

Ok the box this was running on had issues, so I switched to using 
pearl.amd64.dev.gentoo.org, a dual core amd64 X2 4600+ with 4 gigs of 
ram and plenty of disk.  The "problem" now is just converstion time...30 
hours and I'm into 2004-09-17...but it's been in 2004 all day, seems 
like most of the commits are in the last three years.  Are there 
architectural issues with doing this in parallel?

Since the repository commits are all in cvs, it should be possible to do 
the work in parallel, since you know what all the commits touch.  The 
concern would be ordering of nodes in the tree; you'd end up building a 
bunch of subtrees and patching them together?

-Alec Warner
