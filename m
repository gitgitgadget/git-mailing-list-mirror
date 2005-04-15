From: linux@horizon.com
Subject: Re: Handling renames.
Date: 15 Apr 2005 13:37:59 -0000
Message-ID: <20050415133759.7560.qmail@science.horizon.com>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 15:35:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMQxy-00021A-5Y
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 15:34:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbVDONiF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 09:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbVDONiF
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 09:38:05 -0400
Received: from science.horizon.com ([192.35.100.1]:23098 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S261817AbVDONiC
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2005 09:38:02 -0400
Received: (qmail 7561 invoked by uid 1000); 15 Apr 2005 13:37:59 -0000
To: dwmw2@infradead.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> One option for optimising this, if we really need to, might be to track
> the file back to its _first_ ancestor and use that as an identification.
> The SCM could store that identifier in the blob itself, or we could
> consider it an 'inode number' and store it in git's tree objects.

This suggestion (and this whole discussion about renames) has issues
with file copies, which form a branch in the revision history.  If I
copy foo.c to foo2.c (or fs/ext2/ to fs/ext3/), then the oldest ancestor
isn't a "unique inode number".

I've written a lot of programs by debugging hello.c.

Thinking about this can give you all sorts of exciting merge possibilities.

If branch1 renames a.c to b.c, and branch2 patches a.c, it seems obvious
that the patch should be merged into b.c.  But what if branch1 copies a.c
to b.c?
