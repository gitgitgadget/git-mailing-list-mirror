From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git/spearce.git (topics)
Date: Tue, 23 Oct 2007 12:00:38 -0700
Message-ID: <7vtzoh7j1l.fsf@gitster.siamese.dyndns.org>
References: <20071023012140.GC22997@thunk.org>
	<7vtzoi8voo.fsf@gitster.siamese.dyndns.org>
	<20071023020044.GA27132@thunk.org>
	<20071023040522.GX14735@spearce.org>
	<20071023043321.GC27132@thunk.org>
	<20071023044657.GC14735@spearce.org>
	<20071023045632.GD27132@thunk.org>
	<20071023050726.GD14735@spearce.org>
	<20071023053003.GE27132@thunk.org>
	<20071023054238.GE14735@spearce.org>
	<20071023120338.GG27132@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue Oct 23 21:01:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkOzs-0005PL-6i
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 21:01:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752152AbXJWTAs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 15:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752209AbXJWTAs
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 15:00:48 -0400
Received: from rune.pobox.com ([208.210.124.79]:42641 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752152AbXJWTAr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 15:00:47 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 44CB714E8B9;
	Tue, 23 Oct 2007 15:01:08 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id E84F614EAC1;
	Tue, 23 Oct 2007 15:01:02 -0400 (EDT)
In-Reply-To: <20071023120338.GG27132@thunk.org> (Theodore Tso's message of
	"Tue, 23 Oct 2007 08:03:38 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62148>

Theodore Tso <tytso@mit.edu> writes:

> With git.git, we are essentially throwing away development history
> while it is in 'pu', but once a commit graduates to 'next', we do keep
> the development history forever.  The downside to this is that
> development 'crud' can build up in next; even if all substantive
> commits in 'next' end up graduating to 'master', there will still be
> lots of merge commits that will only be in 'next'.   
>
> I have an emotional bias which tends to treat that excess history as
> toxic waste to be avoided at all costs, but that's probably because
> when you have a git tree as huge as the kernel, life is easier if the
> history is kept as clean as possible.  
>
> Which I suppose is easy enough to do in the git.git model; if you
> throw away the 'next' branch and then rewind it so it is forked off of
> 'master' all of that history essentially gets flushed.

You can view 'next' as if it is sort of -mm.  Following 'master'
is like following Linus tree, whose development is without those
numerous 'merge improvements again' merges into 'next'.

> The downside
> is that people maintaining topics branches which were forked against
> the old 'next' will need to do some grotty work to rebase their
> patches, so any attempt to rewind next would probably require the
> central maintainer to give plenty of notice, and then on the flag day,
> save 'next' as 'old-next' before rewinding to allow the other
> developers to more easily rebase any private branches they might have.

An alternative is to give an easier access to the tips of
individual topic branch head, at least to the ones that have
been merged to 'next' as they will never be rewound once they
are in 'next', and encourage people to fork off of them, instead
of 'next' directly.  Then 'next' will be more like 'pu'.

> Hmm, interesting.  A lot of this is quite subtle, or at least the
> impacts of different choices in the git workflow really didn't become
> obvious to me until I started trying I stepped into the central
> maintainer role for a project using git!

Very true.
