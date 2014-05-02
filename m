From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v6 4/7] pull: add --merge option
Date: Fri, 2 May 2014 19:32:50 +0000
Message-ID: <20140502193250.GF75770@vauxhall.crustytoothpaste.net>
References: <1398988808-29678-1-git-send-email-felipe.contreras@gmail.com>
 <1398988808-29678-5-git-send-email-felipe.contreras@gmail.com>
 <20140502013753.GE75770@vauxhall.crustytoothpaste.net>
 <536305def1e35_23b2147b2f0bb@nysa.notmuch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s5/bjXLgkIwAv6Hi"
Cc: git@vger.kernel.org, Andreas Krey <a.krey@gmx.de>,
	John Keeping <john@keeping.me.uk>, Jeff King <peff@peff.net>,
	Richard Hansen <rhansen@bbn.com>,
	Philip Oakley <philipoakley@iee.org>,
	"W. Trevor King" <wking@tremily.us>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 02 21:33:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgJCf-00016z-7I
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 21:33:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752790AbaEBTc5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 15:32:57 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:47488 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751902AbaEBTc4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 May 2014 15:32:56 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:406f:e13c:7c96:bfde])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 0F74028087;
	Fri,  2 May 2014 19:32:55 +0000 (UTC)
Mail-Followup-To: Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org, Andreas Krey <a.krey@gmx.de>,
	John Keeping <john@keeping.me.uk>, Jeff King <peff@peff.net>,
	Richard Hansen <rhansen@bbn.com>,
	Philip Oakley <philipoakley@iee.org>,
	"W. Trevor King" <wking@tremily.us>
Content-Disposition: inline
In-Reply-To: <536305def1e35_23b2147b2f0bb@nysa.notmuch>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.14-trunk-rt-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247960>


--s5/bjXLgkIwAv6Hi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 01, 2014 at 09:41:34PM -0500, Felipe Contreras wrote:
> brian m. carlson wrote:
> > On Thu, May 01, 2014 at 07:00:05PM -0500, Felipe Contreras wrote:
> > > Also, deprecate --no-rebase since there's no need for it any more.
> > >=20
> > > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > > ---
> > >  Documentation/git-pull.txt |  8 ++++++--
> > >  git-pull.sh                | 10 +++++++++-
> > >  2 files changed, 15 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
> > > index 9a91b9f..767bca3 100644
> > > --- a/Documentation/git-pull.txt
> > > +++ b/Documentation/git-pull.txt
> > > @@ -127,8 +127,12 @@ It rewrites history, which does not bode well wh=
en you
> > >  published that history already.  Do *not* use this option
> > >  unless you have read linkgit:git-rebase[1] carefully.
> > > =20
> > > ---no-rebase::
> > > -	Override earlier --rebase.
> > > +-m::
> > > +--merge::
> > > +	Force a merge.
> > > ++
> > > +See `pull.mode`, `branch.<name>.pullmode` in linkgit:git-config[1] i=
f you want
> > > +to make `git pull` always use `--merge`.
> >=20
> > So I'm confused here, and maybe you can enlighten me.  As I read this
> > documentation, --merge would always force a merge, like --no-ff.  If so,
> > I don't see an option to preserve the existing behavior, which is the
> > I-don't-care-just-do-it case.  If the behavior is different, then this
> > documentation needs to be improved, I think, along with the
> > documentation earlier in the series.
>=20
> I don't understand what is your point.
>=20
> So basically you think these should be the same?
>=20
>   % git pull --merge --no-merge --rebase --no-rebase
>   % git pull

My point is that it's unclear to me what options I need to use to retain
the current behavior (fast-forward if possible, merge otherwise) without
a warning.  Right now, it looks like --merge is equivalent to --no-ff,
which seems silly, since we already have an option for that.

So my request is that you add an option (command-line and configuration)
that maintains the current behavior, or if there's already such an
option, that the documentation be clear enough so that I can figure it
out.  Because right now, it's not.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--s5/bjXLgkIwAv6Hi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTY/LiAAoJEL9TXYEfUvaLEVIP/iPZ6k3JmDGbyI4fawCU+gBF
QyBICWzze49G3mMnm8437X1zMltS+hKxnLTADRcvHJLmbWdRNq8S+X+N4xW5alfi
wyMbwiDFv5/rjYbXStpt75ulww9t6xFbH4v494dnQHGOEUEi0mN2LKsV0t72CSb3
TWHfdQa8l3laXhKswqpV2pKaIWec5RP49K9kAuteLy2ivqhAjY/5UN8v5emIIl7C
XiVqvT87IoCW5cpn8AgawH0r2ObcTwtef0VWGXo8lOgLrLN80Je5EtBY1mQzZz6S
uikhOfUMGqzHQc5Azdl/Y5qmPBD3c8T+T+wiwJX2rlR1sTFb7F0NBSHm9znN5jwj
paEjzoXT83Hkm7mKlONAZam3PB8DNbKOXWqkOhfr734EW9Q8z4h+QG6+/3d5AgPI
1IBxCyxypWUB+17zLRV323dKrqGOKJ7EReHExEEOIz89jMEabmwz7spQycoBdh0x
BtUbFMk5ZPbUVgYjHGO7RvCpqB8qmRDLyCo07+CpEnDlFyxNKyLQiDD0TD1wh6l4
h3iOo/zwIuhuq3FuMMEmo4IcaAJIlDpbWa2z7U8BcBKqNoq7aAWwbfWsorh7Te/p
aqqCQQoEAYzBLgZ8l9iC+qeDIyHl3B0xsKOHoXJAg/jLRE23atXa9i9jVTWzA1uy
DE7FQ+nlkbwfU6fU4nuZ
=fJ3o
-----END PGP SIGNATURE-----

--s5/bjXLgkIwAv6Hi--
