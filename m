From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: seperate commits for objects already updated in index?
Date: Tue, 14 Mar 2006 09:20:22 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603140915290.3618@g5.osdl.org>
References: <Pine.LNX.4.64.0603141634010.5276@sheen.jakma.org>
 <Pine.LNX.4.64.0603140856120.3618@g5.osdl.org> <Pine.LNX.4.64.0603141703080.5276@sheen.jakma.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 14 18:28:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJDD3-00049e-Av
	for gcvg-git@gmane.org; Tue, 14 Mar 2006 18:21:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752321AbWCNRU4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Mar 2006 12:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752307AbWCNRUc
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Mar 2006 12:20:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:28608 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752306AbWCNRUZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Mar 2006 12:20:25 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2EHKMDZ021945
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 14 Mar 2006 09:20:23 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2EHKMbF001384;
	Tue, 14 Mar 2006 09:20:22 -0800
To: Paul Jakma <paul@clubi.ie>
In-Reply-To: <Pine.LNX.4.64.0603141703080.5276@sheen.jakma.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17592>



On Tue, 14 Mar 2006, Paul Jakma wrote:

> On Tue, 14 Mar 2006, Linus Torvalds wrote:
> 
> > The simplest thing to do is to do
> > 
> > 	git reset
> > 
> > to reset your index back to your HEAD (but obviously DON'T use the "-f"
> > flag, which will also force the working tree!).
> 
> Ah, of course! (I knew I was being dumb ;) ).

Well, I actually think git is being somewhat of an ass, for no really good 
reason. It's true that you are doing something pretty strange by _both_ 
using "git-update-index" and "git commit -o" but the fact is, at least 
when adding files, that would be expected (ie you have to mark a file 
in the index to add it).

I also think that test is historical, from before Junio cleaned up how 
"git commit" worked - it _used_ to be that "git commit" would work in the 
current index, but these days it generates a new index to commit when you 
do "-o", so there's really no _technical_ reason to refuse the partial 
commit any more as far as I can see.

So I don't know. I don't think you were being dumb, I think git could have 
been friendlier to you.

		Linus
