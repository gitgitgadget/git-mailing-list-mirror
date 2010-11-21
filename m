From: Jeff King <peff@peff.net>
Subject: Re: How to fix =?utf-8?B?4oCcWW91ciBicmFu?=
 =?utf-8?Q?ch_and_'origin=2Fmaster'_have_diverged?= =?utf-8?B?4oCd?= after
 editing a commit that came before a pull?
Date: Sun, 21 Nov 2010 11:30:02 -0500
Message-ID: <20101121163001.GA29216@sigill.intra.peff.net>
References: <AANLkTikr+uGrO2EB9WQk+CXeOm7jiYxdbhGzRRvgc9B9@mail.gmail.com>
 <20101120043628.GB20725@sigill.intra.peff.net>
 <AANLkTikCnX5aBrmh9+wnb9JyOiynv0zhrpdMJwbhL2ji@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Yang Zhang <yanghatespam@gmail.com>, git@vger.kernel.org
To: Gavin Guo <tuffkidtt@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 21 17:30:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKCny-0005UO-Av
	for gcvg-git-2@lo.gmane.org; Sun, 21 Nov 2010 17:30:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754309Ab0KUQaG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Nov 2010 11:30:06 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:49619 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754105Ab0KUQaF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Nov 2010 11:30:05 -0500
Received: (qmail 11106 invoked by uid 111); 21 Nov 2010 16:30:03 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sun, 21 Nov 2010 16:30:03 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 21 Nov 2010 11:30:02 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTikCnX5aBrmh9+wnb9JyOiynv0zhrpdMJwbhL2ji@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161866>

On Sun, Nov 21, 2010 at 10:45:13PM +0800, Gavin Guo wrote:

> > To fix it, what you want to do is recreate the history on top of B'=
 as
> > it happened on top of B. So first you go back to C', the last commi=
t
> > just before the commits from upstream that were rewritten. (you wil=
l
> > have pick its sha1 out of the log):
> >
> > =C2=A0git checkout -b temp B'
>=20
> I think you mean git checkout -b temp C'

Yes, sorry. You should base your temp branch on C'.

> > =C2=A0git rebase --onto temp F'^ branch_name
> [...]
> > At that point your original branch should be in the state you want.=
 You
> > can delete the temp branch with "git branch -D temp".
>=20
> I'm sorry that I can't understand "your original branch should be in
> the state you want" ?
> You only create a temp branch, and rebase some commits on it, right ?=
?
> What does that related to original branch ??

The three-argument form of rebase above will switch to branch_name (you=
r
original branch), consider F'^ as the upstream, and rebase
=46'^..branch_name on top of the commits in "temp".

-Peff
