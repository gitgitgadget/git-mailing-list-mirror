From: Tom Lord <lord@emf.net>
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Date: Fri, 29 Apr 2005 12:28:41 -0700 (PDT)
Message-ID: <200504291928.MAA27145@emf.net>
References: <2944.10.10.10.24.1114802002.squirrel@linux1>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 21:24:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRb4q-0008VK-Dl
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 21:23:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262894AbVD2T2q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 15:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262896AbVD2T2q
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 15:28:46 -0400
Received: from emf.emf.net ([205.149.0.19]:50697 "EHLO emf.net")
	by vger.kernel.org with ESMTP id S262894AbVD2T2o (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2005 15:28:44 -0400
Received: (from lord@localhost) by emf.net (K/K) id MAA27145; Fri, 29 Apr 2005 12:28:41 -0700 (PDT)
To: seanlkml@sympatico.ca
In-reply-to: <2944.10.10.10.24.1114802002.squirrel@linux1> (seanlkml@sympatico.ca)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Think of it this way:

  (a) Joe, the mainline maintainer, gets a trusted message containing
      a diff.

  (b) Joe reads the diff, it makes great sense, he wants to merge.

  (c) Joe downloads a tree.  Supposedly that tree is the result of
      applying this diff.   The tree, not the diff, is used for
      merging.

You can see the logical whole there... now the practical one:


   (d) Joe is repeating (a..c) at an unfathomably high rate.
       At a low rate, he could be double-checking enough that
       that the diff-vs-tree problem isn't that serious.  But
       at the rate he operates, exploits appear all along the
       patch-flow pipeline because so much stuff goes unchecked.

       Joe may be scan the changes he's merged before committing but,
       if his rate is high, that scan *must*, out of biological and
       physical necessity, be shallow.   Exploits can occur on the
       submitter machine, in the communication channel, and on Joe's 
       machine.   Social exploits can occur because of the separation
       between a submitter saying "this is what I'm doing" vs. the reality
       of what the submitter is doing.

-t

