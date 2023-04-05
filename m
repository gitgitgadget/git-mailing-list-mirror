Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F46CC76188
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 14:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238457AbjDEOnL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 10:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238383AbjDEOnE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 10:43:04 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB282D77
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 07:43:03 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2A70A1F1426;
        Wed,  5 Apr 2023 10:43:00 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=4RGPJt+1mX7yZnDeJcr14cu5WEAvGMlN3tnDfcO
        PPZ4=; b=mQOXI92KfCrTp0dZxz8FO+N98iYv1b8PhlzRTtE9RnNpEWSOAdH4she
        03qi5j0k3o1FijZXpv13H1tC7iVYwIO/AGkf/z17UgkPa/zhdqYmmIcD3NvrTm42
        /EU8MboAMsqn3k3BfLnJS8IN3AZTKes01LRqHIDyjGadABdqcpVA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 222211F1425;
        Wed,  5 Apr 2023 10:43:00 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [108.15.224.39])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CFD6D1F1424;
        Wed,  5 Apr 2023 10:42:55 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Date:   Wed, 5 Apr 2023 10:42:52 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] global: resolve Perl executable via PATH
Message-ID: <ZC2I7CfVzY6Tl7Pk@pobox.com>
References: <d9cfad7caf9ff5bf88eb06cf7bb3be5e70e6d96f.1680689378.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PkwihCrBN/69aKoW"
Content-Disposition: inline
In-Reply-To: <d9cfad7caf9ff5bf88eb06cf7bb3be5e70e6d96f.1680689378.git.ps@pks.im>
X-Pobox-Relay-ID: 2704BAFA-D3C0-11ED-A687-C2DA088D43B2-09356542!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--PkwihCrBN/69aKoW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Patrick Steinhardt wrote:
> The majority of Perl scripts we carry in Git have a `#!/usr/bin/perl`
> shebang. This is not a portable location for the Perl interpreter and
> may thus break on some systems that have the interpreter installed in a
> different location. One such example is NixOS, where the only executable
> installed in `/usr/bin` is env(1).

Is there a reason to not set PERL_PATH, which is the
documented method to handle this?  From the Makefike:

# Define PERL_PATH to the path of your Perl binary (usually /usr/bin/perl).

--=20
Todd

--PkwihCrBN/69aKoW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIGcjzoxKnTmf/7jnQyWTi76vDOMFAmQtiOEACgkQQyWTi76v
DOOyywgAupegJ9m/JkmawLBMtsavgRtODXib6FqGQChmW1VQExl3yRA0Uj/5x9DM
qmUnDT4WgyEhlBMKInBp4FCtKGKXL80i4SNGTSFw192vw8f5FlHk6k4I4n4np+9B
ESwg1HYvUV/9LlS69Q25SdCpvSApwqhSHIl46Rj7EpNsww/1wBD7Doy+jS4NyVyZ
nJqNzmwLdZFAhsOE2F37Wlc5Jur5gbXvImX1Uj+jMXOcFBnArVdyywQA7oP1b+c8
0vq1fqTt4BKcGhtjBOLTZQR+TPkEK5LiqH41D/OpEcMsuudPuMorTa7yaWQE/SJm
gyoj3rCtrb9BJIPXjBbsPZDXNKUS/A==
=9g9g
-----END PGP SIGNATURE-----

--PkwihCrBN/69aKoW--
