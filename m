From: Junio C Hamano <junkio@cox.net>
Subject: Re: Unresolved issues #2 (shallow clone again)
Date: Sun, 07 May 2006 19:54:09 -0700
Message-ID: <7vy7xdgram.fsf@assigned-by-dhcp.cox.net>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net>
	<7v4q065hq0.fsf@assigned-by-dhcp.cox.net>
	<87mzdx7mh9.wl%cworth@cworth.org>
	<7v1wv92u7o.fsf@assigned-by-dhcp.cox.net> <e3ksoq$is$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 08 04:54:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fcvt2-0008Po-Bk
	for gcvg-git@gmane.org; Mon, 08 May 2006 04:54:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbWEHCyM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 22:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932266AbWEHCyM
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 22:54:12 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:48334 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932264AbWEHCyL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 May 2006 22:54:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060508025410.NZCP9215.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 7 May 2006 22:54:10 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e3ksoq$is$1@sea.gmane.org> (Jakub Narebski's message of "Sun, 07
	May 2006 15:30:15 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19756>

Jakub Narebski <jnareb@gmail.com> writes:

> Wouldn't it be easier (sorry, no code yet) to have the following:
>
>         I WANT to have these
>         I HAVE these
>         These are GRAFT PARENTLESS        
>
> with the target side sending list of all parentless commits in the
> ... The source side will then do the grafting 'in memory' and
> send the packs like normal, only with those cauterizing grafts in place.

I think that is essentially the outline of shallow clone
proposal, except that you have to be careful and take not just
"parentless" but other grafts (e.g. one that removes one parent
from a merge commit to pretend that a side branch did not exist)
into account as well.  I do not remember if I already coded it
or not -- I might have.
