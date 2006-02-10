From: Shawn Pearce <spearce@spearce.org>
Subject: [ANNOUNCE] pg - A patch porcelain for GIT
Date: Fri, 10 Feb 2006 14:59:14 -0500
Message-ID: <20060210195914.GA1350@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Feb 10 20:59:31 2006
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1F7eQU-0005RL-00
	for <gcvg-git@gmane.org>; Fri, 10 Feb 2006 20:59:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbWBJT71 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Feb 2006 14:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751047AbWBJT71
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Feb 2006 14:59:27 -0500
Received: from [64.38.20.226] ([64.38.20.226]:33738 "EHLO corvette.plexpod.net")
	by vger.kernel.org with ESMTP id S1750813AbWBJT71 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Feb 2006 14:59:27 -0500
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1F7eQD-0005RO-Nu
	for git@vger.kernel.org; Fri, 10 Feb 2006 14:59:14 -0500
Received: by asimov.spearce.org (Postfix, from userid 1000)
	id DA48320FBA0; Fri, 10 Feb 2006 14:59:14 -0500 (EST)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15879>

I just posted the first public version of pg, a GIT porcelain for
managing patches.  Think StGIT, but better in some ways:

Feature Summary:

- Maximum compatibility with other GIT porcelains.

    pg was designed to interoperate with core GIT and the other
    GIT porcelains as much as possible.  GIT favorites like git-am
    can be used to modify a pg managed patch, and vice-versa,
    and without requiring changes to the other GIT tools.

- Simplified command line user interface.

    pg tries to simplify GIT by 'hiding' the index and behaving like
    more traditional SCMs which only look at `HEAD` (last commit)
    and the working directory (files).

- Preserves change history of patches.

    The complete change history associated with each patch is
    maintained directly within GIT.  By storing the evolution of a
    patch as a sequence of GIT commits standard GIT history tools
    such as gitk can be used.

- Its prune proof.

    The metadata structure is stored entirely within the refs
    directory and the object database, which means you can safely use
    git-prune without damaging your work, even for unapplied patches.

- Preserves patch series during clone.

    The metadata structure used by pg allows git-clone to preserve
    the patch series information, without changes required to
    git-clone.  (Patch series information is not preserved during
    git-pull/git-push however.)

- Mix and matching of changes (bug fixes/features).

    By maintaining changes as individual patches it is possible to
    apply individual changes to the current working directory and
    to unapply them just as easily.

- Automatic detection (and cancellation) of returning patches.

    pg automatically detects when a patch is received from
    the upstream GIT repository during a pg-rebase and deletes
    (cancels) the local version of the patch from the patch series.
    The automatic cancelling makes it easy to use pg to track and
    develop changes on top of a GIT project.

- Fast

    pg operations generally perform faster than StGIT operations,
    at least on my large (~7000 file) repositories.


And for those so inclined:

  Homepage:       http://www.spearce.org/projects/scm/pg/
  GIT Repository: http://www.spearce.org/projects/scm/pg.git


-- 
Shawn.
