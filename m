From: martin f krafft <madduck@madduck.net>
Subject: Re: [PATCH] topgit tg push feature
Date: Mon, 11 May 2009 09:47:31 +0200
Message-ID: <20090511074731.GA30271@lapse.rw.madduck.net>
References: <20090425161300.GD19142@gmx.de> <20090425163447.GE19142@gmx.de> <20090505093448.GC16524@gmx.de> <20090507045904.GA2068@gmx.de> <36ca99e90905062245w1ec78828ice5ed18161b6ec43@mail.gmail.com> <20090507084355.GA11680@pengutronix.de> <36ca99e90905070250l656f8879g87eb27c09db2cd42@mail.gmail.com> <20090509103625.GC13344@lapse.rw.madduck.net> <20090509190910.GA9655@gmx.de> <20090511032813.GA15540@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-ripemd160;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
To: Marc Weber <marco-oweber@gmx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 11 11:01:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3RNb-0000jt-NN
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 11:01:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754998AbZEKJAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 05:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754641AbZEKJAv
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 05:00:51 -0400
Received: from clegg.madduck.net ([193.242.105.96]:36405 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753856AbZEKJAu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 05:00:50 -0400
Received: from lapse.rw.madduck.net (lapse.oerlikon.madduck.net [IPv6:2001:41e0:ff12:0:214:a4ff:fe04:eadc])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id 8DBD81D40A2;
	Mon, 11 May 2009 11:00:39 +0200 (CEST)
Received: by lapse.rw.madduck.net (Postfix, from userid 1000)
	id AADA5808A; Mon, 11 May 2009 09:47:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090511032813.GA15540@gmx.de>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux squeeze/sid kernel 2.6.30-rc4-686 i686
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.2/9351/Mon May 11 04:59:11 2009 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118783>


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Marc Weber <marco-oweber@gmx.de> [2009.05.11.0528 +0200]:
> commit cdab940eefc0a56e0daa8b270bace1aba00a3b57
> Author: Marc Weber <marco-oweber@gmx.de>
> Date:   Mon May 11 05:25:40 2009 +0200
>=20
>     t/tg-push
>    =20
>     add tg-push  pushing the branch, its deps and their bases
>    =20
>     Signed-off-by: Marc Weber <marco-oweber@gmx.de>

I tested this feature and it seems to work quite nicely. I have
a couple of minor remarks, but otherwise am ready to sign this off
and include it upstream.

As soon as this feature is there, we need to disable to push
refspecs installed by tg-remote, and also probably add a warning to
the hook in case they are present; those are evil.

> +	-h|--help)
> +		echo "Usage: tg push [(--dry-run | --no-deps | --tgish-only)] [-r "rem=
ote remote2"]* branch*"
> +		exit 1;;

--help should not exit non-zero, because if you ask for --help and
it prints it, that's not an error.

> +if [ -z "$remotes" ]; then
> +	remotes=3D"$(git config topgit.remote 2>/dev/null)"
> +fi

This configuration key was news to me, but only because I usually
run tg-remote without --populate, in which case it is not added.
This is probably a bug in tg-remote and should be fixed alongside
the push refspec removal.

> +		echo "pushing:"; echo $list
> +		if $dry_run; then
> +			echo git push $remote $list
> +		else
> +			git push $remote $list
> +		fi

git-push has --dry-run, why not use that?

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
due to lack of interest tomorrow has been cancelled.
=20
spamtraps: madduck.bogus@madduck.net

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEAREDAAYFAkoH2BIACgkQIgvIgzMMSnXtLQCgs+ru+ZtUypQVkVrCDnus+Fsd
xy8AoJ3vQ6A1WTtPznMoPtBqLiS1kMtN
=gw42
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
