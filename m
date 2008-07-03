From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: RFC: grafts generalised
Date: Thu, 3 Jul 2008 09:11:43 +0200
Message-ID: <20080703071143.GC27419@cuci.nl>
References: <20080702143519.GA8391@cuci.nl> <m3lk0kfdo1.fsf@localhost.localdomain> <20080702173203.GA16235@cuci.nl> <20080703002117.GH12567@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Jul 03 10:28:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEKAL-0002yW-Oc
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 10:27:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756628AbYGCIVA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 04:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755547AbYGCITR
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 04:19:17 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:43901 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934978AbYGCHLs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 03:11:48 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id A08465466; Thu,  3 Jul 2008 09:11:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080703002117.GH12567@machine.or.cz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87261>

Petr Baudis wrote:
>On Wed, Jul 02, 2008 at 07:32:03PM +0200, Stephen R. van den Berg wrote:
>> Also, the graft mechanism specifically is intended as a temporary
>> solution until one uses filter-branch to "finalise" the result into a
>> proper repository which becomes cloneable.

>Grafts are _much_ older than filter-branch and I'm not sure where did
>you get this idea; do we claim that in any documentation?

Not in direct documentation, but it is what breaths down from posts on
the mailinglist like:

http://kerneltrap.org/mailarchive/git/2008/6/10/2085624

Jakub Narebski:
>Then if possible use git-filter-branch to make history recorded in
>grafts file permanent...

Petr Baudis wrote:
>There's nothing ugly or necessarily temporary about grafts. One example
>of completely valid usage is adding previous history of a project to it
>later.

>First, you don't need to carry around all the archived baggage you are
>probably rarely going to access anyway if you don't need to; changing a
>VCS is ideal cutoff point.

That depends on the project, of course, and is not a valid statement in
general.  Part of the charm of full history is that git-blame and
git-bisect work, at arbitrary points in the past.

>Second, you don't need to worry about doing perfect conversion at the
>moment of the switch.

Well, you do, if you intend to make it cloneable.

>Third, even if you think you have done it perfectly, it will turn out
>later that something is wrong anyway.

Not necessarily.  I have automated the checkout-verification-process which
basically checks out every revision from the respective old repository
and binary-compares it with the corresponding revision in the git
repository.  This ensures a full binary match across the board.
With respect to historical merges, I agree, those might not be
completely correctly grafted, but the level of correctness can be
determined at will, and once we achieve somewhere around 99% accuracy,
we consider it done (for this project).

>Fourth, it may not be actually _clear_ what the canonical history should
>be.

That depends on the project.  In my project it *is* clear, so this point
doesn't make any difference.

-- 
Sincerely,
           Stephen R. van den Berg.

This is a day for firm decisions!  Or is it?
