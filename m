From: Junio C Hamano <junkio@cox.net>
Subject: Re: Problem with the dump HTTP transport
Date: Wed, 21 Dec 2005 09:59:57 -0800
Message-ID: <7vu0d2baaq.fsf@assigned-by-dhcp.cox.net>
References: <1135166574.26233.64.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 21 19:03:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ep8G3-0002qA-Kw
	for gcvg-git@gmane.org; Wed, 21 Dec 2005 19:00:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbVLUSAI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 13:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbVLUSAH
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 13:00:07 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:36533 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751150AbVLUSAG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2005 13:00:06 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051221175829.PXYX17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 21 Dec 2005 12:58:29 -0500
To: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1135166574.26233.64.camel@localhost> (Marcel Holtmann's message
	of "Wed, 21 Dec 2005 13:02:54 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13885>

Marcel Holtmann <marcel@holtmann.org> writes:

> Cannot obtain needed object c2f3bf071ee90b01f2d629921bb04c4f798f02fa
> while processing commit 0000000000000000000000000000000000000000.
> cg-fetch: objects fetch failed
>
> Both, git and cogito, are the latest versions from yesterday. So it
> seems every time you repack, you need to do something extra to keep the
> dump HTTP transport happy.

The last sentence is correct and I do that (the magic word is
git-update-server-info, and that is done as part of git-repack
automatically), but it does not seem to apply here.  It most
likely is a mirroring delay.  That c2f3... object is the commit
at the tip of the master branch, and the repository is fully
packed right now (except v1.0.0 tag object which is loose).
