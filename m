From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git status: ignore empty directories (because they cannot be added)
Date: Mon, 22 May 2006 18:11:36 -0700
Message-ID: <7vu07h8rzr.fsf@assigned-by-dhcp.cox.net>
References: <E1FiHXS-0008MC-LB@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 23 03:11:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiLQy-0008Ck-Th
	for gcvg-git@gmane.org; Tue, 23 May 2006 03:11:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWEWBLi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 21:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbWEWBLi
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 21:11:38 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:38094 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750748AbWEWBLi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 May 2006 21:11:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060523011137.SWLX24290.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 22 May 2006 21:11:37 -0400
To: Matthias Lederhofer <matled@gmx.net>
In-Reply-To: <E1FiHXS-0008MC-LB@moooo.ath.cx> (Matthias Lederhofer's message
	of "Mon, 22 May 2006 23:02:06 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20559>

Matthias Lederhofer <matled@gmx.net> writes:

> and a new option -u / --untracked-files to show files in untracked
> directories.
>
> ---
> A few things I'm not sure about:
> - Should there be another option to disable --no-empty-directory?

I am not sure about this.  We used to show everything in a
directory full of untracked directory, which was distracting and
that was the reason we added --directory there.  Maybe it would
be less confusing if we just updated the message

	    print "#\n# Untracked files:\n";
	    print "#   (use \"git add\" to add to commit)\n";
	    print "#\n";

to say "use 'git add' on these files and files in these
directories you wish to add", or something silly like that,
without this patch?
