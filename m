From: Junio C Hamano <junkio@cox.net>
Subject: Re: 2 questions/nits about commit and config
Date: Sat, 04 Feb 2006 21:58:50 -0800
Message-ID: <7vek2imjmt.fsf@assigned-by-dhcp.cox.net>
References: <20060204212337.GA8612@blinkenlights.visv.net>
	<7voe1mvkls.fsf@assigned-by-dhcp.cox.net>
	<7vhd7evk38.fsf@assigned-by-dhcp.cox.net>
	<1139094055.4200.6.camel@evo.keithp.com>
	<7vu0bemkce.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Feb 05 06:59:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5cvW-0003CF-SP
	for gcvg-git@gmane.org; Sun, 05 Feb 2006 06:59:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030274AbWBEF6x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Feb 2006 00:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964906AbWBEF6x
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Feb 2006 00:58:53 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:30858 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S964903AbWBEF6w (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2006 00:58:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060205055635.MMGT17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 5 Feb 2006 00:56:35 -0500
To: git@vger.kernel.org
In-Reply-To: <7vu0bemkce.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 04 Feb 2006 21:43:29 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15623>

Junio C Hamano <junkio@cox.net> writes:

> Here is me thinking aloud again.

Before I started writing this message, I meant to address an
excellent point Carl Worth raised in an earlier thread.  "What
would I do for final sanity check before committing?".  So here
is a follow-up.

>  - "git commit"

"git diff --cached HEAD".

>  - "git commit --include paths..." (or "git commit -i paths...")

This is for people who work by taking advantage of the power of
the index file, i.e. perform "checking in without committing" by
running update-index whenever the changes so-far look good.
Combined use of "git diff --cached HEAD" (to look at diffs for
paths other than paths...) and "git diff HEAD paths..." would be
the _full_ "final sanity check", but in practice "git diff HEAD
paths..." or even "git diff paths..." would be more useful for
these people.  They've verified the changes so-far were sane
when they did update-index already.

>  - "git commit paths..." acquires a new semantics.  This is an
>    incompatible change that needs user training, which I am
>    still a bit reluctant to swallow, but enough people seem to
>    have complained.

"git diff HEAD paths...".
