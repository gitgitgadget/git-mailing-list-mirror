From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 1/8] Add basic Coccinelle transforms.
Date: Tue, 7 Jun 2016 02:31:44 +0000
Message-ID: <20160607023144.GA72717@vauxhall.crustytoothpaste.net>
References: <20160607005716.69222-2-sandals@crustytoothpaste.net>
 <xmqqk2i1u3zn.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 04:31:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bA6o7-0007d0-33
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 04:31:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752857AbcFGCbv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 22:31:51 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:40834 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751126AbcFGCbu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2016 22:31:50 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id A7DCF282A8;
	Tue,  7 Jun 2016 02:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1465266708;
	bh=hiswytJMnKu9OGRPYDKlPg+XAfGkmVvTXqN551W+e0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OTZW7eW89oELuEweeO0oVQyD9YVFIukBf28+Ykc83x/JtNWB8c5O32rzbAmmfp3DB
	 1QTeN+DdnzgzTNM2PMhYuJmrx81SoL8P+TMX01SMWuS+DQINUvYq2d0FeKAoGnlx0b
	 mFM622TY0ajzPoT+HcdpXjl0swsfOs795gkxh7r6kYDr9J6EcE92TfglUH0RkcqIRw
	 muw6E9hQP/sQG5pyFm2Pbpv0DZjYSSihhQeTmmz8zY/N1xbmN8w/B42mHSVoKvZ86D
	 159LqyUcOVBNGKIYPx7f85yBjMpZg4a9Bj8mNUvGVK+vjgbLl4ps2FNLuDDh23EyNk
	 tK+UapHvCKlKIXDH3VHQzswx7LjSq08MXPOCKGCsf6GYhw5O/MJEbr46U3QAyIWLjO
	 6RLvxcDlr06vzIRc/K8aZrtRemlNfCS2D572GvDntdfNmGjkg90kUnMuwf7i6IF9He
	 4m3LVsGI6GvR5Eh61VRP4AZXHtmUrM53+ZercCGGkSzMpvXg9Nw
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
Content-Disposition: inline
In-Reply-To: <xmqqk2i1u3zn.fsf@gitster.mtv.corp.google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.6.0-trunk-amd64)
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296591>


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 06, 2016 at 07:28:28PM -0700, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > Coccinelle (http://coccinelle.lip6.fr/) is a program which performs
> > mechanical transformations on C programs using semantic patches.  These
> > semantic patches can be used to implement automatic refactoring and
> > maintenance tasks.
> >
> > Add a set of basic semantic patches to convert common patterns related
> > to the struct object_id transformation.
> >
> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> > ---
> > I realize the name and location of this file might be suboptimal.
> > Suggestions on better locations and filenames would be appreciated.
>=20
> Once is_null_sha1() is updated to is_null_oid(), the first rewrite
> definition would become useless, no?  I am not sure what the point
> is to keep this file in our history.

It might not be generally useful to keep forever.  I generally have
applied this set of transforms after each of the other semantic patches,
but I can simply refer to "a standard set of transforms" if you think
that's better, or I can post a URL with those somewhere to refer to.

My goal here is simply to avoid needing to include this set of
transformations in each commit message, which would tend to bloat it
considerably.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.12 (GNU/Linux)

iQIcBAEBCgAGBQJXVjIQAAoJEL9TXYEfUvaLR0kP/iiIPMZzalLtJdXRvIuT9iIx
D7oesqOiOCd96woSUu6vzrq09XhBCv4BxQW1EzDHDkXd2rjro8qgOgPLV8kLNQOB
ym2pjjU8KUgCsMMK7d8JBfbDwnRbMKAukuUg/hsohhMkh9HwBbmZAjgoL51MKX0t
hqQLktZSwU7y7jTsvOpIANarxM41qMu/oQi//kc6aj1RGu7KsVN5pgWZDVon1W0O
q594fHowpu7kxqC91MkdWg6ejbk0RAu4k5quJGYpW5tZCH7Q5Lw/1Ckiq7rX9Y3R
e8qlPuLURTBJKAml/2OAuppk1iMuLknHKWYUUUOnC4jRSydgdlESjSh/PrW9tFOb
CSwRgAYhRcFoLTx8lcrtc+GEzsHwrL/o/IycXli15WGa17ctzJqPV+urK/7+m9Nx
C2Lg7cqxqvtWNCOCBxCdW+TyDCK4+R30QTh9VXO5s5oDVceib8hQ9UvaSQRwHCC+
z9zH0EKXtaiGW2e1JuYpiV/YWx7tFKMmFW0bhBXlv1/YZ14mUKSm/FYRm06J7T7C
IFctEaaNWlEwgjOYBHctQBED+t5wxz6iIxJfFa8u/QvAh9rX+kEJwWcdon2/P5tU
bMuCOJvnSE9ASqguqOI1k1JW4tmZ35jAN6ahD3RAEba3dFKV/mwgX3MaFLbySquh
2t/X8dorN2S+79G//YL3
=wuoF
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
