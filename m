From: "C. Scott Ananian" <cscott@cscott.net>
Subject: Re: [PATCH] write-tree performance problems
Date: Wed, 20 Apr 2005 11:30:22 -0400 (EDT)
Message-ID: <Pine.LNX.4.61.0504201128550.2630@cag.csail.mit.edu>
References: <200504191250.10286.mason@suse.com> <200504192049.21947.mason@suse.com>
 <Pine.LNX.4.58.0504192337120.6467@ppc970.osdl.org> <200504201122.35448.mason@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 17:28:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOH5x-0000Dk-Da
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 17:26:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbVDTPam (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 11:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbVDTPam
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 11:30:42 -0400
Received: from sincerity-forever.csail.mit.edu ([128.30.67.31]:46734 "EHLO
	sincerity-forever.csail.mit.edu") by vger.kernel.org with ESMTP
	id S261692AbVDTPag (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 11:30:36 -0400
Received: from catfish.lcs.mit.edu ([128.30.67.25] helo=cag.csail.mit.edu)
	by sincerity-forever.csail.mit.edu with esmtp (Exim 3.36 #1 (Debian))
	id 1DOH9t-0000PT-00; Wed, 20 Apr 2005 11:30:33 -0400
To: Chris Mason <mason@suse.com>
In-Reply-To: <200504201122.35448.mason@suse.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 20 Apr 2005, Chris Mason wrote:

> With the basic changes I described before, the  100 patch time only goes down
> to 40s.  Certainly not fast enough to justify the changes.  In this case, the
> bulk of the extra time comes from write-tree writing the index file, so I
> split write-tree.c up into libwrite-tree.c, and created update-cache
> --write-tree.

Hmm.  Are our index files too large, or is there some other factor?
I was considering using a chunked representation for *all* files (not just 
blobs), which would avoid the original 'trees must reference other trees 
or they become too large' issue -- and maybe the performance issue you're 
referring to, as well?
  --scott

Boston MI6 quiche LPMEDLEY BLUEBIRD PBSUCCESS jihad biowarfare non-violent protest 
Yakima NRA EZLN DES hack SARANAC KMPLEBE Echelon PBCABOOSE security
                          ( http://cscott.net/ )
