From: martin f krafft <madduck@madduck.net>
Subject: Re: [gitolite] repo config for delegated projects
Date: Sat, 6 Feb 2010 17:22:22 +1300
Message-ID: <20100206042222.GA7825@lapse.rw.madduck.net>
References: <20100203035718.GA30644@lapse.rw.madduck.net>
 <2e24e5b91002022222h5ca3ebe6k75854a9a056f0ed1@mail.gmail.com>
 <20100203202249.GA27125@lapse.rw.madduck.net>
 <20100204011842.GB497@atcmail.atc.tcs.com>
 <20100204040812.GC13411@lapse.rw.madduck.net>
 <2e24e5b91002051650k3c7cf14ev8752d36b5616e9a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-ripemd160;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	Sitaram Chamarty <sitaram@atc.tcs.com>,
	Teemu Matilainen <teemu.matilainen@iki.fi>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 06 05:24:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdcDZ-0004wT-Fq
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 05:24:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753758Ab0BFEWp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 23:22:45 -0500
Received: from clegg.madduck.net ([193.242.105.96]:57987 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752795Ab0BFEWn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 23:22:43 -0500
Received: from lapse.rw.madduck.net (lapse.nz.madduck.net [IPv6:2001:4428:234::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id D39551D4099;
	Sat,  6 Feb 2010 05:22:26 +0100 (CET)
Received: by lapse.rw.madduck.net (Postfix, from userid 1000)
	id 5B2F8CC; Sat,  6 Feb 2010 17:22:22 +1300 (NZDT)
Content-Disposition: inline
In-Reply-To: <2e24e5b91002051650k3c7cf14ev8752d36b5616e9a4@mail.gmail.com>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux squeeze/sid kernel 2.6.32-trunk-686 i686
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.95.3 at clegg
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139142>


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Sitaram Chamarty <sitaramc@gmail.com> [2010.02.06.1350 +1300]:
> OK I've run into a little decision-point here.
>=20
> The problem above is of making sure that a delegated admin cannot
> misuse the gitconfig mechanism to do stuff he's not allowed to do,
> but it's actually worse than that :(

Let me thus challenge the whole delegation mechanism.

When I first encountered it, I thought it was a great idea, but it
seems to promise more than it can do. I understand that the reasons
for that are security-related, and I tip my hat to you for being so
conscious about this =E2=80=94 better have a secure system with limited
functionality, than an insecure system that can do everything (why
am I thinking of PHP apps right now???).

The wildrepos branch is a definite improvement to proper delegation.
Without it, the main admin has to change the main configuration file
every time that a delegated admin wants to add a new repo.

However, given the somewhat awkward configuration (you need to add
delegated admins in multiple places), and the restrictions, I am
starting to wonder what use-case delegations solve that couldn't be
addressed easier with multiple accounts and gitolite instances.
Thoughts?

> Regardless of how I look at it, I can't think of a cure for this short
> of either:
>   - putting all the allowed gitconfigs in the RC file, and not in the
> config (writing the RC file requires shell access, and we presume the
> "root of trust" person has enough smarts to know what to allow and
> what not to allow), and allowing repo admins to *refer* to them to use
> whichever they want
>   - someone coming up with a list of gitconfig's that are "safe", and
> specific values for those that are unsafe (like saying "if you use
> showrev, you can only use this command  as the value", and forcing
> only those.

I think the second path is a red herring. However, I don't
understand why we would need to go via the RC file instead of the
main config. Only the main admin can modify that, or appoint others
to modify it. Plus, it's managed in Git and thus has a history
attached to it.

Speaking of shell access, I notice gl-auth-command has the -s
option. Is there a configuration variable that I overlooked which
allows me to give shell login rights to specific users?

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
review of a chemistry paper:
  "paper should be greatly reduced or completely oxidized."
                                                    -- frank vastola
=20
spamtraps: madduck.bogus@madduck.net

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEAREDAAYFAkts7noACgkQIgvIgzMMSnXdoQCdEIIkPZtSZZuBOGvZwU+2R5AV
/zMAn0BQg+vYw43DvUUZzKPWRs0nyv97
=KYRP
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
