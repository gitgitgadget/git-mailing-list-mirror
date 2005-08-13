From: Petr Baudis <pasky@suse.cz>
Subject: Re: Fwd: Re: git checkout -f branch doesn't remove extra files
Date: Sat, 13 Aug 2005 13:00:51 +0200
Message-ID: <20050813110050.GA5608@pasky.ji.cz>
References: <20050813041737.GB25236@redhat.com> <Pine.LNX.4.58.0508122151120.19049@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dave Jones <davej@redhat.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 13 13:01:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3tl5-0003t1-Px
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 13:01:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbVHMLA4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 07:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbVHMLA4
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 07:00:56 -0400
Received: from w241.dkm.cz ([62.24.88.241]:25608 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S1751325AbVHMLAz (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Aug 2005 07:00:55 -0400
Received: (qmail 6312 invoked by uid 2001); 13 Aug 2005 11:00:51 -0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0508122151120.19049@g5.osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, Aug 13, 2005 at 07:05:11AM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> If you really want a temporary tree, what you do is something like
> 
> 	git-checkout-cache --prefix=tmp-dir/ -f -a
> 
> and when you're done, you just do
> 
> 	rm -rf tmp-dir
> 
> and you're done.
> 
> NOTE NOTE NOTE! In the above, the order of the parameters is really really 
> important! "-a" takes effect when it is seen, so it needs to be last. 
> Also, the "--prefix" thing really _really_ needs the slash at the end, 
> because it's literally used to prefix the pathname.
> 
> HOWEVER, if all you want to do is just a tar-file, then there's a better 
> solution. It's called
> 
> 	snap=git-snapshot-$(date +"%Y%m%d")
> 	git-tar-tree HEAD $snap | gzip -9 > $snap.tar.gz
> 
> which is even easier, and a hell of a lot more efficient.

To put my two cents too, Cogito has cg-export for this:

	cg-export tmp-dir

to export to a temporary directory and

	cg-export git-snapshot.tar.gz

to export to a gzipped tarball (it can also do .tar, .tgz and .tar.bz2).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
