Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A13C77B7A
	for <git@archiver.kernel.org>; Wed, 17 May 2023 01:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjEQBUZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 21:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjEQBUX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 21:20:23 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B89B269D
        for <git@vger.kernel.org>; Tue, 16 May 2023 18:20:22 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 40D485AF40;
        Wed, 17 May 2023 01:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1684286421;
        bh=XIZDEQf6NifjGxZ+fniy0Dhvpdh7FodcVLUfm2wxYc0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=LR3FHfb13YgHfaBAj2rC3+XCfB+X5vVYrtu7nxRLTvyucDNgsUND8QorsIDXODrdF
         8q62kRVvIswxod894zYxImbiJ28V+1nzuk7143dFrsgLC1HsfHgiJjZJsYcilR4Ti7
         lFQzk2OwsZnXbxvK95KSpOVQ/ZQgnT/FUhbU4W1N3NfxpNof/xIPiiN12I6BEoc+cH
         psHVZAUujdC+z2b5AuoFMFj498nCQDXQeNZMRDeRgAmNwadw4wOAY45K/iSxcihjAq
         Idym0fzgWk3LB3+9VdpU68Rjk918xridCzFclUk6KOY3uNUR/immOKSdCfTJ9/meZT
         o5HZoj1UphsaeeBBHnlMdyM5d+ZHCcP+jYEFt0/9sLL04pHDmnv+8jiIJyaz5h3G6I
         Se71/zn4iSUTP9+BrSXJih4qfDPD4QY3w/dY5OKmrmJQACdCTDB4PetYqZKlPaGjhC
         P6/q1sJU/nDC80J7ruTsyo7odsG6SCIX2Nw30B6WOZ9koDzg8YV
Date:   Wed, 17 May 2023 01:20:19 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "Tim Walter (Visual Concepts)" <twalter@vcentertainment.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git hangs with --separate-git-dir
Message-ID: <ZGQr03G/9swNcHt0@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Tim Walter (Visual Concepts)" <twalter@vcentertainment.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <BY5PR14MB36544D63ECEAB9954C14407FA5799@BY5PR14MB3654.namprd14.prod.outlook.com>
 <ZGP2AzYJSLpI4kGN@tapette.crustytoothpaste.net>
 <BY5PR14MB36541924E1E6E5E912AFE0C2A5799@BY5PR14MB3654.namprd14.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tQvioxSlGKfzoxP/"
Content-Disposition: inline
In-Reply-To: <BY5PR14MB36541924E1E6E5E912AFE0C2A5799@BY5PR14MB3654.namprd14.prod.outlook.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--tQvioxSlGKfzoxP/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-05-16 at 21:55:35, Tim Walter (Visual Concepts) wrote:
> ---TAW--- The real issue is that it does a "very bad hang and mess up of =
the OS" if the repo is separate from the working directory.
> ---TAW--- In my case it happens to be a separate drive, not sure if that =
is relevant, I didn't try a separate folder on the same drive.

Git is an unprivileged process that doesn't install any sort of kernel
drivers.  It should not have any sort of capability of hanging the OS.
If the OS is hanging, that's an OS or a driver bug.

> ---TAW--- It's not possible to uninstall the anti-virus SW, company polic=
y and I don't have permissions for that level of configuration.
> ---TAW--- Our current solution (perforce) manages the same source files a=
nd does not have any interaction with the anti-virus
> ---TAW---We're careful to tell the anti-virus to ignore certain folders, =
and not to do on-demand scanning on those drives anyway.
> ---TAW--- That's one of the reasons we have separate drives (c: is protec=
ted a lot more than d: which is just the "work folders" for example.

I can tell you having answered a lot of Git-related questions on
StackOverflow and been on this list a long time, as well as being the
maintainer of Git LFS, that antiviruses often have weird behaviour just
being installed that breaks things randomly, even when fully
deactivated.  For example, some antiviruses inject code into every
process, and that breaks lots of things by itself.  Git is an
open source project and can't anticipate the behaviour of every
antivirus, so our semi-official policy has been that you should only use
the one shipped with the OS, if any.

It may be that Perforce happens to work here because it works
differently under the hood, but I simply can't say.

You could try running the command under the Windows Subsystem for Linux,
which often avoids antiviruses, and see if that fixes the problem for
you.  It may work better and be faster as well.  I like Debian for this
purpose, but Ubuntu is also very popular.

It may be that it's not antivirus-related at all, but the reason I asked
you to completely remove it and restart is to eliminate that problem,
since it's very frequently the cause, especially for random hangs.  I
appreciate that that's difficult in a corporate environment, but I hope
you understand where we're coming from as well.

> ---TAW--- I expected that other people would have had this issue already,=
 but it sounds like you've never heard of it, so maybe something odd
> ---TAW--- about our particular configuration? But I don't know what, exce=
pt that:
> ---TAW---  : it's a large project
> ---TAW---  :  it contains binary as well as text files
> ---TAW---  : I am trying to use 2 different local drives
> ---TAW---  : I am using windows, sorry can't help that, we are forced to =
develop using windows tools.

I haven't seen this problem, since I only use Windows extremely
occasionally for testing a few things.  I'm unable to reproduce any sort
of problem using a separate Git dir on a separate filesystem on Linux.

You can try reporting it to the Git for Windows issue tracker at
https://github.com/git-for-windows/git/issues, and maybe they can help
you, but I'm pretty sure this is not a bug in Git itself.  Git for
Windows ships a lot of code besides Git itself, and it's possible that
something there is related, though, and they'll have the knowledge to
help out more.  You can try searching the issue tracker to see if
somebody has reported a similar problem before.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--tQvioxSlGKfzoxP/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZGQr0wAKCRB8DEliiIei
gUUQAP4tvwENT/wgP0Y0HHkt1bDRHbYUAGShFb2veUnP/kLD7gD+MlM4huLdKlGz
KN0SrJ+EEYnX7BiCOcGpxED4Xjpyyw4=
=K5gO
-----END PGP SIGNATURE-----

--tQvioxSlGKfzoxP/--
