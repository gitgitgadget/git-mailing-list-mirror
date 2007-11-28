From: Jeff King <peff@peff.net>
Subject: Re: Rollback of git commands
Date: Wed, 28 Nov 2007 11:28:32 -0500
Message-ID: <20071128162832.GA890@coredump.intra.peff.net>
References: <9e4733910711271523p3be94010jac9c79e6b95f010d@mail.gmail.com> <7vmyszb39s.fsf@gitster.siamese.dyndns.org> <9e4733910711271733r6f280618pbb14095aebba3309@mail.gmail.com> <9e4733910711271749q1b96bfe9i60e43619c89234b9@mail.gmail.com> <3AAC5548-A9AC-4236-B1F7-5CFDE11B52C4@adacore.com> <20071128162002.GB20308@coredump.intra.peff.net> <9e4733910711280823q5fa14120scb6371a1465efca5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Geert Bosch <bosch@adacore.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 17:29:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxPmQ-0002Vg-BF
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 17:28:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759269AbXK1Q2f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 11:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759054AbXK1Q2f
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 11:28:35 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2957 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758816AbXK1Q2f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 11:28:35 -0500
Received: (qmail 11894 invoked by uid 111); 28 Nov 2007 16:28:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 28 Nov 2007 11:28:33 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Nov 2007 11:28:32 -0500
Content-Disposition: inline
In-Reply-To: <9e4733910711280823q5fa14120scb6371a1465efca5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66374>

On Wed, Nov 28, 2007 at 11:23:30AM -0500, Jon Smirl wrote:

> > Assuming that they also retain the "having an object implies having all
> > of the objects it points to" property, then it makes it hard to talk
> > about subsets or single refs. If I fetch from you and you communicate
> > your repo state as some hash, then I am stuck getting _all_ of your
> > refs to complete this property.
> 
> push/pull would still work at the branch level. The local state
> tracking objects wouldn't be exchanged.

Fair enough.

My spider sense still tingles about this, and I have the feeling that
you might run into weird merge problems when two refs are updated
simultaneously. I guess that shouldn't happen since you will write out
the complete "here are the refs" after every operation, leaving no room
for simultaneous updates, but I haven't given it enough thought to be
sure there aren't funny corner cases.

-Peff
