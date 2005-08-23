From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-ls-new-files & make patch, pull, etc.
Date: Mon, 22 Aug 2005 22:15:47 -0700
Message-ID: <7v1x4lz118.fsf@assigned-by-dhcp.cox.net>
References: <430A84D1.2050206@linuxmachines.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 23 07:16:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7R8k-0007Xb-JA
	for gcvg-git@gmane.org; Tue, 23 Aug 2005 07:16:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbVHWFPv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Aug 2005 01:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbVHWFPv
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Aug 2005 01:15:51 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:31462 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750704AbVHWFPu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2005 01:15:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050823051550.WSPX12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 23 Aug 2005 01:15:50 -0400
To: Jeff Carr <jcarr@linuxmachines.com>
In-Reply-To: <430A84D1.2050206@linuxmachines.com> (Jeff Carr's message of
	"Mon, 22 Aug 2005 19:07:13 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Jeff Carr <jcarr@linuxmachines.com> writes:

> Something simple like the perl script at the bottom would be useful for
> showing files that haven't been added via git-update-cache --add already.

If I am not mistaken, you just reinvented:

    $ git ls-files --others

in a very expensive way.  Notice your `find . -type f` that does
not prune .git directory upfront.

Also you may want to take a look at:

    $ git ls-files --others --exclude-from=.git/info/exclude
