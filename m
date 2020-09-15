Return-Path: <SRS0=NngS=CY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0653C43461
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 22:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC2DE20770
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 22:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbgIOWw1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Sep 2020 18:52:27 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60396 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727410AbgIOWwI (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 15 Sep 2020 18:52:08 -0400
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 176E860457;
        Tue, 15 Sep 2020 22:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1600210296;
        bh=hO6eQCu3bL8wpSQvVLSYyMQyiD5Zvqp4wNDO4aWhtos=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=qcPUQQhXCAl8UZSLBioR/KcLFRAtmar9Fx64ZnGkqSATUyh0q6qTfp3gfcGXKGv6r
         xxLSA6dtqeuahkuzn2uG1eUbSxCRK9LoYvY5EzzDeXzTgqsEzgZix+RPqLca1k6Mkc
         u3jlEYpApQWlprxEG4doMQpDj3GGFpdfH665nNMMwAHYGG+mOLGrAA/pW7CIzZb/iw
         G6+sFlisxLDyB6kewsaWD49j2AroB+JTS5KIuFAagiHqQRtWDoJ+HAjCQcOWf3TvKz
         FKkslkHJ0+JCiUGVoAHw+nPTWQ97jL2k70nW20zVMg8HStr9WQ4N8A9gQXMqxJh3+i
         5KfkycReh9w86b95Z+QuhfHJNI7NZbqxZe4NI+acohfzeB6zGHooyZvw2zwUFo8/B8
         g4WQ3+aG2zOyDHoeaPvV0sIj04h8Q1FNJ0z8ucF6+T2cy5dTNW8eBbtVJfNS/m8HE9
         JrY5jHPyT7IgKc8221BdcNdzLUn8R08v5Ek6cMvzvfrwOt7Y+Aa
Date:   Tue, 15 Sep 2020 22:51:31 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Matheus Tavares <matheus.bernardino@usp.br>
Subject: Re: [PATCH v2] builtin/clone: avoid failure with GIT_DEFAULT_HASH
Message-ID: <20200915225131.GG2866143@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>,
        Matheus Tavares <matheus.bernardino@usp.br>
References: <20200911233815.2808426-1-sandals@crustytoothpaste.net>
 <20200915015845.4149976-1-sandals@crustytoothpaste.net>
 <xmqq8sdb1x0t.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cyV/sMl4KAhiehtf"
Content-Disposition: inline
In-Reply-To: <xmqq8sdb1x0t.fsf@gitster.c.googlers.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--cyV/sMl4KAhiehtf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-09-15 at 04:31:14, Junio C Hamano wrote:
> > Changes since v1:
> > * Use git_config_set_gently to make things work with SHA-1 repos as well
> >   as SHA-256 repos.
>=20
> Hmph, the reason why v1's bug weren't caught was because it was only
> tested with GIT_TEST_DEFAULT_HASH=3Dsha256, right?  I am wondering if
> adding two new tests that run the same end-user scenario except
> for the choice of hash algorithms would be a good way to ensure this
> will stay fixed.  Am I mistaken?

Sure, I can do that.  I'll try to get a v3 out soon.
--=20
brian m. carlson: Houston, Texas, US

--cyV/sMl4KAhiehtf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX2FFcwAKCRB8DEliiIei
gd/UAP96cdAF54aGFQV3YDBODlrrlE+9wMg8Y+scrE58FkLZDgD/VLDhhwLtwmri
aGYZknTa/FDqR2aEhNOMnDzSFq8lQwA=
=f8K7
-----END PGP SIGNATURE-----

--cyV/sMl4KAhiehtf--
