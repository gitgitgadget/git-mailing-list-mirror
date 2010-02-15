From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add an optional argument for --color options
Date: Mon, 15 Feb 2010 00:21:39 -0500
Message-ID: <20100215052139.GH3336@coredump.intra.peff.net>
References: <1266098475-21929-1-git-send-email-lodatom@gmail.com>
 <20100214064408.GB20630@coredump.intra.peff.net>
 <ca433831002140658r30aa539fy5480cae8298d6d6c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 06:23:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgtQS-0007bM-9s
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 06:23:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752258Ab0BOFVg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Feb 2010 00:21:36 -0500
Received: from peff.net ([208.65.91.99]:40063 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752186Ab0BOFVf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 00:21:35 -0500
Received: (qmail 13588 invoked by uid 107); 15 Feb 2010 05:21:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 15 Feb 2010 00:21:45 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Feb 2010 00:21:39 -0500
Content-Disposition: inline
In-Reply-To: <ca433831002140658r30aa539fy5480cae8298d6d6c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139978>

On Sun, Feb 14, 2010 at 09:58:58AM -0500, Mark Lodato wrote:

> > Hmm...the only one I see that silently ignores is "--submodule=3Dbo=
gus".
> > But it seems that "git log -Bfoobar" fails but does not print a use=
ful
> > message. =C2=A0Probably both should be fixed, and your option shoul=
d follow
> > the same convention as those.
>=20
> Just wondering, why does diff use a separate option parsing mechanism
> than the rest of the code?  Would it be worthwhile to switch to
> parse_opt?  This may make the code cleaner, and it would definitely
> make the command-line interface more consistent with the rest of the
> suite.  From a user's point of view, the biggest win would be "-h"
> printing all of the options, like all the non-diff commands do.

It's historical. The diff option parser predates parse-options by quite
a bit, and was never converted. Pierre made some attempts at converting
it and the revision parser some time back, and we ended up with the mor=
e
iterative approach (you can step through each argument with
parse-options, and then alternatively feed it to the revision and diff
options parser).

I don't remember if there were any technical limitations, though (e.g.,
places where the revision parser does not conform to parse-options
standards or needs some special treatment). You'd have to search the
list archives to see what actually happened.

-Peff
