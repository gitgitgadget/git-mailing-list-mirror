From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Could this be done simpler?
Date: Thu, 25 Jun 2009 16:17:09 -0700
Message-ID: <7vljnfykcq.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.01.0906241426120.3154@localhost.localdomain>
	<7veit9m8cs.fsf@alter.siamese.dyndns.org>
	<200906260002.40531.chriscool@tuxfamily.org>
	<200906260023.03169.chriscool@tuxfamily.org>
	<7vprcsymjd.fsf@alter.siamese.dyndns.org>
	<alpine.LFD.2.01.0906251544030.3605@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jun 26 01:17:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJyC0-0004El-Fv
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 01:17:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756174AbZFYXRJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 19:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756417AbZFYXRI
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 19:17:08 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:58702 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756758AbZFYXRH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 19:17:07 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090625231710.GDCY18948.fed1rmmtao107.cox.net@fed1rmimpo03.cox.net>;
          Thu, 25 Jun 2009 19:17:10 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 8PH91c00K4aMwMQ04PH9QB; Thu, 25 Jun 2009 19:17:09 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=YjxVEfEYJ9cA:10 a=Z4Rwk6OoAAAA:8
 a=t4fgg1usrRpOzruv3IUA:9 a=vXBPYsphcpmtR5rNI0Ep2cg3X5kA:4 a=jbrJJM5MRmoA:10
X-CM-Score: 0.00
In-Reply-To: <alpine.LFD.2.01.0906251544030.3605@localhost.localdomain> (Linus Torvalds's message of "Thu\, 25 Jun 2009 15\:50\:19 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122259>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Sure, I suspect that being really clever about decomposing an octopus 
> merge might allow us to bisect things _faster_ to one of the branches 
> involved in the merge, but the amount of smarts to do that just for that 
> reason seems pretty outlandish.
>
> And if we ever do end up with an actual bug being bisected to the octopus 
> merge itself, at that point I don't think it's unreasonable to take the 
> same approach we do with any normal merge: just try to figure out what the 
> conflict is all about (clearly it's not a data conflict, since the 
> octopus wouldn't have succeeded in that case, but subtle merge errors can 
> be due to two branches each introducing their own assumptions without 
> actually ever clashing on a source file level).
>
> With regular merges, if you really don't see what the conceptual conflict 
> is, you could try to do a temporary rebase to try to figure it out, and I 
> suspect that that is what you'd want to do with an octopus merge too - 
> rather than try to decompose the octopus merge into multiple simpler 
> merges, you'd like to try to linearize history and then re-do the 
> bisection attempt on that totally modified/simplified history.

All true.

Thanks for thoughts.
