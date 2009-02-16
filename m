From: Jeff King <peff@peff.net>
Subject: Re: disallowing push to currently checked-out branch
Date: Mon, 16 Feb 2009 00:06:08 -0500
Message-ID: <20090216050608.GA13181@coredump.intra.peff.net>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org> <20090215232013.GA11543@zakalwe.fi> <20090216000443.GB3503@coredump.intra.peff.net> <alpine.DEB.1.10.0902151727330.14911@asgard.lang.hm> <20090216035027.GA12689@coredump.intra.peff.net> <alpine.DEB.1.10.0902152057500.14911@asgard.lang.hm> <20090216040529.GC12689@coredump.intra.peff.net> <alpine.DEB.1.10.0902152113380.14911@asgard.lang.hm> <20090216043708.GB12986@coredump.intra.peff.net> <alpine.DEB.1.10.0902152143430.14911@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Heikki Orsila <shdl@zakalwe.fi>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Mon Feb 16 06:08:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYviN-0007Vo-Tw
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 06:08:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbZBPFGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 00:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751022AbZBPFGL
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 00:06:11 -0500
Received: from peff.net ([208.65.91.99]:45537 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750938AbZBPFGK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 00:06:10 -0500
Received: (qmail 13393 invoked by uid 107); 16 Feb 2009 05:06:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 16 Feb 2009 00:06:29 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Feb 2009 00:06:08 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.0902152143430.14911@asgard.lang.hm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110138>

On Sun, Feb 15, 2009 at 09:55:24PM -0800, david@lang.hm wrote:

> two cycles of changes, not three, so 6-10 years for changes that break  
> existing bahavior without a _really_ pressing reason. so new functions,  
> new commands, new flags don't have to wait at all. it's only if you want  
> to change something that will cause grief for users if they get a new  
> version and run their existing tools against it.

I think you have to think about _how much_ grief it will cause, too.

Yes, some git enhancements are purely new functions and features that
will not affect anyone who does not opt into them.  But many
enhancements cover cases that _must_ change behavior. Even bugfixes fall
into this category. Who is to say somebody is not relying on the buggy
behavior? So there must be some discretion for the maintainer to say
"Anyone relying on this behavior is probably crazy".

And so there is some degree of cost-benefit. How much pain will this
cause versus how much good will it do?

> I am not interested in forking git. but I am saying that a backwards  
> incompatible change had better _really_ be worth it, and not just be worth 
> it for the people who live an breath git, but for the users as well (this  
> is a test that the dashed name elimination failed. in spite of a volcal  
> few saying that all the commands in the path were causing problems, most  
> people couldn't understand why the git people wanted to remove them)

Have you read the related threads in the archive?  I think there is a
significant sentiment that this change _is_ really worth it. The current
behavior is hurting new users. I think the general consensus is that the
default should change; the question is how and when.

The dashed-names change didn't go so well. You can argue whether or not
it was a good change in the first place, but that is beside the point.
The lesson to be learned there is that _how_ it was done could have been
better. One of the things we are trying differently is having the
warning. Another is that Junio is putting together a contact list for
major projects using git. If you have a suggestion for another
technique, I'm sure people will be open to it.

And as I said, I don't think a timetable has been set. But I would be
surprised if it ends up in the 6-10 year range.

-Peff
