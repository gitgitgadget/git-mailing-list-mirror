From: David Lang <david.lang@digitalinsight.com>
Subject: Re: Re: Merge with git-pasky II.
Date: Sat, 16 Apr 2005 16:02:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.62.0504161559140.22652@qynat.qvtvafvgr.pbz>
References: <20050414121624.GZ25711@pasky.ji.cz>
 <7vll7lqlbg.fsf@assigned-by-dhcp.cox.net><Pine.LNX.4.58.0504141133260.7211@ppc970.osdl.org>
 <7v7jj5qgdz.fsf@assigned-by-dhcp.cox.net><Pine.LNX.4.58.0504141728590.7211@ppc970.osdl.org><1113559330.12012.292.camel@baythorne.infradead.org><Pine.LNX.4.58.0504150753440.7211@ppc970.osdl.org>
 <20050416014442.GW4488@himi.org><Pine.LNX.4.62.0504160518310.21837@qynat.qvtvafvgr.pbz>
 <20050416155536.GX4488@himi.org><20050416160333.GF19099@pasky.ji.cz>
 <Pine.LNX.4.58.0504160913180.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Petr Baudis <pasky@ucw.cz>, Simon Fowler <simon@himi.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 00:58:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMwFY-0001p5-Bz
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 00:58:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbVDPXCf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 19:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbVDPXCf
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 19:02:35 -0400
Received: from warden3-p.diginsite.com ([208.147.64.186]:61844 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id S261185AbVDPXCc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 19:02:32 -0400
Received: from sacims01.digitalinsight.com by warden3.diginsite.com
          via smtpd (for vger.kernel.org [12.107.209.244]) with SMTP; Sat, 16 Apr 2005 16:02:32 -0700
Received: by sacexc01.diginsite.com with Internet Mail Service (5.5.2657.72)
	id <24ZWY89C>; Sat, 16 Apr 2005 16:02:12 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvexc00.digitalinsight.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id 29YX155G; Sat, 16 Apr 2005 16:02:08 -0700
To: Linus Torvalds <torvalds@osdl.org>
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <Pine.LNX.4.58.0504160913180.7211@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 16 Apr 2005, Linus Torvalds wrote:

> Almost all attacks on sha1 will depend on _replacing_ a file with a bogus
> new one. So guys, instead of using sha256 or going overboard, just make
> sure that when you synchronize, you NEVER import a file you already have.
>
> It's really that simple. Add "--ignore-existing" to your rsync scripts,
> and you're pretty much done. That guarantees that a new evil blob by the
> next mad scientist out to take over the world will never touch your
> repository, and if we make this part of the _standard_ scripts, then
> dammit, security is in good _practices_ rather than just relying blindly
> on the hash being secure.
>
> In other words, I think we could have used md5's as the hash, if we just
> make sure we have good practices. And it wouldn't have been "insecure".
>
> The fact is, you don't merge with people you don't trust. If you don't
> trust them, they have a much easier time corrupting your repository by
> just creating bugs in the code and checking that thing in. Who cares about
> hash collisions, when you can generate a kernel root vulnerability by just
> adding a single line of code and use the _correct_ hash for it.
>
> So the sha1 hash does not replace _trust_. That comes from something else
> altogether.

What I am bringing up is not intended to be a trust thing, but instead a 
safety thing, accidents, not evil intent. makeing the rsync scripts 
--ignore-existing will avoid corrupting local data when pulling remotely, 
but it won't solve the problem of running into a collision locally (and 
won't do much to help you figure out what's wrong when you run into a 
remote collision)

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
