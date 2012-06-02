From: Jeff King <peff@peff.net>
Subject: Re: Bug: rebase when an author uses accents in name on MacOSx
Date: Sat, 2 Jun 2012 12:09:04 -0400
Message-ID: <20120602160904.GB15017@sigill.intra.peff.net>
References: <7vehq18c82.fsf@alter.siamese.dyndns.org>
 <20120531011911.GC5488@sigill.intra.peff.net>
 <7v62bc97w1.fsf@alter.siamese.dyndns.org>
 <78E7FEAC-6587-4EB3-B78B-08D321F53BF9@spotinfluence.com>
 <7vtxyw6ypx.fsf@alter.siamese.dyndns.org>
 <69ED148F-BD10-4DE3-91F2-D31F83A0EAB7@spotinfluence.com>
 <7vd35k6w0i.fsf@alter.siamese.dyndns.org>
 <168277BB-0E71-4987-A2BE-6202034A96F1@spotinfluence.com>
 <20120601093039.GD32340@sigill.intra.peff.net>
 <B0BB0BD8-EFB5-4A3C-A6F7-00A1C7DE0509@spotinfluence.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Lanny Ripple <lanny@spotinfluence.com>
X-From: git-owner@vger.kernel.org Sat Jun 02 18:09:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Saqtf-0007Ob-Br
	for gcvg-git-2@plane.gmane.org; Sat, 02 Jun 2012 18:09:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758119Ab2FBQJJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jun 2012 12:09:09 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:41131
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752751Ab2FBQJI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2012 12:09:08 -0400
Received: (qmail 13782 invoked by uid 107); 2 Jun 2012 16:09:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 02 Jun 2012 12:09:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 02 Jun 2012 12:09:04 -0400
Content-Disposition: inline
In-Reply-To: <B0BB0BD8-EFB5-4A3C-A6F7-00A1C7DE0509@spotinfluence.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199046>

On Fri, Jun 01, 2012 at 08:56:01AM -0500, Lanny Ripple wrote:

> I did show that sed was broken and have provided a minimal, reproducible test.
> 
> I have reported it to the sed maintainers and they are working on it.

Great. Do we know yet which versions are affected?

> A message or comment in the code that seds not properly handling utf8
> characters have been shown to be the cause of the problem and that git
> selects sed from the PATH would have been 100% effective in at least
> one case.  I don't know the troubleshooting skills of the other two
> people that bumped into the problem so can't comment.  Of the billions
> of people that have not (if it existed) looked at the breadcrumb and
> weren't led astray it's (would have) also been 100% effective.  Can
> you in turn posit any reasonable way that get_author_ident_from_commit
> would improperly build author-script short of a bad sed?  I guess you
> could pull out transient or systematic disk error.

I assume from bogus commit objects. But I admit I am just guessing, and
don't have data.

> You do, in fact, have several solutions.  I won't reiterate since they
> are in the thread earlier.  You also have in many cases the valid
> concern that the solutions would not be backwards compatible.  And
> yes, this sed will get fixed but what then?  The next person that gets
> a sed they don't expect earlier in their PATH will have to go through
> the same steps.

When I said:

> > But really, I'd rather just see the broken sed fixed. Where would the
> > breadcrumb lead people at this point, anyway? We don't actually have a
> > solution besides "uninstall this other, crappy sed". Has the sed bug
> > actually been fixed?

I meant that there is not a fix for the _user_ to perform at that point.
The point of a breadcrumb like that is that we are not going to put a
fix into git, so we want to at least give the user a clue that their
system has a problem. But what is their next step after being informed
that their system has a problem?

-Peff
