From: Jeff King <peff@peff.net>
Subject: Re: remote#branch
Date: Tue, 30 Oct 2007 21:43:47 -0400
Message-ID: <20071031014347.GB23274@coredump.intra.peff.net>
References: <Pine.LNX.4.64.0710280000240.4362@racer.site> <20071029174000.GA4449@efreet.light.src> <alpine.LFD.0.999.0710291112590.30120@woody.linux-foundation.org> <20071029214925.GH21133@thunk.org> <alpine.LFD.0.999.0710291545250.30120@woody.linux-foundation.org> <20071030030104.GK21133@thunk.org> <7vtzo9s221.fsf@gitster.siamese.dyndns.org> <20071030044026.GA9600@thunk.org> <alpine.LFD.0.999.0710292150400.30120@woody.linux-foundation.org> <46a038f90710301741n67526976vda1cd131270aa7f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Theodore Tso <tytso@mit.edu>,
	Junio C Hamano <gitster@pobox.com>, Jan Hudec <bulb@ucw.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Petr Baudis <pasky@suse.cz>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 02:44:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1In2cm-0008Kk-4j
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 02:44:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752194AbXJaBnu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 21:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752110AbXJaBnu
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 21:43:50 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4844 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751944AbXJaBnt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 21:43:49 -0400
Received: (qmail 6464 invoked by uid 111); 31 Oct 2007 01:43:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 30 Oct 2007 21:43:48 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Oct 2007 21:43:47 -0400
Content-Disposition: inline
In-Reply-To: <46a038f90710301741n67526976vda1cd131270aa7f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62774>

On Wed, Oct 31, 2007 at 01:41:12PM +1300, Martin Langhoff wrote:

> Having something functionally similar to
> 
>   cg-clone git://foo.tld/bar.git#blue
> 
> would save a few steps -- and some potential confusion -- for projects
> using GIT.
> 
> In case it's not clear what it does (not everyone here has used
> cogito) it will create and checkout a branch tracking the "blue" head
> on the repo when the clone is done. This is _instead of_ creating and
> checking out the branch that tracks the configured "HEAD" of the repo.

Actually, IIRC it won't fetch any of the non 'blue' refs.

Anyway, to recap (my impression of) the discussion leading up to this:
  - the cogito feature is useful
  - the cogito syntax does not allow for multiple branches to be
    specified
  - one such syntax proposed was git://foo.tld/bar.git#blue,red
  - one problem with that syntax is that comma is a valid character
    in the branch name, and '#' is a valid character in the repo name
  - one proposed solution was that '#' and ',' when used as data should
    be URL-encoded
  - flamefest begin

So I think nobody disagrees that such a feature is useful; there is
disagreement about the syntax.

-Peff
