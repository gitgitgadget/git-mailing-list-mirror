From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Cache negative delta pairs
Date: Thu, 29 Jun 2006 14:54:54 -0700
Message-ID: <7v1wt7pqz5.fsf@assigned-by-dhcp.cox.net>
References: <20060628223744.GA24421@coredump.intra.peff.net>
	<7v4py4y7wo.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0606291053280.1213@localhost.localdomain>
	<20060629180011.GA4392@coredump.intra.peff.net>
	<Pine.LNX.4.64.0606291410420.1213@localhost.localdomain>
	<20060629185335.GA6704@coredump.intra.peff.net>
	<Pine.LNX.4.64.0606291458110.1213@localhost.localdomain>
	<20060629195201.GA10786@coredump.intra.peff.net>
	<Pine.LNX.4.64.0606291616480.1213@localhost.localdomain>
	<Pine.LNX.4.64.0606291352110.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 29 23:56:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw4Uy-0003dq-Em
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 23:56:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932899AbWF2V4A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 17:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932972AbWF2VzJ
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 17:55:09 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:42695 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932968AbWF2Vy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 17:54:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060629215455.CZFU12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 29 Jun 2006 17:54:55 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606291352110.12404@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 29 Jun 2006 14:04:01 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22915>

Linus Torvalds <torvalds@osdl.org> writes:

> Instead of having a separate cache, wouldn't it be much better to just 
> take the hint from the previous pack-file?
>
> In the repacking window, if both objects we are looking at already came 
> from the same (old) pack-file, don't bother delta'ing them against each 
> other. 
>
> That means that we'll still always check for better deltas for (and 
> against!) _unpacked_ objects, but assuming incremental repacks, you'll 
> avoid the delta creation 99% of the time.

I bow down before you.

No ugly special-case caching, just automatically "the right
thing", with very little overhead.

It just makes sense.

We have a winner.

;-)
