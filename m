X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Submodules in GIT
Date: Thu, 30 Nov 2006 18:19:49 +0100
Message-ID: <20061130171949.GI18810@admingilde.org>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200611301449.55171.andyparkins@gmail.com> <20061130152011.GM12463MdfPADPa@greensroom.kotnet.org> <200611301530.51171.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PW0Eas8rCkcu1VkF"
NNTP-Posting-Date: Thu, 30 Nov 2006 17:20:23 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200611301530.51171.andyparkins@gmail.com>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32780>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GppZh-0007DL-Ks for gcvg-git@gmane.org; Thu, 30 Nov
 2006 18:19:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030833AbWK3RTv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 12:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030835AbWK3RTv
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 12:19:51 -0500
Received: from agent.admingilde.org ([213.95.21.5]:15068 "EHLO
 mail.admingilde.org") by vger.kernel.org with ESMTP id S1030829AbWK3RTu
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 12:19:50 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1GppZd-0004tl-Ko; Thu, 30 Nov 2006 18:19:49 +0100
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org


--PW0Eas8rCkcu1VkF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Thu, Nov 30, 2006 at 03:30:49PM +0000, Andy Parkins wrote:
> Well, I know what the commit is /that/ was all that was stored.  So I=20
> (actually supermodule-git does):
>=20
> cd $DIRECTORY_ASSOCIATED_WITH_SUBMODULE
> git checkout -f $COMMIT_FROM_SUPERMODULE
>=20
> Obviously, this is grossly simplified.  It also requires that HEAD be all=
owed=20
> to be an arbitrary commit rather than a branch, but that's already been=
=20
> generally agreed upon as a good thing.

It's not that easy.

You also have to make sure that all your submodule commits that _ever_
have been part of your submodule have be stay in your repository
forever.
Consider that your submodule switches to an other branch and some
old commits are not referenced by the current version any more.
These old commits still have to survive a git-prune, if they have been
part of some old supermodule version.
So you really have to connect both object databases and it's not enough
to just store the commit sha1 without actually parsing it by the GIT
core.

--=20
Martin Waitz

--PW0Eas8rCkcu1VkF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFbxK1j/Eaxd/oD7IRAtozAJ477SfCnVw7xWOCLEkDn/mxqKxv/gCdFPmE
o+6Iu3n039WLuCAHyXokL2g=
=sx55
-----END PGP SIGNATURE-----

