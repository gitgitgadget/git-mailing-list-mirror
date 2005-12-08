From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Clean up file descriptors when calling hooks.
Date: Wed, 07 Dec 2005 18:25:12 -0800
Message-ID: <7vvey0mik7.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0512072052560.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 08 03:26:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkBTP-0002jh-2u
	for gcvg-git@gmane.org; Thu, 08 Dec 2005 03:25:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932634AbVLHCZQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Dec 2005 21:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932641AbVLHCZQ
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Dec 2005 21:25:16 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:61105 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932634AbVLHCZP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2005 21:25:15 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051208022359.MKPV17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 7 Dec 2005 21:23:59 -0500
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0512072052560.25300@iabervon.org> (Daniel
	Barkalow's message of "Wed, 7 Dec 2005 21:04:38 -0500 (EST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13354>

Daniel Barkalow <barkalow@iabervon.org> writes:

> When calling post-update hook, don't leave stdin and stdout connected to 
> the pushing connection.

A quick question.  I understand "not connected to the pushing
connection" is desirable, but is there a reason you chose to
leave them open to /dev/null, not close()d?
