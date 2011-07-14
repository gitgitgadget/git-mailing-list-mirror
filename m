From: Jeff King <peff@peff.net>
Subject: Re: encrypted netrc for Git (was: [Wishlist] could git tell which
 password it is asking when asking a password.)
Date: Thu, 14 Jul 2011 11:00:33 -0400
Message-ID: <20110714150033.GA6797@sigill.intra.peff.net>
References: <877h82nlua.dlv@debian.org>
 <87aacygcfx.fsf@lifelogs.com>
 <87bowxt0sh.fsf_-_@lifelogs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 14 17:00:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhNP7-0001jk-Dm
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 17:00:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754543Ab1GNPAg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Jul 2011 11:00:36 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34699
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754318Ab1GNPAf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 11:00:35 -0400
Received: (qmail 6452 invoked by uid 107); 14 Jul 2011 15:00:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Jul 2011 11:00:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jul 2011 11:00:33 -0400
Content-Disposition: inline
In-Reply-To: <87bowxt0sh.fsf_-_@lifelogs.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177131>

On Thu, Jul 14, 2011 at 09:05:50AM -0500, Ted Zlatanov wrote:

> On Fri, 01 Jul 2011 12:04:02 -0500 Ted Zlatanov <tzz@lifelogs.com> wr=
ote:=20
>=20
> TZ> On Fri, 01 Jul 2011 15:59:09 +0200 R=C3=A9mi Vanicat <vanicat@deb=
ian.org> wrote:=20
>=20
> RV> It would be interesting also to plug some sort of password-safe u=
nto
> RV> git, or some "git-agent".=20
>=20
> TZ> This would also be really nice.  ~/.netrc is not a great place to=
 put
> TZ> passwords for the HTTP transport.  In GNU Emacs we have ~/.authin=
fo.gpg
> TZ> with the same content as ~/.netrc but encrypted by GPG and thus m=
ore
> TZ> secure (the user is either prompted for the password, if the file=
 is
> TZ> encrypted symmetrically, or the user simply loads their private k=
ey into
> TZ> the GPG agent).  I believe all this can be done with the GPGME li=
brary.
> TZ> There's also the Secrets API on newer Gnome and KDE installs, whi=
ch has
> TZ> a pretty nice D-Bus interface.
>=20
> TZ> But is this a libcurl feature request?  Or can a Git plugin (an
> TZ> alternate HTTPS transport maybe?) handle it?
>=20
> Ping?  I'd like to work on this if it seems like a feasible feature.

Check out:

  https://github.com/peff/git/commits/jk/http-auth

which provides an interface for getting credentials from external
helpers.

I need to write docs for a few of the top commits before posting the
patches to the list, but other than that, it should be fairly solid and
usable. And I'd love to get feedback from somebody trying to write a ne=
w
helper for it (i.e., to tell if the interface to the helpers is good
enough).

-Peff
