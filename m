From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] Documentation: new upstream rebase recovery section
 in git-rebase
Date: Tue, 02 Sep 2008 14:39:28 -0700
Message-ID: <7vvdxei5wv.fsf@gitster.siamese.dyndns.org>
References: <1220386721-10215-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Sep 02 23:40:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kadc9-0004QX-Jt
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 23:40:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751695AbYIBVjf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 17:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752241AbYIBVje
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 17:39:34 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42058 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677AbYIBVje (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 17:39:34 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7195F5AC05;
	Tue,  2 Sep 2008 17:39:33 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1E7475AC04; Tue,  2 Sep 2008 17:39:29 -0400 (EDT)
In-Reply-To: <1220386721-10215-1-git-send-email-trast@student.ethz.ch>
 (Thomas Rast's message of "Tue, 2 Sep 2008 22:18:41 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A1BAD8B8-7937-11DD-992D-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94718>

Thomas Rast <trast@student.ethz.ch> writes:

> I flagged it as RFC because I'd appreciate some feedback:
>
> - Are the warnings too repetitive?  I fear that if we sound too
>   protective, users won't listen.
>
> - Is it perhaps too verbose, or in the wrong place?  I did not want to
>   detract from the feature descriptions that the manpage should first
>   and foremost contain.  Chances that a user will "accidentally" read
>   the section at this position and length seem fairly low however.

It feels on a bit too repetitive side, but I think this is going in the
right direction.  How about dropping the earlier part of the change to
Notes section (but keep "See also" which is a good guide for understanding
the said "implications")?

> +HELP, MY UPSTREAM HAS REBASED!
> +------------------------------

I read this section only once, but it looked reasonable as a recovery
procedure to me.

The additions you made are all about why rebasing public history is bad
from mechanisms (overlapping changes made by old upstream history and new
upstream history, unless they are identical, will cause merge conflicts
between themselves that downstream will have hard time resolving) POV.
While that description is all good, I think there should also be a
discussion from the patchflow/workflow angle.

"Upstream has rebased" almost implies that it has its own upstream
(i.e. "My upstream" is not the toplevel upstream, but is a subsystem tree
or something).

Rebasing upstream is bad, but an upstream that backmerges from its own
upstream too often is equally bad, and the reason of the badness, viewed
from the workflow angle, shares exactly the same component.

It means that the mid-level upstream in question is not focused enough.

Cf.

    http://article.gmane.org/gmane.linux.kernel/681763
    http://article.gmane.org/gmane.linux.kernel/684030
    http://article.gmane.org/gmane.linux.kernel/684073
    http://article.gmane.org/gmane.linux.kernel/684091
    http://article.gmane.org/gmane.linux.kernel/638511
