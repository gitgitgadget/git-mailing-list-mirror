From: Junio C Hamano <junkio@cox.net>
Subject: Re: make gitfakemmap standalone to fix linking error in git.c
Date: Mon, 05 Dec 2005 09:40:21 -0800
Message-ID: <7vfyp7cuii.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0512050519k5ed80035x9eb4907f569e0a4b@mail.gmail.com>
	<81b0412b0512050524w7b632651n93c836fda41a39d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 05 18:43:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjKKG-0005F0-6z
	for gcvg-git@gmane.org; Mon, 05 Dec 2005 18:40:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488AbVLERkX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Dec 2005 12:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932487AbVLERkX
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Dec 2005 12:40:23 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:55006 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932484AbVLERkW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Dec 2005 12:40:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051205173946.QXZB15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 5 Dec 2005 12:39:46 -0500
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0512050524w7b632651n93c836fda41a39d@mail.gmail.com>
	(Alex Riesen's message of "Mon, 5 Dec 2005 14:24:47 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13218>

Alex Riesen <raa.lkml@gmail.com> writes:

> Why does it always happen...

Because you touched you did not absolutely have to ;-).

When I took setenv patch for git.c, I was thinking about
something similar.  It may be cleaner to split out the pieces so
that the functions like usage(), die(), xmalloc() and friends
could be linkable in git.c and others that want to link in only
the minimum set without including "cache.h" which has more
intimate knowledge of other git internals.
