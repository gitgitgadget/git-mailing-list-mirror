From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: Issues building docs on an offline box again.
Date: Tue, 24 Feb 2009 09:51:55 -0500
Message-ID: <1235486982-sup-7798@ntdws12.chass.utoronto.ca>
References: <c115fd3c0902231507k46da3294yf2726a92cb0fbc1a@mail.gmail.com> <20090224022856.GN4371@genesis.frugalware.org> <c115fd3c0902240504y9fe6ce4m65ba73ce2937cb9e@mail.gmail.com> <20090224140747.GS4371@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; boundary="=-1235487115-895246-26579-1259-28-="; micalg="pgp-sha1"
To: Tim Visher <tim.visher@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 24 15:53:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbyf3-0004E0-7W
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 15:53:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756812AbZBXOv7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 09:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756678AbZBXOv6
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 09:51:58 -0500
Received: from www.cquest.utoronto.ca ([192.82.128.5]:56494 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756634AbZBXOv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 09:51:58 -0500
Received: from ntdws12.chass.utoronto.ca ([128.100.160.253] ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1LbydY-0000dI-23; Tue, 24 Feb 2009 09:51:56 -0500
Received: from localhost
	([127.0.0.1] helo=ntdws12.chass.utoronto.ca ident=505)
	by ntdws12.chass.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1LbydX-000444-Uj; Tue, 24 Feb 2009 09:51:55 -0500
Received: (from bwalton@localhost)
	by ntdws12.chass.utoronto.ca (8.13.8/8.13.8/Submit) id n1OEptvh015624;
	Tue, 24 Feb 2009 09:51:55 -0500
In-Reply-To: <20090224140747.GS4371@genesis.frugalware.org>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111293>


--=-1235487115-895246-26579-1259-28-=
Content-Type: text/plain; charset=UTF-8

Excerpts from Miklos Vajna's message of Tue Feb 24 09:07:47 -0500 2009:
> I'm not a docbook expert, either - but It seems the url your config
> rewrites is http://www.oasis-open.org/docbook/xml/4.2, while the url you
> try to access during the build is
> http://docbook.sourceforge.net/release/xsl/current. So I *think* you
> need to add two other entries as well for the xsl urls, but I'm just
> guessing.

I'm no expert either, but I just became more familiar after packaging
it for OpenCSW (just to build the git docs!).  It's likely that your
docbook dtds are fine but the xsl stylesheets are either missing or
broken.

Try looking at the docbook stylesheets (xsl in particular) packages in
your cygwin setup.  There should be lines like:

<rewriteSystem systemIdStartString="http://docbook.sourceforge.net/release/xsl
/current" rewritePrefix="file:///usr/share/sgml/docbook/xsl-stylesheets-1.69.1-5
.1"/>
<rewriteURI uriStartString="http://docbook.sourceforge.net/release/xsl/current "rewritePrefix="file:///usr/share/sgml/docbook/xsl-stylesheets-1.69.1-5.1"/>

to handle the remapping you require.  This was from the
/etc/xml/catalog file on rhel5, but it should be _similar_ on a cygwin
setup (my cygwin boxes aren't outfitted with the docbook toolchain so
I can't verify for you).

HTH.
-Ben
-- 
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302

GPG Key Id: 8E89F6D2; Key Server: pgp.mit.edu
Contact me to arrange for a CAcert assurance meeting.

--=-1235487115-895246-26579-1259-28-=
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFJpAmL8vuMHY6J9tIRAgzOAKCra4MfQQbrNpxkN160BFK9tR67VQCfZclC
hYdOvqa4rCpoDbe5hnVY1gk=
=JQRf
-----END PGP SIGNATURE-----

--=-1235487115-895246-26579-1259-28-=--
