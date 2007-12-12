From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 0/2] [RFT] git-svn: more efficient revision -> commit mapping
Date: Wed, 12 Dec 2007 10:05:10 -0800
Message-ID: <20071212180510.GB18980@untitled>
References: <1197185262-16765-1-git-send-email-normalperson@yhbt.net> <1197233768.7185.6.camel@brick> <1197248646.7185.25.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Harvey Harrison <harvey.harrison@gmail.com>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed Dec 12 19:05:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2Vxe-0001MC-Iv
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 19:05:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027AbXLLSFM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 13:05:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751657AbXLLSFM
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 13:05:12 -0500
Received: from hand.yhbt.net ([66.150.188.102]:57741 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751307AbXLLSFL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 13:05:11 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 8B6EE7DC025;
	Wed, 12 Dec 2007 10:05:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1197248646.7185.25.camel@brick>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68078>

Harvey Harrison <harvey.harrison@gmail.com> wrote:
> On Sun, 2007-12-09 at 12:56 -0800, Harvey Harrison wrote:
> > On Sat, 2007-12-08 at 23:27 -0800, Eric Wong wrote:
> > > This is very lightly tested, but describes the format I described in:
> > > 
> > >   http://article.gmane.org/gmane.comp.version-control.git/67126
> > > 
> > >   (more in the commit messages)
> > > 
> > > I'll be out of town the next few days and I'm not sure how much I'll be
> > > able to follow up on it while I'm gone.  Please test, especially if
> > > you're dealing with a repository where large .rev_db files are a
> > > problem.
> > > 
> > > Junio: not intended for master just yet, but if you hear nothing but
> > > good things about it, feel free :)
> > Preliminary tests against the gcc repo are going swimmingly.
> > 
> > Successful git svn rebase against trunk, doing a full git svn fetch
> > now to build rev_maps for all svn branches/tags.  At halfway through
> > space has decreased from ~2GB to 17MB for about half of the needed
> > metadata.
> > 
> 
> Eric,
> 
> I'm very happy with these patches.  For the gcc repo, git-svn metadata
> has gone from over 5GB to 33MB.  git-svn fetch/rebase are working fine,
> will shout if I see any odd behavior.

Harvey:

Thanks for the feedback.  Glad it helps with gcc.  I'll make unlinking
the index files the default tonight since it shouldn't hurt performance
enough to matter, and the disk savings is enough to justify it..

Sam (or anybody else using useSvmProps:

  Do you have any feedback with svmProps enabled?

-- 
Eric Wong
