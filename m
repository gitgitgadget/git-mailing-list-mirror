From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Git-commits mailing list feed.
Date: Sat, 23 Apr 2005 13:23:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504231318510.2344@ppc970.osdl.org>
References: <200504210422.j3L4Mo8L021495@hera.kernel.org> <42674724.90005@ppp0.net>
 <20050422002922.GB6829@kroah.com> <426A4669.7080500@ppp0.net>
 <1114266083.3419.40.camel@localhost.localdomain> <426A5BFC.1020507@ppp0.net>
 <1114266907.3419.43.camel@localhost.localdomain> <Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org>
 <20050423175422.GA7100@cip.informatik.uni-erlangen.de>
 <Pine.LNX.4.58.0504231125330.2344@ppc970.osdl.org> <2911.10.10.10.24.1114279589.squirrel@linux1>
 <Pine.LNX.4.58.0504231234550.2344@ppc970.osdl.org> <7vis2d2rmv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sean <seanlkml@sympatico.ca>,
	Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	David Woodhouse <dwmw2@infradead.org>,
	Jan Dittmer <jdittmer@ppp0.net>, Greg KH <greg@kroah.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 23 22:17:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPR3f-0004Yo-2Q
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 22:16:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbVDWUVi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 16:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbVDWUVh
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 16:21:37 -0400
Received: from fire.osdl.org ([65.172.181.4]:37290 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261772AbVDWUVd (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Apr 2005 16:21:33 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3NKLJs4001698
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 23 Apr 2005 13:21:20 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3NKLI6r015927;
	Sat, 23 Apr 2005 13:21:18 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vis2d2rmv.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 23 Apr 2005, Junio C Hamano wrote:
> 
> If that is the case, can't you do it without introducing this
> new tag object, like this?

No, because I also want to sign the _name_ I gave it.

Otherwise somebody can take my "signed commit", and claim that I called it 
something else.

Just signing the commit is indeed sufficient to just say "I trust this
commit". But I essentially what to also say what I trust it _for_ as well.

And sure, I could make a totally bogus "commit" object that just points to 
the original commit, uses the same "tree" from that original commit, and 
write what I want to trust into that commit. I then sign that, and create 
yet _another_ commit that has the signature (and the pointer to the just 
signed commit) in its commit message, and then I point to _that_ commit.

So yes, we can certainly do this with playing games with commits. That 
sounds singularly ugly, though, since just doing a "tag" object is a lot 
more straightforward, and really tells the world what's going on (and 
makes it easy for automated tools to just browse the object database and 
see "that's a tag").

			Linus
