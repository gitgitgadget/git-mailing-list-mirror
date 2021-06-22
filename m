Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B12C4743C
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 00:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8A9761245
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 00:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbhFVAm5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 20:42:57 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54308 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230021AbhFVAm4 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 21 Jun 2021 20:42:56 -0400
Received: from camp.crustytoothpaste.net (unknown [69.17.174.146])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1051F60424;
        Tue, 22 Jun 2021 00:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1624322441;
        bh=XX3wHf4eHVGvUvgrjy5d+jtg3h4/JB+vZohMB5osKuE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=wCW6VHM9YsMrHCgKKMsNALtm4csgVBMPnxziWTbcTM1EULXUnhvXH2AIzUoqIaqsl
         fN7hS7oX2TFxblDsJjWsoHkxKE4hjo3l+Y5JhsoYlWp/6fLLx1u5wlaL5VzycTf+Og
         SeknlhlFJ9Ys1kCkH7L5sWtaBA0+b7aCcSJy0IEuTWvIt6+bxLXIb8D9akd3SsySBx
         F2mQCr3oPFMmFbMchYxP98iFxTPar+32mrCjVBJmVpGWQHRfErOUfd9zD6LtYbuVnQ
         eogIzaaU4K6cvYnUKjuhdm+7qYyGZrG0Z3DfUOv8+G0o7LId7aKRx+JaqZZ24y4SYS
         mrIJRstP+vTRTvTFjAjbH2bz1j1ar2U1Kez7cM/ra2KNzR4w0L1ZLPh1vL7UlaqAd/
         TW/+vCJr6UgZOFYqq+JIClujijrK9wBCsHa4TNPohbLy8fzuD3dy8ohOaa1CxWevOy
         yUTZaflQCNQLWwYK4pP0tQgGWtIQ/JBitXGBF66UY2OigUw5vWI
Date:   Tue, 22 Jun 2021 00:40:37 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [RFC PATCH 0/2] MVP implementation of remote-suggested hooks
Message-ID: <YNExhalSLWvmky55@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Emily Shaffer <emilyshaffer@google.com>
References: <cover.1623881977.git.jonathantanmy@google.com>
 <87fsxc47le.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Wo7QKuCy9WYgE5Aa"
Content-Disposition: inline
In-Reply-To: <87fsxc47le.fsf@evledraar.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Wo7QKuCy9WYgE5Aa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-06-20 at 19:51:04, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>=20
> On Wed, Jun 16 2021, Jonathan Tan wrote:
>=20
> > This but does not use any features from es/config-based-hooks but is
> > implemented on that branch anyway because firstly, I need an existing
> > command to attach the "autoupdate" subcommand (and "git hook" works),
> > and secondly, when we test this at $DAYJOB, we will be testing it
> > together with the aforementioned branch.
> >
> > I have had to make several design choices (which I will discuss later),
> > but now with this implementation, the following workflow is possible:
> >
> >  1. The remote repo administrator creates a new branch
> >     "refs/heads/suggested-hooks" pointing to a commit that has all the
> >     hooks that the administrator wants to suggest. The hooks are
> >     directly referenced by the commit tree (i.e. they are in the "/"
> >     directory).
> >
> >  2. When a user clones, Git notices that
> >     "refs/remotes/origin/suggested-hooks" is present and prints out a
> >     message about a command that can be run.
> >
> >  3. If the user runs that command, Git will install the hooks pointed to
> >     by that ref, and set hook.autoupdate to true. This config variable
> >     is checked whenever "git fetch" is run: whenever it notices that
> >     "refs/remotes/origin/suggested-hooks" changes, it will reinstall the
> >     hooks.
> >
> >  4. To turn off autoupdate, set hook.autoupdate to false. Existing hooks
> >     will remain.
> >
> > Design choices:
> >
> >  1. Where should the suggested hooks be in the remote repo? A branch,
> >     a non-branch ref, a config? I think that a branch is best - it is
> >     relatively well-understood and any hooks there can be
> >     version-controlled (and its history is independent of the other
> >     branches).
>=20
> First, unlike brian I don't (I hope I'm fairly summarizing his view
> here) disagree mostly or entirely with the existence of such a feature
> at all. I mean, I get the viewpoint that git shouldn't bless what
> amounts to an active RCE from the remote.

It's accurate that I'm generally opposed to such a feature.  I feel that
suggesting people install hooks is likely to lead to social engineering
attacks, and it's also likely to lead to bad practices such as the
expectation that all developers will install hooks or the use of hooks
instead of CI or other effective controls.

If we do add this feature (which, as I said, I'm opposed to) and we
decide to store it in a ref, that ref should not be a normal branch by
default (it should be a special one-level ref, like refs/stash or such),
and the ref name should be configurable.  Not all developers use English
as their working language and we should respect that.

In addition, there should be an advice.* option that allows people to
turn this off once and for all, and it should be clearly documented.
Ideally it should be off by default.

> I think I get why you want to do it that way, I just don't get why, as
> mostly noted in those earlier rounds why it wouldn't be a better
> approach / more straightforward / more git-y to:
>=20
> 1. Work on getting hooks driven by config <this is happening with
>    Emily's series / my split-out "base" topic>
> 2. Have a facility to read an in-repo '.gitconfig'; have lots of safety
>    valves etc. around this, I suggested starting with a whitelist of the
>    N least dangerous config options, e.g. some diff viewing options, or
>    a suggested sendemail.to or whatever.

This also makes me deeply nervous for much of the same reasons.  There
are situations where e.g. ignoring whitespace can lead to security
problems in code review (think Python), and in general it's hard to
reason about all the ways people can do malicious things.  Typically
adding untrusted config ends poorly (think of all the modeline
vulnerabilities in Vim).

I'd definitely want support for this to be off with no prompting by
default.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--Wo7QKuCy9WYgE5Aa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYNExhAAKCRB8DEliiIei
gWbcAQC6g/QORvXfqtwibqPL5D7kGPBDOM7mfqjn9zZZ0WW9XAEAiT/KvXphYgm9
Ndwvgv+sMsjtmu9uCJOjGThS2TtLbgI=
=QJJB
-----END PGP SIGNATURE-----

--Wo7QKuCy9WYgE5Aa--
