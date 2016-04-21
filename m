From: Joey Hess <id@joeyh.name>
Subject: Re: 'next'ed --allow-unrelated-histories could cause lots of grief
Date: Thu, 21 Apr 2016 18:57:39 -0400
Message-ID: <20160421225739.GA7508@kitenet.net>
References: <20160421161043.GK7907@onerussian.com>
 <xmqqbn52ud6r.fsf@gitster.mtv.corp.google.com>
 <20160421185528.GJ23764@onerussian.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Cc: Git Gurus hangout <git@vger.kernel.org>
To: Yaroslav Halchenko <yoh@onerussian.com>
X-From: git-owner@vger.kernel.org Fri Apr 22 00:57:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atNXm-0007vj-4x
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 00:57:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753926AbcDUW5t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 18:57:49 -0400
Received: from kitenet.net ([66.228.36.95]:38818 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751760AbcDUW5t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 18:57:49 -0400
X-Question: 42
Authentication-Results: kitenet.net;
	dkim=pass (1024-bit key; unprotected) header.d=joeyh.name header.i=@joeyh.name header.b=jjlFmMfS;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1461279459; bh=ZWQ8dggRcM0KKbWl5ITpCCxw1sseSIIjmO59t6v3bo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jjlFmMfSH0qf18naIBjCt0CTxopeSSyl1/L32Wxbb5D35KeU4lbXIlp8n+p9QDddA
	 7qkPxF90Y1382ucYqXtkykT4FiFkLAiSP/mhlAsyFbaDiUGrilVSk+UX8hXrx9ktWh
	 8BIy8SOvJV2nVoPU5G0EhNYLAzSUQtPYLpXNd1d8=
Content-Disposition: inline
In-Reply-To: <20160421185528.GJ23764@onerussian.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Status: No, score=-93.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_PBL,RCVD_IN_RP_RNBL,
	RCVD_IN_SORBS_DUL,RDNS_NONE,SPF_SOFTFAIL,USER_IN_WHITELIST autolearn=no
	autolearn_force=no version=3.4.1
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on kite.kitenet.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292162>


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Yaroslav Halchenko wrote:
> - for git-annex (Joey was CCed from the beginning, not sure if annex
>   would be affected though), it would be merging of git-annex
>   branches while joining multiple annexes for the sync (e.g. by git
>   annex assistant).=20

Not entirely accurate (git-annex merges its git-annex branches using a
custom merge method and not involving git-merge). The actual use case is
two users (or one user with two devices) each with a git-annex
repository who decide to share their files by combining the two
repositories. This is pretty far from the kernel world, so it's not like
bisection is something they care about.

However, I also see --allow-unrelated-histories as very useful to
prevent many foot-shooting maneuvers. Especially when a repository has
special-purpose branches, like git-annex's git-annex branch, or other
branches that are never intended to be merged into master. It's a not
entirely uncommon mistake for users to merge in such a branch, and the
users who make such a mistake often don't know enough git to easily
recover from it.

Junio C Hamano wrote:
>   merge: GIT_MERGE_ALLOW_UNRELATED_HISTORIES environment

I hope this patch lands, it will save me a lot of bother.

--=20
see shy jo

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBVxla4ckQ2SIlEuPHAQITGg/+L7dQvJTtMQUxsr/8HEtbvV26LOXK3HIg
qXfocgiuuJMM/b6hEx5Uf1hWoKKvnmo8NPUd44r1Fjj15gy/nkAQN/uUshe+5euL
GyaVxrCo8jBwWz2xXNcLMBWw0ZZBa+8tuHgB3+Z5PWPrPkoh2ppH5yBymf6mMEm6
KuE+yMsjmK1AFWzqqNOuJqX2Db65lAssBasjfapE5FVs1AwBfP+mmLNozyxXSt/p
fgcJvrsTnNnZbSRb0/zMKhdPyABP3zH5mrk89mETluoi96Qt+JmgtuPqVisiJo22
Pvxya4YZ7kWXoQQIpIIRuLrd7apS80kFF5HzMfYhILxTElkLrq+m8KeoIptFiTTX
jmLqHGOKtpWvKMRNuyFrf68zNg4rkiHXmwfHOXSPMoW1tvCjePxh94A++8ZrdOxe
hYSaUPU/PkMFGRO9Cl8VO4OJrqz4bshBvmNcWv4qkHGBsAXtrHf5Td4rhaG3G6eu
8dU6hlLygmokJwSgxjvnRvsGpEHphOVsk+txYdHmIUbQax0SDAkQY74FxAP/JP4I
RYe0G2izMsQ97vmQJdAWwY8rvwohVpwUi1uB7lbxd3P/NfHe5TUrzBMI7AaU9aRO
1fcJ2Y+OTtmWPDh5X8eKHV3YozOvcjqCcjN3b1S0FY7tDSDL9qs2GKzTTB+3sbRC
w3PYiu8ToN4=
=7sbc
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
