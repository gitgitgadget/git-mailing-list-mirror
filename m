From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH 7/7] builtin-merge: avoid non-strategy git-merge
	commands in error message
Date: Sat, 26 Jul 2008 18:00:22 +0200
Message-ID: <20080726160022.GM32057@genesis.frugalware.org>
References: <1217073292-27945-1-git-send-email-vmiklos@frugalware.org> <4f2b03391e3f85cf2224f97a2a7765d08707bd73.1217037178.git.vmiklos@frugalware.org> <68749731fe8de8b2a9ffc53963291aeab9256b82.1217037178.git.vmiklos@frugalware.org> <99c90877657be0ed439a9918f500d6ad132550a2.1217037178.git.vmiklos@frugalware.org> <13f39dd6752a34beeb6ecccb51dbc7546ef87182.1217037178.git.vmiklos@frugalware.org> <fc448aa651ad9e8e9d1cf5556a665b5bd6074628.1217037178.git.vmiklos@frugalware.org> <65a569c389352c5d0500b8c44c28e5572352e6ba.1217037178.git.vmiklos@frugalware.org> <alpine.DEB.1.00.0807261701520.26810@eeepc-johanness> <20080726152502.GL32057@genesis.frugalware.org> <alpine.DEB.1.00.0807261737260.26810@eeepc-johanness>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+U0EQ97FbU8QddnY"
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 26 18:01:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMmD0-0002DN-In
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 18:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752332AbYGZQA0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 12:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752460AbYGZQA0
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 12:00:26 -0400
Received: from virgo.iok.hu ([193.202.89.103]:48226 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752262AbYGZQAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 12:00:25 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 5F7E71B24FC;
	Sat, 26 Jul 2008 18:00:24 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id B5C6D4465E;
	Sat, 26 Jul 2008 17:17:20 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 184BB1190A09; Sat, 26 Jul 2008 18:00:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807261737260.26810@eeepc-johanness>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90251>


--+U0EQ97FbU8QddnY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 26, 2008 at 05:38:55PM +0200, Johannes Schindelin <Johannes.Sch=
indelin@gmx.de> wrote:
> > -				if (!strcmp(main_cmds.names[i]->name, all_strategy[j].name))
> > +				if (!strncmp(ent->name, all_strategy[j].name, ent->len))
>=20
> Oops... that is not what I meant.  You'd have to check if=20
> !all_strategy[j].name[ent->len], too...

Hmm. So let's say ent->name is "ours.exe", ent->len is set to 4.

Then !strncmp(ent->name, all_strategy[j].name, ent->len) will be true,
and the command will not be added to the exclude list.

However, if I check for !all_strategy[j].name[ent->len], that will be
false, so 'ours' will be excluded from the available strategy list.

Have I missed something?

Thanks.

--+U0EQ97FbU8QddnY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiLShYACgkQe81tAgORUJbBFwCfekVfGrP3seQXH3xilivzSwiv
6ykAn20QBm7GKkm+b+LIZGpBlbI4YSzT
=SF3c
-----END PGP SIGNATURE-----

--+U0EQ97FbU8QddnY--
