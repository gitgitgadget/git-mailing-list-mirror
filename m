From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] git-submodule add: Add -r/--record option.
Date: Mon, 29 Oct 2012 06:58:55 -0400
Message-ID: <20121029105855.GA15075@sigill.intra.peff.net>
References: <20121023204437.GE28592@odin.tremily.us>
 <1f6ee2966ffe0f58f4b96ae0efb2ffb13e2fa2d8.1351029479.git.wking@tremily.us>
 <50883E54.4080507@web.de>
 <20121025005307.GE801@odin.tremily.us>
 <508D9A12.6010104@web.de>
 <CAJo=hJt_A5FCCcvR=sZ5Ni+-ZGq+MjxqkONbh9k+A46xBH9jzA@mail.gmail.com>
 <20121028223431.GF26675@odin.tremily.us>
 <20121029053401.GB30186@sigill.intra.peff.net>
 <20121029104544.GA2424@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>, Git <git@vger.kernel.org>,
	Nahor <nahor.j+gmane@gmail.com>, Phil Hord <phil.hord@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Mon Oct 29 11:59:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSn3n-00047U-K4
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 11:59:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753001Ab2J2K67 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Oct 2012 06:58:59 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:42045 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751582Ab2J2K66 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 06:58:58 -0400
Received: (qmail 19122 invoked by uid 107); 29 Oct 2012 10:59:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 29 Oct 2012 06:59:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Oct 2012 06:58:55 -0400
Content-Disposition: inline
In-Reply-To: <20121029104544.GA2424@odin.tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208615>

On Mon, Oct 29, 2012 at 06:45:44AM -0400, W. Trevor King wrote:

> > > Ah, good, then we *are* all using the option for the same thing.
> >=20
> > That makes me more comfortable. Your patch adds support for setting=
 the
> > variable initially. Does it need any special magic for maintenance,=
 or
> > is it something that would always be updated by hand?
>=20
> Everyone we've heard from so far interprets the setting as =E2=80=9Cp=
ull from
> $branch in the remote repository $url to update the submodule=E2=80=9D=
=2E  With
> Phil's export, that would become
>=20
>   $ git submodule foreach 'git checkout "$submodule_branch" && git pu=
ll'
>   $ git commit -a -m "Updated submodules"
>   $ git push
>=20
> As Nahor mentioned on the 23rd, there are a number of ways that the
> upstream branch could disappear, but Git has no way to know what the
> new branch setting should be.  This means that even if we make =E2=80=
=9Cpull
> from $branch=E2=80=9D interpretation official, we still couldn't do a=
nything
> slick about updating it.  So, yes, it will be updated by hand.

OK.

Can you send an updated version of the patch that summarizes the
situation in the commit message?

I also think it is probably worth saying something in the documentation
for the feature like "Note that this value is not actually used by git;
however, some external tools and workflows may make use of it."

-Peff
