From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: gitk graph routing problem
Date: Fri, 14 Dec 2007 23:29:31 +0100
Message-ID: <20071214222931.GB4943@steel.home>
References: <20071104104618.GA3078@steel.home> <18271.3714.731136.272491@cargo.ozlabs.ibm.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Dec 14 23:30:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3J2b-0002UJ-5T
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 23:29:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754468AbXLNW3f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 17:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754080AbXLNW3f
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 17:29:35 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:34129 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753272AbXLNW3e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 17:29:34 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTvwij8=
Received: from tigra.home (Fcaa0.f.strato-dslnet.de [195.4.202.160])
	by post.webmailer.de (mrclete mo6) (RZmta 14.6)
	with ESMTP id z06a73jBEKg2Up ; Fri, 14 Dec 2007 23:29:32 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id F2313277AE;
	Fri, 14 Dec 2007 23:29:31 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id D66C056D22; Fri, 14 Dec 2007 23:29:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <18271.3714.731136.272491@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68356>

Paul Mackerras, Tue, Dec 11, 2007 23:26:10 +0100:
> Alex Riesen writes:
> 
> > To reproduce, try running in git repo:
> > 
> >     gitk 02f630448e5d48e..06ea6ba9cf46ef5
> > 
> > Than go some pages (around 5) forward. You should notice system load
> > going up rapidly. Now try paging back - and graph starts stretching
> > to the right, to the point nothing fits on the screen anymore.
> 
> I finally got back to look at this.  The problem is not so much the
> layout algorithm per se as the fact that I haven't worked out a good
> way to pack lots of downward-pointing arrows in without using up
> arbitrarily large amounts of horizontal space.  You have managed to
> find an example where just about every commit is a merge needing one
> or more downward-pointing arrows.
> 
> Incidentally, gitk from the dev branch of my gitk.git repo does much
> better on this example, since it is able to hoist the open-circle
> (excluded) commits up to the row below their merge children, which
> looks much nicer.

could you point to a specific commit where it does that?

Because the current head of dev branch at //git.kernel.org/pub/scm/gitk/gitk
(3de07118f0993e6f7bc7ce02276751795d80b877) does not look any
different and still almost locks up drawing all the horizontal lines.
