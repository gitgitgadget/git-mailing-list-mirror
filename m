From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: Re: [PATCH] display shortlog after git-commit
Date: Mon, 16 Apr 2007 09:26:41 +0300
Message-ID: <20070416062640.GE23255@mellanox.co.il>
References: <20070322104021.GJ29341@mellanox.co.il>
	<7v7it7kkl9.fsf@assigned-by-dhcp.cox.net>
	<20070404060213.GB31984@mellanox.co.il>
	<7v7iss8xo6.fsf@assigned-by-dhcp.cox.net>
	<20070404070135.GF31984@mellanox.co.il>
	<7vps6k7gez.fsf@assigned-by-dhcp.cox.net>
	<20070415223909.GG15208@mellanox.co.il>
	<7vy7kt1bij.fsf@assigned-by-dhcp.cox.net>
	<20070416053435.GA23255@mellanox.co.il>
	<7vk5wcx3cd.fsf@assigned-by-dhcp.cox.net>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 08:26:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdKfr-0001rt-Sj
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 08:26:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754001AbXDPG0k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 02:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753997AbXDPG0k
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 02:26:40 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:60233 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753992AbXDPG0i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 02:26:38 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1033322uga
        for <git@vger.kernel.org>; Sun, 15 Apr 2007 23:26:37 -0700 (PDT)
Received: by 10.67.29.7 with SMTP id g7mr4097478ugj.1176704797526;
        Sun, 15 Apr 2007 23:26:37 -0700 (PDT)
Received: from ?127.0.0.1? ( [89.138.119.177])
        by mx.google.com with ESMTP id j2sm6108506ugf.2007.04.15.23.26.36;
        Sun, 15 Apr 2007 23:26:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vk5wcx3cd.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44594>

> Quoting Junio C Hamano <junkio@cox.net>:
> Subject: Re: [PATCH] display shortlog after git-commit
> 
> "Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:
> 
> >> Quoting Junio C Hamano <junkio@cox.net>:
> >> Subject: Re: [PATCH] display shortlog after git-commit
> >> 
> >> "Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:
> >> 
> >> > Display the subject of the commit just made.
> >> 
> >> WHY?  You just made the commit.
> >
> > BTW, Junio, why does git-commit need to display the diffstat?
> > You just made the commit ...
> 
> Don't ask me.  It was not my idea.
> 
> We only had --summary per popular list request, and it made
> certain amount of sense since addition/deletion are notable
> events that do not happen with _every_ commit.

Hmm. I agree. Does it make sense to only show additions/deletions?

Digging through git-commit.sh history, I found this: the log actually
misleadingly talks about the summary of created/deleted files.  Is it possible
that git-runstatus --shortlog reported just the created/deleted files
originally?

commit ebd124c6783da5e064963611ee17741cd173f6b5
Author: Nicolas Pitre <nico@cam.org>
Date:   Thu Dec 14 23:15:44 2006 -0500

    make commit message a little more consistent and conforting

    It is nicer to let the user know when a commit succeeded all the time,
    not only the first time.  Also the commit sha1 is much more useful than
    the tree sha1 in this case.

    This patch also introduces a -q switch to supress this message as well
    as the summary of created/deleted files.

    Signed-off-by: Nicolas Pitre <nico@cam.org>
    Signed-off-by: Junio C Hamano <junkio@cox.net>

If yes, then is it possible that this change might have been introduced
inadvetently by git-runstatus behaviour change?

Nicolas, what was the intent?

-- 
MST
