From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [PATCH] fix compare symlink against readlink not data
Date: Fri, 06 May 2005 18:59:24 +0200
Message-ID: <1115398764.32065.27.camel@localhost.localdomain>
References: <20050506134501.GA11430@vrfy.org>
	 <20050506160359.GB6904@kroah.com>
	 <1115396614.32065.23.camel@localhost.localdomain>
	 <20050506163603.GA17766@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 18:53:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DU64H-0000Z2-OC
	for gcvg-git@gmane.org; Fri, 06 May 2005 18:52:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbVEFQ7b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 12:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbVEFQ7b
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 12:59:31 -0400
Received: from soundwarez.org ([217.160.171.123]:32732 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261157AbVEFQ70 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2005 12:59:26 -0400
Received: from dhcp-113.off.vrfy.org (d081180.adsl.hansenet.de [80.171.81.180])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by soundwarez.org (Postfix) with ESMTP id 591212E91E;
	Fri,  6 May 2005 18:59:23 +0200 (CEST)
To: Greg KH <greg@kroah.com>
In-Reply-To: <20050506163603.GA17766@kroah.com>
X-Mailer: Evolution 2.2.2 (2.2.2-1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 2005-05-06 at 09:36 -0700, Greg KH wrote:
> On Fri, May 06, 2005 at 06:23:34PM +0200, Kay Sievers wrote:
> > On Fri, 2005-05-06 at 09:03 -0700, Greg KH wrote:
> > > On Fri, May 06, 2005 at 03:45:01PM +0200, Kay Sievers wrote:
> > > > Fix update-cache to compare the blob of a symlink against the link-target
> > > > and not the file it points to. Also ignore all permissions applied to
> > > > links.
> > > > Thanks to Greg for recognizing this while he added our list of symlinks
> > > > back to the udev repository.
> > > 
> > > Hm, even with this patch applied (it's in Linus's tree right now), I
> > > still get the following with a clean checked out udev tree:
> > >  $ cg-diff
> > >  Index: test/sys/block/cciss!c0d0/device
> > >  ===================================================================
> > 
> > I can't reproduce this. Are you sure, that the git-core binaries are
> > called and not the cogito ones?
> > 
> >   git-update-cache --refresh
> >   git-diff-cache -r HEAD
> > from the core-git should print nothing.
> 
> Odd.  If I reclone the whole tree from the udev kernel.org tree, then it
> works just fine.  If I create a new copy of my local tree, I still have
> the same problem.  Diffing the trees shows no difference in the objects
> at all...
> 
> Can you add a symlink to a local tree and see if you can duplicate this?

Works as it should be.
What happens when you throw away your old .git/index with?
  git-read-tree HEAD

Kay

