From: Joey Hess <joey@kitenet.net>
Subject: Re: moving to a git-backed wiki
Date: Fri, 4 Feb 2011 10:34:21 -0400
Message-ID: <20110204143421.GA6449@gnu.kitenet.net>
References: <7vsjw957fq.fsf_-_@alter.siamese.dyndns.org>
 <7vzkqg4x2h.fsf_-_@alter.siamese.dyndns.org>
 <20110131225529.GC14419@sigill.intra.peff.net>
 <AANLkTimHCp_JKUw1keJoA4zD_q7Sci+rOwPeAs_T=7xH@mail.gmail.com>
 <20110201201144.GA16003@sigill.intra.peff.net>
 <AANLkTikfzzELUaN3B+20rh9D51St8mUYs4p-WYjp8JVV@mail.gmail.com>
 <4D488DCD.3080305@eaglescrag.net>
 <4D4929F4.3020805@snarc.org>
 <4D4A11D7.4040103@eaglescrag.net>
 <20110203174518.GA14871@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 04 15:36:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlMmF-0005j0-LG
	for gcvg-git-2@lo.gmane.org; Fri, 04 Feb 2011 15:36:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752061Ab1BDOgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Feb 2011 09:36:35 -0500
Received: from wren.kitenet.net ([80.68.85.49]:34522 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751777Ab1BDOge (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Feb 2011 09:36:34 -0500
Received: from gnu.kitenet.net (dialup-4.153.249.105.Dial1.Atlanta1.Level3.net [4.153.249.105])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id A6C4A118281
	for <git@vger.kernel.org>; Fri,  4 Feb 2011 09:36:21 -0500 (EST)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id 7C16D50A5C; Fri,  4 Feb 2011 09:34:21 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20110203174518.GA14871@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166045>


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Jeff King wrote:
> If it sounds like I'm handwaving away scalability problems, I am. I'd be
> curious to see some performance numbers for gollum or ikiwiki versus
> more traditional wiki formats.

Ikiwiki builds static pages, this tends to mean it doesn't have
performance, because there is little more to perform than
httpd < file > network :)
So I've routinely had ikiwiki sites slashdotted, and not noticed.

Ikiwiki is not enormously fast in the rare cases when it does have to
run as a CGI, but little of that has to do with git. About the worst
case is that saving a page edit leads to a git commit -- if git
decides to gc the repository right then, it could make the save stall
for a while. There are easy ways to avoid that. (ie, git gc in cron job)
In general, though ikiwiki as a CGI is fast enough to not be annoying --=20
although it won't scale to a site the size of wikipedia.

Since I'm lazy, ikiwiki does not include a history or diff viewer. It
just points off to gitweb or a similar tool. As you say, gitweb can be
fast enough, and really most wiki users do read their current content,
or maybe make an edit; digging in the history is comparatively rare.
And once users realize the wiki is in git, they can use gitk to dig in
the history without using any server resources. :)

The feature I like best with using git for a wiki (besides ease of
branching) is that it can actually make a legitimate use of the
woefully underused git push over git:// feature. Ikiwiki can be
configured to check such pushes, running via the pre-receive hook. This
allows it to limit the changes that can be pushed anonymously to changes
that could be made using the web interface. So if you've chosen to lock
some pages, or virus filter attachments, or whatever, in the web side of
the wiki, that all applies to the anonymous git pushes too. Details at
<http://ikiwiki.info/tips/untrusted_git_push/>

--=20
see shy jo

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIVAwUBTUwOaskQ2SIlEuPHAQjmFhAAoKU1oDoO04B8A96IE1GbwY4TAunfrMAz
a3sCETK9O65o6afvGiLRBaCAwxFAHQzflaKE3KyRevCNDYkg7t4sXAI7V3UXB7xV
ECmFywUCw54kfxEGDJPaxDzdzApBmKqAlkKdJmLxTRgt8Y79FX7Iag3nPdFM+JMy
Kl2iv/M7fEHJ2RzVDMhtDEfFXBACNfZYWr7GW7sgKA0MuFhUVWLmElO9Ko6Hbnga
GdOl4DcA8X66gvHrAqmT5VsmaDRuS0BNV58vaTC80M9EYHhCFDbpIql36t1lhgbd
PYLMNuSIx0w2bjoIbATRhi4ovg+hNYFHM6mysIJpmAHala5ckR8esRf6XsTnRltO
i08hgwLj6dOh8lzzP1wFzBMXmK9IMUqlSSGuTnkKkyl2CwWLJHtgIqyBs7vNNgzm
vmjHrtNV8MBw2q7lw9M76pNaUUq9YxuqTzggptYXPL2R5YIhD79KK6tn7A73K0d4
yPk50c81lTkFxc02RbOPC1a1+fEUy+cKs9Y4LXzRHx1Q6cHaBcfERigKueGZr/k+
9FAl9aRrDAD8XQ1tJuJ4CeYFG15uqqk6uTMmdeuclabLa4W/3dhfa9AAh0dX8KOo
AgQPlFSUBHKAnzjw6TdcLhsOPXoSFWYdrWIAIg8Qd7Nm+iOgdFtuRJy0f2KJPNFx
QBvUfl/NVlU=
=nnPQ
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
