From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 21/22] teach the merge algorithm about cache iterators
Date: Mon, 12 Sep 2005 16:43:05 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509121633480.23242@iabervon.org>
References: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
 <20050912145629.28120.70337.stgit@dexter.citi.umich.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 12 22:39:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEv4y-0005QV-37
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 22:39:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbVILUjA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 16:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbVILUjA
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 16:39:00 -0400
Received: from iabervon.org ([66.92.72.58]:44294 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932224AbVILUi7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 16:38:59 -0400
Received: (qmail 25186 invoked by uid 1000); 12 Sep 2005 16:43:05 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Sep 2005 16:43:05 -0400
To: Chuck Lever <cel@netapp.com>
In-Reply-To: <20050912145629.28120.70337.stgit@dexter.citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8425>

On Mon, 12 Sep 2005, Chuck Lever wrote:

> For now, we simply replace indpos with a cache cursor.  Likely more
> changes will be needed after we successfully replace the cache array
> with an abstract data type.

The right order is probably to add the concept of a cache that isn't the 
one that normal functions deal with, have read_cache_unmerged return such 
a thing, call cc_init with that, and rip out all of the removal and 
position adjustment code. Then read_tree won't care at all about the 
internal structure of the cache type, and it can be replaced without any 
problem.

	-Daniel
*This .sig left intentionally blank*
