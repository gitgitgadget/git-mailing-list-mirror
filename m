From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: tree corrupted on disk quota full
Date: Thu, 11 Jan 2007 15:59:18 +0200
Message-ID: <20070111135918.GO1759@mellanox.co.il>
References: <45A63E59.7030009@op5.se>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 14:59:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H50ST-0000HO-Q8
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 14:59:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030465AbXAKN7G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 08:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030478AbXAKN7G
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 08:59:06 -0500
Received: from dev.mellanox.co.il ([194.90.237.44]:37367 "EHLO
	dev.mellanox.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030472AbXAKN7F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 08:59:05 -0500
Received: from mellanox.co.il ([194.90.237.34])
	by dev.mellanox.co.il (8.13.1/8.13.1) with SMTP id l0BDwtER017635;
	Thu, 11 Jan 2007 15:58:55 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Thu, 11 Jan 2007 15:59:18 +0200
To: Andreas Ericsson <ae@op5.se>
Content-Disposition: inline
In-Reply-To: <45A63E59.7030009@op5.se>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36592>

> > I hit a quota limit on a disk my tree was on, but did not notice.
> > Doing git pull on a tree seems to have corrupted it.
> > Now I have:
> > 
> > $ git-fsck-objects
> > error: 4d4d30be967d3284cbf59afd4fba6ab536e295f5: object not found
> > error: c03590b581d51d5fa43adbef9415e935d0229412: object not found
> > missing tree 10147d79b2418168d9433067b6439971bd4f1261
> > broken link from  commit 322a6c93ad86d2a151dd97a4c6b0e014a4893437
> >               to    tree 10147d79b2418168d9433067b6439971bd4f1261
> > dangling commit 322a6c93ad86d2a151dd97a4c6b0e014a4893437
> > 
> > The tree can not be pulled into, or from.
> > 
> 
> Can you do a "git rev-list" on the commit pointing to this tree?

On which commit?

> If so, you should be able to do "git reset HEAD~1" and re-do the fetch.

$ git reset --hard HEAD~1
HEAD is now at 2d41bf8... Remove svn keywords
$ git-fsck-objects
error: 4d4d30be967d3284cbf59afd4fba6ab536e295f5: object not found
error: c03590b581d51d5fa43adbef9415e935d0229412: object not found
missing tree 10147d79b2418168d9433067b6439971bd4f1261
broken link from  commit 322a6c93ad86d2a151dd97a4c6b0e014a4893437
              to    tree 10147d79b2418168d9433067b6439971bd4f1261
dangling commit 322a6c93ad86d2a151dd97a4c6b0e014a4893437

-- 
MST
