From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: GPG signing for git commit?
Date: Wed, 15 Apr 2009 11:55:54 -0700
Message-ID: <20090415185554.GG23644@curie-int>
References: <1238793954.19982.14.camel@hyperair-laptop> <alpine.LFD.2.00.0904031535140.3915@localhost.localdomain> <49D99BB2.2090906@vilain.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3v/vPZnlCeuYLnyQ"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 15 20:57:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuAIy-00089A-Fr
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 20:57:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753212AbZDOS4B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 14:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752524AbZDOS4A
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 14:56:00 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:43773 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752366AbZDOS4A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 14:56:00 -0400
Received: (qmail 27480 invoked from network); 15 Apr 2009 18:55:58 -0000
Received: from tsi-static.orbis-terrarum.net (HELO curie.orbis-terrarum.net) (76.10.188.108)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Wed, 15 Apr 2009 18:55:58 +0000
Received: (qmail 31032 invoked by uid 10000); 15 Apr 2009 11:55:54 -0700
Content-Disposition: inline
In-Reply-To: <49D99BB2.2090906@vilain.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116644>


--3v/vPZnlCeuYLnyQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 06, 2009 at 06:05:38PM +1200, Sam Vilain wrote:
> This system allows for *pushes* to be signed and in general laying the
> foundation for knowing that commits are authentic without the intrusion
> into the refs/tags/* space that making lots of signed tags would imply.
I'm on the lookout for something similar, so that we can be sure who
introduced some change into the central repo.

One of the spots that we're looking for in this, is a model something
like what follows. Firstly, a "proxy maintainer" (PM) is a developer
with commit rights to the central repo, that's willing to proxy commits
by an outside source for some specific package. Think of them as the
kernel subsystem maintainer, but many more of them. The PM is still
expected to verify the work before passing it on the central repo.

So we have a commit with author+committer being the outside source, and
now we want to record (in an easily reviewable fashion) that a specific
changeset was introduced to the central tree by the PM.

Not sure of the best route to trace this data. Signing the SHA1 makes
the most sense, but need to be able to do that without polluting the tag
namespace.

If the changeset does not have an associated signature, we'd like to
reject it at the central repo.

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Infra Guy
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--3v/vPZnlCeuYLnyQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.10 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iEYEARECAAYFAknmLboACgkQPpIsIjIzwiwMqACgqPrqKUNXlPswt/IxBdBuy0Lj
N3gAn0Uv802O6lJ1sXYUf7KaU7CVFNmU
=ARaC
-----END PGP SIGNATURE-----

--3v/vPZnlCeuYLnyQ--
