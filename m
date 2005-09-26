From: Petr Baudis <pasky@suse.cz>
Subject: Re: How to make Cogito use git-fetch-pack?
Date: Mon, 26 Sep 2005 20:46:15 +0200
Message-ID: <20050926184615.GB26340@pasky.or.cz>
References: <43347F98.6020101@zytor.com> <20050924011912.GK10255@pasky.or.cz> <4334B428.7020608@zytor.com> <43383999.8090508@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 26 20:47:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJxzZ-0007cH-A0
	for gcvg-git@gmane.org; Mon, 26 Sep 2005 20:46:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932471AbVIZSqS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 14:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbVIZSqS
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 14:46:18 -0400
Received: from w241.dkm.cz ([62.24.88.241]:20689 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932471AbVIZSqR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Sep 2005 14:46:17 -0400
Received: (qmail 30774 invoked by uid 2001); 26 Sep 2005 20:46:15 +0200
To: "H. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <43383999.8090508@zytor.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9321>

Dear diary, on Mon, Sep 26, 2005 at 08:10:33PM CEST, I got a letter
where "H. Peter Anvin" <hpa@zytor.com> told me that...
> H. Peter Anvin wrote:
> >Petr Baudis wrote:
> >
> >>Dear diary, on Sat, Sep 24, 2005 at 12:20:08AM CEST, I got a letter
> >>where "H. Peter Anvin" <hpa@zytor.com> told me that...
> >>
> >>>Is there any way to make Cogito use git-fetch-pack instead of 
> >>>git-ssh-fetch?  git+ssh:// seems to invoke the latter.
> >>
> >>
> >>I just added git+packed+ssh:// to be used for this purpose.
> >>
> >
> >Since git tends to use "pack" (e.g. git-fetch-pack) I'd suggest use 
> >git+pack+ssh:// instead.  It's shorter, too.
> >
> 
> I thought some more about this, and realized that it really doesn't make 
> sense for there to be another name for this.  Simply put, git+ssh:// 
> requires ssh access and git to be present on the other side, and within 
> those parameters it should use whatever access method is most effective. 
> Thus, having a separate URL type only makes sense if something is 
> fundamentally and user-visibly different between the two.

Tags fetching. I agree that the difference isn't that big other than
this (contrary to the other fetchers, ssh-fetch won't reproduce the pack
setup; this may sound as a bad thing, but it prevents transfer of
redundant data which is pretty much inevitable (or for free) for the
other fetchers). And since we will probably move to the pack fetchers
for tags as well, I agree that there indeed is little point in this.
I will switch all the git+ssh fetching to it after I implement the new
tags fetching.

By the way, how much more CPU-intensive are the pack-based methods in
practice, especially on the server (packing) side? Could it be
noticeable?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
