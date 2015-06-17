From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: co-authoring commits
Date: Wed, 17 Jun 2015 18:52:24 -0400
Message-ID: <20150617225224.GF4076@thunk.org>
References: <CAOvwQ4i_HL7XGnxZrVu3oSnsbnTyxbg8Vh6vzi4c1isSrrexYQ@mail.gmail.com>
 <xmqq4mm66r99.fsf@gitster.dls.corp.google.com>
 <CAOvwQ4j2bjR1jnLVyZbw1OCE=xQxbCEFGKcK1bpuv1K3s_Y2EQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Josh Triplett <josh@joshtriplett.org>
To: Tuncer Ayaz <tuncer.ayaz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 00:52:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5MCE-0002XA-Kl
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 00:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755015AbbFQWwc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 18:52:32 -0400
Received: from imap.thunk.org ([74.207.234.97]:41293 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754999AbbFQWwa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 18:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org; s=ef5046eb;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=ZNgnqev85wr2bJ9lQBCm4FiR+Mntz+MwwEu00ny9tUA=;
	b=prO7wq6JXOU/Fd2b0rVvxS9GNaQSQsiBLMe+vYcR4JKeMeMT9c4TAI7NFw0Fm827kUWS9P1y+SmhIJeA/igG3xm/9LYkh05EpKtAKeQzVsrVt86T3kjOMwY8ZmSfg+E1ZBPU4PmoFXLsDgG0a1qJqxIiT/oWv/G154IlGfHqLjA=;
Received: from root (helo=closure.thunk.org)
	by imap.thunk.org with local-esmtp (Exim 4.84)
	(envelope-from <tytso@thunk.org>)
	id 1Z5MC2-0004Mf-Ls; Wed, 17 Jun 2015 22:52:26 +0000
Received: by closure.thunk.org (Postfix, from userid 15806)
	id DD7B458404B; Wed, 17 Jun 2015 18:52:24 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CAOvwQ4j2bjR1jnLVyZbw1OCE=xQxbCEFGKcK1bpuv1K3s_Y2EQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271926>

On Wed, Jun 17, 2015 at 10:26:32PM +0200, Tuncer Ayaz wrote:
> 
> By allowing multiple authors, you don't have to decide who's the
> primary author, as in such situations usually there is no primary at
> all. I sometimes deliberately override the author when committing and
> add myself just as another co-author in the commit message, but as
> others have noted it would be really great if we can just specify
> multiple authors.

Just recently, there a major thread on the IETF mailing list where
IETF working group had drafts where people were listed as co-authors
without their permission, and were upset that the fact that their name
was added made it seem as if they agreed with the end product.  (i.e.,
that they were endorsing the I-D).  So while adding formal coauthor
might solves (a few) problems, it can also introduce others.

Ultimately there is one person who can decide which parts of the
changes to put in the commit that gets sent to the maintainer.  So
there *is* someone who is the primary author; the person who takes the
final pass on the patch and then hits the send key.

One could imagine some frankly, quite rare example where there is a
team of people who votes on each commit before it gets sent out and
where everyone is equal and there is no hierarchy.  In that case,
perhaps you could set the from field to a mailing list address.  But
honestly, how often is that *all* of the authors are completely
equal[1]?

In my personal practice, if I make significant changes to a patch, I
will indeed simply change the submitter, and then give credit the
original author.  This is the case where I'm essentially saying, "Bob
did a lot of work, but I made a bunch of changes, so if things break
horribly, blame *me*, not Bob".

Alternatively, if I just need to make a few cosmetic changes to
Alice's patch (i.e., fix white spaces, correct spelling, change the
commit description so it's validly parsable and understandable
English, etc.), I'll just add a comment in square brackets indicating
what changes I made before I committed the change.  This seems to work
just fine, and I don't think we should try to fix something that isn't
broken.

						- Ted


[1]  Gilbert and Sullivan attacked this notion is a commedic way in
"The Gondoliers"; especially in the songs "Replying we sing as one
individual" and "There Lived a King":

	     https://www.youtube.com/watch?v=YD0dgXTQ3K0
	     https://www.youtube.com/watch?v=oSaVdqcDgZc
