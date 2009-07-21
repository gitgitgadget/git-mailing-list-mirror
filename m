From: Josef Bacik <josef@redhat.com>
Subject: Re: [RFE] allow git bisect to figure out in which revision a bug
	was fixed
Date: Tue, 21 Jul 2009 16:28:48 -0400
Message-ID: <20090721202848.GA3453@localhost.localdomain>
References: <x49ocrdokp9.fsf@segfault.boston.devel.redhat.com> <7vfxcpdbsh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff Moyer <jmoyer@redhat.com>, git@vger.kernel.org,
	Josef Bacik <josef@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 22:29:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTLy1-0005Du-1X
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 22:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756085AbZGUU2y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 16:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755737AbZGUU2x
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 16:28:53 -0400
Received: from mx2.redhat.com ([66.187.237.31]:49967 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753161AbZGUU2x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 16:28:53 -0400
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n6LKSqxu031855;
	Tue, 21 Jul 2009 16:28:52 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n6LKSp0q012585;
	Tue, 21 Jul 2009 16:28:51 -0400
Received: from localhost.localdomain (vpn-10-146.bos.redhat.com [10.16.10.146])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n6LKSoI7025996;
	Tue, 21 Jul 2009 16:28:50 -0400
Content-Disposition: inline
In-Reply-To: <7vfxcpdbsh.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Scanned-By: MIMEDefang 2.58 on 172.16.27.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123708>

On Tue, Jul 21, 2009 at 01:24:46PM -0700, Junio C Hamano wrote:
> Jeff Moyer <jmoyer@redhat.com> writes:
> 
> > As a distro kernel grunt, I sometimes find myself in the situation of
> > having to track down the commit that fixed a given problem so that I can
> > backport it to an older kernel.  Sometimes I'm smart enough to figure it
> > out myself, other times I'm not.  ;-)  It would be helpful if git bisect
> > could help figure out in what commit a bug was fixed as opposed to
> > introduced.  Is there any interest in implementing such a feature?
> 
> Doesn't that already exist?
> 
> You are hunting for an existence of the bug, so any commit that is buggy
> (with respect to the bug you are interested in) is *GOOD*.  The tip of the
> upstream is *BAD* in that it does not have your favourite bug anymore.
> 
> You bisect that history down, and will find the first *BAD* commit.
> 
> Now, why is that commit the procedure finds is *BAD*, again?  Yup, because
> it does not have your favourite bug anymore.  And why is that so?
> 
> Because the commit fixed that bug.

Sure, but as one who has used this procedure several times before, it is very
error prone, on my side because I'm a big goober.  I have a tendancy to get my
wires crossed and get dumped out at a commit that doesnt make sense (my latest
attempt put me out at a merge commit).  Sure its my fault for not being able to
keep it straight, theres no arguing that, it still would be nice for there to be
a way to remove as much human error from the process as possible.  Thanks,

Josef
