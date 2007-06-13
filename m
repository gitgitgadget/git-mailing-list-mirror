From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: pull into dirty working tree
Date: Wed, 13 Jun 2007 22:47:11 +0200
Message-ID: <20070613204711.GC3412@steel.home>
References: <18031.64456.948230.375333@lisa.zopyra.com> <86zm33291h.fsf@blue.stonehenge.com> <20070613192828.GB3412@steel.home> <86645r1wh8.fsf@blue.stonehenge.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 22:47:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyZkO-0000KA-CW
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 22:47:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753454AbXFMUrS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 16:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753227AbXFMUrS
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 16:47:18 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:53399 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753454AbXFMUrR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 16:47:17 -0400
Received: from tigra.home (Fcb25.f.strato-dslnet.de [195.4.203.37])
	by post.webmailer.de (klopstock mo64) (RZmta 7.2)
	with ESMTP id G05368j5DIJI1e ; Wed, 13 Jun 2007 22:47:12 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 1F4C2277BD;
	Wed, 13 Jun 2007 22:47:12 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id B01C2D261; Wed, 13 Jun 2007 22:47:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <86645r1wh8.fsf@blue.stonehenge.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaHqBkvAA==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50129>

Randal L. Schwartz, Wed, Jun 13, 2007 21:32:35 +0200:
> Alex> Wont work for new files (not yet known to git) which conflict with the
> Alex> same names from origin. Your method will not put them anywhere and
> Alex> their presence will break git-rebase. You _must_ do a merge.
> 
> So I missed git-add for those.  Then it'll work.  I guess I implied that the
> git-commit initial step should capture all of the "interesting" state.

No, it wont. What files are you going to add? All, but *.o? All, but
*.log? What if user hasn't setup .gitignore yet? What if he meant to
add an ignored file anyway?

> git-rebase *will* do the merge.  It must. :)

It won't merge anything which isn't known to git. Now, I come to think
about it, no existing merge method will help you here (and very likely
it shouldn't).

It is actually much simplier doing things right: all this stashing
people keep talking about.
