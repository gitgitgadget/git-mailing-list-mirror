From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/3] Better ref summary alignment in "git fetch"
Date: Fri, 3 Jun 2016 13:00:58 -0400
Message-ID: <20160603170058.GB1733@sigill.intra.peff.net>
References: <20160522112019.26516-1-pclouds@gmail.com>
 <20160603110843.15434-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 19:13:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8sT6-0004a4-3I
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 19:01:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752405AbcFCRBD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Jun 2016 13:01:03 -0400
Received: from cloud.peff.net ([50.56.180.127]:48634 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750994AbcFCRBC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 13:01:02 -0400
Received: (qmail 23278 invoked by uid 102); 3 Jun 2016 17:01:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Jun 2016 13:01:01 -0400
Received: (qmail 23859 invoked by uid 107); 3 Jun 2016 17:01:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Jun 2016 13:01:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Jun 2016 13:00:58 -0400
Content-Disposition: inline
In-Reply-To: <20160603110843.15434-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296352>

On Fri, Jun 03, 2016 at 06:08:40PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:

> v2 reformats "abc/common -> def/common" to "{abc -> def}/common"
> instead and fall back to "a -> b" when they have nothing in commmon
> (e.g. "HEAD -> FETCH_HEAD"). We could add an option if a user wants t=
o
> stick with "a -> b" (and we could do some alignment there as well) bu=
t
> it's not part of this series.

I tried this on one of my nastiest long-branch-heavy repos. It really
does look better than the status quo. I think it's nicer than the
stair-stepping proposal in that it does get everything aligned
perfectly, and reduces wasted data that spills off the side of my
terminal.

I do somehow find the:

  { -> origin}/whatever

a little off-putting, I think because the "from" side is empty, and
therefore you get this weird mix of punctuation: "{ ->". I wonder if
there's another syntactic shorthand we could apply in that case
(especially since it will easily be the most common), but I couldn't
think of one.

> It's a shame that the flag '-' in these ref update lines is not the
> same in fetch and push (see 1/3). Because git-fetch does not support
> --porcelain option, maybe it's not too late to change its meaning... =
=20

I'd agree with that final "maybe". :)

-Peff
