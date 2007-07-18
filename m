From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Empty directories...
Date: Wed, 18 Jul 2007 02:30:47 -0400
Message-ID: <20070718063047.GA32566@spearce.org>
References: <85lkdezi08.fsf@lola.goethe.zz> <vpqfy3m7dex.fsf@bauges.imag.fr> <85zm1uxmmw.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Jul 18 08:30:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IB33n-0002Ac-Rt
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 08:30:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbXGRGax (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 02:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbXGRGax
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 02:30:53 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:54950 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260AbXGRGaw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 02:30:52 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IB33g-0006zE-Dz; Wed, 18 Jul 2007 02:30:48 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id DF5DD20FBAE; Wed, 18 Jul 2007 02:30:47 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <85zm1uxmmw.fsf@lola.goethe.zz>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52832>

David Kastrup <dak@gnu.org> wrote:
> > ,----[ http://www.spinics.net/lists/git/msg30730.html ]
> > | From: Linus Torvalds <torvalds@xxxxxxxxxxxxxxxxxxxx>
> > | 
> > | I wouldn't personally mind if somebody taught git to just track empty
> > | directories too.
> > | 
> > | There is no fundamental git database reason not to allow them:
> > | it's in fact quite easy to create an empty tree object.
> > | The problems with empty directories are in the *index*, and they
> > | shouldn't be insurmountable.
> 
> Stop right here: does that mean that I can script some "put empty
> directories into the last commit manually" procedure bypassing the
> index?

Yes.  But when you read that tree into the index later (by say
checking out a branch that points to it) the empty directories
will not be created, as they have no files to cause their creation.
Committing changes on that branch will remove the empty directories.
;-)

Oh, and the above question from you sounds like you think you can
modify the last commit to include new directories that weren't
there before.  You cannot do that without changing the tree SHA-1,
which will cause the commit SHA-1 to change.  That in turns means you
are not actually adding to the last commit but instead are creating
an entirely different commit.  History in Git is always immutable.

-- 
Shawn.
