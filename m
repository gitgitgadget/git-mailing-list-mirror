From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: write-tree is pasky-0.4
Date: Fri, 15 Apr 2005 11:44:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504151138490.7211@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org>
 <7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net> <20050414121624.GZ25711@pasky.ji.cz>
 <7vll7lqlbg.fsf@assigned-by-dhcp.cox.net> <20050414193507.GA22699@pasky.ji.cz>
 <7vmzs1osv1.fsf@assigned-by-dhcp.cox.net> <20050414233159.GX22699@pasky.ji.cz>
 <7v7jj4q2j2.fsf@assigned-by-dhcp.cox.net> <20050414223039.GB28082@64m.dyndns.org>
 <7vfyxsmqmk.fsf@assigned-by-dhcp.cox.net> <20050415062807.GA29841@64m.dyndns.org>
 <7vfyxsi9bq.fsf@assigned-by-dhcp.cox.net> <7vaco0i3t9.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 20:42:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMVlD-0007Pk-Si
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 20:41:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261922AbVDOSpH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 14:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbVDOSos
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 14:44:48 -0400
Received: from fire.osdl.org ([65.172.181.4]:56799 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261922AbVDOSmO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2005 14:42:14 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3FIg5s4010449
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 15 Apr 2005 11:42:05 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3FIg4Nj007890;
	Fri, 15 Apr 2005 11:42:04 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vaco0i3t9.fsf_-_@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 15 Apr 2005, Junio C Hamano wrote:
> 
> Linus, sorry for bothering you with a false alarm.  The problem
> turns out to be introduced in pasky-0.4 and does not exist in
> your HEAD.

Hey, all the code I write is always perfect, of course ;)

That said, I'm having some trouble merging with your perfect code,
especially since I decided that Russell's "always big-endian" thing was
definitely the right way to go (but ended up doing it slightly
differently).

I did my own version of "upcate-cache --cacheinfo", although mine is a bit 
more anal, and if you add a new filename it wants that "--add" flag in 
there first (why? I really like to make sure that people who add or remove 
files from the cache say so explicitly, so that there are no surprises). 
Otherwise it should be compatible with yours.

And I merged your "Add -z option to show-files", but you had based your 
other patches on Petr's tree which due to my other changes is not going to 
merge totally cleanly with mine, so I'm wondering if you might want to try 
to re-merge your mergepoint stuff against my current tree? That way I can 
continue to maintain a set of "core files", and Pasky can maintain the 
"usable interfaces" part..

		Linus
