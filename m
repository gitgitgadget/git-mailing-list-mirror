From: Jeff King <peff@peff.net>
Subject: Re: Re: git log -M -- filename is not working?
Date: Wed, 12 May 2010 09:09:18 -0400
Message-ID: <20100512130918.GA20755@coredump.intra.peff.net>
References: <z2r76c5b8581005071131q15524cb8td6711dbb9142b28e@mail.gmail.com>
 <19428.24021.324557.517627@winooski.ccs.neu.edu>
 <20100508044434.GC14998@coredump.intra.peff.net>
 <19428.62170.654092.308682@winooski.ccs.neu.edu>
 <20100508053025.GG14998@coredump.intra.peff.net>
 <7v39y3c5p1.fsf@alter.siamese.dyndns.org>
 <19429.3589.823244.270582@winooski.ccs.neu.edu>
 <20100512113855.GB23847@coredump.intra.peff.net>
 <19434.39095.448649.313537@winooski.ccs.neu.edu>
 <AANLkTin0E9rd7Ld3exCA5NbGnYhlspUZ93KT1O6Zvzrq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eli Barzilay <eli@barzilay.org>,
	Junio C Hamano <gitster@pobox.com>,
	Eugene Sajine <euguess@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 12 15:09:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCBgj-00061Q-5n
	for gcvg-git-2@lo.gmane.org; Wed, 12 May 2010 15:09:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922Ab0ELNJU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 May 2010 09:09:20 -0400
Received: from peff.net ([208.65.91.99]:59919 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750732Ab0ELNJT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 May 2010 09:09:19 -0400
Received: (qmail 3464 invoked by uid 107); 12 May 2010 13:09:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 12 May 2010 09:09:18 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 12 May 2010 09:09:18 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTin0E9rd7Ld3exCA5NbGnYhlspUZ93KT1O6Zvzrq@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146945>

On Wed, May 12, 2010 at 09:06:11PM +0800, Bo Yang wrote:

> On Wed, May 12, 2010 at 8:01 PM, Eli Barzilay <eli@barzilay.org> wrote:
> >> I really wonder if it would be that hard to just fix the code to follow
> >> several files. [...]
> >
> > That would obviously be a better solution...
> 
> The new line level history browser utility will follow multiple line
> ranges of multiple files and it of course will do this. :) Please wait
> for some days, I will make it possible in this summer.

Yeah, I know there is some overlap with your work. I wonder, though, if
it may be desirable for speed reasons to have three levels of limiting:

  1. limit by pathspec (what we have now, very fast)

  2. limit by path with rename following (my patch, slower)

  3. limit to history of arbitrary content (your work, which will
     presumably be even slower still)

Obviously if your (3) can be as fast as my (2), then there is no need
for (2).

-Peff
