From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] diff-delta: bound hash list length to avoid O(m*n) behavior
Date: Fri, 03 Mar 2006 18:39:37 -0800
Message-ID: <7vbqwnx79y.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602272110320.25336@localhost.localdomain>
	<7vhd6kq8lc.fsf@assigned-by-dhcp.cox.net>
	<7vbqwrq4yi.fsf@assigned-by-dhcp.cox.net>
	<7vfylzx7t3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 04 03:40:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFMgT-00050f-Q0
	for gcvg-git@gmane.org; Sat, 04 Mar 2006 03:39:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbWCDCjj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Mar 2006 21:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbWCDCjj
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Mar 2006 21:39:39 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:31631 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751274AbWCDCjj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Mar 2006 21:39:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060304023635.LGAZ26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 3 Mar 2006 21:36:35 -0500
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <7vfylzx7t3.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 03 Mar 2006 18:28:08 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17166>

Junio C Hamano <junkio@cox.net> writes:

> 	The first round.  The set of objects packed were from
> today's Linus tip (everything down to epoch v2.6.12-rc2), 193309
> objects in total, on my Duron 750 with slow disks.
>
> 	  real		user		sys		bytes		savings
> master  11m17.121s	10m23.280s	0m47.290s       109045599	N/A
> nico	  25m37.058s	23m0.770s       2m20.460s	104401392	4.25%
> jc	  24m12.072s	21m45.120s	2m16.400s	104409761	4.25%

Minor correction in numbers.  The size for nico and jc are
swapped.  jc variant created the smallest pack in this
experiment.

Which puzzles me even more...
