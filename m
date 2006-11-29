X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Submodules in GIT
Date: Wed, 29 Nov 2006 17:15:43 +0100
Message-ID: <20061129161543.GG18810@admingilde.org>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200611281335.38728.andyparkins@gmail.com> <20061128154434.GD28337@spearce.org> <200611281629.08636.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NQTVMVnDVuULnIzU"
NNTP-Posting-Date: Wed, 29 Nov 2006 16:16:47 +0000 (UTC)
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200611281629.08636.andyparkins@gmail.com>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32649>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpS6K-0003qk-5K for gcvg-git@gmane.org; Wed, 29 Nov
 2006 17:16:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967460AbWK2QP4 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 11:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967462AbWK2QP4
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 11:15:56 -0500
Received: from agent.admingilde.org ([213.95.21.5]:57773 "EHLO
 mail.admingilde.org") by vger.kernel.org with ESMTP id S967460AbWK2QPz (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 11:15:55 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1GpS63-0005f5-Qd; Wed, 29 Nov 2006 17:15:43 +0100
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org


--NQTVMVnDVuULnIzU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Tue, Nov 28, 2006 at 04:29:05PM +0000, Andy Parkins wrote:
> In summary, from the supermodule's point of view:
>  * A submodule with changed working directory is "dirty-wd"
>  * A submodule with changed index is "dirty-idx" from the supermodule's
>  * A submodule with changed HEAD (since the last supermodule commit)=20
>    is "changed but not updated" and can hence be "update-index"ed into the
>    supermodule
>  * A submodule with changed HEAD that has been added to the supermodule i=
ndex
>    is "updated but not checked in"
>  * A submodule with changed HEAD (since the last supermodule update-index=
) is
>    both "changed but not updated" _and_ "updated but not checked in", jus=
t=20
>    like any normal file.

when tracking refs/heads/master instead of HEAD, you also get:
   * A submodule where HEAD is not pointing to refs/heads/master is
     "dirty-branch" or something.


> What's needed then:
>  * A way of telling git to treat a particular directory as a submodule in=
stead
>    of a directory
This is handled by creating a GIT repository in this directory.
My current implementation needs some more magic by the user to add it to
the index, but I plan to change this to the way that GIT repositories
will be recognized as possible submodules.

>  * git-status gets knowledge of how to check for "dirty" submodules
This is on top of my TODO.

>  * git-commit-tree learns about how to store "submodule" object types in
>    trees.  The submodule object type will be nothing more than the hash o=
f the
>    current HEAD commit.  (This might be my ignorance, perhaps it's just=
=20
>    update-index that needs to know this)
it's only update-index that has to know this.
Otherwise it would be implicitly updated and you would never get your
"changed but not updated" status as above.


--=20
Martin Waitz

--NQTVMVnDVuULnIzU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFbbIvj/Eaxd/oD7IRAv6ZAJ9W909185K/byVc91ctIBsqlkM9hACfZhzD
FDHKPq/XhUbPIOcZkZNnVtk=
=sT3j
-----END PGP SIGNATURE-----

