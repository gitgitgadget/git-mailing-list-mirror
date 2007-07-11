From: Jan Hudec <bulb@ucw.cz>
Subject: Re: git-rm isn't the inverse action of git-add
Date: Wed, 11 Jul 2007 20:56:44 +0200
Message-ID: <20070711185644.GA3069@efreet.light.src>
References: <46893F61.5060401@jaeger.mine.nu> <20070702194237.GN7730@nan92-1-81-57-214-146.fbx.proxad.net> <46895EA4.5040803@jaeger.mine.nu> <f72hu8$65g$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 20:57:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8hNQ-00017h-OJ
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 20:57:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761283AbXGKS5A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 14:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759836AbXGKS47
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 14:56:59 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:40120 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759414AbXGKS46 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 14:56:58 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 655D257397;
	Wed, 11 Jul 2007 20:56:57 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id bCGPr3ZGABNN; Wed, 11 Jul 2007 20:56:55 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id AF4C7572C7;
	Wed, 11 Jul 2007 20:56:55 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1I8hMj-0002fv-3e; Wed, 11 Jul 2007 20:56:45 +0200
Content-Disposition: inline
In-Reply-To: <f72hu8$65g$1@sea.gmane.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52189>


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 11, 2007 at 14:20:24 +0200, Jakub Narebski wrote:
> Christian Jaeger wrote:
> > I don't per se require undo actions. I just don't understand why git-rm
> > refuses to remove the file from the index, even if I didn't commit it.
> > The index is just an intermediate record of the changes in my
> > understandings, and the rm action would also be intermediate until it's
> > being committed. And a non-committed action being deleted shouldn't need
> > a special confirmation from me, especially not one which is consisting
> > of a combination of two flags (of which one is a destructive one).
>=20
> Should git-rm refuse to remove index entry if it is different from working
> directory version or not?

IMHO it should refuse to remove index entry if it is different from both
working-tree version and versions in all parents.

If index matches any of that, but the working tree version does not match a=
ny
parent, the index entry should be removed (which currently isn't -- that's
the proposed change), but the file left in wokring tree. That would make
git-add + git-rm get you right back where you started, with nothing in index
and unversioned file in working tree.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGlSfsRel1vVwhjGURAi5nAKDJKgQB1xMES+Gs8YRLYAucti5rfwCg5NMC
90BJmhXxo4H86DYVlurlWiY=
=Dqkv
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
