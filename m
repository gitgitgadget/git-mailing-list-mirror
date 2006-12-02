X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Submodules in GIT
Date: Sat, 2 Dec 2006 21:40:12 +0100
Message-ID: <20061202204012.GU18810@admingilde.org>
References: <20061130170625.GH18810@admingilde.org> <200612012154.33834.andyparkins@gmail.com> <20061201220821.GL18810@admingilde.org> <200612021004.22236.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XbOGSHoyTtRSevGh"
NNTP-Posting-Date: Sat, 2 Dec 2006 20:40:26 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200612021004.22236.andyparkins@gmail.com>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33044>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gqben-0000eV-3J for gcvg-git@gmane.org; Sat, 02 Dec
 2006 21:40:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162265AbWLBUkP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 15:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162461AbWLBUkP
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 15:40:15 -0500
Received: from agent.admingilde.org ([213.95.21.5]:30372 "EHLO
 mail.admingilde.org") by vger.kernel.org with ESMTP id S1162265AbWLBUkN
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 15:40:13 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1Gqbee-0004iF-PC; Sat, 02 Dec 2006 21:40:12 +0100
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org


--XbOGSHoyTtRSevGh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Sat, Dec 02, 2006 at 10:04:20AM +0000, Andy Parkins wrote:
> On Friday 2006, December 01 22:08, Martin Waitz wrote:
>=20
> > > echo $SUBMODULE_HASH >
> > > submodule/.git/refs/supermodules/commit$SUPERMODULE_HASH
> >
> > I guess you are aware that you have to scan _all_ trees inside _all_
> > supermodule commits for possible references.
>=20
> No you don't; you do it as part of the appropriate normal operations.
>=20
>  * supermodule commit - scan the current tree for "link" objects in the
>    tree.  If you find one write the reference in the submodule.
>  * adding a new submodule - if this is a new submodule there can't be any
>    references in the supermodule already.
>  * cloning a supermodule, every new commit that gets written in the=20
>    supermodule gets checked from "link" objects.

 * removing a branch from the supermodule.
   OK, this is an infrequent operation and it can be handled by redoing
   everything.

I just don't like to duplicate information which is already available
easily.  We'd need much to many special cases, just to correctly support
reachablility analysis.
KISS.

> > So what do you do with deleted submodules?
> > You wouldn't want them to still sit around in your working directory,
> > but you still have to preserve them.
>=20
> Now that is a tricky one.  Mind you, I think that problem exists for any=
=20
> implementation.  I haven't got a good answer for that.

If you just keep it in a shared object repository you don't have any
problems.

Please note that it is not required to keep it in one physical location.
You can still use alternates/whatever to store some objects in another
repository, but you need to be able to access all objects from the
supermodule.

--=20
Martin Waitz

--XbOGSHoyTtRSevGh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFceSsj/Eaxd/oD7IRAl9+AJ9AeFrDFLiVUDJ8Q4HwWJHUOqNhogCePSp4
FkvK2pM/prnQQcuU/AdSLbY=
=3j0e
-----END PGP SIGNATURE-----

