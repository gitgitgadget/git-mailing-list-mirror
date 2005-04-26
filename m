From: Petr Baudis <pasky@ucw.cz>
Subject: Re: : Networking
Date: Tue, 26 Apr 2005 20:33:50 +0200
Message-ID: <20050426183350.GB13224@pasky.ji.cz>
References: <20050425214326.512b006e.davem@davemloft.net> <20050426005725.6bfe6135.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "David S. Miller" <davem@davemloft.net>, torvalds@osdl.org,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 20:29:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQUnp-0000zw-Uv
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 20:28:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbVDZSeG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 14:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbVDZSeG
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 14:34:06 -0400
Received: from w241.dkm.cz ([62.24.88.241]:30861 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261683AbVDZSdx (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 14:33:53 -0400
Received: (qmail 15448 invoked by uid 2001); 26 Apr 2005 18:33:50 -0000
To: Andrew Morton <akpm@osdl.org>
Content-Disposition: inline
In-Reply-To: <20050426005725.6bfe6135.akpm@osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, Apr 26, 2005 at 09:57:25AM CEST, I got a letter
where Andrew Morton <akpm@osdl.org> told me that...
> c) To generate -mm's linus.patch (patch against 2.6.12-rc3):
> 
> 	git pull origin
> 	git diff -r v2.6.12-rc3 > ../25/patches/linus.patch

(Mainly for people not familiar with git-pasky - this merged origin to
the working tree since it was tracked branch - that's what origin is by
default after git init.)

> d) To generate davem's tree (patch against linus's current tree (ie: patch
>    against 2.6.12-rc3+linus.patch)):
> 
> 	git pull git-net
> 	MERGE_BASE=$(merge-base $(cat .git/heads/origin ) $(cat .git/heads/git-net))
> 	git diff -r $MERGE_BASE:$(cat .git/heads/git-net) > ../25/patches/git-net.patch

This is the bad way; I think this suffers of basically the same problems
as my ancient merging by "forward-patching". You should probably do a
regular merge:

	git pull git-net
	git merge git-net
	git diff -p

The last command will show diff between current tree and the first
parent; that amounts the merged patch in this case.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
