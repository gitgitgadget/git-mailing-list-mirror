From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Handling large files with GIT
Date: Sun, 12 Feb 2006 19:42:41 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602121939070.3691@g5.osdl.org>
References: <46a038f90602080114r2205d72cmc2b5c93f6fffe03d@mail.gmail.com> 
 <87slqty2c8.fsf@mid.deneb.enyo.de> <46a038f90602081435x49e53a1cgdc56040a19768adb@mail.gmail.com>
 <Pine.OSX.4.64.0602131416530.25089@piva.hawaga.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Florian Weimer <fw@deneb.enyo.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 13 04:43:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8UcM-0005T8-MR
	for gcvg-git@gmane.org; Mon, 13 Feb 2006 04:43:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574AbWBMDnM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Feb 2006 22:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751575AbWBMDnM
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Feb 2006 22:43:12 -0500
Received: from smtp.osdl.org ([65.172.181.4]:29416 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751573AbWBMDnL (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Feb 2006 22:43:11 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1D3glDZ006417
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 12 Feb 2006 19:42:47 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1D3gfMM000407;
	Sun, 12 Feb 2006 19:42:44 -0800
To: Ben Clifford <benc@hawaga.org.uk>
In-Reply-To: <Pine.OSX.4.64.0602131416530.25089@piva.hawaga.org.uk>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16041>



On Mon, 13 Feb 2006, Ben Clifford wrote:
> 
> I've been keeping maildir in git for a few months, with mail being delivered
> into a git repo on one (permanently connected) host and me merging that branch
> into a repo on my laptop for reading (the intention being that I should be
> able to sync it back to the permanently connected host as I sometimes read
> mail there.
> 
> Alas, the merge part of this absolutely sucks -- as time goes by, its getting
> slower and slower (its taking an hour or so to do the merge, which has got to
> the point of being barely usable -- if it wasn't for the neat hack-value, I'd
> have given up on this by now).

If it takes an hour per merge, it _is_ unusable. I consider 15 _seconds_ 
to be pretty unusable.

Can you do a

	git-ls-tree -r -t HEAD
	git-ls-tree -r -t HEAD^1
	git-ls-tree -r -t HEAD^2

after a merge, and put the three resulting files up somewhere public (I 
assume the filenames aren't going to be anything private, I don't know how 
maildir organizes stuff) so that people can get an idea of what ends up 
being involved there..

		Linus
