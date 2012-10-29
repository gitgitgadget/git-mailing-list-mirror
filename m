From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] git-submodule add: Add -r/--record option.
Date: Mon, 29 Oct 2012 01:34:01 -0400
Message-ID: <20121029053401.GB30186@sigill.intra.peff.net>
References: <20121023204437.GE28592@odin.tremily.us>
 <1f6ee2966ffe0f58f4b96ae0efb2ffb13e2fa2d8.1351029479.git.wking@tremily.us>
 <50883E54.4080507@web.de>
 <20121025005307.GE801@odin.tremily.us>
 <508D9A12.6010104@web.de>
 <CAJo=hJt_A5FCCcvR=sZ5Ni+-ZGq+MjxqkONbh9k+A46xBH9jzA@mail.gmail.com>
 <20121028223431.GF26675@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>, Git <git@vger.kernel.org>,
	Nahor <nahor.j+gmane@gmail.com>, Phil Hord <phil.hord@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Mon Oct 29 06:34:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TShzO-0000i0-Qv
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 06:34:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753742Ab2J2FeF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Oct 2012 01:34:05 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41782 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753604Ab2J2FeE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 01:34:04 -0400
Received: (qmail 15350 invoked by uid 107); 29 Oct 2012 05:34:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 29 Oct 2012 01:34:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Oct 2012 01:34:01 -0400
Content-Disposition: inline
In-Reply-To: <20121028223431.GF26675@odin.tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208584>

On Sun, Oct 28, 2012 at 06:34:31PM -0400, W. Trevor King wrote:

> On Sun, Oct 28, 2012 at 02:59:33PM -0700, Shawn Pearce wrote:
> > Looks like the Gerrit meaning is basically the same as =C3=86var's.=
 Gerrit
> > updates the parent project as if you had done:
> >=20
> >   $ git submodule foreach 'git checkout $(git config --file
> > $toplevel/.gitmodules submodule.$name.branch) && git pull'
> >   $ git commit -a -m "Updated submodules"
> >   $ git push
>=20
> Ah, good, then we *are* all using the option for the same thing.

That makes me more comfortable. Your patch adds support for setting the
variable initially. Does it need any special magic for maintenance, or
is it something that would always be updated by hand?

Right now, the variable is not an official git-submodule thing and it i=
s
OK to say "you are on your own by setting and using it from external
tools". But as soon as we support setting it in the first place, it is
reasonable to claim it as a bug if we do not keep it up to date for
certain operations.

I'm not familiar enough with the workflows around branching submodules
to know whether any such operations actually exist.

-Peff
