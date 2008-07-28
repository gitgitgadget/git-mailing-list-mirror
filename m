From: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: Bizarre missing changes (git bug?)
Date: Mon, 28 Jul 2008 02:00:41 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0807280141140.6791@localhost.localdomain>
References: <8502DF7C-5303-49E8-8C67-F837343E2F0C@gmail.com>
 <alpine.LFD.1.10.0807211331390.31863@woody.linux-foundation.org>
 <200807260512.40088.zippel@linux-m68k.org>
 <alpine.LFD.1.10.0807261249430.4188@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807270049290.6791@localhost.localdomain>
 <alpine.LFD.1.10.0807271144520.3486@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807272101470.6791@localhost.localdomain>
 <alpine.LFD.1.10.0807271613440.3486@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jul 28 02:02:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNGBb-0007Rh-56
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 02:01:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756697AbYG1AA5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 20:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756696AbYG1AA5
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 20:00:57 -0400
Received: from smtp-vbr2.xs4all.nl ([194.109.24.22]:4700 "EHLO
	smtp-vbr2.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753196AbYG1AA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 20:00:56 -0400
Received: from squid.home (linux-m68k.xs4all.nl [82.95.193.92])
	(authenticated bits=0)
	by smtp-vbr2.xs4all.nl (8.13.8/8.13.8) with ESMTP id m6S00hVx016291
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 28 Jul 2008 02:00:47 +0200 (CEST)
	(envelope-from zippel@linux-m68k.org)
X-X-Sender: roman@localhost.localdomain
In-Reply-To: <alpine.LFD.1.10.0807271613440.3486@nehalem.linux-foundation.org>
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90377>

Hi,

On Sun, 27 Jul 2008, Linus Torvalds wrote:

> > Why are you dismissing what I wrote without even giving it a second 
> > thought? I didn't bother with the initial example, because it's so 
> > simple, that it's no real challenge.
> 
> Did you try it? It really shouldn't be any simpler than anything else. And 

Of course I did:

$ git log --parents --name-only --full-history lib/vsprintf.c | grep -e ^commit | wc -l
5929

This is same amount of commits as for gitk.

$ /usr/bin/time git log --parents --name-only --full-history lib/vsprintf.c | grep -e ^commit -e ^lib | /usr/bin/time ruby ../filter.rb
3.08user 0.14system 0:03.54elapsed 91%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+48230minor)pagefaults 0swaps
20
["72fd4a35a824331d7a0f4168d7576502d95d34b3", ["0a6047eef1c465c38aacfbdab193161b3f0cd144"]]
["06b2a76d25d3cfbd14680021c1d356c91be6904e", ["96e3e18eed3b48f6d4377dee0326a106e8a04569"]]
["1da177e4c3f41524e886b7f1b8a0c1fc7321cac2", []]
["e905914f96e11862b130dd229f73045dad9a34e8", ["f796937a062c7aeb44cd0e75e1586c8543634a7d"]]
["4e57b6817880946a3a78d5d8cad1ace363f7e449", ["8032230694ec56c168a1404c67a54d281536cbed"]]
["4f9d5f4a353440f2265781bfa641587964901861", ["9b706aee7d92d6ac3002547aea12e3eaa0a750ae"]]
["0a6047eef1c465c38aacfbdab193161b3f0cd144", ["e905914f96e11862b130dd229f73045dad9a34e8"]]
["c6b40d16d1cfa1a01158049bb887a9bbe48ef7ba", ["11443ec7d9286dd25663516436a14edfb5f43857"]]
["ea6f3281a145d16ed53e88b0627f78d5cde6068f", ["72fd4a35a824331d7a0f4168d7576502d95d34b3"]]
["11443ec7d9286dd25663516436a14edfb5f43857", ["ea6f3281a145d16ed53e88b0627f78d5cde6068f"]]
["b39a734097d5095d63eb9c709a6aaf965633bb01", ["c6b40d16d1cfa1a01158049bb887a9bbe48ef7ba"]]
["78a8bf69b32980879975f7e31d30386c50bfe851", ["0f9bfa569d46f2346a53a940b2b9e49a38635732"]]
["4d8a743cdd2690c0bc8d1b8cbd02cffb1ead849f", ["78a8bf69b32980879975f7e31d30386c50bfe851"]]
["0fe1ef24f7bd0020f29ffe287dfdb9ead33ca0b2", ["4d8a743cdd2690c0bc8d1b8cbd02cffb1ead849f"]]
["9b706aee7d92d6ac3002547aea12e3eaa0a750ae", ["06b2a76d25d3cfbd14680021c1d356c91be6904e"]]
["0f9bfa569d46f2346a53a940b2b9e49a38635732", ["4f9d5f4a353440f2265781bfa641587964901861"]]
["4277eedd7908a0ca8b66fad46ee76b0ad96e6ef2", ["b39a734097d5095d63eb9c709a6aaf965633bb01"]]
["8032230694ec56c168a1404c67a54d281536cbed", ["1da177e4c3f41524e886b7f1b8a0c1fc7321cac2"]]
["f796937a062c7aeb44cd0e75e1586c8543634a7d", ["4e57b6817880946a3a78d5d8cad1ace363f7e449"]]
["96e3e18eed3b48f6d4377dee0326a106e8a04569", ["4277eedd7908a0ca8b66fad46ee76b0ad96e6ef2"]]
0.12user 0.02system 0:03.64elapsed 3%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+7252minor)pagefaults 0swaps

These are the same 20 commits (with parents) from a simple git-log.

> I dismissed what you wrote because the example you _did_ state was about 
> something else entirely (ie apparently some giggle bug that simplifies 
> things incorrectly).

I'm trying to get back things to the topic and it's not just giggle, every 
tool presents a different version of the history.

> > What did I do wrong that you rebuff me based on this secondary problem 
> > (which I'm quite aware of, because it was me who mentioned in first place) 
> > and giving the primary problem (which is the missing history) no 
> > attention?
> 
> It's not missing history. It's all there in --full-history. The default is 
> to give a reasonable simplification, and I told you what the 
> simplification was, and it's perfectly conceptually fine - AND IT IS MUCH 
> MORE EFFICIENT than the alternatives.
> 
> So I'm not seeing your point what-so-ever. 

That's why I gave you an alternative example, where history is missing.

>  - with full-history, you have it all, but it's useless in practice

Could you please specify which full-history you mean, gitk --full-history 
or git-log --full-history?

>  - without full-history, it's useful in practice

>From a VCS I would still expect nevertheless to present a correct 
history not some approximation.

bye, Roman
