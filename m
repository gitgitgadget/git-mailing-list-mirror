From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] perl/Git.pm: add parse_rev method
Date: Fri, 30 May 2008 23:49:28 +0200
Message-ID: <20080530214928.GK593@machine.or.cz>
References: <20080530095047.GD18781@machine.or.cz> <1212179270-26170-1-git-send-email-LeWiemann@gmail.com> <20080530210531.GH18781@machine.or.cz> <7vd4n3iivt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 30 23:50:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2CUS-0003In-1F
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 23:50:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754558AbYE3Vtc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 17:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754354AbYE3Vtb
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 17:49:31 -0400
Received: from w241.dkm.cz ([62.24.88.241]:38572 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754170AbYE3Vta (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 17:49:30 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id A20901E4C030; Fri, 30 May 2008 23:49:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vd4n3iivt.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83345>

On Fri, May 30, 2008 at 02:25:58PM -0700, Junio C Hamano wrote:
> Perhaps, but except for the use of nonstandard try...catch.  I have been
> wondering if we can move away from it, with the goal of eventually getting
> rid of the construct altogether.

It's consistent with the rest of the code; we may want to remove it,
but we should either do it everywhere or not at all and I think it's
an issue independent on this patch.

> Didn't we hear from Randal that the construct is known to be leaky?

I agree that in hindsight, using this construct was probably not the
best idea, and I'm in principle not against removing it as long as there
is no functionality lost - the ability to let the program just fail
if I don't care in my code, or catch specifically for nonzero exit codes
and let the program fail in other cases, is very useful and I do use it
in some of my code; I would hate to lose this flexibility.

If there is an alternative (perhaps even slightly more clumsy) way to
solve this, I have no problem with switching over; however, I don't have
much time or interest to research this myself. If Lea wants to figure
something out, she (*) is welcome as far as I'm concerned.


(*) Lea, I hope I figured this out right - sorry if not. :-)

-- 
				Petr "Pasky" Baudis
Whatever you can do, or dream you can, begin it.
Boldness has genius, power, and magic in it.	-- J. W. von Goethe
