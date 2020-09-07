Return-Path: <SRS0=kCdt=CQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFC3C433E2
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 20:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D60DC217A0
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 20:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgIGUwv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Sep 2020 16:52:51 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55330 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726735AbgIGUwu (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 7 Sep 2020 16:52:50 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 98E0D60489;
        Mon,  7 Sep 2020 20:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1599511968;
        bh=MWtOgnzo6q+5XSk/CX/cQZ6AfXKtFyBRRzjuc5X1vao=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Lr6XRjpOQQI8AKMZJs9yKNUEEDGgjH0vFTSqHEEZ0p468C59Jv16MDHGhXjXJPzWS
         4aV8P3FuMb8BQokrrC0BUWkcSfgNB61IhLV9H8JTbGBOqdChaum/i82UO9R1wsc1zB
         K2CSwMJ6qIOFYcAF+wmU2/YgkCF+Wwqc2HEhl2/MN+AmGt8pEPl/v4lSsQ4qyiR195
         4cRE1hdbxHX4lwz8nUW7XIFaR2mgWa+OhfwrBP3TYAXDnjflc0xTd+eOlPqtJaVKVP
         EvVu+YMdeYQBbchnCtNYCNt+TxXINJjsASe/berPHfWI6/fqCowZFDLl0VOzW18Tp1
         VqDmMr/RAP1uWczaqsqmHSV6ehDlqek4PH5uJ0IFEFG3DPzwcqc+cm5BkPqyDf4Vwc
         +EBCY1eokcSBkrdkPIlC7EA+O/16wU1FYFEcBREkoQUXMTGNXJpSunR1BjjiY2AuHX
         5jaZkbNCL2HapDXmV5Tc1mjafhmhjMZLUSi2hKlS1Jp4JycU4i+
Date:   Mon, 7 Sep 2020 20:52:42 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Proposal: server-advertised config options
Message-ID: <20200907205242.GF241078@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Drew DeVault <sir@cmpwn.com>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
References: <xmqqimcp1kvf.fsf@gitster.c.googlers.com>
 <C5HDRLX7ZPR5.1TFS72T7PBXSJ@homura>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w3uUfsyyY1Pqa/ej"
Content-Disposition: inline
In-Reply-To: <C5HDRLX7ZPR5.1TFS72T7PBXSJ@homura>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--w3uUfsyyY1Pqa/ej
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-09-07 at 19:23:15, Drew DeVault wrote:
> On Mon Sep 7, 2020 at 2:51 PM EDT, Junio C Hamano wrote:
> > I do not want to see this as a "server" thing. All the examples are
> > "per project preference" and I do agree it would be nice to have a
> > standardised way for projects to communicate their preference to
> > their participants. Regardless of the hosting site I clone and
> > fetch my project from, I'd want to see it communicated consistently
> > to them.
>=20
> The server I have in mind (git.sr.ht) is a little bit different in that
> most of those examples I gave would be configured automatically on the
> server side. My server software knows where your mailing list is, for
> example. My goal is to try and make this as hands-off and "it just
> works" as possible.

The Git security model doesn't permit untrusted config options, so I
think it's risky to add support for config options from the server
side.  We need to consider not only advanced users who are going to be
able to make a good decision here, but novice users who are struggling
to understand how Git works and are prone to social engineering.  Just
because your server is not malicious does not mean that others aren't.

In addition, if I'm cloning a repository just to build it, I don't want
to be prompted to set those configuration options at all.  My experience
in Git hosting is that clones and fetches far, far outnumber pushes, so
adding a prompting feature adds a bunch of impediment with little gain
for the vast majority of users.

> > All of the above leads to a design to have a common convention
> > widely shared among projects to express project preferences over
> > different kind of tools, among which Git is one of them, and store
> > it in a known location in the projects' trees. Most importantly,
> > there must not be any Git protocol extension for doing this kind of
> > thing.
>=20
> Storing a file in your project tree to handle this configuration would
> eliminate the "hands off" feature I was aiming for. We also have a
> policy which forbids our software from making any automated changes to
> the contents of your git repository - we just don't consider it
> appropriate in the domain of our server software's responsibilities.

That doesn't mean you can't provide a downloadable shell script that
people could check into their repositories to configure this for the
user.  That's the typical way that projects that use standardized hooks
work, for example, and it lets the user decide whether they want to
configure these things (by running the script) or not (by not running
it).  Users who are not interested in becoming contributors need not
ever be bothered with it at all.

It doesn't automatically "just work", but it also lets projects decide
for themselves what their settings should be.  Just because a site
offers, say, mailing lists, doesn't mean that folks will want to use
those mailing lists.  For example, the Go language repository is hosted
on GitHub, but uses Gerrit for code review, not GitHub pull requests.

> Also, the conventions for tooling-related files in-tree like this is
> currently very disorganized within the ecosystem. Between .editorconfig,
> .gitattributes, .github/funding.yml, a dozen CI systems, and who knows
> what else, there's no common consensus on where to put files like this
> or what they should look like. I think that securing consensus for this
> would involve reaching out to these projects, and the scope of that
> effort and the necessary follow-up developments and compatibility
> planning on behalf of these projects would be...  astonishingly large.

You can try to standardize all repository dotfiles, or you can just
provide a configuration file and documentation and let people adopt it
as you go, which is how most of these work.  If your design is
desirable, people will adopt it and spread it across projects.
--=20
brian m. carlson: Houston, Texas, US

--w3uUfsyyY1Pqa/ej
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX1admgAKCRB8DEliiIei
gRBPAQDtYh78XP/9nSxyXwpje+GJLnJoz72C1HcHf/BOzxcwqgD/dc14FP5ofc2V
CVQjwqNd9K+NMuVDDLyWz3ex+t/kkgs=
=bOrw
-----END PGP SIGNATURE-----

--w3uUfsyyY1Pqa/ej--
