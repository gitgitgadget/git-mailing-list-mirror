From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/5] t5312: test object deletion code paths in a
 corrupted repository
Date: Thu, 19 Mar 2015 21:32:17 -0400
Message-ID: <20150320013217.GA15302@peff.net>
References: <20150317072750.GA22155@peff.net>
 <20150317072844.GA25191@peff.net>
 <CAPig+cTfqWr9un=4+QGs0jcUaV9U=z5Xyg3-r-D6dABGXUkmzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 02:32:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYlnV-0000VV-SE
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 02:32:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbbCTBcV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 21:32:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:35563 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750731AbbCTBcU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 21:32:20 -0400
Received: (qmail 15833 invoked by uid 102); 20 Mar 2015 01:32:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Mar 2015 20:32:20 -0500
Received: (qmail 19074 invoked by uid 107); 20 Mar 2015 01:32:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Mar 2015 21:32:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Mar 2015 21:32:17 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cTfqWr9un=4+QGs0jcUaV9U=z5Xyg3-r-D6dABGXUkmzg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265857>

On Thu, Mar 19, 2015 at 09:16:52PM -0400, Eric Sunshine wrote:

> > --- /dev/null
> > +++ b/t/t5312-prune-corruption.sh
> > @@ -0,0 +1,104 @@
> > +# we do not want to count on running pack-refs to
> > +# actually pack it, as it is perfectly reasonable to
> > +# skip processing a broken ref
> > +test_expect_success 'create packed-refs file with broken ref' '
> > +       rm -f .git/refs/heads/master &&
> > +       cat >.git/packed-refs <<-EOF
> 
> Broken &&-chain.

Thanks. I notice that a large number of broken &&-chains are on
here-docs. I really wish you could put the && on the "EOF" line at the
end of the here-doc. I understand _why_ that this not the case, but
mentally it is where I want to type it, and I obviously sometimes fail
to go back and fix it. I don't think there's a better solution in POSIX
sh, though.

-Peff
