Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2513D20A78
	for <e@80x24.org>; Thu,  2 Feb 2017 00:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751207AbdBBA0F (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 19:26:05 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:51286 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751052AbdBBA0E (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 1 Feb 2017 19:26:04 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 4A523280AD;
        Thu,  2 Feb 2017 00:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1485995162;
        bh=uIkCa0+4Wq6/NOaMnrD36vTwJaB/4p/XoyG5v7hlE+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kNYJkfdAI656F9BwAGhk3ZYjHHlBnHrEx0Nh7GtyvpXnTBsQ5oxVntymWZ3CLdvHu
         K/rjUEgLht58+oN58zc4BNBSltOC3rZWCxOlhUMdh4pvPK0sFlWEWjG7KCPr1iZp2I
         8vO5z1dNzS97e/cf85QGHHFcxwH9n8wD0dnsJ/VIeHnzXkSGE6Eh1215XFq5UTybdw
         8oaYj/XZa6wgAOE42DlReywpkiFmLIFxpeztCJsXhMsDnaLboNePM3SrKBYsTWRi5i
         3LxshBQTjErwgfz83iXUV0jA6M/sdei869i5sSMEuG+R+MCmDSxe6n+hhtaGsU/1de
         l56xbYAZs3C3E/du6sUX3f2hnZ+ZBToRAtXVwTI9OSa7UjYIuCB5b1ylCDv+DV70UC
         fqnUszv7N4WlMQgLNDeggzxc7Bn9vMz6liFEl64HwVKwvl0N+qBH3QijTQTloBAUTB
         Yk8ZTLMZDLuGY3CdiY5KakXmOUXq3w/PqG43DDcelFrbImtV8F+
Date:   Thu, 2 Feb 2017 00:25:57 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "Gumbel, Matthew K" <matthew.k.gumbel@intel.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git commit results in many lstat()s
Message-ID: <20170202002556.mn7pfu4442btru5v@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Gumbel, Matthew K" <matthew.k.gumbel@intel.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <DA0A42D68346B1469147552440A645039A9C56D4@ORSMSX115.amr.corp.intel.com>
 <xmqq8tppo92x.fsf@gitster.mtv.corp.google.com>
 <DA0A42D68346B1469147552440A645039A9C57D6@ORSMSX115.amr.corp.intel.com>
 <xmqq60ktmpwl.fsf@gitster.mtv.corp.google.com>
 <DA0A42D68346B1469147552440A645039A9C5929@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xcvocajjra7dgx4v"
Content-Disposition: inline
In-Reply-To: <DA0A42D68346B1469147552440A645039A9C5929@ORSMSX115.amr.corp.intel.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-1-amd64)
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--xcvocajjra7dgx4v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 02, 2017 at 12:14:30AM +0000, Gumbel, Matthew K wrote:
> I'm testing such a change locally. Git test suite seems to be running for=
 quite
> a while. Do you know any way to run it in parallel or otherwise speed it
> up?

I usually do something like the following:

  make -j3 all && (cd t && GIT_PROVE_OPTS=3D-j3 make prove)

This, of course, requires that you have Perl's prove installed, which
has been part of core Perl since 5.10.1.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--xcvocajjra7dgx4v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAliSfJQACgkQv1NdgR9S
9ouI+A/7BCgF/rq8L55UHkIe5GmUrKyno0wcE8/J40fb6CXpPeB8O/c/USzC2/8o
qGtYT/pw4Xj97lIQ/dQXwZIzJ7fm6nwOwZmyKMudFEF55wISFBa5rL/tSQvb/ddi
Qnu7MwO7sT6Qe46Wq5XaGInXQkqWLTg9tqL6t0J8OE2MSelt5lKzA/nnmuXidP/S
Ce8uWohlO3hIRNfkNxZ1WQ7NkFCwZ5DHHRYFCJ1rueg6qlJLCJpaeYxJs+kcPhNg
AY491aeEdr+3kuc/Ngo/Ie2Oh/bzCQEmmWA8dKTzfoImu/IheTZtAhb5CFqid+tB
+ZOL6vlydG5zHyfzABBjjWt7jrYoDJ7gsMn16MvLz2C2eXQ1v5HmJZx6NFEf+4E6
111BtXGvyopfk0cLxWRlROuBFWxLCkT+QqSzIN61rmZ5DOh2XRgi84pi+CFdoy9s
hp++HaPg7tXR97DVNlJ1S6YR34bXqeCp3nKTgE+YgRvs8ZyBx5vaYx6lSumDc0NC
1UjLNhOLSDnkyi9GVc6/Cuq88a+OdxmPP+balW9S2f4i8IpTPjnWpQY9EK1ir4S9
sQvFdC5nOL98YkgQlFKAFQabKpPu4ax846qO1MiVz7DA0YwDvrAKyoLKk0mquGF5
OQ/pHnTHDrzc97ZnG131XsJuRkyjPKwKg7sTjwhDr6QFispK5gw=
=Q8hE
-----END PGP SIGNATURE-----

--xcvocajjra7dgx4v--
