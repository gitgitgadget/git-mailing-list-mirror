From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: auto-merge after push?
Date: Thu, 11 Jun 2009 13:40:20 +0300
Message-ID: <20090611104020.GA12036@redhat.com>
References: <20090511142326.GA18260@redhat.com> <alpine.DEB.1.00.0905111714250.4973@intel-tinevez-2-302> <20090511201705.GA21045@redhat.com> <alpine.DEB.1.00.0905112302130.27348@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 11 12:41:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEhjF-0001y2-Vs
	for gcvg-git-2@gmane.org; Thu, 11 Jun 2009 12:41:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761398AbZFKKln (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2009 06:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758682AbZFKKln
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jun 2009 06:41:43 -0400
Received: from mx2.redhat.com ([66.187.237.31]:41724 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752619AbZFKKln (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2009 06:41:43 -0400
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n5BAeQuu006337;
	Thu, 11 Jun 2009 06:40:26 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n5BAeQmK001955;
	Thu, 11 Jun 2009 06:40:26 -0400
Received: from redhat.com (vpn-224-117.phx2.redhat.com [10.3.224.117])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n5BAeM24022238;
	Thu, 11 Jun 2009 06:40:23 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0905112302130.27348@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Scanned-By: MIMEDefang 2.58 on 172.16.27.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121334>

On Mon, May 11, 2009 at 11:03:27PM +0200, Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 11 May 2009, Michael S. Tsirkin wrote:
> 
> > On Mon, May 11, 2009 at 05:18:06PM +0200, Johannes Schindelin wrote:
> > > The thing is, a merge can fail.  And then you already need direct access 
> > > to the working directory in question.
> > > 
> > > If you were actually talking about fast-forward pushes (because you did 
> > > the merge locally already), this might help you:
> > > 
> > > 	http://thread.gmane.org/gmane.comp.version-control.git/110251
> > 
> > Sounds good. But it looks like this patch is unlikely to be merged, does 
> > it not?
> 
> Unlikely to be merged by Junio?  Without success stories, certainly.
> 
> But you can do the same as I did: run your local Git with that patch.  I 
> am actually growing fonder and fonder of denyCurrentBranch=updateInstead.  
> It works beautifully here.
> 
> Of course, I always know what I am doing.
> 
> Ciao,
> Dscho
> 
> P.S.: :-)

So here's a success story:

I have been using this patch for 1 month now, on all my trees, with
denyCurrentBranch=updateInstead
I find it very useful for several reasons:
- I commit on my development machine, then push to test machine
- I debug and fix an issue on test machine, push change back to devel machine
- If I'm going from home to the office, I just push into the machine at the office, and when
  I get there the tree is set up and ready for me to hack on, same on my way back

Of course all the same things can be accomplished with a set of scripts,
but frankly I never got them to be as flexible and easy to use as this
patch. This patch simply works for me. Thanks for it Johannes, and I
hope it makes it into upstream at some point, so that more people can
benefit from it.

-- 
MST
