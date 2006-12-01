X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 1 Dec 2006 10:57:51 +0100
Message-ID: <20061201095751.GK18810@admingilde.org>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200611301449.55171.andyparkins@gmail.com> <456F0153.5000107@b-i-t.de> <200612010919.06030.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlxN1C6awaFNesUv"
NNTP-Posting-Date: Fri, 1 Dec 2006 09:58:06 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200612010919.06030.andyparkins@gmail.com>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32883>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq59a-00039M-At for gcvg-git@gmane.org; Fri, 01 Dec
 2006 10:57:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759300AbWLAJ5y (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 04:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759301AbWLAJ5y
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 04:57:54 -0500
Received: from agent.admingilde.org ([213.95.21.5]:65440 "EHLO
 mail.admingilde.org") by vger.kernel.org with ESMTP id S1759300AbWLAJ5w
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 04:57:52 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1Gq59T-0004Im-UQ; Fri, 01 Dec 2006 10:57:51 +0100
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org


--UlxN1C6awaFNesUv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Fri, Dec 01, 2006 at 09:19:04AM +0000, Andy Parkins wrote:
> Let's imagine a supermodule repository, and guess at it in more detail (I=
'll=20
> abbreviate some of the less interesting output):
>=20
> $ git-cat-file -p HEAD
> tree fb02e78085ecf2f29045603df858b5362e5bf8a4
> parent 4f2dba685507e4a8e07dac298c4024feaec6bd7d
> author Andy Parkins
> committer Andy Parkins=20
> $ git-cat-file -p fb02e78085ecf2f29045603df858b5362e5bf8a4
> 100644 blob 46bd4e284a57e2faa539e7b72d62a38867075af5    Makefile
> 040000 tree 49ea01373a986a3db44d66702714aa75059ffa2c    doc
> 040000 subm d0a877464dc0198667a3e27ed3af8448ddacf947    libxcb

at the moment, it is:
  140000 commit ccddf1d4b0cf7fd3a699d8b33cf5bc4c5c4435b7  libxcb

> The "subm" type is our new ODB object that's going to store whatever we w=
ill=20
> need to access the submodule.  "libxcb" has already told us where this=20
> submodule is in the supermodule tree.
>=20
> $ git-cat-file -p d0a877464dc0198667a3e27ed3af8448ddacf947
> submodulecommithash ccddf1d4b0cf7fd3a699d8b33cf5bc4c5c4435b7
> submoduleurlhint git://anongit.freedesktop.org/git/xcb/libxcb

So why do you need the url hint committed to the supermodule?
We don't store remote information in the object database, too.
Remember: this is still a distributed project, there is no one URL to
any submodule.

> I say:
>  submodulecommithash points at a commit /in the submodule/

But unluckily, this does not work.
You really have to be able to traverse the entire commit chain
=66rom the supermodule into all submodules.

--=20
Martin Waitz

--UlxN1C6awaFNesUv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFb/yfj/Eaxd/oD7IRAv9gAJ9MKKIRFn2vvKlM0vRz4B7VIkalUACcCRIo
w+RcDrU6iSjwDoWYrLLDa5U=
=sewp
-----END PGP SIGNATURE-----

