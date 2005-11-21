From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix git.c compilation target
Date: Mon, 21 Nov 2005 15:01:39 -0800
Message-ID: <7vlkzhmwq4.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0511210010m66a3f898q6d108a799de023d9@mail.gmail.com>
	<81b0412b0511210124u5cc0d4efv2045123d92872c66@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 22 00:05:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeKfR-0006XI-KB
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 00:01:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbVKUXBm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 18:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbVKUXBl
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 18:01:41 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:16115 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751216AbVKUXBl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 18:01:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051121230104.NJUY6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 21 Nov 2005 18:01:04 -0500
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0511210124u5cc0d4efv2045123d92872c66@mail.gmail.com>
	(Alex Riesen's message of "Mon, 21 Nov 2005 10:24:17 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12500>

Alex Riesen <raa.lkml@gmail.com> writes:

> There was more to it.
> The patch removes a reference to git.sh from Makefile and installs
> _all_ programs and scripts.
>

Thanks; the filter-out should go, but I am wondering if it makes
more sense to:

 - make git$(X) part of PROGRAMS (probably it is a
   SIMPLE_PROGRAM that does not link with many extra stuff, or a
   class on its own);

 - have "install" target depend on "all".
