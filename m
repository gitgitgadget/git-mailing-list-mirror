From: Joey Hess <joey@kitenet.net>
Subject: Re: is it kosher for pre-commit to change what's staged?
Date: Wed, 10 Nov 2010 16:45:42 -0400
Message-ID: <20101110204542.GA11201@gnu.kitenet.net>
References: <20101110170819.GA3031@gnu.kitenet.net>
 <7v1v6thrzc.fsf@alter.siamese.dyndns.org>
 <20101110200650.GA13439@burratino>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 10 21:46:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGHYZ-0002w9-OY
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 21:46:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756090Ab0KJUqD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 15:46:03 -0500
Received: from wren.kitenet.net ([80.68.85.49]:54340 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754013Ab0KJUqC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 15:46:02 -0500
Received: from gnu.kitenet.net (dialup-4.153.251.221.Dial1.Atlanta1.Level3.net [4.153.251.221])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 01673118332
	for <git@vger.kernel.org>; Wed, 10 Nov 2010 15:45:59 -0500 (EST)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id D34F64965D; Wed, 10 Nov 2010 15:45:42 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20101110200650.GA13439@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161185>


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Jonathan Nieder wrote:
> In this case, isn't it only a half accident?  For example, I think
> v1.5.4-rc0~78^2~12 (builtin-commit: fix partial-commit support,
> 2007-11-18) taught git to support this a little better.

Partial commits modified by pre-commit still don't work entirely right IME.
After the commit, the index is such that git wants to revert any changes
added to the commit by the pre-commit hook.

> That said, I would be interested to hear the use case, since modifying
> staged content on the fly for a commit sounds a little crazy. :)

Well, with git-annex (which I should probably properly announce here
sometime), large files are not committed to git, but instead a symlink
pointing at the content is committed. That symlink can temporarily be
replaced with a copy of the file when the user wants to modify it, and
if the user then commits, it's nice if it can move away the large file's
content, and arrange for the commit to contain an updated symlink pointing
at the new content.

That said, since git commit stages the whole large file into the index,
which is the kind of expensive operation git-annex exists to avoid,
it's still not very practical to intercept the commit like that. What
I ideally need is a hook that is run before git commit stages anything.


BTW, githooks says pre-commit is "invoked before obtaining the proposed
commit log message", which is a bit confusing. I actually see
prepare-commit-msg and commit-msg both called after pre-commit.

--=20
see shy jo

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIVAwUBTNsEdskQ2SIlEuPHAQi+RRAAqwoZLnKCWwmYvDK0EJgVKmVyYudLl9jx
hvmLfb3iJeE33CKTiURoz7549sQulxGFwSqRt4H2qxKocAKjAMSzgf9kJcbo9RjV
dWc01aX9i3c33rcFOVCXmvCDMwe6nS34TPfVYTMYE+5+JviGatd0TJ5S0WjbnLYL
TYKBeEYdYWqyaaxbb3ZhLY0p1cVrGMY9AlZB4sXkfjMg+ZvAwzuYShEvXEoa+0MF
m/s6FJPUMyA0Y3TAxBUHdFfpYyrGeZkYg2jRv9F3eRuKC9f2kDbBzMyoxVdTcF1g
ZrHVrAYCTYAx21OOqH5ExCvy8unFF+u7vP6F36mZHZp+HWscEDsRCLaK+ma2QF0n
o4QRoyYIUmFtZgco8xQajduDIWBrwoyW04AD2rZIXnQyXqIM/vDACa4rU8JlQCKD
b6bBHkNxCYt7ElSLlT4uEaa+gWhiN2bJ18cHPjJTAt8/qk/G6L2UZb37J3Ywkqar
H8thnYxgwo1Jkknqxg19pKiip1I6xanMzGcwasgRmZZtPZ1Xn30DY69qntBCfRti
yk0gsYRZ6CA2ZOB5u4pTDmHvJPE/ReoHrj/nP6VGE9NDqBICwCqX5E80aTrH4AZw
R7KlOOSxy21+hXulcovQWVaejaD8GW8lTvxBXNwcqPCevZBUoeW8cWl1nYyX8Zb1
dxvffvdh7Hw=
=6rj+
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
