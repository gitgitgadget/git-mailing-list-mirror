From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 0/3] --seed as an alias for --dissociate --reference
Date: Thu, 21 May 2015 01:06:45 -0400
Message-ID: <20150521050645.GA27478@peff.net>
References: <20150521041435.GA18978@peff.net>
 <xmqqmw0yle0y.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 21 07:06:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvIh2-0003qe-NI
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 07:06:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbbEUFGs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 01:06:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:33754 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751186AbbEUFGr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 01:06:47 -0400
Received: (qmail 3698 invoked by uid 102); 21 May 2015 05:06:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 21 May 2015 00:06:47 -0500
Received: (qmail 31802 invoked by uid 107); 21 May 2015 05:06:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 21 May 2015 01:06:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 May 2015 01:06:45 -0400
Content-Disposition: inline
In-Reply-To: <xmqqmw0yle0y.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269559>

On Wed, May 20, 2015 at 10:01:49PM -0700, Junio C Hamano wrote:

> >   1. Assuming that "seed" is a reasonable verb for this concept, is
> >      "--seed=<repo>" OK for the option?  Would "--seed-from=<repo>" be
> >      better? (Also, the response "bleh, seed is a terrible name" is
> >      fine, too, but only if accompanied by your own suggestion :) ).
> 
> The seed may not even have to be a repository.  A bundle file hosted
> on CDN that is reachable via (resumable) wget would be another good
> way to prime the well, and it would fit with the above framework
> nicely.  Grab it, fetch from it into a temporary hierarchy and then
> run "fetch --prune" against the repository you originally wanted to
> clone from.

Yeah, I was just looking over the list archives for the past few months,
for things I had marked as "to read and think about later"[1]. That's
how I recalled our prior discussion on --dissociate.

Anyway, I happened upon the "prime the clone from a bundle" concept
being discussed again recently, and had the same thought. We already
treat local bundles as a possible source for fetching/cloning. Once upon
a time I had some patches that would let you clone straight from a
bundle over http (it just spooled to disk, which is not the _most_
efficient way to do it, but trying to massage the bundle straight into a
packfile[2] ends up every complex very quickly). I should resurrect those
patches.

-Peff

[1] My "think about later" mailbox has ~5000 messages in it, some of
    which are from 2010. I think I may need to just declare bankruptcy.

[2] There's that word again.
