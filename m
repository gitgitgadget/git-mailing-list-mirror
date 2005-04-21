From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Possible problem with git-pasky-0.6.2 (patch: **** Only garbage was found in the patch input.)I
Date: Thu, 21 Apr 2005 09:11:05 +0200
Message-ID: <20050421071104.GC31910@pasky.ji.cz>
References: <200504201706.09656.elenstev@mesatop.com> <20050420231212.GN19112@pasky.ji.cz> <200504201715.00058.elenstev@mesatop.com> <200504201820.27497.elenstev@mesatop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 09:07:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOVmC-0004U0-3q
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 09:07:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbVDUHLQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 03:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbVDUHLP
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 03:11:15 -0400
Received: from w241.dkm.cz ([62.24.88.241]:11240 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261351AbVDUHLG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 03:11:06 -0400
Received: (qmail 5916 invoked by uid 2001); 21 Apr 2005 07:11:05 -0000
To: Steven Cole <elenstev@mesatop.com>
Content-Disposition: inline
In-Reply-To: <200504201820.27497.elenstev@mesatop.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Apr 21, 2005 at 02:20:27AM CEST, I got a letter
where Steven Cole <elenstev@mesatop.com> told me that...
> Actually, I meant "patch -p1 <stuff_from_above".

So, how did it end up?

Actually, never mind. I forgot that I bring the local changes forward as
patches instead. So this is Harmless (tm). It means the patch containing
your local changes has just that kind of git diff output containing
filename: hash. I will probably just chain grep -v '^[^+-@ ]' in front
of patch. (Someone starting his filename with a space _deserves_ the
trouble. ;-)

> But before doing that, I did a fsck-cache as follows, with these results.
> This seems damaged.
> 
> [steven@spc git-pasky-0.6.2]$ fsck-cache --unreachable $(cat .git/HEAD)

You can't do just this. In Cogito repository, you may have multiple
branches, each with different HEAD of course. So you need to

	fsck-cache --unreachable $(cat .git/heads/*)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
