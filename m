From: Blu Corater <blu@daga.cl>
Subject: Re: replacing a bad commit
Date: Mon, 5 Feb 2007 16:53:32 -0300
Message-ID: <20070205195332.GW14499@daga.cl>
References: <20070205153949.GT14499@daga.cl> <eq7mf0$lb0$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 05 20:53:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HE9uE-00011z-74
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 20:53:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933014AbXBETxe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 14:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933020AbXBETxe
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 14:53:34 -0500
Received: from pc-25-158-44-190.cm.vtr.net ([190.44.158.25]:58961 "EHLO
	daga.cl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933014AbXBETxe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 14:53:34 -0500
Received: from blu by daga.cl with local (Exim 4.63)
	(envelope-from <blu@daga.cl>)
	id 1HE9u8-0005Do-Ax
	for git@vger.kernel.org; Mon, 05 Feb 2007 16:53:32 -0300
Mail-Followup-To: git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <eq7mf0$lb0$1@sea.gmane.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38774>

On Mon, Feb 05, 2007 at 05:38:18PM +0100, Jakub Narebski wrote:
> Blu Corater wrote:
> 
> > Here is the situation. Upstream realeses tarballs once in a while. I
> > maintain local modifications. Every time upstream releases a tarball, I
> > fast forward the 'upstream' branch, and merge into 'local' branch. My
> > tree, currently, looks somewhat like this:
> > 
> >                o---o---o <--topic2
> >                |
> >                |  o---o---o <--topic1
> >                | /
> >    o---o---C---A---o---o <--local
> >   /   /   /  
> >  /   /   /
> > o---o---o---B <--upstream
> > 
> > Problem is, B should have been merged into 'local', at A, but I just
> > realized it wasn't (probably due to my own stupidity).
> > 
> > I need to correct A, i.e. merge with B, but keeping the branches already
> > in flux, and propagating the changes due to the merge to them. In short,
> > replace A with a properly merged A'.
> > 
> > I tried branching from C and merging with B, then rebasing topic branches,
> > but then I am not sure how to rebase 'local'to eliminate A.
> 
> Try using
> 
>   $ git rebase --onto A' A local

Thanks a lot, that did it.

I've got confused by the wording of the git-rebase man page. It says:

       <upstream>
          Upstream branch to compare against

Which suggests to me that <upstream> must be a branch tip, and not a
random commit, as seems to be the case (well, not random, but reachable
from <branch> if I understand well). Also, the man page doesn't give any
example of rebasing using a random commit as <upstream>, they all use
branch tips which reinforced my wrong assumption.

-- 
Blu.
