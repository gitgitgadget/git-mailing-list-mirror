Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D18CC4727F
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 22:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A6052087D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 22:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbgIYW2h (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 18:28:37 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38324 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727258AbgIYW2h (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 25 Sep 2020 18:28:37 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BD43C60457;
        Fri, 25 Sep 2020 22:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1601072886;
        bh=9Q956smj4mdKWXMvUn/hA8xqq/nvu5WemhHGvNrS3Q0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Z1yOBcd7LjwLv/jV+zurGChje5qfK4wtobdlZIk0rx2Oj+6jPq4A+AdBbsvOKysh/
         wV0vpdEjkR1SAL2uUEM34Q9Cbd2LbNQIVDPvpA6LhL8XNpJeiIIlI99nVU2WXdvp2q
         jxcqR7YUIupVN6XPIpvn58dEoAZUl0PqHInRDVmuOtYxxHBxme+7AhnNHxKpdHSzFR
         enI0zWTbq+cMYr0898ZJqgFTUu8cG6tl83itqNMQI0XnxxZKUMNm4OJiRE5K2LoUWR
         x1YC4Yglj/XvwTrs0ImFDFnn6zcuHeyG/FQialzb9a8/Dh5cXMo6RUNcc5ZJG0D0ht
         m0WSMrHIio+ux+QIL0KbQ4zSFfjPdwL2dMAgtOEQ7OSDaLB78FCrJGH03TBFqQmVrL
         zzIagZb64rX3RqWit3KqJ4JUvG39WQEyYgIg2werV76CoQfzDr7suHT1IpkC55ArQr
         9dO+V4Lf0HdTspayfKjqZkdL9pw5nBKmZ/3bwNPRARgCCvuY2vs
Date:   Fri, 25 Sep 2020 22:28:01 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Frank Illenseer <illenseer@altair.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git Alias not working in worktree
Message-ID: <20200925222801.GC1392312@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Frank Illenseer <illenseer@altair.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <DM5PR03MB2826A616AC30710E169B7237B5360@DM5PR03MB2826.namprd03.prod.outlook.com>
 <DM5PR03MB2826C04CC5AAF3B61BDDAFE2B5360@DM5PR03MB2826.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RIYY1s2vRbPFwWeW"
Content-Disposition: inline
In-Reply-To: <DM5PR03MB2826C04CC5AAF3B61BDDAFE2B5360@DM5PR03MB2826.namprd03.prod.outlook.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--RIYY1s2vRbPFwWeW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-09-25 at 16:44:25, Frank Illenseer wrote:
> Dear Git User-group,
>=20
> I am having a setup where I use worktrees and I was now experimenting wit=
h adding git aliases to work more efficiently with the commands.
> However I found that obviously it does not seem to work like I would like=
 to have it:
>=20
> My intention is to have a ".gitconfig" file as part of the repo so that a=
ll developers can easily get to the same configuration that was setup and a=
lso to have the config tracked as part of the repo.
> We are using Git for Windows v2.28 and also git 2.28 on Linux.

I'm not sure about what's causing the issue that you're having, but let
me dissuade you from trying to store configuration in the repository.
Git's security model doesn't permit untrusted configuration because
configuration can be used to specify programs and execute arbitrary
code.  If you specify a config file that's in the repository and someone
checks out a branch with a malicious config file, they can execute
arbitrary code on that system.

If you want to provide settings, it would be better to provide a shell
script that developers could _optionally_ run (after first verifying)
that sets certain config options.  Because that would be run only on
demand by the user and can be inspected before running, it would be a
lot more secure.  In addition, if you're setting aliases, it's possible
that the user may already have an alias for that option that they are
used to and expect to work a certain way (e.g., my "git co" is
recursive) and may not want your alias.

I realize you may be working in a corporate environment where users are
somewhat more trusted, but take note that you probably don't let
developers execute arbitrary code on each other's systems and social
engineering attacks ("Hey, can you check out this branch and see why the
code isn't working?") are easy.  There's a big difference between "I
ran this script" and "I checked out this branch".

Hopefully someone else can provide an answer to why your alias isn't
working.  I have some guesses, but no definitive answers at the moment.
I'll try to play around with some things and figure it out over the next
couple of days if nobody gets to it before me.
--=20
brian m. carlson: Houston, Texas, US

--RIYY1s2vRbPFwWeW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX25u8AAKCRB8DEliiIei
gdXQAQDdFZAxuFn8gqP9qKJUw/HKrxvfvC9mwILzgkZb5LbuwAEA1iBzynUYQps2
s2nYwehe0bnhgb3G8aJdIiY7C8+qoQM=
=8C8w
-----END PGP SIGNATURE-----

--RIYY1s2vRbPFwWeW--
