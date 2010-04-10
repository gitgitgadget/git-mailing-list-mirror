From: Jeff King <peff@peff.net>
Subject: Re: git status --porcelain is a mess that needs fixing
Date: Sat, 10 Apr 2010 02:32:15 -0400
Message-ID: <20100410063215.GA6260@coredump.intra.peff.net>
References: <20100409184608.C7C61475FEF@snark.thyrsus.com>
 <20100410040959.GA11977@coredump.intra.peff.net>
 <20100410054645.GA17711@progeny.tock>
 <20100410055124.GA17778@progeny.tock>
 <20100410060353.GA4585@coredump.intra.peff.net>
 <20100410061224.GA18715@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Raymond <esr@snark.thyrsus.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 10 08:32:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0UFU-0007Uc-MS
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 08:32:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284Ab0DJGck convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Apr 2010 02:32:40 -0400
Received: from peff.net ([208.65.91.99]:53916 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751260Ab0DJGck (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 02:32:40 -0400
Received: (qmail 15369 invoked by uid 107); 10 Apr 2010 06:32:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 10 Apr 2010 02:32:39 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Apr 2010 02:32:15 -0400
Content-Disposition: inline
In-Reply-To: <20100410061224.GA18715@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144518>

On Sat, Apr 10, 2010 at 01:12:24AM -0500, Jonathan Nieder wrote:

> Jeff King wrote:
>=20
> > You do "git clean -ndX" to see
> > _everything_ that is untracked, and "git clean -nd" to see things t=
hat
> > are untracked but not ignored.
>=20
> No, the capital X tells clean to only list excluded files.  The
> standard use is as a poor man=E2=80=99s =E2=80=9Cmake maintainer-clea=
n=E2=80=9D, leaving
> unrelated files alone.

Ah, I read it as "-x" (probably because I had never heard of "-X"
either...).

So yes, it would do the right thing. I still think a --show-ignored
option to git-status would probably be better (in addition to being
sanctioned plumbing, it means we only have to traverse the tree once
for Eric's case, instead of twice).

> I only learned about it just now.  I=E2=80=99m glad I did (I often us=
e the
> lowercase version for this because I just didn=E2=80=99t know about -=
X), but
> as you mentioned, it is not so applicable here because not plumbing.

The "-X" mode seems much safer to me, as you are less likely to blow
away things you actually wanted to keep while cleaning the tree of
crufty build products. It seems like it should have been the
easier-to-type "-x", but it is far too late for such bikeshedding at
this point.

Thanks for the pointer.

-Peff
