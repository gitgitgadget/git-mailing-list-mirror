From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-completion.bash: always swallow error output of
 for-each-ref
Date: Fri, 12 Feb 2016 18:46:56 -0500
Message-ID: <20160212234655.GA23398@sigill.intra.peff.net>
References: <56B32953.2010908@gmail.com>
 <20160204111307.GA30495@sigill.intra.peff.net>
 <alpine.DEB.2.20.1602041216240.2964@virtualbox>
 <20160213002122.Horde.mxoPmZIuCikpV2PO97l11AI@webmail.informatik.kit.edu>
 <20160213004300.Horde.fMBUV1thpmh_xekWw-EOFAA@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	tr@thomasrast.ch
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sat Feb 13 00:47:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUNQU-0005XM-Lb
	for gcvg-git-2@plane.gmane.org; Sat, 13 Feb 2016 00:47:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983AbcBLXq7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Feb 2016 18:46:59 -0500
Received: from cloud.peff.net ([50.56.180.127]:41311 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751320AbcBLXq6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2016 18:46:58 -0500
Received: (qmail 26723 invoked by uid 102); 12 Feb 2016 23:46:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Feb 2016 18:46:58 -0500
Received: (qmail 21117 invoked by uid 107); 12 Feb 2016 23:47:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Feb 2016 18:47:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Feb 2016 18:46:56 -0500
Content-Disposition: inline
In-Reply-To: <20160213004300.Horde.fMBUV1thpmh_xekWw-EOFAA@webmail.informatik.kit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286097>

On Sat, Feb 13, 2016 at 12:43:00AM +0100, SZEDER G=C3=A1bor wrote:

>=20
> Quoting SZEDER G=C3=A1bor <szeder@ira.uka.de>:
>=20
> >Now, if 'git for-each-ref' could understand '**' globbing, not just
> >fnmatch...
>=20
> Oh, look, though the manpage says:
>=20
>   <pattern>...
>       If one or more patterns are given, only refs are shown that mat=
ch
>       against at least one pattern, either using fnmatch(3) or litera=
lly,

Yeah, we might want to update that. Wildmatch is basically fnmatch()
compatible, but it understands "**" (which I _think_ is the reason we
picked it up in the first place). I think we dropped it into place by
default because "**" is otherwise meaningless for fnmatch.

I don't think there are any other differences between the two, but Duy
probably knows offhand.

It looks like we mention fnmatch() in a few places in the documentation=
,
and AFAIK each of these is now outdated.

-Peff
