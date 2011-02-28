From: Jeff King <peff@peff.net>
Subject: Re: symling diff driver (Was: Re: git diff: add option for omitting
 the contents of deletes)
Date: Mon, 28 Feb 2011 08:08:50 -0500
Message-ID: <20110228130850.GB9054@sigill.intra.peff.net>
References: <AANLkTi=++gcw5CDQnTRbhUGkvWc9Zm+Ct4Zm5oGGYKUh@mail.gmail.com>
 <7vk4gm7dz3.fsf@alter.siamese.dyndns.org>
 <4D6A6291.8050206@drmicha.warpmail.net>
 <7v7hclulz0.fsf@alter.siamese.dyndns.org>
 <7v39n9uldp.fsf@alter.siamese.dyndns.org>
 <4D6B4F6B.1040209@drmicha.warpmail.net>
 <20110228121726.GA5197@sigill.intra.peff.net>
 <4D6B981E.5090206@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Feb 28 14:08:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pu2qP-00085t-JP
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 14:08:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754012Ab1B1NIx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 08:08:53 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:35014 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753876Ab1B1NIw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 08:08:52 -0500
Received: (qmail 23246 invoked by uid 111); 28 Feb 2011 13:08:52 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 28 Feb 2011 13:08:52 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Feb 2011 08:08:50 -0500
Content-Disposition: inline
In-Reply-To: <4D6B981E.5090206@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168108>

On Mon, Feb 28, 2011 at 01:42:06PM +0100, Michael J Gruber wrote:

> > I am still carrying around my "symlinks as a special class of diff"
> > patches if you are interested:
> > 
> >   https://github.com/peff/git/tree/jk/userdiff-symlinks
> 
> This is marvelous (except for s/perl -pe/sed -e/, of course).

I used perl because many older seds have trouble with files not ending
in newline.

> Is there anything left to do to get this in pu? (The reference to
> "previous patch" may need to be more explicit.)

See this subthread for discussion:

  http://article.gmane.org/gmane.comp.version-control.git/156760

On the one hand, there were doubts that anybody would actually want to
use it (though it looks like you may be the counterexample to that). On
the other hand, it may be that the solution does not go far enough, and
that .gitattributes should become aware of file types in its matching.
That would be more flexible, and it would also fix other broken areas
(like the fact that a symlink to foo.pdf might have its symlink text
merged as if it were a pdf).

-Peff
