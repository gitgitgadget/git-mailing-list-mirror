From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/5] argv-array: Add argv_array_pop function [v2]
Date: Thu, 5 Apr 2012 22:20:58 -0400
Message-ID: <20120406022058.GA16264@sigill.intra.peff.net>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1333654745-7898-1-git-send-email-nhorman@tuxdriver.com>
 <1333654745-7898-2-git-send-email-nhorman@tuxdriver.com>
 <7vd37m5458.fsf@alter.siamese.dyndns.org>
 <20120405232429.GA8654@hmsreliant.think-freely.org>
 <7vobr53bbe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Neil Horman <nhorman@tuxdriver.com>, git@vger.kernel.org,
	Phil Hord <phil.hord@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 04:21:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFynV-00086m-9v
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 04:21:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757048Ab2DFCVD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Apr 2012 22:21:03 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49493
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754086Ab2DFCVC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 22:21:02 -0400
Received: (qmail 30344 invoked by uid 107); 6 Apr 2012 02:21:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 05 Apr 2012 22:21:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Apr 2012 22:20:58 -0400
Content-Disposition: inline
In-Reply-To: <7vobr53bbe.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194835>

On Thu, Apr 05, 2012 at 06:20:53PM -0700, Junio C Hamano wrote:

> >> > CC: Jeff King <peff@peff.net>
> >> > CC: Phil Hord <phil.hord@gmail.com>
> >> > CC: Junio C Hamano <gitster@pobox.com>
> >> > ---
> >> 
> >> Please don't do "Cc:" here; they belong to your e-mail header.
> >> 
> > You mean place them below the snip line?  I can do that.
> 
> No.  When you review and fix typo in format-patch output, you can add
> these to the e-mail header part and git-send-email will pick them up just
> fine.

I think there is a legitimate conflict of interest here.

It's not clear exactly what "cc" tags in a commit message mean, because
it is really a per-project thing. I don't work on the kernel, but I
always took their cc tag to mean "these are people interested in this
topic area". Send-email helpfully picks up that hint and cc's them on
the emailed patch. And when the patch is applied, those cc lines remain,
because people reading "git log" much later may find a bug in the patch,
and it is helpful to tell them the people interested in the area.

In git.git, though, we don't typically use such cc tags. Perhaps because
we are a much smaller project than the kernel, or perhaps for other
logistical reasons. And even if we did, the cc list above does not
really meet the guideline I gave. They are people who happened to review
your patch or comment on the list, not people who are interested forever
in a particular subsystem.

So from the maintainer's and the project's perspective, those cc lines
are useless noise.

But from the submitter's point of view, it may be convenient to tell git
"these are people who have reviewed _this_ patch series", and have it
automatically cc them on each iteration of the series without re-typing
their addresses.  And because of the send-email behavior I mentioned
above, the "cc" tags are a convenient place to put it.

So it is a piece of information that is useful to the submitter, but not
to the maintainer. Where can the submitter put it that will help
themselves, but not bother the maintainer?  I wonder if the right
solution would be an option for send-email to respect cc lines, but
strip them out of the body of the sent patch.

-Peff
