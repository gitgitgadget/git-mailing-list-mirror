From: Petr Baudis <pasky@suse.cz>
Subject: Re: [CFH] Remotes conversion script
Date: Mon, 25 Sep 2006 00:40:17 +0200
Message-ID: <20060924224017.GC20017@pasky.or.cz>
References: <20060924212142.GB20017@pasky.or.cz> <8aa486160609241457u40fffdd8h298e44351749bb29@mail.gmail.com> <20060924221644.GE13132@pasky.or.cz> <8aa486160609241534yc78b194g64038fe22048c443@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 25 00:40:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRce8-0002BY-4b
	for gcvg-git@gmane.org; Mon, 25 Sep 2006 00:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbWIXWkU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 18:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWIXWkU
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 18:40:20 -0400
Received: from w241.dkm.cz ([62.24.88.241]:42214 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751463AbWIXWkS (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Sep 2006 18:40:18 -0400
Received: (qmail 1314 invoked by uid 2001); 25 Sep 2006 00:40:17 +0200
To: Santi <sbejar@gmail.com>
Content-Disposition: inline
In-Reply-To: <8aa486160609241534yc78b194g64038fe22048c443@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27707>

Dear diary, on Mon, Sep 25, 2006 at 12:34:24AM CEST, I got a letter
where Santi <sbejar@gmail.com> said that...
> It could be I'm wrong (for sure, I miss something), but I see the
> branches/ files like [remote] sections files with just one fetch:
> 
> .git/branches/git:
> git://...../git.gi
> 
> would be:
> 
> [remote "git"]
> url=git://...../git.git
> fetch=refs/heads/master:refs/heads/git

That's basically right, the point is that with moving to remotes
support, we will make each remote live in its own separate namespace,
so when creating new remote branch, it won't live as refs/heads/git
but as refs/remotes/git/master (referencing to it as 'git' will still
work as long as you won't have a local 'git' branch, in which case
you will have to use 'remotes/git'). Cogito will certainly still have
to support using the old setup, but it will not support creating it
anymore.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
