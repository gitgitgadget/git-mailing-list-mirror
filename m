From: CJ van den Berg <cj@vdbonline.com>
Subject: Re: git fetch inside a bare repo does nothing
Date: Fri, 13 Jul 2007 13:32:10 +0200
Message-ID: <20070713113209.GA9046@prefect.vdbonline.net>
References: <20070713103303.GD18199@xp.machine.xx>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 13 13:32:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9JOF-0007QH-9Z
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 13:32:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754891AbXGMLcO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 07:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754862AbXGMLcO
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 07:32:14 -0400
Received: from marvin.vdbonline.net ([208.78.101.188]:60635 "EHLO
	marvin.vdbonline.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754431AbXGMLcN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 07:32:13 -0400
Received: from marvin.vdbonline.net (localhost [127.0.0.1])
	by marvin.vdbonline.net (Postfix) with ESMTP id 2BF9868099
	for <git@vger.kernel.org>; Fri, 13 Jul 2007 13:32:12 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	marvin.vdbonline.net
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	SPF_HELO_PASS autolearn=ham version=3.1.7-deb
Received: from prefect.vdbonline.net (localhost [127.0.0.1])
	by marvin.vdbonline.net (Postfix) with ESMTP
	for <git@vger.kernel.org>; Fri, 13 Jul 2007 13:32:12 +0200 (CEST)
Received: by prefect.vdbonline.net (Postfix, from userid 1000)
	id 720994D427C; Fri, 13 Jul 2007 13:32:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070713103303.GD18199@xp.machine.xx>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52385>


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 13, 2007 at 12:33:03PM +0200, Peter Baumann wrote:
> kblin on IRC wanted to know how to update a bare repo with fetching.
> He wants to have a bare repo of samba as a mirror and clone from this
> mirror to avoid network traffic and to have several git repos which
> could all have a different branch checked out. For a better description
> see [1].
>=20
> I suggested to use "git fetch --bare" inside the bare repo, but this
> doesn't work. So what I'm asking now if this is intenional behaviour or
> a bug, so please could someone  shed some light on it?  Or how is the
> prefered method to update a bare repo *without* pushing to it?

"git fetch" works fine in a bare repo. The issue you're probably having is
that "git clone --bare" does not add a [remote "origin"] section to the
config file like regular "git clone" does, so "git fetch" has nothing to
do. Just add a remote section (either with "git remote add" or manually) and
regular "git fetch" will work fine.

Just for reference, this is the remote section that is equivalent to the
original "git clone --bare your_uri_here":

[remote "origin"]
        url =3D your_uri_here
        fetch =3D +refs/heads/*:refs/heads/*


--=20
CJ van den Berg

mailto:cj@vdbonline.com
  xmpp:cj@vdbonline.com

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGl2K5l3pZXfh0CHIRAqnTAJ45XNle48om9eZcvF7TTSpnlyL4EQCgozgq
fwYxgHZxsJdqJCUcsPhgWCI=
=CHit
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
