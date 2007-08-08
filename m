From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH] unpack-trees.c: assume submodules are clean during
 check-out
Date: Wed, 08 Aug 2007 13:39:52 +0200
Message-ID: <20070808113952.GN999MdfPADPa@greensroom.kotnet.org>
References: <7vy7he6ufj.fsf@assigned-by-dhcp.cox.net>
 <20070801140532.GC31114MdfPADPa@greensroom.kotnet.org>
 <7v643vj316.fsf@assigned-by-dhcp.cox.net> <46B4A350.9060806@tromer.org>
 <20070805144632.GB999MdfPADPa@greensroom.kotnet.org>
 <46B76B8C.9050905@tromer.org>
 <20070806190344.GF999MdfPADPa@greensroom.kotnet.org>
 <46B7E5FE.7050006@tromer.org>
 <20070807085149.GH999MdfPADPa@greensroom.kotnet.org>
 <46B91F4E.8050008@tromer.org>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eran Tromer <git2eran@tromer.org>
X-From: git-owner@vger.kernel.org Wed Aug 08 13:40:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIjtY-0004zA-0D
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 13:40:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbXHHLkD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 07:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbXHHLkD
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 07:40:03 -0400
Received: from psmtp09.wxs.nl ([195.121.247.23]:56859 "EHLO psmtp09.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751287AbXHHLkA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 07:40:00 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp09.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JMG002XWDQLSZ@psmtp09.wxs.nl> for git@vger.kernel.org; Wed,
 08 Aug 2007 13:39:58 +0200 (MEST)
Received: (qmail 24474 invoked by uid 500); Wed, 08 Aug 2007 11:39:52 +0000
In-reply-to: <46B91F4E.8050008@tromer.org>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55318>

On Tue, Aug 07, 2007 at 09:41:34PM -0400, Eran Tromer wrote:
> On 2007-08-07 04:51, Sven Verdoolaege wrote:
> > Surely this is a lot worse than occasionally committing something you
> > didn't plan to commit, and only if you are performing a known "dangerous"
> > operation.
> > 
> Are you saying that
> $ git reset --hard HEAD && vi foo && git commit -a
> is a "known dangerous" operation that can record corrupted content even
> though you didn't touch it?

I'm only saying that "git commit -a" will commit anything that has been
modified, so you have to be careful when using it and it just so happens
that git reset may leave submodules modified.  This should probably
be documented.
And I agree with you that this is not ideal (personally, I'd want
all checked-out submodules to get updated automatically), but it's
certainly better than your earlier proposal.

> So, when I'm sure all the edits I did in the work tree are fine, how
> *do* I safely make a commit without manually inspecting the changed
> files list, or manually listing the changed files for "git add", or
> manually running "git submodule update", or manually checking whether
> there happens to be some submodules in this project, some other such
> cumbersome measure?

If you've ever done a "git submodule update" in the project, you should
know that there are submodules and if you haven't then there are no
checked-out submodules that can get out of sync.
If you're talking about tools, then they should indeed be extra careful.

[another proposal]
> 
> Does this sound reasonable?

I'll leave it to others to comment on that one.

skimo
