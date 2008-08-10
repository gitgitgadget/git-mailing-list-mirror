From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [RFC] Plumbing-only support for storing object metadata
Date: Sun, 10 Aug 2008 20:11:16 +0200
Message-ID: <20080810181115.GA3906@efreet.light.src>
References: <20080809210733.GA6637@oh.minilop.net> <d411cc4a0808091449n7e0c9b7et7980cf668106aead@mail.gmail.com> <20080810035101.GA22664@spearce.org> <20080810112038.GB30892@cuci.nl> <alpine.DEB.1.10.0808100502530.32620@asgard.lang.hm> <20080810145019.GC3955@efreet.light.src> <20080810175735.GA14237@cuci.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Cc: david@lang.hm, "Shawn O. Pearce" <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>,
	Jamey Sharp <jamey@minilop.net>,
	Josh Triplett <josh@freedesktop.org>, git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Sun Aug 10 20:12:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSFP2-0005Or-SM
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 20:12:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752223AbYHJSL0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 14:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752113AbYHJSL0
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 14:11:26 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:48162 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751967AbYHJSLZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 14:11:25 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 6A1015732C;
	Sun, 10 Aug 2008 20:11:24 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id UrrU1Cpe-PI1; Sun, 10 Aug 2008 20:11:21 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 48C2657325;
	Sun, 10 Aug 2008 20:11:20 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.69)
	(envelope-from <bulb@ucw.cz>)
	id 1KSFNs-0001BS-48; Sun, 10 Aug 2008 20:11:16 +0200
Content-Disposition: inline
In-Reply-To: <20080810175735.GA14237@cuci.nl>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91861>


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 10, 2008 at 19:57:35 +0200, Stephen R. van den Berg wrote:
> Jan Hudec wrote:
> >On Sun, Aug 10, 2008 at 05:16:47 -0700, david@lang.hm wrote:
> >> On Sun, 10 Aug 2008, Stephen R. van den Berg wrote:
> >>> However, pondering the idea a bit more, I could envision something
> >>> similar to the following:
>=20
> >.... provided the two entries under the same name wouldn't drive the int=
ernal
> >logic completely mad, I quite like this. Note by the way, that you need =
to
> >allow for two trees too, because you may want to store attributes for
>=20
> Well, in theory yes, but currently git doesn't store directories.

It depends. It does store directories in the tree objects, it just does not
do that in index. And we are talking about tree objects, where git does sto=
re
directories.

Besides, that is irrelevant to storing attributes for directories -- the
attribute objects are not themselves directories, so git would store them
just fine.

> How about extending git-core to allow for storage of directories by
> virtue of the following object in a tree:
>=20
> 040000 blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391  .
>=20
> I.e. the hash belongs to the empty blob.

Sorry, but this is insane. If git was to store anything for empty
directories, it would be empty tree, not a tree containing empty blob called
'.'. There was even a prototype patch to do that sent to the list (I believe
it was from Linus and was part of an argument along the lines "you could do
it like this, so stop talking and finish it if you have good enough reason =
to
want it (which you obviously don't)").

> Normally you don't (have to) store these directory blobs, but if you
> insist on having them, git will create the empty directory on checkout
> (i.e. you wouldn't need the dummy file trick anymore to force the
> directory to be present).

No, I don't give a damn about directories themselves. I want to store their
attributes, which is completely different thing.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkifL0MACgkQRel1vVwhjGXiuACeOWYvBchl+9dpXdMpXiLaHvop
+fwAoIoludfuRiKB2aWtzyT0HLmoO7CQ
=k/zY
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
