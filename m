From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Importing Mozilla CVS into git
Date: Fri, 2 Jun 2006 08:53:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606020849390.5498@g5.osdl.org>
References: <9e4733910606011521n106f8f24s6c7053ce51e3791e@mail.gmail.com>
 <Pine.LNX.4.64.0606011643290.5498@g5.osdl.org>
 <9e4733910606011759t7c828a50gc4a6b45d92d2b344@mail.gmail.com>
 <Pine.LNX.4.64.0606011809401.5498@g5.osdl.org> <7vac8wdpr5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 02 17:54:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmByH-0006Kd-Hy
	for gcvg-git@gmane.org; Fri, 02 Jun 2006 17:53:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbWFBPxs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Jun 2006 11:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbWFBPxs
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jun 2006 11:53:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20908 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932479AbWFBPxs (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Jun 2006 11:53:48 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k52Frf2g028121
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 2 Jun 2006 08:53:41 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k52FreKK012563;
	Fri, 2 Jun 2006 08:53:40 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vac8wdpr5.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21164>



On Thu, 1 Jun 2006, Junio C Hamano wrote:
> > You're much better off using "gitk --all" if you want to see the result, 
> > the "show-branch" this is really broken. It is using the old algorithm 
> > that we used to use for "git-rev-tree", and got rid of about a year ago 
> > there in favour of git-rev-list ;)
> 
> Are you sure about it?  My recollection is it uses the
> merge-base logic, naturally enhanced for multiple heads.

Well, it's all the same algorithm, where just the bit usage differs. 
git-rev-tree is slightly closer, if only because the original 
git-merge-base only did two heads, if I recall correctly (while 
git-rev-tree did 16 - the ability of git-show-branch to do 29 came from 
just using all the free bits rather than the high bits like rev-tree did)

> And enhancing it to support more than one int wide bitmap should
> not be too difficult, although looking at the output would be
> very taxing for human eye, so I do not know if it is worth it.

Yeah, I don't think there is any reason to really support it. If you have 
more than a few heads, you really do need the graphical version to see 
what is going on, and git-show-branch doesn't buy you anything.

		Linus
