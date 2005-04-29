From: Tom Lord <lord@emf.net>
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Date: Fri, 29 Apr 2005 13:44:03 -0700 (PDT)
Message-ID: <200504292044.NAA28429@emf.net>
References: <20050429202117.GA15417@uglybox.localnet>
Cc: noel@zhtwn.com, seanlkml@sympatico.ca, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 22:42:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRcJR-0000XN-KN
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 22:42:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262943AbVD2Uqi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 16:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262967AbVD2Uo0
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 16:44:26 -0400
Received: from emf.emf.net ([205.149.0.19]:1290 "EHLO emf.net")
	by vger.kernel.org with ESMTP id S262953AbVD2UoG (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2005 16:44:06 -0400
Received: (from lord@localhost) by emf.net (K/K) id NAA28429; Fri, 29 Apr 2005 13:44:03 -0700 (PDT)
To: noel@zhtwn.com
In-reply-to: <20050429202117.GA15417@uglybox.localnet> (message from Noel Maddy on Fri, 29 Apr 2005 16:21:17 -0400)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



  > Your example had Joe reviewing a signed diff, and then applying changes
  > from a tree that "supposedly" had the diff applied correctly, but may
  > have been corrupted. If the tree was not an accurate representation of
  > applying the diff, then the changes Joe applied to his tree will be
  > different than those that he reviewed.

That's right.   I'm saying that Joe needn't rely on the tree at all since
he should be having his tools verify its contents anyway.  Given that, 
he may as well have his tools *generate* the tree.  Having generated the tree,
it's gravy to then verify that it matches the tree the submitter thought he
was sending -- that's a *secondary* checksum where `git' currently uses
it as primary.


  > My example had Joe downloading a remote signed tree, reviewing the changes
  > locally between his own trusted tree and the remote tree, 

In the real world, that "review" step is the weak link.  When it goes
wrong, the first step is to make sure we are reviewing a tree everyone
involved *intended* -- and it's only with signed diffs adding up to
that tree that we get there.

-t
