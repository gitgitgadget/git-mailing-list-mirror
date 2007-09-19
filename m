From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Problem with merge when renaming
Date: Wed, 19 Sep 2007 23:11:11 +0200
Message-ID: <20070919211110.GA12807@steel.home>
References: <95b3d0af0709181334y1e21507ey485860e4d45aa26f@mail.gmail.com> <7v7imnvca0.fsf@gitster.siamese.dyndns.org> <20070918224447.GC14488@steel.home> <7vejgvtv0a.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Euresti <evelio@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 23:11:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IY6pQ-0007o9-53
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 23:11:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbXISVLT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 17:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750717AbXISVLT
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 17:11:19 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:53799 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230AbXISVLS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 17:11:18 -0400
Received: from tigra.home (Fadce.f.strato-dslnet.de [195.4.173.206])
	by post.webmailer.de (mrclete mo62) (RZmta 12.10)
	with ESMTP id v0597dj8JHHuSB ; Wed, 19 Sep 2007 23:11:16 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 6DAC527752;
	Wed, 19 Sep 2007 23:11:16 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 566CCBDE4; Wed, 19 Sep 2007 23:11:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vejgvtv0a.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzyClJ1UZQ=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58737>

Junio C Hamano, Wed, Sep 19, 2007 01:27:01 +0200:
> > it happens with very recent git (as of today)
> >
> >>  (2) if you do "git merge -s resolve" instead of just "git
> >>      merge", do you see a difference?
> >
> > yes: it has more error output.
> >
> > Trying really trivial in-index merge...
> > warning: Merge requires file-level merging
> > Nope, a really trivial in-index merge not possible
> > Trying simple merge.
> > Simple merge failed, trying Automatic merge.
> > error: init: is a directory - add individual files instead
> > fatal: Unable to process path init
> > fatal: merge program failed
> > Automatic merge failed; fix conflicts and then commit the result.
> 
> Isn't this the same as the known issue here?
> 
> 	<http://permalink.gmane.org/gmane.comp.version-control.git/53402>
> 

Yes, looks similar:

    .../git/t$ ./t3031-df-3way.sh -d -v -i
    ...
    Created commit 992a330: side moves and makes changes
     6 files changed, 155 insertions(+), 153 deletions(-)
     create mode 100644 D
     create mode 100644 D.A
     delete mode 100644 D/A
     delete mode 100644 D/B
     delete mode 100644 D/C
     create mode 100644 D0C
    *   ok 1: setup

    * expecting success: 

	    git read-tree -m initial side master


    fatal: Entry 'D/A' would be overwritten by merge. Cannot merge.
    * FAIL 2: threeway


		    git read-tree -m initial side master

    .../git/t$
