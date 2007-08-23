From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: Re: stgit 0.13 import mbox problems
Date: Thu, 23 Aug 2007 14:56:08 -0400
Message-ID: <20070823185608.GC1608@filer.fsl.cs.sunysb.edu>
References: <20070823092254.GA5976@kroah.com> <20070823180633.GA24530@filer.fsl.cs.sunysb.edu> <20070823184758.GB17601@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: catalin.marinas@gmail.com, git@vger.kernel.org
To: Greg KH <greg@kroah.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 20:56:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOHrD-00043i-U7
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 20:56:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764611AbXHWS4N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 14:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764895AbXHWS4N
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 14:56:13 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:47608 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764567AbXHWS4N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 14:56:13 -0400
Received: from filer.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l7NIu9Le005291;
	Thu, 23 Aug 2007 14:56:09 -0400
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l7NIu9XX005288;
	Thu, 23 Aug 2007 14:56:09 -0400
X-Authentication-Warning: filer.fsl.cs.sunysb.edu: jsipek set sender to jsipek@fsl.cs.sunysb.edu using -f
Content-Disposition: inline
In-Reply-To: <20070823184758.GB17601@kroah.com>
User-Agent: Mutt/1.5.16 (2007-07-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56516>

On Thu, Aug 23, 2007 at 11:47:58AM -0700, Greg KH wrote:
> On Thu, Aug 23, 2007 at 02:06:33PM -0400, Josef Sipek wrote:
> > On Thu, Aug 23, 2007 at 02:22:54AM -0700, Greg KH wrote:
> > > Hi,
> > > 
> > > I wanted to see if I could start using stgit instead of quilt, so I
> > > tried to import my current set of kernel patches.
> >  
> > May I suggest you give guilt [1,2] a spin? It uses the same quilt-like
> > patch directory format so things should Just Work(tm).
> 
> Nice, I didn't realize this was still being worked on.
> 
> Hm, is there an "easy" way to take a current tree of quilt patches
> (like, say 177 of them) and import them into guilt?  After reading the
> guilt documentation I didn't see a way to do it, but I might have missed
> something.
 
cd gregkh-2.6/
git-checkout master
guilt-init
rm -rf .git/patches/master/
mv quilts-patches-dir/ .git/patches/master/
guilt-series # tada!

> Also, this looks exactly like stgit in a way, can anyone point me at the
> differences, or is this just two different projects being done by two
> different groups/people to do the same thing?  If so, that's fine, just
> curious.

Yep. Two different projects taking different approaches to storing the
patches. I go with the plaintext diff approach ala quilt, while stgit uses
git objects to store the data.

Josef 'Jeff' Sipek.
 
-- 
#endif /* NO LIFE */
