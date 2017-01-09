Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D3C81FEB3
	for <e@80x24.org>; Mon,  9 Jan 2017 12:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752495AbdAIMSz (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 07:18:55 -0500
Received: from userp1040.oracle.com ([156.151.31.81]:27058 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751166AbdAIMRy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 07:17:54 -0500
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v09CHrUx029772
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Jan 2017 12:17:53 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id v09CHqc5014263
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Mon, 9 Jan 2017 12:17:52 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.13.8/8.13.8) with ESMTP id v09CHo76014516;
        Mon, 9 Jan 2017 12:17:51 GMT
Received: from localhost (/10.175.238.166)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Jan 2017 04:17:49 -0800
Date:   Mon, 9 Jan 2017 13:22:51 +0100
From:   Quentin Casasnovas <quentin.casasnovas@oracle.com>
To:     Quentin Casasnovas <quentin.casasnovas@oracle.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Refreshing index timestamps without reading content
Message-ID: <20170109122251.GD7000@chrystal.oracle.com>
References: <20170105112359.GN8116@chrystal.oracle.com>
 <CACsJy8BRfJG6L49VyC+qsrQ9Arz0gCGpMATpK9uLq61Lx6_Jtg@mail.gmail.com>
 <20170109121724.GC7000@chrystal.oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gDGSpKKIBgtShtf+"
Content-Disposition: inline
In-Reply-To: <20170109121724.GC7000@chrystal.oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Source-IP: userv0022.oracle.com [156.151.31.74]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--gDGSpKKIBgtShtf+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 09, 2017 at 01:17:24PM +0100, Quentin Casasnovas wrote:
> On Mon, Jan 09, 2017 at 07:02:45PM +0700, Duy Nguyen wrote:
> > On Thu, Jan 5, 2017 at 6:23 PM, Quentin Casasnovas
> > <quentin.casasnovas@oracle.com> wrote:
> >=20
> > > If not, I am willing to implement a --assume-content-unchanged to the=
 git
> > > update-index if you guys don't see something fundamentally wrong with=
 this
> > > approach.
> >=20
> > If you do that, I think you should go with either of the following opti=
ons
> >=20
> > - Extend git-update-index --index-info to take stat info as well (or
> > maybe make a new option instead). Then you can feed stat info directly
> > to git without a use-case-specific "assume-content-unchanged".
> >=20
> > - Add "git update-index --touch" that does what "touch" does. In this
> > case, it blindly updates stat info to latest. But like touch, we can
> > also specify  mtime from command line if we need to. It's a bit less
> > generic than the above option, but easier to use.
> >=20
> > Caveat: The options I'm proposing can be rejected. So maybe wait a bit
> > to see how people feel and perhaps send an RFC patch, again to gauge
> > the reception.
>=20
>=20
> Hey Duy,
>=20
> Thanks for your answer.
>=20
> I've played with this a bit last week and added an extra command, which I
> called --refresh-stat, which works like your suggested --index.  It works
                                                         ^^^^^^^

Whoops, sorry!

[...] *a bit* like your suggested *--touch*. [...]

I don't really need it to support specific mtime from the CLI for my
different use cases, but if someone has some ideas in how that would be
useful, I can try implementing your --index-info change to support stat
information to be passed around instead of my current simple
implementation.

Q

--gDGSpKKIBgtShtf+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJYc4CbAAoJEB5Tt01po9cNAy4P/2Gjtk2780XG2BzNR2xhJvPP
ody0Kpw7/TWSMji7UT3lMP/cjDsxvctNou8lcdcTyotfbeEAQWUV5ifKXLDazu09
DsJXBI3cW8x7zuN8fQkdd9WDls0CSMTJ74V630qh8IGODcqpv15TcjNCuanKvxE6
FBWPvoMopNW3b0/q3cTolT7v9Yb562R42IeaA4SIdRVx687AgusFBFa7YRq0SK9+
sJ8m9LooiioQkuB0h9w+djYz0sq/H6qYGfLg1LiTSjXhvGvYupCb4xOYQ94Bephd
VBJu5wOHbau8fGhsib1A8tflGSPhQyw4terRElOP6KgJdq6hqXII3mEAqQQg+7Zu
ZU3GvzTiMqF6G863vrdGDkxIs58VGkYwprVH9xkYzQHP7lxEZj87K0CE878Jkypx
9uD1+HMo1yBzMlT5JV5JbMQ2h4zdWEQyGy+GvDGteNm6nZbhwgEdJk9azWiPBreN
WSpwt5M0GS5HJoRqIUKZR9V7sW6RPSyg7gzezaSA/rK9GEzvbP1QDXPZp0285PjN
llBJdIgjkyaoTcDvZ+wVipk6qKN2QBPi5KBqmjY/P56PAKqJHtFBZFS+xO/MJibb
ZhEryiySxNG6pjHmlUjKTZuhTM48njG+OIbqOBOZvuzXO//x3v6AO6hBY6L1Rsw0
MNQ/2DXBzUri7bbEt3XN
=bxNt
-----END PGP SIGNATURE-----

--gDGSpKKIBgtShtf+--
