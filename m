From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCh] jit-trackdown
Date: Fri, 29 Apr 2005 17:40:56 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504291730000.30848-100000@iabervon.org>
References: <7voebx4dyd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Greaves <david@dgreaves.com>,
	GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 29 23:38:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRdB1-0006v1-Li
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 23:37:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263006AbVD2Vmw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 17:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263023AbVD2VmX
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 17:42:23 -0400
Received: from iabervon.org ([66.92.72.58]:1799 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S263021AbVD2VlJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2005 17:41:09 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DRdEG-0006cx-00; Fri, 29 Apr 2005 17:40:56 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7voebx4dyd.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 29 Apr 2005, Junio C Hamano wrote:

> Have toilet side gitters reached a concensus (or semi-concensus)
> on how things under .git/ should be organized?  Is there a
> summary somewhere, something along the following lines?

I've made a proposal like the following:

.git/
  objects/    (traditional)
  refs/       Directories of hex SHA1 + newline files
    heads/    Commits which are heads of various sorts
    tags/     Tags, by the tag name (or some local renaming of it)
  info/       Other shared information
    remotes
  ...         Everything else isn't shared
  HEAD        Symlink to refs/heads/<something>

The plumbing doesn't care what you name heads or tags, but expects things
to be in heads to be commit objects and tags to be tag objects (which can
tag whatever).

AFAICT, there is general concensus that this is how things should be, but
I haven't convinced Linus that the plumbing should know about anything
other than objects/.

	-Daniel
*This .sig left intentionally blank*

