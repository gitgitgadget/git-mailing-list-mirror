From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] test-lib: tests can have multiple prerequisites
Date: Mon, 26 Apr 2010 15:17:03 -0400
Message-ID: <20100426191703.GC10772@coredump.intra.peff.net>
References: <20100421131255.GA2750@progeny.tock>
 <20100421133806.GA5595@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Don Slutz <Don.Slutz@SierraAtlantic.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 26 21:17:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6Tnu-0003p9-NX
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 21:17:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752742Ab0DZTRI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Apr 2010 15:17:08 -0400
Received: from peff.net ([208.65.91.99]:58823 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751658Ab0DZTRH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Apr 2010 15:17:07 -0400
Received: (qmail 13410 invoked by uid 107); 26 Apr 2010 19:17:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 26 Apr 2010 15:17:14 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Apr 2010 15:17:03 -0400
Content-Disposition: inline
In-Reply-To: <20100421133806.GA5595@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145851>

On Wed, Apr 21, 2010 at 08:38:06AM -0500, Jonathan Nieder wrote:

> Alas, I didn=E2=80=99t notice the thread with the almost identical pa=
tch [1]
> before writing this one.
>=20
> Since I am painting it, I prefer this way.  I find it intuitive and
> can=E2=80=99t really see where the fuss about using some other coding=
 style
> came from.  So I would be very happy if someone who does understand
> the fuss could come up with a comment to add to the commit message
> about this. :)

I liked commas better, but since you are doing the work of writing the
patches, I will let it go. :)

I do wonder if it might be less error-prone to have:

  test_expect_success PREREQ1 PREREQ2 'desc' 'test'

instead of

  test_expect_success 'PREREQ1 PREREQ2' 'desc' 'test'

which should just be something like

  while test $# -gt 2; do
    test_have_prereq "$1" || skip=3Dt
    shift
  done

But if you think that's dumb, just ignore it. It is really not worth
spending that much time on.

-Peff
