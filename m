From: Tom Lord <lord@emf.net>
Subject: Re: Val Henson's critique of hash-based content storage systems
Date: Fri, 29 Apr 2005 13:37:47 -0700 (PDT)
Message-ID: <200504292037.NAA28344@emf.net>
References: <Pine.LNX.4.61.0504291608410.32145@cag.csail.mit.edu>
Cc: git@vger.kernel.org, robj@unrealities.com
X-From: git-owner@vger.kernel.org Fri Apr 29 22:38:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRcFZ-0008Up-Br
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 22:38:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262936AbVD2UmV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 16:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262940AbVD2UjK
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 16:39:10 -0400
Received: from emf.emf.net ([205.149.0.19]:10 "EHLO emf.net")
	by vger.kernel.org with ESMTP id S262963AbVD2Uhx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2005 16:37:53 -0400
Received: (from lord@localhost) by emf.net (K/K) id NAA28344; Fri, 29 Apr 2005 13:37:47 -0700 (PDT)
To: cscott@cscott.net
In-reply-to: <Pine.LNX.4.61.0504291608410.32145@cag.csail.mit.edu> (cscott@cscott.net)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


  lord:

  > I would expect someone to have on hand a small number of blobs that are
  > different but have different hashes and, eventually, to drop said files
  > into a blob-based infrastructure to wreak havoc.

  cscott:
  
  This is just ridiculous.  The number of known collisions in SHA1 is 
  *exactly zero* at this point in time --- not guaranteed to stay that way, 
  of course, but generating collisions is likely to remain relatively 
  expensive for some time.

Blob-dbs and the low-level object system (trees, file-contents, and
changesets) are pretty fundamental things.  It is likely (and
desirable) -- not guaranteed but likely (and desirable) -- that people
will invest heavily in building infrastructure that operates solely at
that level of abstraction.  Arguably, that is already happening.

Simultaneously, it is very desirable that some mathemetican somewhere
will discover two bitstrings which are different but have SHA1
checksums, and then tell everyone in the world about their discovery.

My point is simply that blob-db implementations should assume that the
mathemeticians will succeed and take the small steps necessary to make
sure that those bitstrings can't be used to crash a distributed
blob-db infrastructure.

-t


