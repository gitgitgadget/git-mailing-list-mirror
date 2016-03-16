From: Jeff King <peff@peff.net>
Subject: Re: parse-options does not recognize "unspecified" behavior
Date: Wed, 16 Mar 2016 17:44:42 -0400
Message-ID: <20160316214442.GC4441@sigill.intra.peff.net>
References: <CAFZEwPPd2wFqFq2LFEzN2CzhTV6C420SLPcXi1SWE=z2epOYLw@mail.gmail.com>
 <20160316204912.GA1890@sigill.intra.peff.net>
 <CAFZEwPMa3GZS6pvFwr8PLVDqKm5xmMd307nbjhpZSC_ndpw8vw@mail.gmail.com>
 <20160316212308.GA4538@sigill.intra.peff.net>
 <CAPig+cRKyaUefz0qj6unkaiPg25=Xi2WorQE4Fm46CCf00UbHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 22:44:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agJFJ-0003j2-Sb
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 22:44:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755655AbcCPVoq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 17:44:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:32863 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751051AbcCPVop (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 17:44:45 -0400
Received: (qmail 27619 invoked by uid 102); 16 Mar 2016 21:44:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Mar 2016 17:44:45 -0400
Received: (qmail 20817 invoked by uid 107); 16 Mar 2016 21:45:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Mar 2016 17:45:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Mar 2016 17:44:42 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cRKyaUefz0qj6unkaiPg25=Xi2WorQE4Fm46CCf00UbHQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289049>

On Wed, Mar 16, 2016 at 05:37:03PM -0400, Eric Sunshine wrote:

> A much easier solution would be to update OPT_VERBOSE() to understand
> that negative values are "unspecified", and then --verbose would
> (pseudocode):
> 
>     if (value < 0)
>         value = 0
>     value++;
> 
> and --no-verbose would:
> 
>     value = 0
> 
> That should be compatible with existing clients of OPT__VERBOSE()
> which initialize the value to 0, and should satisfy Pranit's case; he
> can initialize it to -1, and if it is still -1 when option parsing is
> done, then he knows that neither --verbose nor --no-verbose was seen.

Yes, that makes much more sense to me. Thanks for the back-story.

-Peff
