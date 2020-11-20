Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3815BC388F9
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 02:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEF8722256
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 02:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbgKTCJd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 21:09:33 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:44218 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725887AbgKTCJd (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 19 Nov 2020 21:09:33 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 760E86045A;
        Fri, 20 Nov 2020 02:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1605838172;
        bh=Dg6syPnsXvNIG17coh1LelZzeWbskEDcz64rPfFmboY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=A8Bj3CPXgCJ8A2EeIQsLRwtpehgldMOAc660sPBxYEfbn5pja+OcVYKFZv1Fw4xQa
         ggz2Wkbs0fbpcriPO3azzgFWowghvpYDEldF/09pv58PknYzPv91C6AxHC1ZMVwj73
         As/T5z5w4o58I4S9aJhKB0mDB/5JVJivT3DmSgrab6bvE4ADWdgfs0cJPhNe/0IuT+
         7JBpFs9sXMVoqEsVfRobaP7ddmUcym2Hc0xeu8n7EQR9aMiK1zeBiUrcXUB0hG2TfT
         60PAr1twl7SR/KCcYKeyAHKima/+BuHhPPV79ov9TheB1M0aXDaHADWiVNtaHN9gHl
         LZ++fE9Na7yuigW2Zm9S4mjUxnozYu+lRM8encvvfIUld5PTpcmsVIllQcaEK5mWzu
         xpsU3DV7ooF6VAvKoUZdgct4svXJBs1xRKdJh8/MstocxWFV7JqbZHPbg4lD1tHhPW
         rT/QOPXkw1gYawdUmc6Wr4/0RIt2ehUtYJB1wNoB9JZC3Y8chrU
Date:   Fri, 20 Nov 2020 02:09:24 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/7] t1300: test "set all" mode with value_regex
Message-ID: <20201120020924.GF389879@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.796.git.1605801143.gitgitgadget@gmail.com>
 <2da2131114eb47e70ccaf8fb9c51bf7fb5b173b0.1605801143.git.gitgitgadget@gmail.com>
 <xmqqo8jtvvby.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vKFfOv5t3oGVpiF+"
Content-Disposition: inline
In-Reply-To: <xmqqo8jtvvby.fsf@gitster.c.googlers.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--vKFfOv5t3oGVpiF+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-11-19 at 22:24:33, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
> > +test_expect_success 'set all config with value_regex' '
> > +	q_to_tab >initial <<-\EOF &&
> > +	[abc]
> > +	Qkey =3D one
> > +	EOF
> > +
> > +	cp initial .git/config &&
>=20
> Not a new problem with this patch, but does the above pattern
> introduce potential problems?  I am wondering if overwriting the
> config file with a little piece that has only the stuff the test is
> interested in, while wiping the parts that may be essential for
> repository integrity (e.g. "extensions.objectFormat"), is OK in the
> long run (brian cc'ed for his sha256 work).  There also are
> autodetected crlf settings etc. that are in the .git/config when a
> test repository is created, and we probably would want to keep them
> intact.

I haven't looked at the code, but if you're just using git config in a
test, then overwriting the config file shouldn't be a problem with
SHA-256.  If you're trying to read or write objects or the index, then
that's definitely a problem, and you'll definitely notice exciting
failures if you do that.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--vKFfOv5t3oGVpiF+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHQEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX7clUwAKCRB8DEliiIei
gfr6AQCFR7OGtGbH+OccYEPnXqLiRxy/ZEdtLtXoRIJIZp5RrgD0C0JtXBrjFI0S
OFfunDSKGxdDDwJ0tislrZ8HwoGACg==
=u8mh
-----END PGP SIGNATURE-----

--vKFfOv5t3oGVpiF+--
