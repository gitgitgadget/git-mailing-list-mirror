From: Junio C Hamano <junkio@cox.net>
Subject: Re: fix potential deadlock in create_one_file
Date: Fri, 06 Jan 2006 14:38:13 -0800
Message-ID: <7vpsn5q8x6.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0601050100v519e76c8u11f4d484f9d28e0a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 06 23:39:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ev0EY-0007m3-3H
	for gcvg-git@gmane.org; Fri, 06 Jan 2006 23:38:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964869AbWAFWiS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jan 2006 17:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbWAFWiR
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jan 2006 17:38:17 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:59524 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S964869AbWAFWiP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2006 17:38:15 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060106223704.SCOH20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 6 Jan 2006 17:37:04 -0500
To: Alex Riesen <raa.lkml@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14224>

Alex Riesen <raa.lkml@gmail.com> writes:

> It can happen if the temporary file already exists (i.e. after a panic
> and reboot).

We use pid here and using somebody else's pid feels wrong but
that is only for collision avoidance, mktemp(3) is no better,
and neither tmpfile(3) nor mkstemp(3) are usable for directories
anyway, so your patch as is would be the best solution.

Thanks.
