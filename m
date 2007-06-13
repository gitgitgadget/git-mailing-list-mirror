From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: pull into dirty working tree
Date: Thu, 14 Jun 2007 00:27:17 +0200
Message-ID: <20070613222717.GA5513@steel.home>
References: <18031.64456.948230.375333@lisa.zopyra.com> <86zm33291h.fsf@blue.stonehenge.com> <20070613192828.GB3412@steel.home> <86645r1wh8.fsf@blue.stonehenge.com> <20070613204711.GC3412@steel.home> <86odjjziek.fsf@blue.stonehenge.com> <20070613213931.GD3412@steel.home> <86k5u7zf7x.fsf@blue.stonehenge.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Thu Jun 14 00:27:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HybJH-0005R2-5h
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 00:27:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754781AbXFMW1Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 18:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753847AbXFMW1Y
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 18:27:24 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:36890 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753820AbXFMW1X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 18:27:23 -0400
Received: from tigra.home (Fcb25.f.strato-dslnet.de [195.4.203.37])
	by post.webmailer.de (fruni mo34) (RZmta 7.2)
	with ESMTP id D01babj5DKKYTZ ; Thu, 14 Jun 2007 00:27:18 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 5C52C277BD;
	Thu, 14 Jun 2007 00:27:18 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id CDF5BD261; Thu, 14 Jun 2007 00:27:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <86k5u7zf7x.fsf@blue.stonehenge.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaHqBkvAA==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50138>

Randal L. Schwartz, Thu, Jun 14, 2007 00:01:22 +0200:
> In which case, it's even simpler:
> 
> git-add . # add *everything* that's not .gitignored
> git-commit -a -m WIP # save for replay (H above)
> git-fetch origin # get upstream (P Q R)
> git-rebase origin # creates E' F' G' H'
> git-reset --soft HEAD^ # back up to G'
> git-reset # mark everything un-added as of G'
> 
> Yeah, this is far easier.
> 

It is also wrong. You either add a lot of junk (because it is not
ignored yet - who'll setup .gitignores just to check something?!) and
spend a millenium hashing it (ever tried to add 4.7 DVD?) or it does
not add really important files which just happen to be in .gitignore.

IOW, this recipe is dangerous. It'll only _mostly_ work.
