From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] t/t3308-notes-merge.sh: succeed with relaxed
 notes refs
Date: Thu, 8 Jan 2015 05:31:58 -0500
Message-ID: <20150108103158.GB4806@peff.net>
References: <d4509363c8f670483dacdd2a5070f5a@74d39fa044aa309eaea14b9f57fe79c>
 <e514c72c481c66f9808f1dd09117a16@74d39fa044aa309eaea14b9f57fe79c>
 <xmqq8uhgqkge.fsf@gitster.dls.corp.google.com>
 <20150107011958.GA3536@peff.net>
 <xmqqiogilgr5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Kyle J. McKay" <mackyle@gmail.com>,
	Git mailing list <git@vger.kernel.org>,
	Scott Chacon <schacon@gmail.com>,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 08 11:33:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9ANr-0007N0-0t
	for gcvg-git-2@plane.gmane.org; Thu, 08 Jan 2015 11:32:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755830AbbAHKcB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2015 05:32:01 -0500
Received: from cloud.peff.net ([50.56.180.127]:60314 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753100AbbAHKcA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2015 05:32:00 -0500
Received: (qmail 22395 invoked by uid 102); 8 Jan 2015 10:32:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 08 Jan 2015 04:32:01 -0600
Received: (qmail 26988 invoked by uid 107); 8 Jan 2015 10:32:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 08 Jan 2015 05:32:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Jan 2015 05:31:58 -0500
Content-Disposition: inline
In-Reply-To: <xmqqiogilgr5.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262190>

On Wed, Jan 07, 2015 at 08:03:58AM -0800, Junio C Hamano wrote:

> > But we are talking about
> > somebody who is already fully-qualifying a ref (and anything unqualified
> > continues to get looked up under refs/notes).
> 
> That (specifically 'merge') is not my real worry.  It's the other
> way around, actually.
> 
> Because expand_notes_ref() makes sure that any given notes ref is
> prefixed appropriately to start with refs/notes/,
> 
>     git notes --ref=refs/heads/master add ...blah...
>     git notes --ref=refs/tag/v1.0 add ...blah...
> 
> would be a sensible way when somebody wants to keep a forest of
> notes refs, one per real ref.  Wouldn't they have already been
> trained to spell "refs/heads/master" when they want to refer to
> refs/notes/refs/heads/master because of this?

Thanks, that is a more interesting case, and I agree that moving to
allowing fully-qualified refs would technically be a regression.  I'm
still slightly doubtful that this is something people do in practice,
but I guess we have no way to know for sure.

-Peff
