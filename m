From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] transplant: move a series of commits to a different parent
Date: Sun, 24 Jun 2007 10:20:27 +0200
Message-ID: <20070624082027.GA2467@steel.home>
References: <1BD13366-B4BD-4630-9046-49567A345CBC@zib.de> <11826268772950-git-send-email-prohaska@zib.de> <81b0412b0706231404hc8b4bc4xd5bc51c733d8ea69@mail.gmail.com> <9C4338DC-0C4A-4981-9EC9-2417513F629D@zib.de>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Jun 24 10:20:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2NKs-0006YP-3b
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 10:20:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752776AbXFXIUd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 04:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752786AbXFXIUc
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 04:20:32 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:54084 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752355AbXFXIUa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 04:20:30 -0400
Received: from tigra.home (Fad95.f.strato-dslnet.de [195.4.173.149])
	by post.webmailer.de (klopstock mo43) (RZmta 7.5)
	with ESMTP id Q06192j5O4FEfZ ; Sun, 24 Jun 2007 10:20:28 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 62E75277BD;
	Sun, 24 Jun 2007 10:20:28 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 17EFEC164; Sun, 24 Jun 2007 10:20:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9C4338DC-0C4A-4981-9EC9-2417513F629D@zib.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzyClFly0M=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50777>

Steffen Prohaska, Sun, Jun 24, 2007 09:08:16 +0200:
> 
> On Jun 23, 2007, at 11:04 PM, Alex Riesen wrote:
> 
> >>git-transplant.sh <onto> <from> <to>
> >>
> >>transplant starts with the contents of <onto> and puts on top of
> >>it the contents of files if they are touched by the series of
> >>commits <from>..<to>.  If a commit touches a file the content of
> >>this file is taken as it is in the commit. No merging is
> >>performed. Original authors, commiters, and commit messages are
> >>preserved.
> >>
> >[...]
> ># detached head
> >git checkout $(git rev-parse onto) && git format-patch --stdout
> >--full-index from..to|git am -3
> 
> No. This one tries to apply the _changes_ between from..to. What I
> need is the resulting _content_ of files modified between from..to.
> 

Ach, yes. I should have read your message a bit more closely. There is
a term for that "contents of files", BTW: "repository state".

> I believe it's more like git-filter-branch, but I wasn't yet abel to
> tell git-filter-branch how to do the job.

I suspect git-filter-branch can be both.
