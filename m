From: Derek Fawcus <dfawcus@cisco.com>
Subject: Re: space compression (again)
Date: Fri, 15 Apr 2005 20:00:54 +0100
Message-ID: <20050415200054.F6735@mrwint.cisco.com>
References: <Pine.LNX.4.61.0504151232160.27637@cag.csail.mit.edu> <Pine.LNX.4.58.0504151117360.7211@ppc970.osdl.org> <Pine.LNX.4.61.0504151437100.27637@cag.csail.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Apr 15 20:58:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMW0T-0000np-JI
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 20:57:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbVDOTBC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 15:01:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbVDOTBC
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 15:01:02 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:2355 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S261907AbVDOTA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2005 15:00:57 -0400
Received: from ams-core-1.cisco.com (144.254.224.150)
  by ams-iport-1.cisco.com with ESMTP; 15 Apr 2005 21:00:57 +0200
Received: from cisco.com (mrwint.cisco.com [64.103.71.48])
	by ams-core-1.cisco.com (8.12.10/8.12.6) with ESMTP id j3FJ0s54003793
	for <git@vger.kernel.org>; Fri, 15 Apr 2005 21:00:54 +0200 (MEST)
Received: (from dfawcus@localhost)
	by cisco.com (8.8.8-Cisco List Logging/8.8.8) id UAA20405
	for git@vger.kernel.org; Fri, 15 Apr 2005 20:00:54 +0100 (BST)
To: git@vger.kernel.org
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.61.0504151437100.27637@cag.csail.mit.edu>; from cscott@cscott.net on Fri, Apr 15, 2005 at 02:45:55PM -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 15, 2005 at 02:45:55PM -0400, C. Scott Ananian wrote:
> > - we already have wasted space due to the low-level filesystem (as
> >   opposed to "git") usually being block-based, which means that space
> >   utilization for small objects tends to suck. So you really want to
> >   prefer objects that are several kB (compressed), and a small block just
> >   wastes tons of space.
> 
> Not on (say) reiserfs, and not over the network.  I'm proposing (at the 
> moment) easy conversion from chunked to unchunked disk representation,
> so that you can leave things unchunked if (for example) you know you're 
> running ext2 with a large block size.

Or if one does not care about space,  and simply want's speed,  add another
layer of indirection - a flattened container object which has hashses as
normal,  then as it's content simply has the 'chunk list object' and the
'chunk objects' concatenated.

It's then a per user / database as to if the flattened objects,  or the
heirarcal objects are storred locally.

DF
