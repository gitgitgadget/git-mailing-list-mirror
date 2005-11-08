From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-pull.sh's bad mode
Date: Tue, 08 Nov 2005 11:30:10 -0800
Message-ID: <7vhdaney4d.fsf@assigned-by-dhcp.cox.net>
References: <E1EZUK2-0005EG-56@jdl.com>
	<7v4q6njecr.fsf@assigned-by-dhcp.cox.net>
	<20051108163546.GC1431@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Loeliger <jdl@freescale.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 08 20:33:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZZAg-00030E-4E
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 20:30:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965280AbVKHTaO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 14:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965284AbVKHTaO
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 14:30:14 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:24996 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S965280AbVKHTaM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2005 14:30:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051108192947.KTR4527.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 8 Nov 2005 14:29:47 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051108163546.GC1431@pasky.or.cz> (Petr Baudis's message of
	"Tue, 8 Nov 2005 17:35:46 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11351>

Petr Baudis <pasky@suse.cz> writes:

>> Makefile installs git-pull with executable bit set anyway, so it
>> really does not matter.
>
> But it should definitely be fixed. E.g. I actually personally use (for
> Cogito development) git-core which I never make install (I have
> system-wide git-core installation which is just whatever is the latest
> version Gentoo ships, and I use that for non-Cogito development).
> It would be painful if this mode of usage wouldn't be supported.

You could perhaps do "make" without install and set PATH to
include the source directory (you need to do a bit more if we
ever update templates/ directory and you would want to try it). 

The point is that git-pull was generated with +x from
git-pull.sh, and the mode bits of git-pull.sh (source) does not
matter anymore.  It used to matter back when we called them
git-*-script but not these days.
