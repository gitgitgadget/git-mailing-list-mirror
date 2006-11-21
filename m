X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Submodules in GIT
Date: Tue, 21 Nov 2006 12:49:39 +0100
Message-ID: <20061121114938.GI20736@admingilde.org>
References: <20061120215116.GA20736@admingilde.org> <ejt9dh$kfm$1@sea.gmane.org> <7v7ixp20za.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611201501230.3338@woody.osdl.org> <7v4pstzmk5.fsf@assigned-by-dhcp.cox.net> <ejthuh$fn8$1@sea.gmane.org> <20061121062158.GF20736@admingilde.org> <ejuit4$mg$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VkVuOCYP9O7H3CXI"
NNTP-Posting-Date: Tue, 21 Nov 2006 11:49:55 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <ejuit4$mg$1@sea.gmane.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31986>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmU8G-0000FI-8t for gcvg-git@gmane.org; Tue, 21 Nov
 2006 12:49:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030897AbWKULtl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 06:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030898AbWKULtk
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 06:49:40 -0500
Received: from agent.admingilde.org ([213.95.21.5]:52455 "EHLO
 mail.admingilde.org") by vger.kernel.org with ESMTP id S1030897AbWKULtk
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 06:49:40 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1GmU8B-0001r2-3m; Tue, 21 Nov 2006 12:49:39 +0100
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org


--VkVuOCYP9O7H3CXI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Tue, Nov 21, 2006 at 11:04:46AM +0100, Jakub Narebski wrote:
> "bind" header in commit objects is meant as a kind of shortcut, to ease
> reachability checking (you don't need to recurse into directories).

Well, but you already have to recurse to find all objects which are
reachable by a commit, so you don't loose anything.

> > The advantage in your proposal would be that submodules would
> > be visible immediately when looking at the commit,
> > without having to traverse the entire tree.
> > This may be worthwhile when showing the combined history of parent
> > and submodules.
>=20
> That was the idea.

On the other hand that only has to be done once anyway.
After you traversed the tree once you can create your own
(in memory) cache of submodules connected to the tree.
While walking the commits backwards, you only have to check those
parts of the tree which have changed.
So it may even be suitable for larger repositories.
But clearly it is not as low as with the in-commit cache.
So we have to weight complexity of the data storage with
runtime complexity.  Opinions?

--=20
Martin Waitz

--VkVuOCYP9O7H3CXI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFYufSj/Eaxd/oD7IRAjWrAJ4vy4uRBCJ6PjcSY9Iar99S63M12QCdFJkz
0B3/mqxDlkdjUlMoeOOQYz8=
=OVux
-----END PGP SIGNATURE-----

