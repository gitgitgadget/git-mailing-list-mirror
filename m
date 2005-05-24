From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitweb wishlist
Date: Tue, 24 May 2005 13:44:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505241334530.2307@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505201604460.2206@ppc970.osdl.org>
 <428E745C.30304@zytor.com> <Pine.LNX.4.58.0505201702170.2206@ppc970.osdl.org>
 <4292A08A.5050108@cobite.com> <Pine.LNX.4.58.0505232048190.2307@ppc970.osdl.org>
 <Pine.LNX.4.58.0505240110580.2307@ppc970.osdl.org>
 <20050524161745.GA9537@cip.informatik.uni-erlangen.de>
 <Pine.LNX.4.58.0505240929051.2307@ppc970.osdl.org>
 <Pine.LNX.4.58.0505240943080.2307@ppc970.osdl.org>
 <Pine.LNX.4.58.0505241017510.2307@ppc970.osdl.org>
 <20050524184612.GA23637@cip.informatik.uni-erlangen.de>
 <Pine.LNX.4.58.0505241236020.2307@ppc970.osdl.org>
 <Pine.LNX.4.58.0505241259250.2307@ppc970.osdl.org> <42938C5B.4000906@cobite.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kay Sievers <kay.sievers@vrfy.org>, Petr Baudis <pasky@ucw.cz>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 24 22:42:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DagDE-0002Sn-4H
	for gcvg-git@gmane.org; Tue, 24 May 2005 22:41:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbVEXUmg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 16:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbVEXUmf
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 16:42:35 -0400
Received: from fire.osdl.org ([65.172.181.4]:42455 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261392AbVEXUm1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 May 2005 16:42:27 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4OKgJjA021676
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 24 May 2005 13:42:20 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4OKgHRi015979;
	Tue, 24 May 2005 13:42:18 -0700
To: David Mansfield <david@cobite.com>
In-Reply-To: <42938C5B.4000906@cobite.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 24 May 2005, David Mansfield wrote:
> 
> Sounds possible.  Unfortunately, the 'uniqueness' of a commit actually 
> doesn't exist.  It's all smoke-and-mirrors.  In order to disallow this 
> (which I think need to do) I'd need to use some commit member 
> information, and add some heuristic: if this file is already in the 
> commit, then this MUST be a different commit.  Unfortunately, it's 
> possible that the 'member' already in the commit is the wrong one and 
> this is the right one, which just sounds horribly ugly to me.
> 
> I'll think on it.

I think it's a fundamentally hard problem to fix, but it may be that the 
fix is to give hints about command line options and in particular the time 
fuzz thing to try.

So maybe just _detection_ logic in cvsps, along with a warning like

	"time fuzz is 600 seconds, and the time difference between the two
	 commits of this file was 431 seconds. You may want to try a lower
	 -z argument"

or something.

It might also be possible to try to sort all the names by date of commit
first, and see if they "bunch up" into groups of low fuzz with much bigger 
fuzz in between groups..

		Linus
