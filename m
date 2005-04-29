From: Tom Lord <lord@emf.net>
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Date: Fri, 29 Apr 2005 11:54:09 -0700 (PDT)
Message-ID: <200504291854.LAA26550@emf.net>
References: <2712.10.10.10.24.1114799620.squirrel@linux1>
Cc: torvalds@osdl.org, mpm@selenic.com, linux-kernel@vger.kernel.org,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 20:50:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRaY6-0004Ir-0y
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 20:49:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262882AbVD2SyW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 14:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262886AbVD2SyW
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 14:54:22 -0400
Received: from emf.emf.net ([205.149.0.19]:42249 "EHLO emf.net")
	by vger.kernel.org with ESMTP id S262882AbVD2SyM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2005 14:54:12 -0400
Received: (from lord@localhost) by emf.net (K/K) id LAA26550; Fri, 29 Apr 2005 11:54:09 -0700 (PDT)
To: seanlkml@sympatico.ca
In-reply-to: <2712.10.10.10.24.1114799620.squirrel@linux1> (seanlkml@sympatico.ca)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


   From: "Sean" <seanlkml@sympatico.ca>

   On Fri, April 29, 2005 2:08 pm, Tom Lord said:

   > The confusion here is that you are talking about computational complexity
   > while I am talking about complexity measured in hours of labor.
   >
   > You are assuming that the programmer generating the signature blindly
   > trusts the tool to generate the signed document accurately.   I am
   > saying that it should be tractable for human beings to read the documents
   > they are going to sign.


   Developers obviously _do_ read the changes they submit to a project or
   they would lose their trusted status.  That has absolutely nothing to do
   with signing, it's the exact same way things work today, without sigs.

Nobody that I know is endorsing "the way things work today" as especially
robust.  Lots of people endorse it as successful in the marketplace and has
having not failed horribly yet -- but that's not the same thing.


   It's not "blind trust" to expect a script to reproducibly sign documents
   you've decided to submit to a project.

It *is* blind trust to assume without further guarantees that the diff
someone sends you (signed or not) describes a tree accurately unless
the tree in question is created by a local application of that diff.

In essense, `git' (today) wants *me* to trust that *you* have
correctly applied that diff -- evidently in order to speed things up.
It makes remote users "patch servers", for no good reason.

Triple signatures, signing both the name of the ancestor, the diff,
and the resulting tree are the most robust because I can apply the
diff to the ancestor and then *verify* that it matches the signed
tree.   But systems should neither ask users to sign something too large
to read nor rely on signatures of things too large to read.


   The signature is not a QUALITY
   guarantee in and of itself.

Which has nothing to do with any of this except indirectly.

   See?  Signing something does not change the quality guarantee one way or
   the other.  It does not put any additional demands on the developer, so
   it's fine to have an automated script do it.  It's just a way to avoid
   impersonations.

The process should not rely on the security of every developer's
machine.  The process should not rely on simply trusting quality
contributors by reputation (e.g., most cons begin by establishing
trust and continue by relying inappropriately on
trust-without-verification).  This relates to why Linus'
self-advertised process should be raising yellow and red cards all
over the place: either he is wasting a huge amount of his own time and
should be largely replaced by an automated patch queue manager, or he
is being trusted to do more than is humanly possible.

-t
